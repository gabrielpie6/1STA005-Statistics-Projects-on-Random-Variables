clear all clc clf

% Função para calcular a função de massa de probabilidade (pmf) de uma variável aleatória de Pascal
function pmf=pascalpmf(k,p,x)
  % Para a variável aleatória de Pascal (k,p) X, e
  % vetor de entrada x, a saída é um
  % vetor pmf: pmf(i)=Prob[X=x(i)]
  x=x(:);
  n=max(x);
  i=(k:n-1)';
  ip= [1 ;(1-p)*(i./(i+1-k))];
  % pb=todas as probabilidades de pascal n-k+1
  pb=(p^k)*cumprod(ip);
  okx=(x==floor(x)).*(x>=k);
  % define x(i) ruim=k para parar indexação ruim
  x=(okx.*x) + k*(1-okx);
  % pmf(i)=0 a menos que x(i) >= k
  pmf=okx.*pb(x-k+1);
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória de Pascal
function cdf=pascalcdf(k,p,x)
  % Para uma variável aleatória de Pascal (k,p) X
  % e vetor de entrada x, a saída
  % é um vetor cdf tal que
  % cdf(i)=Prob[X<=x(i)]
  x=floor(x(:)); % para x(i) não inteiro
  allx=k:max(x);
  % allcdf contém todos os valores cdf necessários
  allcdf=cumsum(pascalpmf(k,p,allx));
  % x_i < k têm probabilidade zero,
  % outros valores estão OK
  okx=(x>=k);
  % define x(i) de probabilidade zero=k,
  % apenas para que a indexação não seja estragada
  x=(okx.*x) +((1-okx)*k);
  cdf= okx.*allcdf(x-k+1);
  cdf = cdf';
endfunction

% Função para calcular o valor esperado de uma variável aleatória
function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e parâmetro
sx = 0:1:9;
p  = 0.4;
k  = 3;

% Cálculo da PMF e CDF
px = pascalpmf(k, p, sx);
fx = pascalcdf(k, p, sx);
px = px';

% Valor esperado
E = expectedValue(sx, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(sx, px, 'b');
title("Pascal PMF (p = 0.4; k = 3)");
xlabel("Espaço amostral");
ylabel('P_X(x)');
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(sx, fx, 'r');
title("Pascal CDF (p = 0.4; k = 3)");
xlabel("Espaço amostral");
ylabel('F_X(x)');
axis square