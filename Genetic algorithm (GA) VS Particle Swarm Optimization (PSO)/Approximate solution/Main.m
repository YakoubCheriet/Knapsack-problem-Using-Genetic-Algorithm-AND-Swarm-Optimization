function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 02-Feb-2019 21:09:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Main_OpeningFcn, ...
    'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)

movegui(gcf,'center'); % Mettre la figure en centre de l'ecrant
warning('off','all'); % Disactiver les messages d'avertissement(pour la generation graphic des interfaces)

folder = fileparts(which(mfilename)); % Déterminez où se trouve le dossier de votre fichier m.
addpath(genpath(folder)); % Ajoutez ce dossier ainsi que tous les sous-dossiers au chemin.

set(handles.checkboxSlect_AG,'value',1) ; % coche le checkbox
set(handles.checkboxSlect_PSO,'value',1) ; % coche le checkbox

set(handles.pushbuttonStartPSO,'Enable','on')
set(handles.pushbuttonStartAG,'Enable','on')

set(handles.uitableAG, 'Data', {}) % Vider les Tables
set(handles.uitablePSO, 'Data', {})

clc ; % Effacer la ligne de commande
clear global; % Effacer toutes les variables Global sauvegardées précédemment

Load_State(handles) % Charger les parametre sauvegarder

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles)

% Bring the setting in front

Global_Setting % Demarage du figure en mode modal, des que la figure Menu s'affiche
movegui(Global_Setting)

varargout{1} = handles.output;

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)

Save_State(handles); % Sauvegarder les parametres des la fermeture de la figure Menu

delete(hObject);

% Sauvegarder les parametres de Gui
function Save_State(handles)

state_GA.Proba_Cross = str2double(get(handles.editProb_Cross,'String'));
state_GA.Proba_Mut = str2double(get(handles.editProb_Mut,'String'));

state_PSO.C1 = str2double(get(handles.editC1,'String'));
state_PSO.C2 = str2double(get(handles.editC2,'String'));
state_PSO.W = str2double(get(handles.editW1,'String'));

save('4_Statistics/Menu_Setting_Status.mat','state_GA','state_PSO');

% Charger les parametres de Gui
function Load_State(handles)

global state_PSO state_GA

File_Name = 'Menu_Setting_Status.mat';

if exist(File_Name,'file')
    
    load(File_Name)
    
    set(handles.editProb_Cross,'String',state_GA.Proba_Cross);
    set(handles.editProb_Mut,'String',state_GA.Proba_Mut);
    
    set(handles.editC1,'String',state_PSO.C1);
    set(handles.editC2,'String',state_PSO.C2);
    set(handles.editW1,'String',state_PSO.W);
    
    delete(File_Name);
end


% --- Executes on button press in pushbuttonPar_Glob.
function pushbuttonPar_Glob_Callback(hObject, eventdata, handles)
Global_Setting
set(handles.pushbuttonStartPSO,'Enable','on')
set(handles.pushbuttonStartAG,'Enable','on')

% --- Executes on button press in pushbuttonGen_Tests.
function pushbuttonGen_Tests_Callback(hObject, eventdata, handles)
Generateur_Tests

% --- Executes on button press in pushbuttonGen_TestPSO.
function pushbuttonGen_TestPSO_Callback(hObject, eventdata, handles)



function editProb_Cross_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editProb_Cross_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editProb_Mut_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editProb_Mut_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editPop_Size_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editPop_Size_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editC1_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editC1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editW1_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editW1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editC2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editC2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editW2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editW2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxSlect_AG.
function checkboxSlect_AG_Callback(hObject, eventdata, handles)

value = get(handles.checkboxSlect_AG, 'Value');

if value == 1
    set(handles.pushbuttonSelectTest_AG,'Enable','off')
else
    set(handles.pushbuttonSelectTest_AG,'Enable','on')
end

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbuttonSelectTest_PSO.
function pushbuttonSelectTest_PSO_Callback(hObject, eventdata, handles)

% Parametres Globales
global Objet_Nbr Vect_Weight Vect_Profit Sac_Max_capacity

% Recuperer le Repertoire du fichier selectionner
[file,path] = uigetfile('*.txt',...
    'Selectioner votre test Sil vous plait','Test.txt');
if isequal(file,0)
    disp('Selection annuler');
    set(handles.checkboxSlect_PSO,'value',1)
else
    msgbox('fichier selectionner');
    set(handles.checkboxSlect_PSO,'value',0)
end

path = (fullfile(path,file));

% Lecture du fichier selectionner
[ Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity ] = Read_File(path);

% --- Executes on button press in checkboxSlect_PSO.
function checkboxSlect_PSO_Callback(hObject, eventdata, handles)

value = get(handles.checkboxSlect_PSO, 'Value');

if value == 1
    set(handles.pushbuttonSelectTest_PSO,'Enable','off')
else
    set(handles.pushbuttonSelectTest_PSO,'Enable','on')
