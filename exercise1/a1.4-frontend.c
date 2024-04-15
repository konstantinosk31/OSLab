#include "config.h"

void startup(); //show startup welcome message
void handle_frontend_input(int argc, char **argv); //assert that input is of correct format
void parse(char *buff, int *command_id, int *workers); //parse the user instruction
void open_dispatcher(int argc, char **argv, int *disp_pid, int *pipe_to_disp, int *pipe_from_disp); //create dispatcher process
void sighandler(int signum); //signal handler for SIGUSR1 and SIGINT

int disp_pid, pipe_to_disp, pipe_from_disp;

/*
argc = 3;
argv = {
    0: a1.4-frontend,
    1: char* file_to_read,
    2: char c2c
}
*/  

int main(int argc, char **argv) {
    handle_frontend_input(argc, argv);

    startup();

    open_dispatcher(argc, argv, &disp_pid, &pipe_to_disp, &pipe_from_disp);
    
	if(signal(SIGUSR1, sighandler) < 0) {
        perror("Could not establish SIGUSR1 handler.\n");
    }
    while(1){
        char buff[1024];
        if(fgets(buff, sizeof(buff), stdin) == NULL){
            printf("Input terminated.\n");
            break;
        }
        int command_id;
        int workers;
        parse(buff, &command_id, &workers);
        char valid = 1; //is actually bool
        switch (command_id){
        case 0:
            write(pipe_to_disp, &command_id, sizeof(command_id));
            printf("Adding %d workers...\n", workers);
            write(pipe_to_disp, &workers, sizeof(workers));
            break;
        case 1:
            write(pipe_to_disp, &command_id, sizeof(command_id));
            printf("Removing %d workers...\n", workers);
            write(pipe_to_disp, &workers, sizeof(workers));
            break;
        case 2:
            write(pipe_to_disp, &command_id, sizeof(command_id));
            printf("Displaying info...\n");
            break;
        case 3:
            write(pipe_to_disp, &command_id, sizeof(command_id));
            printf("Displaying progress...\n");
            break;
        default:
            valid = 0;
            printf("Please enter valid instruction.\n");
            break;
        }
        if(valid && (kill(disp_pid, SIGUSR1) < 0)) {
            print(STD_ERR, "Error while sending the signal to the dispatcher\n");
        }
    }
}

void handle_frontend_input(int argc, char **argv) {
    if(argc != 3) {
        print(STD_ERR, "The number of arguments is wrong!\n");
        exit(1);
    }

    if(strlen(argv[2]) != 1) {
        print(STD_ERR, "You can search for single characters, not entire strings!\n");
        exit(1);
    }
}

void startup() {
    char buff[1024];
    snprintf(buff, sizeof(buff),
    "      _                                           _   \n"
    "  ___| |__   __ _ _ __       ___ ___  _   _ _ __ | |_ \n"
    " / __| '_ \\ / _` | '__|____ / __/ _ \\| | | | '_ \\| __|\n"
    "| (__| | | | (_| | | |_____| (_| (_) | |_| | | | | |_ \n"
    " \\___|_| |_|\\__,_|_|        \\___\\___/ \\__,_|_| |_|\\__|\n \n\n"
    "We are going to count the number of occurrences of your favorite character for you!\n"
    "Here are your options!\n\n"
    "To add workers in your service just type: \"Add: <number of workers to add>\"\n\n"
    "To remove workers from your service just type: \"Remove: <number of workers to remove>\"\n\n"
    "If you want to know more details about your workers just type: \"Info\"\n\n"
    "To see the progress of the execution of the program just type: \"Progress\"\n\n");
    print(STD_OUT, buff);
}

void parse(char *buff, int *command_id, int *workers) {
    char *token, copy[1024];
    strcpy(copy, buff);
    token = strtok(copy, " ");
    if(strcmp(token, "Add:") == 0) {
        *command_id = 0;
        token = strtok(NULL, " ");
        *workers = atoi(token);
        return;
    }

    else if(strcmp(token, "Remove:") == 0) {
        *command_id = 1;
        token = strtok(NULL, " ");
        *workers = atoi(token);
        return;
    }

    else if(strcmp(token, "Info\n") == 0) {
        *command_id = 2;
        return;
    }

    else if(strcmp(token, "Progress\n") == 0) {
        *command_id = 3;
        return;
    }

    else {
        *command_id = -1;
        return;
    }
}

void open_dispatcher(int argc, char **argv, int *disp_pid, int *pipe_to_disp, int *pipe_from_disp){
    int to_disp[2], from_disp[2];
    pipe(to_disp);
    pipe(from_disp);

    pid_t p = fork();
	if(p < 0){
		print(STD_ERR, "fork");
		exit(1);
	}

	else if(p == 0){
        if(close(to_disp[1]) == -1){
            print(STD_ERR, "Error closing dispatcher's pipe_from_front write end.\n");
            exit(1);
        }
        if(close(from_disp[0]) == -1){
            print(STD_ERR, "Error closing dispatcher's pipe_to_front read end.\n");
            exit(1);
        }
        fcntl(to_disp[0], F_SETFD, 0);
        fcntl(from_disp[1], F_SETFD, 0);

		char *argv2[] = {"./a1.4-dispatcher\0", "", "", "", "", NULL};
        for(int i = 1; i < 5; i++) argv2[i] = (char *)malloc(1024);
        strcpy(argv2[1], argv[1]);
        itoa(to_disp[0], argv2[2]);
        itoa(from_disp[1], argv2[3]);
        strcpy(argv2[4], argv[2]);
		if(execv(argv2[0], argv2) < 0) {
            print(STD_ERR, "Cannot open the dispatcher!\n");
        }
		exit(0);
	}

    close(to_disp[0]);
    close(from_disp[1]);

    *disp_pid = p;
    *pipe_to_disp = to_disp[1];
    *pipe_from_disp = from_disp[0];
}

void sighandler(int signum) {
    if(signal(SIGUSR1, sighandler) < 0) {
        perror("Could not establish SIGUSR1 handler.\n");
    }
    if(signum == SIGUSR1){
        int pipe_value;
        read(pipe_from_disp, &pipe_value, sizeof(pipe_value));
        switch(pipe_value) {
        case 0:
            printf("You cannot exceed the maximum number of workers supported by the system (%d)\n", MAX_WORKERS);    
            break;

        case 1:
            printf("You cannot remove more workers than you currently use\n");
            break;

        case 2:
            printf("ok");
            break;

        case 3:
            printf("ok");
            break;

        default:
            print(STD_ERR, "Frontend received unrecognised signal from dispatcher.\n");
            exit(1);
       }
    }

    else if(signum == SIGINT) {
        print(STD_ERR, "Char-count was interrupted");
        exit(1);
    }
}
