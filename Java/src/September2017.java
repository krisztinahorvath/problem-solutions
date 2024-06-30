import java.util.ArrayList;
import java.util.List;

public class September2017 {
    public class Pizza {
        private String description;
        private int basePrice;

        Pizza(String description, int basePrice) throws Exception {
            if(description == null || description.isEmpty())
                throw new Exception("Description must be a non-null and non-empty");

            if(basePrice <= 0)
                throw new Exception("BasePrice must be a strictly positive integer.");

            this.description = description;
            this.basePrice = basePrice;
        }

        public String getDescription() {
            return description;
        }

        public int getPrice () {
            return basePrice;
        }
    }

    public class PizzaWithIngredients extends Pizza {
        private int ingredientsPrice;

        PizzaWithIngredients(String description, int basePrice, int ingredientsPrice) throws Exception {
            super(description, basePrice);

            if(ingredientsPrice <= 0)
                throw new Exception("IngredientsPrice must be strictly positive");

            this.ingredientsPrice = ingredientsPrice;
        }

        @Override
        public String getDescription(){
            return super.getDescription() + " + ingredients";
        }

        @Override
        public int getPrice() {
            return super.getPrice() + ingredientsPrice;
        }
    }

    public class Main {
        // b concat 2 sorted lists keeping the sorted property
        public static List<Pizza> concatenateLists(List<Pizza> list1, List<Pizza> list2){
            List<Pizza> list3 = new ArrayList<>();

            int i = 0, j = 0; // indexes for list1 & list2
            int k = 0; // index for list3
            while (i < list1.size() && j < list2.size()){
                if(list1.get(i).getPrice() > list2.get(j).getPrice()){
                    list3.add(k, list1.get(i));
                    i++;
                }
                else {
                    list3.add(k, list2.get(j));
                    j++;
                }
                k++;
            }

            while( i < list1.size()){
                list3.add(list1.get(i));
                i++;
            }

            while(j < list2.size()){
                list3.add(list2.get(j));
                j++;
            }

            return list3;
        }

        // c) => insertion sort
        public static void sortList(List<Pizza> pizzaList){
            for(int i = 1; i < pizzaList.size(); i++){
                Pizza currentElement = pizzaList.get(i);
                int j = i - 1;
                while(j >= 0 && pizzaList.get(i).getPrice() < currentElement.getPrice()){
                    pizzaList.set(j+1,pizzaList.get(j));
                    j--;
                }
                pizzaList.set(j+1, currentElement);
            }
        }

        // d
        public static void printPizzaList(List<Pizza> pizzaList){
            int sumPrices = 0;
            for(Pizza p: pizzaList){
                sumPrices = p.getPrice();
                System.out.println(p.getDescription() + " " + p.getPrice() + "\n");
            }
            System.out.println("Total price: " + sumPrices);
        }

        // e
        public static void main(String[] args){
            try{
                List<Pizza> list1 = new ArrayList<>();
                list1.add(new Pizza("Pizza1", 10));
                list1.add(new Pizza("Pizza2", 20));
                list1.add(new PizzaWithIngredients("Pizza with ingr1", 8, 20));

                List<Pizza> list2 = new ArrayList<>();
                list2.add(new Pizza("Pizza3", 18));
                list2.add(new PizzaWithIngredients("Pizza with ingr2", 10, 19));
                list2.add(new PizzaWithIngredients("Pizza with ingr3", 20, 14));

                // sort using c)
                sortList(list1);
                sortList(list2);

                // concat using b)
                List<Pizza> mergedList = concatenateLists(list1, list2);
                printPizzaList(mergedList);
            }
            catch (Exception e){
                System.out.println(e.getMessage());
            }
        }

        //   f) describe the specifications of the used list operations
        // List<T> list = new ArrayList<>(); creates a new empty list
        // add(elem) - adds a new element to the list
        //           - O(1) adds to the back of the list
        // add(index, elem) - adds a new element to the position specified by index in the list
        //                  - O(1)
        // size() - returns the size of the list
        // get(index) - returns the element on position index in the list
        //            - O(1)
        // set(index, newElement) - sets element at position index to newElement
    }
}
