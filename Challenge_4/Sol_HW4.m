clc
clear all
close all

%% 
% Symbolical creation of variables
syms f x y X Y J j DF df

% Objective Function
f = 100*(Y-X.^2).^2+(1-X).^2;

%% Derivatives

% First Derivatives
fx=diff(f,X);
fy=diff(f,Y);

% Second Derivatives
fxx=diff(fx,X);
fyy=diff(fy,Y);
fxy=diff(fx,Y);
fyx=diff(fy,X);

%% Evaluating the derivatives

F=eval(f);
Fx=eval(fx);
Fy=eval(fy);

Fxx=eval(fxx);
Fyy=eval(fyy);
Fxy=eval(fxy);

%% Choosing the starting point

X=3;%input('Escriba en que valor empieza la coordenada x: ');
Y=3;%input('Escriba en que valor empieza la coordenada y: ');

plot3(X,Y,eval(f),'go','linewidth',2); hold on

%% Iterating
cont=0;

while(1)
    cont=cont+1;
    s=[X;Y]; % Current point
    h=[fxx fxy; fxy fyy]; % Hessian Matrix
    H=eval(h); % Evaluaton of the Hessian
    j=[fx;fy]; % Gradient Vector
    J=eval(j);% Evaluation of the gradient

    % Future Point 
    
    % Newton's Method
    S=s-((H^-1)*J);
    
    % Steepest Descent
    alpha = 0.01/norm(J,2);
    S=s-alpha*((1^-1)*J)

    F_old=eval(f);
    
    % Updating Values
    X=S(1,1);
    Y=S(2,1);
    
    F_new=eval(f);
    
    plot3([s(1) S(1)], [s(2), S(2)],[F_old,F_new],'ro-','linewidth',2);
    
    % For breaking the loop
    if abs(J(1,1))<0.00001 && abs(J(2,1))<0.00001 || cont>100000, 
        break, 
    end     
    
    % Plotting the answer
    x2=-2:0.1:3;
    y2=-5:0.1:12;
    [x2, y2]=meshgrid(x2,y2);
    f2 = 100*(y2-x2.^2).^2+(1-x2).^2;
    mesh(x2,y2,f2);
    xlabel('X'),ylabel('Y'),zlabel('Z'); grid on;
    plot3(X,Y,eval(f),'ro','linewidth',2); hold on
end
