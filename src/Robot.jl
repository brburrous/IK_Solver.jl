# Type that defines a serial Robot
# With DH parameters "DH" and target end effector position "target"

struct Robot
    DH::Array
    target
    # Ts
end
# DH table follows format: DH(a, α, d, θ)

# Constructor with standard target matrix
function Robot(DH::Array)
    A = Sym.([
    "r₁₁" "r₁₂" "r₁₃" "p_x"
    "r₂₁" "r₂₂" "r₂₃" "p_y"
    "r₃₁" "r₃₂" "r₃₃" "p_z"
    ])
    B = [0 0 0 1]
    target = vcat(A, B)
    Robot(DH, target)
end


sympy.simplify(E::Equation) = Equation(sympy.simplify(E.lh), sympy.simplify(E.rh))