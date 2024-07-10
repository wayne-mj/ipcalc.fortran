FC=gfortran
FFLAGS=-O3 -Wall -Wextra
AR=ar
ARARGS=r
MODULES=ipcalcmod.f95
PROG=ipcalc.f95
SRC=$(MODULES) $(PROG)
OBJ=${SRC:.f95=.o}
BASE=${SRC:.f95=}

all: clean lib $(PROG:.f95=)

%.o: %.f95
	$(FC) $(FFLAGS) -o $@ -c $<

$(PROG:.f95=): $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

lib: $(MODULES)
	$(FC) $(FFLAGS) -c $(MODULES)

dist: clean lib $(MODULES)
	$(AR) $(ARARGS) $(PROG:.f95=.a) $(MODULES:.f95=.o)

clean:
	rm -f *.o *.mod $(BASE) *.a
