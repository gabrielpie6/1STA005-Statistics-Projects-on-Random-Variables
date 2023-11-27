clear all clf clf

% Função para utilizar em binomialrv
function n=count(x,y)
  % n(i)= # de elementos de x <= y(i)
  [MX,MY]=ndgrid(x,y);
  % colunas de MX = x
  % linhas  de MY = y
  n=(sum((MX<=MY),1))';
endfunction

% Função para calcular a função de densidade de probabilidade (pdf) de uma variável aleatória binomial
function pmf=bignomialpmf(n,p,x)
  % binomial(n,p) rv X,
  % input : numero de observacoes n, probabilidade p e vetor de amostras x
  % output: vetor pmf, que é: Px(x(i))

  k=(0:n-1)';
  a=log((p/(1-p))*((n-k)./(k+1)));
  L0=n*log(1-p);
  L=[L0; L0+cumsum(a)];
  pb=exp(L);
  % pb=[P[X=0] ... P[X=n]]ˆt
  x=x(:);
  okx =(x>=0).*(x<=n).*(x==floor(x));
  x=okx.*x;
  pmf=okx.*pb(x+1);
endfunction

% Função para calcular a função de densidade de probabilidade (pdf) de uma variável aleatória binomial
function pmf=binomialpmf(n,p,x)
  % binomial(n,p) rv X,
  % input : numero de observacoes n, probabilidade p e vetor de amostras x
  % output: vetor pmf, que é: Px(x(i))

  if p<0.5
    pp=p;
  else
    pp=1-p;
  end
  i=0:n-1;
  ip= ((n-i)./(i+1))*(pp/(1-pp));
  pb=((1-pp)^n)*cumprod([1 ip]);
  if pp < p
    pb=fliplr(pb);
  end
  pb=pb(:); % pb=[P[X=0] ... P[X=n]]ˆt
  x=x(:);
  okx =(x>=0).*(x<=n).*(x==floor(x));
  x=okx.*x;
  pmf=okx.*pb(x+1);
endfunction

% Função para calcular a função de distribuição cumulativa (cdf) de uma variável aleatória binomial
function cdf=binomialcdf(n,p,x)
  % input : numero de observacoes n, probabilidade p e vetor de amostras x
  % output: vetor cdf, onde cdf(i)=P[X<=x(i)]

  x=floor(x(:)); %normaliza nao inteiros
  allx=0:max(x);
  % calcula cdf de 0 ate max(x)
  allcdf=cumsum(binomialpmf(n,p,allx));
  okx=(x>=0);            % x(i) < 0 tem probabilidade 0
  x=(okx.*x);            % seta os valores negativos para 0
  cdf= okx.*allcdf(x+1); % zero para probabilidades 0
endfunction

% Função para gerar um vetor de amostras de uma variável aleatória binomial
function x=binomialrv(n,p,m)
  % input : numero de observacoes n, probabilidade p e quantidade de amostras m
  % output: vetor x, onde x é o vetor de amostras

  r=rand(m,1);
  cdf=binomialcdf(n,p,0:n);
  x=count(cdf,r);
endfunction

% Função para calcular o valor esperado de uma variável aleatória
function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Parametros
n = 10;        % Numero de observacoes
p = 0.33;       % Probabilidade
x = 0:(n - 1); % Espaco amostral

% Calculos da PMF e CDF
pgx = bignomialpmf(n, p, x);
px = binomialpmf(n, p, x);
fx = binomialcdf(n, p, x);

% Valor esperado
E  = expectedValue(x, px);
Eg = expectedValue(x, pgx);

% Plot pmf usando binomial
figure(1);
subplot(2,2,1);
stem(0:(n - 1), px, 'b');
title("Binomial PMF (n = 10, p = 0.33)");
xlabel("Espaço amostral");
ylabel('P_X(x)');
axis square

% Plot pmf usando bignomial
figure(1);
subplot(2,2,2);
stem(0:(n - 1), pgx, 'b');
title("Bignomial PMF (n = 10, p = 0.33)");
xlabel("Espaço amostral");
ylabel('P_X(x)');
axis square

% Plot do cdf
figure(1);
subplot(2,2,3:4);
stem(0:(n - 1), fx, 'r');
title("Binomial CDF (n = 10, p = 0.33)");
xlabel("Espaco amostral");
ylabel('F_X(x)');
axis square
