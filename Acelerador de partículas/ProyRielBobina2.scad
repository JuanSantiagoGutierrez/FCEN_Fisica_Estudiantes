$fn=100;

//Parametros
abertura_riel= 10; //radio de abertura
angle_gen_anillo = 90;
radio_anillo = 100 ;
angulo_bobina = 17 ;
radio_bobina = 24 ;
angle_abertura = 35;
abertura_sensor = 5.5; //Radio de abertura
contenedor_sensor = 10; //Radio del contenedor
// radio_bobina no debe superar la mitad del radio_anillo.

lado = 31 ;
module riel2(completo,sensor){
if (completo == true){
        rotate([0,0,90])riel2(false);
        rotate([0,0,180])riel2(false);
        rotate([0,0,270])riel2(false);
    }
    union(){
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
            }}
        //Abertura del riel
        rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo,0,0]) circle(r=abertura_riel);
        //Corte superior del riel
        rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo,0,0]) rotate(angle_abertura) translate([-lado*3/2,2,0]) square([3*lado,3*lado]);

        //Encastres embra
        translate([100+lado/3.3,6,-lado/2]) rotate([90, 0, 0]) scale([1.1,1.1,1.1]) cube([lado/6,lado/6,12]);
        translate([100-lado/2.1,6,-lado/2]) rotate([90, 0, 0]) scale([1.1,1.1,1.1]) cube([lado/6,lado/6,12]);
        if (sensor == true){rotate([0,0,45])translate([100,0,0])rotate([0,angle_abertura+20,0])translate([0,0,10])cylinder(r=abertura_sensor,h=100,center=true); }
        }
        //Encastres macho   
        // Acople para el Sensor 
        if (sensor == true){
            
            difference(){
                // Acople en bruto
                rotate([0,0,45])translate([100,0,0])rotate([0,angle_abertura+20,0])translate([0,0,10])cylinder(r=contenedor_sensor,h=70,center=true);
                // Recortes para armar el acople
                rotate([0,0,45])translate([100,0,0])rotate([0,angle_abertura+20,0])translate([0,0,10])cylinder(r=abertura_sensor,h=100,center=true);
                rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo,0,0]) circle(r=abertura_riel);
                difference(){
                    rotate_extrude(angle=angle_gen_anillo+10,convexity=10) translate([radio_anillo,0,0]) circle(r=50);
                    rotate_extrude(angle=angle_gen_anillo+10,convexity=10) translate([radio_anillo,0,0]) circle(r=19);
                    }
                translate([0,0,-18])cube([1000,1000,5],center = true);
                difference(){
                    cylinder(r=1.2*radio_anillo,h=40,center=true);
                    cylinder(r=radio_anillo+15,h=45,center=true);
                }
                //remoción de excedente 
                if (contenedor_sensor <= 12){
                    difference(){translate([0,0,-10]) rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo-17,0,0]) circle(r=22);
                    translate([0,0,-10]) rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo-17,0,0]) circle(r=10);
                    }
                    difference(){translate([0,0,10]) rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo+17,0,0]) circle(r=23);
                    translate([0,0,10]) rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo+16,0,0]) circle(r=10);
                    }
                    
                }
            }
}}}
// Bobina
module bobina(){
    difference(){
        union(){
            rotate_extrude(angle=angulo_bobina,convexity=10)
            translate([radio_anillo,0,0])
                circle(r=radio_bobina); 
            
            difference(){
            rotate_extrude(angle=angulo_bobina,convexity=10)
            translate([radio_anillo,0,0])
                circle(r=1.65*radio_bobina);
            
            rotate([0,0,1])
            rotate_extrude(angle=angulo_bobina-2,convexity=10)
            translate([radio_anillo,0,0])
                circle(r=2*radio_bobina);
            }
        }
        
        difference(){
            rotate([0,0,-1])
            rotate_extrude(angle=angulo_bobina+2,convexity=10)
            translate([radio_anillo,0,0])
                square(lado+2, center=true);   
    
        difference(){
            rotate([0,0,-1])
            rotate_extrude(angle=angulo_bobina+2,convexity=10)
            translate([radio_anillo,0,0])
            circle(r=lado);
            
            rotate([0,0,-1])
            rotate_extrude(angle=angulo_bobina+2,convexity=10)
            translate([radio_anillo,0,0])
            circle(r=radio_bobina-4);
        }
        }
        }
}
//Anillo + Encastre = Riel
module anillo(){
    difference(){
        union(){
        
        rotate_extrude(angle=90,convexity=10)
        translate([radio_anillo,0,0])
    difference(){
        square(lado, center=true);
        circle(d=lado-6);
    }
    
//Encastre
        translate([-6,100+lado/3.3,-lado/3])
        rotate([0, 90, 0])
            cube([lado/6,lado/6,12]);
        translate([-6,100-lado/2.1,-lado/3])
        rotate([0, 90, 0])
            cube([lado/6,lado/6,12]);
        }
        
//Cono
        translate([0,0,-20])
        scale([10,10,10])
            cylinder(d1=10,d2=55,h=10);
    
//Encastres negativo
        translate([100+lado/3.3,6,-lado/2])
        rotate([90, 0, 0])
        scale([1.1,1.1,1.1])
            cube([lado/6,lado/6,12]);
        translate([100-lado/2.1,6,-lado/2])
        rotate([90, 0, 0])
        scale([1.1,1.1,1.1])
            cube([lado/6,lado/6,12]);
    }
}
//

module MitadBobina(){ 
    difference(){
        bobina();
        translate([0,0,-300*radio_bobina])
        rotate([0,0,angulo_bobina/2])
        cube(600*radio_bobina);
    }
}

module bobinacompleta(completo){
    if (completo == true) {
        bobina();
        }
    else{
        MitadBobina(); 
        }
    }

module riel(completo){  
    anillo();
    if (completo == true) {
        rotate([0,0,90])anillo();
        rotate([0,0,180])anillo();
        rotate([0,0,270])anillo();
    }
     
}

/* 
El módulo riel(), tiene un parámetro que es 
completo y se le puede asignar "true" esto
otorga todo la circunferencia del riel. 
En caso de no especificar otorga un cuarto del riel. 
*/

//riel(true); 
riel2(false,true);

/*
El módulo "bobinacompleta(), tiene un parámtro 
que es completo y se le puede asignar
"true", esto otorga a la bobina por completo. 
Si no se aclara dará la mitad de la bobina.
*/

//bobinacompleta(true);

// Otros módulos utilizados para el proyecto y la impresión en 3D.
// Para la mitad de una bobina: "Mitadbobina();"
//Mitadbobina();
// Para un cuarto del riel: "Cuartoriel();"
//cuartoriel();