function varargout = DSP_FFT_Resolution(varargin)
% DSP_FFT_RESOLUTION MATLAB code for DSP_FFT_Resolution.fig
%      DSP_FFT_RESOLUTION, by itself, creates a new DSP_FFT_RESOLUTION or raises the existing
%      singleton*.
%
%      H = DSP_FFT_RESOLUTION returns the handle to a new DSP_FFT_RESOLUTION or the handle to
%      the existing singleton*.
%
%      DSP_FFT_RESOLUTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DSP_FFT_RESOLUTION.M with the given input arguments.
%
%      DSP_FFT_RESOLUTION('Property','Value',...) creates a new DSP_FFT_RESOLUTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DSP_FFT_Resolution_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DSP_FFT_Resolution_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DSP_FFT_Resolution

% Last Modified by GUIDE v2.5 24-Sep-2020 16:10:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DSP_FFT_Resolution_OpeningFcn, ...
                   'gui_OutputFcn',  @DSP_FFT_Resolution_OutputFcn, ...
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


% --- Executes just before DSP_FFT_Resolution is made visible.
function DSP_FFT_Resolution_OpeningFcn(hObject, eventdata, handles, varargin)

   handles.data.enable_sinusoid_1 = 1;
   handles.data.enable_sinusoid_2 = 0;
   handles.data.f1 = 100;
   handles.data.f2 = 200;
   handles.data.a1 = 10.0;
   handles.data.a2 = 10.0;
   handles.data.window = 'Rectangular';
   handles.data.L = 64;
   handles.data.N = 512;
   handles.data.fs = 500;
   handles.data.num_samples = 200;

   clc;
   fprintf('DSP FFT Resolution GUI: Initialized the GUI.\n');

   % Choose default command line output for DSP_FFT_Resolution
   handles.output = hObject;

   % Update handles structure
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);

% UIWAIT makes DSP_FFT_Resolution wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DSP_FFT_Resolution_OutputFcn(hObject, eventdata, handles) 
   varargout{1} = handles.output;


function edit_window_length_Callback(hObject, eventdata, handles)
   current_L = handles.data.L;
   L = str2double(get(hObject,'String'));
   L_hi = handles.data.num_samples;
   if (L >= 1) && (L <= L_hi)
      L = double(uint32(L));
      handles.data.L = L;
      fprintf('DSP FFT Resolution GUI: Set L = %d.\n', L);
   else
      fprintf('DSP FFT Resolution GUI: Illegal value for L. Limits are 1 to %d.\n', ...
         L_hi);
      set(hObject, 'string', num2str(current_L));   
   end
   % Update handles structure
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function edit_window_length_CreateFcn(hObject, eventdata, handles)
   if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
       set(hObject,'BackgroundColor','white');
   end


function edit_fft_size_Callback(hObject, eventdata, handles)
   current_N = handles.data.N;
   N = str2double(get(hObject,'String'));
   if (N >= 1) && (N <= 1024)
      N = double(uint32(N));
      handles.data.N = N;
      fprintf('DSP FFT Resolution GUI: Set N = %d.\n', N);
   else
      fprintf('DSP FFT Resolution GUI: Illegal value for N. Limits are 1 to 1024.');
      set(hObject, 'string', num2str(current_N));   
   end
   % Update handles structure
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function edit_fft_size_CreateFcn(hObject, eventdata, handles)
   if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
       set(hObject,'BackgroundColor','white');
   end


% --- Executes on button press in radiobutton_sinusoid_1_enable.
function radiobutton_sinusoid_1_enable_Callback(hObject, eventdata, handles)
   s1 = get(hObject,'Value');
   handles.data.enable_sinusoid_1 = s1;
   if s1
      fprintf('DSP FFT Resolution GUI: Enabled sinusoid 1.\n');
   else
      fprintf('DSP FFT Resolution GUI: Disabled sinusoid 1.\n');
   end
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


