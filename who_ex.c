/* added by venovako */
#include "cgic.h"
#include <stdlib.h>
#include <sys/types.h>
#include <grp.h>
#include <pwd.h>
#include <unistd.h>

int cgiMain()
{
  struct passwd *const rpw = getpwuid(getuid());
  if (!rpw)
    return EXIT_FAILURE;
  struct group *const rgr = getgrgid(getgid());
  if (!rgr)
    return EXIT_FAILURE;
  struct passwd *const epw = getpwuid(geteuid());
  if (!epw)
    return EXIT_FAILURE;
  struct group *const egr = getgrgid(getegid());
  if (!egr)
    return EXIT_FAILURE;
  cgiHeaderContentType("text/html");
  (void)fprintf(cgiOut, "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n<meta charset=\"UTF-8\">\n<title>real and effective user and group</title>\n</head>\n<body>\n<table style=\"border: solid thick;\">\n<caption>real and effective user and group</caption><thead><th style=\"border: solid medium; text-align: left;\">type</th><th style=\"border: solid medium; text-align: center;\">user</th><th style=\"border: solid medium; text-align: right;\">group</th></thead>\n<tbody>\n");
  (void)fprintf(cgiOut, "<tr><td style=\"border: solid thin; text-align: left;\">real</td><td style=\"border: solid thin; text-align: center;\">%s</td><td style=\"border: solid thin; text-align: right;\">%s</td></tr>\n", rpw->pw_name, rgr->gr_name);
  (void)fprintf(cgiOut, "<tr><td style=\"border: solid thin; text-align: left;\">effective</td><td style=\"border: solid thin; text-align: center;\">%s</td><td style=\"border: solid thin; text-align: right;\">%s</td></tr>\n", epw->pw_name, egr->gr_name);
  (void)fprintf(cgiOut, "</tbody>\n</table>\n</body>\n</html>\n");
  return EXIT_SUCCESS;
}

#ifndef CGICNOMAIN
int main(int argc, char *argv[])
{
  return (cgicMain(argc, argv) ? EXIT_FAILURE : cgiMain());
}
#endif /* !CGICNOMAIN */
