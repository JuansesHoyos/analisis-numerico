function InterpolacionLagrange()
    % Crear la figura principal para la interfaz gráfica.
    fig = uifigure('Position', [100, 100, 800, 600], 'Name', 'Interpolación de Lagrange');

    % Panel para las entradas
    panelInputs = uipanel(fig, 'Title', 'Entradas', 'Position', [20, 350, 360, 200]);

    % Etiquetas y campos de entrada para los valores de x y f(x).
    uilabel(panelInputs, 'Text', 'Función f(x):', 'Position', [10, 140, 100, 22]);
    inputFuncion = uieditfield(panelInputs, 'text', 'Position', [120, 140, 200, 22]);

    uilabel(panelInputs, 'Text', 'Valores de x en vector:', 'Position', [10, 100, 100, 22]);
    inputX = uieditfield(panelInputs, 'text', 'Position', [120, 100, 200, 22]);

    uilabel(panelInputs, 'Text', 'Valor a interpolar (xi):', 'Position', [10, 70, 100, 22]);
    inputXi = uieditfield(panelInputs, 'numeric', 'Position', [120, 70, 200, 22]);

    % Botón para calcular la interpolación.
    btnCalcular = uibutton(fig, 'Text', 'Calcular', ...
        'Position', [140, 300, 120, 40], 'ButtonPushedFcn', @(~,~) calcularInterpolacion());

        % Tabla para mostrar los resultados
    resultsTable = uitable(fig, 'Position', [400, 350, 360, 200], ...
        'ColumnName', {'Iteración', 'x', 'f(x)'}, 'Tag', 'ResultsTable');

    % Área de los ejes donde se mostrará el gráfico.
    ax = uiaxes(fig, 'Position', [50, 50, 700, 250]);
    title(ax, 'Interpolación de Lagrange');
    xlabel(ax, 'x');
    ylabel(ax, 'f(x)');
    grid(ax, 'on');

function calcularInterpolacion()
    % Obtener los valores ingresados por el usuario.
    try
        x = str2num(inputX.Value); % Convertir cadena de texto a vector.
        if isempty(x) || ~isvector(x)
            error('Los valores de x no son válidos.');
        end

        func_str = inputFuncion.Value;
        f = str2func(['@(x)', func_str]);

        xi = inputXi.Value;
        if isnan(xi)
            error('El valor de xi no es válido.');
        end
    catch
        uialert(fig, 'Por favor ingrese valores válidos para x, la función f(x) y xi.', 'Error', 'Icon', 'error');
        return;
    end

    % Calcular y usando la función dada.
    y = arrayfun(f, x);

    % Mostrar la tabla de valores en la consola.
    tabla = table(x', y', 'VariableNames', {'x', 'f(x)'});
    disp('Tabla de Valores');
    disp(tabla);

    resultsTable.Data = [x', y'];

    % Inicializar los coeficientes de interpolación.
    n = length(x);
    l = ones(n, 1);
    p = zeros(n, 1);

    for i = 1:n
        for j = 1:n
            if i ~= j
                l(i) = l(i) * (xi - x(j)) / (x(i) - x(j));
            end
        end
        p(i) = l(i) * y(i);
    end

    valorInterpolado = sum(p);

    % Mostrar el resultado en la consola.
    disp(['El valor interpolado en xi = ', num2str(xi), ' es: ', num2str(valorInterpolado)]);

    % Graficar la interpolación en los ejes de la interfaz.
    x_plot = linspace(min(x), max(x), 100);
    y_plot = zeros(size(x_plot));

    for k = 1:length(x_plot)
        xk = x_plot(k);
        lk = ones(n, 1);
        pk = 0;

        for i = 1:n
            for j = 1:n
                if i ~= j
                    lk(i) = lk(i) * (xk - x(j)) / (x(i) - x(j));
                end
            end
            pk = pk + lk(i) * y(i);
        end

        y_plot(k) = pk;
    end

    % Actualizar los ejes con la gráfica.
    ax = findobj(fig, 'Type', 'axes');
    cla(ax); % Limpiar los ejes antes de graficar.
    plot(ax, x_plot, y_plot, '-r', 'LineWidth', 2, 'DisplayName', 'Interpolación');
    hold(ax, 'on');
    scatter(ax, x, y, 'bo', 'filled', 'DisplayName', 'Puntos conocidos');
    scatter(ax, xi, valorInterpolado, 'kx', 'LineWidth', 2, 'DisplayName', 'Valor interpolado');
    legend(ax, 'Location', 'best');
    grid(ax, 'on');
    title(ax, 'Interpolación de Lagrange');
    xlabel(ax, 'x');
    ylabel(ax, 'f(x)');
    hold(ax, 'off');
end
end