function sysCall_init() 
    activated=true
    smoke=true
    smokeModel=sim.getObjectHandle('smoke')
    fireDrawingObjType=sim.drawing_discpoints+sim.drawing_cyclic+sim.drawing_25percenttransparency+sim.drawing_emissioncolor+
        sim.drawing_itemcolors+sim.drawing_itemsizes+sim.drawing_facingcamera+sim.drawing_painttag
    fireCont=sim.addDrawingObject(fireDrawingObjType,0.1,0,-1,20,nil,nil,nil,{1,0,0,1,0,0.9})
    oh=sim.getObjectHandle(sim.handle_self)
    s=sim.getObjectSizeFactor(oh)
    pp={{1,0,0,0},
        {0.86,0,0,0},
        {0.78,0,0,0},
        {0.74,0,0,0},
        {0.8,0,0,0},
        {0.7,0,0,0},
        {0.6,0,0,0},
        {0.5,0,0,0},
        {0.4,0,0,0},
        {0.45,0,0,0},
        {0.55,0,0,0},
        {0.65,0,0,0}}
    co={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
    for i=0,11,1 do
        co[i+1]=sim.getObjectHandle('fireParticle'..i)
    end
    rndX={0,0,0,0,0,0,0,0,0,0,0,0}
    rndY={0,0,0,0,0,0,0,0,0,0,0,0}
    rndZ={0,0,0,0,0,0,0,0,0,0,0,0}
    rndCnt=0
    light=sim.getObjectHandle('fireLight')
    lightPos={0,0,0}
    if (smoke) then
        sim.setModelProperty(smokeModel,0)
    else
        sim.setModelProperty(smokeModel,sim.modelproperty_scripts_inactive)
    end
end

function sysCall_cleanup() 
    sim.removeDrawingObject(fireCont)
end 

function sysCall_actuation() 
    sim.addDrawingObjectItem(fireCont,nil)
    s=sim.getObjectSizeFactor(oh)
    if (rndCnt>0.05) then
        rndCnt=0
        for i=1,12,1 do
            rndX[i]=math.random()-0.5
            rndY[i]=math.random()-0.5
            rndZ[i]=math.random()
        end
        lightPos[1]=math.random()-0.5
        lightPos[2]=math.random()-0.5
        lightPos[3]=math.random()
    end
    ts=sim.getSimulationTimeStep()
    rndCnt=rndCnt+ts
    if (activated) then
        op=sim.getObjectPosition(oh,-1)
        for i=1,12,1 do
            v=pp[i][1]*s
            p={pp[i][2]*s,pp[i][3]*s,pp[i][4]*s}
            dx={v*ts*rndX[i],v*ts*rndY[i],v*ts*rndZ[i]*2}
            p={p[1]+dx[1],p[2]+dx[2],p[3]+dx[3]}
            l=math.sqrt(p[1]*p[1]+p[2]*p[2]+p[3]*p[3])
            if (l>0.5*s) then
                p={0,0,0}
                l=0
            end
            pp[i][2]=p[1]/s
            pp[i][3]=p[2]/s
            pp[i][4]=p[3]/s
            data={p[1]+op[1],p[2]+op[2],p[3]+op[3],1,1-l/s,0,0.1*s-l/8}
            sim.addDrawingObjectItem(fireCont,data)
            sim.setObjectPosition(co[i],sim.handle_parent,p)
        end
        sim.setObjectPosition(light,oh,{lightPos[1]*0.2*s,lightPos[2]*0.2*s,lightPos[3]*0.4*s})
        sim.setLightParameters(light,1)
    else
        sim.setLightParameters(light,0)
    end
end 