function edit_freq1_Callback(hObject, eventdata, handles)
   current_f1 = handles.data.f1;
   f1 = str2double(get(hObject,'String'));
   f_lo = -handles.data.fs/2;
   f_hi = handles.data.fs/2;
   if (f1 >= f_lo) && (f1 <= f_hi)
      handles.data.f1 = f1;
      fprintf('DSP FFT Resolution GUI: Set f1 = %.2f Hz.\n', f1);
   else
      fprintf('DSP FFT Resolution GUI: Illegal value for f1. Limits are %.1f to %.1f Hz.\n', ...
         f_lo, f_hi);
      set(hObject, 'string', num2str(current_f1));
   end
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function edit_freq1_CreateFcn(hObject, eventdata, handles)
   if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
       set(hObject,'BackgroundColor','white');
   end


% --- Executes on button press in radiobutton_sinusoid_2_enable.
function radiobutton_sinusoid_2_enable_Callback(hObject, eventdata, handles)
   s2 = get(hObject,'Value');
   handles.data.enable_sinusoid_2 = s2;
   if s2
      fprintf('DSP FFT Resolution GUI: Enabled sinusoid 2.\n');
   else
      fprintf('DSP FFT Resolution GUI: Disabled sinusoid 2.\n');
   end
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


function edit_freq2_Callback(hObject, eventdata, handles)
   current_f2 = handles.data.f2;
   f2 = str2double(get(hObject,'String'));
   f_lo = -handles.data.fs/2;
   f_hi = handles.data.fs/2;
   if (f2 >= f_lo) && (f2 <= f_hi)
      handles.data.f2 = f2;
      fprintf('DSP FFT Resolution GUI: Set f2 = %.2f Hz.\n', f2);
   else
      fprintf('DSP FFT Resolution GUI: Illegal value for f2. Limits are %.1f to %.1f Hz.\n', ...
         f_lo, f_hi);
      set(hObject, 'string', num2str(current_f2));
   end
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function edit_freq2_CreateFcn(hObject, eventdata, handles)
   if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
       set(hObject,'BackgroundColor','white');
   end


% --- Executes on button press in radiobutton_Hamming.
function radiobutton_Hamming_Callback(hObject, eventdata, handles)
   if get(hObject,'Value')
      handles.data.window = 'Hamming';
      fprintf('DSP FFT Resolution GUI: Set window to Hamming.\n');
   end
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


% --- Executes on button press in radiobutton_Rectangular.
function radiobutton_Bartlett_Callback(hObject, eventdata, handles)
   if get(hObject,'Value')
      handles.data.window = 'Bartlett';
      fprintf('DSP FFT Resolution GUI: Set window to Bartlett.\n');
   end
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


% --- Executes on button press in radiobutton_Rectangular.
function radiobutton_Rectangular_Callback(hObject, eventdata, handles)
   if get(hObject,'Value')
      handles.data.window = 'Rectangular';
      fprintf('DSP FFT Resolution GUI: Set window to Rectangular.\n');
   end
   guidata(hObject, handles);
   draw_plots(hObject, eventdata, handles);


