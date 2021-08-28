% Demonstration of the generation of Zernike polynomials and the feature 
% extraction using Zernike moments.
% Created by: Haryo Mirsandi
% Reference: Chong et al., Pattern Recognit., 36 (2003), 731-742.

set(0,'DefaultFigureWindowStyle','docked')
clearvars
close all
disp('Demo started');

%% Create the surface
% Define the geometry
surface.lx = 200;                   % length
surface.nx = 80;                    % number of cells in x and y-directions
surface.dx = surface.lx/surface.nx; % size of the grid

% Create the cartesian grid
x = linspace(-1, 1,surface.nx);
y = linspace(1,-1,surface.nx);
[x,y] = meshgrid(x,y);
surface.x = x;
surface.y = y;
% Transform the coordinates to polar
[t,r] = cart2pol(x,y);
        
% Mask outside the circle
surface.mask = (sqrt(x.^2 + y.^2) <= 1);

% surface inner grid
surface.grid = [-surface.lx/2+surface.dx/2 surface.lx/2-surface.dx/2];

%% Example 1: Display one Zernike polynomial (n,m)

% Set the indices
n = 2;      % radial degree
m = 0;      % azimuthal degree

% Fits the Zernike polynomial to the surface
surface.val = zernike(r,t,n,m);

% Masking
surface.val(surface.mask == 0) = NaN;

% Visualize the surface
figure(1), clf
fig_title = sprintf('Z (%d, %d)',n,m);
visualize_surface(fig_title, surface);

%% Example 2: Display all Zernike polynomials up to the specified radial order

% Set the highest radial order
nmax = 6;   

figure(2), clf
sgtitle('Zernike Polynomials', 'FontSize', 24);
count = 0;      % counter for plotting
for n = 0:nmax
    for m = -n:2:n
        % Set the subplot number
        count = count+1;
        subplot(nmax+1, nmax+1, count)  
        
        % Fits the Zernike polynomial to the surface
        surface.val = zernike(r,t,n,m);

        % Masking
        surface.val(surface.mask == 0) = NaN;
        
        % Visualize the surface
        fig_title = sprintf('(%d, %d)',n,m);
        visualize_surface(fig_title, surface);
    end
    count = count+(nmax-n);
end

%% Example 3: Decompose a known combination of Zernike Polynomials

% Set the highest radial order
nmax = 3;   

% Create the field that contains the combination of Zernike polynomials
surface.val = zeros(surface.nx,surface.nx);
for n = 0:nmax
    for m = -n:2:n
        % Fits the Zernike polynomial
        temp_val = zernike(r,t,n,m);
        % Add the values to the surface
        surface.val = surface.val + temp_val;
    end
end

% Visualize the surface
figure(3), clf
subplot(211)
fig_title = 'Combination of Zernike Polynomials';
visualize_surface(fig_title, surface);

% Extract the features using Zernike moments
[coeff, idx] = zernike_moments(surface.val,nmax);

% Show the coefficients using bar plot
subplot(212)
fig_title = ('Zernike feature extraction');
visualize_zernike_coeff(fig_title, coeff, idx);

%% Example 4: Feature extraction of a function using Zernike Moments

% Set the highest radial order
nmax = 25;

% Set the field value
surface.val = (sin(x*pi*2)).^4+(sin(y*pi*2)).^4;

% Visualize the surface
figure(4), clf
subplot(221)
fig_title = sprintf('Ground truth');
visualize_surface(fig_title, surface)

% Extract the features using Zernike moments
[coeff, idx] = zernike_moments(surface.val,nmax);

% Show the coefficients using bar plot
subplot(212)
fig_title = ('Zernike feature extraction');
visualize_zernike_coeff(fig_title, coeff, idx)

% Reconstruct the surface using the calculated coefficients
surface.val = zeros(surface.nx,surface.nx);
idx_count = 0;
for n = 0:nmax
    for m = -n:2:n
        % Fits the Zernike polynomial
        temp_val = zernike(r,t,n,m);
        % Add the values to the surface
        idx_count = idx_count+1;
        surface.val = surface.val + temp_val * coeff(idx_count);
        % Visualize the reconstructed surface
        subplot(222)
        fig_title = sprintf('Z (%d, %d)', n,m);
        visualize_surface(fig_title, surface);
        pause(0.01)        
    end
end

% Visualize the reconstructed surface
subplot(222)
fig_title = sprintf('Reconstructed surface');
visualize_surface(fig_title, surface);
%%
disp('Demo finished');