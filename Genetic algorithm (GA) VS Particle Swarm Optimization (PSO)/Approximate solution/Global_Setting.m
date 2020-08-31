function varargout = Global_Setting(varargin)
% GLOBAL_SETTING MATLAB code for Global_Setting.fig
%      GLOBAL_SETTING, by itself, creates a new GLOBAL_SETTING or raises the existing
%      singleton*.
%
%      H = GLOBAL_SETTING returns the handle to a new GLOBAL_SETTING or the handle to
%      the existing singleton*.
%
%      GLOBAL_SETTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GLOBAL_SETTING.M with the given input arguments.
%
%      GLOBAL_SETTING('Property','Value',...) creates a new GLOBAL_SETTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Global_Setting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Global_Setting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Global_Setting

% Last Modified by GUIDE v2.5 12-Jan-2019 15:30:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Global_Setting_OpeningFcn, ...
    'gui_OutputFcn',  @Global_Setting_OutputFcn, ...
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


% --- Executes just before Global_Setting is made visible.
function Global_Setting_OpeningFcn(hObject, eventdata, handles, varargin)

movegui(gcf,'center') % Centrer la figure
clc; % netoyer la console

handles.output = hObject;

% --- in case the window is closed => return pre-set values
% Parametres globales
global Max_Iter Exec_Time Test_Iter Pop_Size CRO_Bool

Max_Iter = str2double(get(handles.editMax_Iter,'String'));
Exec_Time = str2double(get(handles.editExc_Time,'String'));
Test_Iter = str2double(get(handles.editTest_IterAG,'String'));
Pop_Size = str2double(get(handles.editPopSize,'String'));
CRO_Bool = get(handles.checkboxRepair, 'Value'); % recuperer la valeur de check box

if strcmp(handles.editMax_Iter.Enable,'off')
    Max_Iter = -1;
elseif strcmp(handles.editExc_Time.Enable,'off')
    Exec_Time = -1;
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Global_Setting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Global_Setting_OutputFcn(hObject, eventdata, handles)

warning('off','all');
Load_State(handles) % Charger les parametres savegarder

varargout{1} = handles.output;



function editExc_Time_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editExc_Time_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMax_Iter_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editMax_Iter_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenuCritere.
function popupmenuCritere_Callback(hObject, eventdata, handles)

global Crit_Setting

contents = get(handles.popupmenuCritere,'String');
Value = contents{get(handles.popupmenuCritere,'Value')};

if strcmp(Value,'Iteration (Generation)') == 1
    Crit_Setting = 1;
    set(handles.editMax_Iter,'Enable','on');
    set(handles.editExc_Time,'Enable','off');
elseif strcmp(Value,'Execution time') == 1
    Crit_Setting = 2;
    set(handles.editMax_Iter,'Enable','off');
    set(handles.editExc_Time,'Enable','on');
elseif strcmp(Value,'Iteration (Generation) and Execution Time') == 1
    Crit_Setting = 3;
    set(handles.editMax_Iter,'Enable','on');
    set(handles.editExc_Time,'Enable','on');
end

% --- Executes during object creation, after setting all properties.
function popupmenuCritere_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbuttonSet.
function pushbuttonSet_Callback(hObject, eventdata, handles)

global Max_Iter Exec_Time Test_Iter Pop_Size CRO_Bool
global CRO_Type

Max_Iter = str2double(get(handles.editMax_Iter,'String'));
Exec_Time = str2double(get(handles.editExc_Time,'String'));
Test_Iter = str2double(get(handles.editTest_IterAG,'String'));
Pop_Size = str2double(get(handles.editPopSize,'String'));
CRO_Bool = get(handles.checkboxRepair, 'Value'); % recuperer la valeur de check box

if strcmp(handles.editMax_Iter.Enable,'off')
    Max_Iter = -1;
elseif strcmp(handles.editExc_Time.Enable,'off')
    Exec_Time = -1;
end

if strcmp(handles.popupmenuCRO_Type.Enable, 'on')
    contents = get(handles.popupmenuCRO_Type,'String');
    value = contents{get(handles.popupmenuCRO_Type,'Value')};
    CRO_Type = value;
end

close

