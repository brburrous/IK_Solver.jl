# Type defining an equation
struct Equation
    lh
    rh
end

# Operator overloading for Equation data type
Base.:+(x::Equation, y::Equation) = Equation(x.lh+y.lh, x.rh+y.rh)
Base.:+(x::Equation, y) = Equation(x.lh+y, x.rh+y)
Base.:+(x, y::Equation) = Equation(x+y.lh, x+y.rh)

Base.:-(x::Equation, y::Equation) = Equation(x.lh-y.lh, x.rh-y.rh)
Base.:-(x::Equation, y) = Equation(x.lh-y, x.rh-y)
Base.:-(x, y::Equation) = Equation(x-y.lh, x-y.rh)

Base.:*(x::Equation, y::Equation) = Equation(x.lh*y.lh, x.rh*y.rh)
Base.:*(x::Equation, y) = Equation(x.lh*y, x.rh*y)
Base.:*(x, y::Equation) = Equation(x*y.lh, x*y.rh)

Base.:/(x::Equation, y::Equation) = Equation(x.lh/y.lh, x.rh/y.rh)
Base.:/(x::Equation, y) = Equation(x.lh/y, x.rh/y)
Base.:/(x, y::Equation) = Equation(x/y.lh, x/y.rh)

Base.:^(x::Equation, y) = Equation(x.lh^y, x.rh^y)

# Constructor for a tuple
Equation(x::Tuple) = Equation(x[1], x[2])
function Equation(A::Array, B::Array) 
    if size(A) == size(B)
        [Equation(x) for x in zip(A, B)]
    else
        error("size of matrices don't match")
    end
end

# Swaps left and right args of equation
flip(x::Equation) = Equation(x.rh, x.lh)

# Flips every equation in a matrix of Equations
flip(A::Matrix{Equation}) = [flip(x) for x in A]

# Constructor for equation 
function Equation(A::Vector)
    if length(A) == 2
        Equation(A[1], A[2])
    else
        error("vector needs two elements exactly")
    end
end