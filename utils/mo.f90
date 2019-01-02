program MO
  implicit none
  character(20):: fname
  character(27)::tmp1
  character(79)::tmp
  character(9)::val
  real:: hm,lm 
  if (iargc()/=1) then 
     write(*,*) "input parameter missing,stop"!    ch1(ii)=c(ii,imol1)
     write(*,*) "log-filename" ! cl1(ii)=c(ii,imol1+1) !! add by Yecheng Zhou
     stop
  end if 
  
  call getarg(1,fname)


 open(unit=99,file=fname,status='old',err=9993)

  do while(.true.)
    read(99,'(a27)') tmp1
    
    if(tmp1 .eq.' Alpha virt. eigenvalues --') then 
       backspace(99) 
       backspace(99) 
       read(99,'(a79)') tmp
       write(*,*) tmp 
       val=tmp((len(trim(tmp))-8):(len(trim(tmp))+2))
       read(val,*) hm
       
       read(99,'(a79)') tmp
       write(*,*) tmp 
       val=tmp(30:39)
       read(val,*) lm
       
       exit
    end if 
  enddo
 write(*,"(4(f10.6x))") hm,lm,27.2*hm,27.2*lm 
stop 
9993 write(*,*) "not exist"

end program MO 
