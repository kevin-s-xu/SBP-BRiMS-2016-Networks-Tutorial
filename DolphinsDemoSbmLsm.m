% Demo of stochastic block model (SBM) and latent space model (LSM) fits to
% Dolphin social network data from Mark Newman's website:
% http://www-personal.umich.edu/~mejn/netdata/
%
% This demo was part of a tutorial by Kevin S. Xu and James R. Foulds at
% the SBP-BRiMS 2016 conference and is designed to be executed 1 line at a
% time rather than running the entire script at once.
%
% Data reference:
% D. Lusseau, K. Schneider, O. J. Boisseau, P. Haase, E. Slooten, and S. M.
% Dawson. The bottlenose dolphin community of Doubtful Sound features a
% large proportion of long-lasting associations. Behavioral Ecology and
% Sociobiology, 54:396-405, 2003.

%#ok<*NOPTS>
load('Dolphins.mat')

%% Fit stochastic block model (SBM) to data

% Examine adjacency matrix and eigenvalues
spy(adj)
[U,S,V] = svd(adj);
plot(diag(S),'x')

% Fit SBM with 2 classes by first estimating class memberships using
% spectral clustering
c = spectralClusterSbm(adj,2,struct());
histogram(c)
c'

% Compute maximum-likelihood estimates of edge probabilities from adjacency
% matrix and class assignments
[W,logLik] = estimateSbmProb(adj,c,struct());
logLik
% Convert estimated edge probabilities from vector to 2x2 matrix for easier
% interpretation
W = blockvec2mat(W,false)
imagesc(W)
colormap gray
colorbar

% Re-order nodes by class memberships and re-examine adjacency matrix
[cSorted,sortIdx] = sort(c);
cSorted'
figure(2)
spy(adj(sortIdx,sortIdx))

% Repeat fit with 3 classes
[c,Z,S] = spectralClusterSbm(adj,3,struct());
figure(1)
histogram(c)
c'
[W,logLik] = estimateSbmProb(adj,c,struct());
logLik
W = blockvec2mat(W,false)
imagesc(W)
colormap gray
colorbar
[cSorted,sortIdx] = sort(c);
cSorted'
figure(2)
spy(adj(sortIdx,sortIdx))

% Compute clustering coefficient of the actual network
clustCoeff = clusteringCoefficient(adj)

% Simulate new networks from SBM fit to compare how well the SBM replicates
% the clustering coefficient of the actual network
nRuns = 100;
clustCoeffSbm = zeros(1,nRuns);
for run = 1:nRuns
    adjSim = generateSbm(c,W,false);
    clustCoeffSbm(run) = clusteringCoefficient(adjSim);
end
histogram(clustCoeffSbm)
mean(clustCoeffSbm)

%% Fit latent space model (LSM) to data

% Fit LSM using 2 latent dimensions
tic; [posEst,biasEst,logLik] = estimateLsm(adj,2,2); toc;
logLik

% Compare network visualization using fitted latent positions to
% force-directed layout
figure(1)
plot(graph(adj),'xdata',posEst(:,1),'ydata',posEst(:,2))
figure(2)
plot(graph(adj))

% Simulate new networks from LSM fit to compare how well the LSM replicates
% the clustering coefficient of the actual network
clustCoeffLsm = zeros(1,nRuns);
for run = 1:nRuns
    adjSim = generateLsm(posEst,biasEst);
    clustCoeffLsm(run) = clusteringCoefficient(adjSim);
end
histogram(clustCoeffLsm)
mean(clustCoeffLsm)

% Fit LSM in 3 dimensions for comparison
tic; [posEst,biasEst,logLik] = estimateLsm(adj,3,2); toc;
logLik
% Simulate new networks from latent space model fit
clustCoeffLsm = zeros(1,nRuns);
for run = 1:nRuns
    adjSim = generateLsm(posEst,biasEst);
    clustCoeffLsm(run) = clusteringCoefficient(adjSim);
end
histogram(clustCoeffLsm)
mean(clustCoeffLsm)
