function [polinomio, tablaDiferencias] = funcionInterpolacionNewton()
    % FUNCIONINTERPOLACIONNEWTON Calcula el polinomio de interpolación de Newton
    % y la tabla de diferencias divididas.
    %
    % Solicita los puntos (xi, yi) desde la consola y construye el polinomio.
    %
    % Salida:
    %   - polinomio: Polinomio simbólico de interpolación.
    %   - tablaDiferencias: Tabla de diferencias divididas.
    %
    % Ejemplo de uso:
    %   Ejecutar la función y seguir las instrucciones en la consola.
    
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

end
