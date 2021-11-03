function [t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)
%on a un signal auquel on va appliquer différentes erreurs
%Entrées:

%A1: Amplitude 1
%A2: Amplitude 2
%A3: Amplitude 3

%f1: fréquence 1
%f2: fréquence 2
%f3: fréquence 3
%fe: fréquence d'échantillonnage

%G: Gain (erreur linéaire) 
%O: Offset (erreur linéaire)

%a: paramètre a du polynôme d'ordre 2 (erreur non linéaire)
%b: paramètre b du polynôme d'ordre 2 (erreur non linéaire)
%c: paramètre c du polynôme d'ordre 2 (erreur non linéaire)

%lmbd: paramètre lambda de l'exponentielle (erreur non linéaire)
%mu1:paramètre mu de l'exponentielle (erreur non linéaire)
%mu: paramètre mu du logarithme (erreur non linéaire)
%lambda: paramètre lambda du logarithme (erreur non linéaire)

% Sortie: 
% t: vecteur allant de 0 à 1 avec un pas de Te
% vf: vecteur fréquence allant de 0 à fe avec un pas de 1
% y: Signal sinusoïdal de sortie
% Ynew: Fourier du signal y sans erreur
% Ybis:Fourier du signal y avec erreur 
% se: Signal sinusoïdal auquel une erreur linéaire a été appliquée (gain et offset)
% SE: Fourier du Signal sinusoïdal auquel une erreur linéaire a été appliquée (gain et offset)

% d: Polynôme appliquée à t 
% j: Polynôme appliquée au signal de base y 
% h: Exponentielle appliquée à t
% e: Exponentielle appliquée au signal de base y
% q: Logarithme appliquée à t
% r: Logarithme appliquée au signal de base y 

Te=1/fe
t=[0:Te:1];
% vecteur fréquence
vf=[0:1:fe];

% Signal de base
y=M+A1*sin(2*pi*f1*t)+ A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);

%Signal de base de fourier 
Y=abs(fft(y))/fe;

%signal de base avec erreur linéaire sous fourier 
se= G * y + O;
vf=[0:1:fe];
Ynew=[Y(1,1), 2*Y(1,2:floor(fe/2))];%notre moyenne est Y(1,1) cette ligne pour ajuster tout les amplitudes à 10
SE=abs(fft(se))/fe;

%Erreur polynôme d'ordre 2
d=a*t.^2+b*t+c;%Polynôme appliquée à t
j=a*y.^2+b*y+c;%Polynôme appliquée au signal y de base

%Erreur exponentielle 
h=lmbd*exp(t/mu1);%Exponentielle appliquée à t
e=lmbd*exp(y/mu1);%Exponentielle appliquée au signal Y de base

%Erreur logarithmique 
q=lambda*log(abs(t/mu));%Logarithme appliquée à x
r=lambda*log(abs(y/mu));%Logarithme appliquée au signal Y de base

% % if AFF
%     hold on;
%     plot(t,r,'b')
% %     title(' Courbe logarithme')
% %     xlabel('x abscisse')
% %     ylabel('y ordonnée ')
%     hold on; 
%     plot(t,y,'m')
%     plot(t,d)
%     hold off
end

