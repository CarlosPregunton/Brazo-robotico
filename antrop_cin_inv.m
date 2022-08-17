function [ Q ] = antrop_cin_inv( Pef,R,l1,l2,l3,qr,l4 )

%Calculo de la cinematica inversa del robot antropomorfico
P = Pef - l4*R*[0;0;1];
Px = P(1);
Py = P(2);
Pz = P(3);

%Solución por transformadas homogeneas
% k1p = (l2+Py);
% k2p = 2*Px;
% k3p = l2-Py;
% tanq1e2 = roots([k1p,k2p,k3p]);
% sol = 2*atan(tanq1e2);
% q1 = sol(1)

%Solución por método gráfico
fi = atan2(Py,Px);
alfa = atan2(l2,sqrt(Px^2+Py^2-l2^2));
q1 = fi - alfa; 

%Solución por transformadas homogeneas
% k1 = ((Py-l2.*cos(q1)).^2)+((Pz-l1).^2).*(sin(q1).^2);
% k2 = -2.*(Py-l2.*cos(q1)).*l3.*sin(q1);
% k3 = -2.*(Pz-l1).*l3.*(sin(q1).^2);
% k4 = (l3.^2).*(sin(q1).^2);
% k1p = (k1+k4-k2-sin(q1).^2).*(qr.^2);
% k2p = 2.*k3;
% k3p (k1+k4+k2-sin(q1).^2).*(qr.^2)
% tanq2e2 = roots([k1p,k2p,k3p])
% sol = 2*atan(tanq2e2);
% q2 = sol(1)

%Solución por método gráfico
D = (Px^2+Py^2-l2^2+(Pz-l1)^2-l3^2-qr^2)/(2*l3*qr);
q3 = atan2(sqrt(1-D^2),D);

%Solución por métoo gráfico
q2 = atan2(Pz-l1,sqrt(Px^2+Py^2-l2^2))-atan2(qr*sin(q3),l3+qr*cos(q3));

%Solución por transformadas homogeneas
% q3 = asin((Pz-l1-l3*sin(q2))/qr)-q2

%% Cinematica inversa para la la orientación de la herramienta

R03T=[-cos(q1)*sin(q2+q3),-sin(q1)*sin(q2+q3),cos(q2+q3);...
    sin(q1),-cos(q1),0;cos(q1)*cos(q2+q3),sin(q1)*cos(q2+q3),sin(q2+q3)];
R36=R03T*R;

if not(R36(1,3)==0 && R36(2,3)==0)
   %considerando la raíz positiva 
%    q4=atan2(R36(2,3),R36(1,3));   
%    q5=atan2(sqrt(1-R36(3,3)^2),R36(3,3));
%    q6=atan2(R36(3,2),-R36(3,1));
   %Considerando la raíz negativa
   q4=atan2(-R36(2,3),-R36(1,3));
   q5=atan2(-sqrt(1-R36(3,3)^2),R36(3,3));
   q6=atan2(-R36(3,2),R36(3,1));
   
end

if R36(1,3)==0 && R36(2,3)==0 
    %casos en los que R36(13)=0 y R36(23)=0
    if R36(3,3)==1
        %por convención fi (q4, en este caso) es cero.
        q4=0;
        q5=0;
        q6=atan2(R36(2,1),R36(1,1));
        
    end
    
    if R36(3,3)==-1
    %caso en el que R36(33)==-1
         q4=0;
         q5=pi;
         q6=-atan2(-R36(1,2),-R36(1,1));
         
    end
end
Q = [ q1,q2,q3,q4,q5,q6 ];
end

