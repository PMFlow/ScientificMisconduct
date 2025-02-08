##
FABRICATION and FALSIFICATION of results in Paper2:

Figure 1 and Figure 2 are FABRICATED with the  code 'SongJiang_fabricated_IC_Paper2.m'
(also posted at
https://github.com/PMFlow/RichardsEquation/blob/main/2D/Richards_2D/Richy_2D_Flow_benchmark_IC_SongJiang.m)

These figures are obtained by altering the initial conditions formulated in this article as follows:
- \varphy(t=0)=0 on the right boundary  
{x=2 and z\in [0,2]};
- \varphy(t=0)=\varphy(t=0)+0.1 on the left boundary  {x=0 and z\in [0,2]};
- \varphy(t=0)=\varphy(t=0)+0.1 on the left corner {x=0 and z=2}.

Further, with
- \varphy(t=0)=\varphy(t=0)-0.1 on the top right corner {x=2 and z=2},
one obtains Figs. 1a and 2a.

With
- \varphy(t=0)=0 on the first half of the top boundary {x\in[0,1] and z=2}, and 
- \varphy(t=0)=\varphy(t=0)+0.2 on the top right corner {x=2 and z=2},
on obtains Figs. 1b and 2b.
