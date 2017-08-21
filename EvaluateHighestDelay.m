function HighestDelay = EvaluateHighestDelay(solution)

%pairs = neighbourSolution.pairs;
%routes = neighbourSolution.routes;
lambda = solution.lambda;

Matrizes;
miu= R*1e9/(8*1000);            % capacidade em bits / pacotes de 1000bytes -> pacotes/sec
lambda_s= T*1e6/(8*1000);       % packet arrival rate
gama= sum(sum(lambda_s));       % trafego total na rede (packets/sec)
d= L*1e3/2e8;                   % velocidade propagacao / vel da luz na fibra optica

AverageDelay= (lambda./(miu-lambda)+lambda.*d);
AverageDelay(isnan(AverageDelay))= 0;
AverageDelay= 2*sum(sum(AverageDelay))/gama;

HighestDelay = AverageDelay;

end