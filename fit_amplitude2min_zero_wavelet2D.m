function [wmin_esti_cut,wzero_esti_cut]=fit_amplitude2min_zero_wavelet2D(synthetic,samt_syn,len,iter)
% synthetic - 2D地震道
% samt_syn - 地震道采样间隔
% iter - 利用5点平滑滤波平滑地震道振幅谱的平滑次数
% len - 子波长度

slode=hanning(21);
window=ones(size(synthetic,1),1);
window(1:11)=slode(1:11);
window(end-10:end)=slode(11:21);
for k=1:size(synthetic,2)
    synthetic(:,k)=synthetic(:,k).*window;
end

N_fft=2^nextpow2(length(synthetic))*2;
% N_fft=length(synthetic);
% FSN=abs(fft(synthetic,N_fft));
% FS=sum(FSN,2)./size(synthetic,2);

FSN=abs(sum(fft(synthetic,N_fft),2));
FS=FSN./size(synthetic,2);
f=0:1/(N_fft*samt_syn):1/samt_syn-1/(N_fft*samt_syn);

Fw_esti=FS;
for k=1:iter
    Fw_esti=smooth5(Fw_esti,2);
    idx=find(Fw_esti<0);
    Fw_esti(idx)=FS(idx);
    Fw_esti(1)=FS(1);
    Fw_esti(N_fft)=FS(N_fft);
end
% 
% figure,plot(f,FS),hold on,plot(f,Fw_esti,'r'),
%   set(gca,'tickdir','out','FontSize',12,'Fontweight','bold'),
%   %title('地震道振幅谱'),legend('原始','平滑'),
%   title('振幅谱'),legend('地震道','子波'),
%   xlabel('Frequency (Hz)'),xlim([0,150])

Fw_amp_esti=abs(Fw_esti);
xxx=hilbert(log(Fw_amp_esti));
ttt=(-1)*imag(xxx);
wmin_esti=real(ifft(Fw_amp_esti.*exp(1i*ttt)));
wmin_esti_cut=wmin_esti(1:len);
wmin_esti_cut=wmin_esti_cut.';

wzero_esti=real(fftshift(ifft(Fw_amp_esti)));
M=floor(len/2);
id=find(abs(wzero_esti)==max(abs(wzero_esti)));
wzero_esti_cut=wzero_esti(id-M:id+M);
wzero_esti_cut=wzero_esti_cut.';


