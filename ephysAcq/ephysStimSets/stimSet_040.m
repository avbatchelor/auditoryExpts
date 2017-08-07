function stimSet_041(exptInfo,preExptData)

% Sine wave with and without CVA

%% Hard-coded params
injectionDur = 1.25;

%% Speaker or piezo
exptInfo.stimType = 's';

%% Archive this code
archiveExpCode(exptInfo)

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)

%% Specify stimulus


%% Specify states
state{1} = 'CVA';
state{2} = 'Dry paper';

%% Set up and acquire with the stimulus set
numberOfStimuli = 1;
stimRan = randperm(numberOfStimuli);

count = 1;
repeat = 1;
stimNum = 1; 

while repeat < 40
    trialMeta.stimNum = stimNum;
    fprintf(['\nStimNum = ',num2str(trialMeta.stimNum)])
    fprintf(['\nRepeatNum = ',num2str(repeat)])
    [stim,currentCommand] = pickStimulus(trialMeta.stimNum,state);
%     fprintf(['\nMake sure state is ',stim.state])
%     pause
    acquireTrialWithOdor('none',stim,exptInfo,preExptData,trialMeta,currentCommand);
    if count == 3
        stimNum = 2;
    elseif count == 6
        count = 1; 
        stimNum = 1; 
        repeat = repeat + 1;
    end
end

%% Run current injection trial
currentInjectionTrial(exptInfo,preExptData)


end

function [stim,currentCommand] = pickStimulus(stimNum,state)
switch stimNum
    case 1 % current injection during stimulus
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 1;
        stim.state = state{1};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (1.5)*stim.sampleRate;
        pulseEndInd = (3.25)*stim.sampleRate;
        currentCommand(pulseStartInd:pulseEndInd) = 0*(-0.0394/4);
    case 2 % current injection during stimulus
        % Make stimulus
        stim = OptoStimulus;
        stim.optoDur = 1;
        stim.state = state{2};
        stim.endPadDur = 5;
        % Make current command
        currentCommand = zeros(size(stim.stimulus));
        pulseStartInd = (1.5)*stim.sampleRate;
        pulseEndInd = (3.25)*stim.sampleRate;
        currentCommand(pulseStartInd:pulseEndInd) = 0*(-0.0394/4);
%     case 3 % current injection during stimulus
%         % Make stimulus
%         stim = OptoStimulus;
%         stim.optoDur = 1;
%         stim.state = state{2};
%         stim.endPadDur = 5;
%         % Make current command
%         currentCommand = zeros(size(stim.stimulus));
%         pulseStartInd = (1.5)*stim.sampleRate;
%         pulseEndInd = (3.25)*stim.sampleRate;
%         currentCommand(pulseStartInd:pulseEndInd) = 8*(-0.0394/4);
end
end
