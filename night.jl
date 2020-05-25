
mutable struct Night
    bias::Float64
    eta::Float64
end

function update(night::Night,deltaR::Float64)
    night.bias+=night.eta*deltaR
end

struct Event
    choice::Int64
    reward::Float64
    surprise::Float64
end

function pickEvent(events::Vector{Event})
    probs=[e.surprise for e in events]
    probs/=sum(probs)

    for i in 2:length(probs)
        probs[i]+=probs[i-1]
    end
        
    p=rand()
    i=1
    while p>probs[i]
        i+=1
    end

    events[i].choice

end

    
