function Taylor

n = input('Digite el valor de n: ');
x = input('Digite el valor a calcular: ');
suma = 0;

for i= 1:n
    suma = suma + (x^i)/factorial(i);
end

fprintf('El resultado es: %d \n', suma)

