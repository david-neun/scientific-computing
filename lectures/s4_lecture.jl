# topic: Catastrophic Cancellation
# the catastrophic cancellation occurs when we subtract two nearly equal numbers, which can lead to a significant loss of precision in numerical computations. In this case, the expression (1e+14) + 1 - (1e-14) can be simplified to 1e+14 + 1 - 1e-14, which is approximately equal to 1e+14 + 1. However, due to the limitations of floating-point arithmetic, the result may not be accurate.
# the professor did f(x) = x^2

# lets do the derivative of the function f(x) = x^2 + 3x + 2 creating a function that takes in a function and returns its derivative using the limit definition of a derivative.
function derivative(f, x, h=1e-8)
    return (f(x + h) - f(x)) / h
end

#now lets evaluate the derivative of f(x) = x^2 + 3x + 2 at x = 1
f(x) = x^2 + 3x + 2
x = 1
dfdx = derivative(f, x)
println("The derivative of f(x) at x = $x is $dfdx")

# run this command on Julia> ] add Plots
using Plots
# plot the function f(x) and its derivative



## Now let's plot the function f(x) and its derivative
x_vals = -10:0.1:10
f_vals = f.(x_vals)
dfdx_vals = derivative.(f, x_vals)



# Algebra to avoid catastrophic cancellation in the derivative calculation
# The derivative of f(x) = x^2 + 3x + 2 is f'(x) = 2x + 3. Let's define this function and compare it to the numerical derivative we calculated.
function analytical_derivative(x)
    return 2x + 3
end


# now lets solve this problem
# (1e+14)+1-(1e-14) = 1e+14 + 1 - 1e-14 = 1e+14 + 1 