#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <string.h>

void argument_handling(int argc, char **argv);

int main(int argc, char **argv) {
	argument_handling(argc, argv);
	int fdr, fdw, oflags, mode;
	char c2c = 'a';
	int count = 0;
	oflags = O_CREAT | O_WRONLY | O_TRUNC;	
	mode = S_IRUSR | S_IWUSR;
	if((fdr = open(argv[1], O_RDONLY)) == -1) {
		perror("Problem opening file to read\n");
		exit(1);
	}
	if((fdw = open(argv[2], oflags, mode)) == -1) {
		perror("Problem opening file to write\n");
		exit(1);
	}

	ssize_t rcnt;
	char buff[1024];
   	c2c = argv[3][0];

	while(1) {
		rcnt = read(fdr, buff, sizeof(buff) - 1);
	    if(rcnt == 0) break; //end of file
	   	if(rcnt == -1) {
			perror("Failed to read file\n");
			exit(1);
		}
		buff[rcnt] = '\0';
		for(size_t i = 0; i < rcnt; i++){
			if(buff[i] == c2c) count++;	
		}
	}
	close(fdr);
	ssize_t wcnt;
	snprintf(buff, sizeof(buff), "The character '%c' appears %d times in file %s.\n", c2c, count, argv[1]);   	
	size_t len = strlen(buff), idx = 0;
	do {
		wcnt = write(fdw, buff+idx, len-idx);
		if(wcnt == -1){
			perror("Failed to write to file\n");
			exit(1);
		}
		idx += wcnt;
	} while(idx < len);
	close(fdw);
	return 0;
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

