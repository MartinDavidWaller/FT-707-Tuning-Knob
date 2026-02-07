tubeQuality = 200;

knobDiameter = 50;
knobHeight = 18;

fingerHoleDiameter = 17;

rotatorShaftDiameter = 7;
rotatorShaftLength = 12;

fingerGrips = [
        
    [22.5],
    [67.5],
    [112.5],
    [157.5],
    [202.5],
    [247.5],
    [292.5],
    [337.5],
];

module lockingScrew()
{
    difference()
    {
        // Form the main tube
        
        cylinder(r=6, h=22, $fn=tubeQuality);
        
        // Remove the centre core 
        
        translate([0,0,-4])
            cylinder(r=1.6, h=28, $fn=tubeQuality);
        
        // Remove the bolt head hole
        
        translate([0,0,20])
            cylinder(r=3, h=3, $fn=tubeQuality);
        
        // Bury the nut hole
        
        for(i = [0 : 4])
        {
            translate([i,0,8])
                cylinder(r=3.3, h=3, $fn=6);
        }
    }
        
}

module rotatorShaft()
{
    difference()
    {
    cylinder(r=rotatorShaftDiameter / 2, h=rotatorShaftLength, $fn=tubeQuality);
    
    //translate([1.5,-2.5,2])
    //cube([1.5,5,rotatorShaftLength]);
    }
}

module core()
{
    difference()
    {
    cylinder(r=(knobDiameter - 10) / 2, h=knobHeight - 5, $fn=tubeQuality);
        
    translate([0,0,-2])    
        cylinder(r=rotatorShaftDiameter, h=knobHeight +4, $fn=tubeQuality);
    }
   
}

module step1()
{
    union()
    {
    cylinder(r=knobDiameter / 2, h=knobHeight, $fn=tubeQuality);
    
            translate([0,00,knobHeight])
            cylinder(r1=knobDiameter / 2, r2= (knobDiameter / 2 ) - 5, h=5, $fn=tubeQuality);
    }
}

module step2()
{
    difference()
    {
        step1();
    
        for(fg = fingerGrips) {
        
            // Draw in the tube to hold the coin
    
            translate(
                [
                    (knobDiameter + 10.5) / 2 * cos(fg[0]),
                    (knobDiameter + 10.5) / 2 * sin(fg[0]),
                    2
                ])
                cylinder(r=7, h=knobHeight + 20, $fn=tubeQuality);

  
        }
        
                translate([0,0,knobHeight + 8])
rotate([180,0,0])
            cylinder(r1=knobDiameter / 2 - 5, r2= (knobDiameter / 2 ) - 8, h=5, $fn=tubeQuality);   
   
        //translate([0,0,-1])
   //core();     
    }
    

}

module step3()
{
    fingerHoleLow = 10;
    fingerHoleHigh = 14;
    
    difference()
    {
        union()
        {
            step2();
        
            // Put in the cylinder for the finger hole
            
            for (i = [ fingerHoleLow : fingerHoleHigh])
            {
            translate(
                [
                (knobDiameter - i) / 2 * cos(22.5),
                (knobDiameter - i) / 2 * sin(22.5),
                0
                ])
                cylinder(r=fingerHoleDiameter / 2, h=knobHeight + 6, $fn=tubeQuality);
            }

        }
        
        for (j = [ fingerHoleLow : fingerHoleHigh])
        {
        translate(
            [
            (knobDiameter - j) / 2 * cos(22.5),
            (knobDiameter - j) / 2 * sin(22.5),
            knobHeight + 6
            ])
        sphere(fingerHoleDiameter - 10,  $fa = 0.4, $fs = 0.4);
        }
    
        translate([0,0,-1])
            core(); 
        
        rotate([0,0,67.5])
                translate([0,0,-1])
            rotatorShaft(); 
        

    }
}

module step4()
{
    lockingScrewHeight = 7;
    
    difference()
    {
        union()
        {
            step3();
        
            // Position the locking screw hole
            
            rotate([0,90,67.5])
                translate([-lockingScrewHeight,0,1])        
                lockingScrew();
        }
        
        rotate([0,90,67.5])
            translate([-lockingScrewHeight,0,15])        
            cylinder(r=3.5, h=10, $fn=tubeQuality); 

        rotate([0,90,67.5])
            translate([-lockingScrewHeight,0,0])        
            cylinder(r=1.6, h=60, $fn=tubeQuality); 
    
        // Remove the shaft hole
        
        cylinder(r=rotatorShaftDiameter / 2, h=20, $fn=tubeQuality); 
    }    
}

step4();

 
//lockingScrew();






