%function1
function dydt = comput_output(t,y,k,sn,wp,wn,xp,xn)
	sump=0;sumn=0;
  for i=1:sn
	p=wp(i)*xp(i)+wn(i)*xn(i);
	n=wp(i)*xn(i)+wn(i)*xp(i);
	sump=sump+p;
	sumn=sumn+n;
  end
	dydt=[sump-y(1)-k*y(1)*y(2);sumn-y(2)-k*y(1)*y(2)];
end

%function2
function dydt = match_ode(t,y,vp,vn,xp,xn,n,k1,column_number)
	y_delta_wp=[];y_delta_wn=[];y_wp=[];y_wn=[];
	y_error=[y(3);y(4)];
	y1dot=-k1*y(1)*y(2);
	y2dot=-k1*y(1)*y(2);
	y_error_dot=-eye(2)*y_error+[1,0,0,1;0,1,1,0]*[y(1);0;y(2);0];
  for i=1:column_number
	y_delta_wp=[y_delta_wp;y(4+i)];
	y_delta_wn=[y_delta_wn;y(4+column_number+i)];
	y_wp=[y_wp;y(4+2*column_number+i)];
	y_wn=[y_wn;y(4+3*column_number+i)];
  end
	y_delta_wpdot=-eye(column_number)*y_delta_wp+n*[xp',xn']*y_error;
	y_delta_wndot=-eye(column_number)*y_delta_wn+n*[xn',xp']*y_error;
	y_wpdot=-eye(column_number)*y_wp+vp'+y_delta_wp;
	y_wndot=-eye(column_number)*y_wn+vn'+y_delta_wn;
	dydt=[y1dot;y2dot;y_error_dot;y_delta_wpdot;y_delta_wndot;y_wpdot;y_wndot];
end

%function3
function dydt = match_ode2(t,y,vp,vn,xp,xn,n,k1,column_number)
	y_delta_wp=[];y_delta_wn=[];y_wp=[];y_wn=[];
	y_error=[y(3);y(4)];
	y1dot=-k1*y(1)*y(2);
	y2dot=-k1*y(1)*y(2);
	y_error_dot=-eye(2)*y_error+[1,0,0,1;0,1,1,0]*[0;y(1);0;y(2)];
  for i=1:column_number
	y_delta_wp=[y_delta_wp;y(4+i)];
	y_delta_wn=[ y_delta_wn;y(4+column_number+i)];
	y_wp=[y_wp;y(4+2*column_number+i)];
	y_wn=[y_wn;y(4+3*column_number+i)];
  end
	y_delta_wpdot=-eye(column_number)*y_delta_wp+n*[xp',xn']*y_error;
	y_delta_wndot=-eye(column_number)*y_delta_wn+n*[xn',xp']*y_error;
	y_wpdot=-eye(column_number)*y_wp+vp'+y_delta_wp;
	y_wndot=-eye(column_number)*y_wn+vn'+y_delta_wn;
	dydt=[y1dot;y2dot;y_error_dot;y_delta_wpdot;y_delta_wndot;y_wpdot;y_wndot];
end

%function4
function dydt = not_match_ode(t,y,vp,vn,xp,xn,n,column_number,d,p)
  if (d>0)&&(p<0)
	dp=d;dn=0;yn=-p;yp=0;
	else
	dn=-d;dp=0;yn=0;yp=p;
  end
	y_delta_wp=[];y_delta_wn=[];y_wp=[];y_wn=[];
	y_error=[y(1);y(2)];
	y_error_dot=-eye(2)*y_error+[1,0,0,1;0,1,1,0]*[dp;dn;yp;yn];
  for i=1:column_number
	y_delta_wp=[y_delta_wp;y(2+i)];
	y_delta_wn=[ y_delta_wn;y(2+column_number+i)];
	y_wp=[y_wp;y(2+2*column_number+i)];
	y_wn=[y_wn;y(2+3*column_number+i)];
  end
	y_delta_wpdot=-eye(column_number)*y_delta_wp+n*[xp',xn']*y_error;
	y_delta_wndot=-eye(column_number)*y_delta_wn+n*[xn',xp']*y_error;
	y_wpdot=-eye(column_number)*y_wp+vp'+y_delta_wp;
	y_wndot=-eye(column_number)*y_wn+vn'+y_delta_wn;
	dydt=[y_error_dot;y_delta_wpdot;y_delta_wndot;y_wpdot;y_wndot];
end