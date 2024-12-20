#include "cgic.h"
#include <stdlib.h>

int cgiMain() {
	cgiWriteEnvironment("/tmp/capcgi.dat");
	cgiHeaderContentType("text/html");
	fprintf(cgiOut, "<title>Captured</title>\n");
	fprintf(cgiOut, "<h1>Captured</h1>\n");
	fprintf(cgiOut, "Your form submission was captured for use in\n");
	fprintf(cgiOut, "debugging CGI code.\n");
	return 0;
}

#ifndef CGICNOMAIN
int main(int argc, char *argv[])
{
  return (cgicMain(argc, argv) ? EXIT_FAILURE : cgiMain());
}
#endif /* !CGICNOMAIN */
