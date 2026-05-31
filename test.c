#include "openfml.h"
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int x = atoi(argv[1]);
  printf("Log(%d) = %f", x, fast_log(x));
  return 0;
}