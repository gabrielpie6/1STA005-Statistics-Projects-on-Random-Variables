clear all clc clf

% Função para calcular a função de densidade de probabilidade (pdf) de uma variável aleatória exponencial
function f=exponentialpdf(lambda,x)
  % Para a variável aleatória exponencial(lambda) X
  % e vetor de entrada x, a saída é um
  % vetor f tal que f(i)=f_X(x(i))
  f=lambda*exp(-lambda*x);
  f=f.*(x>=0);
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória exponencial
function F=exponentialcdf(lambda,x)
  % Para a variável aleatória exponencial(lambda) X
  % e vetor de entrada x, a saída é um
  % vetor F tal que F(i)=F_X(x(i))
  F=1.0-exp(-lambda*x);
endfunction

% Função para calcular o valor esperado de uma variável aleatória contínua exponencial
function E = expectedValue(a, b, lambda)
  f = @(x) lambda * exp(-lambda .* x);
  E = quadcc(@(x) x .* f(x), a, b);
endfunction

% Espaço amostral e parâmetro
sx = 0:0.05:9;
lambda = 1;

% Cálculo da PDF e CDF
px = exponentialpdf(lambda, sx);
fx = exponentialcdf(lambda, sx);

% Valor esperado
E = expectedValue(0, inf, lambda)

% Plot da PDF
figure(1);
subplot(1,2,1);
plot(sx, px, 'b-');
title('Exponencial PDF (\lambda = 1)');
xlabel("Espaço amostral");
ylabel('f_X(x)');
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
plot(sx, fx, 'r-');
title('Exponencial CDF (\lambda = 1)');
xlabel("Espaço amostral");
ylabel('F_X(x)');
axis square
