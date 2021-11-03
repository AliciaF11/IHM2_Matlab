function [Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

Te=1/fe
t=[0:Te:1];
y=M+A1*sin(2*pi*f1*t)+ A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);

%Transformé de fourrier
Y=abs(fft(y))/fe;

%GAIN ET OFFSET
%on ajoute le gain au niveau du graph 1 (superposition des deux courbes) 
se= G * y + O;
% x=t*fe
vf=[0:1:fe];
Ynew=[Y(1,1), 2*Y(1,2:floor(fe/2))];%notre moyenne est Y(1,1) cette ligne pour ajuster tout les amplitudes à 10

SE=abs(fft(se))/fe;

% if AFF
% stem(vf(1,1:floor(fe/2)),Ynew, 'g')
% title('Transformée de Fourrier')
% xlabel('Fréquence (Hz)')
% ylabel('Amplitudes')
% end 

%Offset et gain pour le TF 

vf=[0:1:fe];

Ybis=[SE(1,1), 2*SE(1,2:floor(fe/2))]

% if AFF
% hold on
% stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
% hold off
% end
end

