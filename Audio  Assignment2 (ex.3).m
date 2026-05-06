Fs = 22050;
total_signal = [];
notas = [1.0, 1.125, 1.25, 1.33, 1.5, 1.33, 1.25, 1.125, 1.0];
duracao_nota = 0.5;

for n = notas
    F = 440.0 * n;
    A = 5000;
    t = 0:1/Fs:duracao_nota-(1/Fs);
    amostras = zeros(size(t));

    for k = 1:5
        amostras = amostras + (-(2.0 * A / (pi * k)) * sin(2.0 * pi * k * F * t));
    end

    N = length(amostras);
    L = floor(N / 10);
    if L > 0
        ramp = sin(linspace(0, pi/2, L));
        amostras(1:L) = amostras(1:L) .* ramp;
        amostras(end-L+1:end) = amostras(end-L+1:end) .* fliplr(ramp);
    end
    
    total_signal = [total_signal, amostras];
end

plot(total_signal);
title('Assignment 3: Harmonic Synthesis');
sound(total_signal, Fs);
audiowrite('assignment3_output.wav', total_signal/max(abs(total_signal)), Fs);