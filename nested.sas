data prob1;
input 
type $	bag $	color $	count;
cards;
plain	1	1	10
plain	1	2	14
plain	1	3	14
plain	1	4	5
plain	1	5	6
plain	1	6	9
peanut	2	1	3
peanut	2	2	6
peanut	2	3	8
peanut	2	4	1
peanut	2	5	2
peanut	2	6	1
plain	3	1	8
plain	3	2	16
plain	3	3	14
plain	3	4	10
plain	3	5	4
plain	3	6	5
peanut	4	1	1
peanut	4	2	5
peanut	4	3	2
peanut	4	4	4
peanut	4	5	6
peanut	4	6	1
peanut	5	1	1
peanut	5	2	7
peanut	5	3	1
peanut	5	4	6
peanut	5	5	4
peanut	5	6	3
plain	6	1	7
plain	6	2	17
plain	6	3	10
plain	6	4	6
plain	6	5	8
plain	6	6	5
plain	7	1	8
plain	7	2	16
plain	7	3	12
plain	7	4	9
plain	7	5	6
plain	7	6	7
peanut	8	1	3
peanut	8	2	5
peanut	8	3	4
peanut	8	4	6
peanut	8	5	0
peanut	8	6	3
plain	9	1	6
plain	9	2	10
plain	9	3	18
plain	9	4	6
plain	9	5	8
plain	9	6	7
peanut	10	1	4
peanut	10	2	3
peanut	10	3	2
peanut	10	4	3
peanut	10	5	3
peanut	10	6	4
plain	11	1	3
plain	11	2	25
plain	11	3	15
plain	11	4	6
plain	11	5	3
plain	11	6	4
peanut	12	1	1
peanut	12	2	5
peanut	12	3	3
peanut	12	4	4
peanut	12	5	4
peanut	12	6	4
peanut	13	1	1
peanut	13	2	4
peanut	13	3	1
peanut	13	4	4
peanut	13	5	3
peanut	13	6	5
plain	14	1	6
plain	14	2	8
plain	14	3	24
plain	14	4	3
plain	14	5	9
plain	14	6	8
;
run;


*sp15 prob1.B;
proc anova data = prob1;
	class type bag color;
	*bag is nested within type;
	model count = type  color bag(type) type*color ;
	*gives the multiple comparison procedure;
	means color /tukey;
run;



*sp15 prob1.D;
*for the mulitple comparison procedure, means with the same
letter are not statistically different;
proc glm data = prob1 alpha=.05;
	class type bag color;
	*bag is nested within type;
	model count = type  color bag(type) type*color ;
	*gives the multiple comparison procedure;
	means color /tukey;
	*gets the residuals to test for normality;
	output out = myout r = res;
run;





*Tests for normality of residuals;
proc univariate  normal plot data = myout;
	var res;
run;

