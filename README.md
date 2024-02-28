# Mobile-robotics

Code developed for "A. Marino, - Receding Horizon Tracking Trajectory Strategy for Feedback Linearized Differential-Drive".  
Master's student "Calabria University".  
For any questions or suggestions write to alexismarino0109@gmail.com

# Sumary.
Within this repository, a comprehensive framework for mobile robotics is meticulously outlined, encompassing a diverse array of critical topics such as path planning, controller implementation, mobile robot modeling, sensor integration, and the application of Extended Kalman Filter (EKF) for precise positioning solutions amidst dynamic environmental configurations. This intricate scheme is meticulously crafted and implemented entirely within the MATLAB/Simulink environment, providing a cohesive and integrated platform for exploring, analyzing, and advancing mobile robotics principles and applications. The repository serves as a valuable resource for researchers, engineers, and enthusiasts alike, offering a detailed exploration of fundamental aspects and advanced techniques within the realm of mobile robotics.  
![image](https://github.com/fercho-0109/Mobile-robotics/assets/40362695/23696346-064c-4809-91ac-6b2186e58d7a)


# Problem Statement
Design a mobile robot simulation capable of moving in a structured environment following a desired trajectory  by means of a control strategy, the robot's position data is obtained by a set of sensors, this information must be filtered to obtain reliable data. The complete control strategy is determined by the closed control loop strategy shown in Figure  
![image](https://github.com/fercho-0109/Mobile-robotics/assets/40362695/898f4cfd-08c3-46a4-8ad3-529e24647de3)
## Main Assumptions
- The robot base movement is performed by wheels.  
- Assume a differential drive robot model  
- The robot moves in a structured environment  
- The environment is equipped with beacons localisation sensors  
- 
## Differential Drive Model 
![image](https://github.com/fercho-0109/Mobile-robotics/assets/40362695/e4ec6f7c-1631-4a29-ae84-eefdb1700f1a)

##  PATH PLANNING 
Define the environment  
![image](https://github.com/fercho-0109/Mobile-robotics/assets/40362695/ed22113f-075b-4db6-ac83-3a3f5df54866)  
The target and starting positions are selected from the environment so that the path planning can find the solution for all possible configurations.  
The position of all obstacles is a-priory know  
The obstacles are static   
**The strategy used to develop the path planning is Voronoi Diagrams, visibility graphs, and potential field** The goal is to compute the shortest Collision-Free path.  
**example**  
![image](https://github.com/fercho-0109/Mobile-robotics/assets/40362695/bef6face-4e72-4604-9409-2a6ba333d4fd)




















 
# Prerequisites
- The code was created and tested on the Matlab/Simulink 2023a environment

# File description
The repository contains three files
1. **Electric_Bicycle**: This Matlab file contains the configuration parameters of the program and shows the results of the analysis.
2. **Electric_Bike**: This Simulink file contains the complete simulation of the e-bike system and the implementation of the observer and control.
3. **Report**: This contains the complete explanation, the mathematical formulations, and the control configuration.


# Example to run the experiment  
**"e-BIKE"**
### Matlab/Simulink simulation 
1. Download the files. 
2. Run the Matlab file "**Electric_Bicycle**".
3. Open and run the Simulink file "**Electric_Bike**"
4. The Scope blocks should start to show the results  
![image](https://github.com/fercho-0109/Dynamic-system-analysis-of-a-e-Bike-/assets/40362695/38b221e3-3071-4afd-bd2a-a567903d0a51)  
fig1. In blue is shown the graph of the free response without feedback. On the other hand, the orange graph is the response after feedback control which shows a noticeable reduction of the overshoot that is generated in the beginning



