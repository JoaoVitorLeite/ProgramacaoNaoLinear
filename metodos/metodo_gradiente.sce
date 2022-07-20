
clc()
clear()

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

function grad = gradiente(x)
    xx = x'
    [L,C] = size(xx)
    g = zeros(C)
    for i = 1:C
        k = xx
        k(i) = xx(i) + delta
        g(i) = ((funcao(k) - funcao(xx))/delta)
    end
    grad = g
endfunction

printf("Metodo Gradiente")

tic()

x=[-9;9] //
[m n] = size(x)
delta = 10^(-5)
g = 1
ite = 0
Niteracoes = 200
tol = 10^(-5)

while (max(abs(g)) > tol && ite < Niteracoes)
    
    g = gradiente(x)
    d = -g
    
    a = 0.5
    alpha = 1
    
    while funcao(x + alpha*d) > (funcao(x) + a*g'*alpha*d)
        alpha = 0.5*alpha
    end
    
    x = x + alpha*d
    ite = ite + 1
    
end

tempo = toc()

printf("\nNumero de iteracoes: %d\n", ite)
printf("\nTempo de execucao: %f\n", tempo)
printf("\nValor de x encontrado:\n")
disp(x)
printf("\nValor de f(x): %f\n", funcao(x))







