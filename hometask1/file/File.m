clear all; clc; close all;

%% Analisys of text from file
% to-do
% 1) Reading the file as a text of array of chars +
% 2) Create array of cells which consist of three columns +
% "char"->"amount of meetings"->"probobilities"
% 3) Save the chars and probobalities to file *.mat and *.xls as the cell
% variables. Name the files shouold be: +
% Data_Analisys.mat
% Data_Analisys.xls
% Data_Analisys.png
% 4) Plot the distribution of probability of symbols in text. +
% Be careful to the labels on the axis.
% Recommendation use xticks(), xticklabels().
% 5) Save the plot as figure and PNG image with resolution at least 400 px.
% The name +
% of files should be: Data_Analisys.png

%% Reading the file
% TO-DO 1
% Read the file from *.txt as a char stream+

fileID = fopen("Textvar8.txt", "r");
stream = fread(fileID, [1, inf], '*char');
fclose(fileID);

%% Analysis
% TO-DO 2 
% Use ony char from file
% Use lowercase string+
% Try to use the "Cell" as a data containers;+
% Name the varible Data_Analisys+
% The cell should consist of 3 columns:+
% "Symbol" | "Amount of meeting" | "Probolitie"

% You can use only 1 cycle for this task+
% Avoid the memmory allocation in cycle+

stream = lower(stream);
stream_sz = size(stream, 2);
alphabet = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя';
Data_Analisys = cell(33,3);

for itc = 1 : size(alphabet, 2)
    statistic = strfind(stream, alphabet(itc));
    amount = size(statistic, 2);
    Data_Analisys(itc, :) = {alphabet(itc), amount, amount/stream_sz};
end

%% Plot Data
% TO-DO 3
% Illustrate the results from Analysis block
% There should be lable of axis, title, grid

probabilities = cell2mat(Data_Analisys(:, 3));
amounts = cell2mat(Data_Analisys(:, 2));
x = 1:size(alphabet, 2);

b = tiledlayout(2, 1);
nexttile;

b1 = bar(probabilities);
grid on;
xticks(x); xticklabels(Data_Analisys(:, 1));
xlabel('Char'); ylabel('Probability');
title('Distribution of probability of symbols in text');

nexttile;
b2 = bar(amounts);
grid on;
xticks(x); xticklabels(Data_Analisys(:, 1));
xlabel('Char'); ylabel('Amount of meetings');
title('Amount of meetings of symbols in text');

%% Save the file
% TO-DO 4
% Save the figure as Data_Analisys.fig

savefig('Data_Analisys.fig');

% Save the figure as image Data_Analisys.png

exportgraphics(b, 'Data_Analisys.png');

% Save the data as MAT-file Data_Analisys.mat

save('Data_Analisys.mat', "Data_Analisys");

% Save the data as Excel table Data_Analisys.xls

writecell(Data_Analisys, 'Data_Analisys', 'FileType', 'spreadsheet');
