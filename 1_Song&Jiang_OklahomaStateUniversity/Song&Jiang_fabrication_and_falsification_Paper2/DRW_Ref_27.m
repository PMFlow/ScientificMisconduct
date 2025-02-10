% Run GRW_Ref_27.m first to generate p21 and pp1
p_new=p21+0.1*randn(1,9261);
nn_new=pp1+0.1*randn(1,9261);
data_input=p_new;
data_target=nn_new;
plot(data_input,data_target,'b-');
% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created 08-Sep-2022 17:42:48 
%
% This script assumes these variables are defined:
%
%   p_new - input data.
%   nn_new - target data.


% Choose a Training Function
% For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest.
% 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. Suitable in low memory situations.
trainFcn = 'trainbr';  % Bayesian Regularization backpropagation.

% Create a Fitting Network
hiddenLayerSize = 10;
net1 = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net1.divideParam.trainRatio = 70/100;
net1.divideParam.valRatio = 15/100;
net1.divideParam.testRatio = 15/100;

% Train the Network
[net1,tr] = train(net1,data_input,nn_new);

% Test the Network
y = net1(data_input); 
e = gsubtract(nn_new,y);
performance = perform(net1,nn_new,y);
y7=net1(-2.*ones(1,441));
y7=reshape(y7,21,21);
n0=cat(1,y7,y7);
y8=net1(zeros(1,441));
y8=reshape(y8,21,21);
% View the Network
hiddenLayerSize = 10;
net2 = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net2.divideParam.trainRatio = 70/100;
net2.divideParam.valRatio = 15/100;
net2.divideParam.testRatio = 15/100;

% Train the Network
[net2,tr] = train(net2,nn_new,data_input);

% Test the Network
y7=net1(-2.*ones(1,441));
y7=reshape(y7,21,21);
n0=cat(1,y7,y7);
y8=net1(zeros(1,441));
y8=reshape(y8,21,21);
% View the Network

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
%figure, plotfit(net,x,t)



% View the Network

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, ploterrhist(e)
%figure, plotregression(t,y)
n0=zeros(21,21,21);
for i=1:10
    n0(:,:,i)=y7;
end
for i=11:21
    n0(:,:,i)=y8;
end

