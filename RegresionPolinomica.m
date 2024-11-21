function RegresionPolinomica()
    % Crear la figura principal
    fig = uifigure('Name', 'Regresión Polinómica', 'Position', [100, 100, 800, 600]);

    % Panel para las entradas
    panelInputs = uipanel(fig, 'Title', 'Entradas', 'Position', [20, 350, 360, 200]);

    % Etiquetas y campos de entrada para x e y
    uilabel(panelInputs, 'Text', 'Valores de x:', 'Position', [10, 140, 100, 22]);
    inputX = uieditfield(panelInputs, 'text', 'Position', [120, 140, 200, 22]);

    uilabel(panelInputs, 'Text', 'Valores de y:', 'Position', [10, 100, 100, 22]);
    inputY = uieditfield(panelInputs, 'text', 'Position', [120, 100, 200, 22]);

    % Botón para calcular el ajuste
    calcButton = uibutton(panelInputs, 'Text', 'Calcular Ajuste', ...
        'Position', [120, 20, 120, 40], 'ButtonPushedFcn', @(~,~)calculateFit());

    % Tabla para mostrar los resultados
    uitable(fig, 'Position', [400, 350, 360, 200], ...
        'ColumnName', {'x', 'y_original', 'y_ajustado'}, 'Tag', 'ResultsTable');

    % Axes para la gráfica
    ax = uiaxes(fig, 'Position', [50, 50, 700, 250]);
    title(ax, 'Regresión Polinómica');
    xlabel(ax, 'x');
    ylabel(ax, 'y');
    grid(ax, 'on');

    % Función para calcular el ajuste polinómico
    function calculateFit()
        % Obtener valores de x e y ingresados por el usuario
        try
            x = str2num(inputX.Value); 
            y = str2num(inputY.Value);
        catch
            uialert(fig, 'Por favor ingrese vectores válidos.', 'Error', 'Icon', 'error');
            return;
        end

        if isempty(x) || isempty(y) || length(x) ~= length(y)
            uialert(fig, 'Los vectores x e y deben tener el mismo tamaño.', 'Error', 'Icon', 'error');
            return;
        end

        % Ajuste polinómico de segundo orden
        degree = 2;
        coefficients = polyfit(x, y, degree);
        y_fit = polyval(coefficients, x);

        % Actualizar la tabla de resultados
        resultsTable = findobj(fig, 'Tag', 'ResultsTable');
        resultsTable.Data = [x', y', y_fit'];

        % Graficar los datos originales y el ajuste
        x_fine = linspace(min(x), max(x), 500);
        y_fine = polyval(coefficients, x_fine);

        cla(ax);
        plot(ax, x, y, 'bo', 'MarkerSize', 8, 'DisplayName', 'Datos Originales');
        hold(ax, 'on');
        plot(ax, x_fine, y_fine, '-r', 'LineWidth', 2, 'DisplayName', 'Ajuste Polinómico');
        legend(ax, 'Location', 'Best');
    end
end
