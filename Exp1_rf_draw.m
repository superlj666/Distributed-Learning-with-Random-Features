data_name = 'HIGGS';
start_with_1 = 1;
x_slim = 62;
marker = 0;

load(['./results/Exp1/error_rfs_', data_name]);
if start_with_1
    x_ticks_given = [1, 11,21,31,41, 51, 61];
    x_ticklabels_given = [1, 500,1000,1500,2000, 2500, 3000];
else
    error_matrix = error_matrix(:, 2:end);
    time_matrix = time_matrix(:, 2:end);    
    x_ticks_given = [0, 10,20,30,40, 50, 60];
    x_ticklabels_given = [0, 500,1000,1500,2000, 2500, 3000];
end

x_ticks = size(error_matrix, 2);

color1 = [55,126,184]/255;
color2 = [1,0.6,0.78];
color3 =  [255,0,255]/255;

% color = [55,126,184]/255;
% gray = [211,211,211]/255;
orange = [ 0.91,0.41,0.17];
% blue = [0,0.4470,0.7410];
light_blue = [0.5843,0.6157,0.9882];
light_red =  [255,204,204]/255;
figure('DefaultAxesFontSize',16);
ax = gca;

yyaxis left;
xbound = [1,1,1:x_ticks,x_ticks,x_ticks,fliplr(1:x_ticks)];
ybound = [max(error_matrix(:,1)),min(error_matrix(:,1)),min(error_matrix),min(error_matrix(:,end)),max(error_matrix(:,end)),fliplr(max(error_matrix))];
hold on;
s = fill(xbound,ybound,light_red,'EdgeColor',color1,'linewidth',0.5);
alpha(s,0.30);
hold on;
%plot(error_matrix','-','color',light_red,'linewidth',0.5);
hold on;
if marker
    h1 = plot(mean(error_matrix),'-','marker', '.', 'markersize', 12, 'color','r','linewidth',2,'DisplayName','error_matrix', 'DisplayName','Error Rate');
else
    h1 = plot(mean(error_matrix),'-', 'color','r','linewidth',2,'DisplayName','error_matrix', 'DisplayName','Error Rate');
end

box on;
grid on;
ax.XTick = x_ticks_given;
ax.XTickLabel = x_ticklabels_given;
xlim([0,x_slim]);
xlabel('The number of random features');
ylabel('classification error', 'color', 'r');
set(gca,'ycolor','r');


yyaxis right;
xbound = [1,1,1:x_ticks,x_ticks,x_ticks,fliplr(1:x_ticks)];
log_time_matrix = log(time_matrix);
ybound = [max(log_time_matrix(:,1)),min(log_time_matrix(:,1)),min(log_time_matrix),min(log_time_matrix(:,end)),max(log_time_matrix(:,end)),fliplr(max(log_time_matrix))];
hold on;
s = fill(xbound,ybound,light_blue,'EdgeColor',color1,'linewidth',0.5);
alpha(s,0.20);
hold on;
%plot(log_time_matrix','-','color',light_blue,'linewidth',0.5);
hold on;
if marker
    h2 = plot(mean(log_time_matrix),'-','marker', '.', 'markersize', 12,'color','b','linewidth',2,'DisplayName','log_time_matrix', 'DisplayName','Training Time');
else
    h2 = plot(mean(log_time_matrix),'-','color','b','linewidth',2,'DisplayName','log_time_matrix', 'DisplayName','Training Time');
end
ylabel('log traning time (second)', 'color', 'b');
set(gca,'ycolor','b');
 
%legend([h1,h2],{'Average of classsification error';'Average of log training time'},'location','north');
title(data_name);
saveas(gcf, ['./results/Exp1/rf_', data_name], 'epsc');
