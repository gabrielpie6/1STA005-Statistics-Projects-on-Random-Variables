clear all clf clf

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória uniform
function F=uniformcdf(a,b,x)
  % input : minimo a, maximo b e vetor de amostras x
  % output: vetor f, onde y_i = FX(x_i) (uniform cdf de x)

  % variavel aleatoria uniform de acordo com x
  F=(x-a+1).*((x>=a) & (x<b))/(b-a);
  F=F+1.0*(x>=b);
endfunction

% Função para calcular a função de densidade de probabilidade (pdf) de uma variável aleatória uniform
function f=uniformpdf(a,b,x)
  % input : minimo a, maximo b e vetor de amostras x
  % output: vetor f, onde y_i = fx(x_i) (uniform pdf de x)

  % variavel aleatoria uniform de acordo com x
  f=((x>=a) & (x<b))/(b-a);
endfunction

% Função para gerar um vetor de amostras de uma variável aleatória uniform
function x=uniformrv(a,b,m)
  % input : minimo a, maximo b e quantidade de amostras m
  % output: vetor de m elementos, onde x(i) é uma amostra de X

  % variavel aleatoria uniform (a,b)
  x=a+(b-a)*rand(m,1);
endfunction

% Função para calcular o valor esperado de uma variável aleatória
function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e parâmetros
a = 3;    % minimo
b = 10;   % maximo
x = 0:12;

% Cálculo da PMF e CDF
px = uniformpdf(a, b, x);
fx = uniformcdf(a, b, x);

% Valor esperado
E = expectedValue(x, px);

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(x, px, 'b');
title('Uniform PMF (a = 3, b = 10)');
xlabel("Espaço amostral");
ylabel('P_X(x)');
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(x, fx, 'r');
title('Uniform CDF (a = 3, b = 10)');
xlabel("Espaço amostral");
ylabel("F_X(x)");
axis square
