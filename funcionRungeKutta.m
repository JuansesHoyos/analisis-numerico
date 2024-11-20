function [M2, M5, M4] = funcionRungeKutta()
    % FUNCIONRUNGEKUTTA Método de Runge-Kutta de 3er orden para resolver ecuaciones diferenciales.
    % Solicita los datos necesarios por consola y realiza los cálculos iterativos, además de graficar los resultados.
    %
    % Salidas:
    %   - M2: Tabla con los valores intermedios en cada iteración.
    %   - M5: Vector de valores de x en cada paso.
    %   - M4: Vector de valores de y en cada paso.
    %
    % Ejemplo de uso:
    %   Ejecutar la función y seguir las instrucciones en la consola.

    % Solicitar entrada desde la consola.
    try
        funcionMatematica = input('Introduce la función en términos de x e y (ejemplo: x+y): ', 's');
        f = str2func(['@(x,y)' funcionMatematica]); % Convertir a función anónima.
    catch
        error('Error: La función ingresada no es válida. Verifica la sintaxis.');
    end

    x = input('Introduce el valor inicial de x (x0): ');
    y = input('Introduce el valor inicial de y (y0): ');
    h = input('Introduce el tamaño del paso (h): ');
    n = input('Introduce el número de pasos (n): ');

    % Validaciones de entrada.
    if ~isnumeric(x) || ~isscalar(x)
        error('Error: x0 debe ser un número escalar.');
    end
    if ~isnumeric(y) || ~isscalar(y)
        error('Error: y0 debe ser un número escalar.');
    end
    if ~isnumeric(h) || ~isscalar(h) || h <= 0
        error('Error: h debe ser un número positivo.');
    end
    if ~isnumeric(n) || ~isscalar(n) || n <= 0 || mod(n,1) ~= 0
        error('Error: n debe ser un número entero positivo.');
    end

    % Inicializar variables.
    x0 = x;
    y0 = y;
    k1 = 0; k2 = 0; k3 = 0;
    yii = 0;
    xi = 0;

    M2 = {}; % Tabla de resultados inicializada como una celda vacía.
    M5 = zeros(1, n); % Vector de valores de x.
    M4 = zeros(1, n); % Vector de valores de y.

    % Iteraciones del método de Runge-Kutta de 3er orden.
    for i = 1:n
        yiSiguiente = yii;
        if i == 1
            % Primera iteración.
            k1 = f(x0, y0);
            xk2 = x0 + (1/2) * h;
            yk2 = y0 + (1/2) * k1 * h;
            k2 = f(xk2, yk2);
            xk3 = x0 + h;
            yk3 = y0 - k1 * h + 2 * k2 * h;
            k3 = f(xk3, yk3);

            % Calcular el siguiente valor de y.
            yii = y0 + (h / 6) * (k1 + 4 * k2 + k3);
            xi = x0;

            % Guardar resultados.
            M2 = num2cell([i, k1, xk2, yk2, k2, xk3, yk3, k3, yii]);
            M5(i) = xi;
            M4(i) = yii;
        else
            % Iteraciones posteriores.
            xi = xi + h;
            yi = yiSiguiente;

            k1 = f(xi, yi);
            xk2 = xi + (1/2) * h;
            yk2 = yi + (1/2) * k1 * h;
            k2 = f(xk2, yk2);
            xk3 = xi + h;
            yk3 = yi - k1 * h + 2 * k2 * h;
            k3 = f(xk3, yk3);

            % Calcular el siguiente valor de y.
            yii = yi + (h / 6) * (k1 + 4 * k2 + k3);

            % Guardar resultados.
            M3 = num2cell([i, k1, xk2, yk2, k2, xk3, yk3, k3, yii]);
            M2 = [M2; M3];
            M5(i) = xi;
            M4(i) = yii;
        end
    end

    % Mostrar los resultados en la consola.
    fprintf('\nTabla de resultados (M2):\n');
    disp(cell2table(M2, 'VariableNames', {'Iteración', 'k1', 'xk2', 'yk2', 'k2', 'xk3', 'yk3', 'k3', 'yii'}));
    fprintf('Vector de valores de x (M5):\n');
    disp(M5);
    fprintf('Vector de valores de y (M4):\n');
    disp(M4);

    % Graficar los resultados.
    figure;
    plot(M5, M4, '-o', 'LineWidth', 2, 'MarkerSize', 6, 'MarkerFaceColor', 'r');
    grid on;
    title('Método de Runge-Kutta');
    xlabel('x');
    ylabel('y');
    legend('Solución aproximada');
end
