function arctanTaylor
suma = 0;
y = input('Desea el resultado en radianes o grados? \n 1. Radianes \n 2. Grados \n');
n = inputNumeric('Digite el valor de iteraciones n: ');
x = inputNumeric('Digite el valor a aproximar "x": ');

for i = 0:n
    suma = suma + ((-1)^i) * (x^(2*i+1) / (2*i+1))
end

radian = suma * (pi/180);
switch y
    case 1
        fprintf('El resultado en radianes es: %d ', radian);
    case 2
        fprintf('El resultado en grados es: %d ', suma);
end
end

function num = inputNumeric(prompt)
    while true
        userInput = input(prompt, 's');
        num = str2double(userInput);
        if ~isnan(num);
            break;
        else
            disp('Por favor ingrese un número válido.');
        end
    end
end