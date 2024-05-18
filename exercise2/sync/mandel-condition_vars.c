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
#include <pthread.h>
#include <semaphore.h>
#include <fcntl.h>
#include <stdbool.h>
#include <signal.h>

#include "mandel-lib.h"

#define MANDEL_MAX_ITERATION 100000

/***************************
 * Compile-time parameters *
 ***************************/

/*
 * Output at the terminal is is x_chars wide by y_chars long
*/
const int y_chars = 50;
const int x_chars = 90;

/*
 * The part of the complex plane to be drawn:
 * upper left corner is (xmin, ymax), lower right corner is (xmax, ymin)
*/
const double xmin = -1.8, xmax = 1.0;
const double ymin = -1.0, ymax = 1.0;
	
/*
 * Every character in the final output is
 * xstep x ystep units wide on the complex plane.
 */
double xstep;
double ystep;

int NTHREADS;

struct thread_info {
    pthread_t thread_id;
    int fd;
    int line;
}; 

pthread_mutex_t mut;
pthread_cond_t *conds;
bool *myturn;

void *safe_malloc(size_t size)
{
	void *p;

	if ((p = malloc(size)) == NULL) {
		fprintf(stderr, "Out of memory, failed to allocate %zd bytes\n",
			size);
		exit(1);
	}

	return p;
}

/*
 * This function computes a line of output
 * as an array of x_char color values.
 */

void compute_mandel_line(int line, int color_val[])
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
void output_mandel_line(int fd, int color_val[])
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

void * compute_and_output_mandel_line(void *arg) //arg: int fd, int line
{
    struct thread_info *thread = (struct thread_info *) arg;
	int fd = thread->fd;
	int line = thread->line;
	/*
	 * A temporary array, used to hold color values for the line being drawn
	 */
	int color_val[x_chars];

	for( ; line < y_chars; line += NTHREADS) {

		compute_mandel_line(line, color_val);
		pthread_mutex_lock(&mut); //lock mutex
		// wait until previous thread sends signal
		while(!myturn[line%NTHREADS]) pthread_cond_wait(&conds[line%NTHREADS], &mut);
		myturn[line%NTHREADS] = false;
		output_mandel_line(fd, color_val);
		myturn[(line+1)%NTHREADS] = true;
        pthread_cond_signal(&conds[(line+1)%NTHREADS]); //send signal to next thread
		pthread_mutex_unlock(&mut); //unlock mutex
	}
	return NULL;
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
	if(safe_atoi(argv[1], &NTHREADS) == -1){
		perror("atoi error!\n");
		exit(1);
	}
	if(NTHREADS <= 0){
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

    struct thread_info *threads;

    threads = (struct thread_info *) safe_malloc(NTHREADS * sizeof(struct thread_info));
	conds = (pthread_cond_t* ) safe_malloc(NTHREADS * sizeof(pthread_cond_t));
	myturn = (bool *) safe_malloc(NTHREADS * sizeof(bool));
	
	myturn[0] = true;

    for(int i = 0; i < NTHREADS; ++i) {
		threads[i].fd = 1;
		threads[i].line = i;
        int ret = pthread_create(&threads[i].thread_id, NULL, compute_and_output_mandel_line, &threads[i]);
        if(ret) {
            perror("pthread_create");
			exit(1);
        }
    }

    for(int i = 0; i < NTHREADS; ++i) { //join all threads after their executions
        int ret = pthread_join(threads[i].thread_id, NULL);
        if(ret) {
            perror("pthread_join");
			exit(1);
        }
    }

	reset_xterm_color(1);
	free(threads);
	free(conds);
	return 0;
}
