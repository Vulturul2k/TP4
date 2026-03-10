#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int seed = atoi(argv[1]);

  srand(seed);
  printf("Random number: %d\n", rand());

  return 0;
}