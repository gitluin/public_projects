#include <stdio.h>
#include <ctype.h>
#include <string.h>

int
main(int argc, char* argv[]){
	char curr, letters[3];
	const char* conversions = "abcdefghijklmnopqrstuvwxyz";
	int output = 0;

	if (argc != 2){
		printf("Please provide 1 argument: \"[A-Z][A-Z]\"!\n");
		printf("Input will be truncated to two letters.\n");
		return 0;
	}

	snprintf(letters, 3 * sizeof(char), "%s", argv[1]);
	
	for (int i=0;i < strlen(letters);i++){
		curr = tolower(letters[i]);

		for (int j=0;j < strlen(conversions);j++){
			if (curr == conversions[j]){
				output += ((strlen(letters) > 1 && (i == 0))
						? ((j+1)*25 + j + 1) : (j + 1));

				break;
			}
		}
	}

	if (output == 0){
		printf("Something went wrong. Check what you've done.\n");
		return -1;
	}

	printf("%d\n", output);

	return 1;
}
