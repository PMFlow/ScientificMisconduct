##
This folder contains comparisons between the GRW and the equivalent FD scheme. The GRW scheme represents the pressure head by N particles, \psi~n_i/N, where n_i is the number of particles at the site i of a regular lattice. Comparisons with the FD solution show that the relative errors of the GRW scheme are of order 1/N and for N>=1e18 the errors are close to the machine precision 1e-16. 

These results demonstrate the willful falsification of the results presented in [Suciu et al., 2021] ((https://doi.org/10.1016/j.advwatres.2021.103935) by Zeyuan Song and Zheyu Jiang from Oklahoma State University. In their preprint 
"A Data-facilitated Numerical Method for Richards Equation to Model Water Flow Dynamics in Soil, https://doi.org/10.48550/arXiv.2310.02806" as well as in references [31] and [32] therein, they make the incorrect and baseless statement that in case of Richard's equation the GRW scheme is no longer equivalent to a finite difference scheme and the relation between \psi and n_i/N cannot be linear! 
  
##

- 'main_Richy_1D_FD.m' is the Matlab code for the finite difference L-scheme for Richards' equation.

- 'main_Richy_1D_GRW.m' is the Matlab code for the biased GRW (BGRW) L-scheme for Richards' equation using the "reduced fluctuations algorithm".

- 'main_Richy_1D_GRW_trunc.m' solves the Richards equation with a Truncation Scheme which disregards the rests of the truncations done by 'floor' functions.  

- 'theta_exp.m' provides the unsaturated/saturated water content as a function of pressure head ccording to the exponential parameterization.

- 'IC_Richy_sat_101.mat' is a file containing the initial condition.

- 'pGRWe3.mat' ... 'pGRWe24.mat' are files containing the pressure head computed with the BGRW code for increasing numbers of particles N=1e-3, ... , N=1e-24.

- 'rGRWe3.mat' ... 'rGRWe24.mat' are files containing the pressure head computed with the Truncation Scheme.

- 'pFD.mat' is the file containing the finite difference solution.
  
- 'comparison_GRW_FD.m' compares the BGRW and FD solutions.

- 'comparison_GRW_FD_trunc.m' compares the FD and Truncation Scheme solutions.

- 'Fig.1.png' and 'Fig.2.png' present the results of the comparison.
