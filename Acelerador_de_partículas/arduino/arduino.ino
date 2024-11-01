// ------------------------------------------------------------ //
const int Pin2 = 2; // Pin del sensor S1 de entrada
const int bobinaPin = 9;   // Pin para controlar la bobina
int ContadorVuelta = 0;
const float distanciaS1 = 0.5;

int sensorS1Pin;
unsigned long bobina;

unsigned long tiempoinicialS1;

unsigned long tiempofinalS1;

float velocidadS1;

void setup() {
  Serial.begin(9600);
  pinMode(sensorS1Pin, INPUT);
  pinMode(bobinaPin, OUTPUT);
}

void apagarS1() {
  // Tomar el tiempo de salida
  tiempofinalS1 = millis();
   // Apagar bobina
  digitalWrite(bobinaPin, LOW);
  // Calculo de la velocidad S1
  velocidadS1 = (distanciaS1 * 1000) / (tiempofinalS1 - tiempoinicialS1);
  ContadorVuelta += 1;

  Serial.print("tiempofinalS1: ");
  Serial.println(tiempofinalS1);
      
  Serial.print("Vuelta: ");
  Serial.println(ContadorVuelta);

  Serial.print("Velocidad S1: ");
  Serial.print(velocidadS1);
  Serial.println(" cm/s");
  bobina = 0;
}
void loop()
{ sensorS1Pin = digitalRead(Pin2);
  /*
  Serial.println("----------");
  Serial.print("Sensor: ");
  Serial.println(sensorS1Pin);
  Serial.print("Bobina: ");
  Serial.println(bobina);
  delay(1000);
  */
  if ((sensorS1Pin == 1) && (bobina == 0)){
      // El estado de la bobina 
     bobina = 1;
      // Tomar el tiempo de entrada
     tiempoinicialS1 = millis();
     Serial.print("Vuelta: ");
     Serial.println(ContadorVuelta);
     
     Serial.print("tiempoinicialS1: ");
     Serial.println(tiempoinicialS1);
     
  // Encender bobina
      digitalWrite(bobinaPin, HIGH);
  }
  if ((sensorS1Pin == 0) && (bobina == 1)){
  tiempofinalS1 = millis();
  // Apagar bobina
  bobina = 0;
  digitalWrite(bobinaPin, LOW);
  // Calculo de la velocidad S1
  velocidadS1 = (distanciaS1 * 1000) / (tiempofinalS1 - tiempoinicialS1);
  ContadorVuelta += 1;

  Serial.print("tiempofinallS1: ");
  Serial.println(tiempofinalS1);
      
  Serial.print("Velocidad S1: ");
  Serial.print(velocidadS1);
  Serial.println(" cm/s");

    } 
    }
// ------------------------------------------------------------ //
