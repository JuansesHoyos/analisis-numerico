function metodoEuler()

while true
    funcion_str = input('Ingrese la función en términos de x y y: ', 's');
    fTest = str2func(['@(x, y) ' funcion_str]);
    try
        valoresPrueba = fTest(1, 1);
        if isnumeric(valoresPrueba)
            break;
        else
            error('La función no es valida.');
        end
    catch
        disp('La función ingresada no es válida, intente nuevamente.');
    end
end

h = inputNumeric('Ingrese el tamaño de h: ');
x0 = inputNumeric('Ingrese el valor de x0: ');
y0 = inputNumeric('Ingrese el valor de y0: ');
n = inputNumeric('Ingrese el valor de n a aproximar: ');

f= str2func(['@(x, y) ' funcion_str]);

if derivadaCero(f, x0, y0)
    disp('Error: La derivada es cero.');
    return;
end

x = x0:h:n;
y = zeros(size(x));
y(1) = y0;

iteraciones = (0:length(x)-1)';
valores_x = x';
valores_y = zeros(length(x), 1);
valores_y(1) = y0;

for i = 1:(length(x) -1)
    y(i+1) = y(i) + h * f(x(i), y(i));
    valores_y(i+1) = y(i+1);
end

tabla = table(iteraciones, valores_x, valores_y, 'VariableNames', { ...
    'Iteración', 'x', 'y'});
disp(tabla);

plot(x, y, '-o')
xlabel('X')
ylabel('y')
title('Método Euler')
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

function isZero = derivadaCero(f, x0, y0)
    epsilon = 1e-6;
    derivada = f(x0 + epsilon, y0) - f(x0, y0);
    isZero = abs(derivada) < epsilon;
end