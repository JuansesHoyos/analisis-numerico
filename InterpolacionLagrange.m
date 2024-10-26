function InterpolacionLagrange()

x = input ('Ingrese los valores de x con el formato [x0, x1, x2, ...]: ');
y = input ('Ingrese los valores de y con el formato [y0, y1, y2, ...]: ');

xi = input ('Ingrese el valor a interpolar: ');

n = length(x);
l = ones(n, 1);
p = zeros(n, 1);

for i = 1:n
    for j = i:n
        if i ~= j
            l(i) = l(i) * (xi - x(j)) / (x(i) - x(j));
        end
    end
    p(i) = l(i) * y(i);
end 

    valorInterpolado = sum(p);

    disp(['El valor interpolado en xi=', num2str(xi), ' es: ', num2str(valorInterpolado)]);
end