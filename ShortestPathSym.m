function [route]= ShortestPathSym(custos,origem,destino)

R= [0  1  0  0  1  0  0  0  0  0  1  0  0  0  0  0  0
    1  0  1  0  1  0  0  0  0  0  0  0  0  0  0  0  0
    0  1  0  1  0  1  0  0  0  0  0  0  0  0  0  0  0
    0  0  1  0  1  1  0  0  0  0  0  0  0  0  0  0  0
    1  1  0  1  0  0  1  0  0  0  1  0  0  0  0  0  0
    0  0  1  1  0  0  1  0  1  0  0  1  0  0  0  0  0
    0  0  0  0  1  1  0  1  0  0  0  0  0  0  0  0  0
    0  0  0  0  0  0  1  0  1  0  1  0  1  0  0  0  0
    0  0  0  0  0  1  0  1  0  1  0  0  0  0  0  0  0
    0  0  0  0  0  0  0  0  1  0  0  1  0  0  1  0  0
    1  0  0  0  1  0  0  1  0  0  0  0  0  1  0  0  0
    0  0  0  0  0  1  0  0  0  1  0  0  0  0  0  1  0
    0  0  0  0  0  0  0  1  0  0  0  0  0  1  1  0  0
    0  0  0  0  0  0  0  0  0  0  1  0  1  0  0  0  0
    0  0  0  0  0  0  0  0  0  1  0  0  1  0  0  0  1
    0  0  0  0  0  0  0  0  0  0  0  1  0  0  0  0  1
    0  0  0  0  0  0  0  0  0  0  0  0  0  0  1  1  0];

[n n1]=size(custos);
if n~=17 || n1~=17
    route=[-1];
elseif origem == destino || origem>17 || origem<1 || destino>17 || destino<1
    route=[-2];
elseif min(min(custos))<0
    route=[-3];
else
    custos= custos + custos.';
    S=zeros(1,n);
    S(origem)= 1;
    p=zeros(1,n);
    maximo= max(max(custos))*n+1;
    c=maximo*ones(1,n);
    c(origem)= 0;
    aux= origem;
    while S(destino) == 0
        for i = 1:17
            if R(aux,i)>0 && c(i)>(c(aux)+custos(aux,i))
                c(i)= c(aux)+custos(aux,i);
                p(i)= aux;
            end
        end
        aux= 0;
        cost= maximo;
        for i = 1:17
            if S(i)==0 && c(i)<cost
                aux= i;
                cost= c(i);
            end
        end
        if c(destino)==cost
            aux= destino;
        end
        S(aux)= 1;
    end
    route= [destino];
    aux= destino;
    while p(aux)~=origem
        route= [p(aux) route];
        aux= p(aux);
    end
    route= [origem route];
    route(17)= 0;
end
end

