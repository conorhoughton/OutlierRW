
include("ou_process.jl")
include("soft_max.jl")
include("rw.jl")
    

r0=0
mean=0
lamd=0.1
sigma=1

eta=0.01

beta=2.5

ou1=OuProcess(r0,sigma,lamd,mean)
ou2=OuProcess(r0,sigma,lamd,mean)

rw1=Rw(r0,eta)
rw2=Rw(r0,eta)

softMax=makeSoftMax(beta)

choiceReward=0
bestReward=0

t=0

while t<100000
    
    global t,choiceReward,bestReward

#    println(t," ",ou1.r," ",rw1.r," ",ou2.r," ",rw2.r)
    
    if softMax(rw1.r,rw2.r)==1
        choiceReward+=ou1.r
        updateRw(rw1,ou1.r)
    else
        choiceReward+=ou2.r
        updateRw(rw2,ou2.r)
    end

    if softMax(ou1.r,ou2.r)==1
        bestReward+=ou1.r
    else
        bestReward+=ou2.r
    end
        
    ouStep(ou1)
    ouStep(ou2)

    t+=1
end

println(choiceReward/bestReward)
