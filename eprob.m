function [eX] = eprob(X)
% Modified by M Convertino, Jan. 2017
% clear all, close all 
% eprob: calculates the exceedance probability for n column vectors in the
%        array [m n] X, where m are the observations. The probability is 
%        output in percent. eX is output as a structure (see Output Arguments).
%
% Usage: eX = eprob(X);
%
% Input Arguments:
%
%   X - [m n] vector where m are the observations and n are the number of
%   datasets for which the exceedance probability is to be calculated. 
%   The size of m must be the same for all datasets.
%
% Output Arguments:
%
%   eX - structure array containing all output data
%   ex.data - input data X [m n]
%   ex.r - the number of rows, m
%   ex.c - the number of datasets (columns), n
%   ex.sort - X input data sorted in descending order
%   ex.rank - single column matrix of the sorted data rank
%   ex.eprob - calculated exceedance probability (rank/m+1)
%
% Example:
%
%   X = randn(1000,1) % create randomly distributed dataset with 1000 values
%   eX = eprob(X);
%
% Author: Jeff A. Tuhtan
% e-mail address: jtuhtan@gmail.com
% Release: 1.0
% Release date: 20.08.2010


Scap = 10; % active operational energy storage capacity
% Scap = StorCapPercent eX average annual generation
eX = struct;

eX.data = X;
eX.r = size(eX.data,1); % no. rows
eX.c = size(eX.data,2); % no. cols

eX.sort = sort(eX.data,'descend'); % sorts data in descending order
eX.rank = (1:eX.r)';
eX.eprob = zeros(eX.r,1);
eX.eprob = eX.rank./(eX.r+1);

% plotting eeXceedance probability curve (in %)
% figure, 
% plot(eX.eprob * 100,eX.sort,'-','LineWidth',2,'Color',[.8 .8 .8]);
% xlabel('Exceedance Probability (%)','FontWeight','Bold');
% ylabel('Value','FontWeight','Bold');
% 
% 
% 
% figure,
% loglog(eX.sort,eX.eprob * 100,'-','LineWidth',2,'Color',[.8 .8 .8]);
% ylabel('Exceedance Probability (%)','FontWeight','Bold');
% xlabel('Value','FontWeight','Bold');
% 
% title('1986',... 
%   'FontWeight','bold')








figure, 
plot(eX.eprob * 100,eX.sort,'-','LineWidth',2);
xlabel('Exceedance Probability (%)','FontWeight','Bold');
ylabel('Value','FontWeight','Bold');



figure,
loglog(eX.sort,eX.eprob * 100,'-m','LineWidth',2);
ylabel('Exceedance Probability (%)','FontWeight','Bold');
xlabel('Value','FontWeight','Bold');



% title('1986',... 
  % 'FontWeight','bold')