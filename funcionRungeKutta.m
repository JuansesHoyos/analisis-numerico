function funcionRungeKutta()
    % Crear la figura principal para la interfaz gráfica.
    fig = uifigure('Position', [100, 100, 800, 600], 'Name', 'Método de Runge-Kutta de 4to Orden');

    % Panel para las entradas
    panelInputs = uipanel(fig, 'Title', 'Entradas', 'Position', [20, 350, 360, 200]);
    
    % Etiquetas y campos de entrada para los valores de la función, x0, y0, h, y n.
    uilabel(panelInputs, 'Text', 'Introduce la función: ', 'Position', [10, 140, 100, 22]);
    inputFunction = uieditfield(panelInputs, 'text', 'Position', [120, 140, 200, 22]);

    uilabel(panelInputs, 'Text', 'Valor de x0:', 'Position', [10, 100, 100, 22]);
    inputX0 = uieditfield(panelInputs, 'numeric', 'Position', [120, 100, 200, 22]);

    uilabel(panelInputs, 'Text', 'Valor de y0:', 'Position', [10, 70, 100, 22]);
    inputY0 = uieditfield(panelInputs, 'numeric', 'Position', [120, 70, 200, 22]);

    uilabel(panelInputs, 'Text', 'Tamaño del h:', 'Position', [10, 40, 100, 22]);
    inputH = uieditfield(panelInputs, 'numeric', 'Position', [120, 40, 200, 22]);

    uilabel(panelInputs, 'Text', 'Número de pasos:', 'Position', [10, 10, 100, 22]);
    inputN = uieditfield(panelInputs, 'numeric', 'Position', [120, 10, 200, 22]);
    
    % Botón para ejecutar el cálculo.
    btnCalcular = uibutton(fig, 'push', 'Text', 'Calcular', ...
        'Position', [140, 300, 120, 40], 'ButtonPushedFcn', @(~,~)calcularRungeKutta());
    
    % Área para mostrar la tabla de resultados.
    tablaResultados = uitable(fig, 'Position', [400, 350, 360, 200],...
        'ColumnName', {'Iteración', 'k1', 'xk2', 'yk2', 'k2', 'xk3', 'yk3', 'k3', 'xk4', 'yk4', 'k4', 'yii'});

    % Área de los ejes donde se mostrará el gráfico.
    ax = uiaxes(fig, 'Position', [50, 50, 700, 250]);
    title(ax, 'Método de Runge-Kutta de 4to Orden');
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');

function calcularRungeKutta()
    % Obtener los valores ingresados por el usuario.
    try
        funcionStr = inputFunction.Value;
        f = str2func(['@(x, y) ' funcionStr]);
        x0 = inputX0.Value;
        y0 = inputY0.Value;
        h = inputH.Value;
        n = inputN.Value;
    catch
        uialert(fig, 'Por favor ingrese valores válidos para la función y los parámetros.', 'Error', 'Icon', 'error');
        return;
    end

    % Validar entradas.
    if n <= x0
        uialert(fig, 'El valor final (n) debe ser mayor que x0.', 'Error', 'Icon', 'error');
        return;
    end

    if mod((n - x0), h) ~= 0
        uialert(fig, 'El valor final (n) debe ser consistente con el tamaño de paso (h).', 'Error', 'Icon', 'error');
        return;
    end

    % Inicializar variables.
    x = x0;
    y = y0;
    M2 = {}; % Tabla de resultados.
    M5 = zeros(1, n); % Vector de valores de x.
    M4 = zeros(1, n); % Vector de valores de y.

    % Iteraciones del método de Runge-Kutta de 4to orden.
    for i = 1:n
        if i == 1
            % Primera iteración.
            k1 = f(x0, y0);
            xk2 = x0 + (1/2) * h;
            yk2 = y0 + (1/2) * k1 * h;
            k2 = f(xk2, yk2);
            xk3 = x0 + (1/2) * h;
            yk3 = y0 + (1/2) * k2 * h;
            k3 = f(xk3, yk3);
            xk4 = x0 + h;
            yk4 = y0 + k3 * h;
            k4 = f(xk4, yk4);

            % Calcular el siguiente valor de y.
            yii = y0 + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
            xi = x0;

            % Guardar resultados.
            M2 = num2cell([i, k1, xk2, yk2, k2, xk3, yk3, k3, xk4, yk4, k4, yii]);
            M5(i) = xi;
            M4(i) = yii;
        else
            % Iteraciones posteriores.
            xi = xi + h;
            yi = yii;

            k1 = f(xi, yi);
            xk2 = xi + (1/2) * h;
            yk2 = yi + (1/2) * k1 * h;
            k2 = f(xk2, yk2);
            xk3 = xi + (1/2) * h;
            yk3 = yi + (1/2) * k2 * h;
            k3 = f(xk3, yk3);
            xk4 = xi + h;
            yk4 = yi + k3 * h;
            k4 = f(xk4, yk4);

            % Calcular el siguiente valor de y.
            yii = yi + (1 / 6) * (k1 + 2 * k2 + 2 * k3 + k4);

            % Guardar resultados.
            M3 = num2cell([i, k1, xk2, yk2, k2, xk3, yk3, k3, xk4, yk4, k4, yii]);
            M2 = [M2; M3];
            M5(i) = xi;
            M4(i) = yii;
        end
    end

    % Mostrar los resultados en la tabla.
    tablaResultados = findobj(fig, 'Type', 'uitable');
    tablaResultados.Data = cell2mat(M2);

    % Graficar los resultados en los ejes dentro de la misma interfaz.
    ax = findobj(fig, 'Type', 'axes');
    cla(ax);  % Limpiar los ejes antes de volver a dibujar
    plot(ax, M5, M4, '-o', 'LineWidth', 2, 'MarkerSize', 6, 'MarkerFaceColor', 'r');
    grid(ax, 'on');
    title(ax, 'Método de Runge-Kutta de 4to Orden');
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    legend(ax, 'Solución aproximada');
end
end