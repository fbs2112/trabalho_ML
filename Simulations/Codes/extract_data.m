clear;
close all;
clc;

addpath('../Dataset/Raw/');

files = dir('../Dataset/Raw/*.wav');

N = size(files,1);

N_SAMPLES = 500;
N_SAMPLES_TRAIN = 100;
N_SAMPLES_TEST = 400;

audio = cell(N,3);
length_audio = zeros(N,1);

nA = 1;
nB = 1;
nC = 1;
nD = 1;
nE = 1;
nF = 1;
nG = 1;
nH = 1;

for n = 1:N
    
    audio{n,1} = files(n).name;
    audio{n,2} = audioread(files(n).name);
    
    length_audio(n) = size(audio{n,2},1);
        
    switch files(n).name(1)
    
        case 'A'
            
            audio_A{nA,1} = files(n).name;
            audio_A{nA,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_A{nA,2})/N_SAMPLES);
            
            aux = buffer(audio_A{nA,2},N_SAMPLES);
            
            audio_A{nA,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_A{nA,4} = aux(N_SAMPLES_TRAIN+1:end,:);
        
            nA = nA + 1;
            
        case 'B'
            
            audio_B{nB,1} = files(n).name;
            audio_B{nB,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_B{nB,2})/N_SAMPLES);
            
            aux = buffer(audio_B{nB,2},N_SAMPLES);
            
            audio_B{nB,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_B{nB,4} = aux(N_SAMPLES_TRAIN+1:end,:);
            
            nB = nB + 1;
            
        case 'C'
            
            audio_C{nC,1} = files(n).name;
            audio_C{nC,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_C{nC,2})/N_SAMPLES);
            
            aux = buffer(audio_C{nC,2},N_SAMPLES);
            
            audio_C{nC,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_C{nC,4} = aux(N_SAMPLES_TRAIN+1:end,:);
            
            nC = nC + 1;
            
        case 'D'
            
            audio_D{nD,1} = files(n).name;
            audio_D{nD,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_D{nD,2})/N_SAMPLES);
            
            aux = buffer(audio_D{nD,2},N_SAMPLES);
            
            audio_D{nD,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_D{nD,4} = aux(N_SAMPLES_TRAIN+1:end,:);
            
            nD = nD + 1;
            
        case 'E'
            
            audio_E{nE,1} = files(n).name;
            audio_E{nE,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_E{nE,2})/N_SAMPLES);
            
            aux = buffer(audio_E{nE,2},N_SAMPLES);
            
            audio_E{nE,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_E{nE,4} = aux(N_SAMPLES_TRAIN+1:end,:);
        
            nE = nE + 1;
            
        case 'F'
            
            audio_F{nF,1} = files(n).name;
            audio_F{nF,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_F{nF,2})/N_SAMPLES);
            
            aux = buffer(audio_F{nF,2},N_SAMPLES);
            
            audio_F{nF,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_F{nF,4} = aux(N_SAMPLES_TRAIN+1:end,:);
        
            nF = nF + 1;
            
        case 'G'
            
            audio_G{nG,1} = files(n).name;
            audio_G{nG,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_G{nG,2})/N_SAMPLES);
            
            aux = buffer(audio_G{nG,2},N_SAMPLES);
            
            audio_G{nG,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_G{nG,4} = aux(N_SAMPLES_TRAIN+1:end,:);
        
            nG = nG + 1;    
            
        case 'H'
            
            audio_H{nH,1} = files(n).name;
            audio_H{nH,2} = audioread(files(n).name);
    
            N_BLK = floor(length(audio_H{nH,2})/N_SAMPLES);
            
            aux = buffer(audio_H{nH,2},N_SAMPLES);
            
            audio_H{nH,3} = aux(1:N_SAMPLES_TRAIN,:);
            audio_H{nH,4} = aux(N_SAMPLES_TRAIN+1:end,:);
        
            nH = nH + 1;    
        
    end
    
end

save('../Dataset/Processed/audio.mat','audio');
save('../Dataset/Processed/audio_A.mat','audio_A');
save('../Dataset/Processed/audio_B.mat','audio_B');
save('../Dataset/Processed/audio_C.mat','audio_C');
save('../Dataset/Processed/audio_D.mat','audio_D');
save('../Dataset/Processed/audio_E.mat','audio_E');
save('../Dataset/Processed/audio_F.mat','audio_F');
save('../Dataset/Processed/audio_G.mat','audio_G');
save('../Dataset/Processed/audio_H.mat','audio_H');