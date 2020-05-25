#plots efficiency for our new rule against eta - the rw learning rate for rw process

#beta 1.5 
include("ou_process.jl")
include("soft_max.jl")
include("rw.jl")
include("rw_out_process.jl")    
include("background.jl")

r0=0.0::Float64
mean=0.::Float64
lamd=0.1::Float64
sigma=1.0::Float64

beta=1.5

ou1=OuProcess(r0,sigma,lamd,mean)
ou2=OuProcess(r0,sigma,lamd,mean)

softMax=makeSoftMax(beta)

eta0=0.01

tMax=10000000

outlier_probs=Float64[0.1,0.1]
outlier_rewards=Float64[-5,5]

sigma_b=1.5
mean_b=0.0::Float64

sigma_noise=0.1::Float64

bg=makeBackground(sigma_b,mean_b)

while eta0<2
    global eta0

    eta=eta0/bg(mean_b)
    
    rw1=New(r0,eta,bg)
    rw2=New(r0,eta,bg)
    getReward1=makeGetReward(ou1,outlier_rewards,outlier_probs,sigma_noise)
    getReward2=makeGetReward(ou2,outlier_rewards,outlier_probs,sigma_noise)

    reward=rw_process(ou1,ou2,rw1,rw2,getReward1,getReward2,softMax,tMax)

    println(eta0," ",reward[1]," ",reward[2])

    eta0+=0.05
    
end
