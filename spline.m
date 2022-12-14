clc;
clear;

times = [0 1.85 2.87 3.78 4.65 5.50 6.32 7.14 7.96 8.79 9.69];
dists = 0:10:100;

m = length(times) - 1;

#scatter(times, dists);
#hold on;
for i = 1:m
  h(i) = times(i+1) - times(i);
endfor

% Assuming a linear tendency on the extremes
A(1, 1) = 2*(h(1) + h(2));
A(1, 2) = h(2);
for i=2:m-2
  A(i, i-1) = h(i);
  A(i, i) = 2*(h(i) + h(i+1));
  A(i, i+1) = h(i+1);
endfor
A(m-1, m-2) = h(m-1); A(m-1, m-1) = 2*(h(m-1) + h(m));

for i=1:m-1
  B(i) = (dists(i+2) - dists(i+1))/h(i+1) - (dists(i+1) - dists(i))/h(i);
end

B = 6*B';

S = linsolve(A, B);
S = [0; S; 0]

for i=1:m
  a(i) = (S(i+1) - S(i))/(6*h(i));
  b(i) = S(i)/2;
  c(i) = (dists(i+1) - dists(i))/h(i) - (S(i+1)*h(i) + 2*S(i)*h(i))/6;
  d(i) = dists(i);
endfor

for i=1:m
  x = times(i):0.01:times(i+1);
  plot(x, 3*a(i)*(x - times(i)).^2 + 2*b(i)*(x - times(i)) + c(i), "linewidth", 3);
  hold on;
endfor
