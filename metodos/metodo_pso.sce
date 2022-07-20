clc
clear

//Funcao
function y = funcao(x)
    /*f = x^2 + y^2 + 3x - 2y
    regiao = x_i pertencente ao intervalo [-10,10]
    chute inicial = [3;2]
    x = [-1.5;1]
    f(x) = -3.25
    */
    y = x(1)^2 + x(2)^2 + 3*x(1) - 2*x(2) //FUNCAO 1

    /*f = Rotated Hyper-Ellipsoid Function
    regiao = x_i pertencente ao intervalo [-65.536, 65.536]
    chute inicial = [-20;30;10]
    x = [0;0;0]
    f(x) = 0
    */
//    d = length(x); //FUNCAO 2
//    outer = 0;
//    for ii = 1:d
//        inner = 0;
//        for jj = 1:ii
//            xj = x(jj);
//            inner = inner + xj^2;
//        end
//        outer = outer + inner;
//    end
//    y = outer;

    /*f = Sphere Function
    regiao = x_i pertencente ao intervalo [-5.12, 5.12]
    chute inicial = [-2.5;2.5;1.0;3.0]
    x = [0;0;0;0]
    f(x) = 0
    */
//    d = length(x); //FUNCAO 3
//    sum = 0;
//    for ii = 1:d
//        xi = x(ii);
//        sum = sum + xi^2;
//    end
//    y = sum;

    /*f = Sum of Different Powers Function
    regiao = x_i pertencente ao intervalo [-1,1]
    chute inicial = [-0.9;0.9]
    x = [0;0]
    f(x) = 0
    */
//    d = length(x); //FUNCAO 4
//    sum = 0;
//    for ii = 1:d
//        xi = x(ii);
//        new = (abs(xi))^(ii+1);
//        sum = sum + new;
//    end
//    y = sum;

    /*f = Sum Squares Function
    regiao = x_i pertencente ao intervalo [-10,10]
    chute inicial = [-9;9]
    x = [0;0]
    f(x) = 0
    */
//    d = length(x); //FUNCAO 5
//    sum = 0;
//    for ii = 1:d
//        xi = x(ii);
//        sum = sum + ii*xi^2;
//    end
//    y = sum;

    /*f = Booth Function
    regiao = x_i pertencente ao intervalo [-10,10]
    chute inicial = [-9;9]
    x = [1;3]
    f(x) = 0
    */    
    //y = (x(1) + 2*x(2) - 7)^2 + (2*x(1) + x(2) - 5)^2; //FUNCAO 6

    /*f = Matyas Function
    regiao = x_i pertencente ao intervalo [-10,10]
    chute inicial = [-9;9]
    x = [0;0]
    f(x) = 0
    */
    //y = 0.26 * (x(1)^2 + x(2)^2) + (-0.48*x(1)*x(2)); //FUNCAO 7
endfunction

printf("Metodo PSO\n")

tic()

nVar = 2 //
xMin = -10 //
xMax = 10 //
vMin = -0.2*(xMax - xMin)
vMax = -vMin
wMax = 1
wMin = 0.2
MaxIt = 200
ps = 20
c1 = 2
c2 = 2
c1Min = 2.5
c1Max = 0.5
c2Min = 0.5
c2Max = 2.5
w = 1
tol = 10^(-5)

posicao = xMin + (xMax - xMin)*rand(ps, nVar, 'uniform')
velocidade = vMin + (vMax - vMin)*rand(ps, nVar, 'uniform')
custo = zeros(1, nVar)

for k = 1:ps
    custo(k) = funcao(posicao(k,:))
end

pbest = posicao
pbest_custo = custo
[elem index] = min(pbest_custo)
gbest = pbest(index, :)
gbest_custo = pbest_custo(index)
best_custo = zeros(1, MaxIt)

global_best_custo = %inf

for it = 1:MaxIt
    
    for i = 1:ps
        
        velocidade(i,:) = w * velocidade(i,:) + c1 * rand(1,nVar) .* (pbest(i,:) - posicao(i,:)) + c2 * rand(1,nVar) .* (gbest - posicao(i,:))

        for w = 1:nVar

            if velocidade(i,w) > vMax
                velocidade(i,w) = vMax
            end

            if velocidade(i,w) < vMin
                velocidade(i,w) = vMin
            end    

        end
            
        posicao(i,:) = posicao(i,:) + velocidade(i,:)

        for w = 1:nVar

            if posicao(i,w) > xMax
                posicao(i,w) = xMax
            end

            if posicao(i,w) < xMin
                posicao(i,w) = xMin
            end

        end
        
        custo(i) = funcao(posicao(i,:))
        
        if custo(i) < pbest_custo(i)
            pbest(i,:) = posicao(i,:)
            pbest_custo(i) = custo(i)
            
            if pbest_custo(i) < gbest_custo
                gbest = pbest(i,:)
                gbest_custo = pbest_custo(i)
            end
        
        end
        
    end
    best_custo(it) = gbest_custo
    
    if gbest_custo < global_best_custo
        global_best_posicao = gbest
        global_best_custo = gbest_custo
    end
    
    printf("Iteracao %d / Best cost = %f\n", it, gbest_custo)
    
    w = wMax - (it/MaxIt)*(wMax - wMin)
    c1 = (it/MaxIt)*(c1Max - c1Min) + c1Min
    c2 = (it/MaxIt)*(c2Max - c2Min) + c2Min
    
    if norm(velocidade) < tol
        break
    end
    
end

tempo = toc()

printf("\n\nNumero de iteracoes : %d\n", it)
printf("\nTempo de execucao: %f\n", tempo)
printf("\nValor de x encontrado:\n")
disp(global_best_posicao)
printf("\nValor de f(x):\n")
disp(global_best_custo)






