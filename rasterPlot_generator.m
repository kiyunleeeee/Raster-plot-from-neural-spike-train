% Created: 11/30/2020. By kiyunlee
% Modified: 12/21/2022 By kiyunlee

% Description
% This program generates raster plots from neural spike train data.
% Unlike other types raster plot, spike is represented as a vertical line, not a dot.
% With the representation of neural activity by vertical lines, it is clearer to see overall activity such as burst and synchrounous firings.


% Note
% This program is designed for spike train data measured by total 60 electrodes (9 electrode in each well A~F + 6 ground electrodes).
% Depending on microelectrode types, slight modification of the code is needed.


% import spike train data
data = importdata('result.txt');



% define parameters
duration = 310; % neural activity recording duration + buffer of 10 s (s)
fs = 10000; % sampling frequency (Hz)
numElectrode = 9; % number of electrodes in each well
electrodeID = data(:,1); % electrode ID defined by manafucturer
t = data(:,2); % timepoint of record



% get first and last location of each electrode ID
loc = []; loc(1) = 1;
for i = 2:length(electrodeID)
    if electrodeID(i,1) ~= electrodeID (i-1,1);
        loc = [loc; i-1; i];
    end
end
loc = [loc; length(electrodeID)];

% predefined electrode IDs. Row: well A~F, column: electrode 1~9
ID = [43 42 51 44 52 53 31 41 54; % well A
63 82 83 71 73 64 62 72 74; % well B
65 76 77 75 87 66 85 86 78; % well C
56 57 48 55 47 46 68 58 45; % well D
36 17 16 28 26 35 37 27 25; % well E
34 23 22 24 12 33 14 13 21]; % well F




% initialize all spike train as active (1)
A = zeros(numElectrode,duration*fs); B=A; C=A; D=A; E=A; F=A; % well A~F
for i = 1:2:length(loc)-1
    
    [row col] = find(ID == electrodeID(loc(i)));
    
    if row == 1
        for j = loc(i):loc(i+1)
            A(col, round(t(j)*fs,0)) = 1; % "col"th electrode in well A
        end
    elseif row == 2
        for j = loc(i):loc(i+1)
            B(col, round(t(j)*fs,0)) = 1;
        end
    elseif row == 3
        for j = loc(i):loc(i+1)
            C(col, round(t(j)*fs,0)) = 1;
        end
    elseif row == 4
        for j = loc(i):loc(i+1)
            D(col, round(t(j)*fs,0)) = 1;
        end
    elseif row == 5
        for j = loc(i):loc(i+1)
            E(col, round(t(j)*fs,0)) = 1;
        end
    elseif row == 6
        for j = loc(i):loc(i+1)
            F(col, round(t(j)*fs,0)) = 1;
        end
    end
end




% set inactive electrode which is < 5 spike/min as inactive (0) 
for i=1:numElectrode
    if sum(A(i,:))<25
        A(i,:)=0;
    end
end
for i=1:numElectrode
    if sum(B(i,:))<25
        B(i,:)=0;
    end
end
for i=1:numElectrode
    if sum(C(i,:))<25
        C(i,:)=0;
    end
end
for i=1:numElectrode
    if sum(D(i,:))<25
        D(i,:)=0;
    end
end
for i=1:numElectrode
    if sum(E(i,:))<25
        E(i,:)=0;
    end
end
for i=1:numElectrode
    if sum(F(i,:))<25
        F(i,:)=0;
    end
end




% generate raster plots
% define scale bar and window size for raster plot
scaleBar = 5; % sec
window = [85*10^6 (85+10)*10^6]; % for example, recording window from 85 to 95 s
lw = 1; % line width


% well A
electrode = A; % electrode ID
time = (0:length(electrode)-1)*100;

figure; lineL = .5; % line length for raster plot
for i=1:numElectrode
        
        spike = electrode(i,:);
        rasterTime = []; trial = [];
        rasterTime = time(spike~=0); rasterTime = rasterTime';
        trial = i*ones(size(rasterTime)); % "i"th electrode in well A 
         
        plot([rasterTime(:)'; rasterTime(:)'], [trial(:)'+lineL/2; trial(:)'-lineL/2], 'k', 'LineWidth', lw); hold on;
        
