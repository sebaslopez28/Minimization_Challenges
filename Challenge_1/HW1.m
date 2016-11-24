close all
clear all

data=load('xydata.dat');
X=data(:,1);
dobs=data(:,2);

% grid
Na=201;
amin=0;
Da = 0.1;
Nb=201;
bmin=0;
Db = 0.1;

% populate grid with errors
E1 = zeros(Na,Nb);
E2 = zeros(Na,Nb);
E3=zeros(Na,Nb);
E5=zeros(Na,Nb);
E15=zeros(Na,Nb);
Einf = zeros(Na,Nb);
for i=[1:Na]
for j=[1:Nb]
    ao = amin+Da*(i-1);
    bo = bmin+Db*(j-1);
    dpre = ao + bo*X;
    e = dobs-dpre;
    abse = abs(e);
    E1(i,j)=sum(abse);
    E2(i,j)=sum(abse.^2);
    E3(i,j)=sum(abse.^3);
    E5(i,j)=sum(abse.^5);
    E15(i,j)=sum(abse.^15);
    Einf(i,j)=sum(abse.^20); 
end
end

% find minimum error
[r1 ,c1]=find(E1==min(min(E1)));
a1 = amin+Da*(r1-1);
b1 = bmin+Db*(c1-1);
dpre1 = a1 + b1*X;
resid1=abs(dobs-dpre1);

[r2 ,c2]=find(E2==min(min(E2)));
a2 = amin+Da*(r2-1);
b2 = bmin+Db*(c2-1);
dpre2 = a2 + b2*X;
resid2=abs(dobs-dpre2);

[r3 ,c3]=find(E3==min(min(E3)));
a3 = amin+Da*(r3-1);
b3 = bmin+Db*(c3-1);
dpre3 = a3 + b3*X;
resid3=abs(dobs-dpre3);

[r5 ,c5]=find(E5==min(min(E5)));
a5 = amin+Da*(r5-1);
b5 = bmin+Db*(c5-1);
dpre5 = a5 + b5*X;
resid5=abs(dobs-dpre5);

[r15 ,c15]=find(E15==min(min(E15)));
a15 = amin+Da*(r15-1);
b15 = bmin+Db*(c15-1);
dpre15 = a15 + b15*X;
resid15=abs(dobs-dpre15);

[rinf ,cinf]=find(Einf==min(min(Einf)));
ainf = amin+Da*(rinf-1);
binf = bmin+Db*(cinf-1);
dpreinf = ainf + binf*X;
residinf=abs(dobs-dpreinf);

disp(sprintf('1: a %f b %f', a1, b1 ));
disp(sprintf('1: a %f b %f', a2, b2 ));
disp(sprintf('1: a %f b %f', a3, b3 ));
disp(sprintf('1: a %f b %f', a5, b5 ));
disp(sprintf('1: a %f b %f', a15, b15 ));
disp(sprintf('1: a %f b %f', ainf, binf ));



figure(1)
plot(X,dobs,'b*')
hold on
plot(X,dpre1,'b')
plot(X,dpre2,'r')
plot(X,dpre3,'g')
plot(X,dpre5,'c')
plot(X,dpre15,'k')
plot(X,dpreinf,'m')
S1={'Data','L_{1}','L_{2}','L_{3}','L_{5}','L_{15}','L_{\infty}'};
legend(S1)

figure(1)
legend(S1,'location','northwest')
xlabel('X data')
ylabel('Y data')
set(gca,'FontSize',18)

figure(2)
subplot(3,2,1)
stem(X,resid1,'b')
title('Residual L_{1}')

subplot(3,2,2)
stem(X,resid2,'r')
title('Residual L_{2}')

subplot(3,2,3)
stem(X,resid3,'g')
title('Residual L_{3}')

subplot(3,2,4)
stem(X,resid5,'c')
title('Residual L_{5}')

subplot(3,2,5)
stem(X,resid15,'k')
title('Residual L_{15}')

subplot(3,2,6)
stem(X,residinf,'m')
title('Residual L_{\infty}')




   
 
    