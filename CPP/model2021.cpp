#include <iostream>
using namespace std;
class Vehicle{
protected:
    double speed;
public:
    Vehicle(double ms){speed=ms;}
    virtual void go(){cout<<"Vehicle going ..."<<endl;}
    void accelerate(){cout<<"Vehicle accelerating..."<<endl;}
};
class Scooter:public  Vehicle{
public:
    Scooter(double s): Vehicle(s){}
    void go(){cout<<"Scooter going ..."<<endl;}
    void accelerate(int s) {cout<<"Accelerating with "<<s<<"..."<<endl;}
};
int main(){
    Scooter s(1);
    Vehicle& v=s; // reference to s, v of type vehicle, but it points to an object of type Scooter
    v.go(); // Scooter going ... bcs go() is virtual allowing for late binding
    v.accelerate(); // Vehicle accelerating  ..., accelerate() is not virtual, and Scooter doesn't override it

    // for non-virtual methods, the method corresp to the reference type is called regardless of the actual
    // object's type
    return 0;
}