##
FABRICATION and FALSIFICATION of results in Paper2:

Figure 1 and Figure 2 are obtained with the three-dimensional codes 'GRW_Ref_27.m' and 'DRW_Ref_27.m' posted by the authors in the GitHub repository
https://github.com/taekwonzysong/AI4Soil/tree/main/Ref.%20%5B27%5D

These figures present solutions at the final time  having a similar appearance to the initial state. The reason is that the number of particles and the water content are not updated at the end of each time step, resulting in a wrong iterative scheme which fails to converge.

The results given by the two codes are identical. However, while Figs. 1a and 2a correspond to a cross-section at y=1.7, Figs 1b and 2b are FABRICATED by taking the cross section at y=0.7 in 'DRW_Ref_27.m'.
#
Thus, the comparison of the GRW and DRW approaches is FALSIFIED.
##
- 'GRW_Ref_27.m' is the code for the Global Random Walk method downloaded in 01.02.2025 from https://github.com/taekwonzysong/AI4Soil/tree/main/Ref.%20%5B27%5D;
  
                 the comment at lines 98-104 shows that Figs 1a,1b,2a, 2b are obtained with the GRW code.
  
- 'DRW_Ref_27.m' is the code for the Data-Driven Global Random Walk method downloaded in 01.02.2025 from https://github.com/taekwonzysong/AI4Soil/tree/main/Ref.%20%5B27%5D.

                 the comment at lines  289-295 shows that Figs 1a,1b,2a, 2b are also obtained with the DRW code.
  
- 'theta_GM' is the van Genuchten-Mualem parameterization of water content.
