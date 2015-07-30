function plotBallData(stim,rawData,trialMeta,exptInfo)

close all
set(0,'DefaultFigureWindowStyle','docked')
%setCurrentFigurePosition(1);

subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.05], [0.1 0.01], [0.1 0.01]);

%% Decode
settings = ballSettings;
[procData.vel(:,1),procData.disp(:,1)] = processBallData(rawData(:,1),settings.xMinVal,settings.xMaxVal,settings,stim);
[procData.vel(:,2),procData.disp(:,2)] = processBallData(rawData(:,2),settings.yMinVal,settings.yMaxVal,settings,stim);
groupedData = groupBallData(procData,trialMeta,exptInfo);

figure(1)
h(1) = subplot(6,2,1) ;
mySimplePlot(stim.timeVec,stim.stimulus)
title('Velocity and displacement vs. time')
set(gca,'XTick',[])
ylabel({'stim';'(V)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
set(gca,'XColor','white')

h(2) = subplot(6,2,3);
mySimplePlot(stim.timeVec,procData.vel(:,1))
set(gca,'XTick',[])
ylabel({'Lateral Vel';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
moveXAxis(stim)
shadestimArea(stim) 

h(3) = subplot(6,2,5);
mySimplePlot(stim.timeVec,procData.vel(:,2))
set(gca,'XTick',[])
ylabel({'Forward Vel';'(mm/s)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim) 
moveXAxis(stim)

h(4) = subplot(6,2,7);
mySimplePlot(stim.timeVec,procData.disp(:,1))
set(gca,'XTick',[])
ylabel({'X Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
shadestimArea(stim) 
moveXAxis(stim)

h(5) = subplot(6,2,9);
mySimplePlot(stim.timeVec,procData.disp(:,2))
ylabel({'Y Disp';'(mm)'})
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
line([stim.timeVec(1),stim.timeVec(end)],[0,0],'Color','k')
shadestimArea(stim) 
xlabel('Time (s)')
linkaxes(h(:),'x')

subplot(6,2,2:2:6)
plot(procData.disp(:,1),procData.disp(:,2))
hold on 
plot(procData.disp(1,1),procData.disp(1,2),'go')
text(procData.disp(1,1),procData.disp(1,2),'start','Color','g','FontSize',12);
plot(procData.disp(end,1),procData.disp(end,2),'ro')
text(procData.disp(end,1),procData.disp(end,2),'stop','Color','r','FontSize',12);
plot(0,0,'bo')
text(0,0,'stim start','Color','b','Fontsize',12);
axis square
axis equal
xMax = max(abs(procData.disp(:,1)));
yMax = max(abs(procData.disp(:,1)));
overallMax = max([xMax, yMax]);
if overallMax == 0 
    overallMax = 1; 
end
xlim([-overallMax,overallMax])
ylim([-overallMax,overallMax])
ylabel('Y displacement (mm)')
title('X-Y displacement')

subtightplot (6, 2, 11, [0.1 0.05], [0.1 0.01], [0.1 0.01]);
bins = -10:0.5:40;
vTemp = groupedData.yVel(:);
hist(vTemp,bins);
xlim([-10 40])
xlabel('Forward velocity (mm/s)')
ylabel('Counts')
set(get(gca,'YLabel'),'Rotation',0,'HorizontalAlignment','right')
box off;
set(gca,'TickDir','out')
axis tight

subtightplot (6, 2, 8:2:12, [0.1 0.05], [0.1 0.01], [0.1 0.01]);
uniqueStim = unique(groupedData.stimNum); 
colorSet = distinguishable_colors(length(uniqueStim),'w');
for i = 1:length(uniqueStim) 
    stimNumInd = find(groupedData.stimNum == uniqueStim(i));
    plot(mean(groupedData.xDisp(stimNumInd,:)),mean(groupedData.yDisp(stimNumInd,:)),'Color',colorSet(i,:))
    hold on 
    xMax = max(abs(groupedData.xDisp(i,:)));
    yMax = max(abs(groupedData.yDisp(i,:)));
    maxMat(i) = max([xMax, yMax]);
end
axis square
axis equal
overallMax = max(maxMat(:));
if overallMax == 0 
    overallMax = 1; 
end
xlim([-overallMax,overallMax])
ylim([-overallMax,overallMax])
xlabel('X displacement (mm)')
ylabel('Y displacement (mm)')

suptitle(stim.speakerOrder(stim.speaker))

end

function shadestimArea(stim) 
gray = [192 192 192]./255;
pipStarts = stim.startPadDur; 
pipEnds = stim.startPadDur + stim.stimDur;
Y = ylim(gca);
X = [pipStarts,pipEnds];
line([X(1) X(1)],[Y(1) Y(2)],'Color',gray);
line([X(2) X(2)],[Y(1) Y(2)],'Color',gray);
colormap hsv
alpha(.1)
end

function moveXAxis(stim)
set(gca,'XColor','white')
line([stim.timeVec(1),stim.timeVec(end)],[0,0],'Color','k')
end