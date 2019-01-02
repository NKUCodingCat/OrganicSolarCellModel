mkdir bin
cd bin
gfortran -O3 ../g09log.f90 -o g09log.exe -static
gfortran -O3 ../calv/transferintegral.f90 -o calv -lopenblas -llapack -static
gfortran -O3 ../gfilm/split.f90 ../gfilm/fileio.f90 -o split -static
gfortran -O3 ../rw/rw_serial.f90 -o rw -static
gfortran -O3 ../solar.out/commondat.f90 ../solar.out/subroutine.f90 ../solar.out/main.f90  -o solar.out -static 