clear;
clc;
close all;

addpath('./Functions/');

L = 1;
N = 1000;

mu = 0.9;
gamma = 1e-6;

S = struct('step',mu,'filterOrderNo',N,'initialCoefficients',0,'gamma',gamma);

T = 1000;
Ts = 0.001;

t = (0:1:T-1)*Ts;

xSine = sin(2*pi*t);
xSine2 = sin(2*pi*t + pi/4);
xSine3 = sin(2*pi*t + pi/2);

d1 = xSine(L+1:end);
d2 = xSine2(L+1:end);
d3 = xSine3(L+1:end);

% Adaptive Algorithm

[y1,e1,w1] = NLMS(d1,xSine,S);
[y2,e2,w2] = NLMS(d2,xSine2,S);
[y3,e3,w3] = NLMS(d3,xSine3,S);

y1_test = filter(w1(:,end),1,xSine);
y2_test = filter(w1(:,end),1,xSine2);
y3_test = filter(w1(:,end),1,xSine3);

%delay = round((length(w1(:,end))-1)/2);
delay = 0;

figure;

subplot(1,3,1);

plot(xSine,'-b')
hold on
plot(y1_test(delay+1:end),'--r')

subplot(1,3,2);

plot(xSine2,'-b')
hold on
plot(y2_test(delay+1:end),'--r')

subplot(1,3,3);

plot(xSine3,'-b')
hold on
plot(y3_test(delay+1:end),'--r')


figure
plot(10*log10(abs(e1.^2)),'-b')
hold on
plot(10*log10(abs(e2.^2)),'--r')
plot(10*log10(abs(e3.^2)),'-.m')

rmpath('./Functions/');