num_nodes_x=21;
num_nodes_y=21;
num_nodes_z=21;
initial_length=0;
end_length=2;
initial_width=0; 
end_width=2;
initial_depth=0;
end_depth=2;
dx=(end_length-initial_length)/(num_nodes_x-1);
dy=(end_width-initial_depth)/(num_nodes_y-1);
dz=(end_depth-initial_depth)/(num_nodes_z-1);
grid_x=initial_length:dx:end_length;
grid_y=initial_width:dy:end_width;
grid_z=initial_depth:dy:end_depth;
K_s = 0.0496;
theta_r=0.131;
theta_s=0.396;
alpha=0.423;
n_model=2.06;
Total_time = 3/16; 
past=Total_time/3;
iterations= 500; 
dt=1/48;
t1=Total_time/3;      
Tolerance = 1e-5;
number_of_particles=10^10;
theta =  @(psi)  theta_GM(theta_r,theta_s,psi,alpha,n_model,(n_model-1)/n_model);
calculate_K = @(theta) K_s.*((theta - theta_r)./(theta_s-theta_r)).^0.5.*(1-(1-((theta - theta_r)./(theta_s-theta_r)).^(1/(n_model-1)/n_model)).^((n_model-1)/n_model)).^2;  
ini = 1 - ((grid_z'-initial_width)/(end_width-initial_width))*3+0*grid_x+0*grid_y;
for i=1:21
    psi_0(:,:,i) = ini;
end
i0=1/dx; j0=1/dy; k0=1/dz;
psi_0(21,1:i0,1:j0)=-2; 
n0=net1(reshape(psi_0,1,9261));
n0=reshape(n0,21,21,21);
psi = psi_0;
n=n0;
kt=1;
new_number_of_particles=zeros(21,21,21);
soil_moisture_content = theta(psi);
soil_moisture_content0=soil_moisture_content;
L=0.5;  
pa=psi;
current_time=0;
tol_iterations=zeros(1,iterations);
while current_time<=Total_time
    current_time=current_time+dt; 
    for iteration=1:iterations
        K1=calculate_K(soil_moisture_content);
        K_x=(K1(2:20,1:20,1:20)+K1(2:20,2:21,2:21))/2;
        K_y=(K1(1:20,1:20,2:20)+K1(2:21,2:21,2:20))/2;
        K_z=(K1(1:20,2:20,1:20)+K1(2:21,2:20,2:21))/2;
        r_x=dt*K_x/(dx^2*L); 
        r_y=dt*K_y/(dy^2*L);
        r_z=dt*K_z/(dz^2*L);
        residual_coefficients=1-(r_x(:,1:19,1:19)+r_x(:,2:20,2:20)+r_y(1:19,1:19,:)+r_y(2:20,2:20,:)+r_z(1:19,:,1:19)+r_z(2:20,:,2:20));
        new_number_of_particles(2:20,2:20,2:20)=residual_coefficients.*n(2:20,2:20,2:20) ...
            +r_x(:,1:19,1:19).*n(2:20,1:19,1:19)+r_x(:,2:20,2:20).*n(2:20,3:21,3:21) ...
            +r_y(1:19,1:19,:).*n(1:19,1:19,2:20) +r_y(2:20,2:20,:).*n(3:21,3:21,2:20)...
            +r_z(1:19,:,1:19).*n(1:19,2:20,1:19) +r_z(2:20,:,2:20).*n(3:21,2:20,3:21);
       
        new_number_of_particles(:,:,1)=new_number_of_particles(:,:,2); 
        new_number_of_particles(1:j0,:,21)=psi_0(1:j0,:,21); 
        new_number_of_particles(1:j0,21,:)=psi_0(1:j0,21,:); 
        new_number_of_particles(j0+1:21,21,21)=new_number_of_particles(j0+1:21,21,20);
        new_number_of_particles(j0+1:21,21,21)=new_number_of_particles(j0+1:21,20,21);
        new_number_of_particles(1,:,2:20)=new_number_of_particles(2,:,2:20)+number_of_particles*(dz); 
        new_number_of_particles(:,1,2:20)=new_number_of_particles(:,2,2:20)+number_of_particles*(dz);
        if current_time<=t1 
            new_number_of_particles(21,:,1:i0)=n0(21,:,1:i0)+number_of_particles*(2.2*current_time/t1);
            new_number_of_particles(21,1:i0,:)=n0(21,1:i0,:)+number_of_particles*(2.2*current_time/t1);
        else
            new_number_of_particles(21,:,1:i0)=number_of_particles*(0.2);
        end
        new_number_of_particles(21,:,i0+1:21-1)=new_number_of_particles(20,:,i0+1:20)-number_of_particles*(dy); 
        new_number_of_particles(21,i0+1:21-1,:)=new_number_of_particles(20,i0+1:20,:)-number_of_particles*(dy);% no flux
        soil_moisture_content_diff=(soil_moisture_content0-soil_moisture_content)/L;
        third_term_init=(r_y(2:20,2:20,:)-r_y(1:19,1:19,:))*dy + soil_moisture_content_diff(2:20,2:20,2:20);
        flux_residual=number_of_particles*(reshape(third_term_init,1,6859));
        flux_residual=reshape(flux_residual,19,19,19);
        new_number_of_particles(2:20,2:20,2:20)=new_number_of_particles(2:20,2:20,2:20)+flux_residual;
        pp1=reshape(new_number_of_particles,1,9261);
        psi=reshape(net2(pp1),21,21,21);
        tol_iteration=dx*norm(psi-pa,"fro")+norm(psi-pa,"fro")/norm(psi,"fro");
        if kt*past>=current_time && kt*past<current_time+dt && current_time<=Total_time
            tol_iterations(iteration)=tol_iteration;
        end 
        if tol_iteration <= Tolerance
            break
        end        
        soil_moisture_content = theta(psi);
        pa=psi;
    end
end
p1=psi(:,:,17);
soil_moisture_content1=soil_moisture_content(:,:,17);
%%% Full credits given to GRW solver originally presented in:
%Suciu, N., Illiano, D., Prechtel, A., Radu, F. A., 2021. https://github.com/PMFlow/RichardsEquation Git repository https://doi.org/10.5281/zenodo.4709693
%Suciu, N., Illiano, D., Prechtel, A., Radu, F. A., 2021. Global random walk solvers for fully coupled flow and transport in saturated/unsaturated porous media. Advances in Water Resources, 152, 103935
clear
num_nodes_x=21;
num_nodes_y=21;
num_nodes_z=21;
initial_length=0;
end_length=2;
initial_width=0; 
end_width=2;
initial_depth=0;
end_depth=2;
dx=(end_length-initial_length)/(num_nodes_x-1);
dy=(end_width-initial_depth)/(num_nodes_y-1);
dz=(end_depth-initial_depth)/(num_nodes_z-1);
grid_x=initial_length:dx:end_length;
grid_y=initial_width:dy:end_width;
grid_z=initial_depth:dy:end_depth;
K_s = 0.0496;
theta_r=0.131;
theta_s=0.396;
alpha=0.423;
n_model=2.06;
Total_time = 3/16; 
past=Total_time/3;
iterations= 500; 
dt=1/48;
t1=Total_time/3;      
Tolerance = 1e-5;
number_of_particles=10^10;
theta =  @(psi)  theta_GM(theta_r,theta_s,psi,alpha,n_model,(n_model-1)/n_model);
calculate_K = @(theta) K_s.*((theta - theta_r)./(theta_s-theta_r)).^0.5.*(1-(1-((theta - theta_r)./(theta_s-theta_r)).^(1/(n_model-1)/n_model)).^((n_model-1)/n_model)).^2;  
ini = 1 - ((grid_z'-initial_width)/(end_width-initial_width))*3+0*grid_x+0*grid_y;
for i=1:21
    psi_0(:,:,i) = ini;
end
i0=1/dx; j0=1/dy; k0=1/dz;
psi_0(21,1:i0,1:j0)=-2; 
n0=number_of_particles*(reshape(psi_0,1,9261));
n0=reshape(n0,21,21,21);
psi = psi_0;
n=n0;
kt=1;
new_number_of_particles=zeros(21,21,21);
soil_moisture_content = theta(psi);
soil_moisture_content0=soil_moisture_content;
L=0.5;  
pa=psi;
current_time=0;
tol_iterations=zeros(1,iterations);
while current_time<=Total_time
    current_time=current_time+dt; 
    for iteration=1:iterations
        K1=calculate_K(soil_moisture_content);
        K_x=(K1(2:20,1:20,1:20)+K1(2:20,2:21,2:21))/2;
        K_y=(K1(1:20,1:20,2:20)+K1(2:21,2:21,2:20))/2;
        K_z=(K1(1:20,2:20,1:20)+K1(2:21,2:20,2:21))/2;
        r_x=dt*K_x/(dx^2*L); 
        r_y=dt*K_y/(dy^2*L);
        r_z=dt*K_z/(dz^2*L);
        residual_coefficients=1-(r_x(:,1:19,1:19)+r_x(:,2:20,2:20)+r_y(1:19,1:19,:)+r_y(2:20,2:20,:)+r_z(1:19,:,1:19)+r_z(2:20,:,2:20));
        new_number_of_particles(2:20,2:20,2:20)=residual_coefficients.*n(2:20,2:20,2:20) ...
            +r_x(:,1:19,1:19).*n(2:20,1:19,1:19)+r_x(:,2:20,2:20).*n(2:20,3:21,3:21) ...
            +r_y(1:19,1:19,:).*n(1:19,1:19,2:20) +r_y(2:20,2:20,:).*n(3:21,3:21,2:20)...
            +r_z(1:19,:,1:19).*n(1:19,2:20,1:19) +r_z(2:20,:,2:20).*n(3:21,2:20,3:21);
       
        new_number_of_particles(:,:,1)=new_number_of_particles(:,:,2); 
        new_number_of_particles(1:j0,:,21)=psi_0(1:j0,:,21); 
        new_number_of_particles(1:j0,21,:)=psi_0(1:j0,21,:); 
        new_number_of_particles(j0+1:21,21,21)=new_number_of_particles(j0+1:21,21,20);
        new_number_of_particles(j0+1:21,21,21)=new_number_of_particles(j0+1:21,20,21);
        new_number_of_particles(1,:,2:20)=new_number_of_particles(2,:,2:20)+number_of_particles*(dz); 
        new_number_of_particles(:,1,2:20)=new_number_of_particles(:,2,2:20)+number_of_particles*(dz);
        if current_time<=t1 
            new_number_of_particles(21,:,1:i0)=n0(21,:,1:i0)+number_of_particles*(2.2*current_time/t1);
            new_number_of_particles(21,1:i0,:)=n0(21,1:i0,:)+number_of_particles*(2.2*current_time/t1);
        else
            new_number_of_particles(21,:,1:i0)=number_of_particles*(0.2);
        end
        new_number_of_particles(21,:,i0+1:21-1)=new_number_of_particles(20,:,i0+1:20)-number_of_particles*(dy); 
        new_number_of_particles(21,i0+1:21-1,:)=new_number_of_particles(20,i0+1:20,:)-number_of_particles*(dy);% no flux
        soil_moisture_content_diff=(soil_moisture_content0-soil_moisture_content)/L;
        third_term_init=(r_y(2:20,2:20,:)-r_y(1:19,1:19,:))*dy + soil_moisture_content_diff(2:20,2:20,2:20);
        flux_residual=number_of_particles*(reshape(third_term_init,1,6859));
        flux_residual=reshape(flux_residual,19,19,19);
        new_number_of_particles(2:20,2:20,2:20)=new_number_of_particles(2:20,2:20,2:20)+flux_residual;
        pp1=reshape(new_number_of_particles,1,9261);
        psi=reshape(1/number_of_particles*(pp1),21,21,21);
        tol_iteration=dx*norm(psi-pa,"fro")+norm(psi-pa,"fro")/norm(psi,"fro");
        if kt*past>=current_time && kt*past<current_time+dt && current_time<=Total_time
            tol_iterations(iteration)=tol_iteration;
        end 
        if tol_iteration <= Tolerance
            break
        end        
        soil_moisture_content = theta(psi);
        pa=psi;
    end
end
%% original in GitHub/ DRW.m ===> Figs. 1b and 2b in Paper 2
p1=psi(:,:,7);
soil_moisture_content1=soil_moisture_content(:,:,7);
%% by changing the position of the cross-section, DRW.m produces the Figs. 1a and 2a as well:
% p1=psi(:,:,17); 
% soil_moisture_content1=soil_moisture_content(:,:,17);
%%
p1=psi(:,:,7);
soil_moisture_content1=soil_moisture_content(:,:,7);
pp1=reshape(new_number_of_particles,1,9261);
p21=reshape(psi,1,9261);
% Plot the 3D mesh of p1
figure;
mesh(grid_x, grid_y, p1); % Create a 3D mesh plot
xlabel('$x$', 'Interpreter', 'latex'); % Label for x-axis
ylabel('$z$', 'Interpreter', 'latex'); % Label for z-axis
zlabel('$\psi(x,z,t)$', 'Interpreter', 'latex'); % Label for y-axis
view(115, 15); % Set view angle (azimuth: 115, elevation: 15)
grid on; % Enable grid

% Plot the contour of soil moisture content
figure;
contourf(grid_x, grid_y, soil_moisture_content1, 12); % Filled contour plot with 12 levels
colormap(flipud(parula)); % Use reversed parula colormap
colorbar; % Add a colorbar
xlabel('$x$', 'Interpreter', 'latex'); % Label for x-axis
ylabel('$z$', 'Interpreter', 'latex'); % Label for z-axis
title('$\theta(x,z,t)$', 'Interpreter', 'latex'); % Title of the plot







