function stimSet_019(exptInfo,preExptData)

% Probe experiment with 200Hz pure tone plus saturation test

%% Archive this code
archiveExpCode(exptInfo)

%% Set up and acquire with the stimulus set
pause on 
count = 1;
stimCount = 1; 
FS = stoploop('Stop Experiment');
while ~FS.Stop()
    trialMeta.stimNum = stimCount;
    stim = pickStimulus(trialMeta.stimNum);
    switchSpeaker(stim.speaker);
    if count == 1 
        fprintf(['\nMove probe to ',stim.probe,' antenna, then press Enter\n'])
        pause
    end
    acquireTrial('i',stim,exptInfo,preExptData,trialMeta);
    if count == 3
        count = 1;
        stimCount = stimCount + 1; 
    else
        count = count+1;
    end
    if stimCount == 7; 
        stimCount = 1; 
    end
end

FS.Clear() ;  % Clear up the box
clear FS ;

    function stim = pickStimulus(stimNum)
        switch stimNum
            case 1
                stim = SineWave;
                stim.carrierFreqHz = 200;
                stim.probe = 'left';
                stim.maxVoltage = 0.0125;
            case 2
                % Saturation test
                stim = SineWave;
                stim.carrierFreqHz = 200;
                stim.maxVoltage = 0.00625;
                stim.probe = 'left';
            case 3
                stim = SineWave;
                stim.carrierFreqHz = 200;
                stim.probe = 'off';
                stim.maxVoltage = 0.0125;
            case 4
                % Saturation test
                stim = SineWave;
                stim.carrierFreqHz = 200;
                stim.maxVoltage = 0.00625;
                stim.probe = 'off';
            case 5
                stim = SineWave;
                stim.carrierFreqHz = 200;
                stim.probe = 'right';
                stim.maxVoltage = 0.0125;
            case 6
                % Saturation test
                stim = SineWave;
                stim.carrierFreqHz = 200;
                stim.maxVoltage = 0.00625;
                stim.probe = 'right';
        end
    end


end