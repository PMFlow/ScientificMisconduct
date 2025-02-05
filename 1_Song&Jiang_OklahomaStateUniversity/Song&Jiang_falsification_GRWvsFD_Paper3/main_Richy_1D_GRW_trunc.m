%%   Truncation Scheme for Richards Eq.-1D
close all; clear all;
tic
%%   Grid Initialization
I = 101;
a = 0 ;
b = 2 ;
dx = (b-a)/(I-1);
x = a:dx:b;
x2 = (x(1:I-1)+x(2:I))/2;
T = 1*10^4; past=T/5; 
S = 2000; 
Tolerance=1e-18; 
%%   Parameters
Ksat = 2.77*10^-6;
theta_res=0.06;
theta_sat=0.36;
alpha=10;
q0=2.77*10^-7;
q1=2.50*10^-6;
t1=T/100;
maxr=0.8;
%%  Coefficients
vectKsat=Ksat*ones(1,I);
theta = @(p) theta_exp(theta_res,theta_sat,alpha,p);
K = @(theta) vectKsat.*(theta-theta_res)/(theta_sat-theta_res); 
%% Initial conditions
load IC_Richy_sat_101; % scenario-1
p=c;
L=2;
N=1e24; % 1e18; % 1e6; % 1e3; % 1e10; % 
n0 = floor(N*p);
p0=n0/N;
n=n0; nA=n(1);
pinit=p;
thtinit=tht;
figure(1); plot(pinit,x,'*');
ylabel('$z$','Interpreter','latex'); xlabel('$\psi(z,t=0)$','Interpreter','latex');
figure(2); plot(thtinit,x,'*');
ylabel('$z$','Interpreter','latex'); xlabel('$\theta(z,t=0)$','Interpreter','latex');
%% Solution
tgraf=0; tconv=0; t=0; kt=1; nn=zeros(1,I);
% restr=0; restjump1=0; restjumpI=0; rest1=0; rest2=0;
conv=zeros(5,S);
tht=theta(p);
tht0=tht;
pa=p;
iS=1:S;
while t<=T
    D=K(tht); D=D(1:I-1);
    dt=dx^2*maxr/max(D)/2; % r<=1/2 such that 1-2*r>=0
    t=t+dt;
    eps=zeros(1,S); 
    for s=1:S
        %% Reduced fluctuation BGRW algorithm:
        D=K(tht); D=D(1:I-1); 
        r=dt*D/dx^2/L;
        rloc=[1-2*r(1),1-(r(1:I-2)+r(2:I-1)),1-2*r(I-1)];
        nloc=rloc.*n; nn=floor(nloc); njump=n-nn;
        nleft=r(2:I-1).*n(3:I); njumpleft=floor(nleft); % left jumps
        nn(2:I-1)=nn(2:I-1)+njumpleft;
        nright=r(1:I-2).*n(1:I-2); njumpright=floor(nright); % left jumps
        nn(2:I-1)=nn(2:I-1)+njumpright;                 
        % restr=rloc.*n+restr; nn=floor(restr); restr=restr-nn;  njump=n-nn;
        % rest1=r(2:I-1).*n(3:I)+rest1; njumpleft=floor(rest1); rest1=rest1-njumpleft; % left jumps
        % nn(2:I-1)=nn(2:I-1)+njumpleft;
        % rest2=r(1:I-2).*n(1:I-2)+rest2; njumpright=floor(rest2); rest2=rest2-njumpright; % left jumps
        % nn(2:I-1)=nn(2:I-1) +njumpright;                 
        %% Dirichlet BC
        nn(1)=nA;
        %% Neuman BC
        if t<=t1
            qR=q0+t*(q1-q0)/t1; % -qR=-D(I-1)*((c(I)-c(I-1))/dx+1);
        else
            qR=q1;
        end
        nn(I)=nn(I-1)+(qR/D(I-1)-1)*dx*N;
        dtht=(tht0-tht)/L;
        %% Source term
        f=diff(r)*dx+dtht(2:I-1); 
        nn(2:I-1)=nn(2:I-1)+f*N;
        n=nn; p=n/N;
        na=n;
        %% Convergence criterion
        tol_eps=norm(p-pa);
        if kt*past>=t && kt*past<t+dt 
            eps(s)=tol_eps;
        end
        if tol_eps <= Tolerance
            break
        end        
        tht=theta(p);       
        pa=p;
    end
    if  kt*past>=t && kt*past<t+dt 
        rndt=kt*past;
        fprintf('t= %d\n',rndt);
        str=['t=',num2str(rndt)];
        strvect(kt,1:length(str))=str;
        conv(kt,:)=eps;
        figure(3); box; hold on;
        P(kt)=plot(iS,eps); 
        kt=kt+1;
    end
    tht=theta(p);    
    tht0=tht;
end
q=-D.*((p(2:I)-p(1:I-1))/dx+1);
%% Tolerance=1e-18; solutions for inceasing N;
% save('rGRWe3','p','x');
% save('rGRWe6','p','x');
% save('rGRWe10','p','x');
% save('rGRWe18','p','x');
% save('rGRWe24','p','x');
%% Plots
NameArray = {'Marker'}; ValueArray = {'o','+','x','*','.'}';
set(P,NameArray,ValueArray); 
set(gca,'yscale','log'); box on;
xlabel('$s$','Interpreter','latex');
ylabel('$\|\psi^s - \psi^{s-1}\| \;/\; \|\psi^s\|$','Interpreter','latex');
legend(strvect,'location','best'); legend('boxoff');  xlim([0 500]); ylim([1e-20 1]); 
figure(4);
plot(p,x,'mo--','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',7.2) ;
ylabel('$z$','Interpreter','latex'); xlabel('$\psi(z)$','Interpreter','latex')
grid on ;
figure(5);
plot(tht,x,'mo--','LineWidth',1.2,'MarkerFaceColor','yellow','MarkerSize',7.2) ;
ylabel('$z$','Interpreter','latex'); xlabel('$\theta(z)$','Interpreter','latex')
grid on ;
figure(6)
plot(q,x2,'.g'); 
ylabel('$z$','Interpreter','latex'); xlabel('$q(z)$','Interpreter','latex')
%%
fprintf('The space step is : %0.2e \n',dx) ;
fprintf('The time step is : %0.2e \n',dt) ;
toc 
