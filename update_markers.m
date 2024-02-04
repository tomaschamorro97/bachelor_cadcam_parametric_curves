function [new_low,new_high]=update_markers( low, high, curve_type, stage_size )
% Prof. Oscar Ruiz Salguero. 31-10-2015
% INPUT:
% low, high: current lower indices of the local control polygon 
%            within an array
% curve_type: (SPLINE | BEZIER | OW N| CATMULL)
% stage_size: Number of control points per stage.
%            if SPLINE-> stage_size = 2, 3, or 4
%            if BEZIER-> stage_size >= 2
%            if CATMULL-> stage_size = 4
%            if OWN -> stage_size = 3, 4
% OUTPUT:
% new_low, new_high: lower and upper index, respectively, 
%         of the control polygon for the next iteration, 
%         according to the specified curve type 
%         and stage size.

global CATMULL
global SPLINE
global BEZIER
global OWN

switch ( curve_type ) 
    case {OWN}  
        if ((stage_size ==3)|(stage_size == 4))
            low = low + (stage_size - 1);
            high = high + (stage_size - 1);     
        else
            disp('error update_markers(): wrong stage size for OWN curve');
            keyboard
        end    
    case {BEZIER} 
        if (stage_size >=2 )
            low = low + (stage_size - 1);
            high = high + (stage_size - 1); 
        else
            disp('error update_markers(): wrong stage size for BEZIER curve');
            keyboard            
        end            
    case {SPLINE} 
        if (stage_size==2)|(stage_size==3)|(stage_size==4)
            low = low + 1;
            high = high + 1; 
        else
            disp('error update_markers(): wrong stage size for SPLINE curve');
            keyboard            
        end    
    case {CATMULL}    
        if (stage_size==4)
            low = low + 1;
            high = high + 1; 
        else
            disp('error update_markers(): wrong stage size for CATMULL curve');
            keyboard            
        end              
    otherwise
        disp('error update_markers(): wrong curve type');
        keyboard
end
new_low = low;
new_high = high;
end

