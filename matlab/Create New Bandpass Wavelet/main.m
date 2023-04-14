clear
q=100;pp=1;%ÓáÊÏ×Ó²¨¸ß½ØÆµºÍµÍ½ØÆµ
Sample_Rate = 0.001;
Wavelet_Length = 100;

t=-(Wavelet_Length-1)/2*Sample_Rate :Sample_Rate:Wavelet_Length/2*Sample_Rate;
ww=1/(q-pp)*(q*exp(-(pi*q*t).^2)-pp*exp(-(pi*pp*t).^2));

figure; set (gcf,'position',[0    203   1560   620] )
LINEWIDTH = 2.5
plot(t,ww,'-k','linewidth',LINEWIDTH)