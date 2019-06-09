function error_rate = linear_solver(X_train, y_train, X_test, y_test, lambda, type)
    X_train = [X_train, ones(length(y_train), 1)];
    X_test = [X_test, ones(length(y_test), 1)];
    w = linear_train(X_train, y_train, lambda);
    y_predict = X_test * w;
    error_rate = error_estimate(y_predict, y_test, type);
end
