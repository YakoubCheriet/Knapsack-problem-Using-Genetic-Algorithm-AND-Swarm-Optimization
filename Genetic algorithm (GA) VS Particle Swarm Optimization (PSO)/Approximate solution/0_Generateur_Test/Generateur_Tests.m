function varargout = Generateur_Tests(varargin)
% GENERATEUR_TESTS MATLAB code for Generateur_Tests.fig
%      GENERATEUR_TESTS, by itself, creates a new GENERATEUR_TESTS or raises the existing
%      singleton*.
%
%      H = GENERATEUR_TESTS returns the handle to a new GENERATEUR_TESTS or the handle to
%      the existing singleton*.
%
%      GENERATEUR_TESTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERATEUR_TESTS.M with the given input arguments.
%
%      GENERATEUR_TESTS('Property','Value',...) creates a new GENERATEUR_TESTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Generateur_Tests_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Generateur_Tests_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Generateur_Tests

% Last Modified by GUIDE v2.5 24-Dec-2018 16:11:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Generateur_Tests_OpeningFcn, ...
    'gui_OutputFcn',  @Generateur_Tests_OutputFcn, ...
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


% --- Executes just before Generateur_Tests is made visible.
function Generateur_Tests_OpeningFcn(hObject, eventdata, handles, varargin)

movegui('center'); % Center la fenetre

% Disactiver des config gui
set(handles.pushbuttonSave,'Enable','off') ;
set(handles.editTestName,'Enable','off') ;
set(handles.checkbox3,'value',1) ;
set(handles.editNbObjet,'Enable','off')

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Generateur_Tests wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Generateur_Tests_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


% --- Executes on button press in pushbuttonGenrate_Test.
function pushbuttonGenrate_Test_Callback(hObject, eventdata, handles)
clc; % Netoyer la console

% Parametre Global
global Sac_Max_capacity Vect_Weight Vect_Profit Objet_Nbr

value = get(handles.checkbox3, 'Value'); % Recuperer la valuer de CheckBox

if value == 1 % Si le checkBox est coché
    
    warning('off','all') % Disactiver l'affichage d'avertissement
    % Créer des répertoires
    folder = 'Tests/Auto/';
    mkdir('Tests/Auto/Easy');
    mkdir('Tests/Auto/Medium');
    mkdir('Tests/Auto/Hard');
    
    % Recuperation des valeurs INTERVAL de Poids,Profits depuis les Edits
    Poids = [str2double(get(handles.editPoids1,'String'));str2double(get(handles.editPoids2,'String'))];
    Profit = [str2double(get(handles.editProfit1,'String'));str2double(get(handles.editProfit2,'String'))];
    
    % Numéro d'objet pour chaque test
    Objet_Nbr = [20,30,40,50,60,80,100,120,140,150,180,200,300,400,500];
    k = 1; % Indice pour le vecteur Objet_Nbr 
    
    for i = 1 :15 % Parcoure N° de Test / 2 (30/2)
        
        if i <= 5 % Premier catego EASY
            
            TestName = [folder 'Easy/KnapSack_' num2str(Objet_Nbr(k)) '-1']; % Concat des Nom fichier TXT
            [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr(k)); % Creer les parametres
            Save_File(Objet_Nbr(k),Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName); % Sauvegarder les Parametres
            
            TestName = [folder 'Easy/KnapSack_' num2str(Objet_Nbr(k)) '-2'];
            [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr(k));
            Save_File(Objet_Nbr(k),Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName);
            
            k = k + 1;
            
        elseif i > 5 & i <= 10 % Dexieme Catego MOYENNE
            
            TestName = [folder 'Medium/KnapSack_' num2str(Objet_Nbr(k)) '-1'];
            [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr(k));
            Save_File(Objet_Nbr(k),Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName);
            
            TestName = [folder 'Medium/KnapSack_' num2str(Objet_Nbr(k)) '-2'];
            [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr(k));
            Save_File(Objet_Nbr(k),Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName);
            
            k = k + 1;
            
        else % Troixieme Catego HARD
            
            TestName = [folder 'Hard/KnapSack_' num2str(Objet_Nbr(k)) '-1'];
            [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr(k));
            Save_File(Objet_Nbr(k),Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName);
            
            TestName = [folder 'Hard/KnapSack_' num2str(Objet_Nbr(k)) '-2'];
            [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr(k));
            Save_File(Objet_Nbr(k),Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName);
            
            k = k + 1;
        end
        
    end
    
    disp('Test Files Created');
    
