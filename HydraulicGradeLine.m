%Benjamin Chupik
%EWB Puerto Rico
%Hydraulic Grade line
%Created 11/02/2019
%Last Edited: 11/19/2019



%Cleaning
clc
clear;
close all;

%constants
degToKm = 10000/90; %km/deg

%importing data
    %id,lat,long.didst,elv
data = readtable('95d.csv');
rawsize = size(data,1);
data = sortrows(data,2);%sorts the table by path name so they are for sure together

%finding dist between points
distBetween = data.MetersfromLastNode;

%getting path names and scraping data
pathNameList = [data.TrackName(1)]; %init path name list (for keeping track of names)
counter = 1; %for keeping track of what path were on (for data storage)
rowcounter = 2; %for keeping track of what row of the path were on
tempDistFromStart = 0;%pre allocate dist from start
distFromStart = {};%rows are new pathe, col 1 is dist between, elevation
lastnew = 1; %for keeping track of the locatoin of the last new path was
for i=2:rawsize %goes through all data
    if ~strcmp(data.TrackName{i}, pathNameList{end}) %if dif name
        pathNameList = [pathNameList;data.TrackName(i)]; %put name in
        distFromStart{counter,1} = tempDistFromStart;%add to previous name
        distFromStart{counter,2} = data.Elevation(lastnew:(i-1)); %add elevation data
        lastnew=i; 
        counter = counter +1; %increment counter
        tempDistFromStart = 0; %resets the temp
        rowcounter=2; %restes the row
    else
        tempDistFromStart = [tempDistFromStart;tempDistFromStart(rowcounter-1)+distBetween(i)];%sums it with last one
        rowcounter = rowcounter+1;%move down row
    end
end
%need to add the last bit to the cell array
distFromStart{counter,1} = tempDistFromStart;
distFromStart{counter,2} = data.Elevation(lastnew:(i));



%for every path
numbpaths = size(pathNameList,1); %number of paths
for i = 1:numbpaths %goes through every path
    figure %creates a new figure
    hold on %combines plots
    plot(distFromStart{i,1},distFromStart{i,2},'LineWidth',2) %the hydrolic grade line
    xlabel('Dist from start of pipe(Km)')
    ylabel('Elevation (whatever was givin)')
    title(pathNameList{i})

    scatter(distFromStart{i,1},distFromStart{i,2},'o') %circles the data points
    legend('Hydrolic Grade Line','Node')
    
    %output figures to esp type file
    %Uncomment to print all the figures nicely
    %print([pathNameList{i},'_HydraulicGradeLine'],'-depsc');%print figure
end


