mkdir bin
cd bin
gfortran -O3 ../g09log.f90 -o g09log.exe -static
gfortran -O3 ../calv/transferintegral.f90 -o calv -lopenblas -llapack -static
gfortran -O3 ../gfilm/split.f90 ../gfilm/fileio.f90 -o split -static