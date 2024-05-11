#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <signal.h>
#include <math.h>
#include <stdint.h>

#define STD_IN 0
#define STD_OUT 1
#define STD_ERR 2

#define MAX_WORKERS 64

int min(int a, int b); //returns the minimum of a and b
int max(int a, int b); //returns the maximum of a and b
void print(int fdw, char *buff); //prints the content of buff to the file descriptor fdw
void show_pstree(pid_t p); //show process tree
void scan(int fd, char *buff, unsigned int bytes_to_read); //scan bytes_to_read bytes from file descriptor fd to buff
void itoa(int num, char *str); //convert int num to char array str