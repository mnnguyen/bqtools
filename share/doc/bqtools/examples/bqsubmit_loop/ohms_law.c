#include <stdio.h>

int main(int argc, char *argv[]) 
{
	float resistance, current;
	float voltage, power;
	FILE *fp;

	/* Read resistance and current from input file */
	fp = fopen(argv[1], "rt");
	fscanf(fp, "%*s %*s %f", &resistance);		
	fscanf(fp, "%*s %*s %f", &current);		
	fclose(fp);

	/* Calculate voltage and power */
	voltage = resistance * current;
	power   = voltage    * current;

	/* Output the results */
//	printf("The voltage is %6.2f V\nThe power is %6.2f W\n", voltage, power);
	printf("Inputs:\n");
	printf("    Resistance : %f ohms\n", resistance);
	printf("    Current    : %f A\n", current);
	printf("Results:\n");
	printf("    Voltage    : %f V\n", voltage);
	printf("    Power      : %f W\n", power);

	return 0;
}
