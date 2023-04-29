//I know this is a noodle code or even frankenstein code, but it works and i am happy with that

let lines = [];
let notes = [];
let lyreY = 140;
let score = 0;
let lastSpawnTime = 0;
let isPaused = false;
let showMenu = false;
let endGame = false; 
let lastCommandTime = 0;
let lastClassificationTime = 0; // IMG
const delayTime = 1000; // 1 second

let Vclassifier; // VoiceRec
let IMGclassifier; 


const options = { probabilityThreshold: 0.9 };
const optionsIMG = { probabilityThreshold: 0.9 };


// Label
let label = 'listening...';

// Teachable Machine model URL:
let soundModel = 'https://teachablemachine.withgoogle.com/models/7K6A9z6sy/';
let imageModelURL = 'https://teachablemachine.withgoogle.com/models/ePDGT2Dkp/';

let video;
let flippedVideo;
// To store the classification
let IMGlabel = "";

// Time of last command

function preload() {
  // Load the model
  Vclassifier = ml5.soundClassifier(soundModel + 'model.json');
  IMGclassifier = ml5.imageClassifier(imageModelURL + 'model.json');
  //soundFormats('mp3', 'ogg');
  //sound1 = loadSound('sound/success.mp3'); // my sound for colecting the note
  //soundFormats('mp3', 'ogg');
  //sound2 = loadSound('sound/negative-beeps.mp3'); // my sound for missing the note
  
}

function setup() {
  createCanvas(640, 480);
  Vclassifier.classify(gotResult, optionsIMG);
  textSize(32);
  stroke(255);
  
  video = createCapture(VIDEO);
  video.size(160, 120);
  video.hide();
  
  flippedVideo = ml5.flipImage(video);
  setInterval(classifyVideo, 0); // classify every 1 second
}

function draw() {
  background(0);
  
  image(flippedVideo, 480, 360); // video 
  
  
    for (let i = 0; i < 5; i++) {
    let y = height / 2 + (i - 2) * 50;
    lines.push(y);
  }
  
  stroke(255);
  for (let i = 0; i < lines.length; i++) {
    line(0, lines[i], width, lines[i]);
  }
  
  if (!isPaused) { // Check if game is not paused
    if (millis() - lastSpawnTime > 3000) {
      spawnNote();
      lastSpawnTime = millis();
    }
    
    for (let i = 0; i < notes.length; i++) {
      let note = notes[i];
      note.x -= 3;
      note.show();
      if (note.hitsLeftEdge()) {
        gameOver();
        break;
      }
      for (let j = 0; j < lines.length; j++) {
        if (note.isCaught(lines[j])) {
          notes.splice(i, 1);
          score++;
          break;
        }
      }
    }
  }
  
  // Display notes when game is paused
  if (isPaused) {
    for (let i = 0; i < notes.length; i++) {
      let note = notes[i];
      note.show();
    }
  }

  // Check if enough time has passed since last command
  if (millis() - lastCommandTime < 3000) {
    fill(255);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Please wait...", width / 2, height / 2 + 160);
  }

  fill(255,255,0);
  noStroke();
  ellipse(50, lyreY, 30, 30);

  fill(255);
  textSize(32);
  text(score, width - 50, 50);
  
  if (isPaused) {
    showMenu = true;
    noLoop();
    fill(255);
    rect(width / 4, height / 2 - 150, width / 2, 300);
    fill(0);
    text('Game is paused', width / 2, height / 2 - 50);
    fill(0);
    textSize(28);
    text('Say "Play" to restart', width / 2, height / 2 + 50);
  } else {
    showMenu = false;
    loop();
  }
  
 
}




// Get a prediction for the current video frame
function classifyVideo() {
  if (millis() - lastClassificationTime > 500) {
    lastClassificationTime = millis();
    flippedVideo = ml5.flipImage(video)
    IMGclassifier.classify(flippedVideo, optionsIMG, IMGgotResult);
    flippedVideo.remove();
  }
}

// When we get a result
function IMGgotResult(error, results) {
  // If there is an error
  if (error) {
    console.error(error);
    return;
  }
  IMGlabel = results[0].label;
  console.log(IMGlabel);
  arrows();
}

function arrows() {
  // Only update lyre position if game is not paused
  if (!isPaused && !endGame) {
    if (IMGlabel == "Up" || key === 'w' || key === 'ArrowUp' ) {
       lyreY -= 50;
       lyreY = constrain(lyreY, 140, 340);
    } else if (IMGlabel == "Down" || key === 's' || key === 'ArrowDown') {
        lyreY += 50;
        lyreY = constrain(lyreY, 140, 340);
    }
  }
}

function wordSaid() {
  if (!endGame) {
    if (label == "Stop" || key === 'q' || key === 'Q') { // Pause game
      isPaused = true;
      showMenu = true;
    } else if (label == "Play" || key === 'a' || key === 'A') { // Unpause game
      if (endGame) { // Check if game is over
        // Reset game variables
        score = 0;
        notes = [];
        lastSpawnTime = 0;
        endGame = false;
        // Restart game loop
        loop();
      } else {
        // Unpause game
        isPaused = false;
        showMenu = false;
        loop();
      }
    }
  }
}






class Note {
  constructor(y) {
    this.x = width;
    this.y = y;
    this.sound = loadSound('sound/success.mp3'); // load the sound file
  }

  show() {
    fill(255, 0, 0);
    noStroke();
    ellipse(this.x, this.y, 20, 20);
  }

  hitsLeftEdge() {
    return this.x < 0;
  }

  isCaught(y) {
    let caught = abs(this.y - y) < 30 && dist(this.x, this.y, 50, lyreY) < 30;
    if (caught) {
      this.sound.play(); // play the sound file when a note is caught
    }
    return caught;
  }
}

function spawnNote() {
  let y = random(lines);
  notes.push(new Note(y));
}

// The model recognizing a sound will trigger this event
function gotResult(error, results) {
  if (error) {
    console.error(error);
    return;
  }
  if (results[0].label !== 'background_noise') {
    label = results[0].label;
    if (millis() - lastCommandTime > delayTime) {
      wordSaid(label);
      lastCommandTime = millis();
    }
  }
}

// Game over function
function gameOver() {
  endGame = true;
  loop();
  fill(255);
  rect(width / 4, height / 2 - 150, width / 2, 300);
  fill(0);
  text('Game over! Score: ' + score, width / 2, height / 2 - 50);
  fill(0);
  textSize(28);
  text('Say "Play" to restart', width / 2, height / 2 + 50); 
  
  if (label == "Play" || key === 'a' || key === 'A') { // Unpause game
      if (endGame) { // Check if game is over
        // Reset game variables
        score = 0;
        notes = [];
        lastSpawnTime = 0;
        endGame = false;
        // Restart game loop
        loop();
      }
    }
  }
