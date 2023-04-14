import numpy as np
import matplotlib.pyplot as plt

def ricker(f_samp_interval, n_wave_samp_point, f_wave_max_amp, f_wave_main_freq, phase):
    n_start_point = int(n_wave_samp_point/2)
    n_end_point = int(n_wave_samp_point/2-1)
    sig_temp = np.zeros(round(n_wave_samp_point/2)*2)
    for i in range(-n_start_point, n_end_point+1):
        f_temp = (np.pi*f_wave_main_freq*i*f_samp_interval)**2
        sig_temp[i+n_start_point] = f_wave_max_amp*(1-2*f_temp)*np.exp(-f_temp)
    amp = np.fft.fft(sig_temp, len(sig_temp))
    amp = amp*np.exp(-1j*phase)
    amp[:len(amp)//2] = amp[:len(amp)//2]*2
    amp[len(amp)//2:] = 0
    sig_temp = np.fft.ifft(amp, len(sig_temp)).real
    sig = sig_temp[:n_wave_samp_point]
    return sig

dominant_frequency = 30     # 子波主频 Hz
sample_rate = 0.001         # 子波采样率 s
phase_rotation = 0          # 子波相位  degrees
wavelet_length = 100        # 子波长度  ms

w = ricker(sample_rate, wavelet_length, 1, dominant_frequency, phase_rotation * np.pi / 180)
t = np.arange(-(wavelet_length-1)/2*sample_rate, ((wavelet_length-1)/2+1)*sample_rate, sample_rate)
line_width = 2.5
plt.figure(figsize=(15.6, 6.2))
plt.plot(t,w, '-k', linewidth=line_width)
plt.show()
