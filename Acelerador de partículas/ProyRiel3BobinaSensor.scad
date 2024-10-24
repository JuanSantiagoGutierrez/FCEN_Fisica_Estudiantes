$fn=100;

//Parametros
abertura_riel= 10; // Radio de abertura
angle_gen_anillo = 90; // Ángulo generado del riel , recomendado "90"
radio_anillo = 100 ; // Longitud desde el centro de curvatura y el eje del riel
angulo_bobina = 17 ; // Ángulo generado de la bobina 
radio_bobina = 24 ; // Tamaño de la bobina 
angle_abertura = 35; // Ángulo de inclinación del corte del riel y la inclinación del sensor 

angle_posicion_sensor = 45 ; // Posición del sensor en la circunferencia , recomendado "[5, 85]"
largo_led = 7 ; // Dimensión del LED [Valor del LED + 1mm]
abertura_sensor = 2.75; // Radio del sensor [Valor del LED + 0.25]
contenedor_sensor = 5; // Radio del contenedor del sensor , por lo menos 2mm más de la abertura
// radio_bobina no debe superar la mitad del radio_anillo.

lado = 31 ; // Dimensión del riel

//
module bobina(){
    difference(){
        union(){
            rotate_extrude(angle=angulo_bobina,convexity=10)translate([radio_anillo,0,0])circle(r=radio_bobina); 
            difference(){
                rotate_extrude(angle=angulo_bobina,convexity=10)translate([radio_anillo,0,0])circle(r=1.65*radio_bobina);
                rotate([0,0,1])rotate_extrude(angle=angulo_bobina-2,convexity=10)translate([radio_anillo,0,0])circle(r=2*radio_bobina);
                }
            }
        difference(){
            rotate([0,0,-1])rotate_extrude(angle=angulo_bobina+2,convexity=10)translate([radio_anillo,0,0])square(lado+2, center=true);   
            difference(){
                rotate([0,0,-1])rotate_extrude(angle=angulo_bobina+2,convexity=10)translate([radio_anillo,0,0])circle(r=lado);
                rotate([0,0,-1])rotate_extrude(angle=angulo_bobina+2,convexity=10)translate([radio_anillo,0,0])circle(r=radio_bobina-4);
                }
            }
        }
    }
//
module riel2_bruto() {
    difference(){
        difference(){
            union(){
                //Encastre macho y pieza base
                translate([-6,100+lado/3.3,-lado/3]) rotate([0, 90, 0]) cube([lado/6,lado/6,12]);
                translate([-6,100-lado/2.1,-lado/3]) rotate([0, 90, 0]) cube([lado/6,lado/6,12]);
                rotate_extrude(angle=angle_gen_anillo,convexity=10)  translate([radio_anillo,0,0]) square([lado,lado],   center=true);
                }
                //Redondeado del riel
            difference(){
                rotate_extrude(angle=angle_gen_anillo+10,convexity=10) translate([radio_anillo,0,0]) circle(r=50);
                rotate_extrude(angle=angle_gen_anillo+10,convexity=10) translate([radio_anillo,0,0]) circle(r=19);
                }
            }
        //Abertura del riel
        rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo,0,0]) circle(r=abertura_riel);
    
        //Corte superior del riel
        rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo,0,0]) rotate(angle_abertura) translate([-lado*3/2,2,0]) square([3*lado,3*lado]);

        //Encastres embra
        translate([100+lado/3.3,6,-lado/2]) rotate([90, 0, 0]) scale([1.1,1.1,1.1]) cube([lado/6,lado/6,12]);
        translate([100-lado/2.1,6,-lado/2]) rotate([90, 0, 0]) scale([1.1,1.1,1.1]) cube([lado/6,lado/6,12]);
        }
    }
//
module acople_sensor(){
    difference() {
        cylinder(h = 2*abertura_riel+2*largo_led /* "abertura_riel" es un radio */, r = contenedor_sensor, center = true);  // Pieza base y radio máximo del acople
        cylinder(h = abertura_riel-1, r = abertura_sensor+3, center = true); // poco importante, radio mínimo del acople
        cylinder(h = 4*abertura_riel, r = abertura_sensor, center = true); // muy importante, agujero para el sensor
        }
    }
//
module riel3(completo, sensor, generar, bobina){
    if (generar == true) {
    if (sensor == false){
            if (completo == false){
                riel2_bruto();
                }
            if (completo == true){
                union(){
                rotate(0)riel2_bruto();
                rotate(90)riel2_bruto();
                rotate(180)riel2_bruto();
                rotate(270)riel2_bruto();
                }
                }
            }
        if (sensor == true){
            if (completo == true){
                rotate(90)riel2_bruto();
                rotate(180)riel2_bruto();
                rotate(270)riel2_bruto();
                }
            difference() {
                union() {
                    rotate([0,0,angle_posicion_sensor-(angulo_bobina/2+3)])translate([radio_anillo,0,0])rotate([0,90-angle_abertura,0])translate([0,0,0])acople_sensor();
                    rotate([0,0,angle_posicion_sensor+(angulo_bobina/2+2)])translate([radio_anillo,0,0])rotate([0,90-angle_abertura,0])translate([0,0,0])acople_sensor();
                    difference() {
                        riel2_bruto();
                            union(){
                        rotate([0,0,angle_posicion_sensor-(angulo_bobina/2+3)])translate([radio_anillo,0,0])rotate([0,90-angle_abertura,0])translate([0,0,0])cylinder(h = 4*abertura_riel, r = contenedor_sensor, center = true);
                        rotate([0,0,angle_posicion_sensor+(angulo_bobina/2+2)])translate([radio_anillo,0,0])rotate([0,90-angle_abertura,0])translate([0,0,0])cylinder(h = 4*abertura_riel, r = contenedor_sensor, center = true);
                            }
                        }
                    }
                rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo,0,0]) circle(r=abertura_riel);
                }
            }
        }
    if (bobina == true){
        bobina(true);
        }
    }
//
//riel3( ¿completo? , ¿sensor? , ¿generar?, ¿bobina?)  , completar con "true" para las condiciones a generar
riel3(false, true, true, false);
rotate([0,0,36.5])bobina();
