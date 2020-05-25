
mutable struct Rw
    r::Float64
    eta::Float64
end


function updateRw(rw::Rw,r)
    rw.r+=rw.eta*(r-rw.r)
end


mutable struct New
    r::Float64
    eta::Float64
    background::Function
end


function updateRw(rw::New,r)
    rw.r+=rw.eta*rw.background(r)*(r-rw.r)
end
