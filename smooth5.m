function [y]=smooth5(x,pow)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%用途：输入数据x，对该数据用相邻的5个点进行平滑
%参数说明：
%    x - 输入数据
%    y - 输出数据
%    pow=2时，五点二次平滑方法
%    pow=3时，五点三次平滑方法
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=length(x);
y=zeros(1,N);
if pow==2
    y(1)=1/35*(31*x(1)+9*x(2)-3*x(3)-5*x(4)+3*x(5));
    y(2)=1/35*(9*x(1)+13*x(2)+12*x(3)+6*x(4)-5*x(5));
    for k=3:N-2
        y(k)=1/35*(-3*x(k-2)+12*x(k-1)+17*x(k)+12*x(k+1)-3*x(k+2));
    end
    y(N-1)=1/35*(-5*x(N-4)+6*x(N-3)+12*x(N-2)+13*x(N-1)+9*x(N));
    y(N)=1/35*(3*x(N-4)-5*x(N-3)-3*x(N-2)+9*x(N-1)+31*x(N));
elseif pow==3
    y(1)=1/70*(69*x(1)+4*x(2)-6*x(3)+4*x(4)-x(5));
    y(2)=1/35*(2*x(1)+27*x(2)+12*x(3)-8*x(4)+2*x(5));
    for k=3:N-2
        y(k)=1/35*(-3*x(k-2)+12*x(k-1)+17*x(k)+12*x(k+1)-3*x(k+2));
    end
    y(N-1)=1/35*(2*x(N-4)-8*x(N-3)+12*x(N-2)+27*x(N-1)+2*x(N));
    y(N)=1/70*(-x(N-4)+4*x(N-3)-6*x(N-2)+4*x(N-1)+69*x(N));
else
    error('Error:该函数的平滑方法只有2次和3次！');
end

    