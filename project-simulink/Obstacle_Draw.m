clear all;
close all;
clc; 
FILE_NAME = 'Obstacle_config006'; %Specify filename to save the map
Epsilon = 2.5; % distance between poins by dividing the objects
Num_Object=10; %Specify Total number of obstacle here

%____________________Main code__________________
handle = figure;
axis([0 100 0 100]);
hold on;

X_Total_points=0;
Y_Total_points=0;
All_cells_Number=0;
Cell_start=1;
%%%____obstacles__________

ob0=[1,1;99.01 1.01;99 99; 1.01 99.01];
ob1=[1.1,76;30 76.01;30.01 80; 1 80.01];
ob2=[26,1;30 1.01;30.01 23; 26.01 23.01];
ob3=[50 86;53 86.01 ; 53.01 99; 50.01 99.01];
ob4=[70 53+5; 73 53.01+5 ; 73.01 76 ;70.01 76.01];
ob5=[53 50; 99 50.01; 99.01 53; 53.01 53.01];
ob6=[73 16; 83 16.01; 83.01 36; 73.01 36.01];
ob7=[43 63; 56 63.01; 50 76];
ob8=[16 43; 30 43.01; 30.01 56; 16.01 56.01];
ob9=[50 16; 63 16.01; 63.01 23; 50.01 23.01];

%%obstacles enlaged
ob00=[1+1.5,1+1.5;99.01-1.5 1.01+1.5;99-1.5 99-1.5; 1.01+1.5 99.01-1.5];
ob11=[1.1+1.5,76-1.5;30+1.5 76.01-1.5;30.01+1.5 80+1.5; 1+1.5 80.01+1.5];
ob22=[26-1.5 1+1.5 ;30+1.5 1.01+1.5;30.01+1.5 23+1.5; 26.01-1.5 23.01+1.5];
ob33=[50-1.5 86-1.5; 53+1.5 86.01-1.5 ; 53.01+1.5 99-1.5; 50.01-1.5 99.01-1.5];
ob44=[70-1.5 60-1.5; 73+1.5 60.01-1.5 ; 73.01+1.5 76+1.5 ;70.01-1.5 76.01+1.5];
ob55=[53-1.5 50-1.5; 99-1.5 50.01-1.5; 99.01-1.5 53+1.5; 53.01-1.5 53.01+1.5];
ob66=[73-1.5 16-1.5; 83+1.5 16.01-1.5; 83.01+1.5 36+1.5; 73.01-1.5 36.01+1.5];
ob77=[43-2 63-2; 56+2 63.01-2; 50 76+2];
ob88=[16-1.5 43-1.5; 30+1.5 43.01-1.5; 30.01+1.5 56+1.5; 16.01-1.5 56.01+1.5];
ob99=[50-1.5 16-1.5; 63+1.5 16.01-1.5; 63.01+1.5 23+1.5; 50.01-1.5 23.01+1.5];
%________________

obstacles={ob0,ob1,ob2,ob3,ob4,ob5,ob6,ob7,ob8,ob9};
obstacles1={ob00,ob11,ob22,ob33,ob44,ob55,ob66,ob77,ob88,ob99};
%_______________________________
for i=1:Num_Object
   X1{i} = obstacles1{i};
   X2{i} = circshift(X1{i},1);    %shifting to calculate rms edge length
l = sqrt(sum(((X2{i}-X1{i}).*(X2{i}-X1{i}))'));   %rms edge length
Num_points = floor(l/Epsilon);

size_input =  length(X1{i});
X_points{i}=0;
Y_points{i}=0;

for j=1:size_input
        %points on one edge of obstacle 
        X_edge{i}{j}=X1{i}(j,1):(X2{i}(j,1)-X1{i}(j,1))/Num_points(j):X2{i}(j,1)
        
        Y_edge{i}{j}=X1{i}(j,2):(X2{i}(j,2)-X1{i}(j,2))/Num_points(j):X2{i}(j,2)
        
        plot(X_edge{i}{j},Y_edge{i}{j},'k',LineWidth=2);
        X_edge{i}{j}(1)=[]; %removing first element to avoid repetetion
        Y_edge{i}{j}(1)=[]; %removing first element to avoid repetetion
        
        %Total points on an obstacle
        X_points{i}=cat(2,X_points{i},X_edge{i}{j});
        Y_points{i}=cat(2,Y_points{i},Y_edge{i}{j});
        
        
end

   for r=1:size_input
       a=r;
       if(r==size_input)
           b=1;
       else
           b=r+1;
       end
           
       plot(X1{i}(a:b,1),X1{i}(a:b,2),'k',LineWidth=2);
       hold on;
       drawnow;
   end

X_points{i}(1)=[];
Y_points{i}(1)=[];
Cell_Number{i} = i*ones(size(X_points{i}));

%Total points 
X_Total_points=cat(2,X_Total_points,X_points{i});
Y_Total_points=cat(2,Y_Total_points,Y_points{i});
All_cells_Number = cat(2,All_cells_Number,Cell_Number{i});
Cell_start(i+1) = length(All_cells_Number)+1;
%drawnow;
end

X_Total_points(1)=[];
Y_Total_points(1)=[];
All_cells_Number(1)=[];
%saves the figure 
saveas(handle,strcat('./Obstacle_Files/',FILE_NAME,'.jpg'));
%Stores the drawn obstacle in file with the same name as figure
save(strcat('./Obstacle_Files/',FILE_NAME));



