import numpy as np
import matplotlib.pyplot as plt

def yuh_shu(q, pp, sample_rate, wavelet_length):
    t = np.arange(-(wavelet_length-1)/2, (wavelet_length+1)/2) * sample_rate
    ww = (1/(q-pp)) * (q*np.exp(-(np.pi*q*t)**2) - pp*np.exp(-(np.pi*pp*t)**2))
    return t, ww

# Example usage
pp = 6                  #俞氏子波低截频 Hz
q = 100                 #俞氏子波高截频 Hz
sample_rate = 0.001     #子波采样率 s
wavelet_length = 100    #子波长度  ms

t, ww = yuh_shu(q, pp, sample_rate, wavelet_length)

plt.plot(t, ww, '-k', linewidth=2.5)
plt.show()
