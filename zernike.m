function zern = zernike(r,t,n,m)
    % Pass in the radial coordinates r, angular coordinates t, Zernike radial
    % and azimuthal degrees n, m, returns the corresponding Zernike polynomial
    % matrix.

    % Check for invalid indices
    zernike_indices(n,m,false);
    
    % Generate the full Zernike polynomial
    if m < 0
        zern = -zernike_radial(r,n,-m).*sin(m*t);
    else
        zern =  zernike_radial(r,n, m).*cos(m*t);
    end
end