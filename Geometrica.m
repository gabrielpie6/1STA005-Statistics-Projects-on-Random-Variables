clear all clc clf

% Função para calcular a função de massa de probabilidade (pmf) de uma variável aleatória geométrica
function pmf=geometricpmf(p,x)
  % Para a variável aleatória geométrica(p) X
  % e vetor de entrada x, a saída é um
  % vetor pmf tal que pmf(i)=Prob[X=x(i)]
  x=x(:);
  pmf= p*((1-p).^(x-1));
  pmf= (x>0).*(x==floor(x)).*pmf;
  pmf = pmf';
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória geométrica
function cdf=geometriccdf(p,x)
  % Para a variável aleatória geométrica(p) X
  % e vetor de entrada x, a saída é um
  % vetor cdf tal que cdf_i=Prob[X<=x_i]
  x=(x(:)>=1).*floor(x(:));
  cdf=1-((1-p).^x);
  cdf = cdf';
endfunction

% Função para calcular o valor esperado de uma variável aleatória
function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e parâmetro
sx = 0:1:6;
p  = 0.5;

% Cálculo da PMF e CDF
px = geometricpmf(p, sx);
fx = geometriccdf(p, sx);

% Valor esperado
E = expectedValue(sx, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(sx, px, 'b');
title("Geométrica PMF (p = 0.5)");
xlabel("Espaço amostral");
ylabel("P_X(x)");
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(sx, fx, 'r');
title("Geométrica CDF (p = 0.5)");
xlabel("Espaço amostral");
ylabel('F_X(x)');
axis square