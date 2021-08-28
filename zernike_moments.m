function [zernike_mnts, idx] = zernike_moments(img_mat, nmax)
    % Pass in the matrix and the highest Zernike radial degree, returns the 
    % Zernike moments and the corresponding indices that allows for the 
    % reconstruction of the input matrix using Zernike polynomials.
 
    % Create the cartesian grid
    [nrows, ncols] = size(img_mat);
    x = linspace(-1, 1,ncols);
    y = linspace( 1,-1,nrows);
    [x,y] = meshgrid(x,y);
    
    % Transform the coordinates to polar
    [t,r] = cart2pol(x,y);

    % Create the mask
    mask = (sqrt(x.^2 + y.^2) <= 1);
    
    % Create a matrix that contains the Zernike polynomials up to
    % the highest radial degree
    tot_idx = 0.5*(nmax+1)*(nmax+2);
    idx = zeros(tot_idx,2);
    zernike_mat = zeros(ncols*nrows,tot_idx);
    
    % Calculate the Zernike polynomials
    count = 0;
    for n = 0:nmax
        for m = -n:2:n
            % Store the indices
            count = count+1;
            idx(count,:) = [n,m];
            % Fit the Zernike polynomial
            temp_val = zernike(r,t,n,m);
            temp_val(mask == 0) = NaN;
            % Map the 2d array onto 1d and store the value
            zernike_mat(:,count) = reshape(temp_val,ncols*nrows,1);
        end
    end    
    
    % Remove nan values
    img_mat(isnan(img_mat)) = 0;   
    zernike_mat(isnan(zernike_mat)) = 0;

    % Calculate the Zernike moments
    img_reshaped = reshape(img_mat,ncols*nrows,1);
    zernike_mnts = (zernike_mat.'*zernike_mat)^-1* ...
                   (zernike_mat.'*img_reshaped);
end