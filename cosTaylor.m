function cosTaylor

n = input('Digite el valor de n: ');
x = input('Digite el valor a calcular: ');
suma = 0;

for i= 0:n
    suma = suma + ((-1)^i) * ((x^(2*i))/factorial(2*i));
end

fprintf('El resultado es: %d \n', suma)

