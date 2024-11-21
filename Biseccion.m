function [raiz, iteraciones] = Biseccion()

func_str = input('Ingrese la función f(x): ', 's');
func_str = ['@(x) ', func_str];

f = str2func(func_str);
%func_str = input('Ingrese la función f(x): ', 's');
%func_str = ['@(x) ', func_str];

%func_str = ('@(x)x^3-x-2');

%f = str2func(func_str);

n = inputNumeric('Ingrese el número de iteraciones: ');
a = inputNumeric('Ingrese el extremo inferior del intervalo: ');
b = inputNumeric('Ingrese el extremo superior del intervalo: ');

tolerancia = 1e-6;

valores_a = [];
valores_b = [];
valores_pm = [];
valores_n = [];

iteraciones = 0;
while (b - a)/2 > tolerancia && iteraciones < n
    pm = (a + b)/2;

    valores_a = [valores_a; a];
    valores_b = [valores_b; b];
    valores_pm = [valores_pm; pm];
    valores_n = [valores_n; iteraciones];

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

tabla = table(valores_n, valores_a, valores_b, valores_pm, 'VariableNames', { ...
    'Interación', 'a', 'b', 'pm'});
disp(tabla);

fprintf('La raíz aproximada es: %.10f\n', raiz);

x = linspace(min(valores_a), max(valores_b), 100);
y = arrayfun(f, x);
plot(x, y, '-o')
xlabel('x')
ylabel('f(x)')
title('Método de Bisección')
grid on
end

function num = inputNumeric(prompt)
    while true
        userInput = input(prompt, 's');
        num = str2double(userInput);
        if ~isnan(num);
            break;
        else
            disp('Por favor ingrese un número válido.');
        end
    end
end