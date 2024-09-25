function AjusteDeCurvas

Y= input('Ingrese el  vector Y (ejemplo: [1 2 3 4]): ');
A= input('Ingrese la matrix A (ejemplo: [1, 2; 3, 4]): ');

% Cálculo de la transpuesta de A
AT = A';

% Producto de AT con A
ATxA = AT * A;

% Producto de AT con Y
ATxY = AT * Y;

% calcular u
u = inv(ATxA) * ATxY;  

% Mostrar el resultado
fprintf('El resultado es:\n');
disp(u);



%Graficar los puntos y el modelo
x = [1 -2 3 4];
y = [4 5 -1 1];

scatter(x, y, 'filled');
title('Nube de puntos')
xlabel('X')
ylabel('Y')
grid on;
hold on;
plot(x, y, '-o');  
hold off;

