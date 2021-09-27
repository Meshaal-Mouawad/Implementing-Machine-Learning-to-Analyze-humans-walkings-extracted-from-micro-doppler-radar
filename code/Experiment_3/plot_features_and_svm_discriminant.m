%__________________________________________________________________________
%
% Description: 
%
%   Function plots 2D features and SVM discriminant line.
%
% Inputs:  x     -  Input feature vector sized [M x 2].
%          c     -  Class labels (-1 and 1), sized [M x 1].
%          model -  Liblinear model.
%          pstr  -  String for plot title.
%
% Outputs: Plot.
%
% References: None
%
% Change History:
%
% 22 July 2020 - Original
%
% Authors:
% John Ball
%__________________________________________________________________________
%
function plot_features_and_svm_discriminant(x, c, model, pstr)

%
% Plot data
%
figure;
hold on;
for k = 1 : size(x,1)
   if c(k) == -1
      pcolor = 'r+';
   else
      pcolor = 'bx';
   end
   plot(x(k,1), x(k,2), pcolor);
end
xlabel('f1');
ylabel('f2');
title(pstr);

%
% Add discriminant line
%
ax = axis;
f1min = ax(1);
f1max = ax(2);
f1 = linspace(f1min, f1max, 101);
f2 = -model.w(1)/model.w(2)*f1 + model.bias/-model.w(2);
plot(f1,f2,'k');
drawnow;
