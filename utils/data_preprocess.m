function data_preprocess(data_name, selected_number)
    dataset_path = '/home/lijian/datasets/';
    [y, X] = libsvmread([dataset_path, data_name]);
    rand_idx = randperm(length(y), selected_number);
    y = y(rand_idx);
    y = label_scale(y, 'binary');
    X = X(rand_idx, :);
    save(['./data/', data_name], 'X', 'y');
end

function y = label_scale(y, type)
    if strcmp(type, 'binary')
        y(y==min(y)) = 0;
        y(y==max(y)) = 1;        
    elseif strcmp(type, 'regression')
        y = (y - min(y))/(max(y) - min(y));
    end
end