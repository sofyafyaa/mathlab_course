function [Output_Matrix, Time_Optimised_code] = New_Instruction(Matrix)
% NEW_INSTRUCTION Summary of this function goes here
% Detailed explanation goes here
    
    tic

    auxiliary_matrix = (Matrix < -35);
    Output_Matrix = Matrix - 2 .* Matrix .* auxiliary_matrix;

    Output_Matrix(5:5:end, 1:end) = Output_Matrix(5:5:end, 1:end) / 6;

    Output_Matrix(1:end, 7:7:end) = 0;

    Time_Optimised_code = toc;

end

