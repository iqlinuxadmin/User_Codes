#### Purpose:

Example of calling FORTRAN executable from Python code. The specific example uses a Python script to call a compiled executable that sums up the integers from 1 to N where N is read from the command line.

#### Contents:

* <code>sum.f90</code>: FORTRAN source code
* <code>drive_sum.py</code>: Python source code
* <code>run.sbatch</code>: Batch-job submission script
* <code>test.out</code>: Output file

#### FORTRAN source code:

```fortran
!===========================================================
! NAME:    sum.f90
! PURPOSE: Computes sum of integers from 1 to N
! COMPILE:
! GNU:     gfortran -o sum.x sum.f90
! Intel:   ifort -o sum.x sum.f90
!
! USAGE:   ./sum.x -n <N>
!===========================================================
program sum
  implicit none
  integer(4)        :: i
  integer(4)        :: n
  integer(4)        :: isum
  character(len=10) :: op_n
  character(len=10) :: str_n

  call get_command_argument(1,op_n)
  call get_command_argument(2,str_n)

  if ( op_n /= '-n' ) then
     write(6,*) 'USAGE:'
     write(6,*) './sumx.x -n <N>'
     stop
  end if

  str_n  = trim(adjustl(str_n))

  read(str_n,*) n
  n = int(n)

  isum = 0
  do i = 1, n
     isum = isum + i
  end do
  write(6,'(a,1x,i4,1x,a3,1x,i4,a1)') 'The sum of integers from 1 to', n, 'is', isum, '.'
  !stop "End of program."
end program sum
```

#### Python source code:

```python
"""
Program: drive_sum.py
         Driver for sum.f90
"""
import subprocess
import numpy as np

for n in np.arange(1, 101):
    command = ["./sum.x", "-n", str(n)]
    subprocess.call( command )
```

#### Example batch-job submission script:

```bash
#!/bin/bash
#SBATCH -J test
#SBATCH -o test.out
#SBATCH -e test.err
#SBATCH -p shared
#SBATCH -N 1
#SBATCH -c 1
#SBATCH -t 0-00:30
#SBATCH --mem=4000

# Set up software environment
module load python/3.7.7-fasrc01
module load gcc/9.3.0-fasrc01

# Run program
srun -n 1 -c 1 python drive_sum.py
```

#### Example Usage:

```bash
# --- Load required modules ---
module load python/3.7.7-fasrc01
module load gcc/9.3.0-fasrc01
# --- Compile the FORTRAN source code ---
gfortran -o sum.x sum.f90 -O2
# --- Submit the job to the queue ---
sbatch run.sbatch
```

#### Example Output:

```
$ cat test.out
The sum of integers from 1 to    1  is    1.
The sum of integers from 1 to    2  is    3.
The sum of integers from 1 to    3  is    6.
The sum of integers from 1 to    4  is   10.
The sum of integers from 1 to    5  is   15.
The sum of integers from 1 to    6  is   21.
The sum of integers from 1 to    7  is   28.
The sum of integers from 1 to    8  is   36.
The sum of integers from 1 to    9  is   45.
The sum of integers from 1 to   10  is   55.
The sum of integers from 1 to   11  is   66.
The sum of integers from 1 to   12  is   78.
The sum of integers from 1 to   13  is   91.
The sum of integers from 1 to   14  is  105.
The sum of integers from 1 to   15  is  120.
The sum of integers from 1 to   16  is  136.
The sum of integers from 1 to   17  is  153.
The sum of integers from 1 to   18  is  171.
The sum of integers from 1 to   19  is  190.
The sum of integers from 1 to   20  is  210.
The sum of integers from 1 to   21  is  231.
The sum of integers from 1 to   22  is  253.
The sum of integers from 1 to   23  is  276.
The sum of integers from 1 to   24  is  300.
The sum of integers from 1 to   25  is  325.
The sum of integers from 1 to   26  is  351.
The sum of integers from 1 to   27  is  378.
The sum of integers from 1 to   28  is  406.
The sum of integers from 1 to   29  is  435.
The sum of integers from 1 to   30  is  465.
The sum of integers from 1 to   31  is  496.
The sum of integers from 1 to   32  is  528.
The sum of integers from 1 to   33  is  561.
The sum of integers from 1 to   34  is  595.
The sum of integers from 1 to   35  is  630.
The sum of integers from 1 to   36  is  666.
The sum of integers from 1 to   37  is  703.
The sum of integers from 1 to   38  is  741.
The sum of integers from 1 to   39  is  780.
The sum of integers from 1 to   40  is  820.
The sum of integers from 1 to   41  is  861.
The sum of integers from 1 to   42  is  903.
The sum of integers from 1 to   43  is  946.
The sum of integers from 1 to   44  is  990.
The sum of integers from 1 to   45  is 1035.
The sum of integers from 1 to   46  is 1081.
The sum of integers from 1 to   47  is 1128.
The sum of integers from 1 to   48  is 1176.
The sum of integers from 1 to   49  is 1225.
The sum of integers from 1 to   50  is 1275.
The sum of integers from 1 to   51  is 1326.
The sum of integers from 1 to   52  is 1378.
The sum of integers from 1 to   53  is 1431.
The sum of integers from 1 to   54  is 1485.
The sum of integers from 1 to   55  is 1540.
The sum of integers from 1 to   56  is 1596.
The sum of integers from 1 to   57  is 1653.
The sum of integers from 1 to   58  is 1711.
The sum of integers from 1 to   59  is 1770.
The sum of integers from 1 to   60  is 1830.
The sum of integers from 1 to   61  is 1891.
The sum of integers from 1 to   62  is 1953.
The sum of integers from 1 to   63  is 2016.
The sum of integers from 1 to   64  is 2080.
The sum of integers from 1 to   65  is 2145.
The sum of integers from 1 to   66  is 2211.
The sum of integers from 1 to   67  is 2278.
The sum of integers from 1 to   68  is 2346.
The sum of integers from 1 to   69  is 2415.
The sum of integers from 1 to   70  is 2485.
The sum of integers from 1 to   71  is 2556.
The sum of integers from 1 to   72  is 2628.
The sum of integers from 1 to   73  is 2701.
The sum of integers from 1 to   74  is 2775.
The sum of integers from 1 to   75  is 2850.
The sum of integers from 1 to   76  is 2926.
The sum of integers from 1 to   77  is 3003.
The sum of integers from 1 to   78  is 3081.
The sum of integers from 1 to   79  is 3160.
The sum of integers from 1 to   80  is 3240.
The sum of integers from 1 to   81  is 3321.
The sum of integers from 1 to   82  is 3403.
The sum of integers from 1 to   83  is 3486.
The sum of integers from 1 to   84  is 3570.
The sum of integers from 1 to   85  is 3655.
The sum of integers from 1 to   86  is 3741.
The sum of integers from 1 to   87  is 3828.
The sum of integers from 1 to   88  is 3916.
The sum of integers from 1 to   89  is 4005.
The sum of integers from 1 to   90  is 4095.
The sum of integers from 1 to   91  is 4186.
The sum of integers from 1 to   92  is 4278.
The sum of integers from 1 to   93  is 4371.
The sum of integers from 1 to   94  is 4465.
The sum of integers from 1 to   95  is 4560.
The sum of integers from 1 to   96  is 4656.
The sum of integers from 1 to   97  is 4753.
The sum of integers from 1 to   98  is 4851.
The sum of integers from 1 to   99  is 4950.
The sum of integers from 1 to  100  is 5050.
```