end

% --- Executes on button press in pushbuttonSelectTest_AG.
function pushbuttonSelectTest_AG_Callback(hObject, eventdata, handles)

global Objet_Nbr Vect_Weight Vect_Profit Sac_Max_capacity

[file,path] = uigetfile('*.txt',...
    'Selectioner votre test Sil vous plait','Test.txt');
if isequal(file,0)
    disp('Selection annuler');
    set(handles.checkboxSlect_AG,'value',1)
else
    msgbox('fichier selectionner');
    set(handles.checkboxSlect_AG,'value',0)
end

path = (fullfile(path,file));

[ Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity ] = Read_File(path);


% --- Executes on button press in pushbuttonStatsAG.
function pushbuttonStatsAG_Callback(hObject, eventdata, handles)
GA_Statistics

% --- Executes on button press in pushbuttonStatsPSO.
function pushbuttonStatsPSO_Callback(hObject, eventdata, handles)
PSO_Statistics

function editTest_IterAG_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editTest_IterAG_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonStartAG.
function pushbuttonStartAG_Callback(hObject, eventdata, handles)

% Parametres globales
global Best_Found_AG AG_Exec_Time AG_Best_Chrom
global Objet_Nbr Vect_Weight Vect_Profit Sac_Max_capacity Test_Iter

Save_State(handles) % Sauvegarder l'etat du Gui
clc; % Netoyer la console

value = get(handles.checkboxSlect_AG, 'Value'); % recuperer la valeur de check box
set(handles.uitableAG, 'Data', {})

% Recuperer les Probabilites Mutation,Croissement
Proba_Cross = str2double(get(handles.editProb_Cross,'String'));
Proba_Mut = str2double(get(handles.editProb_Mut,'String'));

Test_Nbr = 30; % Nombre de test
% Vecteur de N° d'objet
Vect_Objet_Nbr = [20,30,40,50,60,80,100,120,140,150,180,200,300,400,500];
k = 1; % Indice de vecteur Vect_Objet_Nbr

% Déterminez où se trouve le dossier de fichier m.
folder = fileparts(which(mfilename));

folder = [folder '/Tests/Auto/'];

% Initialisation
Best_Found_AG = [];
AG_Exec_Time = [];
AG_Best_Chrom = [];

set(handles.uitableAG,'ColumnWidth', {32}); % Largeur de colonnes de tableau

if value == 0 % Si le CheckBox est Non Coché
    
    for i = 1 : Test_Iter % Nombre d'execution pour chaque test
        [Best_Found_AG(i),AG_Exec_Time(i),AG_Best_Chrom(i,:)] = KnapSack_AG(Proba_Cross,Proba_Mut );
    end
    
    set(handles.uitableAG,'Data',Best_Found_AG); % Affichage des meilleurs fitness trouver
    
    [Best_Fit,index] = max(Best_Found_AG); % Calculer le max des fitness
    Average_Fit = sum(Best_Found_AG)/30; % Moyen des fitness
    Ecart_Fit = Best_Found_AG - Average_Fit; % Ecart des fitness
    Time_All_Sec = num2str(sum(AG_Exec_Time)); % Temps d'execution total en secondes
    
    % Organisation d'affichage dans le messageBox
    Message1 = ['Best Fitnes found : ' num2str(Best_Fit)];
    Message2 = ['Average Fitnes found : ' num2str(Average_Fit)];
    Message3 = ['Total execution time : ' Time_All_Sec ' /sec'];
    Message4 = ['Best Chrom Found : ' num2str(AG_Best_Chrom(index,:))];
    
    msgbox({'GA Test just Finished !';Message1;Message2;Message3},'GA Notice','help','modal');
    
    % Organisation d'affichage dans la console
    fprintf('**************************************************************************\nGA :');
    fprintf(['\n' Message1,'\n' Message2,'\nEcart of Fitnes : ',num2str(Ecart_Fit),'\n' Message3,'\n' Message4, ]);
    fprintf('\n************************************************************************** \n');

else % Si le checkBox est Coché
    
    for i = 1 : Test_Nbr % Parcourire selon le N° de test = 30 fois
        
        if i <= 10 % Catego EAZY
            if mod(i,2)
                TestName = [folder 'Easy/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-1.txt'];
            else
                % Nommer le fichier txt selon le nombre d'objer
                TestName = [folder 'Easy/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-2.txt'];
                k = k + 1; % Incrementer l'indice de vecteur d'objet
            end
            
        elseif i > 10 && i <= 20 % Catego MOYEN
            if mod(i,2)
                TestName = [folder 'Medium/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-1.txt'];
            else
                TestName = [folder 'Medium/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-2.txt'];
                k = k + 1;
            end
            
        elseif i > 20 % Catego Hard
            if mod(i,2)
                TestName = [folder 'Hard/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-1.txt'];
            else
                TestName = [folder 'Hard/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-2.txt'];
                k = k + 1;
            end
            
        end
        
        for j = 1 : Test_Iter % Selon le nombre d'execution pour chaque test
            
            [ Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity ] = Read_File(TestName);
            [Best_Found_AG(i,j),AG_Exec_Time(i,j),AG_Best_Chrom{i,j}] = KnapSack_AG(Proba_Cross,Proba_Mut);

        end
        
        pause(0.1) % Faire un pause pour l'affichage dans le tableau
        set(handles.uitableAG,'Data',Best_Found_AG); % Afficher dans le tableau les fitness
        
    end
    
    % Sauvegarder les valeur trouver
    save('5_Results/Results_AG','Best_Found_AG','AG_Best_Chrom','AG_Exec_Time');
    
    % Message Box
    msgbox({'GA Execution just Finished !';...
            'Click on "Statistics" button to see more details.'}, ...
            'GA Notice','help','modal');
