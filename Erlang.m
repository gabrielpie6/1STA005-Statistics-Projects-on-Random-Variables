clear all clc clf

function pmf=poissonpmf(alpha, x)
  %Poisson (alpha) rv X,
  %out = vector pmf: pmf(i)=P[X=x(i)]
  x = x(:);
  k=(1:max(x))';
  logfacts =cumsum(log(k));
  pb=exp([-alpha; ...
  -alpha+ (k*log(alpha))-logfacts]);
  okx=(x>=0).*(x==floor(x));
  x=okx.*x;
  pmf=okx.*pb(x+1);
  %pmf(i) = 0 para todo zero-prob x(i)
  pmf = pmf';
endfunction

function cdf=poissoncdf(alpha,x)
  %output cdf(i)=Prob[X<=x(i)]
  x=floor(x(:));
  sx=0:max(x);
  cdf=cumsum(poissonpmf(alpha,sx)');
  %cdf de 0 até max(x)
  okx=(x>=0);%x(i)<0 -> cdf=0
  x=(okx.*x);%nega x(i)=0
  cdf= okx.*cdf(x+1);
  %cdf = 0 para todo x(i) < 0
  cdf = cdf';
endfunction

function f = erlangpdf(n,lambda,x)
  f=((lambda^n)/factorial(n-1))...
  *(x.^(n-1)).*exp(-lambda*x);
endfunction

function F = erlangcdf(n, lambda, x)
  % F=1.0 - poissoncdf(n-1, lambda*x);

  % for i = 1:length(x)
    % X = x(i);
    % p = @(k) ((lambda * X).^k) / factorial(k);
    % s = sum(p([0:n-1]));
    % F(i) = 1.0 - exp(-lambda * X) * s;
  % endfor

  % Alteracao para variaveis discretas
  px = erlangpdf(n, lambda, x);
  F(1) = px(1);
  for i = 1:length(x)-1
    F(i+1) = F(i) + px(i+1);
  endfor
endfunction

function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction









% Espaço amostral e parametros
sx = 0:1:9;
n = 3;
lambda = 1;

% Calculo da PMF e CDF
px = erlangpdf(n, lambda, sx);
fx = erlangcdf(n, lambda, sx);

% Valor esperado
E = expectedValue(sx, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(sx, px, 'b');
title("Erlang PMF (n = 3, lambda = 1)");
xlabel("Espaco amostral");
ylabel("PX(x)");
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(sx, fx, 'r');
title("Erlang CDF (n = 3, lambda = 1)");
xlabel("Espaco amostral");
ylabel("FX(x)");
axis square
