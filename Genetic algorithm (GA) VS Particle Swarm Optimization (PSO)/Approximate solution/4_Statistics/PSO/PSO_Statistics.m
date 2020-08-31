function varargout = PSO_Statistics(varargin)
% GA_STATISTICS MATLAB code for GA_Statistics.fig
%      GA_STATISTICS, by itself, creates a new GA_STATISTICS or raises the existing
%      singleton*.
%
%      H = GA_STATISTICS returns the handle to a new GA_STATISTICS or the handle to
%      the existing singleton*.
%
%      GA_STATISTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GA_STATISTICS.M with the given input arguments.
%
%      GA_STATISTICS('Property','Value',...) creates a new GA_STATISTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GA_Statistics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GA_Statistics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GA_Statistics

% Last Modified by GUIDE v2.5 22-Dec-2018 19:44:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GA_Statistics_OpeningFcn, ...
    'gui_OutputFcn',  @GA_Statistics_OutputFcn, ...
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


% --- Executes just before GA_Statistics is made visible.
function GA_Statistics_OpeningFcn(hObject, eventdata, handles, varargin)

% Parametre Global
global PSO_Best_Fit PSO_Avrg_Fit PSO_Fitness_Ecart PSO_Best_Chrom_Found
global PSO_TimeforeachTest PSO_Time_All_Sec PSO_Time_All_Min PSO_Time_Par_Test
global f
clc ; % Netoyer la console
movegui(gcf,'center') % Centrer la figure
load('Results_PSO.mat') % Charger les varibales depuis le fichier .mat

%% Best Fitness
[PSO_Best_Fit,index] = max(Best_Found_PSO'); % Calculer le Max de Fitness Trouver

set(handles.uitableBest_Fit,'Data',PSO_Best_Fit); % Affciher dans le Tableau
set(handles.uitableBest_Fit,'ColumnWidth', {40}); % Definire la largeur des colonnes

%% Average Fitness
PSO_Avrg_Fit = sum(Best_Found_PSO,2)/30; % Calculer la Moyen des fitness
PSO_Avrg_Fit = PSO_Avrg_Fit'; % Transpose
PSO_Avrg_Fit = int32(PSO_Avrg_Fit); % Convertire en Entier base 32

set(handles.uitableAvrg_Fit,'Data',PSO_Avrg_Fit); % Affciher dans le Tableau
set(handles.uitableAvrg_Fit,'ColumnWidth', {40}); % Definire la largeur des colonnes

%% Fitness Ecart For each Test
PSO_Fitness_Ecart = PSO_Best_Fit(:) - double(PSO_Avrg_Fit(:)); % Calculer l'ecart

set(handles.uitableEcart_Fit,'Data',PSO_Fitness_Ecart'); % Affciher dans le Tableau
set(handles.uitableEcart_Fit,'ColumnWidth', {40});

%% Average / Total Time
PSO_TimeforeachTest = sum(PSO_Exec_Time'); % Temps de chaque test
PSO_Time_All_Sec = sum(sum(PSO_Exec_Time)); % Temps d'execution totatl en secondes
PSO_Time_All_Min = PSO_Time_All_Sec / 60; % Temps d'execution totatl en minutes
PSO_Time_Par_Test = PSO_Time_All_Sec / 30; % Temps Moyen

% Afficher les statistiques de temps
set(handles.textTime_All,'string',num2str(PSO_Time_All_Sec));
set(handles.textToMinutes,'string',num2str(PSO_Time_All_Min));
set(handles.textTime_Par_Test,'string',num2str(PSO_Time_Par_Test));

set(handles.uitableAvrg_Time,'Data',PSO_TimeforeachTest);
set(handles.uitableAvrg_Time,'ColumnWidth', {40});

%% Obtenez les meilleurs chrom trouvé de chaque test
for i = 1 : 30
    PSO_Best_Chrom_Found{i} = PSO_Best_Chrom{i,index(i)};
end

if isempty(f)
    f = figure('Name','Best Fitness Found by GA & PSO for each Test');
end

figure(f)
hold on;
plot(PSO_Best_Fit(:),'-*','MarkerIndices',1:30)
xlabel('Nombre de Test')
ylabel('Fitness')
legend({'GA','PSO'})

solo = figure('Name','Best fitness Found by PSO  through Time ');
figure(solo)
hold on;
plot(PSO_TimeforeachTest,PSO_Best_Fit(:),'-*','MarkerIndices',1:30)
xlabel('Temps d-exécution') 
ylabel('Fitness')

% Choose default command line output for GA_Statistics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GA_Statistics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GA_Statistics_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;


% --- Executes on button press in pushbuttonSave_PSO.
function pushbuttonSave_PSO_Callback(hObject, eventdata, handles)

Folder = '5_Results'; % Nom du dossier a creer/ecrire
Algo = 'KnapSack_PSO'; % Semi-Nom de fichier a sauvegarder
File_Name = get(handles.editFile_Name_PSO,'String'); % Recuperer le nom du fichier 

Par_Date_Time = char(datetime('today')); % Recuperer la date actuel
mkdir(Folder,Par_Date_Time) % Creer un dossier et un sous-dossier daté

Directory = [Folder '/' Par_Date_Time '/']; % Concatener les Noms
TestName = [Directory Algo '_' File_Name ]; % Nom Finale du fichier a sauvegarder

Save_Results_PSO(TestName); % Appel au fontion de sauvegarde

% Message (Ques) Box, Pour ouvrire le fichier sauvegarder
answer = questdlg({'PSO Results Saved !'; ...
    'Check the <<Result>> folder under the dated sub-folder.'; ...
    ['Here : "' TestName '.txt"'];
    'To acces the saved file.'; ...
    ''; ...
    'Would you like to open it ?.'}, ...
    'PSO Notice','Yes','No thank you','modal');

switch answer
    case 'Yes'
        eval(['!notepad ' TestName])
end



function editFile_Name_PSO_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editFile_Name_PSO_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
