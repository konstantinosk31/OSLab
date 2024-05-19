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
#include <sys/mman.h>
#include <semaphore.h>

/*
 * Print the given message and exit with a failed status.
 */
#define die(msg) \
	do { perror(msg); exit(EXIT_FAILURE); } while (0)

#define CPUCORES 8
#define STD_ERR 2

int P = 0;
int* count;
sem_t* sema;

void argument_handling(int argc, char **argv);
void print(int fdw, char *buff);
int min(int a, int b);
void child(int fdr, size_t bytes_to_read, char c2c);
void sigintHandler(int sig_num);
void safe_free(void *ptr, size_t size);

int main(int argc, char **argv) {
	argument_handling(argc, argv);

	int fdr, fdw;
	int oflags, mode;
	oflags = O_CREAT | O_WRONLY | O_TRUNC;	
	mode = S_IRUSR | S_IWUSR;
	if((fdr = open(argv[1], O_RDONLY)) == -1) die("Problem opening file to read\n");
	if((fdw = open(argv[2], oflags, mode)) == -1) die("Problem opening file to write\n");

	struct stat st;
	if(stat(argv[1], &st) < 0) die("Stat error\n");
	if(signal(SIGINT, sigintHandler) < 0) die("Could not establish SIGINT handler");
	off_t size = st.st_size;

	P = CPUCORES;
	off_t batch_size = size / P;
	off_t extra_left = size - P * batch_size;
	pid_t p;
	
	if((count = (int *) mmap(NULL, sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0)) == MAP_FAILED)
		die("mmap error");
	*count = 0;
	if((sema = (sem_t *) mmap(NULL, sizeof(sem_t), PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0)) == MAP_FAILED)
		die("mmap error");
	sem_init(sema, 1, 1);

	for(int i = 0; i < P; i++) {
		size_t bytes_to_read = batch_size + (i < extra_left);
		p = fork();
		if(p < 0) die("fork error");
		else if(p == 0) {
			child(fdr, bytes_to_read, argv[3][0]);
			exit(0);
		}
	}

	int status = 0;
	for(int i = 0; i < P; i++) wait(&status);
	
	safe_free(sema, sizeof(sem_t));
	if(sem_destroy(sema)) die("sem_destroy error");
	close(fdr);
	
	char buff[1024];
	snprintf(buff, sizeof(buff), "The character '%c' appears %d times in file %s.\n", argv[3][0], *count, argv[1]);  	
	print(fdw, buff);
	
	safe_free(count, sizeof(int));
	close(fdw);
}

void argument_handling(int argc, char **argv) {
    if(argc != 4) die("There should be three arguments!! (source file, destination file and character)\n");

    if(strlen(argv[3]) > 1) die("You can search for specific characters, not entire strings!!\n");
}

void print(int fdw, char *buff) {
	size_t idx = 0, len = strlen(buff);
	ssize_t wcnt;
	do{
		wcnt = write(fdw, buff+idx, len-idx);
		if(wcnt == -1) die("write error");
		idx += wcnt;
	}while(idx < len);
}

int min(int a, int b) {
	return (a < b ? a : b);
}

void child(int fdr, size_t bytes_to_read, char c2c) {
	ssize_t rcnt = 0;
	char buff[1024];
	while(bytes_to_read) {
		rcnt = read(fdr, buff, min(bytes_to_read, sizeof(buff) - 1)); 
	    if(rcnt == 0) break; //end of file
	   	if(rcnt == -1) die("Failed to read file\n");
		buff[rcnt] = '\0';
		bytes_to_read -= rcnt;
		for(size_t i = 0; i < rcnt; i++){
			if(buff[i] == c2c){
				sem_wait(sema);
				(*count)++;
				sem_post(sema);
			}	
		}
	}
	safe_free(sema, sizeof(sem_t));
	safe_free(count, sizeof(int));
}

void sigintHandler(int sig_num) {
	if(signal(SIGINT, sigintHandler) < 0) die("Could not establish SIGINT handler");
	sleep(1); //To be able to test the SIGINT handler
	char buff[1024];
	snprintf(buff, sizeof(buff),"There are %d processes reading the input file in parallel.\nCounted %d occurences of the character so far.\n", P, *count);
	print(1, buff);
}

void safe_free(void *ptr, size_t size){
	if(munmap(ptr, size) == -1) die("munmap error");
}