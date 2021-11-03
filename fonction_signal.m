function [se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)

Te=1/fe
t=[0:Te:1];

y=M+A1*sin(2*pi*f1*t)+ A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);%fonction
% if AFF
%     if G==0 & O==0
%     plot(t,y,'g')
%     title('Signal')
%     xlabel('Temps(s)')
%     ylabel('Amplitude')
%     end
% end
%selection de la courbe
Y=abs(fft(y))/fe

% GAIN ET OFFSET
%on ajoute le gain au niveau du graph 1 (superposition des deux courbes) 

se= G * y + O
vf=[0:1:fe]
Ynew=[Y(1,1), 2*Y(1,2:floor(fe/2))]
% if AFF
% hold on
% plot(t,se,'--r')
% hold off
% end
 %notre moyenne est Y(1,1) cette ligne pour ajuster tout les amplitudes à 10

end