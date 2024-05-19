#
# Makefile
# 

CC = gcc

# CAUTION: Always use '-pthread' when compiling POSIX threads-based
# applications, instead of linking with "-lpthread" directly.
CFLAGS = -Wall -O2 -pthread
LIBS = 

all: sync-comm


## Mandel

sync-comm: sync-comm.o
	$(CC) $(CFLAGS) -o sync-comm sync-comm.o $(LIBS)

sync-comm.o: sync-comm.c
	$(CC) $(CFLAGS) -c -o sync-comm.o sync-comm.c $(LIBS)

clean:
	rm -f *.s *.o sync-comm
