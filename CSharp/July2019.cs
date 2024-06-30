namespace CSharp
{
    public abstract class RailCar
    {
        private string name;
        private RailCar next;

        public abstract bool isProfitable();
        public abstract string toString();


    }

    public class PassengerCar: RailCar
    {
        private int capacity;

    }

    public class RestaurantCar : RailCar
    {
        private int numberOfTables;

        public override bool isProfitable() {
            return true;
        }

        public override string toString()
        {
            throw new NotImplementedException();
        }


    }
}
