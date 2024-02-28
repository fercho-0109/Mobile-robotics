clear all;
close all;
clc;
%% _______ Proyect Mobile Robotic_________________
% show a priory known enviroment 
LOAD_FILE_NAME = 'Obstacle_config006';
load(strcat(strcat('./Obstacle_Files/',LOAD_FILE_NAME)));
title('Environment')
xlabel('x-position (cm)')
ylabel('y-position (cm)')
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
       plot(x,y,'k',LineWidth=2);
       hold on;
    end
end
% Add task to perform with the robot 
Start = ginput(1);
plot(Start(1),Start(2),'--go','MarkerSize',10,'MarkerFaceColor','g');
drawnow;
Goal  = ginput(1);
plot(Goal(1),Goal(2),'--ro','MarkerSize',10,'MarkerFaceColor','r');
drawnow;
%% _______ PATH PLANING ____________
%Using Voronoi diagrams to generate the path
voronoi(X_Total_points,Y_Total_points);
[Voro_Vertex,Voro_Cell] = voronoin([X_Total_points' Y_Total_points']);
[ Temp_Edge ]=Voronoi_Graph(Voro_Vertex, Voro_Cell, All_cells_Number,Cell_start,Num_Object);
[xx,yy]= find_path(Temp_Edge,Voro_Vertex,Start,Goal,Num_Object,X1);
%figure(2)
% xp=xx';
% yp=yy';
points=[xx ; yy];
tp=0;
distan=0;
np=length(points);
ttotal=zeros(1, np);
for i=1:length(points)-1
    d1=points(1,i+1)-points(1,i);
    d2=points(2,i+1)-points(2,i);
    disPP=sqrt((d1^2)+(d2^2));
    distan=distan+disPP;   
    tt=disPP/2;
    tp=tp+tt;
    ttotal(i+1)=tp;
end
tpp = linspace(0,tp,np);
%% ___Simulation complete system with control and filter_________
X0=[xx(1)-3;yy(1)-3;0.1745];
P0=diag([0.55 0.55 deg2rad(10)].^2);
C=eye(3);
Xhat0=X0+sqrt(P0)*randn(length(X0),1);
disp('continuous system simulation')
data=sim('generator');
 %% _________plot the results_________
X_real=data.X_real';
Y=data.Y';
X_s=data.X_sensores';
X_star=data.X_star';
X_nom=data.X_nom';
X_pred=data.X_stimations';
X_stima=data.X_filter';
t_sim=data.tout';
%% __________Select the plot________________________%
plot_nominal_traj=1;
plotB=1;
pointPlot=1;
enable_real_plot=1;
enable_measurements_plot=1;
enable_estimate_plot=1;
%%___________Real_trajectiry_plot_____________________%
if enable_real_plot
h1=figure();
plot_robot_traj(X_real,-1,1,[0 100 0 100],h1);
figure()
if plotB
    title('Error')
    err=sqrt((X_star(1,:)'-X_real(1,:)').^2+(X_star(2,:)'-X_real(2,:)').^2);
    hold on;grid on;
    plot(t_sim',err,'LineWidth',1);
    plot(t_sim',ones(size(t_sim))*b,'--k','LineWidth',1);
end
end
%_____________measurements_plot______________________%
if enable_measurements_plot
    h=figure();
    title('Position measurement')
    for k=1:size(Y,2)
        cla;
        x=X_s(:,k);
        y=Y(:,k);
        plot_robot_traj(X_s,k,1,[0 100 0 100],h);
        plot_sensors_data(x,y,h);
        pause(0.05);
    end
 figure();
 plot(t_sim',X_real(1,:)'-X_s(1,:)')
 title('Error between real and sensors X pos')
 figure();
 plot(t_sim',X_real(2,:)'-X_s(2,:)')
 title('Error between real and sensors Y pos')
 figure();
 hold on
 plot(X_real(1,:)',X_real(2,:)','b','LineWidth',1)
 plot(X_s(1,:)',X_s(2,:)','r','LineWidth',0.5)
 title('Real trajectory vs Sensor trajectory')
end
%____________robot_nominal_trajectory___________________________%
if plot_nominal_traj
figure();
title('X Reference vs real X trajectory')
hold on;grid on;
plot(t_sim',X_nom(1,:)','b','LineWidth',2);
plot(t_sim',X_star(1,:)','r','LineWidth',2);

figure()
title('Y Reference vs real Y trajectory')
hold on;grid on;
plot(t_sim',X_nom(2,:)','b','LineWidth',2);
plot(t_sim',X_star(2,:)','r','LineWidth',2);

% subplot(333);hold on;grid on;plot(t_sim',X_star(1,:)'-X_nom(1,:)');
% subplot(336);hold on;grid on;plot(t_sim',X_star(2,:)'-X_nom(2,:)');
figure()
if plotB
    title('Error')
    err=sqrt((X_star(1,:)'-X_nom(1,:)').^2+(X_star(2,:)'-X_nom(2,:)').^2);
    hold on;grid on;
    plot(t_sim',err,'LineWidth',3);
    plot(t_sim',ones(size(t_sim))*b,'--k','LineWidth',3);
end
pause();
h=figure();
LOAD_FILE_NAME = 'Obstacle_config006';
load(strcat(strcat('./Obstacle_Files/',LOAD_FILE_NAME)));
title('Enviroment')
xlabel('x-position (cm)')
ylabel('y-position (cm)')
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
       plot(x,y,'k',LineWidth=2);
       hold on;
    end
end

for k=1:2:size(X_nom',1)
    tcur=t_sim(1:k);
    plot_robot_traj(X_nom,k,1,[],h);
    title(num2str(k/size(X_nom',1)));
    
    if pointPlot==0
        plot_robot_traj(X_star,k,2,[],h);
    else
        plot(X_star(1,1:tcur),X_star(2,1:tcur),'-k','LineWidth',2);
    end
    if plotB
        X=X_nom(1:3,k)';
        line([X(1) X(1)+b+3*cos(X(3))],[X(2) X(2)+b+3*sin(X(3))],'LineStyle','--','LineWidth',1);
        plot(X(1)+b+3*cos(X(3)),X(2)+b+3*sin(X(3)),'ob','LineWidth',0.5);
    end
    
    pause(0.3)
end
end
%______________strimation_trajectory____________________%
if enable_estimate_plot
    h=figure();
    for k=1:size(Y,2)
        cla;

            plot_robot_traj(X_real,k,1,[],h);
            plot_robot_traj(X_stima,k,2,[],h);

        pause(0.1);

    end  
    for i=1:size(X_real,1)
        figure('name',[num2str(i) '^a component of the state estima and real']);
        %plot(X(i,:),'--rs','MarkerFaceColor','b');
        plot(X_real(i,:),'LineWidth',1);
        hold on;
        %plot(X_hat(i,:),'--rs','MarkerFaceColor','r');
        plot(X_pred(i,:),'g','LineWidth',1);
        plot(X_stima(i,:),'--r','LineWidth',1);
        legend('Real','Prediction','Estima')
        pause()
    end
 end

