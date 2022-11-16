JSONObject json; 
JSONObject events;

JSONArray items;
JSONObject itemsObj;
long lastRefresh = 0; 

int M = month();      //month
int D = day();        //day
int Y = year();       //year
int Hr = hour();      //hour          
int Min = minute();   //minute
int Sec = second();   //second 
String AmPm;
PFont dateAndTime;
boolean mouseIsPressed;
boolean EventsDropDown = false;
boolean ActivityDropDown = false;
boolean HealthDropDown = false;
boolean NewsDropDown = false;
float Data;
int temp;
String icon_code;
String icon_url;
PImage icon;

color Red = color(255, 0, 0);
color Orange = color(255, 150, 0);
color Yellow = color(255, 255, 0);
color Green = color(0, 255, 0);
color Blue = color(0, 0, 255);
color Purple = color(150, 0, 255);
color Pink = color(255, 0, 255);
color White = color(255, 255, 255);
color[] colorArray;
color current_color;
int color_index = 0;



String weatherURL = "https://api.openweathermap.org/data/2.5/forecast?q=Lubbock,us&APPID=a1806f10985be19c0d54b738233b2034&units=imperial";
String location = "Lubbock, TX";
void setup() {
  size(700, 800);
  dateAndTime = createFont("Monospaced", 30);
  colorArray = new color[8];
  colorArray[0] = White;
  colorArray[1] = Red;
  colorArray[2] = Orange;
  colorArray[3] = Yellow;
  colorArray[4] = Green;
  colorArray[5] = Blue;
  colorArray[6] = Purple;
  colorArray[7] = Pink;
  current_color = colorArray[0];
  getData();
}

void draw() {
  background(current_color);
  fill(255, 255, 255);
  M = month();      //month
  D = day();        //day
  Y = year();       //year
  Hr = hour();      //hour          
  if (Hr > 12){
    Hr = Hr - 12;
    AmPm = "PM";
  }else{
    AmPm = "AM";
  }
  Min = minute();   //minute
  Sec = second();   //second 
  textSize(30);
  textAlign(CENTER);
  fill(255, 255, 255);
  rect(25, 10, 650, 765);

  fill(current_color);
  ellipse(70, 130, 70, 70); //Events
  ellipse(70, 220, 70, 70); //Mirror Time
  ellipse(70, 310, 70, 70); //Health
  ellipse(70, 400, 70, 70); //News
  ellipse(70, 490, 70, 70); //Light
  
  textSize(12);
  fill(0, 0, 0);
  text("Events", 70, 135);
  text("Activity", 70, 225);
  text("Health", 70, 315);
  text("News", 70, 405);
  text("Light", 70, 495);
   if (current_color != White){
    fill(current_color);
  }else{
    fill(0,0,0);
  }
  displayTime();
  displayDate();
  DrawWeather();
  
  PImage person = loadImage("person.png");
  person.resize(500,600);
  image(person, 110, 150);

  fill(0, 0, 0);

  textAlign(LEFT);
     if (mouseIsPressed && mouseX > 40 && mouseX < 90 && mouseY > 120 && mouseY < 170) {
        EventsDropDown = true;
        mouseIsPressed = false;
        }

    if (EventsDropDown == true) {
       fill(0, 0, 0);

       rect(30, 87, 280, 22);
       rect(30, 109, 280, 22);
       rect(30, 131, 280, 22);
       rect(30, 153, 280, 22);

       fill(255, 255, 255);
       getEvents();
        }

  if (mouseIsPressed && mouseX > 40 && mouseX < 90 && mouseY > 200 && mouseY < 240) {
        ActivityDropDown = true;
        mouseIsPressed = false;
        }

    if (ActivityDropDown == true) {
       fill(0, 0, 0);

       rect(30, 180, 90, 22);
       rect(30, 202, 90, 22);
       rect(30, 224, 90, 22);
       rect(30, 246, 90, 22);

       fill(255, 255, 255);
       textSize(12);

       text("Day: 30m", 35, 200, 240, 100);
       text("Night: 45m",35, 229, 240, 100);
        }
        
  if (mouseIsPressed && mouseX > 40 && mouseX < 90 && mouseY > 290 && mouseY < 330) {
        HealthDropDown = true;
        mouseIsPressed = false;
      }

    if (HealthDropDown == true) {
       fill(0, 0, 0);

       rect(30, 270, 200, 80);


       fill(255, 255, 255);
       textSize(12);

       getWeight();
      }
      
  if (mouseIsPressed && mouseX > 40 && mouseX < 90 && mouseY > 380 && mouseY < 420) {
        NewsDropDown = true;
        mouseIsPressed = false;
      }

    if (NewsDropDown == true) {
       fill(0, 0, 0);

       rect(30, 360, 580, 220);


       fill(255, 255, 255);
       textSize(12);

       getNews();
      }
      
  if (mouseIsPressed && mouseX > 40 && mouseX < 90 && mouseY > 470 && mouseY < 490) {
      mouseIsPressed = false;
        color_index++;
        if (color_index > 7){
          color_index = 0;
      }
      current_color = colorArray[color_index];
  }
}

