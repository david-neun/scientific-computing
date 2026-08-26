############
# lecture 1
############

#basic assignment and working in the REPS (read, execute, print, show) environment
x = 5;
println(x)
typeof(x)

a = 2.0
typeof(a)

a_static :: Int32 = 2
typeof(a_static)

const pi = 3.14
typeof(pi)

mybool = true
my_bool = false
typeof(mybool)

my_boolean_1 = 5 > 2
my_boolean_2 = 0 < 3

combined_boolean = my_boolean_1 && my_boolean_2
combined_boolean_2 = my_boolean_1 || my_boolean_2

################################
# Basic mathematical operations
################################

result = 5 + 3
result = 5 - 3
result = 5 * 3
result = 5 / 3
result = 5 ^ 3

result = 5 % 3 #floor division, gives int
result = 5 ÷ 3 #floor division, gives int 
result = 5 // 3 #gives rational number

########################
# unicode support
# you can use unicode characters in variable names
# for example, you can use greek letters like α, β, γ, etc.
# you can also use subscripts and superscripts in variable names
# for example, you can use x₁, x₂, x₃, etc
# you can also use emojis in variable names
# for example, you can use 🐶, 🐱, 🐭,
# etc. but it is not recommended to use emojis in variable names 😂

σ = 5.0
μ = 2.0

λ = "😂"


######
# vector, matrix, and array operations
#######

v = [1, 2, 3, 4, 5]
v = [1; 2; 3; 4; 5]
v2 = [1.0, 2.0, 3.0, 4.0, 5.0]
typeof(v)
ndims(v)

### david exploring
super_integer :: Int128 = 1234567890123456789012345678901234567890

v[1]
v[2]
v[3]
v[4]
v[5]

# matrices are 2D arrays
m = [1 2 3; 4 5 6; 7 8 9]
m2 = [1.0 2.0 3.0; 4.0 5.0 6.0; 7.0 8.0 9.0]
typeof(m)
ndims(m)

A = [1 2 3; 4 5 6; 7 8 9]
A[1, 1]
A[:,1]
A[:,2:3]


size(A)
length(A)


nrow, ncol = size(A)

a,b,c = 1.0

##############################
# mutable and immutable types
##############################

A = [1 2 3; 4 5 6; 7 8 9]

B = A # same data, same memory location
B = copy(A) # new data, new memory location

#slices and views
A=[1 2 3; 4 5 6; 7 8 9]
acol = A[:, 1] # slice, new data, new memory location
acol[1] = 100 # does not change A

acol[1] = @view A[:, 1] # view, same data, same memory location
acol[1] = view(A, :, 1) # view, same data, same memory location

acol[1] = 100 # changes A

#######
# if / else statements
#######

if 5 > 3
    println("5 is greater than 3")
else
    println("5 is not greater than 3")
end


#no additional scope for if statements, so variables defined inside the if statement are accessible outside of it

if 5 > 3
    new_variable = 10
end

#####################
# for / while loops
#####################

for i in 1:5
    println(i)
end

#but loops have soft scope, so variables defined inside the loop are not accessible outside of it
for i in 1:5
    new_loop_variable = i
end