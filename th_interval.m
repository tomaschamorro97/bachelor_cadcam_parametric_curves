function [ min_theta, max_theta ] = th_interval( u0, du, uf )
% Prof. Oscar RUiz Salguero
% 19-04-2020
% This function finds an interval [ min_theta, max_theta ] 
% of the angle theta ( -90 <= theta <= 0). This angle represents
% the (decreeasing) slope of B0(u) coefficient at u=0: 
% dBo(u)/du(u=0) = tangent( theta ).
% 
% INPUT:
%    u0, uf: real numbers representing the parameter interval
%            at which the convexity of the weight set is assessed.
%    du:     real number, representing the sampling step of 
%            the u parameter in the interval [u0, uf].
% OUTPUT:
%    [ min_theta, max_theta ]: corresponds to the theta interval
%           for which the woight sets [B0,B1,B2,B3] or [B0,B1,B2] 
%           satisfy the convexity condition for u in [u0, uf]. 
%           -90 <= min_theta <= max_theta <= 0. It is assumed that
%           the convexity condition is indeed present in at leat
%           one interval [ min_theta, max_theta ] between -90 and
%           0 degrees.

th = -90;

% Detection of the transition NON CONVEX to CONVEX
convex = false;
while (th <= 0) & not( convex)
	[ H ] = own_weights( u0, du, uf, 4, th );
    if (H >= 0) & (H <= 1.0)
            convex = true;
    else
        th = th + 1;
    end
end    

min_theta = th ;

% Detection of the transition CONVEX to  NON CONVEX
while (th <= 0) & convex
	[ H ] = own_weights( u0, du, uf, 4, th );
    if (H >= 0) & (H <= 1.0)
        th = th + 1;    
    else        
        convex = false;
    end
end

max_theta = th ;

end

