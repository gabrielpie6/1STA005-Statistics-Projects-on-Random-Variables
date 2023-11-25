clear all clc clf

function f=exponentialpdf(lambda,x)
  f=lambda*exp(-lambda*x);
  f=f.*(x>=0);
endfunction

function F=exponentialcdf(lambda,x)
  F=1.0-exp(-lambda*x);
endfunction

function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e parametro
sx = 0:1:9;
lambda = 1;

% Calculo da PMF e CDF
px = exponentialpdf(lambda, sx);
fx = exponentialcdf(lambda, sx);

% Valor esperado
E = expectedValue(sx, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(sx, px, 'b');
title("Exponencial PMF (lambda = 1)");
xlabel("Espaco amostral");
ylabel("PX(x)");
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(sx, fx, 'r');
title("Exponencial CDF (lambda = 1)");
xlabel("Espaco amostral");
ylabel("FX(x)");
axis square