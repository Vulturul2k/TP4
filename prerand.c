#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
  srand(time(NULL));
  printf("Random number: %d\n", rand());
  return 0;
}