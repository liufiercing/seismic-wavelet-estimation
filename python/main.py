import numpy as np
import matplotlib.pyplot as plt
from reflectivity_modling import *
from fit_amplitude2min_zero_wavelet2D import *
from scipy.linalg import toeplitz

# Set default figure properties
plt.rcParams['figure.figsize'] = [8, 6]
plt.rcParams['figure.dpi'] = 100
plt.rcParams['figure.facecolor'] = 'w'
plt.rcParams['font.size'] = 18
plt.rcParams['font.family'] = 'Times New Roman'
plt.rcParams['lines.linewidth'] = 2

# Set parameters
N = 180        # Number of reflection coefficient sample points
trace = 30     # Number of model traces

# Generate reflectivity model
modle_name = '1wedge1'
ref = reflectivity_modling(N, modle_name, trace)


# Design wavelet
dt = 0.001  # 1ms
fm = 30     # Center frequency of wavelet
trun_time = 0.04
t = np.arange(-trun_time, trun_time + dt, dt)
w = (1 - 2 * (np.pi * fm * t) ** 2) * np.exp(-(np.pi * fm * t) ** 2)
plt.plot(w, '-r', linewidth=2)
plt.show()
nWaveSampPoint = len(w)
W_temp = toeplitz(w, np.zeros(trace))
WW = W_temp[(nWaveSampPoint - 1) // 2 : - (nWaveSampPoint - 1) // 2, :]  # Full freq



# Convolution, reverse, shift, multiply, and sum
seis = np.dot(WW, ref)

# Estimate wavelet
L_w = 81
wmin_esti, wzero_esti = fit_amplitude2min_zero_wavelet2D(seis, dt, L_w, 30)
wavelet = wzero_esti / max(wzero_esti)

# Plot original and estimated wavelets
plt.plot(w / max(w), '-k', linewidth=2)
plt.plot(wavelet, '-r', linewidth=2)
plt.legend(['Original wavelet', 'Estimated wavelet'])
plt.show()
