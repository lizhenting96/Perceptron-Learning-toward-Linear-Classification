function t = sensor(D)
aa = 10*randn; %б��
bb = 10*randn; %�ؾ�  
rr =20;
n = 50;%nΪÿһ���������

ita = 10000;%itaΪѧϰ��
t = 0;%��������
start = 1;%��ǣ���start=0ʱ�˳�ѭ��
d = D;

x1(:,1) = -1 + 2*rand(n,1);
x1(:,2) = aa.*x1(:,1) + bb + rr*rand(n,1)+d;
x2(:,1) = -1 + 2*rand(n,1);
x2(:,2) = aa.*x2(:,1) + bb - rr*rand(n,1)-d;%x1 x2��n��2�ľ���Ҫ����ת��֮��������ڵ�X

X1 = [x1';ones(1,n)];%X1 X2��3��n�ľ���
X2 = [x2';ones(1,n)];
X = [X1,-X2];
w = [1;1;1];%w����ԭʼ��w��Ϊ������

while start
    mark = zeros(1,2*n);%�ж��Ƿ�ȫ������������ȷ������
    for i = 1:2*n
        w1 = w;%�����ʼwֵ
        w = w + 0.5*ita*(X(:,i)-X(:,i)*sign(w'*X(:,i)));
        if w==w1%������������ȷ���ı��б�������ֵ
            mark(i) = 1;
        else%������������󣬵�������+1
            t = t+1;
        end
    end
    if mark == ones(1,2*n)%�б����ȫΪ1˵�����е�������������ȷ
        start = 0;
    end
end

x = -1:0.01:1;
figure;
plot(x,-w(1)/w(2)*x-w(3)/w(2));
hold on;
plot(x1(:,1),x1(:,2),'bx',x2(:,1),x2(:,2),'k.');
