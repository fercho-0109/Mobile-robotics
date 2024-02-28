function [ Temp_Edge ] = Voronoi_Graph( Voro_Vertex, Voro_Cell, All_cells_Number,Cell_start,Num_Object )
k=1;
temp=0;
for i=1:length(All_cells_Number)
    L=length(Voro_Cell{i});
  for j=1:L
      a=Voro_Cell{i}(j);
      if(j==L)
          b=Voro_Cell{i}(1);
      else
          b=Voro_Cell{i}(j+1);
      end
      for l=1:Num_Object
          if(temp==1)
              temp=0;
              break;
          end
          if (l==All_cells_Number(i));
              continue;
          end
          for m=Cell_start(l):Cell_start(l+1)-2
              if((~isempty(find(Voro_Cell{m}==a)))&(~isempty(find(Voro_Cell{m}==b))))
                  Temp_Edge(k,:)=[a b];
                  k=k+1;
                  temp=1;
                  break;
              end
          end     
      end
  end    
end

Temp_Edge=unique(Temp_Edge,'rows');

%figure;
axis([0 100 0 100]);
hold on;

for i=1:length(Temp_Edge)
    Edge_X1(i)=Voro_Vertex(Temp_Edge(i,1),1);
    Edge_X2(i)=Voro_Vertex(Temp_Edge(i,2),1);
    Edge_Y1(i)=Voro_Vertex(Temp_Edge(i,1),2);
    Edge_Y2(i)=Voro_Vertex(Temp_Edge(i,2),2);
    plot([Edge_X1(i) Edge_X2(i)],[Edge_Y1(i) Edge_Y2(i)],'color','g','LineWidth',2);
end

