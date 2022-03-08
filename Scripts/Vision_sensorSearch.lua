function sysCall_vision(inData)
    simVision.sensorImgToWorkImg(inData.handle)
    simVision.edgeDetectionOnWorkImg(inData.handle,0.2)
    simVision.workImgToSensorImg(inData.handle)
end

function sysCall_init()
end
