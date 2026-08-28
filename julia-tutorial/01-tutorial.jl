# David
println("Hello, Julia!")

# Start adding tutorial code below.
count = 10
temperature = 21.5
course_name = "Introduction to Julia"
is_ready = true
complex_number = 3 + 4im

println(typeof(count))          # Int64
println(typeof(temperature))    # Float64
println(typeof(course_name))    # String
println(typeof(is_ready))       # Bool  
println(typeof(complex_number)) # Complex{Int64}

total = 7 + 3 * 2
area = 2.0^2 * pi
is_valid = total >= 10 && total !=0

println(total)