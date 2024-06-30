#include <bits/stdc++.h>
using namespace std;

class Vehicle {
private:
    int basePrice;

public:
    Vehicle(int basePrice){
        if(basePrice <= 0)
            throw invalid_argument("Base price must be greater than 0 ");

        this->basePrice = basePrice;
    }

    virtual string description() = 0;

    virtual int getPrice() {
        return basePrice;
    }

    virtual ~Vehicle() {};
};

class Car: public Vehicle{
private:
    string model;

public:
    Car(int basePrice, string model): Vehicle(basePrice) {
        if(model.empty())
            throw invalid_argument("Model must be non-null and non-empty");

        this->model = model;
    }

    string description() override {
        return model;
    }
};

class AutomaticCar: public Car{
private:
    int additionalPrice;

public:
    AutomaticCar(int basePrice, string model, int additionalPrice): Car(basePrice, model) {
        if(additionalPrice <= 0)
            throw invalid_argument("Additional price must be strictly positive.");

        this->additionalPrice = additionalPrice;
    }

    int getPrice() override {
        return Car::getPrice() + additionalPrice;
    }

    string description() override {
        return "Automatic car " + Car::description();
    }
};

class CarWithParkingSensor: public Car {
private:
    string sensorType;

public:
    CarWithParkingSensor(int basePrice, string model, string sensorType): Car(basePrice, model) {
        if(sensorType.empty())
            throw invalid_argument("sensor type must be non-null and non-empty");

        this->sensorType = sensorType;
    }

    int getPrice() override {
        return Car::getPrice() + 2500;
    }

    string description() override {
        return "Car with parking sensor " + sensorType + " " + Car::description();
    }
};

// b)
unordered_map<string, int> carModels(vector<Vehicle*> vehicles){
    unordered_map<string, int> map;

    for(auto& v: vehicles){
        Car* car = dynamic_cast<Car*>(v);
        map[car->description()]++;
    }

    return map;
}

// c)
void rearrange_list(vector<Vehicle*>& cars){
    // 2 pointer method maybe idk, brain left the chat, good luck.

//    int i = 0;  // pos of cars < 1000 or > 2000
//    int j = 1; // price in [1000, 2000]

//    int j = -1;
//
//
////    while (i < j && j < )
//
//    for(int i = 0; i < cars.size(); i++) {
//        int price = cars[i]->getPrice();
//        if(price < 1000 || price > 2000 ){
//            if(j != -1)
//                j = i;
//            else if (j != i){
//                swap(cars[i], cars[j]);
//            }
//        }
//    }
}

// d)
void printDescriptions(vector<Vehicle*> list){
    for(auto v: list){
        cout << v->description() << endl;
    }
}

// e)
int main() {
    vector<Vehicle*> cars;
    cars.push_back(new Car(2000, "Audi" ));
    cars.push_back(new AutomaticCar(2000, "Audi", 890));
    cars.push_back(new Car(1400, "Toyota"));
    cars.push_back(new AutomaticCar(4500, "Mercedes", 1200));
    cars.push_back(new CarWithParkingSensor(2500, "Opel", "sensor1"));

    // call b)
    unordered_map<string, int> map = carModels(cars);
    for(auto& model: map)
        cout << "Model: " << model.first << " No. cars: " << model.second << endl;

    // call c)
    rearrange_list(cars);
    printDescriptions(cars);

    for(auto& v: cars)
        delete v;

    return 0;
}

// f) for the List data type I used vector<T> from STL which functions the same way as an array
// Operations:
// vector<Vehicle*> cars - initializes an empty vector of Vehicle objects
// cars.push_back(car) - adds a new vehicle to the list in O(1)
// for(auto& v: cars) - iterate over Vehicle type objets in O(n)

