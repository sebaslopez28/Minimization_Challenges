clc
clear all
% close all
%%
load cross_well_d_vector.txt
load cross_well_g_matrix.txt

d = reshape(cross_well_d_vector,256,1);
G = reshape(cross_well_g_matrix,256,256);
n = 20;
%% Least Squares

mLS = inv(G'*G)*G'*d;
mLS = reshape(mLS,16,16);
subplot(221)
contour(mLS,n)
axis ij
title('Least Squares')

%% Damped Least Squares

epsilon = 1%max(svd(G'*G))*0.5;
mDLS = inv(G'*G + epsilon^2*eye(size(G'*G)))*G'*d;
mDLS = reshape(mDLS,16,16);

subplot(222)
contour(mDLS,n)
axis ij
title('Damped Least Squares')

%% First-Order Tikhonov Regularization

m=16;n=16;
D=zeros(m*n,m*n);
for i=1:m*n
    for j=1:m*n
        if i==j
            D(i,j)=-2;
        end
        if j==i+1
            D(i,j)=1;
        end
        if j==i+n
            D(i,j)=1;
        end
    end
end

Wm = D'*D;

% epsilon =
T = G'*G + epsilon^2*Wm;

mW1DLS = inv(T)*G'*d; %+ inv(T)*epsilon^2*Wm*m;
mW1DLS = reshape(mW1DLS,16,16);

subplot(223)
contour(mW1DLS,n)
axis ij
title('First-Order Tikhonov Regularization')

%% Second-Order Tikhonov Regularization

L=zeros(14*14,256);
k=1;
for i=2:15
    for j=2:15
        M=zeros(16,16);
        M(i,j)=-4;
        M(i,j+1)=1;
        M(i,j-1)=1;
        M(i+1,j)=1;
        M(i-1,j)=1;
        L(k,:)=(reshape(M,256,1))';
        k=k+1;
    end
end

D = L;
Wm = D'*D;

% epsilon =
T = G'*G + epsilon^2*Wm;

mW2DLS = inv(T)*G'*d; %+ inv(T)*epsilon^2*Wm*m;
mW2DLS = reshape(mW2DLS,16,16);

subplot(224)
contour(mW2DLS,n)
axis ij
title('Second-Order Tikhonov Regularization')