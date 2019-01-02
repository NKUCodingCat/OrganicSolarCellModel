program dis
  implicit none
  real(8)::a,b,c, v,hmax,lmax,hmin,lmin,ldelta,hdelta
  character(20):: fname
  real(8)::thm(1000),tlm(1000),nc,nv
  real(8),allocatable::hm(:),lm(:)
  integer::i,h(10),l(10),n,nm
  
  if (iargc()==2) then 
    call getarg(1,fname) 
    call system('tail -1 '//fname//'> tmp.tmp') 
  
    call getarg(2,fname)
    read(fname,*) nm
  else if (iargc()==1) then 
  call system('tail -1  tmp.gro > tmp.tmp') 
    call getarg(1,fname)
    read(fname,*) nm
  else 
     write(*,*) "input parameter missing,stop"!    ch1(ii)=c(ii,imol1)
     write(*,*) "tmp.gro, number of the first molecule" ! cl1(ii)=c(ii,imol1+1) !! add by Yecheng Zhou
     stop
  end if 
  
 open(unit=91,file='tmp.tmp',status='old',err=911)
 read(91,*) a,b,c  ! unit is nm , size of the box
 close(91)
 
 v=a*b*c ! nm^3
 ! v=v*1.0e-21 ! cm^3
 !v=1/v
 v=1.0e+21/v
 i=0 
 
 open(unit=92,file='mo.log',status='old',err=921) 
 do while(.true.)
    i=i+1
    read(92,*,err=922,end=923) 
    read(92,*,err=922) 
    read(92,*,err=922) thm(i),tlm(i),thm(i),tlm(i)
!    write(*,'(i5x,2(f7.4x))') i, thm(i),tlm(i)
 end do 
 stop 
923 n=i-1
write(*,*) "mo.log reached the end"
write(*,*) "Molecule numbers:", n
close(92)

allocate(hm(n),lm(n))
hm(1:n)=thm(1:n);
lm(1:n)=tlm(1:n)


 hmax=maxval(hm(1:nm));  lmax=maxval(lm(1:nm))
 hmin=minval(hm(1:nm));  lmin=minval(lm(1:nm))
  hdelta=0.1*(hmax-hmin); ldelta=0.1*(lmax-lmin) 
 write(*,*) "Molecule 1"
 write(*,'(3(f7.4x))') hmax, hmin, hdelta
 write(*,'(3(f7.4x))') lmax, lmin,ldelta
 
nc=0;nv=0
 h=0;l=0 
 open(unit=94,file='modis.dat',status='replace') 
 open(unit=93,file='mo1.dat',status='replace') 
 do i=1,nm
 !write(*,*) floor((hm(i)-hmin)/hdelta),floor((lm(i)-lmin)/ldelta)
    h(floor((hm(i)-hmin)/hdelta))=h(floor((hm(i)-hmin)/hdelta))+1
    nv=nv+2*exp((hm(i)-hmax)/0.026)
    
    l(floor((lm(i)-lmin)/ldelta))=l(floor((lm(i)-lmin)/ldelta))+1
    nc=nc+2*exp((lmin-lm(i))/0.026)
     write(93,'(i5x,2(f7.4x))') i, thm(i),tlm(i)
 end do 
   write(94,'(a)') 'First molecule'
   write(94,'(2(aX,e12.5x))') 'Nv',nv*v,'Nc',nc*v
   write(*,'(2(aX,e12.5x))') 'Nv',nv*v,'Nc',nc*v
   
do  i=1,10
   write(94,'(2(F8.5X,I4X))') hmin+(i-0.5)*hdelta, h(i), lmin+(i-0.5)*ldelta,l(i)
   write(*,'(2(F8.5X,I4X))') hmin+(i-0.5)*hdelta, h(i), lmin+(i-0.5)*ldelta,l(i)
end do 

close(93)


if (n> nm) then 
open(unit=93,file='mo2.dat',status='replace')
 hmax=maxval(hm(nm+1:n));  lmax=maxval(lm(nm+1:n))
 hmin=minval(hm(nm+1:n));  lmin=minval(lm(nm+1:n))
  hdelta=0.1*(hmax-hmin); ldelta=0.1*(lmax-lmin) 
write(*,*) "Molecule 2"
 write(*,'(3(f7.4x))') hmax, hmin, hdelta
 write(*,'(3(f7.4x))') lmax, lmin,ldelta
nc=0;nv=0
 h=0;l=0 
 do i=nm+1,n
 !write(*,*) floor((hm(i)-hmin)/hdelta),floor((lm(i)-lmin)/ldelta)
    h(floor((hm(i)-hmin)/hdelta))=h(floor((hm(i)-hmin)/hdelta))+1
    nv=nv+2*exp((hm(i)-hmax)/0.026)
    l(floor((lm(i)-lmin)/ldelta))=l(floor((lm(i)-lmin)/ldelta))+1
     nc=nc+2*exp((lmin-lm(i))/0.026)
     write(93,'(i5x,2(f7.4x))') i, thm(i),tlm(i)
 end do 
    write(94,'(a)') 'Second molecule'
    write(94,'(2(aX,e12.5x))') 'Nv',nv*v,'Nc',nc*v
    write(*,'(2(aX,e12.5x))') 'Nv',nv*v,'Nc',nc*v
    
do  i=1,10
    write(94,'(2(F8.5X,I4X))') hmin+(i-0.5)*hdelta, h(i), lmin+(i-0.5)*ldelta,l(i)
    write(*,'(2(F8.5X,I4X))') hmin+(i-0.5)*hdelta, h(i), lmin+(i-0.5)*ldelta,l(i)
end do 
close(93)
end if 
close(94)
stop 

911 write(*,*) "tmp.tmp not exist"
close(91)
921 write(*,*) "mo.log not exist"
922 write(*,*) "read mo.log error"
close(92)

end program dis
