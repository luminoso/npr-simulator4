matrices;
miu= R*1e9/(8*1000);            % capacity in bits / packets of 1000bytes
NumberLinks= sum(sum(R>0));     % number of connections
lambda_s= T*1e6/(8*1000);       % packet arrival rate
gama= sum(sum(lambda_s));       % total network traffic (packets/sec)
d= L*1e3/2e8;                   % speed of propagation / speed of ligh in fiber network
pairs= [];

% connected nodes in a bidirectional path
for origin=1:16
    for destination=(origin+1):17
        if T(origin,destination)+T(destination,origin)>0
            pairs= [pairs; origin destination];
        end
    end
end
npairs= size(pairs,1);
lambda= zeros(17);
routes= zeros(npairs,17);

for i=1:npairs
    origin= pairs(i,1);
    destination= pairs(i,2);
    r= ShortestPathSym(d,origin,destination);
    routes(i,:)= r;
    j= 1;
    while r(j)~= destination
        lambda(r(j),r(j+1))= lambda(r(j),r(j+1)) + lambda_s(origin,destination);
        lambda(r(j+1),r(j))= lambda(r(j+1),r(j)) + lambda_s(destination,origin);
        j= j+1;
    end
end
Load= lambda./miu;
Load(isnan(Load))= 0;
MaximumLoad= max(max(Load))
AverageLoad= sum(sum(Load))/NumberLinks
AverageDelay= (lambda./(miu-lambda)+lambda.*d);
AverageDelay(isnan(AverageDelay))= 0;
AverageDelay= 2*sum(sum(AverageDelay))/gama
Delay_s= zeros(npairs,1);

for i=1:npairs
    origin= pairs(i,1);
    destination= pairs(i,2);
    r= routes(i,:);
    j= 1;
    while r(j)~= destination
        Delay_s(i)= Delay_s(i)+ 1/(miu(r(j),r(j+1)) - lambda(r(j),r(j+1))) + d(r(j),r(j+1));
        Delay_s(i)= Delay_s(i)+ 1/(miu(r(j+1),r(j)) - lambda(r(j+1),r(j))) + d(r(j+1),r(j));
        j= j+1;
    end
end

MaxAvDelay= max(Delay_s)
subplot(1,2,1)
printDelay_s= sortrows(Delay_s,-1);
plot(printDelay_s)
axis([1 npairs 0 1.1*MaxAvDelay])
title('Flow Delays')
subplot(1,2,2)
printLoad= sortrows(Load(:),-1);
printLoad= printLoad(1:NumberLinks);
plot(printLoad)
axis([1 NumberLinks 0 1])
title('Link Loads')