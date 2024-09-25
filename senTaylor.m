function senTaylor

n = input('Digite el valor de n: ');
x = input('Digite el valor a calcular: ');
suma = 0;

for i= 0:n
    suma = suma + ((-1)^i) * ((x^(2*i+1))/factorial(2*i+1));
end

fprintf('El resultado es: %d \n', suma)

