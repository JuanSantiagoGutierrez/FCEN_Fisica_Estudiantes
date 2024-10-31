// ------------------------------------------------------------ //
const int sensorS1Pin = 2; // Pin del sensor S1 de entrada
const int sensorS2Pin = 3; // Pin del sensor S2 de salida
const int bobinaPin = 9;    // Pin para controlar la bobina
int ContadorVuelta = 0;
int estadobobina = 0;
float DistanciaS1 = 1;
unsigned long tiempoInicioS1;
unsigned long tiempoInicioS2;

void setup() {
  Serial.begin(9600);
  pinMode(sensorS1Pin, INPUT);
  pinMode(sensorS2Pin, INPUT);
  pinMode(bobinaPin, OUTPUT);
  
  //attachInterrupt(digitalPinToInterrupt(sensorS1pin), encenderS1, RISING);
  attachInterrupt(digitalPinToInterrupt(sensorS2pin), encenderS2, RISING);
  //attachInterrupt(digitalPinToInterrupt(sensorS1Pin), apagarS1, FALLING); // Interrupción para S1-valor que interrumpe una acción-translate the actual digital pin to the specific interrupt number
  attachInterrupt(digitalPinToInterrupt(sensorS2Pin), apagarS2, FALLING); // Interrupción para S2
}
void encenderS1() {
  // Tomar el tiempo de entrada
  tiempoinicioS1 = millis();
  // Encender bobina
  digitalWrite(bobinaPin, HIGH);  
}
void apagarS1() {
  // Tomar el tiempo de salida
  tiempofinalS1 = millis();
   // Apagar bobina
  digitalWrite(bobinaPin, LOW);
  // Calculo de la velocidad S1
  velocidadS1 = (distanciaS1 * 1000) / (tiempofinalS1 - tiempoincialS1);
  ContadorVuelta += 1;

  Serial.print("Vuelta: ");
  Serial.println(ContadorVuelta);

  Serial.print("Velocidad S1: ");
  Serial.print(velocidadS1);
  Serial.println(" cm/s");
}
void encenderS2() {
  // Tomar el tiempo de entrada
  tiempoinicioS2 = millis();
}
void apagarS2() {
  // Tomar el tiempo de salida
  tiempofinalS2 = millis();
  // Calculo de la velocidad S1
  velocidadS2 = distanciaS1 / (tiempofinalS2 - tiempoincialS2);
  Serial.print("Velocidad S2: ");
  Serial.print(velocidadS2);
  Serial.println(" cm/s");
}
void loop() {
  if ((sensorS1pin = 1) && (estadobobina == 0)){
    encenderS1();
    delay(200)
    }
  if ((sensorS1pin == 0) && (estadobobina == 1)){
    apagarS1();
    }
}
// ------------------------------------------------------------ //