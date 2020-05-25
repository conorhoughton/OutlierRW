#plots efficiency against eta - the rw learning rate for rw process

#beta 1.5 
include("ou_process.jl")
include("soft_max.jl")
include("rw.jl")
include("rw_out_process.jl")    

r0=0
mean=0
lamd=0.1
sigma=1

#beta=2.5

beta=1.5

ou1=OuProcess(r0,sigma,lamd,mean)
ou2=OuProcess(r0,sigma,lamd,mean)

softMax=makeSoftMax(beta)

eta=0.01

tMax=10000000

outlier_probs=Float64[0.1,0.1]
outlier_rewards=Float64[-5,5]

sigma_noise=0.1::Float64

while eta<1
    global eta

    rw1=Rw(r0,eta)
    rw2=Rw(r0,eta)
    getReward1=makeGetReward(ou1,outlier_rewards,outlier_probs,sigma_noise)
    getReward2=makeGetReward(ou2,outlier_rewards,outlier_probs,sigma_noise)

    reward=rw_process(ou1,ou2,rw1,rw2,getReward1,getReward2,softMax,tMax)

    println(eta," ",reward[1]," ",reward[2])

    eta+=0.05
    
end
