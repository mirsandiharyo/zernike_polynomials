function visualize_zernike_coeff(fig_title, coeff, idx)
    % Pass in the figure title, Zernike coefficients, and the corresponding
    % indices, returns a histogram plot.
    
    ax = gca();
    bar(ax, coeff, 'FaceColor', 'b','EdgeColor','black','LineWidth',1.5);
    title(fig_title, 'FontSize', 20);
    % Create string indices (n, m)
    str_idx = arrayfun(@(x,y) sprintf('(%d, %d)',x,y), idx(:,1), idx(:,2), ....
                       'UniformOutput', false);
    set(gca,'XTickLabel', str_idx)               
    % Do not show the xtick labels if the resolution is not enough
    if numel(ax.XTick) ~= numel(str_idx)
        set(gca,'XTickLabel',[])
    end
    xlabel('(n,m)','FontSize', 12)    
    ylabel('Coefficient','FontSize', 12)    
    set(gca, 'XLimSpec', 'Tight');
    pbaspect([2 1 1]);
end
