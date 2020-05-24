
#rw reward process for testing

function rw_process(ou1,ou2,rw1,rw2,softMax,tMax)

    choiceReward=0
    bestReward=0

    t=0

    while t<tMax
    
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
    
    choiceReward/bestReward

    
end
