function [xx,yy]= find_path(Temp_Edge,Voro_Vertex,Start,Goal,Num_Object,X1)
Vertex = unique(Temp_Edge);
N = length(Vertex);
M = length(Temp_Edge);

for i=1:N
    Vertex_Cord(i,:)=Voro_Vertex(Vertex(i),:);
    Start_distance(i)=norm(Start-Vertex_Cord(i,:));
    Goal_distance(i)=norm(Goal-Vertex_Cord(i,:));
end


Voro_Graph = inf*ones(N);

%figure;
axis([0 100 0 100]);
hold on;

for i = 1:M
    a= find(Vertex==Temp_Edge(i,1));
    b= find(Vertex==Temp_Edge(i,2));
    Distance = norm(Vertex_Cord(a,:)-Vertex_Cord(b,:));
    Voro_Graph(a,b)=Distance;
    Voro_Graph(b,a)=Distance;
%     Voro_Graph(a,b)=1;
%     Voro_Graph(b,a)=1;
    
    x=[Vertex_Cord(a,1) Vertex_Cord(b,1)];
    y=[Vertex_Cord(a,2) Vertex_Cord(b,2)];
    
    %plot(x,y,'color','Green','LineWidth',2);
end

for i=1:N
    Start_distance(i)=norm(Start-Vertex_Cord(i,:));
    Goal_distance(i)=norm(Goal-Vertex_Cord(i,:));
end

[Dummy Index_Start]=min(Start_distance);
[Dummy Index_Goal]=min(Goal_distance);
path = dijkstra(Voro_Graph,Index_Start,Index_Goal);

for i=1:Num_Object
    for r=1:length(X1{i})
       a=r;
       if(r==length(X1{i}))
           b=1;
       else
           b=r+1;
       end
       x=[X1{i}(a,1) X1{i}(b,1)];
       y=[X1{i}(a,2) X1{i}(b,2)];
       plot(x,y);
       hold on;
    end
end
drawnow;

plot(Start(1),Start(2),'--go','MarkerSize',10,'MarkerFaceColor','g');
plot(Goal(1),Goal(2),'--ro','MarkerSize',10,'MarkerFaceColor','r');
 
 figure(1);
 axis([0 100 0 100]);
 hold on;
 
 for i=1:length(Temp_Edge)
    Edge_X1(i)=Voro_Vertex(Temp_Edge(i,1),1);
    Edge_X2(i)=Voro_Vertex(Temp_Edge(i,2),1);
    Edge_Y1(i)=Voro_Vertex(Temp_Edge(i,1),2);
    Edge_Y2(i)=Voro_Vertex(Temp_Edge(i,2),2);
    plot([Edge_X1(i) Edge_X2(i)],[Edge_Y1(i) Edge_Y2(i)],'color','g','LineWidth',2);
end
 
 x=[Start(1) Vertex_Cord(path(1),1)];
 xi=x(1);
 y=[Start(2) Vertex_Cord(path(1),2)];
 yi=y(1);
 plot(x,y,'-','color','m','LineWidth',3);
 drawnow;
 x1=zeros(1,length(path)-1);
 y1=zeros(1,length(path)-1);
 for i=1:length(path)-1
 x=[Vertex_Cord(path(i),1) Vertex_Cord(path(i+1),1)];
 x1(i)=x(1);
 y=[Vertex_Cord(path(i),2) Vertex_Cord(path(i+1),2)];
 y1(i)=y(1);
 plot(x,y,'-','color','m','LineWidth',3);
 drawnow;
 hold on;
 end

 x=[Vertex_Cord(path(i+1),1) Goal(1)];
 y=[Vertex_Cord(path(i+1),2) Goal(2)];
 plot(x,y,'-','color','m','LineWidth',3);
 drawnow;
 xx=[xi x1 x];
 yy=[yi y1 y];
end