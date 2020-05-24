
mutable struct Rw
    r::Float64
    eta::Float64
end


function updateRw(rw::Rw,r)
    rw.r+=eta*(r-rw.r)
end
