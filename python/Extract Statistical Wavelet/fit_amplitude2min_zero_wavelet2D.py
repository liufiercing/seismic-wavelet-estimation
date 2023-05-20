#%% 子波提取模块
import math
import numpy as np
from smooth5 import smooth5 
from scipy.signal import hilbert
def fit_amplitude2min_zero_wavelet2D(synthetic, samt_syn, length, iter):
    # synthetic - 2D数组
    # samt_syn - 采样时间间隔
    # iter - 迭代次数
    # len - 滤波器长度
    slode_0 =np.hanning(23)
    slode=slode_0.reshape((-1,1))
    
    window = np.ones((synthetic.shape[0], 1))
    window[0:10] = slode[1:11]
    window[-10:] = slode[12:22]

    for k in range(synthetic.shape[1]):
        synthetic[:,k] = synthetic[:,k] * window[:,0]
    N_fft = 2 ** np.ceil(np.log2(len(synthetic))).astype(int) * 2
    FS = np.abs(np.sum(np.fft.fft(synthetic, N_fft,axis=0), axis=1)) / synthetic.shape[1]
    f = np.arange(0, 1 / samt_syn, 1 / (N_fft * samt_syn))
    print(f.shape)
    Fw_esti = FS
    for k in range(iter):
        Fw_esti = smooth5(Fw_esti, 2)
        idx = np.where(Fw_esti < 0)
        Fw_esti[idx] = FS[idx]
        Fw_esti[0] = FS[0]
        Fw_esti[-1] = FS[-1]

    Fw_amp_esti = np.abs(Fw_esti)
    xxx=hilbert(np.log(Fw_amp_esti))
    #xxx = np.imag(np.log(Fw_amp_esti))
    ttt = (-1) * np.imag(xxx)

    wmin_esti = np.real(np.fft.ifft(Fw_amp_esti * np.exp(1j * ttt)))
    wmin_esti_cut = wmin_esti[0:length].T
    wzero_esti = np.real(np.fft.ifftshift(np.fft.fft(Fw_amp_esti)))
    M = math.floor(length / 2)
    id = np.argmax(np.abs(wzero_esti))
    wzero_esti_cut = wzero_esti[id - M:id + M + 1].T

    return wmin_esti_cut, wzero_esti_cut