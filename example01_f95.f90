PROGRAM example01

    use shadow_globaldefinitions
    use shadow_beamio
    use shadow_variables
    use shadow_kernel
    use shadow_synchrotron

	implicit none
	type (poolSource)   :: src
	type (poolOE)       :: oe1
	real(kind=skr), allocatable, dimension(:,:) :: ray
	integer(kind=ski)   :: ierr

	! load variables from start.00
	CALL PoolSourceLoad(src,"start.00")
	print *,'Number of rays: ',src%npoint
	src%npoint=100000
	print *,'Number of rays (modified): ',src%npoint

	! allocate ray
	ALLOCATE( ray(18,src%npoint) )

	! calculate source
	CALL SourceSync(src,ray,src%npoint)
        call beamWrite(ray,ierr,18,src%npoint,"begin.dat")
	! reads start.01 into oe1
	call PoolOELoad(oe1,"start.01")
	! traces OE1
	call TraceOE(oe1,ray,src%npoint,1)

	! write file star.01
	CALL beamWrite(ray,ierr,18,src%npoint,"star.01")
    DEALLOCATE(ray)

END PROGRAM example01
