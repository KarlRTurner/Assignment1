class Registered
{
  String  type;
  int[] amount;
  
  Registered(String numbers)
  {
    amount =new int[18];
    String[] number = numbers.split(",");
    
      type = number[0];
      for (int i=1; i<number.length; i++)
      {
         amount[i-1] = Integer.parseInt(number[i]);
      }
  }
}
