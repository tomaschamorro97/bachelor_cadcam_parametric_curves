% File for Teaching: Parametric Curves
% Prof. Oscar Ruiz Salguero
% Course  IM0242. Introduction to CAD CAM Systems
% Date:  Oct 2020
% ==============================================
%
clc
clear all
close all

%
WCS = eye(4);
WCS_SIZE = 20;


% Parameter Space
u0 = 0;
du = 0.05;
uf = 1;

stage_size = 4;
% Local Control Polygon
switch (stage_size)
    case 4
        Q = [[1 1 0]' [ 15 1  0 ]' [15 15 0 ]' [ 15 15 15 ]' ];
    case 3
        Q = [[1 1 0]' [ 15 1  0 ]' [15 15 0 ]'  ];
    otherwise
        disp('error main_teaching_curves: unexpected stage size')
        keyboard
end

%======================================================
% OWN WEIGHTS. SINE FUNCTION
%======================================================
[ H ]= bezier_weights( u0, du, uf, stage_size)
U = u0:du:uf ;

figure(1)
title('WEIGHTS for B0(u)=1+sin(pi*(u/2  +  1))')
hold on

plot(U1, H1 , 'or-')
axis equal
hold on

%======================================================
% OWN4 CURVE. SINE FUNCTION 
%======================================================

figure(2)
title('OWN4 Curve for B0(u)=1+sin(pi*(u/2  +  1))')
hold on
plt_axes_str(WCS, WCS_SIZE, 'k', 'b', 'r','Xw','Yw','Zw','Ow')

C1 = Q * H1' ;

plot3(C1(1,:), C1(2,:), C1(3,:), 'ro-')
hold on
plot3(Q(1,:), Q(2,:), Q(3,:),    'bo-')

axis equal
hold on

%======================================================
% OWN WEIGHTS. QUARTIC POLYNOMIAL 
%======================================================

[H2,U2] = own_weights_quartic(u0, du, uf, stage_size );
figure(3)
title('WEIGHTS for B0(u)=(1-u)^4')
hold on
plot(U2, H2 , 'or-')
axis equal
hold on

%======================================================
% OWN4 CURVE. QUARTIC POLYNOMIAL 
%======================================================

figure(4)
title('OWN4 Curve for B0(u)=(1-u)^4)')
hold on
plt_axes_str(WCS, WCS_SIZE, 'k', 'b', 'r','Xw','Yw','Zw','Ow')

C2 = Q * H2' ;

plot3(C2(1,:), C2(2,:), C2(3,:), 'ro-')
hold on
plot3(Q(1,:), Q(2,:), Q(3,:),    'bo-')

axis equal
hold on

%======================================================
% BEZIER WEIGHTS
%======================================================

[H3] = bezier_weights( u0, du, uf, stage_size);
U3 = u0:du:uf ;
figure(5)
title(' BEZIER WEIGHTS')
hold on
plot(U3, H3 , 'or-')
axis equal
hold on

%======================================================
% BEZIER CURVE
%======================================================

figure(6)
title('BEZIER Curve')
hold on
plt_axes_str(WCS, WCS_SIZE, 'k', 'b', 'r','Xw','Yw','Zw','Ow')

C3 = Q * H3' ;

plot3(C3(1,:), C3(2,:), C3(3,:), 'ro-')
hold on
plot3(Q(1,:), Q(2,:), Q(3,:),    'bo-')

axis equal
hold on



