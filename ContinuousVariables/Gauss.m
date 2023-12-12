clear all clc clf

% Função adicional para processamento da função gausscdf()
function y=phi(x)
  sq2=sqrt(2);
  y= 0.5 + 0.5*erf(x/sq2);
endfunction

function f=gausspdf(mu,sigma,x)
  f=exp(-(x-mu).^2/(2*sigma^2))/...
  sqrt(2*pi*sigma^2);
endfunction

function f=gausscdf(mu,sigma,x)
  f=phi((x-mu)/sigma);
endfunction



% Função para calcular o valor esperado de uma variável aleatória contínua gaussiana
function E = expectedValue(a, b, mu, sigma)
  f = @(x) exp(-(x-mu).^2/(2*sigma^2))/sqrt(2*pi*sigma^2);
  E = quadcc(@(x) x .* f(x), a, b);
endfunction


% Espaço amostral e parâmetros
sx = 0:0.05:4;
mu = 2;
sigma = 0.5;

% Cálculo da PMF e CDF
px = gausspdf(mu, sigma, sx);
fx = gausscdf(mu, sigma, sx);

% Valor esperado
E = expectedValue(-inf, inf, mu, sigma)

% Plot da PMF
figure(1);
subplot(1,2,1);
plot(sx, px, 'b-');
title('Gauss PMF (\mu = 2, \sigma = 0.5)');
xlabel("Espaço amostral");
ylabel('f_X(x)');
axis square

% Plot da CDF
figure(1);
subplot(1,2,2);
plot(sx, fx, 'r-');
title('Gauss CDF (\mu = 2, \sigma = 0.5)');
xlabel("Espaço amostral");
ylabel("F_X(x)");
axis square
