#include "config.h"

int min(int a, int b) {
	return (a < b ? a : b);
}

int max(int a, int b) {
	return (a >= b ? a : b);
}

void print(int fdw, char *buff){
	size_t idx = 0, len = strlen(buff);
	ssize_t wcnt;
	do{
		wcnt = write(fdw, buff+idx, len-idx);
		if(wcnt == -1){
			print(STD_ERR, "write\n");
			exit(1);
		}
		idx += wcnt;
	}while(idx < len);
}

void show_pstree(pid_t p){
    int ret;
    char cmd[1024];
    snprintf(cmd, sizeof(cmd), "echo; echo; pstree -a -G -c -p %ld; echo; echo", (long)p);
    cmd[sizeof(cmd)-1] = '\0';
    ret = system(cmd);
    if (ret < 0) {
        print(STD_ERR, "system\n");
        exit(104);
    }
}

void itoa(int num, char *str){
    sprintf(str, "%d", num);
}