#include <iostream>

class Contact {
private:
    std::string name;

public:
    virtual void sendMessage(std::string message) = 0;
    virtual std::string getName() {return this->name;}
};

class Person: public Contact{
private:
    std::string number;

public:
    void sendMessage(std::string message) override {
        
    }
};