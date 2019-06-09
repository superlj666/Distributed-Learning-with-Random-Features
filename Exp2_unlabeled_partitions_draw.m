data_name = 'SUSY';
start_with_1 = 1;
x_slim = 62;
marker = 0;

load(['./results/Exp2/error_partitions_', data_name]);
mean_error_matrix = mean(error_matrix, 1);
mean_error_matrix = reshape(mean_error_matrix, [size(mean_error_matrix,2), size(mean_error_matrix, 3)]);

imagesc(mean_error_matrix);
hcb = colorbar;
colormap jet;
xticks(1:length(n_partitions));
xticklabels(n_partitions);
xlabel('The number of partitions');
yticks(1:length(n_unlabeled));
yticklabels(n_unlabeled); 
ylabel('The number of unlabeled points');
set(gca, 'YDir', 'normal')
set(get(hcb,'Title'),'String','Error')
%caxis([0 1]);
title('Average Erorr in terms of Partitions and Unlabeled Points', 'Interpreter', 'none', 'fontsize', 10);