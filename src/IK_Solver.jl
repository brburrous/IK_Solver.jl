module IK_Solver

using SymPy
using LaTeXStrings


include("Robot.jl")
include("Equation.jl")
include("HelperFunctions.jl")
include("DisplayEq.jl")
include("Rotation.jl")


greet() = print("Hello World!")

export Robot
export split
export rotx, roty, rotz
export flip


end # module IK_Solver
