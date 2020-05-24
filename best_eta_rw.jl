
include("ou_process.jl")
include("soft_max.jl")
include("rw.jl")
include("rw_process.jl")    

r0=0
mean=0
lamd=0.1
sigma=1

beta=2.5

ou1=OuProcess(r0,sigma,lamd,mean)
ou2=OuProcess(r0,sigma,lamd,mean)

softMax=makeSoftMax(beta)


eta=0.01
tMax=1000000

while eta<1.1
    global eta
    rw1=Rw(r0,eta)
    rw2=Rw(r0,eta)
    println(eta," ",rw_process(ou1,ou2,rw1,rw2,softMax,tMax))
    eta+=0.05

end
