% Clear workspace. Clear command window. Close all figure
clear all; clc; close all;
%% task
% 0) Create a function +
% 1) Create the random matrix +
% 2) Analyse the code. Insert the calculation of runtime of code +
% 3) rewrite the code in more optimised form in matlab
% 4) Provide the evidence that results matrix and legacy matrix is the same
% 5) calculate the runtime of new code. Compare it with legacy code. Make
% an conclusion about code. Which one is the more optimised? Which code do
% you suggest to use in matlab? And why?
%% Config the system

% Fixed random generator
rng(999);

% TO-DO 1%
% Create function, which generate 
% create Input_Matrix matrix 55-to-650 size and
% with normal distributed numbers from -53 to 77

num_rows = 55;
num_columns = 650;

lower_bound = -53;
upper_bound = 77;

Input_Matrix = Matrix_generator(num_rows, num_columns, lower_bound, upper_bound);
  
Legacy_Matrix = Input_Matrix;
Ethalon_Matrix = Input_Matrix;

%% Run legacy code
% TO-DO 2
% Measure the runtime of current function

% Save the runtime in variable
% Time_legacy_code = TIME;

[Legacy_output_Matrix, Time_legacy_code] = Legacy_Instruction(Input_Matrix);

%% Run optimised code
% TO-DO 3
% Measure the runtime of your function
% Create function New_Instruction()
% Rewrite and optimised function Legacy_Instruction()
% Use matrix operation, logical indexing
% Try not to use the cycle

[Optimised_Output_Matrix, Time_Optimised_code] = New_Instruction(Input_Matrix);

% Save the runtime in variable
% Time_Optimised_code = TIME;
    
%% Checking the work of student
% TO-DO 4
% Compare the matrix and elapsed time for instruction
% Matrix must be equal each other, but the runtime sill be different

% Runtime comparison

% Comparison of matrix
    % Matrix size and value

%% Function discribing

function [Output_Matrix, Time_legacy_code] = Legacy_Instruction(Matrix)
    tic
   
    for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if Matrix(itter_rows,itter_column) < -35
                Matrix(itter_rows,itter_column) = abs(Matrix(itter_rows,itter_column));
            end
        end
    end 

    % If a_ij < -35 a_ij = |a_ij|

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if mod(itter_column, 5) == 0 
                Matrix(itter_rows,itter_column) = Matrix(itter_rows,itter_column)/6;
            end
        end
   end

   % In every 5n column a_5nj = a_5nj / 6

   for itter_rows = 1 : size(Matrix,1)
        for itter_column = 1 : size(Matrix,2)
            if mod(itter_rows,7) == 0
                Matrix(itter_rows, itter_column) = 0;
            end
        end
   end
    
   % In every 7n row a_i7n = 0
    
   Time_legacy_code = toc;
   
   Output_Matrix = Matrix;
    
end