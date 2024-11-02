// ------------------------------------------------------------ //
const int Pin2 = 2; // Pin del sensor Primario S1
const int Pin3 = 3; // Pin del sensor Secundario S2
const int bobinaPin = 9;   // Pin para controlar la bobina
int ContadorVuelta = 0;
const float distanciaS1 = 0.5; // Tamaño del objeto que pasa por delante del sensor en centimetros
const float distancia_entre_sensores = 3.5; // longitud de arco entre los sensores, 3.5cm = pi*10/9 

int sensorS1Pin;  // Valores para la lectura
int sensorS2Pin;
unsigned long bobina;  // Valores de espera para el cambio de estado
unsigned long bobina2;

unsigned long tiempoinicialS1;  // Tiempos de lectura
unsigned long tiempoinicialS2;
unsigned long tiempofinalS1;
unsigned long tiempofinalS2;

float velocidadS1;  // Velocidades media en los sensores
float velocidadS2;

float aceleracion; // Aceleración experimentada 
int mediraceleracionS1 = 0;
int mediraceleracionS2 = 0;

void setup() {
  Serial.begin(9600);
  pinMode(Pin2, INPUT);
  pinMode(Pin3, INPUT);
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
  sensorS2Pin = digitalRead(Pin3);
  /*
  Serial.println("----------");
  Serial.print("Sensor: ");
  Serial.println(sensorS1Pin);
  Serial.print("Bobina: ");
  Serial.println(bobina);
  delay(1000);
  */
  if ((sensorS1Pin == 1) && (bobina == 0)){
      // El estado de la bobina + encendido
     digitalWrite(bobinaPin, HIGH);
     bobina = 1;
      // Tomar el tiempo de entrada e informar
     tiempoinicialS1 = millis();
     Serial.print("Vuelta: ");
     Serial.println(ContadorVuelta);
     Serial.print("tiempoinicialS1: ");
     Serial.println(tiempoinicialS1);
    }
  if ((sensorS1Pin == 0) && (bobina == 1)){
    tiempofinalS1 = millis();
    // Apagar bobina
    digitalWrite(bobinaPin, LOW);
    bobina = 0;

    // Calculo de la velocidad S1
    velocidadS1 = (distanciaS1 * 1000) / (tiempofinalS1 - tiempoinicialS1);
    ContadorVuelta += 1;

    Serial.print("tiempofinallS1: ");
    Serial.println(tiempofinalS1);
      
    Serial.print("Velocidad S1: ");
    Serial.print(velocidadS1);
    Serial.println(" cm/s");
    mediraceleracionS1 = 1;
    }
    // Sensor 2
  if ((sensorS2Pin == 1) && (bobina2 == 0)){
      // El estado de la bobina 
     bobina2 = 1;
      // Tomar el tiempo de entrada
     tiempoinicialS2 = millis();
     
     Serial.print("tiempoinicialS2: ");
     Serial.println(tiempoinicialS2);
    }
  if ((sensorS1Pin == 0) && (bobina2 == 1)){
    tiempofinalS2 = millis();
    // Apagar bobina
    bobina2 = 0;
    // Calculo de la velocidad S1
    velocidadS2 = (distanciaS1 * 1000) / (tiempofinalS2 - tiempoinicialS2);
  
    Serial.print("tiempofinallS2: ");
    Serial.println(tiempofinalS2);
      
    Serial.print("Velocidad S2: ");
    Serial.print(velocidadS2);
    Serial.println(" cm/s");
    mediraceleracionS2 = 1;
    }  
  if (((sensorS2Pin == 0) && (sensorS1Pin == 0)) && ((mediraceleracionS1 == 1) && (mediraceleracionS2 == 1))){
    mediraceleracionS1 = 0;
    mediraceleracionS2 = 0; 
    aceleracion = (( (velocidadS2) * (velocidadS2))-( (velocidadS1) * (velocidadS1) ) )/ (2 * distancia_entre_sensores);
    Serial.print("aceleracion: ");
    Serial.println(aceleracion);
  }
}
// ------------------------------------------------------------ //
