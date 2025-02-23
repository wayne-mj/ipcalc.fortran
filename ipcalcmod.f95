module ipcalcmod
    implicit none

    ! Define a derived type to store an IP address
    ! and its subnet mask, network address, and broadcast address
    type :: ipaddresstype
        integer :: ip1, ip2, ip3, ip4
        integer :: mask1, mask2, mask3, mask4
        integer :: net1, net2, net3, net4
        integer :: bc1, bc2, bc3, bc4
        character(len=32) :: ipstr, maskstr, netstr, bcstr
    end type ipaddresstype

    character(len=1), parameter :: dot = "."
    logical :: errorflag = .false.

    contains
    
    ! Subroutines to calculate the network and broadcast addresses
    subroutine BroadcastAddress(ip) 
        type(ipaddresstype), intent(inout) :: ip
        
        ip%bc1 = ior(ip%net1, ieor(ip%mask1,255))       ! OR then XOR with 255
        ip%bc2 = ior(ip%net2, ieor(ip%mask2,255))       ! OR then XOR with 255
        ip%bc3 = ior(ip%net3, ieor(ip%mask3,255))       ! OR then XOR with 255
        ip%bc4 = ior(ip%net4, ieor(ip%mask4,255))       ! OR then XOR with 255

        ip%bcstr = trim(adjustl(int2str(ip%bc1)))//dot//trim(adjustl(int2str(ip%bc2)))//dot//trim(adjustl(int2str(ip%bc3)))//dot//trim(adjustl(int2str(ip%bc4)))

    end subroutine BroadcastAddress

    subroutine NetworkAddress(ip) 
        type(ipaddresstype), intent(inout) :: ip
        
        ip%net1 = iand(ip%ip1, ip%mask1)                ! AND operation
        ip%net2 = iand(ip%ip2, ip%mask2)                ! AND operation
        ip%net3 = iand(ip%ip3, ip%mask3)                ! AND operation
        ip%net4 = iand(ip%ip4, ip%mask4)                ! AND operation

        ip%netstr = trim(adjustl(int2str(ip%net1)))//dot//trim(adjustl(int2str(ip%net2)))//dot//trim(adjustl(int2str(ip%net3)))//dot//trim(adjustl(int2str(ip%net4)))
    end subroutine NetworkAddress

    ! Subroutines to parse IP address and subnet mask strings
    subroutine ParseIPString(dotstring, ip) 
        type(ipaddresstype), intent(inout) :: ip
        character(len=32), intent(in) :: dotstring
        integer :: lenstr
        integer :: dots(3)

        lenstr = len_trim(dotstring)
        dots = getdots(dotstring)
        
        if (dots(1) .ne. -1) then
            read(dotstring(1:dots(1)-1),*) ip%ip1           ! Read the first part of the string
            read(dotstring(dots(1)+1:dots(2)-1),*) ip%ip2   ! Read the second part of the string
            read(dotstring(dots(2)+1:dots(3)-1),*) ip%ip3   ! Read the third part of the string       
            read(dotstring(dots(3)+1:lenstr),*) ip%ip4      ! Read the fourth part of the string

            ip%ipstr = dotstring
        else
            errorflag = .true.
            print *, "Error: Invalid IP address"
            stop
        end if
    end subroutine ParseIPString

    subroutine ParseMaskString(dotstring, ip) 
        type(ipaddresstype), intent(inout) :: ip
        character(len=32), intent(in) :: dotstring
        integer :: lenstr
        integer :: dots(3)

        lenstr = len_trim(dotstring)
        dots = getdots(dotstring)
        
        if (dots(1) .ne. -1) then
            read(dotstring(1:dots(1)-1),*) ip%mask1         ! Read the first part of the string
            read(dotstring(dots(1)+1:dots(2)-1),*) ip%mask2 ! Read the second part of the string
            read(dotstring(dots(2)+1:dots(3)-1),*) ip%mask3 ! Read the third part of the string
            read(dotstring(dots(3)+1:lenstr),*) ip%mask4    ! Read the fourth part of the string

            ip%maskstr = dotstring
        else
            errorflag = .true.
            print *, "Error: Invalid subnet mask"
            stop
        end if
    end subroutine ParseMaskString

    ! Find the position of the dots in the string
    function getdots(dotstring) result(dots)
        character(len=32), intent(in) :: dotstring
        integer :: dots(3)
        integer :: lenstr, i, count

        count = 1
        lenstr = len_trim(dotstring)
        do i =1, lenstr
            if(dotstring(i:i) == dot) then
                dots(count) = i
                count = count + 1
            end if
        end do

        if (count .ne. 4) then
            dots(1) = -1
        end if
    end function getdots

    function int2str(input) result(str)
        integer, intent(in) :: input
        character(len=32) :: str

        write(str,'(I0)') input
    end function int2str

end module ipcalcmod