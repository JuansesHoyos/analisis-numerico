function [x_solucion, M] = funcionNewtonRaphson()
    % FUNCIONNEWTONRAPHSON Método de Newton-Raphson para encontrar raíces de funciones.
    % Solicita al usuario ingresar los datos necesarios por consola y realiza el cálculo
    % de la raíz de una función utilizando el método iterativo de Newton-Raphson.
    %
    % Salida:
    %   - x_solucion: Aproximación de la raíz encontrada.
    %   - M: Tabla de iteraciones que incluye xi, f(xi), f'(xi), la solución y el error relativo.
    %
    % Ejemplo de uso:
    %   Ejecutar la función y seguir las instrucciones en la consola.
    
    % Solicitar entrada desde la consola con validaciones.
    funcion = input('Introduce la función en términos de x (ejemplo: x^2-4): ', 's');
    try
        f = str2sym(funcion); % Validar si la función ingresada es simbólicamente correcta.
        x = sym('x'); % Declarar el símbolo 'x'.
        df = diff(f, x); % Derivada de la función.
    catch
        error('Error: La función ingresada no es válida. Verifica la sintaxis.');
    end

    xi = input('Introduce el valor inicial (xi): ');
    if ~isnumeric(xi) || ~isscalar(xi)
        error('Error: El valor inicial (xi) debe ser un número escalar.');
    end

    criterioDeParada = input('Introduce el criterio de parada (porcentaje de error): ');
    if ~isnumeric(criterioDeParada) || ~isscalar(criterioDeParada) || criterioDeParada <= 0
        error('Error: El criterio de parada debe ser un número positivo.');
    end

    format long; % Configurar formato numérico.

    % Inicializar variables.
    i = 0; % Contador de iteraciones.
    x_solucion = xi; % Aproximación inicial de la raíz.
    eA = 100; % Error relativo inicial.
    M = []; % Matriz para almacenar los resultados de cada iteración.

    % Método iterativo de Newton-Raphson.
    while eA > criterioDeParada
        xi1 = x_solucion; % Guardar el valor anterior de xi.
        
        % Evaluar función y derivada en el punto xi.
        try
            fxi = double(subs(f, x, xi)); % Valor de f(xi).
            dfxi = double(subs(df, x, xi)); % Valor de f'(xi).
        catch
            error('Error al evaluar la función o su derivada. Verifica la entrada.');
        end

        if dfxi == 0
            error('Error: La derivada de la función es cero en xi = %.6f. Método no aplicable.', xi);
        end

        % Actualizar la solución usando la fórmula de Newton-Raphson.
        x_solucion = xi - fxi / dfxi;
        i = i + 1; % Incrementar el contador de iteraciones.

        % Calcular el error relativo en iteraciones posteriores.
        if i == 1
            M(i, :) = [i, xi, fxi, dfxi, x_solucion, -1];
        else
            eA = abs(((x_solucion - xi1) / x_solucion) * 100); % Error relativo.
            M(i, :) = [i, xi, fxi, dfxi, x_solucion, eA];
        end

        % Verificar si se ha cumplido el criterio de parada.
        if eA <= criterioDeParada
            break;
        end

        xi = x_solucion; % Actualizar xi para la siguiente iteración.
    end

    % Mostrar los resultados en la consola.
    fprintf('\nSolución aproximada: %.6f\n', x_solucion);
    fprintf('Tabla de resultados:\n');
    disp(array2table(M, 'VariableNames', {'Iteración', 'xi', 'f(xi)', 'f''(xi)', 'x_siguiente', 'Error (%)'}));
end
