%%% portfolio flood, gsua ver. Febr. 2017
%%% manual version 
%%% load gsuaFer.csv
%%% figure, plot(sij(:,1),sij(:,2),'or'), hold on, plot([0,1],0+1.0*[0,1])
%%% xlabel('S_i'); ylabel('S_{ij}'); 


%%% automated version 

function createfigure(X1, Y1)
%CREATEFIGURE(X1, Y1)
%  X1:  vector of x data
%  Y1:  vector of y data

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(X1,Y1,'Marker','o','LineStyle','none','Color',[1 0 0]);

% Create xlabel
xlabel('S_i');

% Create ylabel
ylabel('S_{ij}');

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 1]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[0 1]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontWeight','bold');


