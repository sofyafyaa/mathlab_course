function Pseudorand_Seq = Scrambler(Register, seq_length)

    Pseudorand_Seq = zeros(1, seq_length);

    for itter = 1 : seq_length
        new_register = xor(Register(end), Register(end - 1));
        
        %generation of PN-sequence
        Pseudorand_Seq(itter) = new_register;
    
        % linear feedback
        Register = circshift(Register, 1);
        Register(1) = new_register;
    end
end