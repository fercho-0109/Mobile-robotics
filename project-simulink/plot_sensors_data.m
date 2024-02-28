function[h]=plot_sensors_data(X,y,h)
if nargin==2 || isempty(h)
    h=figure();
end
%parameters;
S=[24 25;
         24 73;
         67 75;
         70 30];
hold on;
plot(S(:,1),S(:,2),'o','LineWidth',2);

for i=1:length(y)
    theta=atan2(X(2)-S(i,2),X(1)-S(i,1));
    plot([S(i,1) S(i,1)+y(i)*cos(theta)],[S(i,2) S(i,2)+y(i)*sin(theta)],'--r','LineWidth',1);
end
end