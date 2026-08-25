# Julia Tutorial

This repository is a quick introduction to the most useful building blocks of
the Julia programming language. The examples below can be copied into
[`julia-tutorial/01-tutorial.jl`](julia-tutorial/01-tutorial.jl) and run with:

```bash
julia julia-tutorial/01-tutorial.jl
```

## Installing Julia

Download Julia from the official website: [julialang.org/downloads](https://julialang.org/downloads/).
Choose the current stable release for your operating system and follow the
installer instructions.

### macOS

The easiest option is to download and open the macOS installer (`.dmg`) from
the Julia downloads page. Alternatively, install Julia with Homebrew:

```bash
brew install --cask julia
```

### Windows

Download the Windows installer (`.exe`) from the Julia downloads page. During
installation, enable the option to add Julia to your `PATH` if it is offered.

### Linux

The official installer can be run from a terminal:

```bash
curl -fsSL https://install.julialang.org | sh
```

Restart your terminal after installation, then verify that Julia is available:

```bash
julia --version
```

You should see the installed Julia version, for example `julia version 1.x.x`.
Start the Julia interactive REPL by running `julia`, or execute this tutorial
file directly:

```bash
julia julia-tutorial/01-tutorial.jl
```

For VS Code, install the **Julia** extension published by the Julia Language
Organization. It provides syntax highlighting, code execution, the Julia REPL,
debugging, and notebook support. Open the Command Palette and run **Julia:
Start REPL** to begin an interactive session.

## 1. Input and output

Use `println` to display values. Use `print` when a newline is not wanted, and
`readline` to read text typed by the user. `parse` converts text to a number.

```julia
println("Hello, Julia!")
print("What is your name? ")
name = readline()
println("Hello, $name")

print("Enter your age: ")
age = parse(Int, readline())
println("Next year you will be $(age + 1).")
```

## 2. Variables, assignment, and types

Assignment uses `=`. Variable names are conventionally written in `snake_case`,
and Julia can infer the type from the assigned value. Use `typeof` to inspect a
value and `::Type` for an optional type annotation or assertion.

```julia
count = 10                 # Int
temperature = 21.5        # Float64
course_name = "Scientific Computing"  # String
is_ready = true            # Bool
complex_number = 2 + 3im   # Complex

println(typeof(count))
count::Int = 11
```

Julia is dynamically typed, but types help document intent and enable fast
compiled code. Constants can be declared with `const` when a binding should not
be reassigned.

## 3. Operators and basic expressions

Julia supports arithmetic, comparison, and logical operators. Multiplication
must be written explicitly with `*`; `^` is exponentiation.

```julia
total = 7 + 3 * 2
area = 2.0^2 * pi
is_valid = total >= 10 && total != 0

println("total = $total")
println("area = $area")
println(is_valid ? "valid" : "invalid")
```

## 4. Conditionals

Use `if`, `elseif`, and `else` to select between branches. The compact ternary
operator is useful for a simple two-way choice.

```julia
score = 87

if score >= 90
	grade = 'A'
elseif score >= 80
	grade = 'B'
else
	grade = 'C'
end

status = score >= 60 ? "passed" : "failed"
println("Grade: $grade ($status)")
```

## 5. Loops

`for` iterates over collections or ranges. `while` repeats while a condition is
true. Use `break` to stop early and `continue` to skip to the next iteration.

```julia
sum_of_squares = 0
for number in 1:5
	sum_of_squares += number^2
end

countdown = 3
while countdown > 0
	println(countdown)
	countdown -= 1
end
println("Sum of squares: $sum_of_squares")
```

## 6. Arrays: vectors and matrices

Vectors are one-dimensional arrays, and matrices are two-dimensional arrays.
Julia uses one-based indexing. A colon creates a range, and `A * B` performs
matrix multiplication.

```julia
numbers = [10, 20, 30, 40]     # Vector{Int}
numbers[2] = 25
println(numbers[1:3])

matrix = [1 2; 3 4]             # 2 x 2 Matrix{Int}
println(matrix[1, 2])
println(matrix * [5, 6])
println(sum(numbers))
```

## 7. Dictionaries, tuples, and named tuples

Tuples group fixed-position values. Dictionaries map keys to values, and named
tuples provide readable field names for a small immutable record.

```julia
point = (3, 4)
student = (name = "Ava", score = 95)
grades = Dict("Ava" => 95, "Noah" => 88)

println(point[1])
println(student.name)
println(grades["Ava"])
```

## 8. Defining and calling functions

Functions are declared with `function ... end` or with a short assignment form.
The last expression is returned automatically. Julia functions can have methods
for different argument types, a feature called multiple dispatch.

```julia
function average(values)
	return sum(values) / length(values)
end

square(x) = x^2

println(average([2, 4, 6]))
println(square(5))
```

## 9. Structs: Julia's class-like data types

Julia does not use classes in the traditional object-oriented sense. Use a
`struct` to define a composite type, then define functions that operate on it.
`mutable struct` allows fields to change after construction; ordinary `struct`
values are immutable.

```julia
struct Rectangle
	width::Float64
	height::Float64
end

area(rectangle::Rectangle) = rectangle.width * rectangle.height

shape = Rectangle(3.0, 4.0)
println(area(shape))
```

## 10. Broadcasting, comprehensions, and useful packages

Broadcasting applies an operation element by element with a dot, such as `.*`
or `sqrt.`. Comprehensions provide a compact way to build arrays. External
packages are loaded with `using` after they have been installed with `] add` in
the Julia package manager.

```julia
values = [1, 4, 9, 16]
roots = sqrt.(values)
even_squares = [number^2 for number in 1:6 if iseven(number)]

println(roots)
println(even_squares)

# In the Julia package manager (press ] in the Julia REPL):
# ] add Example
# Then in Julia code:
# using Example
```

These ten topics cover the syntax needed to begin experimenting with numerical
and scientific programs. Next steps include modules, file I/O, exceptions,
testing, and specialized packages such as `LinearAlgebra`.
