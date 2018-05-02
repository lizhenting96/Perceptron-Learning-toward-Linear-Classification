function t = sensor(D)
aa = 10*randn; %斜率
bb = 10*randn; %截距  
rr =20;
n = 50;%n为每一侧的数据数

ita = 10000;%ita为学习率
t = 0;%迭代次数
start = 1;%标记，当start=0时退出循环
d = D;

x1(:,1) = -1 + 2*rand(n,1);
x1(:,2) = aa.*x1(:,1) + bb + rr*rand(n,1)+d;
x2(:,1) = -1 + 2*rand(n,1);
x2(:,2) = aa.*x2(:,1) + bb - rr*rand(n,1)-d;%x1 x2是n×2的矩阵，要经过转置之后才是正宗的X

X1 = [x1';ones(1,n)];%X1 X2是3×n的矩阵
X2 = [x2';ones(1,n)];
X = [X1,-X2];
w = [1;1;1];%w是最原始的w，为列向量

while start
    mark = zeros(1,2*n);%判断是否全部样本分类正确的向量
    for i = 1:2*n
        w1 = w;%保存初始w值
        w = w + 0.5*ita*(X(:,i)-X(:,i)*sign(w'*X(:,i)));
        if w==w1%该样本分类正确，改变判别矩阵里的值
            mark(i) = 1;
        else%该样本分类错误，迭代次数+1
            t = t+1;
        end
    end
    if mark == ones(1,2*n)%判别矩阵全为1说明所有的样本均分类正确
        start = 0;
    end
end

x = -1:0.01:1;
figure;
plot(x,-w(1)/w(2)*x-w(3)/w(2));
hold on;
plot(x1(:,1),x1(:,2),'bx',x2(:,1),x2(:,2),'k.');
