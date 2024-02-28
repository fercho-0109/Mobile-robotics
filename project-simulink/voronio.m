rng default;
x = [1:0.5:10];
y = ones(1,length(x));
x1=y;
y1=x;
y2=
x2=[x,x1];
y2=[y,y1]
%plot(x2,y2,'o')
% y2=4+x*5;
% x1=[x,x];
% y1=[y,y2];
% plot(x1,y1)
h=voronoi(x2,y2)
[vx,vy] = voronoi(x2,y2);
axis equal