end

% add scale bar
scaleX = range(window)/scaleBar; % \mus
plot([window(1) window(1)+scaleX], [0.2 0.2], '-b', 'LineWidth', lw);       
xlim([window]);

set(gca,'xtick',[],'ytick',[])
box on; hold off;




% well B
electrode=B;
time=(0:length(electrode)-1)*100;

figure; lineL = .5;
for i=1:numElectrode
        
        spike = electrode(i,:);
        rasterTime=[]; trial=[];
        rasterTime=time(spike~=0); rasterTime=rasterTime';
        trial=i*ones(size(rasterTime));
         
        plot([rasterTime(:)'; rasterTime(:)'], [trial(:)'+lineL/2; trial(:)'-lineL/2], 'k', 'LineWidth', lw); hold on;
        
end

% add scale bar
scaleX = range(window)/scaleBar; %\mus
plot([window(1) window(1)+scaleX], [0.2 0.2], '-b', 'LineWidth', lw);       
xlim([window]);

set(gca,'xtick',[],'ytick',[])
box on; hold off;





% well C
electrode=C;
time=(0:length(electrode)-1)*100;

figure; lineL = .5;
for i=1:numElectrode
        
        spike = electrode(i,:);
        rasterTime=[]; trial=[];
        rasterTime=time(spike~=0); rasterTime=rasterTime';
        trial=i*ones(size(rasterTime));
         
        plot([rasterTime(:)'; rasterTime(:)'], [trial(:)'+lineL/2; trial(:)'-lineL/2], 'k', 'LineWidth', lw); hold on;
        
end

% add scale bar
scaleX = range(window)/scaleBar; %\mus
plot([window(1) window(1)+scaleX], [0.2 0.2], '-b', 'LineWidth', lw);       
xlim([window]);

set(gca,'xtick',[],'ytick',[])
box on; hold off;




% well D
electrode=D;
time=(0:length(electrode)-1)*100;

figure; lineL = .5;
for i=1:numElectrode
        
        spike = electrode(i,:);
        rasterTime=[]; trial=[];
        rasterTime=time(spike~=0); rasterTime=rasterTime';
        trial=i*ones(size(rasterTime));
         
        plot([rasterTime(:)'; rasterTime(:)'], [trial(:)'+lineL/2; trial(:)'-lineL/2], 'k', 'LineWidth', lw); hold on;
        
end

% add scale bar
scaleX = range(window)/scaleBar; %\mus
plot([window(1) window(1)+scaleX], [0.2 0.2], '-b', 'LineWidth', lw);       
xlim([window]);

set(gca,'xtick',[],'ytick',[])
box on; hold off;




% well E
electrode=E;
time=(0:length(electrode)-1)*100;

figure; lineL = .5;
for i=1:numElectrode
        
        spike = electrode(i,:);
        rasterTime=[]; trial=[];
        rasterTime=time(spike~=0); rasterTime=rasterTime';
        trial=i*ones(size(rasterTime));
         
        plot([rasterTime(:)'; rasterTime(:)'], [trial(:)'+lineL/2; trial(:)'-lineL/2], 'k', 'LineWidth', lw); hold on;
        
end

% add scale bar
scaleX = range(window)/scaleBar; %\mus
plot([window(1) window(1)+scaleX], [0.2 0.2], '-b', 'LineWidth', lw);       
xlim([window]);

set(gca,'xtick',[],'ytick',[])
box on; hold off;






% well F
electrode=F;
time=(0:length(electrode)-1)*100;

figure; lineL = .5;
for i=1:numElectrode
        
        spike = electrode(i,:);
        rasterTime=[]; trial=[];
        rasterTime=time(spike~=0); rasterTime=rasterTime';
        trial=i*ones(size(rasterTime));
         
        plot([rasterTime(:)'; rasterTime(:)'], [trial(:)'+lineL/2; trial(:)'-lineL/2], 'k', 'LineWidth', lw); hold on;
        
end

%scale bar
scaleX = range(window)/scaleBar; %\mus
plot([window(1) window(1)+scaleX], [0.2 0.2], '-b', 'LineWidth', lw);       
xlim([window]);

set(gca,'xtick',[],'ytick',[])
box on; hold off;



