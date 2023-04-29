 class Eda { //create a class named "food"  
  float x; 
  float y;
  float speed;
  
  
  Eda(float x, float y, float speed){ //same description as for 'player' class
   this.x = x;                        //just different variables 
   this.y = y;
   this.speed = speed;
  }
  
  void display(){    //show food
    fill(0,0, 255);
    ellipse(x, y, 20, 20);
    y ++ ; //made it fall by increasing y 
  }
 }
