
class Fish {                                                           //variables of class below
  float fishx;
  float fishy;
  float speed;
  int condition;                                                         //variables that will be change if 'a' or 'd' pressed to illustrate that fish is turning in the direction of movement

  Fish(float fishx, float fishy, float speed) {                           //class Fish + constructor that takes four arguments from above
    this.fishx = fishx;                                                   //to reference a class variable
    this.fishy = fishy;                                                   //i got an error till find out from engeneers that i need to add 'this' so i read about it on the website and try to do the same as there
    this.speed = speed;//https://happycoding.io/tutorials/processing/creating-classes
    // how i understood 'this' is used when the class instance variable and method/constructor variable have the same names as it is for me// 
    //also to point to the class variables instead of the argument variables
  }

  void display() {
    fishy++;


    if (condition == 1) {         //here i say that when my int condition equal to 1 (that is happening if 'a' is pressed) then use that image?/fish possiotion/code
      //fish body right
      fill (255, 225, 77);
      quad(fishx-30, fishy, fishx, fishy-30, fishx+30, fishy-22, fishx-20, fishy);
      quad(fishx-30, fishy, fishx, fishy+30, fishx+30, fishy+22, fishx-20, fishy);
      fill(255, 225, 77);
      triangle(fishx+30, fishy, fishx+70, fishy-25, fishx+70, fishy+25);
      strokeWeight(3);
      line(fishx-30, fishy, fishx+15, fishy-25);
      line(fishx-30, fishy, fishx+15, fishy+25);
      strokeWeight(1.5);
      fill(255, 58, 65);
      ellipse( fishx, fishy, 100, 25);
      if (mousePressed) {
        fill(110, 226, 212);
        ellipse( fishx, fishy, 100, 25);
      }
      fill(0, 0, 0);
      circle( fishx-37, fishy+7, 7); 
      circle( fishx-37, fishy-7, 7);
    } 
    if (condition == 2) {         //here i say that when my int condition equal to 1 (that is happening if 'd' is pressed) then use that image?/fish possiotion/code
      //fish body left
      fill (255, 225, 77);
      quad(fishx+30, fishy, fishx, fishy-30, fishx-30, fishy-22, fishx+20, fishy);
      quad(fishx+30, fishy, fishx, fishy+30, fishx-30, fishy+22, fishx+20, fishy);
      fill(255, 225, 77);
      triangle(fishx-30, fishy, fishx-70, fishy-25, fishx-70, fishy+25);
      strokeWeight(3);
      line(fishx+30, fishy, fishx-15, fishy-25);
      line(fishx+30, fishy, fishx-15, fishy+25);
      strokeWeight(1.5);
      fill(255, 58, 65);
      ellipse( fishx, fishy, 100, 25);
      fill(0, 0, 0);
      if (mousePressed) {
        fill(110, 226, 212);
        ellipse( fishx, fishy, 100, 25);
      }
      fill(0, 0, 0);
      circle( fishx+37, fishy-7, 7); 
      circle( fishx+37, fishy+7, 7);
    }
  }

  void move() { //just make the fish move
    if (keyPressed) {
      if (fishy > 15) {     //don't let the fish disappear // 'if' below will work only when number of fish y is bigger than 15
        if (key == 'W'|| key == 'w' ) { //if 'w' OR 'W' are pressed then
          fishy-=2; //fishy = fishy - 2;
        }
      }

      if (key == 'S'|| key == 's') {
        fishy++; //fishy = fishy + 1;
      }
      if (fishx > 15) {      // 'if' below will work only when number of fish x is bigger than 15
        if (key == 'A'|| key == 'a') {
          fishx -= speed; 
          condition = 1; //here is where condition is changing// only if key pressed
        }
      }
      if (fishx < height -15) {
        if (key == 'D'|| key == 'd') {
          fishx += speed; 
          condition = 2; //here is where condition is changing// only if key pressed
        }
      }
    }
  }
}
