#include <iostream>
#include <string>
using namespace std;

class Animal {
public:
    virtual void speak() = 0;
};

class Dog : public Animal {
private:
    string name;
public:
    Dog(string n) : name(n) {}
    void speak() override {
        cout << name << " says Woof!" << endl;
    }
};

template <typename T>
T add(T a, T b) {
    return a + b;
}

enum Color { RED, GREEN, BLUE };

int main() {
    int x = 10, y = 20;
    double pi = 3.1415;
    char symbol = '#';
    bool isActive = false;
    string text = "Hello";

    x += y;
    y--;
    pi *= 2.0;
    isActive = (x != y) || (pi > 5.0);

    Dog d("Bruno");
    Animal* a = &d;
    a->speak();

    Color c = RED;
    switch (c) {
        case RED:
            cout << "Color is Red" << endl;
            break;
        case GREEN:
            cout << "Color is Green" << endl;
            break;
        case BLUE:
            cout << "Color is Blue" << endl;
            break;
        default:
            cout << "Unknown Color" << endl;
            break;
    }

    try {
        if (x > 100)
            throw runtime_error("Too big!");
    } catch (exception& e) {
        cout << "Caught exception: " << e.what() << endl;
    }

    for (int i = 0; i < 5; ++i) {
        cout << "i: " << i << endl;
    }

    int result = add<int>(5, 3);
    cout << "Result: " << result << endl;

    return 0;
}
