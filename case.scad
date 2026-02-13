// mf-uwbpro-case, v0.1.4, wetterfrosch

////////////////////////////////////////////////////////////////////////////////
// view/render components or not
////////////////////////////////////////////////////////////////////////////////

showFront   =   0;          // front part of case
showPcb     =   0;          // PCB (for scale)
showBack    =   1;          // back part of case
showHelpers =   0;          // helpers for buttons and LED (for scale)


////////////////////////////////////////////////////////////////////////////////
// constants and other variables
////////////////////////////////////////////////////////////////////////////////

// PCB: dimensions
pcbW = 72;
pcbH = 32.7;
pcbT = 1.7;

// screws: diameter, offset and position (W/H)
screwD = 3.0;
screwOff = 0.5;
screwPosW = (pcbW/2 - screwD/2 - screwOff);
screwPosH = (pcbH/2 - screwD/2 - screwOff);

// slug: 1mm in total, 0.5mm to each side. in general ;)
slugTotal = 1.0;
slug = slugTotal/2;

// wall thickness
wallT = 2.0;

// height of components on backside
setupBottom = 2.0;  // measured: 1.5mm
levelBottomCentered = -((pcbT/2) + setupBottom);
levelBottom = -(pcbT + setupBottom);

// height of components on front
setupTop = 3.9;     // measured: 3.4mm
levelTopCentered = ((pcbT/2) + setupTop);
levelTop = (pcbT + setupTop);


////////////////////////////////////////////////////////////////////////////////
// Front
////////////////////////////////////////////////////////////////////////////////
            
                
color([0,1,0])
if (showFront==1)  
    difference()  {
        union() {
        // front plane
        translate([0,0, levelTop+0.65 ]) 
            cube([pcbW+slugTotal+wallT*2, pcbH+slugTotal+wallT*2, wallT], true);
            
        // front screw sockets
        translate([screwPosW, screwPosH, pcbT+setupTop/2 ])                                         cube([5, 5, setupTop-slug/2], true);
        translate([screwPosW*-1, screwPosH, pcbT+setupTop/2 ])                                      cube([5, 5, setupTop-slug/2], true);
        translate([screwPosW*-1, screwPosH*-1, pcbT+setupTop/2 ])                                   cube([5, 5, setupTop-slug/2], true);
        translate([screwPosW, screwPosH*-1, pcbT+setupTop/2 ])                                      cube([5, 5, setupTop-slug/2], true);



        // radom
        difference() {
            
            // radom: empty hull
            difference() {
                // radom: outer
                hull() {
                    // radom outer: top/pill
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                           sphere(r=3.5, $fn=100);
                        translate([3+13, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                          sphere(r=3.5, $fn=100);
                    }
                    // radom base
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])        cylinder($fn=100, r=4.25, h=0.1);
                        translate([3+13, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])       cylinder($fn=100, r=4.25, h=0.1);
                    }
                }
                
                // radom full inner space
                hull() {
                    // radom pill/top
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                           sphere(r=2.5, $fn=100);
                        translate([3.5+13, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                        sphere(r=2.5, $fn=100);
                    }
                    // radom base
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])        cylinder($fn=100, r=2.5, h=0.1);
                        translate([3.5+13, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])     cylinder($fn=100, r=2.5, h=0.1);
                    }
                }
                
            }

            // radom-reducer   
            color([0,0,1]) translate([-2.5, (pcbH/2+slug)+wallT, levelBottom-0.85])                 cube([25, 10, 9.8]);
        }


        // long side plain