else % Si checkBox non coché
    
    % Recuperation des valeurs INTERVAL de Poids,Profits depuis les Edits
    Objet_Nbr = str2double(get(handles.editNbObjet,'String'));
    Poids = [str2double(get(handles.editPoids1,'String'));str2double(get(handles.editPoids2,'String'))];
    Profit = [str2double(get(handles.editProfit1,'String'));str2double(get(handles.editProfit2,'String'))];
    [Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr);
    set(handles.pushbuttonSave,'Enable','on');
    
    % Affichage des parametres
    fprintf('**************************************************************************');
    fprintf(['\n Nombre d Objet : ',num2str(Objet_Nbr),...
        '\n Vecteur Poids : ',num2str(Vect_Weight),...
        '\n Vecteur Profit :',num2str(Vect_Profit),...
        '\n Capacite max du sac : ' ,num2str(Sac_Max_capacity),'\n'])
    fprintf('\n ************************************************************************** \n');
    
end


% --- Executes on button press in pushbuttonSave.
function pushbuttonSave_Callback(hObject, eventdata, handles)

% Parametre global
global Sac_Max_capacity Vect_Weight Vect_Profit Objet_Nbr

TestName = get(handles.editTestName,'String'); % Nom de fichier a sauvegarder

if strcmp(TestName,'') % Si pas de nom donner un nom par default
    TestName = 'Default_Name';
end

warning('off','all') % Disactiver les affichages d'avertissement
mkdir('Tests/Manuel'); % Creer un repertoire
TestName = ['Tests/Manuel/' TestName]; % Concat des nom de fichier

% Recuperation des valeurs INTERVAL de Poids,Profits depuis les Edits
Objet_Nbr = str2double(get(handles.editNbObjet,'String'));
Poids = [str2double(get(handles.editPoids1,'String'));str2double(get(handles.editPoids2,'String'))];
Profit = [str2double(get(handles.editProfit1,'String'));str2double(get(handles.editProfit2,'String'))];
[Vect_Weight,Vect_Profit,Sac_Max_capacity] = Create_Inputs(Profit,Poids,Objet_Nbr);
set(handles.pushbuttonSave,'Enable','on');

% Afficher les parametres
fprintf('**************************************************************************');
fprintf(['\n Nombre d Objet : ',num2str(Objet_Nbr),...
    '\n Vecteur Poids : ',num2str(Vect_Weight),...
    '\n Vecteur Profit :',num2str(Vect_Profit),...
    '\n Capacite max du sac : ' ,num2str(Sac_Max_capacity),'\n'])
fprintf('\n ************************************************************************** \n');

% Sauvegarder les parametre dans un Fichier txt
Save_File(Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity,TestName);


function editNbObjet_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editNbObjet_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPoids1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editPoids1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editPoids2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editPoids2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editProfit1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editProfit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editProfit2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editProfit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonRead.
function pushbuttonRead_Callback(hObject, eventdata, handles)

% Parametre global
global  Sac_Max_capacity Vect_Weight Vect_Profit Objet_Nbr

% Recuperer le repertoire du fichier selectionner
[file,path] = uigetfile('*.txt',...
    'Selectioner votre test Sil vous plait','Test.txt');
if isequal(file,0)
    disp('Selection annuler');
else
    msgbox('fichier selectionner');
end

path = (fullfile(path,file));

% Lecture de fichier selectionner
[ Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity ] = Read_File_Sample(path);


function editTestName_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function editTestName_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxAuto.
function checkboxAuto_Callback(hObject, eventdata, handles)


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)

% Changement de Gui depuis le changement de checkBox
value = get(handles.checkbox3, 'Value');

if value == 1
    set(handles.pushbuttonGenrate_Test,'Enable','on')
    set(handles.editTestName,'Enable','off')
    set(handles.pushbuttonSave,'Enable','off')
    set(handles.editNbObjet,'Enable','off')
else
    set(handles.editNbObjet,'Enable','on')
    set(handles.editTestName,'Enable','on')
    set(handles.pushbuttonSave,'Enable','on')
    set(handles.pushbuttonGenrate_Test,'Enable','off')
end
