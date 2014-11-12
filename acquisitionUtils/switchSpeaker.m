function switchSpeaker(spNum) 

% spNum = speaker number
% spNum = 0 All speakers off 
% spNum = 1 Left speaker 
% spNum = 2 Middle speaker 
% spNum = 3 Right speaker 

output = [0,0,0];

% Creat digital acquisition session and add channel
dOut = daq.createSession('ni');
dOut.addDigitalChannel('Dev1','port0/line0:2','OutputOnly')

% First switch all speakers off 
dOut.outputSingleScan([0,0,0])

% Switch one speaker on 
if spNum ~= 0
    output(spNum) = 1;
    dOut.outputSingleScan(output)
end

dOut.stop;

end