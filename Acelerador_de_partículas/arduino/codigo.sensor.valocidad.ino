const int sensorS1Pin = 2; // Pin del sensor S1-cte, su valor no cambia
const int sensorS2Pin = 3; // Pin del sensor S2
const int bobinaPin = 9;    // Pin para controlar la bobina

volatile int objetoPasadoS1 = 0; // Contador de interrupciones para S1-volatile sirve para un dato que va directo a la RAM y no necesita ser computado. Una orden directa.
volatile int objetoPasadoS2 = 0; // Contador de interrupciones para S2
unsigned long tiempoInicioS1; // variable que debe "guardarse", contraria al attach
unsigned long tiempoInicioS2;

void setup() {
  Serial.begin(9600);
  pinMode(sensorS1Pin, INPUT);
  pinMode(sensorS2Pin, INPUT);
  pinMode(bobinaPin, OUTPUT);
  
  attachInterrupt(digitalPinToInterrupt(sensorS1Pin), interrupcionS1, FALLING); // Interrupción para S1-valor que interrumpe una acción-translate the actual digital pin to the specific interrupt number
  attachInterrupt(digitalPinToInterrupt(sensorS2Pin), interrupcionS2, FALLING); // Interrupción para S2
}

void loop() {
  // Medir velocidad con S1 y activar bobina
  if (objetoPasadoS1 > 0) {
    unsigned long tiempoFinalS1 = millis();
    unsigned long tiempoS1 = tiempoFinalS1 - tiempoInicioS1; 

    float distancia = 10.0; // Distancia en cm
    float velocidadS1 = distancia / (tiempoS1 / 1000.0); // Velocidad en cm/s

    Serial.print("Velocidad S1: ");
    Serial.print(velocidadS1);
    Serial.println(" cm/s");
    
    // Activar bobina
    digitalWrite(bobinaPin, HIGH);
    delay(200); // Mantener la bobina activa por 0.2s
    digitalWrite(bobinaPin, LOW); //para ingresar low or high
    
    objetoPasadoS1 = 0; // Reinicia el contador
  }

  // Medir velocidad con S2
  if (objetoPasadoS2 > 0) {
    unsigned long tiempoFinalS2 = millis();
    unsigned long tiempoS2 = tiempoFinalS2 - tiempoInicioS2;

    float distancia = 10.0; // Distancia en cm
    float velocidadS2 = distancia / (tiempoS2 / 1000.0); // Velocidad en cm/s

    Serial.print("Velocidad S2: ");
    Serial.print(velocidadS2);
    Serial.println(" cm/s");

    objetoPasadoS2 = 0; // Reinicia el contador
  }
}

void interrupcionS1() {
  if (objetoPasadoS1 == 0) {
    tiempoInicioS1 = millis(); // Guarda el tiempo de inicio para S1
  }
  objetoPasadoS1++; // Aumenta el contador para S1
}

void interrupcionS2() {
  if (objetoPasadoS2 == 0) {
    tiempoInicioS2 = millis(); // Guarda el tiempo de inicio para S2
  }
  objetoPasadoS2++; // Aumenta el contador para S2
}
