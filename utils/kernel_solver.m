function error_rate = kernel_solver(X_train, y_train, X_test, y_test, sigma, lambda, type)
    K_train = gaussian_kernel(X_train, X_train, sigma);
    alpha = kernel_train(K_train, y_train, lambda);
    K_test = gaussian_kernel(X_train, X_test, sigma);
    y_predict = K_test'*alpha;
    error_rate = error_estimate(y_predict, y_test, type);
end

function alpha = kernel_train(K, y, lambda)
    size_n = length(y);
    alpha = (K + lambda * eye(size_n))\y;
end