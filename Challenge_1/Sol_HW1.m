clc
clear all
close all

load xydata.dat

x=xydata(:,1);
y=xydata(:,2);

color=['r', 'c', 'm', 'k', 'g', 'y'];

plot(x,y,'o')
hold on;

mmin=0.1; mmax=2;
bmin=2; bmax=7;

p=[1,2,3,4,5,6,15];
xcal=[10/25:10/25:10]';

for i=1:6
    min(i)=1000;
    for b=bmin:0.01:bmax
        for m=mmin:0.01:mmax
            ycal=m*xcal+b;
            N(i)=norm(y-ycal,p(i));
            if N(i) < min(i)
                min(i)=N(i);
                A(i)=m;
                B(i)=b;
                ynew(:,i)=A(i)*xcal+B(i);
            end
        end
    end
    plot(xcal,ynew(:,i),color(i)); hold on
    i
    r(:,i)=abs(y-ynew(:,i));
end
S1={'Data','L_{1}','L_{2}','L_{3}','L_{5}','L_{15}'};
legend(S1)

[A' B']

 d=y;
 G=[ones(25,1) x];
 m=inv(G'*G)*G'*d;
 xcal=[1:10];
 ycal=m(1)+m(2)*xcal; 
 plot(xcal,ycal,'b')

 figure
 for i=1:6
     subplot(3,2,i)
     stem(x,r(:,i),color(i))
     str=sprintf('Residual L_{%d}',p(i));
     title(str)
 end