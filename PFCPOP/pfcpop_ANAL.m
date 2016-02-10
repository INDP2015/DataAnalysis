% Script to plot the channels on pfcpop with puzzling high correlations
% Take a look at them and make a good explanation!
% This clears the workspace at the beginning so be carefool!
% 
% You need to have the data file on the same folder, for now I'll just 
% copy the file, but make it better!
%
% mauricio.toro@neuro.fchampalimaud.org
% imakoopa2016

close all % Close all open figures
clear all % Clear Workspace

load pfcpop % load the PFCx data, 

% Y & Z = different decitions of the monkey given the same stim
%  calculating the covariance and correlations of all neurons on Y
 
N = size(Y,1);   % Pre-allocating for sanity
covn = zeros(N); % "
corn = zeros(N); % "

% Example of the wrong way!
%for i = 1:842
%    for j = 1:842
%        corN(i,j) = corr(Y(j,:)', Y(i,:)');
%    end
%end

corn = corr(Y');    % The right way of making so many correlations 
ncn = corn-eye(N);  % Let's take out the diagonal, everything it's correlated to itself
tncn = tril(ncn);   % let's only use the lower part of the matrix, the other it's the same
mc = max(max(ncn)); % what's the maximum value?
figure('Name','Correlation Matrix of Y'); % plot the corrected lower triangular matrix
imagesc(tncn); % I said plot it!
colorbar;      % let's have a way of understandig the color code
corV = .99;    % correlation threshold
[i,j] = find(tncn >= corV); % find every pair with high correlation
length(i) % how many pairs do we have? (i) many

%% This double comment will break the code and you can look at the value of i
%  before plotting everything, if you have 100 values, you'll get 100 plots...too many?

% Now we'll plot every pair of highly correlated neurons on different figures
% for each pair, well plot on red and green the neurons
for K = 1:length(i)
    figure
    plot(t,Y(i(K),:), 'r--', t,Y(j(K),:),'g.')
    title(['Corr = ', num2str(tncn(i,j)), ' ', num2str(i(K)), ':', num2str(j(K))])
end

% Tada! see anything interesting?
