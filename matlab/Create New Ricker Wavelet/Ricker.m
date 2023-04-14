function sig=Ricker(fSampInterval,nWaveSampPoint,fWaveMaxAmp,fWaveMainFreq,Phase)
nStartPoint=fix(nWaveSampPoint/2);   %向零取整数
nEndPoint=round(nWaveSampPoint/2-1); %四舍五入
sigTemp=zeros(round(nWaveSampPoint/2)*2,1);
for i=-nStartPoint:nEndPoint
    fTemp=(pi*fWaveMainFreq*i*fSampInterval)^2;  %π*主频*采样间隔，然后再平方
    sigTemp(i+nStartPoint+1)=fWaveMaxAmp*(1-2*fTemp)*exp(-fTemp);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
amp=fft(sigTemp,length(sigTemp));
amp=amp*exp(-1j*Phase);
amp(1:length(amp)/2)=amp(1:length(amp)/2)*2;
amp(length(amp)/2:end)=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigTemp=ifft(amp,length(sigTemp));
sig=real(sigTemp(1:nWaveSampPoint,1));