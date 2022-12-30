function Transform(α, a, d, θ)
    [
        cos(θ) 			-sin(θ) 		0 		a
        sin(θ)*cos(α) 	cos(θ)*cos(α) 	-sin(α)	-sin(α)*d
        sin(θ)*sin(α) 	cos(θ)*sin(α) 	cos(α) 	cos(α)*d
        0 				0 				0 		1
    ]
end


Transform(V::Vector) = Transform(V...)



function transforms(dh)
    [Transform(dh[i, :]) for i = 1:size(dh)[1]]
end



transforms(A::Robot) = transforms(A.DH)



function inverse(hT)
    r = hT[1:3, 1:3]
    r_trans = [r[j,i] for i = 1:3, j = 1:3]
    p = hT[1:3, 4]
    p_trans = [-r_trans*p; 1]
    hcat(vcat(r_trans, [0 0 0]), p_trans)
end



function split(Ts::Vector, i, target)
    if i != 0
        invT = [inverse(Ts[j]) for j = i:-1:1]
        lh = reduce(*, invT)*target
        lh = sympy.simplify.(lh)
        rh = sympy.simplify.(reduce(*, Ts[i+1:end]))
    else
        rh = reduce(*, Ts)
        rh = sympy.simplify.(rh)
        lh = target
    end
    return [lh, rh]
end



split(A::Robot, i) = Equation(split(transforms(A), i, A.target))