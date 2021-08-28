function zernike_indices(n,m,radial)
    % Pass in the Zernike indices n and m, which correspond to radial and
    % azimuthal degrees respectively, and logical radial that tells whether 
    % the indices are for zernike radial function, returns error if one or 
    % both the indices are invalid, or the logical radial is not specified
    % correctly.
    
    if islogical(radial) == false
        error('Please specify the logical input correctly')
    end
    
    if floor(n) ~= n || floor(m) ~= m
        fprintf('n = %d, m = %d\n',n,m);        
        error('n and m must be integers')
    end
    
    if n < 0
        fprintf('n = %d\n',n);  
        error('n must be positive')
    end
    if radial && m < 0
        fprintf('m = %d\n',m);        
        error('m must be positive in the radial function')
    end
    
    if mod(n-m,2) == 1
        fprintf('n = %d, m = %d\n',n,m); 
        error('n-m must be even');
    end   
end