#include "config.h"

void handle_worker_input(int argc, char **argv);

/*
argc = 6;
argv =
{   0: "a1.4worker",
    1: int fdr,
    2: off_t start,
    3: size_t bytes_to_read,
    4: int *pfd,
    5: char c2c
};
*/
int main(int argc, char **argv) {
    handle_worker_input(argc, argv);
    int fdr = atoi(argv[1]);
    off_t start = (off_t) atoi(argv[2]); //!Check for conversion bugs
    size_t bytes_to_read = (size_t) atoi(argv[3]);
    int *pfd = (int *) atoi(argv[4]);
    char c2c = argv[5][0];

    ssize_t rcnt = 0;
    int count = 0;
    char buff[1024];
    lseek(fdr, start, SEEK_SET);
    while(1) {
		rcnt = read(fdr, buff, min(bytes_to_read, sizeof(buff)));
	    if(rcnt == 0) break; //end of file
	   	if(rcnt == -1){
			print(STD_ERR, "Failed to read file\n");
			exit(1);
		}
		buff[rcnt] = '\0';
		bytes_to_read -= rcnt;
		for(size_t i = 0; i < rcnt; i++){
			if(buff[i] == c2c) count++;	
		}
	}
	write(pfd[1], &count, sizeof(count));
}

void handle_worker_input(int argc, char **argv) {
    if(argc != 6) {
        print(STD_ERR, "The number of arguments is wrong!\n");
        exit(1);
    }

    if(strlen(argv[5]) != 1) {
        print(STD_ERR, "You can search for single characters, not entire strings!\n");
        exit(1);
    }
}