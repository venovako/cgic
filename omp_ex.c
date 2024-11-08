#include "cgic.h"
#include <stdlib.h>
#ifdef _OPENMP
#include <omp.h>
#include <unistd.h>
#endif /* _OPENMP */

int cgiMain()
{
  int ret = EXIT_SUCCESS;
  cgiHeaderContentType("text/html");
  (void)fprintf(cgiOut, "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"UTF-8\">\n<title>OpenMP environment</title>\n</head>\n<body>\n<pre>");
#ifdef _OPENMP
  /* this assumes that omp_display_env() writes to stderr */
  FILE *old = stderr;
  stderr = stdout;
  omp_display_env(1);
  stderr = old;
  (void)fprintf(cgiOut, "omp_get_max_threads() = %d\n", omp_get_max_threads());
#else /* !_OPENMP */
  (void)fprintf(cgiOut, "OpenMP is not enabled.\n");
  ret = EXIT_FAILURE;
#endif /* ?_OPENMP */
  (void)fprintf(cgiOut, "</pre>\n</body>\n</html>\n");
  return ret;
}

#ifndef CGICNOMAIN
int main(int argc, char *argv[])
{
  return cgicMain(argc, argv);  
}
#endif /* !CGICNOMAIN */
