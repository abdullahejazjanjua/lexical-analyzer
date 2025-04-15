#include <iostream>
#include <string>
#define MAX

using namespace std;

/* This is a
   multi-line comment
   spanning several lines */

double calculateArea(double length, double width) {
    return length * width;
}

int main() {
    char grade = 'A';
    string message = "Hello World";
    int numbers[5] = {1, 2, 3, 4, 5};
    
    for (int i = 0; i < 5; i++) {
        if (numbers[i] <= 3) {
            // Skip small numbers
            continue;
        }
        cout << numbers[i] << endl;
    }
    
    return 0;
}