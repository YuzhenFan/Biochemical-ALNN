%function1
function [t,y1,yp,yn]= NNFeedforward(xp,xn,k,wp,wn,sn)
     X0=randn(2,1);t0=0;tfinal=20;
     [t,y1]=ode45(@(t,y) comput_output(t,y,k,sn,wp,wn,xp,xn),[t0,tfinal],X0);
     yp=y1(end,1);
     yn=y1(end,2);
end

%function2
function [t,y,e,wp_new,wn_new] = hybrid_parameter_update(xp,xn,wp,wn,p,d,n,k1,column_number)
     t0=0;tfinal=20;
     w0=randn(2+column_number*4,1);wp_new=[];wn_new=[];
if (d>0)&&(p>0)
     Y0=[d;p;w0];
     [t,y]=ode45(@(t,y) match_ode(t,y,wp,wn,xp,xn,n,k1,column_number),[t0,tfinal],Y0);  
     e=y(end,3)-y(end,4);
         for i=1:column_number
          wp_new=[wp_new,y(end,4+2*column_number+i)];
          wn_new=[wn_new,y(end,4+3*column_number+i)];
         end   
     else if (d<0)&&(p<0)
      Y0=[-d;-p;w0];
      [t,y]=ode45(@(t,y) match_ode2(t,y,wp,wn,xp,xn,n,k1,column_number),[t0,tfinal],Y0);
      e=y(end,3)-y(end,4);
         for i=1:column_number
          wp_new=[wp_new,y(end,4+2*column_number+i)];
          wn_new=[wn_new,y(end,4+3*column_number+i)];
         end 
     else 
          Y0=w0;
          [t,y]=ode45(@(t,y) not_match_ode(t,y,wp,wn,xp,xn,n,column_number,d,p),[t0,tfinal],Y0);
          e=y(end,1)-y(end,2);
         for i=1:column_number
          wp_new=[wp_new,y(end,2+2*column_number+i)];
          wn_new=[wn_new,y(end,2+3*column_number+i)];
         end
     end
end
end