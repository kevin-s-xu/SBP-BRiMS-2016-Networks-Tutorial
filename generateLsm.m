function [adj,affinity] = generateLsm(pos,bias)
%generateLsm Generate a network sample from the latent space model
%   adj = generateLsm(pos,bias) generates a network adjacency matrix from
%   the latent space model specified by the node positions (pos) and the
%   bias parameter.
%
%   Input:
%   pos - n x dim matrix of node positions in the latent space. Each row
%         denotes the latent position for a node. n denotes the number of
%         nodes, and dim denotes the dimensionality of the latent space.
%
%   Optional input:
%   bias - Bias parameter, where higher bias denotes higher edge
%          probabilities.
%
%   Outputs:
%   adj - n x n adjacency matrix of network sampled from model.
%   affinity - n x n matrix of node affinities, defined as the logit of the
%              edge probabilities.

% Author: Kevin S. Xu

if nargin < 2
    bias = 0;
end

logistic = @(x) 1 ./ (1 + exp(-x));

affinity = bias - pdist(pos);
dyadProb = logistic(affinity);
adj = rand(size(dyadProb));
adj(adj < dyadProb) = 1;
adj(adj ~= 1) = 0;

affinity = squareform(affinity);
adj = squareform(adj);

end

