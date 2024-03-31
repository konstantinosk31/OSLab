#include <unistd.h>
#include <stdio.h>
#include "zing.h"

void zing() {
	char *username = getlogin();
	printf("Hello there ;) %s\n", username);
}
