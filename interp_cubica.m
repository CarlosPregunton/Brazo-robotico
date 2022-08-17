function [ qi_t,vi_t,ai_t ] = interp_cubica( t0,tf,q0,q1 )
%Esta funcion toma (q0,t0) y (t1,q1) y realiza una interpolación. 
%Como resultado se obtine un vector columna con la interpolación 
%de (q0,t0) a (q1,t1) qi_t

%velocidad inicial y final entre cada trayectoria
v0 = 0;
v1 = 0;

time = linspace(t0,tf,3*(tf-t0)); %3 puntos por unidad 3/unidad
t = time';
c = ones(size(t));

M = [ 1 t0 t0^2 t0^3;
      0 1 2*t0 3*t0^2;
      1 tf tf^2 tf^3;
      0 1 2*tf 3*tf^2];
  
b = [q0; v0; q1; v1];
a = inv(M)*b;

% qd = reference position trajectory
% vd = reference velocity trajectory
% ad = reference acceleration trajectory

qi_t = a(1).*c + a(2).*t +a(3).*t.^2 + a(4).*t.^3;
vi_t = a(2).*c +2*a(3).*t +3*a(4).*t.^2;
ai_t = 2*a(3).*c + 6*a(4).*t;

end

