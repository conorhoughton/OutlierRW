
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


function makeGetReward(ou::OuProcess,rewards::Array{Float64},probs::Array{Float64},sigma_noise)

    inlier=1-sum(probs)
    outliers=Float64[inlier+probs[1]]

    for i in 2:length(probs)
        push!(outliers,probs[i]+outliers[end])
    end

    function getReward()
        r=sigma_noise*randn()
        p=rand()
        if p<inlier
            r+=ou.r
        else
            i=1
            while p>outliers[i]
                i+=1
            end
            r+=rewards[i]
        end
        r
    end
    

end
