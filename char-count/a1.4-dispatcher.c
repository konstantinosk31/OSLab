#include "config.h"

void handle_dispatcher_input(int argc, char **argv);

int P;

/*
argc = 4;
argv = {
    0: "a1.4-dispatcher.c",
    1: int fdr,
    2: int pipe_from_front,
    3: int pipe_to_front,
    4: char c2c
};
*/
int main(int argc, char **argv) {
    handle_dispatcher_input(argc, argv);
    int fdr = atoi(argv[1]);
    int pipe_from_front = atoi(argv[2]);
    int pipe_to_front = atoi(argv[3]);
    char c2c = argv[3][0];

    while(1){
        int workers;
        read(pipe_from_front, &workers, sizeof(workers));
        if(workers != 0){
            P += workers;
            printf("Current number of workers is %d.\n", P);
        }
    }
}

void handle_dispatcher_input(int argc, char **argv) {
    if(argc != 5) {
        print(STD_ERR, "The number of arguments is wrong!\n");
        exit(1);
    }

    if(strlen(argv[4]) != 1) {
        print(STD_ERR, "You can search for single characters, not entire strings!\n");
        exit(1);
    }
}