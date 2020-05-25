
include("ou_process.jl")
include("soft_max.jl")
include("rw.jl")
include("rw_out_process.jl")    
include("background.jl")
include("night.jl")

r0=0.0::Float64
mean=0.::Float64
lamd=0.1::Float64
sigma=1.0::Float64
sigmaNoise=0.2::Float64

beta=1.5::Float64

eta0=1.5::Float64

sigmaB=1.5::Float64
meanB=0.0::Float64

etaNight=0.5::Float64
bias0=0.::Float64


p1=0.075::Float64
p2=0.025::Float64
outR=15.0::Float64


bg=makeBackground(sigmaB,meanB)

eta=eta0/bg(meanB)

etaOld=0.2::Float64

softMax=makeSoftMax(beta)

choiceReward=0.::Float64
bestReward=0.::Float64
oldReward=0.::Float64

daysMax=20

trialsN=20

dreamsN=5

episodesN=1000

for episodes in 1:episodesN

    days=0

    ou=[OuProcess(r0,sigma,lamd,mean),OuProcess(r0,sigma,lamd,mean)]

    rw=[New(r0,eta,bg),New(r0,eta,bg)]

    old=[Rw(r0,etaOld),Rw(r0,etaOld)]

    outlierProbs=[Float64[p1,p2],Float64[p2,p1]]
    outlierRewards=Float64[-outR,outR]

    getReward=[makeGetReward(ou[i],outlierRewards,outlierProbs[i],sigmaNoise) for i in 1:2]

    night=[Night(bias0,etaNight),Night(bias0,etaNight)]

    while days<daysMax
        
        global choiceReward,bestReward,oldReward
        
        events=Event[]
        deltaR=0.0::Float64
        
        for trials in 1:trialsN
            
            reward=[getReward[i]() for i in 1:2]
            
            bestReward+=reward[softMax(ou[1].r,ou[2].r)]
            
            oldChoice=softMax(old[1].r,old[2].r)
            oldReward+=reward[oldChoice]
            updateRw(old[oldChoice],reward[oldChoice])
            
            choice=softMax(rw[1].r+night[1].bias,rw[2].r+night[2].bias)
            
            choiceReward+=reward[choice]
            push!(events,Event(choice,reward[choice],-log(bg(reward[choice]))))
            deltaR+=reward[choice]-rw[choice].r-night[choice].bias
            updateRw(rw[choice],reward[choice])
            
            for i in 1:2
                ouStep(ou[i])
            end
            
            trials+=1
        end
        
        deltaR/=trialsN*dreamsN

        for dreams in 1:dreamsN
            choice=pickEvent(events)        
            update(night[choice],deltaR)
            
        end

    days+=1

    end

end
    
println(choiceReward/bestReward," ",oldReward/bestReward)
