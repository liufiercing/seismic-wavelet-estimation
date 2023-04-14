clear
Dominant_Frequency = 30;
Sample_Rate = 0.001;
Phase_Rotation = 0;
Wavelet_Length = 100;
w= Ricker(Sample_Rate,Wavelet_Length,1,Dominant_Frequency,Phase_Rotation * pi / 180);
% 
t=-(Wavelet_Length-1)/2*Sample_Rate :Sample_Rate:Wavelet_Length/2*Sample_Rate;
%
figure; set (gcf,'position',[0    203   1560   620] )
LINEWIDTH = 2.5
plot(t,w,'-k','linewidth',LINEWIDTH)
