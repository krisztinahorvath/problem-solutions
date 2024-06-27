#include <bits/stdc++.h>

class Person {
private:
    std::string surname;
    std::string firstname;
    int age;

public:
    Person() : surname(""), firstname(""), age(0) {}
    Person(std::string _surname, std::string _firstname, int _age):
        surname(_surname), firstname(_firstname), age(_age) {}

    std::string getSurname() const {return surname;}
    std::string getFirstname() const {return firstname;};
    int getAge() const {return age;}

    // just to check if it works
    void print() {
        std::cout << surname << " " << firstname << age << " " << std::endl;
    }

    ~Person() = default;
};

// ****** POINTERS ******
// for pointers: https://www.delftstack.com/howto/cpp/cpp-asterisk/
// * dereference, access the value pointed by the pointer
// & returns the memory address of a variable

// helper function to merge two halves
void merge(std::vector<Person>& arr, int left, int middle, int right, std::function<bool(const Person&, const Person&)> comp){
    std::vector<Person> temp(right - left + 1); // need a default constructor to use like this

    int i = left; // index in the first subarray
    int j = middle + 1; // index in the second subarray
    int k = 0; // index in the temporary array

    // merge the 2 subarrays
    while(i <= middle && j <= right) {
        if(comp(arr[i], arr[j]))
            temp[k++] = arr[i++];
        else
            temp[k++] = arr[j++];
    }

    // loop through the remaining elements
    while(i <= middle) {
        temp[k++] = arr[i++];
    }
    while(j <= right) {
        temp[k++] = arr[j++];
    }

    // copy the solution to the initial array
    k = 0;
    for(int t = left; t <= right; t++){
        arr[t] = temp[k++];
    }
}

// merge sort bcs WC O(n logn), quick sort has WC O(n^2)
void mergeSort(std::vector<Person>& persons, int left, int right, std::function<bool(const Person&, const Person& )> comp) {
    if(left < right){
        int middle = left + (right - left) / 2;
        mergeSort(persons, left, middle, comp);
        mergeSort(persons, middle + 1, right, comp);
        merge(persons, left, middle, right, comp);
    }
}

void sortPersons(std::vector<Person>& persons, std::function<bool(const Person&, const Person& )> comparator){
    mergeSort(persons, 0, persons.size() - 1,comparator);
}

// comparator functions
bool compareByName(const Person& p1, const Person& p2){
    if(p1.getSurname() < p2.getSurname())
        return true;

    return false;
}

bool compareByAge(const Person& p1, const Person& p2){
    if(p1.getAge() < p2.getAge())
        return true;

    return false;
}

bool compareByAgeAndName(const Person& p1, const Person& p2){
    if(p1.getAge() == p2.getAge())
        return p1.getSurname() < p2.getSurname();
    return p1.getAge() < p2.getAge();
}


int main () {
    std::vector<Person> persons;
    persons.emplace_back("John", "Doe", 28);
    persons.emplace_back("Jane", "Doe", 25);
    persons.emplace_back("Alice", "Smith", 28);
    persons.emplace_back("Alice", "Doe", 28);

    sortPersons(persons, compareByName);
    for(auto& person: persons)
        person.print();

    sortPersons(persons, compareByAge);
    for(auto& person: persons)
        person.print();

    sortPersons(persons, compareByAgeAndName);
    for(auto& person: persons)
        person.print();

    return 0;
}
