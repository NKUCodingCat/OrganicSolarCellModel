FC=gfortran
FCL=-O3 -static

.PHONY: all
all: rw vcal split solar utils
bin:
	mkdir bin

rw: rw/rw-serial.f90 | bin
	$(FC) $(FCL) rw/rw-serial.f90 -o bin/rw.exe

vcal: calv/transferintegral.f90 | bin
	$(FC) $(FCL) calv/transferintegral.f90 -o bin/calv.exe -lopenblas -llapack

split: gfilm/split.f90 gfilm/fileio.f90 | bin
	$(FC) $(FCL) gfilm/split.f90 gfilm/fileio.f90 -o bin/split.exe

solar: solar.out/commondat.f90 solar.out/subroutine.f90 solar.out/main.f90 | bin
	$(FC) $(FCL) solar.out/commondat.f90 solar.out/subroutine.f90 solar.out/main.f90 -o bin/solar.out.exe

utils: utils/mo.f90 utils/statistics.f90 | bin
	$(FC) $(FCL) utils/mo.f90 -o bin/mo.exe
	$(FC) $(FCL) utils/statistics.f90 -o bin/statistics.exe

clean:
	rm -f bin/*.exe