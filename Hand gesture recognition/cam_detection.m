
% PATHS FOR PROJECT NEED TO BE CONFIGURED
function varargout = cam_detection(varargin)
% cam_detection MATLAB code for cam_detection.fig
%      cam_detection, by itself, creates a new cam_detection or raises the existing
%      singleton*.
%
%      H = cam_detection returns the handle to a new cam_detection or the handle to
%      the existing singleton*.
%
%      cam_detection('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in cam_detection.M with the given input arguments.
%
%      cam_detection('Property','Value',...) creates a new cam_detection or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cam_detection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cam_detection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cam_detection

% Last Modified by GUIDE v2.5 14-Nov-2017 23:15:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cam_detection_OpeningFcn, ...
                   'gui_OutputFcn',  @cam_detection_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
path('E:\Sem 5\Digital Image Processing\HandGestureRecognition\lib\segmentation_method', path); % add lib folder to path
path('E:\Sem 5\Digital Image Processing\HandGestureRecognition\lib\recognition', path); % add lib folder to path
path('E:\Sem 5\Digital Image Processing\HandGestureRecognition\lib', path); % add lib folder to path
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before cam_detection is made visible.
function cam_detection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cam_detection (see VARARGIN)
% Choose default command line output for cam_detection
handles.output = hObject;
%get webcam handle
handles.mycam = webcam(1);
%take first snapshots
handles.image1 = snapshot(handles.mycam);    
handles.image0 = snapshot(handles.mycam);    
%set global counter
handles.counter = 0;
%create timer
%manualcapture timer
handles.timer = timer('Name','VideoTimer',          ...
                       'Period',.1,                   ... 
                       'StartDelay',1,                 ... 
                       'TasksToExecute',inf,           ... 
                       'ExecutionMode','fixedSpacing', ...
                       'TimerFcn',{@timerCallback, handles, hObject}); 

start(handles.timer);
% Update handles structure
guidata(hObject,handles);
% UIWAIT makes cam_detection wait for user response (see UIRESUME)
 uiwait(handles.figure1);

function timerCallback(hObj, eventdata, handles, hObject)
   % do stuff periodically
   %take and show snapshot
   img = snapshot(handles.mycam);
   imshow(img, 'Parent', handles.axes1);
   handles.image0 = img;
   guidata(hObject,handles);
 
% --- Outputs from this function are returned to the command line.
function varargout = cam_detection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in recognize_button.
function recognize_button_Callback(hObject, eventdata, handles)
% hObject    handle to recognize_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%take snapshot
img = snapshot(handles.mycam);
%show user that we are doing something
set(handles.text1,'String','Recognizing... Please WAIT')
%perform recognition
%WARNING - recognize not always returns expected output (namely when 
%recognition fails)
[L] = recognize(im2double(img));
%show detected character

set(handles.recognized,'String',char(L));
set(handles.text1,'String','Done')
%imshow(imabsdiff(img,handles.bcg), 'Parent', handles.axes1);

% --- Executes when user attempts to close figure1.
    function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%stop(handles.timer);
%clean workspace
%delete(timerfind('Name','ExampleTimer'));
%delete(timerfind('Name','VideoTimer'));

%clear handles.timer;
%clear handles.timer2;
%clear handles.mycam;
%delete(handles.mycam);
% Hint: delete(hObject) closes the figure
%delete(hObject);

