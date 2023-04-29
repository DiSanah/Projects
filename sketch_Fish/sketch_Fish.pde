int fishx = 400; 
int fishy = 400;
Fish nemo = new Fish(400, 400, 5);
ArrayList <Eda> ebas = new ArrayList<Eda>();  //I took a template from this websiteI took a template from this website: https://happycoding.io/tutorials/processing/arrayshttps: https://happycoding.io/tutorials/processing/arraylists
//as i understood array is used for holding multiple values//still i am sure i can not type this by myself without the template
//to create an arraylist we need to type: ArrayList<'name of existing class'> 'name of array' = new ArrayList<'name of existing class'>(); // 'new' is needed to call the constructor, which gives a new instance of the ArrayList class.



int score;
int gameOver;


void setup() {
  size( 800, 800); //size(width, height);
}


void draw() {
  //save the names in string to display them leter + that's more comfortable becouse the text located in one place
  String s = "score:" + score;
  String q = "Fish has drowned"; //this is part of 
  String f = "press 'f' to pay respects";

  //i can use easy for loops, but for harder ones i need example or trial to be seen// as from this site:https://happycoding.io/tutorials/processing/for-loops
  for (int i = 0; i <=30; i++) {  // integers 'i' (it is a standart leter for a loop, but it can be any), limitation of copies(here is 30,that will be created), i = i +1 (create 1 copy)) { 
    Eda e = new Eda(random(20, width - 20), random(-800, 0), 2); //random here is for making <food>(<eda>) appears is defferent positions
    ebas.add(e); //add 'e' form line above to the list
  }

  if (gameOver == 0) { //if (int gameOver;) equal to 0 - set colour (..., ..., ...);
    background(114, 188, 212);

    for (int i = 0; i <=30; i++) {  //this part of a code i asked engereers to give me hint, becouse the game does mot work properly
      ebas.get(i).display();       //this part of a code i do not fully understand //i see that we save the image/part of 'i'
    }

    for (int i = 0; i <=30; i++) {

      if (ebas.get(i).y >= height) {
        ebas.remove(i); //we remove saved image/part of 'i'
      }
    }




    nemo.move(); //call void move from player class
    nemo.display(); //call void display from player class
    textSize(20); 
    fill(0, 0, 0);
    text(s, 20, 20); //take 's' from string 's'


    for (int i = 0; i < 30; i++ ) {
      Eda food = ebas.get(i);
      //making collision
      if (nemo.fishx + 55 > food.x && nemo.fishx + 5 < food.x + 10 &&  //if fish x + 55 bigger than food x (that is changing becouse it falling) AND fish x less than food x + 10 AND ...
        nemo.fishy + 10 > food.y && nemo.fishy < food.y + 10)          //give limitation when collision will be counted down 
      {
        score ++; // if there is a collision we add 1 to the score
        ebas.remove(i);
      }
      if (nemo.fishx + 55 > food.x && nemo.fishx < food.x + 10 &&      //give limitation when collision will be counted down 
        nemo.fishy + 10 > food.y && nemo.fishy + 5 < food.y + 10) {
        score ++;
        ebas.remove(i);
      }
    }
    //description code to this part is below
    if (nemo.fishy > height) { //part with an easter egg
      gameOver = 1;
    }
  }

  if (gameOver == 1) {   //part with an easter egg
    background(0, 0, 0);
    fill(255, 255, 255);
    textSize(70);
    text(q, 100, 400); //text(text or string, coordinate x, coordinate y);
    textSize(50);      //can be like text("easter egg", x, y); but i have olredy used string for 'score' so i puted 'q' there as well
    text(f, 100, 600);
    if (keyPressed) {
      if (key == 'f'|| key == 'F') {
        nemo.fishy = 400;  
        gameOver = 0;
      }
    }
    //if fish goes behind the screen - increase 'gameOver' to 1 
    // if 'gameOver' equal to 1 - change backgroung to black and print a text from string 'q' and 'f'
    //if button on a keyboard pressed/ if 'f' letter pressed || (OR) 'F' 
    // i give position of fish 'y' be 400// middle of the screen
    // then just make 'gameOver' equal to 0// to repeat the process without restarting the game
    // if the fish y position will be bigger than height of the screen (for me it's 800) then show the massege and if 'f' is pressed make fish 'ressurect' in the middle of the the height
    //something like that
  }
}

//food
