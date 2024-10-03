$fn=100;

//Parametros
abertura_riel= 10;
angle_gen_anillo = 90;
radio_anillo = 100 ;
angulo_bobina = 17 ;
radio_bobina = 24 ;
// radio_bobina no debe superar la mitad del radio_anillo.

lado = 31 ;
module riel2(completo){
if (completo == true){
        rotate([0,0,90])riel2();
        rotate([0,0,180])riel2();
        rotate([0,0,270])riel2();
    }

    difference(){
    
        difference(){
            union(){
            //Encastre macho
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
        rotate_extrude(angle=angle_gen_anillo,convexity=10) translate([radio_anillo,0,0]) rotate(35) translate([-lado*3/2,2,0]) square([3*lado,3*lado]);

    //Encastres embra
        translate([100+lado/3.3,6,-lado/2]) rotate([90, 0, 0]) scale([1.1,1.1,1.1]) cube([lado/6,lado/6,12]);
        translate([100-lado/2.1,6,-lado/2]) rotate([90, 0, 0]) scale([1.1,1.1,1.1]) cube([lado/6,lado/6,12]);
        }
     //Encastres macho   

        }


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
//


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
riel2(false);

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
