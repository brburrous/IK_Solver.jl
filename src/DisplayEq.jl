function shorten_exp(exp)
    # regex for extracting args from sin and cos
    trig_arg = r"(?<=cos|sin)\(.+?\)"


    exp1 = replace(exp, trig_arg=>thetaReplace)
    exp2 = replace(exp1, "cos" => "c", "sin" => "s", "sqrt(2)"=>"\\sqrt{2}", "*"=> " \\cdot ")
end

# returns comma seperated numbers corresponding to theta vals
function thetaReplace(str)
    str_cpy = str
    str_cpy = Base.split(str_cpy, !isnumeric, keepempty=false)
    strfin = reduce((x,y)->x*","*y, string.(str_cpy))
    "_{"*strfin*"}"
end


shortEq(exp) = exp |> string |> shorten_exp


shortEq(E::Equation) = shortEq(E.lh)*" = "*shortEq(E.rh)


printEq(exp) = shortEq(exp) |> latexstring


function printEq(M::Array{Equation}) 
    A = simplify.([x.lh for x in M])
    B = simplify.([x.rh for x in M])
    latexTable2(printEq.(A), printEq.(B))
end


function Base.show(io::IO,  ::MIME"text/latex", Eq::Equation)
	show(io, MIME"text/latex"(), printEq(Eq))
end


function Base.show(io::IO,  ::MIME"text/latex", Eq::Array{Equation})
	show(io, MIME"text/latex"(), printEq(Eq))
end


function latexTable2(A::Array{LaTeXString}, B::Array{LaTeXString},)
    A2 = oneTable(A)
    B2 = oneTable(B)

    L"\begin{equation}
    \left[
    \begin{array}{}
    %$A2
    \end{array}
    \right]
    =
    \left[
    \begin{array}{}
    %$B2
    \end{array}
    \right]
    \end{equation}
    "
end

function oneTable(A::Matrix{LaTeXString})
	B = strip.(String.(A), ['$'])
	C = [reduce((x,y) -> x*" & "*y, B[i, :]) for i = 1:size(B, 1)]
	D = reduce((x, y) -> x*" \\\\ "*y, C)
end