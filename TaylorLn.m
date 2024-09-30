function TaylorLn
suma = 0;
y = input('Desea el resultado en radianes o grados? \n 1. Radianes \n 2. Grados \n');
n = input('Digite el valor de iteraciones n: ');
x = input('Digite el valor a aproximar "x": ');

for i = 1:n
    suma = suma + ((-1)^(i+1))*((x-1)^i)/i
end

radian = suma * (pi/180);
switch y
    case 1
        fprintf('El resultado en radianes es: %d ', radian);
    case 2
        fprintf('El resultado en grados es: %d ', suma);
end