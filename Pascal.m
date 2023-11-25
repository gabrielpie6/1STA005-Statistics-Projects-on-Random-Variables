clear all clc clf

function pmf=pascalpmf(k,p,x)
%For Pascal (k,p) rv X, and
%input vector x, output is a
%vector pmf: pmf(i)=Prob[X=x(i)]
x=x(:);
n=max(x);
i=(k:n-1)';
ip= [1 ;(1-p)*(i./(i+1-k))];
%pb=all n-k+1 pascal probs
pb=(p^k)*cumprod(ip);
okx=(x==floor(x)).*(x>=k);
%set bad x(i)=k to stop bad indexing
x=(okx.*x) + k*(1-okx);
% pmf(i)=0 unless x(i) >= k
pmf=okx.*pb(x-k+1);
endfunction

function cdf=pascalcdf(k,p,x)
%Usage: cdf=pascalcdf(k,p,x)
%For a pascal (k,p) rv X
%and input vector x, the output
%is a vector cdf such that
% cdf(i)=Prob[X<=x(i)]
x=floor(x(:)); % for noninteger x(i)
allx=k:max(x);
%allcdf holds all needed cdf values
allcdf=cumsum(pascalpmf(k,p,allx));
%x_i < k have zero-prob,
% other values are OK
okx=(x>=k);
%set zero-prob x(i)=k,
%just so indexing is not fouled up
x=(okx.*x) +((1-okx)*k);
cdf= okx.*allcdf(x-k+1);
cdf = cdf';
endfunction

function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e parametro
sx = 0:1:9;
p  = 0.4;
k  = 3;

% Calculo da PMF e CDF
px = pascalpmf(k, p, sx);
fx = pascalcdf(k, p, sx);
px = px';

% Valor esperado
E = expectedValue(sx, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(sx, px, 'b');
title("Poisson PMF (p = 0.4; k = 3)");
xlabel("Espaco amostral");
ylabel("PX(x)");
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(sx, fx, 'r');
title("Poisson CDF (p = 0.4; k = 3)");
xlabel("Espaco amostral");
ylabel("FX(x)");
axis square
