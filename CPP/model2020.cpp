#include <iostream>
using namespace std;
class B {
public:
    B() { cout << "B() "; }
    virtual void f() { cout << "B.f "; }
    void g() { f(); }
    virtual void h() { g(); }
};

class D : public B {
public:
    D() { cout << "D() "; }
    void f() { cout << "D.f "; }
    void h() { cout << "Function h ";  B::h(); }
};
int main() {
    B b{}; // B()
    D d{}; // B() D() bcs the constructor of the base class always gets called
    B& dd = d; // pointer to object d of type D
    b.g(); // B.f
    dd.h(); // Function h D.f bcs f() is virtual in B, so object of type d will use its own implementation of it

    // res: B() B() D() B.f Function h D.f
    return 0;
}