clc
clear all
close all
%%
load data_exer1_10.txt
load data_exer1_30.txt

x = data_exer1_10(:,1);
d = data_exer1_10(:,2);

G = [80*ones(size(x,1),1) x];
m = inv(G'*G)*G'*d;

dest=80*m(1)+m(2)*x;

subplot(2,1,1)
plot(x,d,'o')
hold on
plot(x,dest,'r')
title('10%')

Gg = inv(G'*G)*G';
e=0.1;
sigma=(mean(d)*e)^2;
sigma=std(d);
sigma=1;
Cov = sigma^2*Gg*Gg';
U = Cov*m;
S(1) = sqrt(Cov(1,1));
S(2) = sqrt(Cov(2,2));

sprintf('%d +/- %d',m(1),3*(S(1)))
sprintf('%d +/- %d',m(2),3*(S(2)))

%%
x = data_exer1_30(:,1);
d = data_exer1_30(:,2);

G = [80*ones(size(x,1),1) x];
m = inv(G'*G)*G'*d;

dest=80*m(1)+m(2)*x;

subplot(2,1,2)
plot(x,d,'o')
hold on
plot(x,dest,'r')
title('30%')

Gg = inv(G'*G)*G';
e=0.3;
sigma=(mean(d)*e)^2;
sigma=std(d);
sigma=1;
Cov = sigma^2*Gg*Gg';
U = Cov*m;
S(1) = sqrt(Cov(1,1));
S(2) = sqrt(Cov(2,2));

sprintf('%d +/- %d',m(1),3*(S(1)))
sprintf('%d +/- %d',m(2),3*(S(2)))
