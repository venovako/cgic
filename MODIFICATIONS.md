# Modifications of the original source code

Some hardcoded paths changed and whitespace cleaned up.

Wherever sensible, `malloc()` has been replaced by `calloc()`, and the subsequent `memset()` calls have been removed.

`cgiFormLong()` and its bounded version return a `long` value.

`cgiFormFloat()` and `cgiFormLongDouble()` and their bounded versions return a `float` or a `long double` value, respectively.

Some static functions have been made `extern` and the associated type definitions have been moved to `cgic.h`.

A CGI application now has to explicitly contain
```c
int main(int argc, char *argv[])
{
  /* some optional initialization prior to calling the cgic routines */
  int ret = cgicMain(argc, argv);
  /* check ret and do other stuff */
  /* the application logic does not have to be implemented in cgiMain() anymore, but can be */
  ret = cgiMain();
  /* some optional cleanup after the cgiMain() call */
  return ret; /* or whatever suitable */
}
```
with `cgicMain()` being a new function that does what `main()` was doing in the original code, except calling `cgiMain()`.
This way `main()` is no longer a part of the library.

One possible use case is to build an executable that can act as a CGI application as well as a standalone application, depending, e.g., on the command-line arguments.

Another possibility is to write the main program in something that is not C/C++ (e.g., in Fortran, as shown in `cgiftest.f90`).
