clear;
close all;
clc;

addpath('./Functions/');

load('../Dataset/Processed/audio_A.mat');
load('../Dataset/Processed/audio_B.mat');
load('../Dataset/Processed/audio_C.mat');
load('../Dataset/Processed/audio_D.mat');
load('../Dataset/Processed/audio_E.mat');
load('../Dataset/Processed/audio_F.mat');
load('../Dataset/Processed/audio_G.mat');
load('../Dataset/Processed/audio_H.mat');

% Initialization

N_SAMPLES_TRAIN = 100;
N_SAMPLES_TEST  = 400;

L = 1;
N = 20;

mu = 0.9;
gamma = 1e-6;

S = struct('step',mu,'filterOrderNo',N,'initialCoefficients',0,'gamma',gamma);

% Training samples

x_A = audio_A{1,3}';
x_B = audio_B{1,3}';
x_C = audio_C{1,3}';
x_D = audio_D{1,3}';
x_E = audio_E{1,3}';
x_F = audio_F{1,3}';
x_G = audio_G{1,3}';
x_H = audio_H{1,3}';

% Test samples

x_A_test = audio_A{1,4}';
x_B_test = audio_B{1,4}';
x_C_test = audio_C{1,4}';
x_D_test = audio_D{1,4}';
x_E_test = audio_E{1,4}';
x_F_test = audio_F{1,4}';
x_G_test = audio_G{1,4}';
x_H_test = audio_H{1,4}';

cellA = {'A','B','C','D','E','F','G','H'};

for j = 1:length(cellA)
    
    x = eval(sprintf('x_%s',cellA{j}));
    
    for i = 1:size(x,2)
        
        d = x(i,L+1:end);
        
        % Adaptive Algorithm
        
        [y(:,i),e(:,i),w(:,:,i)] = NLMS(d,x(i,:),S);
        
    end
    y2(:,:,j) = y;
    e2(:,:,j) = e;
    w_o(:,:,j) = mean(w,3);
    
    
    
    
    
    
    
    delay = round((length(w_o(:,end))-1)/2);
    %delay = 0;
    
    y_A_test = filter(w_o(:,end,j),1,x_A_test,[],1);
    y_B_test = filter(w_o(:,end,j),1,x_B_test,[],1);
    y_C_test = filter(w_o(:,end,j),1,x_C_test,[],1);
    y_D_test = filter(w_o(:,end,j),1,x_D_test,[],1);
    y_E_test = filter(w_o(:,end,j),1,x_E_test,[],1);
    y_F_test = filter(w_o(:,end,j),1,x_F_test,[],1);
    y_G_test = filter(w_o(:,end,j),1,x_G_test,[],1);
    y_H_test = filter(w_o(:,end,j),1,x_H_test,[],1);
    
    % Plot figures
    
    linewidth = 2;
    fontname = 'Times New Roman';
    fontsize = 20;
    
    figure;
    
    set(gcf,'position',[0 0 800 600]);
    
    plot(1:N_SAMPLES_TRAIN-1,10*log10(mean(abs(e).^2,2)),'-b','linewidth',linewidth);
    
    ylabel('MSE (in dB)','fontname',fontname,'fontsize',fontsize);
    xlabel('Iterations (in sample)','fontname',fontname,'fontsize',fontsize);
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    figure;
    
    set(gcf,'position',[0 0 800 600]);
    
    plot(1:N_SAMPLES_TRAIN,x(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TRAIN-1,y(:,1),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('Iterations (in sample)','fontname',fontname,'fontsize',fontsize);
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    figure;
    
    set(gcf,'position',[0 0 800 600]);
    
    subplot(2,4,1);
    
    plot(1:N_SAMPLES_TEST,x_A_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_A_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    subplot(2,4,2);
    
    plot(1:N_SAMPLES_TEST,x_B_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_B_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    subplot(2,4,3);
    
    plot(1:N_SAMPLES_TEST,x_C_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_C_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    subplot(2,4,4);
    
    plot(1:N_SAMPLES_TEST,x_D_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_D_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    subplot(2,4,5);
    
    plot(1:N_SAMPLES_TEST,x_E_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_E_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    subplot(2,4,6);
    
    plot(1:N_SAMPLES_TEST,x_F_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_F_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    subplot(2,4,7);
    
    plot(1:N_SAMPLES_TEST,x_G_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_G_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    subplot(2,4,8);
    
    plot(1:N_SAMPLES_TEST,x_H_test(1,:),'-b','linewidth',linewidth);
    hold on;
    plot(1:N_SAMPLES_TEST-delay,y_H_test(1,delay+1:end),'--r','linewidth',linewidth);
    
    ylabel('Signal','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    legend({'$x(k)$', '$y(k)$'},'fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    figure;
    
    subplot(2,4,1)
    
    plot(20*log10(abs((x_A_test(1,end - delay) - y_A_test(1,delay+1:end))./(x_A_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    subplot(2,4,2)
    
    plot(20*log10(abs((x_B_test(1,end - delay) - y_B_test(1,delay+1:end))./(x_B_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    subplot(2,4,3)
    
    plot(20*log10(abs((x_C_test(1,end - delay) - y_C_test(1,delay+1:end))./(x_C_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    subplot(2,4,4)
    
    plot(20*log10(abs((x_D_test(1,end - delay) - y_D_test(1,delay+1:end))./(x_D_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    subplot(2,4,5)
    
    plot(20*log10(abs((x_E_test(1,end - delay) - y_E_test(1,delay+1:end))./(x_E_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    subplot(2,4,6)
    
    plot(20*log10(abs((x_F_test(1,end - delay) - y_F_test(1,delay+1:end))./(x_F_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    subplot(2,4,7)
    
    plot(20*log10(abs((x_G_test(1,end - delay) - y_G_test(1,delay+1:end))./(x_G_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
    subplot(2,4,8)
    
    plot(20*log10(abs((x_H_test(1,end - delay) - y_H_test(1,delay+1:end))./(x_H_test(1,end - delay)))))
    ylabel('Prediction error','fontname',fontname,'fontsize',fontsize);
    xlabel('$k$','fontname',fontname,'fontsize',fontsize,'interpreter','latex');
    set(gca,'fontname',fontname,'fontsize',fontsize);
    
    
end