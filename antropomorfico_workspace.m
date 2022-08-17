clear all
close all
clc
%% Trazado de la trayectoria
load('trayectoria.mat'); 

%% Espacio de trabajo del robot 
                            
p_t = txx + [2*ones(201,1),1*ones(201,1),-0.2*ones(201,1)];

    %Trayectoria en el plano xz

[px,py,pz] = ant_cin_dir(20,0,-pi/2,[-pi/2 0],0,0,0);
Path1 = [px,py,pz];
[px,py,pz] = ant_cin_dir(20,0,[-pi/2 pi/2],0,0,0,0);
Path2 = [px,py,pz];
[px,py,pz] = ant_cin_dir(20,0,pi/2,[0 pi/2],0,0,0);
Path3 = [px,py,pz];
[px,py,pz] = ant_cin_dir(20,0,[pi/2 -pi/2],pi/2,0,0,0);
Path4 = [px,py,pz];
[px,py,pz] = ant_cin_dir(20,0,-pi/2,[pi/2 -pi/2],0,0,0);
Path5 = [px,py,pz];
Path = [Path1;Path2;Path3;Path4;Path5];

figure(1)
plot(Path(:,1),Path(:,3),p_t(:,1),p_t(:,3))
xlabel('Ejex');
ylabel('Ejez');
title('Espacio de trabajo en el plano xz');

    %Trayectoria en el plano xy
    
[px,py,pz] = ant_cin_dir(20,[-pi/2 pi/2],0,0,0,0,0);
Path1 = [px,py,pz];
[px,py,pz] = ant_cin_dir(20,pi/2,[0 pi/2],0,0,0,0);
Path2 = [px,py,pz];
[px,py,pz] = ant_cin_dir(20,[pi/2 -pi/2],pi/2,0,0,0,0);
Path3 = [px,py,pz];
[px,py,pz] = ant_cin_dir(20,-pi/2,[pi/2 0],0,0,0,0);
Path4 = [px,py,pz];
 Path = [Path1;Path2;Path3;Path4];

figure(2)
plot(Path(:,1),Path(:,2),p_t(:,1),p_t(:,2))
xlabel('Ejex');
ylabel('Ejey');
title('Espacio de trabajo en el plano xy');



