function w = linear_train(X, y, lambda)
    w = (X'*X + lambda*eye(size(X, 2)))\(X'*y);
end