end


function editTest_IterPSO_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editTest_IterPSO_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonStartPSO.
function pushbuttonStartPSO_Callback(hObject, eventdata, handles)

Save_State(handles)
clc;
value = get(handles.checkboxSlect_PSO, 'Value');
set(handles.uitablePSO, 'Data', {})

global Best_Found_PSO PSO_Exec_Time PSO_Best_Chrom
global Objet_Nbr Vect_Weight Vect_Profit Sac_Max_capacity Test_Iter

C1 = str2double(get(handles.editC1,'String'));
C2 = str2double(get(handles.editC2,'String'));
W = str2double(get(handles.editW1,'String'));

Test_Nbr = 30;
Vect_Objet_Nbr = [20,30,40,50,60,80,100,120,140,150,180,200,300,400,500];
k = 1;

folder = fileparts(which(mfilename));
folder = [folder '/Tests/Auto/'];

Best_Found_PSO = [];
PSO_Best_Chrom = [];
PSO_Exec_Time = 0;

set(handles.uitablePSO,'ColumnWidth', {32})

if value == 0
    
    for i = 1 : Test_Iter
        [Best_Found_PSO(i),PSO_Exec_Time(i)] = KnapSac_PSO( C1,C2,W );
    end
    
    for i = 1 : Test_Iter
        [Best_Found_PSO(i),PSO_Exec_Time(i),PSO_Best_Chrom(i,:)] = KnapSac_PSO( C1,C2,W );
    end
    
    set(handles.uitablePSO,'Data',Best_Found_PSO);
    
    [Best_Fit,index] = max(Best_Found_PSO);
    Average_Fit = sum(Best_Found_PSO)/30;
    Ecart_Fit = Best_Found_PSO - Average_Fit;
    Time_All_Sec = num2str(sum(PSO_Exec_Time));
    
    Message1 = ['Best Fitnes found : ' num2str(Best_Fit)];
    Message2 = ['Average Fitnes found : ' num2str(Average_Fit)];
    Message3 = ['Total execution time : ' Time_All_Sec ' /sec'];
    Message4 = ['Best Chrom Found : ' num2str(PSO_Best_Chrom(index,:))];
    
    msgbox({'PSO Test just Finished !';Message1;Message2;Message3},'PSO Notice','help','modal');
    
    fprintf('**************************************************************************\nPSO :');
    fprintf(['\n' Message1,'\n' Message2,'\nEcart of Fitnes : ',num2str(Ecart_Fit),'\n' Message3,'\n' Message4, ]);
    fprintf('\n************************************************************************** \n');
else
    
    for i = 1 : Test_Nbr
        
        if i <= 10
            if mod(i,2)
                TestName = [folder 'Easy/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-1.txt'];
            else
                TestName = [folder 'Easy/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-2.txt'];
                k = k + 1;
            end
            
        elseif i > 10 && i <= 20
            if mod(i,2)
                TestName = [folder 'Medium/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-1.txt'];
            else
                TestName = [folder 'Medium/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-2.txt'];
                k = k + 1;
            end
            
        elseif i > 20
            if mod(i,2)
                TestName = [folder 'Hard/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-1.txt'];
            else
                TestName = [folder 'Hard/KnapSack_' num2str(Vect_Objet_Nbr(k)) '-2.txt'];
                k = k + 1;
            end
            
        end
        
        for j = 1 : Test_Iter
            
            [ Objet_Nbr,Vect_Weight,Vect_Profit,Sac_Max_capacity ] = Read_File(TestName);
            [Best_Found_PSO(i,j),PSO_Exec_Time(i,j),PSO_Best_Chrom{i,j}] = KnapSac_PSO( C1,C2,W );
            
        end
        
        pause(0.1)
        set(handles.uitablePSO,'Data',Best_Found_PSO);
        
    end
    
    save('5_Results/Results_PSO','Best_Found_PSO','PSO_Best_Chrom','PSO_Exec_Time');
    msgbox({'PSO Execution just Finished !';'Click on "Statistics" button to see more details.'},'PSO Notice','help','modal');
end
