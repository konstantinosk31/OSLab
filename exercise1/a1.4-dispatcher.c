#include "config.h"

void handle_dispatcher_input(int argc, char **argv);
void sighandler(int signum);
void add(int workers);
void remove(int workers);
void info();
void progress();


int P;
int fdr;
int pipe_from_front, pipe_to_front;
char c2c;
int front_pid;

/*
argc = 4;
argv = {
    0: "a1.4-dispatcher.c",
    1: int fdr,
    2: int pipe_from_front,
    3: int pipe_to_front,
    4: char c2c
};
*/
int main(int argc, char **argv) {
    handle_dispatcher_input(argc, argv);
    fdr = atoi(argv[1]);
    pipe_from_front = atoi(argv[2]);
    pipe_to_front = atoi(argv[3]);
    c2c = argv[3][0];
    
    front_pid = getppid();

    struct sigaction sa;
    sa.sa_handler = sighandler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGINT, &sa, NULL) == -1) {
        print(STD_ERR, "Error receiving signal from frontend\n.");
    }

    create_workers();
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
    if(signum == SIGUSR1){
        int workers;
        read(pipe_from_front, &workers, sizeof(workers));
        if(workers > 0 && workers <= MAX_WORKERS) add(workers);
        else if(workers < 0) remove(workers);
        else if(workers == 0) info();
        else if(workers == MAX_WORKERS+1) progress();
        else{
            print(STD_OUT, "Dispatcher received unrecognised instruction from frontend.\n");
            exit(1);
        }
    }
}

void add(int workers){
    if(P + workers > MAX_WORKERS) {
        int num = 0;
        write(pipe_to_front, &num, sizeof(num));
        if(kill(front_pid, SIGUSR1) < 0){
            print(STD_ERR, "Error sending \"Cannot exceed max workers\" signal to frontend.\n");
            exit(1);
        }
        return;
    }
    P += workers;
}

void remove(int workers){
    if(P - workers < 0) {
        int num = 1;
        write(pipe_to_front, &num, sizeof(num));
        if(kill(front_pid, SIGUSR1) < 0){
            print(STD_ERR, "Error sending \"Cannot have negative workers\" signal to frontend.\n");
            exit(1);
        }
        return;
    }
    P += workers;
}

void info(){
    printf("Currently, there are %d workers at your service!\n", P);
    show_pstree(getpid());
}

void progress(){

}