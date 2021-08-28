function visualize_surface(fig_title, surface)
    % Pass in the figure title and the surface structure, 
    % displays the surface.
    
    surface.val(surface.mask == 0) = NaN;
    imagesc(surface.grid, surface.grid, surface.val);
    grid on;
    colormap(whitejet);  
    axis image
    set(gca,'xtick',-surface.lx/2:surface.lx/4:surface.lx/2, ...
            'ytick',-surface.lx/2:surface.lx/4:surface.lx/2);
    title(fig_title, 'FontSize', 20);     
end