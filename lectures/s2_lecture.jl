#####


#initialization
A = Matrix{Int64}(undef, 3, 3) # uninitialized 3x3 matrix of Int64
B = zeros(Int64, 3, 3) # 3x3 matrix of zeros
C = ones(Int64, 3, 3) # 3x3 matrix of ones
D = fill(7, 3, 3) # 3x3 matrix of sevens
Z = fill(1, 3, 3) # 3x3 matrix of ones
R = rand(3, 3) # 3x3 matrix of random numbers between 0 and 1
R1 = rand(1:10, 3, 3) # 3x3 matrix of random integers between 1 and 10
R2 = randm(float64, 3, 3) # 3x3 matrix of random numbers between 0 and 1


#broadcasting
B = A .+ 1 # add 1 to each element of A
C = A .* B # add A and B element-wise
D = (A.* B) .+ C # add the element-wise product of A and B to C
# macro @.
C = @.(A+B)+3

# broadcasting assignment
C = A 
#different that
@allocated C .= A # assign A to C, but does not allocate new memory
@allocated C .= A .+ 1 # add 1 to each element of A and assign to C
C .= 2.0


######
# functions
######


function my_quadratic(x)
    return x^2 + 2x + 1
end

result = my_quadratic(3)

function my_quadratic(x::Float32)
    return x^2 + 2x + 1
end

result = my_quadratic(3.0f0)

function my_quadratic(x::Real)
    return x^2 + 2x + 1
end


result = my_quadratic(3)

# promotions

function my_quadratic(x::T) where T<:Real
    return x^2 + 2x + 1
end

result = my_quadratic(3)


##############
# structs
##############

#dont do this, not performant, flexible, mutable, inheritance
struct the_line
    slope
    intercept
end

#performant, not flexible, immutable, no inheritance
struct LineFloat64
    slope::Float64
    intercept::Float64
end

#performant, not flexible, immutable, no inheritance
struct GenericLine{T}
    slope::T
    intercept::T
end

my_line = GenericLine{Float64}(2.0, 1.0)

# study 
 