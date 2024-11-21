function metodoEuler()
    % Crear la figura principal
    fig = uifigure('Name', 'Método de Euler', 'Position', [100, 100, 800, 600]);

    % Panel para las entradas
    panelInputs = uipanel(fig, 'Title', 'Entradas', 'Position', [20, 350, 360, 200]);

    % Etiquetas y campos de entrada para la función y valores iniciales
    uilabel(panelInputs, 'Text', 'Función f(x, y):', 'Position', [10, 140, 100, 22]);
    inputFunction = uieditfield(panelInputs, 'text', 'Position', [120, 140, 200, 22]);

    uilabel(panelInputs, 'Text', 'x0:', 'Position', [10, 100, 100, 22]);
    inputX0 = uieditfield(panelInputs, 'numeric', 'Position', [120, 100, 200, 22]);

    uilabel(panelInputs, 'Text', 'y0:', 'Position', [10, 70, 100, 22]);
    inputY0 = uieditfield(panelInputs, 'numeric', 'Position', [120, 70, 200, 22]);

    uilabel(panelInputs, 'Text', 'h (Tamaño de paso):', 'Position', [10, 40, 100, 22]);
    inputH = uieditfield(panelInputs, 'numeric', 'Position', [120, 40, 200, 22]);

    uilabel(panelInputs, 'Text', 'Valor final n:', 'Position', [10, 10, 100, 22]);
    inputN = uieditfield(panelInputs, 'numeric', 'Position', [120, 10, 200, 22]);

    % Botón para calcular el método de Euler
    calcButton = uibutton(fig, 'Text', 'Calcular', ...
        'Position', [140, 300, 120, 40], 'ButtonPushedFcn', @(~,~)calculateEuler());

    % Tabla para mostrar los resultados
    resultsTable = uitable(fig, 'Position', [400, 350, 360, 200], ...
        'ColumnName', {'Iteración', 'x', 'y'}, 'Tag', 'ResultsTable');

    % Axes para la gráfica
    ax = uiaxes(fig, 'Position', [50, 50, 700, 250]);
    title(ax, 'Método de Euler');
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');

    % Función para calcular el método de Euler
    function calculateEuler()
        % Obtener valores ingresados por el usuario
        try
            funcionStr = inputFunction.Value;
            f = str2func(['@(x, y) ' funcionStr]);
            x0 = inputX0.Value;
            y0 = inputY0.Value;
            h = inputH.Value;
            n = inputN.Value;
        catch
            uialert(fig, 'Por favor ingrese valores válidos.', 'Error', 'Icon', 'error');
            return;
        end

        % Validar función y valores iniciales
        try
            fTest = f(x0, y0);
            if ~isnumeric(fTest)
                error('La función no es válida.');
            end
        catch
            uialert(fig, 'La función ingresada no es válida. Intente nuevamente.', 'Error', 'Icon', 'error');
            return;
        end

        % Validar tamaño de paso
        if h <= 0
            uialert(fig, 'El tamaño de paso (h) debe ser mayor a cero.', 'Error', 'Icon', 'error');
            return;
        end

        % Calcular puntos con el método de Euler
        x = x0:h:n;
        y = zeros(size(x));
        y(1) = y0;

        iteraciones = (0:length(x) - 1)';
        valores_x = x';
        valores_y = zeros(length(x), 1);
        valores_y(1) = y0;

        for i = 1:(length(x) - 1)
            y(i + 1) = y(i) + h * f(x(i), y(i));
            valores_y(i + 1) = y(i + 1);
        end

        % Actualizar la tabla de resultados
        resultsTable.Data = [iteraciones, valores_x, valores_y];

        % Graficar los resultados
        cla(ax);
        plot(ax, x, y, '-o', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'Aproximación');
        legend(ax, 'Location', 'Best');
    end
end
