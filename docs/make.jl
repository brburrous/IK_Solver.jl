using Documenter
using IK_Solver

makedocs(
    sitename = "IK_Solver",
    format = Documenter.HTML(),
    modules = [IK_Solver]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
