clear
close
clc

%% Simulation
% Load Variables
if(isfile('data.mat'))
    inits = load('data.mat');
else
    run('givenData.m')
    inits = load('data.mat');
end

% Set Simulation Parameters for Simulink
paramStruct.StopTime = 'inf';
paramStruct.SolverType = 'Fixed-step';
paramStruct.Solver = 'ode1';
paramStruct.FixedStep = num2str(inits.dt);

% Run the Model and Save Variables to Workspace
simOut = sim('model.slx',paramStruct);


endTime = simOut.tout(end);

%% Plot

% 3D Trajectory Plot
figure('Name', 'X-Y-H, 3D Trajectory')
set(gcf, 'WindowState', 'maximized');
plot3(simOut.Xe(:,1), simOut.Xe(:,2), simOut.altitude)
title('Trajectory','FontSize',14)
xlabel('X Axis (m)','FontSize',12)
ylabel('Y Axis (m)','FontSize',12)
zlabel('Altitude (m)','FontSize',12)

% X-H Plot
figure('Name', 'X-H Plot')
set(gcf, 'WindowState', 'maximized');
plot(simOut.Xe(:,1), simOut.altitude)
title('X-H Plot','FontSize',14)
xlabel('X Axis (m)','FontSize',12)
ylabel('Altitude (m)','FontSize',12)

% Y-H Plot
figure('Name', 'Y-H Plot')
set(gcf, 'WindowState', 'maximized');
plot(simOut.Xe(:,2), simOut.altitude)
title('Y-H Plot','FontSize',14)
xlabel('Y Axis (m)','FontSize',12)
ylabel('Altitude (m)','FontSize',12)

% X-Y Plot
figure('Name', 'X-Y Plot')
set(gcf, 'WindowState', 'maximized');
plot(simOut.Xe(:,1), simOut.Xe(:,2))
title('X-Y Plot','FontSize',14)
xlabel('X Axis (m)','FontSize',12)
ylabel('Y Axis (m)','FontSize',12)

% Body Angular Rates Plots
figure('Name', 'p-q-r Body Angular Rates Plots')
set(gcf, 'WindowState', 'maximized');
subplot(3,1,1)
plot(simOut.tout, simOut.Wb(:,1))
title('p vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('p (rad/s)','FontSize',12)
hold on

subplot(3,1,2)
plot(simOut.tout, simOut.Wb(:,2))
title('q vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('q (rad/s)','FontSize',12)

subplot(3,1,3)
plot(simOut.tout, simOut.Wb(:,3))
title('r vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('r (rad/s)','FontSize',12)

% u-v-w Body Velocities Plots
figure('Name', 'u-v-w Velocities in Body Frame')
set(gcf, 'WindowState', 'maximized');
subplot(3,1,1)
plot(simOut.tout, simOut.Vb(:,1))
title('u vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('u (m/s)','FontSize',12)
hold on

subplot(3,1,2)
plot(simOut.tout, simOut.Vb(:,2))
title('v vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('v (m/s)','FontSize',12)

subplot(3,1,3)
plot(simOut.tout, simOut.Vb(:,3))
title('w vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('w (m/s)','FontSize',12)


% Euler Angles Plots
figure('Name', 'Euler Angles Plot')
set(gcf, 'WindowState', 'maximized');
subplot(3,1,1)
plot(simOut.tout, simOut.Euler(:,1))
title('\phi vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('\phi (rad)','FontSize',12)
hold on

subplot(3,1,2)
plot(simOut.tout, simOut.Euler(:,2))
title('\theta vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('\theta (rad)','FontSize',12)

subplot(3,1,3)
plot(simOut.tout, simOut.Euler(:,3))
title('\psi vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('\psi (rad)','FontSize',12)

% Mach Number - Angle of Attack and Sideslip Angle Plots
figure('Name', 'Mach Number - Alpha - Beta Plots')
set(gcf, 'WindowState', 'maximized');
subplot(3,1,1)
plot(simOut.tout, simOut.Mach)
title('Mach Number vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('Mach','FontSize',12)
hold on

subplot(3,1,2)
plot(simOut.tout, simOut.alpha)
title('\alpha vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('\alpha (rad)','FontSize',12)

subplot(3,1,3)
plot(simOut.tout, simOut.beta)
title('\beta vs Time','FontSize',14)
xlim([0 endTime])
xlabel('Time (s)','FontSize',12)
ylabel('\beta (rad)','FontSize',12)