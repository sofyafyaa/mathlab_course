function [output_matrix] = Matrix_generator(num_rows, num_columns, ...
                                            lower_bound, upper_bound)
% Generates random matrix (num_rows * num_columns)
% Elements of matrix are numbers from lower_bound to upper_bound

output_matrix = lower_bound + (upper_bound - lower_bound) * rand([num_rows, num_columns]);

end

