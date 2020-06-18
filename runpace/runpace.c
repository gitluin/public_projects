#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int
main(int argc, char* argv[]){
	float miles, pace, pace_min, pace_sec, hms[3];
	char* token;
	char time[5], pace_str[5], mile_str[4];
	char delim[2] = ":";
	int i = 0;

	if (argc != 3){
		printf("Please provide 2 arguments: \"HH:MM:SS\" and Miles!\n");
		return 0;
	}

	snprintf(time, 9 * sizeof(char), "%s", argv[1]);
	snprintf(mile_str, 4 * sizeof(char), "%s", argv[2]);
	miles = strtof(mile_str, NULL);

	token = strtok(time, delim);
	while (token){
		if (i <= 3){
			hms[i] = strtof(token, NULL);

		} else {
			break;
		}

		token = strtok(NULL, delim);
		i++;
	}

	pace = ((hms[0] * 60) + hms[1] + (hms[2] / 60)) / miles;
	pace_min = floor(pace);
	pace_sec = (pace - pace_min) * 60;

	snprintf(pace_str, 5 * sizeof(char),
			(pace_sec < 10) ? "%.0f:0%.0f" : "%.0f:%.0f",
			pace_min, pace_sec);

	printf("%s\n", pace_str);

	return 1;
}