//        translate([-(pcbW/2+slug), -(pcbH/2+slug+wallT), (levelTop-wallT/2) ])
//           cube([(pcbW+slugTotal), 2, 2]);
        }
        
        // holes
        union() {
            translate([screwPosW, screwPosH,  levelTop-4 ])         cylinder($fn=100, h=wallT+3.2, d=screwD );
            translate([screwPosW*-1, screwPosH, levelTop-4])        cylinder($fn=100, h=wallT+3.2, d=screwD);
            translate([screwPosW*-1, screwPosH*-1, levelTop-4])     cylinder($fn=100, h=wallT+3.2, d=screwD);
            translate([screwPosW, screwPosH*-1, levelTop-4])        cylinder($fn=100, h=wallT+3.2, d=screwD);
            }


    
    // button: FLASH
    // RST: half-ring 
    difference() {
        color([1,0,0]) translate([(pcbW/2-2.8), -(pcbH/2-7.5), pcbT+setupTop-0.35]) // Z? ff
            // ring
            difference() {
                cylinder($fn=100, h=wallT, d=5);
                cylinder($fn=100, h=wallT, d=3);
            }
            
        color([1,0,0]) translate([(pcbW/2-2.8)-2.5, -(pcbH/2-7.5)-2.5, pcbT+setupTop-0.35])         cube([2.5,5,wallT+0.2]);
        }

    // RST: edges
        // outer
        color([1,0,0]) translate([(pcbW/2-2.8)-6, -(pcbH/2-7.5)-2.5, pcbT+setupTop-0.35])           cube([6,1,wallT+0.2]);
        // inner
        color([1,0,0]) translate([(pcbW/2-2.8)-6, -(pcbH/2-7.5)+1.5, pcbT+setupTop-0.35])           cube([6,1,wallT+0.2]);
        
        
    // button: RST
    //color([1,0,0]) translate([(pcbW/2-2.8), -(pcbH/2-7.5), pcbT])
    
    // FLASH: half-ring
    difference() {
        color([1,0,0]) translate([(pcbW/2-2.8), (pcbH/2-7.5), pcbT+setupTop-0.35]) // Z? ff
            // ring
            difference() {
                cylinder($fn=100, h=wallT+0.2, d=5);
                cylinder($fn=100, h=wallT+0.2, d=3);
            }
        color([1,0,0]) translate([(pcbW/2-2.8)-2.5, (pcbH/2-7.5)-2.5, pcbT+setupTop-0.35])          cube([2.5,5,wallT+0.2]);
        }

    // FLASH: edges
        // one
        color([1,0,0]) translate([(pcbW/2-2.8)-6, (pcbH/2-7.5)-2.5, pcbT+setupTop-0.35])            cube([6,1,wallT+0.2]);
        // the other
        color([1,0,0]) translate([(pcbW/2-2.8)-6, (pcbH/2-7.5)+1.5, pcbT+setupTop-0.35])            cube([6,1,wallT+0.2]);
    }
if (showFront==1) 
        // BTN RST nose
        color([0,0,1]) translate([(pcbW/2-2.8), (pcbH/2-7.5), setupTop+0.15])                       cylinder($fn=100, h=1.2, d1=2, d2=3);
if (showFront==1) 
        // BTN FLASH nose
        color([0,0,1]) translate([(pcbW/2-2.8), -(pcbH/2-7.5), setupTop+0.15])                      cylinder($fn=100, h=1.2, d1=2, d2=3);


////////////////////////////////////////////////////////////////////////////////
// PCB
////////////////////////////////////////////////////////////////////////////////


if (showPcb==1)  
    // main board
    color([0,0,1]) difference()  {
        // main board
        translate([0,0,pcbT/2]) 
            cube([pcbW, pcbH, pcbT], true);
        // holes
        union() {
            translate([screwPosW, screwPosH, 0])                                cylinder($fn=100, h=pcbT, d=screwD);
            translate([screwPosW*-1, screwPosH, 0])                             cylinder($fn=100, h=pcbT, d=screwD);
            translate([screwPosW*-1, screwPosH*-1, 0])                          cylinder($fn=100, h=pcbT, d=screwD);
            translate([screwPosW, screwPosH*-1, 0])                             cylinder($fn=100, h=pcbT, d=screwD);
            }    
    };
if (showPcb==1)  
    // antenna board
    color([0,0,1]) translate([3.5, (pcbH/2+slug), pcbT]) 
        cube([13, 8.5, 2.3]);

////////////////////////////////////////////////////////////////////////////////
// Back
////////////////////////////////////////////////////////////////////////////////

