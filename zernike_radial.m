function radial = zernike_radial(r,n,m)
    % Pass in the radial coordinates r, Zernike radial and azimuthal degrees 
    % n, m, returns the corresponding radial component of the Zernike polynomial
    % array. 
    % The calculation uses the recursive algorithm proposed by Chong et al. 
    % Reference: Chong et al., Pattern Recognit., 36 (2003), 731-742.

    % Check for invalid indices
    zernike_indices(n,m,true)
    
    % Calculate the radial polynomials
    if n == m
        radial = r.^n;
    elseif n-m == 2
        radial = n*zernike_radial(r,n,n)-(n-1)*zernike_radial(r,n-2,n-2);
    else
        q = m+4;
        h3 = (-4*(q-2)*(q-3))/((n+q-2)*(n-q+4));
        h2 = (h3*(n+q)*(n-q+2))/(4*(q-1))+(q-2);
        h1 = (q*(q-1)/2)-q*h2+(h3*(n+q+2)*(n-q))/(8);
        radial = h1*zernike_radial(r,n,m+4)+ ...
             (h2+h3 ./ r.^2).*zernike_radial(r,n,m+2);
    end
end