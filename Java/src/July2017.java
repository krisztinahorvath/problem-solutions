import java.util.List;
import java.util.ArrayList;

public class July2017 {
 public abstract class Fruit {
     boolean withSeeds;

     public Fruit(boolean withSeeds){
         this.withSeeds = withSeeds;
     }

     public abstract String getDescription();

     public boolean isWithSeeds(){
         return withSeeds;
     }
 }

 public class MelonLike extends Fruit{
     private double kg;

     public MelonLike(double kg, boolean withSeeds) throws Exception {
         super(withSeeds);

         if(kg <= 0)
             throw new Exception("Kg must be greater than 0");
     }

     @Override
     public String getDescription (){
         if(super.isWithSeeds())
             return kg + "melon like with seeds";
         else return kg + "melon like without seeds";
     }
 }

 public class Melon extends MelonLike {
     public Melon(double kg, boolean withSeeds) throws Exception {
         super(kg, withSeeds);
     }

     @Override
     public String getDescription() {
         return super.getDescription() + " melon";
     }
 }

 public class Watermelon extends MelonLike {
     public Watermelon(double kg, boolean withSeeds) throws Exception {
         super(kg, withSeeds);
     }

     @Override
     public String getDescription() {
         return super.getDescription() + " watermelon";
     }
 }

 public class Main {
     // b)
     public int getPosition(List<Fruit> fruitList, Fruit fruit){
         int left = 0;
         int right = fruitList.size() - 1;

         while(left <= right){
             int mid = (left + right)/2;

             String descripMid = fruitList.get(mid).getDescription();
             String fruitDescript = fruit.getDescription();

             if(descripMid.compareTo(fruitDescript) == 0) // fruit exists with same name
                 return mid;

             if(descripMid.compareTo(fruitDescript) > 0 && fruitList.get(mid + 1).getDescription().compareTo(fruitDescript) < 0){
                 return mid + 1;
             }

             if(descripMid.compareTo(fruitDescript) < 0) // str1 > str2
                 right = mid - 1;
             else if(descripMid.compareTo(fruitDescript) > 0) // str1 < str2
                 left = mid + 1;
         }

         return -1;
     }

     // c) insert
     public void insertIntoList(List<Fruit> fruitList, Fruit fruit){
        int pos = getPosition(fruitList, fruit);

        int n = fruitList.size() - 1;
        for(int i = n; i >= pos; i--)
            fruitList.set(i+1, fruitList.get(i));

        fruitList.set(pos, fruit);
     }

     // d)
     void printFruits(boolean withSeeds, List<Fruit> fruitList){
         if(withSeeds){
             for(Fruit f: fruitList)
                 if(f.isWithSeeds())
                     System.out.println(f.getDescription());
         }
         else{
             for(Fruit f: fruitList){
                 if(!f.isWithSeeds())
                     System.out.println(f.getDescription());
             }
         }
     }

     // e)
     public static void main(String[] args) throws Exception {
         List<Fruit> list = new ArrayList<>();
         list.add(new Watermelon(6, false));
         list.add(new Melon(10, true));
         list.add(new MelonLike(11, false));
         list.add(new Watermelon(13, true));

         // using c) insert a new watermelon without seeds having 12kg
         insertIntoList(list, new Watermelon(12, false));

         // using d) print fruits with seeds and then fruits without seeds
         printFruits(true, list);
         printFruits(false, list);
     }
 }
}
