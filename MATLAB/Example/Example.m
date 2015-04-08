%% X-Plane Connect MATLAB Example Script
% This script demonstrates how to read and write data to the XPC plugin.
% Before running this script, ensure that the XPC plugin is installed and
% X-Plane is running.
%% Import XPC
addpath('../')
import XPlaneConnect.*
%% Setup
% Create variables and open connection to X-Plane

disp('xplaneconnect Example Script-');
disp('Setting up Simulation');
Socket = openUDP(49005);

%% Set position of the player aircraft
disp('Setting position');
%       Lat     Lon         Alt   Pitch Roll Heading Gear
POSI = [36.684, -76.04, 2500, 0,    0,   0,      1];
sendPOSI(POSI); % Set own aircraft position

%       Lat     Lon           Alt   Pitch Roll Heading Gear
POSI = [36.68465, -76.04, 2500, 0,    0,  0,      1];
sendPOSI(POSI, 1); % Place another aircraft just north of us

%% Set rates
disp('Setting rates');
pauseSim(1);
% %                  Alpha Velocity PQR
% data = struct('h',[19,   3,       17],...
%               'd',[0,-999,0,-999,-999,-999,-999,-999;... % Alpha data
%                    130,130,130,130,-999,-999,-999,-999;...  % Velocity data
%                    0,0,0,-999,-999,-999,-999,-999]);       % PQR data
% sendDATA(data);
%                  Alpha
data = struct('h',[19],...
              'd',[0,0,0,0,-999,-999,-999,0]);     % Alpha data
sendDATA(data);
%                  Velocity
data = struct('h',[3],...
              'd',[50,50,50,50,-999,-999,-999,-999]);   % Velocity data
sendDATA(data);
%                  PQR
data = struct('h',[17],...
              'd',[0,0,0,-999,-999,-999,-999,-999]);        % PQR data
sendDATA(data);
 %% Set CTRL
 %                      Throttle
 CTRL = [0,0,0,0.8];
 sendCTRL(CTRL);
 
%% Run Simulation
 pauseSim(0);
 pause(5) % Run sim for 5 seconds
 %% Pause sim
 disp('Pausing simulation');
 pauseSim(1);
 pause(5);
 disp('Unpausing simulation');
 pauseSim(0);
 pause(10) % Run sim for 10 seconds
 %% Use DREF to raise landing gear
 disp('Raising gear');
 gearDREF = 'sim/cockpit/switches/gear_handle_status';
 sendDREF(gearDREF, 0);
 pause(10) % Run sim for 10 seconds
 %% Confirm gear and paus status by reading DREFs
 disp('Checking gear');
 pauseDREF = 'sim/operation/override/override_planepath';
%  result = requestDREF({gearDREF, pauseDREF});
 result = requestDREF({gearDREF});
 if result{1} == 0
     disp('Gear stowed');
 else
     disp('Error stowing gear');
 end

%% Exit
 closeUDP(Socket);
 disp('--End of example program--');
 