#include "config.h"

struct worker_node {
    pid_t pid;
    int pipe_from_worker, pipe_to_worker;
    int start, bytes_to_read;
    char removed; //is actually bool

    struct worker_node *next, *prev;
};

typedef struct worker_node worker;

struct workpool_node {
    off_t start;
    int size;
    struct workpool_node *next;
};

typedef struct workpool_node work;

void handle_dispatcher_input(int argc, char **argv);
void sighandler(int signum);
void adding_workers(int workers);
void removing_workers(int workers);
void info();
void progress();
void create_worker(char *file_to_read, char c2c, worker* w);

int P = 0;
int fdr;
int pipe_from_front, pipe_to_front;
char c2c;
pid_t front_pid;
off_t size;
worker *worker_list;
worker *worker_tail;
work *workpool;
work *workpool_tail;
int count = 0;

void segment_workpool(worker *w, int bytes_read){
    work *p = (work *) malloc(sizeof(work));
    
    p -> size = w -> bytes_to_read - bytes_read;
    p -> start = w -> start + bytes_read;
    p -> next = NULL;
    
    workpool_tail->next = p;
    workpool_tail = p;
}

void remove_from_worklist(worker *w){
    if(w == NULL) print(STD_ERR, "Tried to delete NULL worker!\n");
    if(w->prev != NULL && w->next != NULL) w->prev->next = w->next;
    else if(w->prev != NULL && w->next == NULL) worker_tail = w->prev;
    else if(w->prev == NULL && w->next != NULL) worker_list = w->next;
    else if(w->prev == NULL && w->next == NULL){
        worker_list = NULL;
        worker_tail = NULL;
    }
    if(w->pid > 0) free(w);
    
}

void delete_worker(worker *w, int bytes_read) {
    segment_workpool(w, bytes_read);
    remove_from_worklist(w);
}

/*
argc = 5;
argv = {
    0: "a1.4-dispatcher.c",
    1: char* file_to_read,
    2: int pipe_from_front,
    3: int pipe_to_front,
    4: char c2c
};
*/

int main(int argc, char **argv) {
    handle_dispatcher_input(argc, argv);
    char *file_to_read = (char *) malloc(sizeof(argv[1]));
    strcpy(file_to_read, argv[1]);
    pipe_from_front = atoi(argv[2]);
    pipe_to_front = atoi(argv[3]);
    c2c = argv[4][0];
    
    front_pid = getppid();

    if(signal(SIGUSR1, sighandler) < 0) {
        perror("Could not establish SIGUSR1 handler.\n");
    }

    int fdr;
    if((fdr = open(file_to_read, O_RDONLY)) == -1){
         print(STD_ERR, "Problem opening file to read\n");
         exit(1);
    }
    struct stat st;
	if(fstat(fdr, &st) < 0){
		perror("Stat error\n");
		exit(1);
	}
	size = st.st_size;
    off_t batch_size = max(1, sqrt(size));
    workpool = (work *) malloc(sizeof(work));
    workpool->start = 0;
    workpool->size = size;
    workpool->next = NULL;
    workpool_tail = workpool;
    off_t bytes_left = size;
    count = 0;
    while(bytes_left > 0) {
        for(work *wp = workpool; wp != NULL; wp = wp->next) {
            for(worker *w = worker_list; w != NULL; w = w->next){
                int status;
                if(w->pid != -2){ //the worker was running before
                    waitpid(w->pid, &status, WUNTRACED);
                    int bytes_read, cnt;
                    if(status == 0){ //CHECK status
                        bytes_read = w->bytes_to_read;
                        read(w->pipe_from_worker, &cnt, sizeof(cnt)); 
                        //printf("Worker read %d bytes and found char %d times\n",bytes_read, cnt);
                        bytes_left -= bytes_read;
                        count += cnt;
                    }
                    else { //Worker exited abnormally while potentially having read some bytes
                        read(w->pipe_from_worker, &bytes_read, sizeof(bytes_read));
                        read(w->pipe_from_worker, &cnt, sizeof(cnt));
                        bytes_left -= bytes_read;
                        count += cnt;
                        P--;
                        delete_worker(w, bytes_read);
                        continue;
                    }
                    close(w->pipe_from_worker);
                    close(w->pipe_to_worker);
                }
                if(w->removed == 1){
                    remove_from_worklist(w);
                }
                else{
                    w->start = wp->start; //IN ABNORMAL EXECUTION THIS SHOULD CHANGE
                    w->bytes_to_read = min(wp->size, batch_size);
                    if(bytes_left != 0) {
                        create_worker(file_to_read, c2c, w);
                        //printf("worker %d, bytes_left = %ld\n", w->pid, bytes_left);
                        wp->start += w->bytes_to_read;
                        wp->size -= w->bytes_to_read;
                    }
                    else{
                        break;
                    }
                }
            }
        }
    }
	for(worker *w = worker_list; w != NULL; w = w->next){
		int status;
		if(w->pid != -2) {
        	waitpid(w->pid, &status, WUNTRACED);
		}
		remove_from_worklist(w);
		P--;
	}
    while(1){
        //printf("Still alive!\n");
        sleep(5);
    };
}

