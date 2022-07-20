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
d = length(x); //FUNCAO 2
outer = 0;
for ii = 1:d
    inner = 0;
    for jj = 1:ii
        xj = x(jj);
        inner = inner + xj^2;
    end
    outer = outer + inner;
end
y = outer;

/*f = Sphere Function
regiao = x_i pertencente ao intervalo [-5.12, 5.12]
chute inicial = [-2.5, 2.5, 1.0, 3.0]
x = [0;0;0;0]
f(x) = 0
*/
d = length(x); //FUNCAO 3
sum = 0;
for ii = 1:d
    xi = x(ii);
    sum = sum + xi^2;
end
y = sum;

/*f = Sum of Different Powers Function
regiao = x_i pertencente ao intervalo [-1,1]
chute inicial = [-0.9, 0.9]
x = [0;0]
f(x) = 0
*/
d = length(x); //FUNCAO 4
sum = 0;
for ii = 1:d
    xi = x(ii);
    new = (abs(xi))^(ii+1);
    sum = sum + new;
end
y = sum;

/*f = Sum Squares Function
regiao = x_i pertencente ao intervalo [-10,10]
chute inicial = [-9;9]
x = [0;0]
f(x) = 0
*/

d = length(x); //FUNCAO 5
sum = 0;
for ii = 1:d
    xi = x(ii);
    sum = sum + ii*xi^2;
end
y = sum;

/*f = Booth Function
regiao = x_i pertencente ao intervalo [-10,10]
chute inicial = [-9;9]
x = [1;3]
f(x) = 0
*/    
y = (x(1) + 2*x(2) - 7)^2 + (2*x(1) + x(2) - 5)^2; //FUNCAO 6

/*f = Matyas Function
regiao = x_i pertencente ao intervalo [-10,10]
chute inicial = [-9;9]
x = [0;0]
f(x) = 0
*/
y = 0.26 * (x(1)^2 + x(2)^2) + (-0.48*x(1)*x(2)); //FUNCAO 7

