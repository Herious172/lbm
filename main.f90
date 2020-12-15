program main
use vars
integer kstep
call init()
tt=0.0
kstep=1
do while (tt<=t_end)
	call getFeq()
	call collision()
	call streaming()
	call bc()
	call getMacro()	
	call output(kstep)
	kstep=kstep+1
	tt=tt+dt
enddo
call deallocateField()
print *, "done!"
end program
!----------------------------------------------------------------------------
subroutine getMacro() 
use vars
integer i,j,k

do i=1,ied
do j=1,jed-1
	rho(i,j)=0.0
	u(i,j)=0.0
	v(i,j)=0.0
	do k=0,Q
		rho(i,j)=rho(i,j)+f(k,i,j)
		u(i,j)=u(i,j)+ei(k,1)*f(k,i,j)
		v(i,j)=v(i,j)+ei(k,2)*f(k,i,j)
	enddo
	u(i,j)=u(i,j)/rho(i,j)
	v(i,j)=v(i,j)/rho(i,j)
enddo
enddo
j=jed
do i=2,ied-1
	rho(i,j)=f(0,i,j)+f(1,i,j)+f(3,i,j)+2*(f(2,i,j)+f(6,i,j)+f(5,i,j))
enddo

end subroutine