void handle_dispatcher_input(int argc, char **argv) {
    if(argc != 5) {
        print(STD_ERR, "The number of arguments is wrong!\n");
        exit(1);
    }

    if(strlen(argv[4]) != 1) {
        print(STD_ERR, "You can search for single characters, not entire strings!\n");
        exit(1);
    }
}

void sighandler(int signum) {
    if(signal(SIGUSR1, sighandler) < 0) {
        perror("Could not establish SIGUSR1 handler.\n");
    }
    if(signum == SIGUSR1){
        int command_id, workers;
        read(pipe_from_front, &command_id, sizeof(command_id));
        switch (command_id){
        case 0:
            read(pipe_from_front, &workers, sizeof(workers));
            adding_workers(workers);
            break;
        case 1:
            read(pipe_from_front, &workers, sizeof(workers));
            removing_workers(workers);
            break;
        case 2:
            info();
            break;
        case 3:
            progress();
            break;
        default:
            print(STD_OUT, "Dispatcher received unrecognised instruction from frontend.\n");
            exit(1);
            break;
        }
    }
}

void adding_workers(int workers) {
    if(P + workers > MAX_WORKERS) {
        int num = 0;
        write(pipe_to_front, &num, sizeof(num));
        if(kill(front_pid, SIGUSR1) < 0){
            print(STD_ERR, "Error sending \"Cannot exceed max workers\" signal to frontend.\n");
            exit(1);
        }
        return;
    }

    else {
        for(int i = 0; i < workers; ++i) {
            worker *w = (worker *) malloc(sizeof(worker));
            if(worker_list == NULL) worker_list = w;
            w -> pid = -2;
            w -> prev = worker_tail;
            w -> next = NULL;
            w -> removed = 0;
            if(worker_tail != NULL) worker_tail -> next = w;
            worker_tail = w;
        }
        P += workers;
    }
}

void removing_workers(int workers){
    if(P - workers < 0) {
        int num = 1;
        write(pipe_to_front, &num, sizeof(num));
        if(kill(front_pid, SIGUSR1) < 0){
            print(STD_ERR, "Error sending \"Cannot have negative workers\" signal to frontend.\n");
            exit(1);
        }
        return;
    }
    else{
        worker * w = worker_tail;
        for(int i = 0; i < workers; ++i) {
            w->removed = 1;
            w = w->prev;
        }
    }
    printf("Reducing P by %d\n", workers);
    P -= workers;
}

void info() {
    printf("Currently, there are %d workers at your service!\n", P);
    show_pstree(getpid());
}

void progress() {
    int total_left = 0;
    for(work *wp = workpool; wp != NULL; wp = wp->next){
        total_left += wp->size;
    }
    int total_read = size - total_left;
    double percentage = (double)total_read/size*100.0;
    printf("Progress: [");
    for(int i = 0; i < 100; i++){
        if(i < percentage) putchar('#');
        else putchar('.');
    }
    printf("] : %lf%% : %d/%ld\n", percentage, total_read, size);
    printf("Found character %d times!!!\n", count);
}

void create_worker(char *file_to_read, char c2c, worker* w) {
    int to_worker[2], from_worker[2];
    pipe(to_worker);
    pipe(from_worker);

    pid_t p = fork();
    if(p < 0) {
        print(STD_ERR, "fork"); 
        exit(1);
    }
    
    else if(p == 0) {
        if(close(to_worker[1]) < 0) {
            print(STD_ERR, "Error closing worker's pipe_from_disp write end.\n");
            exit(1);
        }
        if(close(from_worker[0]) < 0) {
            print(STD_ERR, "Error closing worker's pipe_to_disp read end.\n");
            exit(1);
        }
        fcntl(to_worker[0], F_SETFD, 0);
        fcntl(from_worker[1], F_SETFD, 0);
        fcntl(fdr, F_SETFD, 0);
        char *argv2[] = {"./a1.4-worker\0", "", "", "", "", "", "", NULL};
        for(int i = 1; i < 7; i++) argv2[i] = (char *)malloc(1024);
        itoa(w->start, argv2[1]);
        itoa(w->bytes_to_read, argv2[2]);
        itoa(to_worker[0], argv2[3]);
        itoa(from_worker[1], argv2[4]);
        strcpy(argv2[5], (char[2]){c2c, '\0'});
        strcpy(argv2[6], file_to_read);
		if(execv(argv2[0], argv2) < 0) {
            print(STD_ERR, "Cannot create workers!\n");
            exit(1);
        }
		exit(0);
    }

    close(to_worker[0]);
    close(from_worker[1]);
    
    w -> pipe_from_worker = from_worker[0];
    w -> pipe_to_worker = to_worker[1];
    w -> pid = p;
    return;
}
