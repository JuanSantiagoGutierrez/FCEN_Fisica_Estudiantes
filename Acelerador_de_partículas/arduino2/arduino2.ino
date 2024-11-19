long tiempo_ini2=0;
long tiempo_fin2=0;
float velo2 = 0;
bool flag2=false;

long tiempo_ini3=0;
long tiempo_fin3=0;
float velo3 = 0;
bool flag3=false;

long Encendido = 0;

void setup() {
  Serial.begin(115200);
  pinMode(2,INPUT);
  pinMode(3,INPUT);
  attachInterrupt(0, sensor2, CHANGE);
  attachInterrupt(1, sensor3, CHANGE);
  pinMode(9, OUTPUT);
}

void loop() {
  if(flag2){
// ---------------- //
      cli();
      Encendido = map(velo2,100,1000,200,100);
    if (Encendido < 0)
      Encendido = 0;
    digitalWrite(9,HIGH);
    delay(Encendido);
    digitalWrite(9,LOW);
    sei();
// ---------------- //
    Serial.print("Velocidad2: ");
    Serial.println(velo2);
    flag2=false;
  }
  if(flag3){
    // ---------------- //
      cli();
    Encendido = map(velo3,100,1000,200,100);
    if (Encendido < 0) 
      Encendido = 0;
    digitalWrite(9,HIGH);
    delay(Encendido);
    digitalWrite(9,LOW);
    sei();
    Serial.print("Encendido2: ");
    Serial.println(Encendido);
    Serial.print("Encendido3: ");
    Serial.println(Encendido);
// ---------------- //
    Serial.print("Velocidad3: ");
    Serial.println(velo3);
    flag3=false;
  }
}

void sensor2(){
  delayMicroseconds(100);
  int estado2 = digitalRead(2);
  if( estado2 == HIGH ){
    tiempo_ini2 = millis();
  }
  else{
    tiempo_fin2 = millis();
    tiempo_fin2 = tiempo_fin2 - tiempo_ini2;
    velo2 = 18.0/tiempo_fin2*1000;
    flag2=true;
  }
}

void sensor3(){
  delayMicroseconds(100);
  int estado3 = digitalRead(3);
  if( estado3 == HIGH ){
    tiempo_ini3 = millis();
  }
  else{
    tiempo_fin3 = millis();
    tiempo_fin3 = tiempo_fin3 - tiempo_ini3;
    velo3 = 18.0/tiempo_fin3*1000;
    flag3=true;
  }
}