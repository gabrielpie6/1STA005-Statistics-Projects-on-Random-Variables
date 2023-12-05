clear all clc clf

function I = numericalIntegrationTrap(f, a, b, n)
  dx = (b - a)/n;
  I=0;
  for i = 0:(n-1)
    I += (f(a + i*dx) + f(a + (i+1)*dx))/2 * dx;
  endfor
endfunction

f  = @(x) x.^2;
I  = numericalIntegrationTrap(f, 0, 1, 50)
I2 = quadgk(f, 0, 1)