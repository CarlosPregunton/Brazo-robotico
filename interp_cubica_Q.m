function [ Qi_t,Vi_t,Ai_t ] = interp_cubica_Q( t0,tf,Q0,Q1 )
%Esta función toma la posición articular inicial Q0(q01,q02,q03,q04,q05,q06)
%y la posición articular final Q1(q11,q12,q13,q14,q15,q16) y devuelve 6
%vectores, correspondientes a las interpolaciones de cada variable
%articular
q01 = Q0(1);
q02 = Q0(2);
q03 = Q0(3);
q04 = Q0(4);
q05 = Q0(5);
q06 = Q0(6);

q11 = Q1(1);
q12 = Q1(2);
q13 = Q1(3);
q14 = Q1(4);
q15 = Q1(5);
q16 = Q1(6);

[ q1_t,v1_t,a1_t ] = interp_cubica( t0,tf,q01,q11 );
[ q2_t,v2_t,a2_t ] = interp_cubica( t0,tf,q02,q12 );
[ q3_t,v3_t,a3_t ] = interp_cubica( t0,tf,q03,q13 );
[ q4_t,v4_t,a4_t ] = interp_cubica( t0,tf,q04,q14 );
[ q5_t,v5_t,a5_t ] = interp_cubica( t0,tf,q05,q15 );
[ q6_t,v6_t,a6_t ] = interp_cubica( t0,tf,q06,q16 );

Qi_t = [q1_t q2_t q3_t q4_t q5_t q6_t];
Vi_t = [v1_t v2_t v3_t v4_t v5_t v6_t];
Ai_t = [a1_t a2_t a3_t a4_t a5_t a6_t];



end

