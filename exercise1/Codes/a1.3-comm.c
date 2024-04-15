#include <unistd.h>
#include <math.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <signal.h>

#define CPUCORES 8
#define STD_ERR 2

int P = 0;

void argument_handling(int argc, char **argv);
void print(int fdw, char *buff);
int min(int a, int b);
void child(int fdr, off_t start, size_t bytes_to_read, int *pfd, char c2c);
void parent(int fdw, int **pfd, char c2c, char *file_to_write);
void sigintHandler(int sig_num);

int main(int argc, char **argv) {
	argument_handling(argc, argv);
	int fdr, fdw;
	int oflags, mode;
	oflags = O_CREAT | O_WRONLY | O_TRUNC;	
	mode = S_IRUSR | S_IWUSR;
	if((fdr = open(argv[1], O_RDONLY)) == -1){
		perror("Problem opening file to read\n");
		exit(1);
	}
	if((fdw = open(argv[2], oflags, mode)) == -1){
		perror("Problem opening file to write\n");
		exit(1);
	}
	struct stat st;
	if(stat(argv[1], &st) < 0){
		perror("Stat error\n");
		exit(1);
	}
	if(signal(SIGINT, sigintHandler) < 0){
		perror("Could not establish SIGINT handler");
		exit(1);
	}
	printf("Initiated SIGINT handler\n");
	sleep(1); //To be able to test the SIGINT handler
	off_t size = st.st_size;
	P = CPUCORES;
	off_t batch_size = size / P;
	//printf("File size = %ld, batch size = %ld, P = %d\n", size, batch_size, P);
	off_t idx = 0, extra_left = size - P * batch_size;
	int **pfd = (int**)malloc(P * sizeof(int *));
	for(int i = 0; i < P; ++i) {
		pfd[i] = (int *)malloc(2 * sizeof(int));
	}
	pid_t p;
	for(int i = 0; i < P; i++) {
		size_t bytes_to_read = batch_size + (i < extra_left);
		if(pipe(pfd[i]) < 0){
			perror("pipe\n");
			exit(1);
		}
		p = fork();
		if(p < 0) {
			perror("fork\n");
			exit(1);
		}
		else if(p == 0) {
			child(fdr, idx, bytes_to_read, pfd[i], argv[3][0]);
			exit(0);
		}
		idx += bytes_to_read;
	}
	int status = 0;
	for(int i = 0; i < P; i++) wait(&status);
	if(p > 0) {
		parent(fdw, pfd, argv[3][0], argv[1]);		
	}
	close(fdr);
	close(fdw);
	for(int i = 0; i < P; ++i) {
		free(*(pfd + i));
	}
	free(pfd);
}

void argument_handling(int argc, char **argv) {
    if(argc != 4) {
        perror("There should be three arguments!! (source file, destination file and character)\n");
        exit(1);
    }

    if(strlen(argv[3]) > 1) {
        perror("You can search for specific characters, not entire strings!!\n");
        exit(1);
    }
}

void print(int fdw, char *buff) {
	size_t idx = 0, len = strlen(buff);
	ssize_t wcnt;
	do{
		wcnt = write(fdw, buff+idx, len-idx);
		if(wcnt == -1){
			perror("write\n");
			exit(1);
		}
		idx += wcnt;
	}while(idx < len);
}

int min(int a, int b) {
	return (a < b ? a : b);
}

void child(int fdr, off_t start, size_t bytes_to_read, int *pfd, char c2c) { //[start, start+bytes_to_read-1]
	ssize_t rcnt = 0;
	int count = 0;
	char buff[1024];
	close(pfd[0]);
	while(bytes_to_read) {
		//start += rcnt;
		//lseek(fdr, start, SEEK_SET);
		//usleep(5000); //!THIS CAUSES AN ERROR DUE TO SHARED FILE POINTER BETWEEN THE CHILDREN
		rcnt = read(fdr, buff, min(bytes_to_read, sizeof(buff) - 1)); 
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
	//printf("Child starting at %ld read %d '%d's\n", start, count, c2c);
	write(pfd[1], &count, sizeof(count));
	close(pfd[1]);
}

void parent(int fdw, int **pfd, char c2c, char *file_to_write) {
	int count = 0, cnt = 0;
	for(int i = 0; i < P; i++){
		close(pfd[i][1]);
		read(pfd[i][0], &cnt, sizeof(cnt));
		count += cnt;
		close(pfd[i][0]);
	}
	char buff[1024];
	snprintf(buff, sizeof(buff), "The character '%c' appears %d times in file %s.\n", c2c, count, file_to_write);  	
	print(fdw, buff);
}

void sigintHandler(int sig_num) {
	if(signal(SIGINT, sigintHandler) < 0){
		perror("Could not establish SIGINT handler");
		exit(1);
	}
	sleep(1); //To be able to test the SIGINT handler
	char buff[1024];
	snprintf(buff, sizeof(buff), "There are %d processes reading the input file in parallel\n", P);
	print(1, buff);
}
