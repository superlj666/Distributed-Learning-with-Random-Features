function kernel=gaussian_kernel(X_row, X_col, tau)
    norms_row = sum(X_row'.^2);    
    norms_col = sum(X_col'.^2);
    
    kernel = exp((-norms_row'*ones(1,size(X_col,1)) - ones(size(X_row,1),1)*norms_col + 2*(X_row*X_col'))/(2*2^tau));
end