
using Random

function makeSoftMax(beta::Float64)
    function softMax(r1::Float64,r2::Float64)
        p=exp(beta*r1)/(exp(beta*r1)+exp(beta*r2))
        if rand()<p
            return 1
        else
            return 2
        end        
    end
end

