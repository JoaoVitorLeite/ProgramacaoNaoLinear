
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

printf("Metodo de Nelder Mead\n")

tic()

x_inicial = [-9,9]
step = 0.8
melhora_thr = 10^(-5)
melhora_break = 10
maxIt = 200
alpha = 2
rho = 1
gamma = 0.5

dim = size(x_inicial)(2)
prev_best = funcao(x_inicial)
melhora = 0
res = []
res(1,:) = [x_inicial, prev_best]

for i = 1:dim
    x = x_inicial
    x(i) = x(i) + step
    f = funcao(x)
    res(i+1,:) = [x, f]
end

iters = 0

while 1
    
    [dummy,idx]=gsort(res(:,dim+1),"g","i");
    res=res(idx,:);
    
    best = res(1, dim+1)
    
    if maxIt && iters >= maxIt
        break
    end
    
    iters = iters + 1
    
    printf("Melhor ate agora : %f\n", best)
    
    if best < prev_best - melhora_thr
        melhora = 0
        prev_best = best
    else
        melhora = melhora + 1
    end
    
    if melhora >= melhora_break
        break
    end
    
    //centroide
    xc = zeros(dim)
    for i = 1:dim
        xc = xc + (res(i,1:dim)/dim)
    end
    
    //reflexao
    xr = xc + rho*(xc - res(dim+1, 1:dim))
    f_r = funcao(xr)
    if res(1, dim+1) <= f_r && f_r < res(dim, dim+1)
        res(dim+1,:) = [xr, f_r]
        continue
    end
    
    //expansao
    if f_r < res(1, dim+1)
        xe = xc + alpha*(res(dim+1, 1:dim) - xc)
        f_e = funcao(xe)
        
        if f_e < f_r
            res(dim+1,:) = [xe, f_e]
            continue
        else
            res(dim+1,:) = [xr, f_r]
            continue
        end
    end
    
    //contracao interna
    if f_r >= res(dim+1, dim+1)
        
        xcont1 = xc - gamma*(xc - res(dim+1,1:dim))
        f_cont1 = funcao(xcont1)
        
        if f_cont1 <= res(dim+1,dim+1)
            res(dim+1,:) = [xcont1, f_cont1]
            continue
        else
            for i = 2:dim+1
                res(i,1:dim) = res(1, 1:dim) + gamma*(res(i,1:dim) - res(1,1:dim))
                res(i,dim+1) = funcao(res(i,1:dim))
            end
        end
    end
    
    if res(dim, dim+1) <= f_r && f_r < res(dim+1,dim+1)
        xcont2 = xc + gamma*(xr - xc)
        f_cont2 = funcao(xcont2)
    end
    
    if f_cont2 <= f_r
        res(dim+1,:) = [xcont2, f_cont2]
        continue
    else
        for i = 2:dim+1
            res(i,1:dim) = res(1, 1:dim) + gamma*(res(i,1:dim) - res(1,1:dim))
            res(i,dim+1) = funcao(res(i,1:dim))
        end
    end
         
end

tempo = toc()

printf("\n\nNumero de iteracoes : %d\n", iters)
printf("Tempo de execucao : %f\n\n", tempo)
printf("Solucao : \n")
disp(res(1, 1:dim))
printf("\nValor da funcao: %f\n", res(1,dim+1))



