import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;

public class September2018 {
    public class Participant {
        private String name;
        private String town;

        public Participant(String name, String town) throws Exception{
            if(name == null || name.isEmpty())
                throw new Exception("name must be non-null and non-empty");

            if(town == null || town.isEmpty())
                throw new Exception("town must be non-null and non-empty");

            this.name = name;
            this.town = town;
        }

        public String getName() {
            return name;
        }

        public String getTown() {
            return town;
        }

        @Override
        public String toString(){
            return name + town;
        }
    }

    public class Volunteer extends Participant{
        private int years;

        public Volunteer(String name, String town, int years) throws Exception {
            super(name, town);

            if(years <= 0)
                throw new Exception("Years should be strictly positive");

            this.years = years;
        }

        @Override
        public String toString(){
            return "Volunteer " + years + " years" + super.toString();
        }
    }

    public class Employee extends Participant {
        private String department;

        public Employee(String name, String town, String department) throws Exception {
            super(name, town);

            if(department == null || department.isEmpty())
                throw new Exception("Department must be non-null and non-empty");

            this.department = department;
        }

        @Override
        public String toString(){
            return "Employee " + department + super.toString();
        }
    }

    public class ONG{
        private List<Participant> participants;

        public ONG(List<Participant> participants){
            this.participants = participants;
        }

        public List<Participant> getAll(boolean volunteer){
            List<Participant> people = new ArrayList<>();
            if(volunteer) { // return all volunteers
                for(Participant p: participants)
                    if(p instanceof Volunteer)
                        people.add(p);
            }
            else {
                for(Participant p: participants)
                    if(p instanceof Employee)
                        people.add(p);
            }

            return people;
        }
    }

    // b.)
    public List<Volunteer> sortVolunteers(ONG ong){
        List<Participant> participants = ong.getAll(true);

        List<Volunteer> volunteers = new ArrayList<>();
        for(Participant p: participants)
            if(p instanceof Volunteer)
                volunteers.add((Volunteer)p);

        mergeSort(volunteers, 0, volunteers.size() - 1);
        return volunteers;
    }

    private void merge(List<Volunteer> volunteers, int left, int mid, int right) {
        List<Volunteer> temp = new ArrayList<>();
        int i = left;
        int j = mid + 1;

        while(i <= mid && j <= right){
            if(volunteers.get(i).getTown().compareTo(volunteers.get(j).getTown()) > 0){
                temp.add(volunteers.get(j));
                j++;
            }
            else{
                temp.add(volunteers.get(i));
                i++;
            }
        }

        while(i <= mid) {
            temp.add(volunteers.get(i));
            i++;
        }

        while(j <= right) {
            temp.add(volunteers.get(j));
            j++;
        }

        // copy temp to volunteers
        int k = 0; // pos in temp
        for(int t = left; t <= right; t++){
            volunteers.set(t, temp.get(k));
            k++;
        }
    }

    private void mergeSort(List<Volunteer> volunteers, int left, int right){
        if(left < right){
            int mid = left + (right - left) / 2;
            mergeSort(volunteers, left, mid);
            mergeSort(volunteers, mid+1, right);
            merge(volunteers, left, mid, right);
        }
    }

    // c.) town with max number of employees
    public static String townWithMaxNrEmployees(List<ONG> ongList){
        Map<String, Integer> map = new HashMap<>();
        for(ONG ong: ongList){
            List<Participant> employees = ong.getAll(false);
            for(Participant p: employees)
                if(map.containsKey(p.getTown()))
                    map.put(p.getTown(), map.get(p.getTown()) + 1);
                else map.put(p.getTown(), 1);
        }

        String maxTown = "";
        int maxCount = 0;
        for(Map.Entry<String, Integer> entry: map.entrySet()){
            if(entry.getValue() > maxCount){
                maxTown = entry.getKey();
                maxCount = entry.getValue();
            }
        }

        return maxTown;
    }

    // d.)
    public int numberOfEmployees(List<ONG> ongs) {
        int nr = 0;
        for(ONG ong: ongs){
            List<Participant> employees = ong.getAll(false);
            nr += employees.size();
        }

        return nr;
    }

    // e.)
    public static void main(String[] args) throws Exception {
        List<Participant> p1 = new ArrayList<>();
        p1.add(new Volunteer("V1", "T1", 1));
        p1.add(new Volunteer("V2", "T2", 2));
        p1.add( new Employee("E1", "T1", "D1"));

        ONG ong1 = new ONG(p1);

        List<Participant> p2 = new ArrayList<>();
        p2.add(new Volunteer("V3", "T3", 10));
        p2.add(new Employee("E2", "T1", "D2"));

        ONG ong2 = new ONG(p2);

        List<ONG> ongList = new ArrayList<>();
        ongList.add(ong1); ongList.add(ong2);

        // call b) for 2nd ong
        List<Volunteer> volunteers = sortVolunteers(ongList.get(1));
        for(Volunteer v: volunteers)
            System.out.println(v.toString());

        // c)
        String town = townWithMaxNrEmployees(ongList);
        System.out.println("Town with max nr employees: " + town);

        // d)
        int nrEmployees = numberOfEmployees(ongList);
        System.out.println("Number of employees in all ongs " + nrEmployees );

    }
}
