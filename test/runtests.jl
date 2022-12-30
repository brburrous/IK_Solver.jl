using Test
using IK_Solver.jl


@test true

DH = [1 1 1 1; 1 1 1 1];

R = Robot(DH)

@test R.DH == DH