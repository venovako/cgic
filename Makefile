ifdef NDEBUG
CFLAGS=-O$(NDEBUG) -DNDEBUG
else # !NDEBUG
CFLAGS=-Og -ggdb3 -DCGICDEBUG
endif # ?NDEBUG
CFLAGS += -march=native -fPIC -fexceptions -fasynchronous-unwind-tables -fno-omit-frame-pointer -pthread -Wall
FFLAGS=$(CFLAGS)
CC=gcc$(GNU)
FC=gfortran$(GNU)
AR=ar
RANLIB=ranlib
LIBS=-L. -lcgic

all: libcgic.a cgictest.cgi cgiftest.cgi capture

install: libcgic.a
	cp libcgic.a /usr/local/lib
	cp cgic.h /usr/local/include
	@echo libcgic.a is in /usr/local/lib. cgic.h is in /usr/local/include.

libcgic.a: cgic.o cgic.h
	rm -f libcgic.a
	$(AR) rc libcgic.a cgic.o
	$(RANLIB) libcgic.a

#mingw32 and cygwin users: replace .cgi with .exe
#static link on Linux: add -static -s

cgictest.cgi: cgictest.o libcgic.a
	$(CC) $(CFLAGS) cgictest.o -o cgictest.cgi ${LIBS}

cgictest.obj: cgictest.c
	$(CC) $(CFLAGS) -DCGICNOMAIN cgictest.c -c -o cgictest.obj

cgiftest.cgi: cgictest.obj libcgic.a
	$(FC) $(FFLAGS) cgiftest.f90 cgictest.obj -o cgiftest.cgi ${LIBS}

capture: capture.o libcgic.a
	$(CC) $(CFLAGS) capture.o -o capture ${LIBS}

clean:
	rm -rfv *.o *.obj *.a *.dSYM cgictest.cgi capture cgicunittest

test:
	$(CC) $(CFLAGS) -DUNIT_TEST cgic.c -o cgicunittest
	./cgicunittest
