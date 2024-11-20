function funcionRegresionLineal
% Solicitar los datos experimentales desde la consola
x = input('Ingresa los valores del eje X (por ejemplo, [0, 1, 2, 3]): ');
y = input('Ingresa los valores del eje Y (por ejemplo, [1.1, 2.0, 2.9]): ');

% Verificar que ambos vectores tengan el mismo tamaño
if length(x) ~= length(y)
    error('Los vectores x e y deben tener la misma longitud');
end

% Número de puntos
n = length(x);

% Cálculo de los coeficientes de la recta y = mx + b
sum_x = sum(x);         % Suma de x
sum_y = sum(y);         % Suma de y
sum_xy = sum(x .* y);   % Suma del producto x*y
sum_x2 = sum(x .^ 2);   % Suma de los cuadrados de x

% Fórmulas para pendiente (m) e intersección (b)
m = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x^2);
b = (sum_y - m * sum_x) / n;

% Mostrar la ecuación de la recta
fprintf('La ecuación de la recta es: y = %.2fx + %.2f\n', m, b);

% Generar valores para la recta
x_fit = linspace(min(x), max(x), 100); % Valores continuos de x para la gráfica
y_fit = m * x_fit + b;                 % Valores correspondientes de y

% Graficar datos y recta de ajuste
figure;
scatter(x, y, 'b', 'filled'); % Graficar puntos experimentales
hold on;
plot(x_fit, y_fit, 'r', 'LineWidth', 2); % Graficar la recta de ajuste
title('Ajuste por Regresión Lineal');
xlabel('X');
ylabel('Y');
legend('Datos Experimentales', 'Recta de Ajuste');
grid on; % Asegúrate de que no haya caracteres especiales en esta línea
hold off;
