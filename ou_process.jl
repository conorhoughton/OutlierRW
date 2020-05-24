
using Random

mutable struct OuProcess
    r::Float64
    sigma::Float64
    lamd::Float64
    mean::Float64
end


function ouStep(ou::OuProcess)
    ou.r+=ou.lamd*(ou.mean-ou.r)+ou.sigma*randn()
end


