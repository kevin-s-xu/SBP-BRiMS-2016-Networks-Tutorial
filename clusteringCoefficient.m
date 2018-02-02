function clustCoeff = clusteringCoefficient(adj)
%clusteringCoefficient Compute clustering coefficient for network
%   clusteringCoefficient(adj) computes the clustering coefficient for the
%   network with adjacency matrix adj. If the network is directed, the
%   clustering coefficient is calculated for the undirected network created
%   by ignoring edge directions, i.e. reciprocating all directed edges.

% Author: Kevin S. Xu

if ~isequal(adj,adj')
    adj = max(adj,adj');
end

n = size(adj,1);
pathsLen2 = adj^2;
pathsLen2(diag(true(n,1))) = 0;
clustCoeff = trace(adj^3) / sum(pathsLen2(:));

end

