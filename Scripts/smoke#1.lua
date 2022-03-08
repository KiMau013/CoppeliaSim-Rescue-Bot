function sysCall_init() 
    smokeDrawingObjType=sim.drawing_discpoints+sim.drawing_cyclic+sim.drawing_50percenttransparency+sim.drawing_25percenttransparency+
        sim.drawing_facingcamera+sim.drawing_itemsizes+sim.drawing_painttag
    smokeCont=sim.addDrawingObject(smokeDrawingObjType,0.1,0,-1,20,{0,0,0},{0,0,0},{0,0,0},{0,0,0,0.7,0,0})
    oh=sim.getObjectHandle(sim.handle_self)
    s=sim.getObjectSizeFactor(oh)
    smokePp={{0.19,0,0,5*s},
        {0.2,0,0,5*s},
        {0.18,0,0,5*s},
        {0.11,0,0,5*s},
        {0.05,0,0,5*s},
        {0.07,0,0,5*s},
        {0.08,0,0,5*s},
        {0.09,0,0,5*s},
        {0.13,0,0,5*s},
        {0.22,0,0,5*s},
        {0.03,0,0,5*s},
        {0.14,0,0,5*s},
        {0.19,0,0,5*s},
        {0.2,0,0,5*s},
        {0.18,0,0,5*s},
        {0.11,0,0,5*s},
        {0.05,0,0,5*s},
        {0.07,0,0,5*s},
        {0.08,0,0,5*s},
        {0.09,0,0,5*s},
        {0.13,0,0,5*s},
        {0.22,0,0,5*s},
        {0.03,0,0,5*s},
        {0.14,0,0,5*s}}
    smokeX={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    smokeY={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
end

function sysCall_cleanup() 
    sim.removeDrawingObject(smokeCont)
end 

function sysCall_actuation() 
    sim.addDrawingObjectItem(smokeCont,nil)
    s=sim.getObjectSizeFactor(oh)
    ts=sim.getSimulationTimeStep()
    smokeStartP={0,0,0}
    
    op=sim.getObjectPosition(oh,-1)
    for i=1,24,1 do
        v=smokePp[i][1]*s
        p={smokePp[i][2]*s,smokePp[i][3]*s,smokePp[i][4]*s}
        dx={v*ts*smokeX[i],v*ts*smokeY[i],v*ts*2}
        p={p[1]+dx[1],p[2]+dx[2],p[3]+dx[3]}
        l=math.sqrt(p[1]*p[1]+p[2]*p[2]+p[3]*p[3])
        if (l>s) then
            smokeX[i]=0.2*(math.random()-0.5)*s
            smokeY[i]=0.2*(math.random()-0.5)*s
            p={smokeX[i]+dx[1],smokeY[i]+dx[2],0}
            l=0
            smokePp[i][1]=s*(0.05+0.17*math.random())
        end
        smokePp[i][2]=p[1]/s
        smokePp[i][3]=p[2]/s
        smokePp[i][4]=p[3]/s
        data={p[1]+op[1],p[2]+op[2],p[3]+op[3],0.05+0.1*s*l}
        sim.addDrawingObjectItem(smokeCont,data)
    end
end 
