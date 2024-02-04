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
global    BEZIER
global    SPLINE
global    CATMULL
global    OWN

%
BEZIER = 'B'
SPLINE = 'S'
CATMULL ='C'
OWN = 'O'


WCS = eye(4);
WCS_SIZE = 5;


% Parameter Space
u0 = 0;
du = 0.05;
uf = 1;

Full_Polygon = load('Control_Polygon.txt');
N_pts = size( Full_Polygon, 2);

curve_type = SPLINE ;  
pts_per_stage = 4;  % if CATMULL type 3.    if SPLINE type 2,3 or 4

upper_marker = pts_per_stage;
lower_marker = 1;

switch curve_type
    case BEZIER
        [ H ]= bezier_weights( u0, du, uf, pts_per_stage)
        U = u0:du:uf ;    
    case SPLINE
        [H]= spline_weights( u0, du, uf, pts_per_stage);
        U = u0:du:uf ;         
    case CATMULL
        [H]= catmull_weights( u0, du, uf, pts_per_stage);
        U = u0:du:uf ; 
    case OWN
        [H,U] = own_weights_sine(u0, du, uf, pts_per_stage );
    otherwise
        disp('error main_teaching_curve_Sequence(): unexpected curve type')
        keyboard 
end

figure(1)
title('WEIGHTS')
hold on
plot(U, H , 'or-')
axis equal
hold on

figure(2)
title('Curve Sequence')
hold on
plt_axes_str(WCS, WCS_SIZE, 'k', 'b', 'r','Xw','Yw','Zw','Ow')

C =[];
while ( upper_marker <= N_pts )
    Q_i = Full_Polygon(1:3,lower_marker:upper_marker);
    C_i = Q_i * H' ;
    plot3(C_i(1,:), C_i(2,:), C_i(3,:), 'r-')
    hold on
    plot3(Q_i(1,:), Q_i(2,:), Q_i(3,:),    'bo-')
    C = [C C_i];

    [lower_marker, upper_marker]=update_markers( lower_marker, upper_marker, curve_type, pts_per_stage );
end














