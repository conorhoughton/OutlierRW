
#rw reward process for testing

function rw_process(ou1,ou2,rw1,rw2,getReward1,getReward2,softMax,tMax)

    choiceReward=0
    bestReward=0

    t=0

    while t<tMax

        reward1=getReward1()
        reward2=getReward2()

        if softMax(rw1.r,rw2.r)==1
            choiceReward+=reward1
            updateRw(rw1,reward1)
        else
            choiceReward+=reward2
            updateRw(rw2,reward2)
        end
        
        if softMax(ou1.r,ou2.r)==1
            bestReward+=reward1
        else
            bestReward+=reward2
        end
        
        ouStep(ou1)
        ouStep(ou2)
        
        t+=1
    end
    
    (choiceReward/bestReward,choiceReward)

    
end
