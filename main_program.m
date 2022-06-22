%main program
clear all;
clc;
n = 0.2; k=500; k1=500;
load('C:\Users\Administrator\crn\data.mat')
one([1:30],1)=1; X=[rand_x,one];
row_number=size(X,1);column_number=size(X,2);
zerx=zeros(row_number,column_number);
Xp=max(X,zerx); Xn=abs(min(X,zerx));
zer=zeros(1,column_number);
w=randn(1,column_number);
wp=max(w,zer); wn=abs(min(w,zer));
W=[];E=[];
for i=1:10
    for j=1:row_number
         xp=Xp(j,:);
         xn=Xn(j,:);
         d=D(j);
     [t1,y1,yp,yn]=NNFeedforward(xp,xn,k,wp,wn,column_number);
         p=yp-yn;
     [t2,y2,e,wp,wn]=hybrid_parameter_update(xp,xn,wp,wn,p,d,n,k1,column_number);
         w=wp-wn;
         W=[W;w]; el(j)=e;
      end
         E=[E;el']; 
     if abs(e)<0.1
         break
  end
end