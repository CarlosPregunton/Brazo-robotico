function [ px,py,pz ] = ant_cin_dir( np,th1,th2,th3,th4,th5,th6 )
%Funcion que calcula la cinematica directa de un robot antropomorfico
% np:numero de puntos de la trayectoria
% el angulo que se va ha variar debe tener la sintaxis [th_min th_max]


q1 = linspace(th1(1),th1(length(th1)),np)';
q2 = linspace(th2(1),th2(length(th2)),np)';
q3 = linspace(th3(1),th3(length(th3)),np)';
q4 = linspace(th4(1),th4(length(th4)),np)';
q5 = linspace(th5(1),th5(length(th5)),np)';
q6 = linspace(th6(1),th6(length(th6)),np)';



l1 = 4.*ones(np,1);
l2 = 1.*ones(np,1);
l3 = 6.5.*ones(np,1);
qr = 3.*ones(np,1) + 2.*ones(np,1); %se le suma l4 a qr
%l4 = 2.*ones(np,1);


 px = cos(q1).*(l3.*cos(q2)+qr.*cos(q2+q3))-l2.*sin(q1);
 py = sin(q1).*(l3.*cos(q2)+qr.*cos(q2+q3))+l2.*cos(q1);
 pz = l1 + l3.*sin(q2)+qr.*sin(q2+q3);


end

