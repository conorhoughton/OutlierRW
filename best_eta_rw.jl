#plots efficiency against eta - the rw learning rate for rw process
#or plots efficiency against beta - the softmax parameter

#beta 1.5 eta 0.2 appears to be the best

include("ou_process.jl")
include("soft_max.jl")
include("rw.jl")
include("rw_process.jl")    

r0=0
mean=0
lamd=0.1
sigma=1

#beta=2.5

beta=0.25

ou1=OuProcess(r0,sigma,lamd,mean)
ou2=OuProcess(r0,sigma,lamd,mean)



#eta=0.01
eta=0.2

tMax=1000000

while beta<10
    global beta
    softMax=makeSoftMax(beta)
    rw1=Rw(r0,eta)
    rw2=Rw(r0,eta)
    reward=rw_process(ou1,ou2,rw1,rw2,softMax,tMax)
    println(beta," ",reward[1]," ",reward[2])
    #eta+=0.05
    beta+=0.25
    
end
