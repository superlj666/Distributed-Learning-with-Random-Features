function error_rate = error_estimate(y_predict, y_test, type)
    if strcmp(type, 'binary')
        y_predict = y_predict > 0.5;
        error_rate = sum(y_predict ~= y_test)/length(y_test);
    elseif strcmp(type, 'regression')
        error_rate = sqrt(sum((y_predict - y_test).^2)/length(y_test));
    end
end