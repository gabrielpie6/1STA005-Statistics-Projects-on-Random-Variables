clear all clf clf

% Função para calcular a função de densidade de probabilidade (pdf) de uma variável aleatória uniform
function f=uniformpdf(a,b,x)
  % input : minimo a, maximo b e vetor de amostras x
  % output: vetor f, onde y_i = fx(x_i) (uniform pdf de x)

  % variavel aleatoria uniform de acordo com x
  f=((x>=a) & (x<b))/(b-a);
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória uniform
function F=uniformcdf(a,b,x)
  % input : minimo a, maximo b e vetor de amostras x

  F = 1/2 * (abs(a-b) + abs(a-x) - abs(b-x))/(abs(a-b));
endfunction


% Função para calcular o valor esperado de uma variável aleatória uniforme
function E = expectedValue(a, b)
  E = (b+a)/2;
endfunction

% Espaço amostral e parâmetros
a = 3;    % minimo
b = 10;   % maximo
x = 0:0.05:12;

% Cálculo da PMF e CDF
px = uniformpdf(a, b, x);
fx = uniformcdf(a, b, x);

% Valor esperado
E = expectedValue(a, b)

% Plot da PMF
figure(1);
subplot(1,2,1);
plot(x, px, 'b-');
title('Uniform PMF (a = 3, b = 10)');
xlabel("Espaço amostral");
ylabel('f_X(x)');
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
plot(x, fx, 'r-');
title('Uniform CDF (a = 3, b = 10)');
xlabel("Espaço amostral");
ylabel("F_X(x)");
axis square
