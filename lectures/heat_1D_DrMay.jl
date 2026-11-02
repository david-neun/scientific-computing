# -------------------------------------------------
# Numerical solution to the 1D heat equation
# The PDE is discretized across space (in 1D) into `n` interior nodes using the "method of lines"
# Updates to the next time step are performed with forward/backward Euler 
#   (Crank-Nicholson and Runga-Kutta are other options we did not discuss)
# For a linear PDE (like the heat equation), our Euler steps are computationally:
#   Forward : Matrix-vector multiplication
#   Backward : Solve a linear system
# ---------------------------------------------------

using LinearAlgebra, SparseArrays
using Plots

# -----------------------------
# Problem setup

# Our PDE is
#   u_t = k ⋅ u_xx; for 0 ≤ x ≤ L and t ≥ 0
# with boundary conditions
#   u(0,t) = a, u(L,t) = b
# and initial condition
#   u(x, 0) = u⁰(x)

k = 0.02; # Heat diffusion constant
L = 1.0; # Length
a = 2.0; b = 2.0; # Fixed boundary values
u⁰(x) = sin(2*pi*x) + 2; # Initial temp profile (generic function)

# Breaking our 1D space into n interior points with regular spacing h, 
# we get the system of equations
#   u⃗= k(Au - g)

n = 100; # Num of interior nodes
h = L / (n + 1) # Regular spacing
grid = h:h:(L-h); # Interior grid
u_0 = @. u⁰(grid)

plot(grid, u_0, title = "Initial temperature profile", xlabel = "x", ylabel = "u", legend = false)

# Negative stencil matrix 
A = (1/h^2) * spdiagm(
    -1 => fill(-1, n-1),
    0 => fill(2, n),
    1 => fill(-1, n-1)
)

# Boundary vector
g = zeros(n); g[1] = a / h^2; g[n] = b / h^2;


# ------------------------
# Forward Euler

Δt = 1e-3; # Time step
T = 2.0; # Simulate out to T seconds
nsteps = ceil(Int, T / Δt) # Number of steps required

u = zeros(n, nsteps+1); # Open up an empty matrix of states
u[:,1] .= u_0;

for i in 1:nsteps
    u_i = @view u[:,i]
    u_ip1 = @view u[:,i+1]
    u_ip1 .= u_i .+ (Δt*k) .* (g .- A*u_i) # Matrix-vector multiplication and vector-vector addition
end

plot_steps = 1:100:nsteps
plot(grid, u[:,plot_steps], title = "Temperature profile over time", xlabel = "x", ylabel = "u", legend = false)

# ------------------------
# Backward Euler

Δt = 1e-2; # Time step (Backward has better stability, larger step size. Try this with Forward and see what happens!)
T = 2.0; # Simulate out to T seconds
nsteps = ceil(Int, T / Δt) # Number of steps required

u = zeros(n, nsteps+1); # Open up an empty matrix of states
u[:,1] .= u_0;

M = I + Δt*k*A # Coeffecient matrix (SPD, tridiagonal)
Mchol = cholesky(M, perm = 1:n) # Precompute Cholesky; tridiagonal, so no permutation needed.
rhs = zeros(n) # Preallocate right hand side, rhs = u_i + Δt*k*g

for i in 1:nsteps
    u_i = @view u[:,i]
    u_ip1 = @view u[:,i+1]
    rhs .= u_i + Δt*k*g
    ldiv!(u_ip1, Mchol, rhs) # Same as u_ip1 .= Mchol \ rhs
end

plot_steps = 1:10:nsteps
plot(grid, u[:,plot_steps], title = "Temperature profile over time", xlabel = "x", ylabel = "u", legend = false)


# --------------------------------------
# Backward Euler with Matrix-free conjugate gradient
# Conjugate gradient only needs the operation M*x for any vector x

using IterativeSolvers # For conjugate gradient, `cg!`

struct HeatOperator{T}
    n :: Int # Number of interior nodes
    c :: T # c = Δt*k/h^2
end

# Define in-place multiplication for our struct
function LinearAlgebra.mul!(y::AbstractVector, M::HeatOperator, x::AbstractVector)
    @assert M.n == length(x)
    @assert M.n == length(y)
    y .= x
    y[1] += M.c * (2*x[1] - x[2])
    @inbounds for i in 1:(M.n-1)
        y[i] +=  M.c * (2*x[i] - x[i+1] - x[i-1])
    end
    y[M.n] += M.c * (2*x[M.n] - x[M.n-1])
    return y
end

# Size queries
Base.size(M::HeatOperator) = (M.n, M.n)
Base.size(M::HeatOperator, i::Int) = M.n

# ------------

Δt = 1e-2; # Time step 
M = HeatOperator(n, Δt*k*inv(h^2))

T = 2.0; # Simulate out to T seconds
nsteps = ceil(Int, T / Δt) # Number of steps required

u = zeros(n, nsteps+1); # Open up an empty matrix of states
u[:,1] .= u_0;

rhs = zeros(n) # Preallocate right hand side, rhs = u_i + Δt*k*g

for i in 1:nsteps
    u_i = @view u[:,i]
    u_ip1 = @view u[:,i+1]
    rhs .= u_i + Δt*k*g
    cg!(u_ip1, M, rhs; reltol = 1e-6)
end

plot_steps = 1:10:nsteps
plot(grid, u[:,plot_steps], title = "Temperature profile over time", xlabel = "x", ylabel = "u", legend = false)
