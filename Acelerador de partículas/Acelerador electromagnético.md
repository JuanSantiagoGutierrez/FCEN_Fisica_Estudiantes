***ACELERADOR ELECTROMAGNÉTICO DE MACRO-PARTICULAS***

*OBJETIVO*  
Mostrar el funcionamiento de un acelerador de particulas electromagnético, con los principios teóricos que conllevan su funcionamiento y a su vez la adquisición de conocimientos sobre electrónica y aplicaciones de las tecnologías. En base a un modelo sencillo y visualizable. Se ha optado por un acelerador pequeño de 10cm de radio.

**Diseño**  
Las partes que conforman a este proyecto son
- El riel 
- La bobina
- El sensor 
- Una placa de control

1. El riel: Canal circular de 10cm de radio para contener a la partícula por un camino circular. 
Este riel se diseño en OpenSCAD e imprimió en 3D.


2. La bobina: Equipo que contiene alambre de cobre galvanizado para entregar la energía cinética a la partícula. 
Diseñada en OpenSCAD e impresa en 3D.
Material para la bobina: 
    - Cobre esmaltado cant: ???
    - Diodo para eliminar la sobre-tensión


3. El sensor: Equipo electrónico que detectará el paso de la partícula a través del riel, dará la instrucción para el encendido de la bobina.
Diseñado en papel y armado con material electrónico. 
Material para el sensor: 

    - LED infrarojo especificaciones: 5mm de diametro
    - LED foto-receptor especificaciones: 5mm de diametro

Esquema del circuito: 
    - insertar imagen


4. La placa de control y alimentación: Equipo electrónico que al recibir la señal del sensor otorgará suficiente corriente a la bobina para su funcionamiento. 

Material para el control: 
    - Fuente V = ?? 
    - Transistor para recepción de señal y paso de corriente
    - 

Herramientas: Arduino
