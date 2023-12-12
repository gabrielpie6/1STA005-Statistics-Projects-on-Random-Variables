clear all clc clf

% Função para calcular a função de massa de probabilidade (pmf) de uma variável aleatória de Poisson
function pmf=poissonpmf(alpha, x)
  % Variável aleatória de Poisson (alpha) X,
  % saída = vetor pmf: pmf(i)=P[X=x(i)]
  x = x(:);
  k=(1:max(x))';
  logfacts =cumsum(log(k));
  pb=exp([-alpha; ...
  -alpha+ (k*log(alpha))-logfacts]);
  okx=(x>=0).*(x==floor(x));
  x=okx.*x;
  pmf=okx.*pb(x+1);
  % pmf(i) = 0 para todo x(i) com probabilidade zero
  pmf = pmf';
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória de Poisson
function cdf=poissoncdf(alpha,x)
  % saída cdf(i)=Prob[X<=x(i)]
  x=floor(x(:));
  sx=0:max(x);
  cdf=cumsum(poissonpmf(alpha,sx)');
  % cdf de 0 até max(x)
  okx=(x>=0);% x(i)<0 -> cdf=0
  x=(okx.*x);% nega x(i)=0
  cdf= okx.*cdf(x+1);
  % cdf = 0 para todo x(i) < 0
  cdf = cdf';
endfunction

% Função para calcular a função de densidade de probabilidade (pdf) de uma variável aleatória de Erlang
function f = erlangpdf(n,lambda,x)
  f=((lambda^n)/factorial(n-1))...
  *(x.^(n-1)).*exp(-lambda*x);
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória de Erlang
function F = erlangcdf(n, lambda, sx)
  % Forma contínua pode ser calculada por
  % F = 1.0 - poissonpdf(n-1, lambda*x);

  % Alteração para variáveis discretas
  % px = erlangpdf(n, lambda, x);
  % F(1) = px(1);
  % for i = 1:length(x)-1
  %  F(i+1) = F(i) + px(i+1);
  % endfor

  f = @(x)((lambda^n)/factorial(n-1))*(x.^(n-1)).*exp(-lambda .* x);
  for i = 1:length(sx)
    F(i) = quadcc(f, 0, sx(i));
  endfor
endfunction

% Função para calcular o valor esperado de uma variável aleatória contínua de Erlang
function E = expectedValue(a, b, n, lambda)
  f = @(x) ((lambda^n)/factorial(n-1))*(x.^(n-1)).*exp(-lambda .* x);
  E = quadcc(@(x) x .* f(x), a, b);
endfunction

% Espaço amostral e parâmetros
sx = 0:0.05:9;
n = 3;
lambda = 1;

% Cálculo da PMF e CDF
px = erlangpdf(n, lambda, sx);
fx = erlangcdf(n, lambda, sx);

% Valor esperado
E = expectedValue(0, inf, n, lambda)

% Plot da PMF
figure(1);
subplot(1,2,1);
plot(sx, px, 'b-');
title('Erlang PMF (n = 3, \lambda = 1)');
xlabel("Espaço amostral");
ylabel('f_X(x)');
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
plot(sx, fx, 'r-');
title('Erlang CDF (n = 3, \lambda = 1)');
xlabel("Espaço amostral");
ylabel("F_X(x)");
axis square
