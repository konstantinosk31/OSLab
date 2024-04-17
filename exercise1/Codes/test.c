#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int rand1(int a, int b){
	return a + rand()%(b-a+1);
}

void rand_input(int n){
	for(long long i = 0ll; i < n; i++){
		int v = rand1(1, 4 - (i == n-1));
		char c;
		switch(v){
		case 1:
			c = rand1('a', 'z');
			break;
		case 2:
			c = rand1('A', 'Z');
			break;
		case 3:
			c = rand1('0', '9');
			break;
		case 4:
			c = ' ';
			break;
		default:
			break;
		}
		putchar(c);
	}
}

void alla(int n){
	for(long long i = 0ll; i < n; i++){
		putchar('a');
	}
}

int main() {
	long long n = 3.75e8;
	freopen("titanic_input.txt", "w", stdout);
	fork();
	fork();
	rand_input(n);
}
