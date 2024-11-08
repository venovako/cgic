# Modifications of the original source code

Some hardcoded paths changed and whitespace cleaned up.

Wherever sensible, `malloc()` has been replaced by `calloc()`, and the subsequent `memset()` calls have been removed.

A CGI application now has to explicitly contain
```c
int main(int argc, char *argv[])
{
  /* some optional initialization prior to calling the cgic routines */
  int ret = cgicMain(argc, argv);
  /* some optional cleanup after the cgiMain() call */
  return ret; /* or whatever suitable */
}
```
with `cgiMain()` implemented as usual and `cgicMain()` being a new function that does what `main()` was doing in the original code.
This way `main()` is no longer a part of the library.

One possible use case is to build an executable that can act as a CGI application as well as a standalone application, depending, e.g., on the command-line arguments.

Another possibility is to write the main program in something that is not C/C++ (e.g., in Fortran, as shown in `cgiftest.f90`).
