
include("ou_process.jl")

r=0
sigma=0
lamb=1.0
mean=0.0

ou=OuProcess(r,sigma,lamb,mean)


#rewards=Float64[-10.,10.]
#probs=Float64[0.1,0.2]


rewards=Float64[-10]
probs=Float64[0.3]



getReward=makeGetReward(ou,rewards,probs)

count0=0
countP=0
countN=0

trialN=10000

for i in 1:trialN
    global count0,countP,countN
    r=getReward()
    if r>0
        countP+=1
    elseif r<0
        countN+=1
    else
        count0+=1
    end
end

println(countN/trialN," ",count0/trialN," ",countP/trialN)

