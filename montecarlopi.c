#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {

  double x, y;
  int inside = 0;

  time_t started = time(NULL);

  srand(started);

  int n = rand() % 10000 + 1;

  printf("Compiled on %s at %s\n", __DATE__, __TIME__);
  printf("Execution started on %s", ctime(&started));

  for (int i = 0; i < n; i++) {

    x = (double)rand() / RAND_MAX;
    y = (double)rand() / RAND_MAX;

    if (x * x + y * y <= 1) {
      inside++;
    }
  }

  double pi = 4.0 * inside / n;

  printf("The approximation of Pi using %d iterations is %f\n", n, pi);

  time_t stopped = time(NULL);

  printf("Execution stopped on %s", ctime(&stopped));

  return 0;
}