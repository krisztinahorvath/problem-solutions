#include <iostream>
#include <vector>

class Contact {
private:
    std::string name;

public:
    Contact(std::string name): name{name} {}
    virtual void sendMessage(std::string message) = 0;
    virtual std::string getName() {return this->name;}

    virtual ~Contact() = default;
};

class Person: public Contact{
private:
    std::string number;

public:
    Person(std::string name, std::string number): Contact(name), number(number) {}

    void sendMessage(std::string message) override {
        std::cout << Contact::getName() << " " << this->number << " " << message << std::endl;
    }
};

class Group: public Contact {
private:
    std::vector<Contact*> contacts;

public:
    Group(std::string name): Contact(name) {}

    void addContact(Contact* c){
        contacts.emplace_back(c);
    }

    void sendMessage(std::string message) override {
        for(auto c: contacts)
             c->sendMessage(message);
    }

    ~Group() override {
        for(auto c: contacts)
            delete c;
    }
};

int main() {
    auto p1 = new Person("Mother", "1");
    auto p2 = new Person("Father", "2");
    auto p3 = new Person("Jane", "3");
    auto p4 = new Person("John", "4");

    auto g1 = new Group("Parents");
    g1->addContact(p1);
    g1->addContact(p2);

    auto g2 = new Group("Family");
    g2->addContact(p1);
    g2->addContact(p2);
    g2->addContact(p3);

    g2->sendMessage("You are invited to my bday party this week!");
    p4->sendMessage("You are invited to my bday party this week!");

    return 0;
}
