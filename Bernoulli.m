clear all clf clf

% Função para calcular a função de densidade de probabilidade (pdf) de uma variável aleatória bernoulli
function pv=bernoullipmf(p,x)
  % input: probabilidade p de sucesso de uma variavel aleatoria e vetor x de amostras
  % output: vetor pv, onde pv é: PX (x(i))

  %se x == 0, pv = 1-p, se x == 1, pv = p
  pv=(1-p)*(x==0) + p*(x==1);
  pv=pv(:);
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória bernoulli
function cdf=bernoullicdf(p,x)
  % input: probabilidade p de sucesso de uma variavel aleatoria e vetor x de amostras
  % output: vetor pv, onde pv(i)=Prob[X<=x(i)] (FX (x(i)))

  x=floor(x(:));
  allx=0:1;
  allcdf=cumsum(bernoullipmf(p,allx)); %soma cumulativa
  okx=(x>=0);                          %se x_i < 0, x_i = 0. x_i = 1 caso contrario
  x=(okx.*x);                          %seta os valores de x < 0 para 0
  cdf= okx.*allcdf(x + 1);
endfunction

% Função para gerar um vetor de amostras de uma variável aleatória bernoulli
function x=bernoullirv(p,m)
  % input: probabilidade p e quantidade de amostras m
  % output: m amostras bernoulli (p) rv (variavel aleatoria)

  r=rand(m,1);
  x=(r>=(1-p)); %se r_i for maior ou igual que 1-p, x_i = 1. x_i = 0 caso contrario
endfunction

% Função para calcular o valor esperado de uma variável aleatória
function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e parametro
p = 0.33;
x = 0:1;

% Calculos da PMF e CDF
px = bernoullipmf(p, x);
fx = bernoullicdf(p, x);

% Valor esperado
E = expectedValue(x, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(x, px, 'b');
title("Bernoulli PMF (p = 0.25)");
xlabel("Espaco amostral");
ylabel("PX(x)");
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(x, fx, 'r');
title("Bernoulli CDF (p = 0.25)");
xlabel("Espaco amostral");
ylabel("FX(x)");
axis square

