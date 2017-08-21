function solution = BuildNeighbourLoad(solution, i)

matrices;
lambda_s = T * 1e6 / (8*1000); % pck arrival rate
miu = R * 1e9 / (8*1000);
d = L * 1e3 / 2e8;

origin = solution.pairs(i,1);
destination = solution.pairs(i,2);
r = solution.routes(i,:);

% remove as cargas deste link
j = 1;
while r(j) ~= destination
    solution.lambda(r(j),r(j+1)) = solution.lambda(r(j),r(j+1)) - lambda_s(origin,destination);
    solution.lambda(r(j+1),r(j)) = solution.lambda(r(j+1),r(j)) - lambda_s(destination,origin);
    j= j+1;
end

% recalcula o caminho mais curto

Load= solution.lambda./miu;
r = ShortestPathSym(Load.^2, origin, destination);
solution.routes(i,:) = r;

j = 1;
% recompute the lambda
while r(j) ~= destination
    solution.lambda(r(j),r(j+1)) = solution.lambda(r(j),r(j+1)) + lambda_s(origin,destination);
    solution.lambda(r(j+1),r(j))= solution.lambda(r(j+1),r(j)) + lambda_s(destination,origin);
    j= j+1;
end

end