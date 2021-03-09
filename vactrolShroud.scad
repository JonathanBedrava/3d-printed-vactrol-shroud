ldrRad = 5.5/2; //radius of the longer side of the LDR
ledRad = 3.3/2;// radius of the LED
ledBaseRad = 4; //radius of the base of the LED (default assumes 3mm LED)
ldrPitch = 3.45; //distance between LDR pins
ledPitch = 2.9; //distance between LED pins
pinRad = 1.25/2; //radius of the pins
ldrHeight = 2.5; //height of the LDR 
ledHeight = 5.65;//the total height of the LED from the base up

baseX = 15; //base length (LED and LDR are oriented along this axis);
baseY = 8; //the width of the base
baseZ = 2; //the thickness of the base;
mountX = ledHeight + ldrHeight + 2;
mountZ = 3.5; //how far the components should rest above the base (should be at minimum the radius of the LED base or the LDR, whichever is greater)

screwRad=1.5;
nutZ = 3.05;
nutX = 6;
screwDepth=12;

caseX = baseX+3;
caseY = baseY+3;
caseZ = baseZ+mountZ*2;

$fn = 60;
translate([0,0,baseZ/2])
    base();
translate([0,caseY+2,caseZ/2])
    case();

module case()
{
    difference()
    {
        cube([caseX,caseY,caseZ],center=true);
        translate([0,0,1.01])
            cube([baseX+.33,baseY+.33,caseZ-1],center = true);
        translate([caseX/2-2,0,-caseZ/2])
            rotate([0,0,-90])
                diodeSymbol();   
    }
    translate([0,0,-baseZ/2-caseZ/2+mountZ/2])
            mount();
}

module base()
{
    difference()
    {
        cube([baseX, baseY, baseZ], center = true);
        translate([mountX/2-2, 0, mountZ/2-2.75])
            rotate([0,0,90]) 
                diodeSymbol();
        translate([mountX/2+.5,0,0])
            rotate([0,0,90])
                pins(ledPitch);
        translate([-mountX/2-.5,0,0])
            rotate([0,0,90])
                pins(ledPitch);
    }
    mount();
}

module mount()
{
    mountY = ldrRad*2+1;
    if(ledRad > ldrRad)
    {
        mountY = ledRad*2+1;
    }

    mountR = ldrRad;
    if(ledRad > ldrRad)
    {
        mountR = ledRad;
    }
    difference(){
        union(){
            
            translate([0, 0, baseZ])
                cube([mountX,mountY,mountZ], center = true);
        }
        translate([0, 0, baseZ/2+mountZ])
            rotate([0,90,0])
                cylinder(r=mountR, h=ledHeight+ldrHeight+.5, center=true);
        translate([0,0,baseZ/2+mountZ-pinRad])
            rotate([90,0,90])
                pins(ledPitch);
    }
}

module pins(pitch)
{
    translate([-pitch/2,0,0])
        cylinder(r = pinRad, h = 20, center = true);
    translate([pitch/2,0,0])
        cylinder(r = pinRad, h = 20, center = true);
    
}

module diodeSymbol()
{
    cylinder(r=1.75, $fn=3, h=1, center=true);
    translate([1.65,0,0])
    cube([.75,2.75,1],center=true);
}