function sysCall_init() 
    jointLHandle=sim.getObjectHandle('_cupboardJointLeft')
    jointRHandle=sim.getObjectHandle('_cupboardJointRight')
    modelHandle=sim.getObjectHandle(sim.handle_self)
    sliderV=0
end

function sysCall_sensing()
    local s=sim.getObjectSelection()
    local show=(s and #s==1 and s[1]==modelHandle)
    if show then
        if not ui then
            local xml =[[<ui title="xxxx" closeable="false" placement="relative" layout="form">
                    <label text="Open/close"/>
                    <hslider id="1" on-change="openSliderMoved"/>
            </ui>]]
            ui=simUI.create(xml)
            if uiPos then
                simUI.setPosition(ui,uiPos[1],uiPos[2])
            else
                uiPos={}
                uiPos[1],uiPos[2]=simUI.getPosition(ui)
            end
            simUI.setTitle(ui,sim.getObjectName(modelHandle))
            simUI.setSliderValue(ui,1,sliderV)
        end
    else
        if ui then
            uiPos[1],uiPos[2]=simUI.getPosition(ui)
            simUI.destroy(ui)
            ui=nil
        end
    end
end

function openSliderMoved(ui,id,v)
    sliderV=v
    sim.setJointPosition(jointLHandle,math.pi*sliderV/200)
    sim.setJointPosition(jointRHandle,math.pi*sliderV/200)
end
