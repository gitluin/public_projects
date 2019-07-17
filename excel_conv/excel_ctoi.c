// A program for converting the provided Excel column letter to a column number

#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main(int argc, char* argv[]){
	char* let = argv[1];
	char* conversions = "abcdefghijklmnopqrstuvwxyz";
	int output = 0;

	if (argc != 2){
		printf("Please provide one string!\n");
		return 1;
	}
	
	if (strlen(let) > 2){
		printf("You provided too many letters!\n");
		return 1;
	}

	// For each letter we were provided
	for (int i=0;i < strlen(let);i++){
		char curr = tolower(let[i]);

		// Find the index that corresponds in conversions
		for (int j=0;j<strlen(conversions);j++){
			if (curr == conversions[j]){
				if ((strlen(let) > 1) && (i == 0)){
					output += (j+1)*25 + j + 1;
					break; 
				}
				output += j + 1;
				break;
			}
		}
	}

	if (output == 0){
		printf("Something went wrong, was about to output 0. Check what you've done.\n");
		return 1;
	}

	printf("%d\n",output);

	return 0;
}
