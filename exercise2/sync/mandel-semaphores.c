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

#include "mandel-lib.h"

#define MANDEL_MAX_ITERATION 100000
#define NTHREADS 3

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

/*
 * This function computes a line of output
 * as an array of x_char color values.
 */

struct thread_info {
    pthread_t thread_id;
    int fd;
    int line;
}; 

sem_t *semaphores;

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
		sem_wait(&semaphores[(line)%NTHREADS]); //lock current semaphore
		output_mandel_line(fd, color_val);
		sem_post(&semaphores[(line + 1)%NTHREADS]); //unlock the next semaphore
	}
}

int main(void)
{
	xstep = (xmax - xmin) / x_chars;
	ystep = (ymax - ymin) / y_chars;

	/*
	 * draw the Mandelbrot Set, one line at a time.
	 * Output is sent to file descriptor '1', i.e., standard output.
	 */

    struct thread_info *threads;

    threads = (struct thread_info *) safe_malloc(NTHREADS * sizeof(struct thread_info));
    semaphores = (sem_t*) safe_malloc(NTHREADS * sizeof(sem_t));

	sem_init(&semaphores[0], 0, 1); //initialize the 0th semaphore to 1
	
	for(int i = 1; i < NTHREADS; ++i) {
        int ret = sem_init(&semaphores[i], 0, 0); //and all else to 0
		if(ret) {
			perror("Semaphore init");
			exit(1);
		}
	}

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

	for (int i = 0; i < NTHREADS; ++i) { //destroy every semaphore
		int ret = sem_destroy(&semaphores[i]);
		if(ret) {
			perror("Semaphore destroy");
			exit(1);
		}
	}

	reset_xterm_color(1);
	free(threads);
	free(semaphores);
	return 0;
}
