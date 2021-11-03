function varargout = IHM(varargin)
% IHM MATLAB code for IHM.fig
%      IHM, by itself, creates a new IHM or raises the existing
%      singleton*.
%
%      H = IHM returns the handle to a new IHM or the handle to
%      the existing singleton*.
%
%      IHM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IHM.M with the given input arguments.
%
%      IHM('Property','Value',...) creates a new IHM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IHM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IHM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IHM

% Last Modified by GUIDE v2.5 02-Nov-2021 11:51:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IHM_OpeningFcn, ...
                   'gui_OutputFcn',  @IHM_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before IHM is made visible.
function IHM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IHM (see VARARGIN)

% Choose default command line output for IHM
handles.output = hObject;

%afficher un fond 
ah = axes('unit', 'normalized', 'position', [0 0 1 1]);
bg = imread('photo1.jpg'); imagesc(bg);
set(ah,'handlevisibility','off','visible','off')


% Update handles structure
guidata(hObject, handles);

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


%On fait appel au fichier init pour avoir des valeurs de départ
run('init1.m');

%on positionne les sliders selon la valeur récupérée précédemment
set(handles.A1,'Value', A1)
set(handles.A2,'Value', A2)
set(handles.A3,'Value', A3)
set(handles.fe,'Value', fe)
set(handles.f1,'Value', f1)
set(handles.f2,'Value', f2)
set(handles.f3,'Value', f3)
set(handles.gain,'Value', G)
set(handles.offset,'Value', O)
set(handles.M,'Value', M)

%notation de la valeur initiale des variables dans leur encadré
set(handles.text_A1,'string',['A1=',num2str(A1)])
set(handles.text_A2,'string',['A2=',num2str(A2)])
set(handles.text_A3,'string',['A3=',num2str(A3)])
set(handles.text_fe,'string',['fe=',num2str(fe),'Hz'])
set(handles.text_f1,'string',['f1=',num2str(f1),'Hz'])
set(handles.text_f2,'string',['f2=',num2str(f2), 'Hz'])
set(handles.text_f3,'string',['f3=',num2str(f3), 'Hz'])
set(handles.text_g,'string',['G=',num2str(G)])
set(handles.text_o,'string',['O=',num2str(O)])
set(handles.text_m,'string',['M=',num2str(M)])
set(handles.text_a,'string',['a=',num2str(a)])
set(handles.text_b,'string',['b=',num2str(b)])
set(handles.text_c,'string',['c=',num2str(c)])
set(handles.text_lambda1,'string',['lambda=',num2str(lmbd)])
set(handles.text_mu_log,'string',['mu=',num2str(mu)])
set(handles.text_mu,'string',['mu=',num2str(mu1)])
set(handles.text_lambda,'string',['lambda=',num2str(lambda)])

%On définit les slider qui sont accessibles à l'utilisateur à l'ouverture
%de l'IHM
set(handles.gain,'Enable','Off');
set(handles.offset,'Enable','Off');
set(handles.a,'Enable','Off');
set(handles.b,'Enable','Off');
set(handles.c,'Enable','Off');
set(handles.checkbox4,'Enable','Off');
set(handles.checkbox5,'Enable','Off');
set(handles.checkbox6,'Enable','Off');
set(handles.lambda_exp,'Enable','Off');
set(handles.mu_exp,'Enable','Off');
set(handles.lambda_log,'Enable','Off');
set(handles.mu_log,'Enable','Off');

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)%fonction transformée de fourier 

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)%fonction non linéaire

%affichage du premier graphique 
axes(handles.axes1)
%on ajoute une condition pour afficher la courbe sans erreur et avec erreur
%selon les checkboxs cochés
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

%affichage du second graphique
axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end
%affichage du troisième graphique 
axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
hold off


% UIWAIT makes IHM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IHM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function offset_Callback(hObject, eventdata, handles)
% hObject    handle to offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


O=get(hObject,'Value');
% set(handles.offset,'Value', O)
set(handles.text_o,'string',['O=',num2str(O)])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

% [t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)


axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end


get(hObject,'Interruptible')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function A1_Callback(hObject, eventdata, handles)
% hObject    handle to A1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M 
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


A1=get(hObject,'Value');
% set(handles.A1,'Value', A1)
set(handles.text_A1,'string',['A1=',num2str(A1)])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)



axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function A1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function A2_Callback(hObject, eventdata, handles)
% hObject    handle to A2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


A2=get(hObject,'Value');
set(handles.A2,'Value', A2)
set(handles.text_A2,'string',['A2=',num2str(A2)])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)



axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function A2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function A3_Callback(hObject, eventdata, handles)
% hObject    handle to A3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


A3=get(hObject,'Value');
% set(handles.A3,'Value', A3)
set(handles.text_A3,'string',['A3=',num2str(A3)])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)


axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function A3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function f1_Callback(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


f1=get(hObject,'Value');
set(handles.f1,'Value', f1)
set(handles.text_f1,'string',['f1=',num2str(f1),'Hz'])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)



axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function f2_Callback(hObject, eventdata, handles)
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


f2=get(hObject,'Value');
% set(handles.f2,'Value', f2)
set(handles.text_f2,'string',['f2=',num2str(f2),'Hz'])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)


axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function f3_Callback(hObject, eventdata, handles)
% hObject    handle to f3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


f3=get(hObject,'Value');
% set(handles.f3,'Value', f3)
set(handles.text_f3,'string',['f3=',num2str(f3),'Hz'])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)


axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function f3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function gain_Callback(hObject, eventdata, handles)
% hObject    handle to gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


G=get(hObject,'Value');
% set(handles.gain,'Value', G)
set(handles.text_g,'string',['G=',num2str(G)])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

% [t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

% axes(handles.axes3)
% plot(t,j,'b')
% hold on;
% plot(t,y,'m')
% plot(t,d)
% title('polynôme')
% xlabel('abscisse')
% ylabel ('ordonnée')
% hold off

get(hObject,'Interruptible')
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function gain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fe_Callback(hObject, eventdata, handles)
% hObject    handle to fe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


fe=floor(get(hObject,'Value'));
% set(handles.fe,'Value', fe)
set(handles.text_fe,'string',['fe=',num2str(fe),'Hz'])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)


axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fe_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fe (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function M_Callback(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew


% set(handles.M,'Value', M)
M=floor(get(hObject,'Value'));
set(handles.text_m,'string',['M=',num2str(M)])

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)


axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end


axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% --- Executes during object creation, after setting all properties.
function M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
% function [t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal
% 
% function [t,y]=fonction_TF(M, A1,A2,A3,f1,f2,f3,fe,G,O)%transformée de fourrier

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% % --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r
global Ybis
global Ynew

% [se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal
% 
% [Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)
% 
% 
% [t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

Check=get(handles.checkbox1,'Value')
if Check==1
    %si l'utilisateur coche la case sans erreur alors on définit les
    %sliders accessibles ou non
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','Off');
    set(handles.checkbox2,'Enable','Off');
    set(handles.checkbox4,'Enable','Off');
    set(handles.checkbox5,'Enable','Off');
    set(handles.checkbox6,'Enable','Off');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

    G=0;
    set(handles.text_g,'string',['G=',num2str(G)])

    O=0;
    set(handles.text_o,'string',['O=',num2str(O)])
    a=0;
    set(handles.text_a,'string',['a=',num2str(a)])

    b=0;
    set(handles.text_b,'string',['b=',num2str(b)])

    c=0;
    set(handles.text_c,'string',['c=',num2str(c)])

    axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

    axes(handles.axes3)
    plot(t,j,'b')
    hold on;
    plot(t,y,'m')
    plot(t,d)
    title('polynôme')
    xlabel('abscisse')
    ylabel ('ordonnée')
    hold off
else  
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','On');
    set(handles.checkbox2,'Enable','On');
    set(handles.checkbox4,'Enable','Off');
    set(handles.checkbox5,'Enable','Off');
    set(handles.checkbox6,'Enable','Off');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

end
% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button
[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

Check=get(handles.checkbox2,'Value')
if Check==1
    set(handles.gain,'Enable','On');
    set(handles.offset,'Enable','On');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','Off');
    set(handles.checkbox1,'Enable','Off');
%     set(handles.checkbox4,'Enable','Off');
%     set(handles.checkbox5,'Enable','Off');
%     set(handles.checkbox6,'Enable','Off');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

    G=1;
    set(handles.text_g,'string',['G=',num2str(G)])

    O=0;
    set(handles.text_o,'string',['O=',num2str(O)])
    a=0;
    set(handles.text_a,'string',['a=',num2str(a)])

    b=0;
    set(handles.text_b,'string',['b=',num2str(b)])

    c=0;
    set(handles.text_c,'string',['c=',num2str(c)])

    axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

    axes(handles.axes2)
        if G==0 & O==0
            stem(vf(1,1:floor(fe/2)),Ynew, 'g')
            title('Transformée de Fourrier')
            xlabel('Fréquence (Hz)')
            ylabel('Amplitudes')
    
        else 
            stem(vf(1,1:floor(fe/2)),Ynew, 'g')
            hold on
            stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
            title('Transformée de Fourrier')
            xlabel('Fréquence (Hz)')
            ylabel('Amplitudes')
            hold off
        end

    axes(handles.axes3)
    plot(t,j,'b')
    hold on;
    plot(t,y,'m')
    plot(t,d)
    title('polynôme')
    xlabel('abscisse')
    ylabel ('ordonnée')
    hold off
else  
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','On');
    set(handles.checkbox1,'Enable','On');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

end

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button
[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

Check=get(handles.checkbox3,'Value')
if Check==1
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox2,'Enable','Off');
    set(handles.checkbox1,'Enable','Off');
    set(handles.checkbox4,'Enable','On');
    set(handles.checkbox5,'Enable','On');
    set(handles.checkbox6,'Enable','On');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

    G=1;
    set(handles.text_g,'string',['G=',num2str(G)])

    O=0;
    set(handles.text_o,'string',['O=',num2str(O)])
    a=0;
    set(handles.text_a,'string',['a=',num2str(a)])

    b=0;
    set(handles.text_b,'string',['b=',num2str(b)])

    c=0;
    set(handles.text_c,'string',['c=',num2str(c)])

   axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

    axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

    axes(handles.axes3)
    plot(t,j,'b')
    hold on;
    plot(t,y,'m')
    plot(t,d)
    title('polynôme')
    xlabel('abscisse')
    ylabel ('ordonnée')
    hold off
else  
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox2,'Enable','On');
    set(handles.checkbox1,'Enable','On');
    set(handles.checkbox4,'Enable','Off');
    set(handles.checkbox5,'Enable','Off');
    set(handles.checkbox6,'Enable','Off');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

end

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

Check=get(handles.checkbox4,'Value')
if Check==1
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','On');
    set(handles.b,'Enable','On');
    set(handles.c,'Enable','On');
    set(handles.checkbox3,'Enable','Off');
    set(handles.checkbox1,'Enable','Off');
    set(handles.checkbox5,'Enable','Off');
    set(handles.checkbox6,'Enable','Off');

    G=1;
    set(handles.text_g,'string',['G=',num2str(G)])

    O=0;
    set(handles.text_o,'string',['O=',num2str(O)])
    a=1;
    set(handles.text_a,'string',['a=',num2str(a)])

    b=2;
    set(handles.text_b,'string',['b=',num2str(b)])

    c=3;
    set(handles.text_c,'string',['c=',num2str(c)])

    axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

   axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

    axes(handles.axes3)
    plot(t,j,'b')
    hold on;
    plot(t,y,'m')
    plot(t,d)
    title('polynôme')
    xlabel('abscisse')
    ylabel ('ordonnée')
    hold off
else  
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','On');
    set(handles.checkbox1,'Enable','Off');
    set(handles.checkbox5,'Enable','On');
    set(handles.checkbox6,'Enable','On');

end
% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

Check=get(handles.checkbox5,'Value')
if Check==1
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','Off');
    set(handles.checkbox1,'Enable','Off');
    set(handles.checkbox4,'Enable','Off');
    set(handles.checkbox6,'Enable','Off');
    set(handles.A1,'Enable','Off');
    set(handles.A2,'Enable','Off');
    set(handles.A3,'Enable','Off');
    set(handles.f1,'Enable','Off');
    set(handles.f2,'Enable','Off');
    set(handles.f3,'Enable','Off');
    set(handles.fe,'Enable','Off');
    set(handles.lambda_exp,'Enable','On');
    set(handles.mu_exp,'Enable','On');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');
    G=1;
    set(handles.text_g,'string',['G=',num2str(G)])

    O=0;
    set(handles.text_o,'string',['O=',num2str(O)])
    a=0;
    set(handles.text_a,'string',['a=',num2str(a)])

    b=0;
    set(handles.text_b,'string',['b=',num2str(b)])

    c=0;
    set(handles.text_c,'string',['c=',num2str(c)])

   axes(handles.axes1)
    if G==0 & O==0
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
    else
        plot(t,y,'g')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold on
        plot(t,y,'--r')
        title('Signal')
        xlabel('Temps(s)')
        ylabel('Amplitude')
        hold off
    end

    axes(handles.axes2)
    if G==0 & O==0
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')

    else 
        stem(vf(1,1:floor(fe/2)),Ynew, 'g')
        hold on
        stem(vf(1,1:floor(fe/2)),Ybis(1,1:floor(fe/2)),'r')
        title('Transformée de Fourrier')
        xlabel('Fréquence (Hz)')
        ylabel('Amplitudes')
        hold off
    end

    axes(handles.axes3)
    plot(t,e,'b')
    hold on;
    plot(t,y,'m')
    plot(t,h)
    title('exponentielle')
    xlabel('abscisse')
    ylabel ('ordonnée')
    hold off
else  
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','On');
    set(handles.checkbox1,'Enable','Off');
    set(handles.checkbox4,'Enable','On');
    set(handles.checkbox6,'Enable','On');
    set(handles.A1,'Enable','On');
    set(handles.A2,'Enable','On');
    set(handles.A3,'Enable','On');
    set(handles.f1,'Enable','On');
    set(handles.f2,'Enable','On');
    set(handles.f3,'Enable','On');
    set(handles.fe,'Enable','On');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

end

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r
global Ybis
global Ynew

[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

Check=get(handles.checkbox6,'Value')
if Check==1
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','Off');
    set(handles.checkbox1,'Enable','Off');
    set(handles.checkbox4,'Enable','Off');
    set(handles.checkbox5,'Enable','Off');
    set(handles.A1,'Enable','Off');
    set(handles.A2,'Enable','Off');
    set(handles.A3,'Enable','Off');
    set(handles.f1,'Enable','Off');
    set(handles.f2,'Enable','Off');
    set(handles.f3,'Enable','Off');
    set(handles.fe,'Enable','Off');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','On');
    set(handles.mu_log,'Enable','On');
    G=1;
    set(handles.text_g,'string',['G=',num2str(G)])

    O=0;
    set(handles.text_o,'string',['O=',num2str(O)])
    a=0;
    set(handles.text_a,'string',['a=',num2str(a)])

    b=0;
    set(handles.text_b,'string',['b=',num2str(b)])

    c=0;
    set(handles.text_c,'string',['c=',num2str(c)])

    axes(handles.axes1)
    plot(t,y,'g')
    hold on
    plot(t,y,'--r')
    title('Signal')
    xlabel('Temps(s)')
    ylabel('Amplitude')
    hold off

    axes(handles.axes2)
    stem(vf(1,1:floor(fe/2)),Ynew, 'g')
    hold on
    stem(vf(1,1:floor(fe/2)),Ynew(1,1:floor(fe/2)),'r')
    title('Transformée de Fourrier')
    xlabel('Fréquence (Hz)')
    ylabel('Amplitudes')
    hold off

    axes(handles.axes3)
    plot(t,r,'b')
    hold on;
    plot(t,y,'m')
    plot(t,q)
    title('logarithme')
    xlabel('abscisse')
    ylabel ('ordonnée')
    hold off
else  
    set(handles.gain,'Enable','Off');
    set(handles.offset,'Enable','Off');
    set(handles.a,'Enable','Off');
    set(handles.b,'Enable','Off');
    set(handles.c,'Enable','Off');
    set(handles.checkbox3,'Enable','On');
    set(handles.checkbox1,'Enable','Off');
    set(handles.checkbox4,'Enable','On');
    set(handles.checkbox5,'Enable','On');
    set(handles.A1,'Enable','On');
    set(handles.A2,'Enable','On');
    set(handles.A3,'Enable','On');
    set(handles.f1,'Enable','On');
    set(handles.f2,'Enable','On');
    set(handles.f3,'Enable','On');
    set(handles.fe,'Enable','On');
    set(handles.lambda_exp,'Enable','Off');
    set(handles.mu_exp,'Enable','Off');
    set(handles.lambda_log,'Enable','Off');
    set(handles.mu_log,'Enable','Off');

end
% --- Executes on button press in pushbuttonli.
function pushbuttonli_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonli (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button


[se,t,y]=fonction_signal(M,A1,A2,A3,f1,f2,f3,fe,G,O)%signal

[Ynew,Ybis,t,y,vf]=fonction_TF(M,A1,A2,A3,f1,f2,f3,fe,G,O)

[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

y=M+A1*sin(2*pi*f1*t)+ A2*sin(2*pi*f2*t) + A3*sin(2*pi*f3*t);%fonction
%extraction

Button=get(handles.pushbuttonli,'Value')
%estimation du gain
Gest=Ybis/Ynew
%estimation de l'erreur sur le gain
erreur_G= 100*abs((Gest-G))
%estimation offset
Off_est=(Ybis(1)-Ynew(1))/20

% v=(se(1)-y(1))/2
if Button==1
    set(handles.text14,'String',['Estimation Gain =',num2str(Gest)])        
    if Off_est<0.005*max(y)
        set(handles.text15,'String',['Estimation Offset= negligeable'])
    else
        set(handles.text15,'String',['Estimation Offset = ',num2str(Off_est)])
    end
end

% --- Executes on slider movement.
function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r
global Ybis
global Ynew
global Button
a=get(hObject,'Value')
set(handles.text_a,'string',['a=',num2str(a)])
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)

axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button

b=get(hObject,'Value')
set(handles.text_b,'string',['b=',num2str(b)])
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)
axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function c_Callback(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
c=get(hObject,'Value')
set(handles.text_c,'string',['c=', num2str(c)])
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)
axes(handles.axes3)
plot(t,j,'b')
hold on;
plot(t,y,'m')
plot(t,d)
title('polynôme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% --- Executes during object creation, after setting all properties.
function c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function lambda_log_Callback(hObject, eventdata, handles)
% hObject    handle to lambda_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button
lambda=get(hObject,'Value')
set(handles.text_lambda,'string',['lambda=',num2str(lambda)])
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)
axes(handles.axes3)
plot(t,r,'b')
hold on;
plot(t,y,'m')
plot(t,q)
title('logarithme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off

% --- Executes during object creation, after setting all properties.
function lambda_log_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambda_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function mu_log_Callback(hObject, eventdata, handles)
% hObject    handle to mu_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button
mu=get(hObject,'Value')
set(handles.text_mu_log,'string',['mu=',num2str(mu)])
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)
axes(handles.axes3)
plot(t,r,'b')
hold on;
plot(t,y,'m')
plot(t,q)
title('logarithme')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% --- Executes during object creation, after setting all properties.
function mu_log_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mu_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function lambda_exp_Callback(hObject, eventdata, handles)
% hObject    handle to lambda_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button
lmbd=get(hObject,'Value')
set(handles.text_lambda1,'string',['lambda=',num2str(lmbd)])
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)
axes(handles.axes3)
plot(t,e,'b')
hold on;
plot(t,y,'m')
plot(t,h)
title('exponentielle')
xlabel('abscisse')
ylabel ('ordonnée')
hold off

% --- Executes during object creation, after setting all properties.
function lambda_exp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lambda_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function mu_exp_Callback(hObject, eventdata, handles)
% hObject    handle to mu_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global A1
global A2
global A3
global f1
global f2
global f3
global fe
global G
global O
global M
global a
global b
global c
global lmbd
global lambda
global mu 
global mu1
global t
global vf
global y
global SE
global se
global d
global j
global h
global e
global q
global r 
global Ybis
global Ynew
global Button

mu1=get(hObject,'Value')
set(handles.text_mu,'string',['mu=',num2str(mu1)])
[t,y,vf,Ynew,SE,se,d,j,h,e,q,r]= fonction_non_lineaire(M,A1,A2,A3,f1,f2,f3,fe,G,O,a,b,c,lmbd,lambda,mu,mu1)
axes(handles.axes3)
plot(t,e,'b')
hold on;
plot(t,y,'m')
plot(t,h)
title('exponentielle')
xlabel('abscisse')
ylabel ('ordonnée')
hold off
% --- Executes during object creation, after setting all properties.
function mu_exp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mu_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



