use <util.scad>
use <donkey.scad>
include <parameters.scad>

d = 11;
tail = 5; // behind donkey available th = d/2 + tail
donkey_feet_w = 43.5;
encoder_feet_w = 29;
hole_to_hole_l = 90; //83.0;
th = 2;
elevate_donkey_screw_holes = th + 13.5;
shaft_mid_h = donkey_feet_w/2 + elevate_donkey_screw_holes;

//to_be_mounted();
module to_be_mounted(){
  translate([hole_to_hole_l/2, 0, shaft_mid_h])
    rotate([0,-90,0])
    rotate([0,0,0])
    import("../openscad_stl/donkey.stl");
    //donkey();

  translate([-hole_to_hole_l/2, 0, shaft_mid_h])
    rotate([0,90,0])
    rotate([0,0,45])
    translate([0,0,-34])
    import("../openscad_stl/donkey_encoder.stl");
    //donkey();
}


box_depth_donkey = hole_to_hole_l/4+11-4;
box_depth_encoder = hole_to_hole_l/4;

donkey_face();
module donkey_face(){
  tr_x = (hole_to_hole_l/2 - box_depth_donkey) - Donkey_feet_th;
  difference(){
    union(){
      translate([tr_x, -(donkey_feet_w+20)/2, 0]){
        cube([box_depth_donkey,
              donkey_feet_w + 20,
              elevate_donkey_screw_holes + donkey_feet_w + -14.2]);
        translate([0,(donkey_feet_w + 20)/2, shaft_mid_h])
          rotate([0,90,0])
          difference(){
            cylinder(r=(donkey_feet_w + 20)/2 + 4, h = box_depth_donkey, $fn=60);
            cube([donkey_feet_w + 20 + 10 + 1,
                 (donkey_feet_w + 20)/2 + 3,
                 2*box_depth_donkey + 2], center=true);
            difference(){
              translate([0,0,box_depth_donkey])
                mirror([0,0,1])
                rotate_extrude($fn=60)
                  translate([-(Donkey_body_d + 4)/2-8.75,0])
                  inner_round_corner2d(1.5, $fn=50);
              cube([donkey_feet_w + 20 + 10 + 1,
                   donkey_feet_w + 20,
                   2*box_depth_donkey + 4], center=true);
            }
          }
      }
    }
    translate([tr_x - box_depth_encoder/2+1.5, -(donkey_feet_w + 20 - 10)/2, -1])
      cube([box_depth_donkey, donkey_feet_w + 20 - 10, shaft_mid_h]);
    translate([0,-50,shaft_mid_h + + 5])
      cube(100);
    translate([hole_to_hole_l/2, 0, shaft_mid_h])
      rotate([0,-90,0])
      rotate([0,0,-90]){
        teardrop(r=(Donkey_body_d + 4)/2, h=100,$fn =50);
        translate([0,0,Donkey_feet_th]){
          rotate_extrude($fn=50)
            translate([(Donkey_body_d + 4)/2,0])
            inner_round_corner2d(1.5, $fn=50);
        }
      }
    translate([0, -(Donkey_body_d - 19)/2, Donkey_body_d/2])
      cube([100, Donkey_body_d - 19, Donkey_body_d*2]); // Further opens teardrop opening
    translate([(hole_to_hole_l/2 - box_depth_donkey) - Donkey_feet_th,0,0])
      rotate([0,90-atan((donkey_feet_w/2 + 24)/(box_depth_donkey - Donkey_feet_th)), 0])
      translate([-hole_to_hole_l, -(donkey_feet_w + 50)/2, 0])
      cube([hole_to_hole_l, donkey_feet_w + 50, 100]); // Makes the slant
    translate([hole_to_hole_l/2,0,donkey_feet_w/2 + elevate_donkey_screw_holes])
      rotate([0,-90,0])
      donkey_screw_hole_translate(){
        rotate([0,0,30]){
          cylinder(d=3.3, h=40); // screw
          rotate_extrude($fn=6)
            translate([1.5,Donkey_feet_th+1])
            inner_round_corner2d(1.5, $fn=20); // round corners of screw holes
          translate([0,0,Donkey_feet_th+1 + 6.1])
            cylinder(d=5.6/cos(30) + 0.1, h=40, $fn=6); // put nut in
        }
      }
  }
}


