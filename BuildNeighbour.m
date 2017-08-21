function solution = BuildNeighbour(solution, i)

matrices;
lambda_s = T * 1e6 / (8*1000); % pck arrival rate
miu = R * 1e9 / (8*1000);
d = L * 1e3 / 2e8;

origin = solution.pairs(i,1);
destination = solution.pairs(i,2);
r = solution.routes(i,:);

% compute the lambda(pckts/s) from our origin up to the destination
j = 1;
while r(j) ~= destination
    solution.lambda(r(j),r(j+1)) = solution.lambda(r(j),r(j+1)) - lambda_s(origin,destination);
    solution.lambda(r(j+1),r(j)) = solution.lambda(r(j+1),r(j)) - lambda_s(destination,origin);
    j= j+1;
end

delay = (1./(miu - solution.lambda) + d);           % delay as a metric
r = ShortestPathSym(delay, origin, destination);
solution.routes(i,:) = r;

j = 1;
% recompute the lambda
while r(j) ~= destination
    solution.lambda(r(j),r(j+1)) = solution.lambda(r(j),r(j+1)) + lambda_s(origin,destination);
    solution.lambda(r(j+1),r(j))= solution.lambda(r(j+1),r(j)) + lambda_s(destination,origin);
    j= j+1;
end

end