% Sauvegarder les parametres de Gui
function Save_State(handles)

global CRO_Setting Crit_Setting

state.Max_Iter = str2double(get(handles.editMax_Iter,'String'));
state.Exec_Time = str2double(get(handles.editExc_Time,'String'));
state.Test_Iter = str2double(get(handles.editTest_IterAG,'String'));
state.Pop_Size = str2double(get(handles.editPopSize,'String'));

state.Checked_CRO = CRO_Setting.Checked;
state.Selected_CRO = CRO_Setting.Selected;

state.Selected_Crit = Crit_Setting;

save('4_Statistics/Global_Setting_Status.mat','state');

% Charger les parametres de Gui
function Load_State(handles)

global CRO_Setting Crit_Setting

File_Name = 'Global_Setting_Status.mat';

if exist(File_Name,'file')
    
    load(File_Name)
    
    set(handles.popupmenuCritere,'value',state.Selected_Crit);
    Adjust_Figure(handles)
    set(handles.editMax_Iter,'String',state.Max_Iter);
    set(handles.editExc_Time,'String',state.Exec_Time);
    set(handles.editTest_IterAG,'String',state.Test_Iter);
    set(handles.editPopSize,'String',state.Pop_Size);
    set(handles.popupmenuCRO_Type, 'Value', state.Selected_CRO)
    set(handles.checkboxRepair,'value',state.Checked_CRO)
    
    CRO_Setting.Selected = state.Selected_CRO;
    Crit_Setting = state.Selected_Crit;
    
    if state.Checked_CRO == 1
        CRO_Setting.Checked = 1;
        set(handles.textCRO,'Enable','on');
        set(handles.popupmenuCRO_Type,'Enable','on');
    else
        CRO_Setting.Checked = 0;
        set(handles.textCRO,'Enable','off');
        set(handles.popupmenuCRO_Type,'Enable','off');
    end
    
    delete(File_Name);
end


function Adjust_Figure(handles)

contents = get(handles.popupmenuCritere,'String');
Value = contents{get(handles.popupmenuCritere,'Value')};

if strcmp(Value,'Iteration (Generation)') == 1
    set(handles.editMax_Iter,'Enable','on');
    set(handles.editExc_Time,'Enable','off');
elseif strcmp(Value,'Execution time') == 1
    set(handles.editMax_Iter,'Enable','off');
    set(handles.editExc_Time,'Enable','on');
elseif strcmp(Value,'Iteration (Generation) and Execution Time') == 1
    set(handles.editMax_Iter,'Enable','on');
    set(handles.editExc_Time,'Enable','on');
end


function editTest_IterAG_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editTest_IterAG_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function editPopSize_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function editPopSize_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)

Save_State(handles); % Sauvegarder les parametres de Gui

delete(hObject);


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in checkboxRepair.
function checkboxRepair_Callback(hObject, eventdata, handles)

global CRO_Setting

value = get(handles.checkboxRepair, 'Value');

if value == 1
    CRO_Setting.Checked = 1;
    set(handles.textCRO,'Enable','on')
    set(handles.popupmenuCRO_Type,'Enable','on')
else
    CRO_Setting.Checked = 0;
    set(handles.textCRO,'Enable','off')
    set(handles.popupmenuCRO_Type,'Enable','off')
end



% --- Executes on selection change in popupmenuCRO_Type.
function popupmenuCRO_Type_Callback(hObject, eventdata, handles)

global CRO_Setting

contents = get(handles.popupmenuCRO_Type,'String');
Value = contents{get(handles.popupmenuCRO_Type,'Value')};

if strcmp(Value,'1- Sequence') == 1
    CRO_Setting.Selected = 1;
elseif strcmp(Value,'2- Profit') == 1
    CRO_Setting.Selected = 2;
elseif strcmp(Value,'3- Weight') == 1
    CRO_Setting.Selected = 3;
elseif strcmp(Value,'4- Ratio (Profit / Weight)') == 1
    CRO_Setting.Selected = 4;
elseif strcmp(Value,'5- Mix (1, 2, 3 & 4)') == 1
    CRO_Setting.Selected = 5;
end


% --- Executes during object creation, after setting all properties.
function popupmenuCRO_Type_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
