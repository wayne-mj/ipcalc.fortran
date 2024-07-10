program ipcalc
    use ipcalcmod
    implicit none
    
    type(ipaddresstype) :: ip1
    character(len=32):: ipstr, maskstr

    ! Set a default that can be displayed as a guide
    ipstr = "192.168.0.10"
    maskstr = "255.255.240.0"

    print *, "Enter IP Address (eg ", trim(adjustl(ipstr)), "): "
    read(*,*) ipstr
    
    print *, "Enter Subnet Mask (eg ", trim(adjustl(maskstr)), "): "
    read(*,*) maskstr
    
    call ParseIPString(ipstr, ip1)
    call ParseMaskString(maskstr, ip1)
    call NetworkAddress(ip1)
    call BroadcastAddress(ip1)

    print *, "IP Address = ", ip1%ip1, ".", ip1%ip2, ".", ip1%ip3, ".", ip1%ip4
    print *, "Subnet Mask = ", ip1%mask1, ".", ip1%mask2, ".", ip1%mask3, ".", ip1%mask4
    print *, "Network Address = ", ip1%net1, ".", ip1%net2, ".", ip1%net3, ".", ip1%net4
    print *, "Broadcast Address = ", ip1%bc1, ".", ip1%bc2, ".", ip1%bc3, ".", ip1%bc4

    print *, "IP Address = ", ip1%ipstr
    print *, "Subnet Mask = ", ip1%maskstr
    print *, "Network Address = ", ip1%netstr
    print *, "Broadcast Address = ", ip1%bcstr

    contains

end program ipcalc