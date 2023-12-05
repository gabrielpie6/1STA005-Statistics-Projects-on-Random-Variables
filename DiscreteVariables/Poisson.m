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

% Função para calcular o valor esperado de uma variável aleatória
function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e alfa
sx = 0:1:6;
alfa = 1

% Cálculos da PMF e CDF
px = poissonpmf(alfa, sx);
fx = poissoncdf(alfa, sx);

% Valor esperado
E = expectedValue(sx, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(sx, px, 'b');
title('Poisson PMF (\alpha = 1)');
xlabel("Espaço amostral");
ylabel('P_X(x)');
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(sx, fx, 'r');
title('Poisson CDF (\alpha = 1)');
xlabel("Espaço amostral");
ylabel('F_X(x)');
axis square
