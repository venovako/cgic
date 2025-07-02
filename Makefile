ifdef NDEBUG
CFLAGS=-O$(NDEBUG) -DNDEBUG
else # !NDEBUG
CFLAGS=-Og -ggdb3 -DCGICDEBUG
endif # ?NDEBUG
ifndef MARCH
MARCH=native
endif # !MARCH
CFLAGS += -march=$(MARCH) -fPIC -fexceptions -fasynchronous-unwind-tables -fno-omit-frame-pointer -pthread -Wall
FFLAGS=$(CFLAGS)
CC=gcc$(GNU)
FC=gfortran$(GNU)
AR=ar
RANLIB=ranlib
#static link on Linux: set STATIC to -static -s
ifndef STATIC
STATIC=-rdynamic
endif # !STATIC
LIBS=$(STATIC) -L. -lcgic

all: libcgic.a cgictest.cgi cgiftest.cgi who_ex.cgi capture

omp: omp_ex.cgi

install: libcgic.a
	cp libcgic.a /usr/local/lib
	cp cgic.h /usr/local/include
	@echo libcgic.a is in /usr/local/lib
	@echo cgic.h is in /usr/local/include

libcgic.a: cgic.o cgic.h
	rm -f libcgic.a
	$(AR) rc libcgic.a cgic.o
	$(RANLIB) libcgic.a

#mingw32 and cygwin users: replace .cgi with .exe

cgictest.cgi: cgictest.o libcgic.a
	$(CC) $(CFLAGS) cgictest.o -o cgictest.cgi ${LIBS}

cgictest.obj: cgictest.c
	$(CC) $(CFLAGS) -DCGICNOMAIN cgictest.c -c -o cgictest.obj

cgiftest.cgi: cgictest.obj libcgic.a
	$(FC) $(FFLAGS) cgiftest.f90 cgictest.obj -o cgiftest.cgi ${LIBS}

who_ex.cgi: who_ex.c libcgic.a
	$(CC) $(CFLAGS) who_ex.c -o who_ex.cgi ${LIBS}

omp_ex.cgi: omp_ex.c libcgic.a
	$(CC) $(CFLAGS) -fopenmp omp_ex.c -o omp_ex.cgi ${LIBS}

capture: capture.o libcgic.a
	$(CC) $(CFLAGS) capture.o -o capture ${LIBS}

clean:
	rm -rfv *.o *.obj *.a *.dSYM *.cgi capture cgicunittest

test:
	$(CC) $(CFLAGS) -DUNIT_TEST cgic.c -o cgicunittest
	./cgicunittest
