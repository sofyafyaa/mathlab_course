function [Output_Matrix, Time_Optimised_code] = New_Instruction(Matrix)
    
    tic

    auxiliary_matrix = (Matrix < -35);
    Output_Matrix = Matrix - 2 .* Matrix .* auxiliary_matrix;

    Output_Matrix(1:end, 5:5:end) = Output_Matrix(1:end, 5:5:end) / 6;

    Output_Matrix(7:7:end, 1:end) = 0;

    Time_Optimised_code = toc;

end

