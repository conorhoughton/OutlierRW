

function makeBackground(sigma::Float64,mean::Float64)
    function background(r::Float64)
        1.0/(sigma*sqrt(2*pi))*exp(-(mean-r)^2/(2*sigma^2))
    end
end
