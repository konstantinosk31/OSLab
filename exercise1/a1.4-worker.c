#include "config.h"

void handle_worker_input(int argc, char **argv);
void sighandler(int signum);

int pipe_from_disp, pipe_to_disp;

/*
argc = 6;
argv =
{   0: "a1.4worker",
    1: int fdr,
    2: off_t start,
    3: size_t bytes_to_read,
    4: int pipe_from_disp,
    5: int pipe_to_disp,
    6: char c2c
};
*/

int main(int argc, char **argv) {
    handle_worker_input(argc, argv);
    int fdr = atoi(argv[1]);
    off_t start = (off_t) atoi(argv[2]); //!Check for conversion bugs
    size_t bytes_to_read = (size_t) atoi(argv[3]);
    int pipe_from_disp = atoi(argv[4]);
    int pipe_to_disp = atoi(argv[5]);
    char c2c = argv[6][0];

    /*struct sigaction sa;
    sa.sa_handler = sighandler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = SA_RESTART;
    if (sigaction(SIGINT, &sa, NULL) == -1) {
        print(STD_ERR, "Error receiving signal from dispatcher\n.");
    }*/

    /*if(signal(SIGUSR1, sighandler) < 0) {
        perror("Could not establish SIGUSR1 handler.\n");
    }*/

    ssize_t rcnt = 0;
    int count = 0;
    char buff[1024];
    while(bytes_to_read) {
        //start += rcnt;
        //lseek(fdr, start, SEEK_SET);
		rcnt = read(fdr, buff, min(bytes_to_read, sizeof(buff) - 1));
	    if(rcnt == 0) break; //end of file
	   	if(rcnt == -1) {
			print(STD_ERR, "Failed to read file\n");
			exit(1);
		}
		buff[rcnt] = '\0';
		bytes_to_read -= rcnt;
		for(size_t i = 0; i < rcnt; i++){
			if(buff[i] == c2c) count++;
		}
	}
	write(pipe_to_disp, &count, sizeof(count));
    close(pipe_from_disp);
    close(pipe_to_disp);
    exit(0);
}

void handle_worker_input(int argc, char **argv) {
    if(argc != 7) {
        print(STD_ERR, "The number of arguments is wrong!\n");
        exit(1);
    }

    if(strlen(argv[6]) != 1) {
        print(STD_ERR, "You can search for single characters, not entire strings!\n");
        exit(1);
    }
}

void sighandler(int signum) {
    if(signal(SIGUSR1, sighandler) < 0) {
        perror("Could not establish SIGUSR1 handler.\n");
    }
    if(signum == SIGUSR1) {
        int input;
        read(pipe_from_disp, &input, sizeof(input));
        switch(input) {
            case 0:
                break;

            case 1:
                break;

            default:
                print(STD_OUT, "Dispatcher received unrecognised instruction from frontend.\n");
                exit(1);

        }
    }
    else if(signum == SIGKILL) {
        //AA
    }
}