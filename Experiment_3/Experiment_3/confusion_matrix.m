%__________________________________________________________________________
%
% Description: 
%
%   Creates a confusion matrix. Rows are truth. Columns are classifier results.
%
% Inputs:  cpred     - M x 1 vector of redicted labels.
%          ctrue     - M x 1 vector of ctrue labels.
%          pclass   - The positive class. Must be a class in ctrue.
%          do_print - Set to 1 to print results, 0 otherwise.
%
% Outputs: cm       - confusion matrix
%          oa       - Overall acciracy (fraction in [0,1]).
%          tp, fp, tn, fn - If a binary (two-class) problem, these are 
%                           calcualted. Otherwise, set to [].
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
function [cm, oa, tp, fp, tn, fn] = confusion_matrix(cpred, ctrue, pclass, do_print)

%
% Force inputs to column vectors
%
cpred = cpred(:);
ctrue = ctrue(:);

%
% Check lengths
%
if length(cpred) ~= length(ctrue)
   error("Predicted and True labels must have same length");
end

%
% Determine classes
%
classes = [cpred; ctrue];
unique_classes = unique(classes)';

%
% Remap for internal cm creation
%
remap_pred = zeros(length(cpred),1);
remap_true = zeros(length(ctrue),1);
class_indx = 1;
for k = unique_classes
   indx = find(cpred == k);
   if length(indx) > 0
      remap_pred(indx) = class_indx;
   end
   indx = find(ctrue == k);
   if length(ctrue) > 0
      remap_true(indx) = class_indx;
   end
   class_indx = class_indx + 1;
end

%
% Create confusion matrix
%
cm = zeros(length(unique_classes), length(unique_classes));
for k = 1 : length(cpred)
   cm(remap_true(k), remap_pred(k)) = cm(remap_true(k), remap_pred(k)) + 1;
end

%
% Stats
%
oa = trace(cm) / sum(cm(:));

tp = [];
fp = [];
tn = [];
fn = [];

if length(unique_classes) == 2
   %
   % Pick based on the supplied positive class
   %
   if pclass == unique_classes(2)
      tp = cm(2,2);
      tn = cm(1,1);
      fp = cm(2,1);
      fn = cm(1,2);
   else
      tp = cm(1,1);
      tn = cm(2,2);
      fp = cm(1,2);
      fn = cm(2,1);
   end
end

if do_print
   
   for r = 1 : length(unique_classes)
      pstr = fprintf(" True class %-3d:  ", unique_classes(r));
      for c = 1 : length(unique_classes)
         pstr = [pstr, fprintf('%-6d  ', cm(r,c))];
      end
      fprintf("%s\n", pstr);
   end
   
   fprintf('\nOA = %-6.4f.', oa);
   
   if ~isempty(tp)
      fprintf("\nTP = %d.", tp);
      fprintf("\nTN = %d.", tn);
      fprintf("\nFP = %d.", fp);
      fprintf("\nFN = %d.", fn);
   end
   
   fprintf("\n");
end
