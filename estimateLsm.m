function [posEst,biasEst,logLik,exitFlag,output] = estimateLsm(adj,dim, ...
    initBias)
%estimateLsm Estimate parameters for latent space model for networks
%   posEst = estimateLsm(adj) fits a 2-D latent space model to the network
%   with adjacency matrix adj and returns the estimated node positions in
%   the latent space. The likelihood of the parameters is iteratively
%   maximized to reach a local maximum, beginning with a multidimensional
%   scaling initialization.
%
%   Note: this function applies only to undirected networks!
%
%   Inputs:
%   adj - n x n adjacency matrix of the network, where n is the # of nodes.
%
%   Optional inputs:
%   dim - Dimensionality of latent space. Higher dimension offers a more
%         flexible model but greater risk of overfitting. (Default: 2)
%   initBias - Initial value of the bias parameter in the latent space
%              model. Higher values should be used for denser networks.
%              (Default: 0)
%
%   Outputs:
%   posEst - n x dim matrix of estimated node positions in the latent
%            space. Each row denotes the latent position for a node.
%   biasEst - Estimated bias parameter.
%   logLik - Log-likelihood (up to a constant) of the model parameters.
%   exitFlag - Exit flag of the optimization routine. See documentation for
%              the fminsearch() function for more information.
%   output - Output struct of the optimization routine. See documentation
%            for the fminsearch() function for more information.

% Author: Kevin S. Xu


if nargin < 2
    dim = 2;
end
if nargin < 3
    initBias = 0;
end

n = size(adj,1);

% Choose initial position by multidimensional scaling on the geodesic
% distance matrix obtained from adjacency matrix
disp('Initializing node positions in latent space by multidimensional scaling')
initDist = distances(graph(adj));
% Set nodes with no paths to higher geodesic distance than diameter (required
% if network is disconnected)
initDist(isinf(initDist)) = max(initDist(~isinf(initDist))) + 1;
optStat = statset('TolX',1e-3*n,'Display','final');
initPos = mdscale(initDist,dim,'Options',optStat);

% Iteratively maximize likelihood using fminsearch() function
disp('Iteratively maximizing likelihood of latent space model')
% Convert adjacency matrix to vectorized form of lower triangle to remove
% redundant entries
adj = squareform(adj);
% Log-likelihood function where x is an (n+1)-by-dim matrix with
% x(1:n,1:dim) = pos and x(n+1,1) = bias
negLogLikFun = @(x) -logLikelihoodLsm(adj,x(1:n,1:dim),x(n+1,1));
xInit = zeros(n+1,dim);
xInit(1:n,1:dim) = initPos;
xInit(n+1,1) = initBias;
optOptim = optimset('Display','final','TolFun',0.1,'TolX',0.1*n, ...
    'MaxFunEvals',5000*n,'MaxIter',5000*n);
[xOpt,logLik,exitFlag,output] = fminsearch(negLogLikFun,xInit,optOptim);
posEst = xOpt(1:n,1:dim);
biasEst = xOpt(n+1,1);

end