//-----------------------------------------------------------
void displayDate() {
  String Ms = str(M);
  String Ds = str(D);
  String Ys = str(Y);
  String MDY = Ms + "/" + Ds+ "/" + Ys;

  textFont(dateAndTime);
  text(MDY, 120, 70);
}

//------------------------------------------------------------
void displayTime() {
  String Hrs = str(Hr);
  String Mins = str(Min);
  if (Mins.length() < 2) {
    Mins = "0" + Mins;
  }
  String Secs = str(Sec);
  if (Secs.length() < 2) {
    Secs = "0" + Secs;
  }
  String HMS = Hrs + ":" + Mins + AmPm;
  textSize(30);
  text(HMS, 120, 40);
  textFont(dateAndTime);
  
}

//------------------------------------------------------------
void mousePressed(){
  mouseIsPressed = true;
  EventsDropDown = false;
  ActivityDropDown = false;
  HealthDropDown = false;
  NewsDropDown = false;
}

void mouseReleased(){
  mouseIsPressed = false;
}

//-------------------------------------------------------------
void getData(){
  //float red_rand = random(20,255);
  //background(red_rand,0,0);
  
  json = loadJSONObject(weatherURL);
  //JSONObject weatherData = json.getJSONObject("main");
  JSONArray weatherArray = json.getJSONArray("list");
  JSONObject tempObj = weatherArray.getJSONObject(0);
  JSONObject main = tempObj.getJSONObject("main");
  JSONArray weather = tempObj.getJSONArray("weather");
  JSONObject weatherObj = weather.getJSONObject(0);
  icon_code = weatherObj.getString("icon");
  Data = main.getFloat("temp");
  temp = int(Data);
  icon_url = "http://openweathermap.org/img/w/"+icon_code+".png";
  icon = loadImage(icon_url);
}

//---------------------------------------------------------------
void DrawWeather(){
  textSize(20);
  text(location,600,40);
  textSize(40);
  text(temp+"F",600,80);
  image(icon, 500, 50);
}

//---------------------------------------------------------------
void getEvents(){
  json = loadJSONObject("events.json");
  items = json.getJSONArray("events");
  itemsObj = items.getJSONObject(0);
  String Event = itemsObj.getString("main");
   textSize(12);
   text(Event, 35, 92, 270, 100);
   itemsObj = items.getJSONObject(1);
   Event = itemsObj.getString("main");
   text(Event,35, 114, 270, 100);
   itemsObj = items.getJSONObject(2);
   Event = itemsObj.getString("main");
   text(Event, 35, 136, 270, 100);
}

//----------------------------------------------------------------
void getWeight(){
  json = loadJSONObject("health.json");
  items = json.getJSONArray("health");
  itemsObj = items.getJSONObject(0);
  int weight = itemsObj.getInt("weight");
  text("Current Weight: "+weight+"lbs", 35, 300);
  itemsObj = items.getJSONObject(1);
  weight = itemsObj.getInt("weight");
  text("Last Week: "+weight+"lbs", 35, 330);
}

//----------------------------------------------------------------
void getNews(){
  json = loadJSONObject("news.json");
  items = json.getJSONArray("news");
  itemsObj = items.getJSONObject(0);
  String article = itemsObj.getString("article");
  textSize(15);
  text(article, 35, 380);
  itemsObj = items.getJSONObject(1);
  article = itemsObj.getString("article");
  text(article, 35, 420);
  itemsObj = items.getJSONObject(2);
  article = itemsObj.getString("article");
  text(article, 35, 460);
  itemsObj = items.getJSONObject(3);
  article = itemsObj.getString("article");
  text(article, 35, 480, 510, 50);
  itemsObj = items.getJSONObject(4);
  article = itemsObj.getString("article");
  text(article, 35, 560);
}
