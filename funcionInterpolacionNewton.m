function [polinomio, tablaDiferencias] = funcionInterpolacionNewton()
    
    % Solicitar puntos xi y yi desde la consola.
    try
        xi = input('Introduce los valores de xi como un vector (ejemplo: [1, 2, 3]): ');
        yi = input('Introduce los valores de yi como un vector (ejemplo: [2, 3, 5]): ');
    catch
        error('Error: Los valores ingresados deben ser vectores válidos.');
    end

    % Validar que xi y yi sean vectores y tengan la misma longitud.
    if ~isvector(xi) || ~isvector(yi)
        error('Error: xi y yi deben ser vectores.');
    elseif length(xi) ~= length(yi)
        error('Error: Los vectores xi y yi deben tener la misma longitud.');
    end

    % Inicializar la tabla de diferencias divididas.
    n = length(xi);
    tablaDiferencias = zeros(n, n);
    tablaDiferencias(:,1) = yi(:); % Asegurarse de que yi sea una columna.

    % Calcular la tabla de diferencias divididas.
    for j = 2:n
        for i = 1:n-j+1
            tablaDiferencias(i,j) = (tablaDiferencias(i+1,j-1) - tablaDiferencias(i,j-1)) / (xi(i+j-1) - xi(i));
        end
    end

    % Extraer los coeficientes b0, b1, ..., bn.
    coeficientes = diag(tablaDiferencias);

    % Construir el polinomio de Newton.
    syms x; % Variable simbólica para el polinomio.
    polinomio = coeficientes(1);
    terminoProducto = 1; % Inicializar el término de producto acumulativo.

    for k = 2:n
        terminoProducto = terminoProducto * (x - xi(k-1));
        polinomio = polinomio + coeficientes(k) * terminoProducto;
    end

    % Mostrar los resultados en la consola.
    fprintf('\nEl polinomio de interpolación de Newton es:\n');
    disp(polinomio);
    
    fprintf('La tabla de diferencias divididas es:\n');
    disp(array2table(tablaDiferencias, 'VariableNames', compose('D%d', 0:n-1)));

    % Graficar los puntos dados y el polinomio de Newton
    f = matlabFunction(polinomio); % Convertir el polinomio simbólico a una función
    x_range = linspace(min(xi) - 1, max(xi) + 1, 400); % Rango para la gráfica
    y_range = f(x_range); % Evaluar el polinomio en el rango

    figure; % Crear nueva figura
    plot(xi, yi, 'ro', 'MarkerFaceColor', 'r'); % Puntos originales en rojo
    hold on;
    plot(x_range, y_range, 'b-', 'LineWidth', 2); % Polinomio interpolante en azul
    xlabel('x');
    ylabel('y');
    title('Polinomio de Interpolación de Newton');
    legend('Puntos originales', 'Polinomio Interpolante');
    grid on;
end
