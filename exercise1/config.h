#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <signal.h>
#include <stdint.h>

#define STD_IN 0
#define STD_OUT 1
#define STD_ERR 2

#define MAX_WORKERS 64

int min(int a, int b);
void print(int fdw, char *buff);
void show_pstree(pid_t p);
void scan(int fd, char *buff, unsigned int bytes_to_read);
void itoa(int num, char *str);