function draw_plots(hObject, eventdata, handles)
   %
   % Get data
   %
   s1_enable = handles.data.enable_sinusoid_1;
   s2_enable = handles.data.enable_sinusoid_2;
   f1 = handles.data.f1;
   f2 = handles.data.f2;
   a1 = handles.data.a1;
   a2 = handles.data.a2;
   window = handles.data.window;
   L = handles.data.L;
   N = handles.data.N;
   fs = handles.data.fs;
   num_samples = handles.data.num_samples;

   % Generate time samples
   ts = 1.0 / fs;
   t = ((0 : (num_samples - 1)) * ts)';

   % Generate frequency indices
   freqs = double((-(N/2) : ((N/2)-1))) / double(N) * fs;

   x = zeros(length(t), 1);
   
   if s1_enable
      x = x + a1 * sin(2*pi*f1*t);
   end

   if s2_enable
      x = x + a2 * cos(2*pi*f2*t);
   end

   % Set the window function
   switch(window)
      case 'Rectangular'
         w = ones(L, 1);
         cwin = 1.0;
      case 'Hamming'
         w = hamming(L);
         cwin = 2.0;
      case 'Bartlett'
         w = bartlett(L);
         cwin = 2.05;
   end
   w((L+1):length(t)) = 0;

   % Physical and computational frequency resolutions
   delta_f_phys = double(cwin * fs / L);
   delta_f_comp = double(fs / N);
   
   % FFT in dB and fftshifted for plotting
   XW = 20*log10(fftshift(abs(fft(x .* w, N)) + 1e-6));
   XW = XW - max(XW);
   
   W = 20*log10(fftshift(abs(fft(w, N)) + 1e-6)); 
   W = W - max(W);
   
   % Update text field with physical and computational resolutions
   physical_resolution_str = sprintf('Physical res.\n%.2f Hz.', delta_f_phys);
   set(handles.text_physical_resolution, 'String', physical_resolution_str);
   
   computational_resolution_str = sprintf('Computational res.\n%.2f Hz.', delta_f_comp);
   set(handles.text_computational_resolution, 'String', computational_resolution_str);
   
   % Time data plots
   xtext = -20*ts;
   ax = handles.axes_time_plot_1;
   h = plot(ax, t, x); set(h, 'LineWidth', 2.0);
   text(ax, xtext, (max(x)+min(x))/2, 'x[n]', 'FontSize', 10, 'backgroundcolor', 'none');
   axis(ax, 'off');
   drawnow;

   ax = handles.axes_time_plot_2;
   h = plot(ax, t, w, 'r'); set(h, 'LineWidth', 2.0);
   text(ax, xtext, (max(w)+min(w))/2, 'w[n]', 'FontSize', 10, 'backgroundcolor', 'none');
   axis(ax, 'off');
   drawnow;

   ax = handles.axes_time_plot_3;
   h = plot(ax, t, w .* x, 'm'); set(h, 'LineWidth', 2.0);
   text(ax, xtext, (max(w .* x)+min(w .* x))/2, 'x_{W}[n]', 'FontSize', 10, 'backgroundcolor', 'none');
   axis(ax, 'off');
   drawnow;

   % Spectral plots  
   xtext = min(freqs) * 1.2;
   
   ax = handles.axes_freq_plot_2;
   plot(ax, freqs, W, 'r');
   axval = axis(ax);
   axis(ax, [axval(1:2), -60, 0]);
   axis(ax, 'off');
   text(ax, xtext, -30, 'W[k]', 'FontSize', 10, 'backgroundcolor', 'none');
   drawnow;
   
   ax = handles.axes_freq_plot_3;
   plot(ax, freqs, XW, 'm');
   axval = axis(ax);
   axis(ax, [axval(1:2), -60, 0]);
   axis(ax, 'off');
   text(ax, xtext, -30, 'X_{W}[k]', 'FontSize', 10, 'backgroundcolor', 'none');
   drawnow;
   
   ax = handles.axes_freq_plot_1;
   if s1_enable
      h = stem(ax, [-f1, f1], a1/2 * [1, 1], '^'); 
      set(h, 'LineWidth', 1.5); 
      set(h, 'MarkerFaceColor', 'blue');
      set(h, 'MarkerEdgeColor', 'blue');
      set(h, 'MarkerSize', 4);
   end
   if s2_enable
      hold(ax,'on');
      h = stem(ax, [-f2, f2], a2/2 * [1, 1], 'o'); 
      set(h, 'LineWidth', 1.5); 
      set(h, 'MarkerFaceColor', 'red');
      set(h, 'MarkerEdgeColor', 'red');
      set(h, 'MarkerSize', 4);
      hold(ax,'off');
   end
   axis(ax, [axval(1:2), 0, max(a1,a2)*1.5]);
   axis(ax, 'off');
   text(ax, xtext, max(a1,a2)*0.75, 'X[k]', 'FontSize', 10, 'backgroundcolor', 'none');
   drawnow;
   
   guidata(hObject, handles);
   