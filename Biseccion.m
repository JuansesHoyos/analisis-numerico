function [raiz, iteraciones] = Biseccion()

% func_str = input('Ingrese la función f(x): ');

func_str = ('@(x)x^3-x-2');

f = str2func(func_str);

n = input('Ingrese el número de iteraciones: ');
a = input('Ingrese el extremo inferior del intervalo: ');
b = input('Ingrese el extremo superior del intervalo: ');

tolerancia = 100;

iteraciones = 0;
while (b - a)/2 > tolerancia && iteraciones < n
    pm = (a + b)/2;

    if f(pm) == 0
        break;
    elseif f(a) * f(pm) < 0
        b = pm;
    else
        a = pm;
    end

    iteraciones = iteraciones + 1;
end

raiz = (a + b)/2

fprintf('La raíz aproximada es: %.10f\n', raiz);

end 