/*
 * mandel.c
 *
 * A program to draw the Mandelbrot Set on a 256-color xterm.
 *
 */

#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <semaphore.h>

#include "mandel-lib.h"

#define MANDEL_MAX_ITERATION 100000

/*
 * Print the given message and exit with a failed status.
 */
#define die(msg) \
	do { perror(msg); exit(EXIT_FAILURE); } while (0)

/***************************
 * Compile-time parameters *
 ***************************/

/*
 * Output at the terminal is is x_chars wide by y_chars long
*/
int y_chars = 50;
int x_chars = 90;

/*
 * The part of the complex plane to be drawn:
 * upper left corner is (xmin, ymax), lower right corner is (xmax, ymin)
*/
double xmin = -1.8, xmax = 1.0;
double ymin = -1.0, ymax = 1.0;
	
/*
 * Every character in the final output is
 * xstep x ystep units wide on the complex plane.
 */
double xstep;
double ystep;

int NPROCS;

unsigned char **heap_shared_buf;

/*
 * Retrieve the system's page size.
 */
long get_page_size(void)
{
	static long page_size = 0;

	if (0 == page_size && -1 == (page_size = sysconf(_SC_PAGESIZE)))
		die("sysconf(_SC_PAGESIZE)");

	return page_size;
}

void *safe_malloc(size_t size)
{
	void *p;

	if ((p = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)) == MAP_FAILED) {
		die("mmap error");
	}

	return p;
}

void *safe_shared_malloc(size_t size)
{
	void *p;

	if ((p = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0)) == MAP_FAILED) {
		die("mmap error");
	}

	return p;
}

void safe_free(void *ptr, size_t size){
	if(munmap(ptr, size) == -1) die("munmap error");
}

/*
 * This function computes a line of output
 * as an array of x_char color values.
 */
void compute_mandel_line(int line, unsigned char color_val[])
{
	/*
	 * x and y traverse the complex plane.
	 */
	double x, y;

	int n;
	int val;

	/* Find out the y value corresponding to this line */
	y = ymax - ystep * line;

	/* and iterate for all points on this line */
	for (x = xmin, n = 0; n < x_chars; x+= xstep, n++) {

		/* Compute the point's color value */
		val = mandel_iterations_at_point(x, y, MANDEL_MAX_ITERATION);
		if (val > 255)
			val = 255;

		/* And store it in the color_val[] array */
		val = xterm_color(val);
		color_val[n] = val;
	}
}

/*
 * This function outputs an array of x_char color values
 * to a 256-color xterm.
 */
void output_mandel_line(int fd, unsigned char color_val[])
{
	int i;
	
	char point ='@';
	char newline='\n';

	for (i = 0; i < x_chars; i++) {
		/* Set the current color, then output the point */
		set_xterm_color(fd, color_val[i]);
		if (write(fd, &point, 1) != 1) {
			perror("compute_and_output_mandel_line: write point");
			exit(1);
		}
	}

	/* Now that the line is done, output a newline character */
	if (write(fd, &newline, 1) != 1) {
		perror("compute_and_output_mandel_line: write newline");
		exit(1);
	}
}

void compute_and_output_mandel_line(int line)
{
	for( ; line < y_chars; line += NPROCS) {
		compute_mandel_line(line, heap_shared_buf[line]);
		safe_free(heap_shared_buf[line], x_chars);
	}
}

/*
 * Create a shared memory area, usable by all descendants of the calling
 * process.
 */
void *create_shared_memory_area(unsigned int numbytes)
{
	int pages;
	void *addr;

	if (numbytes == 0) {
		fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
		exit(1);
	}

	/*
	 * Determine the number of pages needed, round up the requested number of
	 * pages
	 */
	pages = (numbytes - 1) / get_page_size() + 1;

	/* Create a shared, anonymous mapping for this number of pages */
	if ((addr = mmap(NULL, pages*get_page_size(), PROT_READ|PROT_WRITE, MAP_SHARED|MAP_ANONYMOUS, -1, 0)) == MAP_FAILED) {
		die("mmap error");
	}

	return addr;
}

void destroy_shared_memory_area(void *addr, unsigned int numbytes) {
	int pages;

	if (numbytes == 0) {
		fprintf(stderr, "%s: internal error: called for numbytes == 0\n", __func__);
		exit(1);
	}

	/*
	 * Determine the number of pages needed, round up the requested number of
	 * pages
	 */
	pages = (numbytes - 1) / get_page_size() + 1;

	if (munmap(addr, pages * get_page_size()) == -1) {
		perror("destroy_shared_memory_area: munmap failed");
		exit(1);
	}
}

int safe_atoi(char *s, int *val){
	long l;
	char *endp;

	l = strtol(s, &endp, 10);
	if (s != endp && *endp == '\0') {
		*val = l;
		return 0;
	} else
		return -1;
}

void argument_handling(int argc, char **argv) {
	if(argc != 2) {
		perror("There should one argument: the number of threads wanted.\n");
		exit(1);
	}
	if(safe_atoi(argv[1], &NPROCS) == -1){
		perror("atoi error!\n");
		exit(1);
	}
	if(NPROCS <= 0){
		perror("The number of threads should be a positive integer.\n");
		exit(1);
	}
}

void sigintHandler(int sig_num) {
	if(signal(SIGINT, sigintHandler) < 0){
		perror("Could not establish SIGINT handler");
		exit(1);
	}
	reset_xterm_color(1);
	exit(1);
}

int main(int argc, char **argv){
	argument_handling(argc, argv);
	if(signal(SIGINT, sigintHandler) < 0){
		perror("Could not establish SIGINT handler");
		exit(1);
	}

	xstep = (xmax - xmin) / x_chars;
	ystep = (ymax - ymin) / y_chars;

	/*
	 * draw the Mandelbrot Set, one line at a time.
	 * Output is sent to file descriptor '1', i.e., standard output.
	 */
	pid_t *procs;

    procs = (pid_t *) safe_malloc(NPROCS * sizeof(pid_t));
	heap_shared_buf = (unsigned char **) safe_malloc(y_chars*sizeof(unsigned char *));

	for(int line = 0; line < y_chars; line++){
		heap_shared_buf[line] = (unsigned char *) safe_shared_malloc(x_chars);
	}

    for(int i = 0; i < NPROCS; ++i) {
        pid_t p = fork();
		if(p < 0) die("fork error");
		if(p == 0){
			compute_and_output_mandel_line(i);
			return 0;
		}
		if(p > 0) procs[i] = p;
    }

    for(int i = 0; i < NPROCS; ++i) { //wait for all children
        int status;
		if(waitpid(procs[i], &status, WUNTRACED) == -1) die("waitpid error");
    }

	for(int line = 0; line < y_chars; line++){
		output_mandel_line(1, heap_shared_buf[line]);
		safe_free(heap_shared_buf[line], x_chars);
	}

	reset_xterm_color(1);
	safe_free(procs, NPROCS*sizeof(pid_t));
	safe_free(heap_shared_buf, y_chars*sizeof(char *));
	return 0;
}
