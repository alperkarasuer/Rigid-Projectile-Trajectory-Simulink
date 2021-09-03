clear all

%% Constants
dt = 0.01;
g = 9.81;
ft2m = 0.3048;

%% Atmospheric Constants
rho0 = 1.223;
T0 = 293;
k = 1.4;
R = 287;

%% Physical Properties of the Projectile
d = 0.4572;
A = (pi*d*d)/4;
m = 944.8488;
Ix = 32.5309;
Iy = 588.2676;
Iz = Iy;
Ixy = 10;
Iyz = 10;
Ixz = 10;
I = [Ix, -Ixy, -Ixz;...
    -Ixy, Iy, -Iyz;...
    -Ixz, -Iyz, Iz];

%% Aerodynamical Properties of the Projectile
Machpoints = 0.7:0.1:2.0;
Cd_data = -[0.193000, 0.196000, 0.206000, 0.257000, 0.279000, 0.269000,...
            0.416000, 0.395000, 0.384000, 0.373000, 0.362000, 0.352000,...
            0.354000, 0.3440009];
        
Cza_data = -[20.213300, 20.825400, 21.843400, 23.556200, 26.383300, 24.598700,...
            23.268700, 20.533700, 18.997500, 17.741700, 16.698000, 15.796600,...
            14.919000, 14.200300];

Czd_data = [0.401072, 0.28648, 0.114592, -0.229184, -1.203216, -0.802144,...
    -0.171888, 0.515664, 0.744848, 0.916736, 0.974032, 1.031328, 1.08624,...
    1.14592];                
        
Czq_data = -[102.885000, 105.285000, 112.983000, 113.711000, 178.403000,...
            157.881000, 133.721000, 103.086000, 88.152000, 76.435000, 66.881000,...
            59.895000, 54.750000, 51.056000];
              
Cma_data = [-8.269200, -8.580300, -9.111100, -6.034300, -17.335200, -16.136100,...
        -14.625400, -14.758300, -11.152600, -8.920200, -7.407100, -6.237300,...
        -5.463200, -4.742900];
    
Cmd_data = -[17.47528, 18.392016, 19.939008, 22.173552, 28.476112, 25.668608,...
    22.460032, 17.876352, 15.699104, 14.266704, 13.006192, 11.974864,...
    11.17272, 10.427872];    
    
Cmq_data = -[457.057000, 466.180000, 496.727000, 492.380000, 740.436000, 674.419000,...
    574.369000, 480.449000, 428.210000, 388.812000, 357.745000, 333.967000,...
    311.705000, 289.316000];

Clp_data = -[40.493000, 41.949000, 44.638000, 47.044000, 51.895000, 47.722000,...
    42.495000, 36.943000, 33.037000, 30.538000, 28.578000, 26.930000, 25.510000,...
    24.289000];

Cld_data = [3.72424, 4.068016, 4.755568, 6.01608, 8.30792, 6.932816,...
    5.385824, 3.43776, 2.635616, 2.177248, 1.776176, 1.489696, 1.260512,...
    1.031328];
        
%% Position of the launch with respect to NED coordinate system in sea level        
xm = 0;
ym = 0;
hm = 20000*ft2m;
zm = -hm;

%% Initial angular positions and velocities
phiInit = 0*pi/180;
thetaInit = 0*pi/180;
psiInit = 0*pi/180;

% AoA and Sideslip Angle
alphaInit = 10/180*pi;
betaInit = 0/180*pi;

pInit = 0*pi/180;
qInit = 0*pi/180;
rInit = 0*pi/180;

% Elevator, rudder and aileron deflections
def_de = 0;
def_dr = 0;
def_da = 0;

%% Density, temperature and speed of sound in the given altitude

if((hm) <= 10000)
    rho = rho0*(1 - 0.00002256*(hm))^4.256;
    T = T0*(1 - 0.00002256*(hm));
else
    rho = 0.412*exp(-0.000151*(hm-10000));
    T = 0.7744*T0;
end

sos = sqrt(k*R*T);

%% Initial speed and acceleration components
mach = 1.2;
Vm_mpers = mach*sos;

% Given Beta value and known V_t we can find the v value
uInit = cos(alphaInit)*cos(betaInit)*Vm_mpers;
vInit = -cos(alphaInit)*sin(betaInit)*Vm_mpers;
wInit = sin(alphaInit)*Vm_mpers;

save('data.mat')
clear all

