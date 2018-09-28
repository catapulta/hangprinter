// Belt support with help of droftarts' code, found here:
// https://www.thingiverse.com/thing:16627
// Visited 28 September 2018

include <parameters.scad>
use <util.scad>

//spool_center();
module spool_center(){
  bearing_wall_th = Spool_center_bearing_wall_th;
  center_h = Spool_height+Torx_depth-4;
  ek_w = 8;
  eang = 12; // just for placement of inner round corners
  difference(){
    cylinder(r=b608_outer_dia/2+bearing_wall_th, h=center_h,$fn=6*8);
    translate([0,0,-1])
      cylinder(d=b608_outer_dia,h=Spool_height+Torx_depth-0.4+1+2);
    translate([0,0,-1])
      cylinder(d1=b608_outer_dia+2.5, d2=b608_outer_dia-0.1,h=2.2);
  }
  for(a=[0:360/6:359]){
    rotate([0,0,a]){
    translate([b608_outer_dia/2+bearing_wall_th-1,-ek_w/2,0])
      cube([(Spool_r-bearing_wall_th-b608_outer_dia/2), ek_w, center_h]);
    }
  }
  difference(){
    for(a=[0:360/6:359])
      rotate([0,0,a]){
        translate([Spool_r-Spool_outer_wall_th-4, -ek_w/2,0])
          cube([5,ek_w,center_h+4]);
        for(m=[0,1])
          mirror([0,m,0]){
            translate([Spool_r-Spool_outer_wall_th-0.37,ek_w/2,0])
              rotate([0,0,90])
                inner_round_corner(r=2, h=Spool_height+Torx_depth, back=0.4, $fn=4*6);
            translate([b608_outer_dia/2+bearing_wall_th-0.95, ek_w/2-0.2,0])
              rotate([0,0,eang/2])
                inner_round_corner(r=2, h=center_h, ang=90-eang, $fn=4*5);
          }
      }
    translate([0,0,Spool_height+Torx_depth])
      rotate_extrude($fn=100)
        translate([Spool_r-Spool_outer_wall_th-4,0])
          circle(r=4,$fn=40);
  }
}

//torx(female=true);
module torx(h = Spool_height + 2, r = Spool_r, female=false){
  circs = 12;
  intersection(){
    if(female){
      cylinder(r=r+0.1, h=h, $fn=150);
    } else {
      cylinder(r=r, h=h, $fn=150);
    }
    for(i=[0:1:circs])
      rotate([0,0,i*360/circs]){
        translate([r-5,0,-1])
        cylinder(r=r/4.2, h=h+2, $fn=50);
      if(female){
        rotate([0,0,360/(2*circs)]){
           translate([r/2 + 16,0,-1])
             cylinder(r2=1, r1=r/1.9, h=h+2, $fn=50);
           translate([r-10-3.5,0,-1])
             cylinder(r=10, h=h+2, $fn=50);
          }
        }
      }
  }
  cylinder(r=r-5,h=h);
}

module GT2_2mm_tooth(h){
  linear_extrude(height=h) polygon([[0.747183,-0.5],[0.747183,0],[0.647876,0.037218],[0.598311,0.130528],[0.578556,0.238423],[0.547158,0.343077],[0.504649,0.443762],[0.451556,0.53975],[0.358229,0.636924],[0.2484,0.707276],[0.127259,0.750044],[0,0.76447],[-0.127259,0.750044],[-0.2484,0.707276],[-0.358229,0.636924],[-0.451556,0.53975],[-0.504797,0.443762],[-0.547291,0.343077],[-0.578605,0.238423],[-0.598311,0.130528],[-0.648009,0.037218],[-0.747183,0],[-0.747183,-0.5]]);
}

function tooth_spacing(tooth_pitch, pitch_line_offset, teeth)
  = (2*((teeth*tooth_pitch)/(3.14159265*2) - pitch_line_offset));

//GT2_2mm_pulley_extrusion(4, 170);
module GT2_2mm_pulley_extrusion(h, teeth, additional_tooth_width = 0, additional_tooth_depth = 0){

  tooth_depth = 0.764;
  tooth_width = 1.494;
  tooth_depth_scale = ((tooth_depth + additional_tooth_depth ) / tooth_depth) ;
  tooth_width_scale = (tooth_width + additional_tooth_width ) / tooth_width;
  pulley_OD = tooth_spacing (2,0.254, teeth);
  tooth_distance_from_centre = sqrt( pow(pulley_OD/2,2)
                                    -pow((tooth_width+additional_tooth_width)/2,2));

  echo(str("Number of teeth: ", teeth));
  echo(str("Pulley Outside Diameter: ", pulley_OD, " mm"));

  difference(){
    cylinder(r=pulley_OD/2, h=h, $fn=teeth*4);
    for(i=[1:teeth])
      rotate([0,0,i*(360/teeth)])
        translate([0,-tooth_distance_from_centre, -1])
          scale ([ tooth_width_scale , tooth_depth_scale , 1 ])
            GT2_2mm_tooth(); // Teeth
  }
}
