clc;clear;close all;
%% Ԥ�����
set(0,'defaultfigurecolor','w');FONTSIZE=18;   FONTNAME='Times New Roman'; LINEWIDTH=2;
N=180;       %% ����ϵ��������
trace =30;    %%ģ�͵���
%% ��Ʒ���ϵ��ģ��
modle_name = '1wedge1';
[ref]= reflectivity_modling(N, modle_name, trace);
%% wavelet
dt=0.001; % 1ms
fm=30;   trun_time=0.04;  t=-trun_time:dt:trun_time;
w=(1-2*(pi*fm*t).^2).*exp(-(pi*fm*t).^2);
nWaveSampPoint=length(w);
W_temp=convmtx(w',length(ref(:,1)));  %% ʱ��
WW=W_temp(((nWaveSampPoint-1)/2)+1:end-((nWaveSampPoint-1)/2),:);     % full_freq
%% �޻�  ��ת ʱ�� ������
seis=WW*ref;
%%
% seis=pnoise(seis,0.1);   %%����
%%
L_w=81;
[wmin_esti,wzero_esti]=fit_amplitude2min_zero_wavelet2D(seis,dt,L_w,30);
wavelet = wzero_esti/max(wzero_esti);
%%
figure
plot(w/max(w),'-k','LineWidth',2)
hold on 
plot(wavelet,'-r','LineWidth',2)
legend('ԭʼ�Ӳ�','�����Ӳ�')