encoder_face();
module encoder_face(){
  the_height = shaft_mid_h-10;
  difference(){
    translate([-hole_to_hole_l/2, -Encoder_LDP3806_d/2, 0])
      translate([box_depth_encoder,0,0])
      rotate([0,-90,0])
      right_rounded_cube2([the_height, Encoder_LDP3806_d, box_depth_encoder], 13);
    translate([-hole_to_hole_l/2 + box_depth_encoder,0,0])
      rotate([0,-90+atan(the_height/(box_depth_encoder - th)),0])
      translate([0,-(Encoder_LDP3806_d + 2)/2, 0])
      cube([hole_to_hole_l, Encoder_LDP3806_d + 2, 34.56]); // the slant

    translate([-hole_to_hole_l/2 + box_depth_encoder/2 - 1.5,0,32.45])
      translate([0,-(Encoder_LDP3806_d + 2)/2, 0])
      cube([hole_to_hole_l, Encoder_LDP3806_d + 2, 50]); // the slant
    translate([-hole_to_hole_l/2+ 10, 0, shaft_mid_h])
      rotate([0,90,0])
      rotate([0,0,45])
      encoder_screw_hole_translate(-45){
        translate([0,0,-34]){
          translate([0,0,-1])
            rotate([0,0,30])
            cylinder(d=3.3, h=40); // screw
          translate([0,0,4.0])
            rotate([0,0,30])
            cylinder(d=5.6/cos(30) + 0.1, h=40, $fn=6); // Put nut in
        }
      }
    translate([0,0,shaft_mid_h])
      rotate([0,-90,0])
        rotate([0,0,-90]){
          teardrop(r=11, h=50);
        }
    translate([-hole_to_hole_l/2 + box_depth_encoder/2 -1.5, -28/2, -1])
      cube([box_depth_encoder, 28, the_height]);
  }
}

plate();
module plate(){
  a = hole_to_hole_l/2;
  b = box_depth_encoder;
  c = box_depth_donkey;
  d = (donkey_feet_w + 20)/2;
  e = a - Donkey_feet_th;
  f = 5;
  linear_extrude(height=8, convexity=10)
    for(k=[0,1])
      mirror([0,k,0]){
        polygon(points = [
                          [-a+b, -Encoder_LDP3806_d/2],
                          [-a+b-10, -Encoder_LDP3806_d/2],
                          [-a+b-10, -Encoder_LDP3806_d/2 + f],
                          [-a+b, -Encoder_LDP3806_d/2 + f],
                          [ e-c, -d + f],
                          [ e-c+10, -d + f],
                          [ e-c+10, -d],
                          [ e-c, -d],
                         ]);
        polygon(points = [
                          [-a+b, -Encoder_LDP3806_d/2],
                          [-a+b-10, -Encoder_LDP3806_d/2],
                          [-a+b-10, -Encoder_LDP3806_d/2 + f],
                          [-a+b, -Encoder_LDP3806_d/2 + f],
                          [ e-c, d],
                          [ e-c+10, d],
                          [ e-c+10, d-f],
                          [ e-c, d-f],
                         ]);
      }
  //polygon(points = [
  //                  [-a+b, -Encoder_LDP3806_d/2],
  //                  [-a,   -Encoder_LDP3806_d/2],
  //                  [-a,    Encoder_LDP3806_d/2],
  //                  [-a+b,  Encoder_LDP3806_d/2],
  //                  [ e-c,  d],
  //                  [ e  ,  d],
  //                  [ e  , -d],
  //                  [ e-c, -d]
  //                 ]);
  module bit(){
    rotate([0,0,90])
    translate([-Bit_width/2, -Bit_width/2, 0])
    difference(){
      left_rounded_cube2([Bit_width+4,Bit_width,Base_th], Lineroller_base_r);
      translate([Bit_width/2, Bit_width/2, -1])
        cylinder(d=Mounting_screw_d, h=Base_th+2, $fs=1);
    }
  }
  for(k=[0,1])
    mirror([0,k,0]){
      translate([-hole_to_hole_l/2+Bit_width/2,
                 -Encoder_LDP3806_d/2-Bit_width/2,
                 0])
        bit(); // Wood screw holes encoder
      translate([hole_to_hole_l/2 - Donkey_feet_th - Bit_width/2,
                 -(donkey_feet_w + 20)/2 - Bit_width/2,
                 0])
        bit(); // Wood screw holes donkey
    }
}