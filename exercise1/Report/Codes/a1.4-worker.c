#include "config.h"

void handle_worker_input(int argc, char **argv); //assert that input is of correct format
void sighandler(int signum); //signal handler for SIGUSR1 and SIGKILL

int pipe_from_disp, pipe_to_disp;

/*
argc = 7;
argv =
{   0: "a1.4worker",
    1: off_t start,
    2: size_t bytes_to_read,
    3: int pipe_from_disp,
    4: int pipe_to_disp,
    5: char c2c
    6: char* file_to_read,
};
*/

size_t bytes_to_read;
int pipe_to_disp;
int count;

int main(int argc, char **argv) {
    handle_worker_input(argc, argv);
    if(signal(SIGTERM, sighandler) < 0){
        perror("Could not establish SIGTERM handler.\n");
    }
    char *file_to_read = (char *) malloc(sizeof(argv[1]));
    off_t start = (off_t) atoi(argv[1]);
    bytes_to_read = (size_t) atoi(argv[2]);
    int pipe_from_disp = atoi(argv[3]);
    pipe_to_disp = atoi(argv[4]);
    char c2c = argv[5][0];
	strcpy(file_to_read, argv[6]);
	int fdr;
    if((fdr = open(file_to_read, O_RDONLY)) == -1){
         print(STD_ERR, "Problem opening file to read\n");
         exit(1);
    }
    ssize_t rcnt = 0;
    count = 0;
    char buff[1024];
    while(bytes_to_read) {
        start += rcnt;
        lseek(fdr, start, SEEK_SET);
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
    write(pipe_to_disp, &bytes_to_read, sizeof(bytes_to_read));
	write(pipe_to_disp, &count, sizeof(count));
    close(pipe_from_disp);
    close(pipe_to_disp);
    exit(0);
}

void handle_worker_input(int argc, char **argv) {
    if(argc != 7) {
        print(STD_ERR, "The number of arguments is wrong! (from worker)\n");
        exit(1);
    }

    if(strlen(argv[5]) != 1) {
        print(STD_ERR, "You can search for single characters, not entire strings!\n");
        exit(1);
    }
}

void sighandler(int signum) {
    if(signal(SIGTERM, sighandler) < 0) {
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
    else if(signum == SIGTERM) {
        write(pipe_to_disp, &bytes_to_read, sizeof(bytes_to_read));
	    write(pipe_to_disp, &count, sizeof(count));
        close(pipe_from_disp);
        close(pipe_to_disp);
        exit(0);
    }
}
