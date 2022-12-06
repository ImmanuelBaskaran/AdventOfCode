program Day6
integer :: Reason
integer :: length
character(len=:), allocatable :: a
character first
state = 0
!    reading in as a stream
inquire(file='./input.txt',size=length);
allocate(character(len=length) :: a)
open(1, file = './input.txt')
read(1,*,IOSTAT=Reason) a
close(1)
IF (Reason > 0)  THEN
    WRITE(*,*) 'Check input.  Something was wrong'
ELSE IF (Reason < 0) THEN
    WRITE(*,*) 'Somehow there is no marker'
ELSE
    do n = 1, length-3
        do j=0,3
            first = a(n+j:n+j)
            if(index(a(n+j+1:n+3),first)/=0) then
                exit
            end if
            if(j==3) then
                write(*,*) "Found Part 1"
                write(*,*) n+3
                goto 30
            end if
        end do
    end do

30 do n = 1, length-13
        do j=0,13
            first = a(n+j:n+j)
            if(index(a(n+j+1:n+13),first)/=0) then
                exit
            end if
            if(j==13) then
                write(*,*) "Found Part 2"
                write(*,*) n+13
                stop
            end if
        end do
    end do
END IF

end program
