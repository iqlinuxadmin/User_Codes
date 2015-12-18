#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Program: pi_monte_carlo.jl
#          Monte-Carlo calculation of PI
#
# Usage: julia pi_monte_carlo.jl
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function montepi(n)
   R = 1.0
   s = 0
   for i = 1: n
      x = R * rand()
      y = R * rand()
      if x^2 + y^2 <= R^2
         s = s + 1
      end
   end
   return 4.0*s/n
end

# Main program
for n in 10.^(3:8)
    p = montepi(n)
    println("N = $n: PI = $p")
end