if (showBack==1)  
    difference()  {
        union() {
        // back plane
        translate([0,0, levelBottomCentered ]) 
           cube([pcbW+slugTotal, pcbH+slugTotal, wallT], true);
            
        // back screw sockets
        translate([screwPosW, screwPosH,  levelBottomCentered+wallT ])          cube([5, 5, setupBottom], true);
        translate([screwPosW*-1, screwPosH,  levelBottomCentered+wallT ])       cube([5, 5, setupBottom], true);
        translate([screwPosW*-1, screwPosH*-1,  levelBottomCentered+wallT ])    cube([5, 5, setupBottom], true);
        translate([screwPosW, screwPosH*-1,  levelBottomCentered+wallT ])       cube([5, 5, setupBottom], true);
            
        // sides
        // short side (USB-C)
        difference() {
            translate([(pcbW/2+slug), -(pcbH/2+slug+wallT), (levelBottomCentered-wallT/2) ])
                cube([2, pcbH+(2*wallT)+slugTotal, (setupBottom + pcbT + setupTop)+1.5]);
            color([1,0,0]) translate([pcbW/2+slug, -5, pcbT]) 
                cube([2, 10, 4.1]); // USB-C
        }
        // short side (WIFI ANT)
        translate([-(pcbW/2+slug+wallT), -(pcbH/2+slug+wallT), (levelBottomCentered-wallT/2) ])
            cube([2, pcbH+(2*wallT)+slugTotal, (setupBottom + pcbT + setupTop)+1.5]);
            
        // long side (UWB ANT)
        difference() {
        translate([-(pcbW/2+slug), (pcbH/2+slug), (levelBottomCentered-wallT/2) ])
            cube([(pcbW+slugTotal), 2, (setupBottom + pcbT + setupTop)+1.5]);
        
            // cut-out for UWB-ANT-PCB
            color([1,0,0]) translate([3.0, (pcbH/2+slug), pcbT-slug])                               cube([14, 2, 4.05]);
        }


        // radom
        difference() {
            
            // radom: empty hull
            difference() {
                // radom: outer
                hull() {
                    // radom outer: top/pill
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                           sphere(r=3.5, $fn=100);
                        translate([3+13, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                          sphere(r=3.5, $fn=100);
                    }
                    // radom base
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])        cylinder($fn=100, r=4.25, h=0.1);
                        translate([3+13, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])       cylinder($fn=100, r=4.25, h=0.1);
                    }
                }
                
                // radom full inner space
                hull() {
                    // radom pill/top
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                           sphere(r=2.5, $fn=100);
                        translate([3.5+13, (pcbH/2+slug) + 7.5, pcbT+1.15 ])                        sphere(r=2.5, $fn=100);
                    }
                    // radom base
                    hull() {
                        translate([3.5, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])        cylinder($fn=100, r=2.5, h=0.1);
                        translate([3.5+13, (pcbH/2+slug) + 2.1, pcbT+1.15 ]) rotate(a=[90,0,0])     cylinder($fn=100, r=2.5, h=0.1);
                    }
                }
                
            }

            // radom-reducer   
            translate([-2.5, (pcbH/2+slug)+wallT, 5.25])                                            cube([25, 10, wallT]);
        }
        
        // long side plain
        translate([-(pcbW/2+slug), -(pcbH/2+slug+wallT), (levelBottomCentered-wallT/2) ])
            cube([(pcbW+slugTotal), 2, ( setupBottom + pcbT + setupTop)+1.5]);
        }
        
        // holes
        union() {
            translate([screwPosW, screwPosH,  levelBottom-1 ])                  cylinder($fn=100, h=wallT+5, d=screwD );
            translate([screwPosW*-1, screwPosH, levelBottom-1])                 cylinder($fn=100, h=wallT+5, d=screwD);
            translate([screwPosW*-1, screwPosH*-1, levelBottom-1])              cylinder($fn=100, h=wallT+5, d=screwD);
            translate([screwPosW, screwPosH*-1, levelBottom-1])                 cylinder($fn=100, h=wallT+5, d=screwD);
            
            // screw sinks
            translate([screwPosW, screwPosH,  levelBottom-0.2 ])                cylinder($fn=100, h=2.1, d1=5.7, d2=screwD );
            translate([screwPosW*-1, screwPosH,  levelBottom-0.2 ])             cylinder($fn=100, h=2.1, d1=5.7, d2=screwD );
            translate([screwPosW*-1, screwPosH*-1,  levelBottom-0.2 ])          cylinder($fn=100, h=2.1, d1=5.7, d2=screwD );
            translate([screwPosW, screwPosH*-1,  levelBottom-0.2 ])             cylinder($fn=100, h=2.1, d1=5.7, d2=screwD );
            }
            
            // LED
            translate([(pcbW/2-7.4), (pcbH/2-4.0), -(pcbT)-1.5])                cylinder($fn=100, h=pcbT, d=4);
    }


////////////////////////////////////////////////////////////////////////////////
// Helpers
////////////////////////////////////////////////////////////////////////////////

if (showHelpers==1)  
        union() {
            // PCB: POWER LED
            color([1,0,0]) translate([(pcbW/2-7.4), (pcbH/2-4.0), -pcbT])       cylinder($fn=100, h=pcbT, d=1.5);

            // PCB: BTN RST
            color([1,0,0]) translate([(pcbW/2-2.8), (pcbH/2-7.5), pcbT])        cylinder($fn=100, h=2, d=1.7);
    
            // PCB: BTN FLASH
            color([1,0,0]) translate([(pcbW/2-2.8), -(pcbH/2-7.5), pcbT])       cylinder($fn=100, h=2, d=1.7);
        }
