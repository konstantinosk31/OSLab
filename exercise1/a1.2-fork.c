#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>

void argument_handling(int argc, char **argv);
void print(int fdw, char *buff);
void child(int *x, int fdr, int fdw, char c2c, char *file_to_write);
void parent(pid_t p, int *x);

int main(int argc, char **argv) {
	argument_handling(argc, argv);
	int fdr, fdw;
	int x = 17;
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

	pid_t p;
	p = fork();
	if(p < 0){
		perror("fork");
		exit(1);
	}
	else if(p == 0){
		child(&x, fdr, fdw, argv[3][0], argv[1]);		
		exit(0);
	}
	else{
		parent(p, &x);
	}

	close(fdr);
	close(fdw);

	p = fork();
	if(p < 0){
		perror("fork");
		exit(1);
	}
	else if(p == 0){
		char *argv2[] = {"./a1.1-C\0", "", "", "", NULL};
		for(int i = 1; i <= 3; i++){
			argv2[i] = (char *)malloc(sizeof(argv[i]));
			strcpy(argv2[i], argv[i]);
		}
		execv(argv2[0], argv2);
		exit(0);
	}
	else{
		int status;
		wait(&status);
		char buff[1024];
		snprintf(buff, sizeof(buff), "Child process %d exited with status %d.\n", p, status);		
		print(1, buff);
		exit(0);
	}
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

void child(int *x, int fdr, int fdw, char c2c, char *file_to_write) {
	pid_t mypid = getpid(), parpid = getppid();
	char buff[1024];
	snprintf(buff, sizeof(buff), "Hello World!\nMy pid is %d.\nMy parent's pid is %d.\n", mypid, parpid);
	print(1, buff);

	*x = 42;
	snprintf(buff, sizeof(buff), "Variable x is %d (child).\n", *x);
	print(1, buff);

	ssize_t rcnt;
	int count = 0;
	while(1) {
		rcnt = read(fdr, buff, sizeof(buff)-1);
	    if(rcnt == 0) break; //end of file
	   	if(rcnt == -1){
			perror("Failed to read file\n");
			exit(1);
		}
		buff[rcnt] = '\0';
		for(size_t i = 0; i < rcnt; i++){
			if(buff[i] == c2c) count++;	
		}
	}
	snprintf(buff, sizeof(buff), "The character '%c' appears %d times in file %s.\n", c2c, count, file_to_write);  	
	print(fdw, buff);	
}

void parent(pid_t p, int *x) {
	char buff[1024];
   	snprintf(buff, sizeof(buff), "My child's pid is %d.\n", p);		
	print(1, buff);
	int status;
	snprintf(buff, sizeof(buff), "Variable x is %d (parent).\n", *x);
	print(1, buff);
	wait(&status);
	snprintf(buff, sizeof(buff), "Child process %d exited with status %d.\n", p, status);		
	print(1, buff);
}
