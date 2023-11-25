clear all clc clf

function pmf=geometricpmf(p,x)
%geometric(p) rv X
%out: pmf(i)=Prob[X=x(i)]
x=x(:);
pmf= p*((1-p).^(x-1));
pmf= (x>0).*(x==floor(x)).*pmf;
pmf = pmf';
endfunction

function cdf=geometriccdf(p,x)
% for geometric(p) rv X,
%For input vector x, output is vector
%cdf such that cdf_i=Prob(X<=x_i)
x=(x(:)>=1).*floor(x(:));
cdf=1-((1-p).^x);
cdf = cdf';
endfunction

function E = expectedValue(sx, px)
  v = sx .* px;
  E = sum(v);
endfunction

% Espaço amostral e parametro
sx = 0:1:6;
p  = 0.5;

% Calculo da PMF e CDF
px = geometricpmf(p, sx);
fx = geometriccdf(p, sx);

% Valor esperado
E = expectedValue(sx, px)

% Plot da PMF
figure(1);
subplot(1,2,1);
stem(sx, px, 'b');
title("Geometrica PMF (p = 0.5)");
xlabel("Espaco amostral");
ylabel("PX(x)");
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
stem(sx, fx, 'r');
title("Geometrica CDF (p = 0.5)");
xlabel("Espaco amostral");
ylabel("FX(x)");
axis square
