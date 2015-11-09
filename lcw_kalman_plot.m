 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %start from the very beginning,and to create greatness
 %@author: LinChuangwei 
 %@E-mail��979951191@qq.com
 %@brief���������˲���С���Գ���
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function lcw_kalman_plot
clear all
clc;
close all;
%��һ���ı��ļ���ʹ��ʱ�����ݱ�����һ��*.txt�ļ�����
[fname, fpath] = uigetfile(...
    {'*.txt', '*.*'}, ...
    'Pick a file');

z = load(fullfile(fpath, fname));%�������е�ԭʼ���ݣ�matlab�Ǵ�1��ʼ��,���ֵҲ���ǲ���ֵ
lcw_length = length(z);%�󳤶�

%�����ڴ�
xlcw_ = zeros(1, lcw_length);%x���������
xlcw = zeros(1, lcw_length);%x�ĺ������
residual = zeros(1, lcw_length);%�˲�����
p_ = ones(1, lcw_length);%���������
p = ones(1, lcw_length);%���������
k = zeros(1, lcw_length);%����������
%������ʼ��   
%״̬ģ��: x(t) = a x(t-1) + w(t-1)
%����ģ��: z(t) = h x(t) + v(t)
%�����²⣬���������ǲ²�ģ����ڿ������˲��㷨��˵��������ֵ�Ƿ�׼ȷ����ʮ����Ҫ
xlcw(1) = 40;%��Ҫ��
p(1) = 5e2;%��Ҫ��
A = 1;
H = 1;%h�Ǽ���������ʵ�ʹ�����h���ܻ�����ʱ����仯��������ٶ�Ϊ������,�������ǿ��Ը�
Q = 10e-4;%5e2;%������ֵ�ĳ�ʼ���ͺܹؼ���   ����Э����  %��Ҫ��
R = 5e2;%10e-4;%��Ҫ��

%�������˲�
%����ѭ�����̡�����nsimΪ��ѭ������
for t = 2 : lcw_length,
%Ԥ��
xlcw_(t) = A * xlcw(t-1);%x�������������һ��ʱ���ĺ������ֵ��������Ϣ����������û�����룬bΪ0
residual(t) = z(t) - H * xlcw_(t);%z(t)��ʵ�ʲ���ֵ��Ԥ��ֵ֮��Ĳ�Ϊ�˲����̵Ĳ���(����)
p_(t) = A * A * p(t-1) + Q;%�������������
%У׼
k(t) = H * p_(t)/(H * H * p_(t) + R);%k(t)Ϊ����������򿨶������ϵ��
p(t) = p_(t) * (1 - H * k(t));%������������
xlcw(t) = xlcw_(t) + k(t) * residual(t);%���ò������Ϣ���ƶ�x(t)�Ĺ��ƣ�����������ƣ����ֵҲ�������
end

%���濪ʼ��ͼ
t = 1: lcw_length;
%����״̬��״̬����
figure;
h1 = plot(t, xlcw_, 'b');
hold on
h2 = plot(t, xlcw, 'g');
h3 = plot(t, z, 'r');
xlabel('By LinChuangwei');
hold off
legend([h1(1) h2(1) h3(1)], '�������', '�������', '����ֵ');%��ʾ��ʽ
title('�������, ������ƺͲ���ֵ�ıȽ�');
ylabel('״̬');
axis(gca,[0,lcw_length,30,70]);%�涨��ͼ�ķ�Χ

%��Э����
figure;
h1 = plot(t, p_, 'b');
hold on;
h2 = plot(t, p, 'g');
hold off
legend([h1(1) h2(1)], '�������', '�������');
title('������ƺͺ�����Ƶ�Э����');
ylabel('Э����');
xlabel('By LinChuangwei');
%axis(gca,[0,lcw_length,0,500]);%�涨��ͼ�ķ�Χ

%����������
figure;
h1 = plot(t, k, 'b');
legend([h1(1)], '����������');
title('����������');
ylabel('���������� k');
xlabel('By LinChuangwei');
