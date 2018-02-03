function logLik = logLikelihoodLsm(adj,pos,bias)
%logLikelihoodLsm Compute log-likelihood of latent space model parameters
%   logLik = logLikelihoodLsm(adj,pos,bias) computes the log-likelihood of
%   the latent space model parameters pos (node positions) and bias given
%   the adjacency matrix adj.
%
%   Note: this function applies only to undirected networks!
%
%   Inputs:
%   adj - n x n adjacency matrix of the network, where n is the # of nodes.
%   pos - n x dim matrix of node positions in the latent space. Each row
%         denotes the latent position for a node.
%   bias - Bias parameter, where higher bias denotes higher edge
%          probabilities.
%
%   Output:
%   logLik - Log-likelihood of the latent space model parameters (up to a
%            constant).

% Author: Kevin S. Xu

% Convert adjacency matrix to vectorized form of lower triangle to remove
% redundant entries
if ~isvector(adj)
    adj = squareform(adj);
end

affinity = bias - pdist(pos);
logLik = sum( affinity.*adj - log(1 + exp(affinity)) );

end

