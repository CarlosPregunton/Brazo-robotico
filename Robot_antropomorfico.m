clear all
close all
clc

%% Trazado de la trayectoria

load('trayectoria.mat');    
                            %posición de la trayectoria
Pef = (txx + [3*ones(201,1),0*ones(201,1),-6*ones(201,1)])';
R = Txx(1:3,1:3,:);                  %orientacion de la herramienta (R47)
    %Grafica de la trayectoria
plot3( txx(:,1)+3*ones(201,1), txx(:,2), txx(:,3)-6*ones(201,1), 'color', 'k', 'LineWidth', 2);
xlabel('eje x');
ylabel('eje y');                                
zlabel('eje z');
grid on;
hold on;
%% Dimensiones de los eslabones
l1 = 4;
l2 = 1;
l3 = 4.5;
qr = 5;
l4 = 2;
t = [1:length(Txx)];
%% Interpolación de la trayectoria en el espacio articular
for i = 1:length(Txx)-1
Q0 = antrop_cin_inv( Pef(:,i),R(1:3,1:3,i),l1,l2,l3,qr,l4 );
Q1 = antrop_cin_inv( Pef(:,i+1),R(1:3,1:3,i+1),l1,l2,l3,qr,l4 );
t0 = t(i);
tf = t(i+1);
[ Qi_t,Vi_t,Ai_t ] = interp_cubica_Q( t0,tf,Q0,Q1 );

for k = 1:3
q1 = Qi_t(k,1);
q2 = Qi_t(k,2);
q3 = Qi_t(k,3);
q4 = Qi_t(k,4);
q5 = Qi_t(k,5);
q6 = Qi_t(k,6);
% %% Verificación de las singularidades
% Singularidad en el brazo
%sing(i,1) = (l3*cos(q2)+qr*cos(q2+q3))*sin(q3);
    
% Singularidad en la muñeca
%sing(i,2) = sin(q5);

%% Configuracion del robot
% Link(theta,d,a,alpha)
L(1)=Link([0,l1,0,pi/2,0]);
L(2)=Link([0,-l2,l3,0,0]);
L(3)=Link([0,0,0,pi/2,0,pi/2]);
L(4)=Link([0,0,0,0,1]);
L(5)=Link([0,0,0,-pi/2,0]);
L(6)=Link([0,0,0,pi/2,0]);
L(7)=Link([0,2,0,0,0]);

qli=[-pi pi;-pi pi;-pi pi;0 5;-pi pi;-pi pi;-pi pi];%definición de los límites de las juntas 1 y 2
qz=[0,0,0,1,0,0,0];%matriz con vectores articulares renglón
antropom=SerialLink(L,'name','AntropoMorfico','qlim',qli);
antropom.plotopt = {'workspace', [-7 15 -7 7 0 15]};    
antropom.teach([q1,q2,q3,qr,q4,q5,q6]);

end


end