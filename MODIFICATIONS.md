# Modifications of the original source code

Some whitespace cleanup.

Wherever sensible, `malloc()` has been replaced by `calloc()`, and the subsequent `memset()` calls have been removed.

A CGI application now has to explicitly contain
```c
int main(int argc, char *argv[])
{
  /* some optional initialization prior to calling the cgic routines */
  return cgicMain(argc, argv);
}
```
with `cgiMain()` as usual (i.e., `main()` is no longer a part of the library).
