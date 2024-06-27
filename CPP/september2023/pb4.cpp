#include <string>
#include <vector>
#include <iostream>
#include <algorithm>

class Product {
private:
    std::string name;
    int baseprice;

public:
    Product(const std::string& name, int baseprice): name{name}, baseprice{baseprice} {}

    virtual int total_price() {
        return this->baseprice;
    }

    virtual std::string toString() {
        return this->name;
    }

    virtual ~Product() {}
};

class Computer: public Product {
private:
    int tax;

    // A: missing code
public:
    Computer(const std::string& name, int baseprice, int tax): Product(name, baseprice), tax{tax} {}

    int total_price() override {
        return this->tax + Product::total_price();
    }

    std::string toString() override {
        return Product::toString() + "," + std::to_string(total_price());
    }
};

class SorterByTotalPrice {
    // B: missing code
private:
    static bool compareFunction(Product* a, Product* b){
        return (a->total_price() > b->total_price()); // uses computer compare bcs polymorphism & override
    }
public:
    static void sort(std::vector<Product*>& computers) {
        std::sort(computers.begin(), computers.end(), compareFunction);
    }
};

int main(){
    std::vector<Product*> computers{new Computer{"HC90", 140, 10},
                                    new Computer{"HC91", 100, 12},
                                    new Computer{"HC85", 150, 15}};

    SorterByTotalPrice::sort(computers);
    std::cout << computers[0]->toString() << std::endl;
    std::cout << computers[1]->toString() << std::endl;
    std::cout << computers[2]->toString() << std::endl;
    for(auto c:computers)
        delete c;

    return 0;
}