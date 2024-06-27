//
// Created by krisz on 26.06.2024.
//

#include <bits/stdc++.h>

class MyObject {
public:
    virtual void print() = 0;
    virtual ~MyObject() {};
};

class MyInteger: public MyObject {
private:
    int value;

public:
    MyInteger(int val) { this->value = val;}
    void print() override {
        std::cout << value << " ";
    }
};

class MyString: public MyObject {
private:
    std::string value;

public:
    MyString(std::string val) {this->value= val;}
    void print() override {
        std::cout << value << " ";
    }
};

class MyObjectList {
private:
    std::vector<MyObject*> objects; // pointer so that the polymorphism works

public:
    MyObjectList() {}

    MyObjectList& add(MyObject* obj){ // & signifies that it returns a pointer and so that it allows method chaining
        objects.push_back(obj);
        return * this;
    }

    int size () {
        return objects.size();
    }

    MyObject* elemAtIndex(int index){
        return objects.at(index);
    }

    ~MyObjectList() {
        for(auto obj: objects)
            delete obj;
    }
};

class MyListIterator {
private:
    MyObjectList& list; // bcs holds a reference to the list
    int currentIndex;
public:
    MyListIterator(MyObjectList& l): list(l), currentIndex(0) {}

    bool isValid () {
        return currentIndex < list.size();
    }

    MyObject* element() {
        return list.elemAtIndex(currentIndex);
    }

    void next () {
        currentIndex++;
    }

    ~MyListIterator() = default;
};

void function()
{
    MyObjectList list{};
    list.add(new MyInteger{ 2 }).add(new MyString{ "Hi" });
    MyString* s = new MyString{ "Bye" };
    list.add(s).add(new MyString{ "5" });
    MyListIterator i{ list };
    while (i.isValid()) {
        MyObject* o = i.element();
        o->print();
        i.next();
    } // prints: 2 Hi Bye 5
}

int main () {
    function();
    return 0;
}