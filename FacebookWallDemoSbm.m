% Demo of stochastic block model (SBM) fits to a subset of the Facebook
% wall post data collected by Viswanath et al. (2009) containing 181 nodes.
%
% This demo was part of a tutorial by Kevin S. Xu and James R. Foulds at
% the SBP-BRiMS 2016 conference and is designed to be executed 1 line at a
% time rather than running the entire script at once.
%
% Data reference:
% B. Viswanath, A. Mislove, M. Cha, & K. P. Gummadi (2009). On the evolution
% of user interaction in Facebook. In Proceedings of the 2nd ACM Workshop on
% Online Social Networks (pp. 37-42). https://doi.org/10.1145/1592665.1592675

%#ok<*NOPTS>
load('FacebookWallPosts.mat')

% Examine adjacency matrix and eigenvalues
spy(adj)
[U,S,V] = svd(adj);
plot(diag(S),'x')

% Fit SBM with 3 classes by first estimating class memberships using
% spectral clustering
c = spectralClusterSbm(adj,3,struct('directed',true));
histogram(c)
c'

% Compute maximum-likelihood estimates of edge probabilities from adjacency
% matrix and class assignments
[W,logLik] = estimateSbmProb(adj,c,struct('directed',true));
logLik
% Convert estimated edge probabilities from vector to 3x3 matrix for easier
% interpretation
W = blockvec2mat(W,true)
imagesc(W)
colormap gray
colorbar

% Re-order nodes by class memberships and re-examine adjacency matrix
[cSorted,sortIdx] = sort(c);
cSorted'
figure(2)
spy(adj(sortIdx,sortIdx))

% Compute reciprocity and clustering coefficient of actual network
m = nnz(adj);
recip = trace(adj^2)/m;
recip
clustCoeff = clusteringCoefficient(adj)

% Repeat with 5 classes
[c,Z,S] = spectralClusterSbm(adj,5,struct('directed',true));
figure(1)
histogram(c')
[W,logLik] = estimateSbmProb(adj,c,struct('directed',true));
logLik
W = blockvec2mat(W,true)
imagesc(W)
colormap gray
colorbar
[cSorted,sortIdx] = sort(c);
figure(2)
spy(adj(sortIdx,sortIdx))

% Simulate new networks from SBM fit to compare how well the SBM replicates
% the reciprocity and clustering coefficient of the actual network
nRuns = 100;
recipSbm = zeros(1,nRuns);
clustCoeffSbm = zeros(1,nRuns);
for run = 1:nRuns
    adjSim = generateSbm(c,W,true);
    recipSbm(run) = trace(adjSim^2)/nnz(adjSim);
    clustCoeffSbm(run) = clusteringCoefficient(adjSim);
end
mean(recipSbm)
mean(clustCoeffSbm)
