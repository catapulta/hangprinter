include <parameters.scad>
use <util.scad>

base_ywidth = 84;

//rotate([0,90,0])
//belt_roller();
module belt_roller(twod = true){
  wing=7;
  flerp=15;
  if(!twod){
    difference(){
      union(){
        // base
        translate([-Depth_of_roller_base/2, 0,0])
          ydir_rounded_cube2([Depth_of_roller_base, Belt_roller_space_between_walls/2+Belt_roller_wall_th+flerp, Base_th], r=3, $fn=4*5);
        translate([-(Depth_of_roller_base/2+flerp), -(Belt_roller_space_between_walls+2*Belt_roller_wall_th)/2,0])
          left_rounded_cube2([Depth_of_roller_base+flerp, Belt_roller_space_between_walls+2*Belt_roller_wall_th, Base_th], r=3, $fn=4*5);
        difference(){
          union(){
            for(k=[0,1]) mirror([0,k,0])
              roller_wall(Belt_roller_space_between_walls-0.8, Belt_roller_wall_th+0.4, Belt_roller_h, rot_nut=30, bearing_screw=false);
            translate([-Depth_of_roller_base/2,-Belt_roller_space_between_walls/2,0])
              cube([Depth_of_roller_base, Belt_roller_space_between_walls+2, Belt_roller_h-43]);
            translate([-(Depth_of_roller_base)/2, Belt_roller_space_between_walls/2+Belt_roller_wall_th, Base_th])
              rotate([0,90,0])
                rotate([0,0,90])
                  inner_round_corner(h=Depth_of_roller_base, r=2, back=2, $fn=5*4);
            translate([-Depth_of_roller_base/2, (Belt_roller_space_between_walls+2*Belt_roller_wall_th)/2, Base_th])
              rotate([90,0,0])
                rotate([0,0,90])
                  inner_round_corner(h=Belt_roller_space_between_walls+2*Belt_roller_wall_th+2, r=2, $fn=5*4);

            for(k=[0,1]) mirror([0,k,0])
              translate([-Depth_of_roller_base/2, Belt_roller_space_between_walls/2+Belt_roller_wall_th,0])
                rotate([0,0,90])
                  inner_round_corner(h=Base_th+2*(1-k), r=2, back=2, $fn=5*4);

            for(k=[0,1]) mirror([0,k,0]) {
              hull(){
                translate([0,Belt_roller_space_between_walls/2 + 0.5, Belt_roller_h - Depth_of_roller_base/2])
                  rotate([-90,0,0]){
                    translate([0,0,1+Belt_roller_wall_th - min(Belt_roller_wall_th/2, 2)])
                      rotate([0,0,30])
                        cylinder(d=7/cos(30), 1.5, $fn=6);
                  }
                translate([0,Belt_roller_space_between_walls/2 + 0.5, Belt_roller_h - Depth_of_roller_base/2-8])
                  rotate([-90,0,0]){
                    translate([0,0,1+Belt_roller_wall_th - min(Belt_roller_wall_th/2, 2)])
                      rotate([0,0,30])
                        cylinder(d=7/cos(30), 1.5, $fn=6);
                }
              }
            }
          }
          translate([-Depth_of_roller_base/2-10, -(Belt_roller_space_between_walls+2*Belt_roller_wall_th)/2, Base_th])
            rotate([0,90,0])
              rotate([0,0,181])
                corner_rounder(r1=0, r2=2, angle=88);
          translate([-Depth_of_roller_base/2-2, -(Belt_roller_space_between_walls+2*Belt_roller_wall_th)/2-2, 0])
            cylinder(r=2, h=Base_th+2, $fn=4*5);

          mirror([1,0,0])
            translate([Depth_of_roller_base/2, -(Belt_roller_space_between_walls/2+Belt_roller_wall_th),Base_th+2+25])
              rotate([0,0,90])
                inner_round_corner(r=2, h=Belt_roller_h+2,$fn=4*4);
          mirror([0,1,0])
            translate([Depth_of_roller_base/2, -(Belt_roller_space_between_walls/2+Belt_roller_wall_th),Base_th+2])
              rotate([0,0,90])
                inner_round_corner(r=2, h=Belt_roller_h+2,$fn=4*4);


          translate([0,0,-9])
            belt_roller_containing_cube();
          hull(){
            translate([Belt_roller_top_adj_screw_x, Belt_roller_top_adj_screw_y+0.3, Belt_roller_h-33])
              rotate([0,0,30])
              nut(4);
            translate([Belt_roller_top_adj_screw_x, -Belt_roller_top_adj_screw_y-0.3, Belt_roller_h-33])
              rotate([0,0,30])
              nut(4);
          }
          for(k=[0,1]) {
            mirror([0,k,0]) {
              translate([-7, -Belt_roller_containing_cube_ywidth/2, Belt_roller_h-27])
                rotate([0,0,40])
                  cube([4, 6, Belt_roller_h]);
            }
          }

          for(k=[0,1]) mirror([0,k,0]) {
            hull(){
              translate([0,Belt_roller_space_between_walls/2 + 0.5, Belt_roller_h - Depth_of_roller_base/2])
                rotate([-90,0,0]){
                  translate([0,0,1+Belt_roller_wall_th - min(Belt_roller_wall_th/2, 2)])
                    rotate([0,0,30])
                      nut(h=8);
                }
              translate([0,Belt_roller_space_between_walls/2 + 0.5, Belt_roller_h - Depth_of_roller_base/2-8])
                rotate([-90,0,0]){
                  translate([0,0,1+Belt_roller_wall_th - min(Belt_roller_wall_th/2, 2)])
                    rotate([0,0,30])
                      nut(h=8);
              }
            }
            hull() {
              translate([0,Belt_roller_space_between_walls/2 - 1, Belt_roller_h - Depth_of_roller_base/2])
                rotate([-90,0,0])
                  cylinder(d=3.4, h=Belt_roller_wall_th + 2, $fn=12);
              translate([0,Belt_roller_space_between_walls/2 - 1, Belt_roller_h - Depth_of_roller_base/2-8])
                rotate([-90,0,0])
                  cylinder(d=3.4, h=Belt_roller_wall_th + 2, $fn=12);
            }
          }
        }
      }
      translate([Belt_roller_top_adj_screw_x, Belt_roller_top_adj_screw_y,Belt_roller_h-27])
        cylinder(d=M3_screw_head_d, h=Belt_roller_h, $fn=13);
      translate([Belt_roller_top_adj_screw_x, -Belt_roller_top_adj_screw_y,Belt_roller_h-27])
        cylinder(d=M3_screw_head_d, h=Belt_roller_h, $fn=13);
      translate([Belt_roller_top_adj_screw_x, Belt_roller_top_adj_screw_y,-5])
        cylinder(d=3.2, h=Belt_roller_h, $fn=13);
      translate([Belt_roller_top_adj_screw_x, -Belt_roller_top_adj_screw_y,-5])
        cylinder(d=3.2, h=Belt_roller_h, $fn=13);

      translate([0,Belt_roller_space_between_walls/2+Belt_roller_wall_th+flerp/2,0.5])
        Mounting_screw_countersink();
      translate([-Depth_of_roller_base/2-flerp/2,0,0.5])
        Mounting_screw_countersink();
      translate([-Depth_of_roller_base/2, Belt_roller_space_between_walls/2+Belt_roller_wall_th, Base_th])
        rotate([0,0,89.9])
          corner_rounder(r1=2, r2=2, sq=[10,Belt_roller_h], angle=90.2);
      mirror([1,0,0])
        translate([-Depth_of_roller_base/2+2, Belt_roller_space_between_walls/2+Belt_roller_wall_th-2, Base_th+2])
          rotate([0,0,89])
            rotate_extrude(angle=92, $fn=4*4)
              translate([4,0])
                circle(r=2, $fn=4*5);
    }
  } else {
    difference(){
      union(){
        translate([-Depth_of_roller_base/2, 0,0])
          ydir_rounded_cube2_2d([Depth_of_roller_base, Belt_roller_space_between_walls/2+Belt_roller_wall_th+flerp], r=3, $fn=4*5);
        translate([-(Depth_of_roller_base/2+flerp), -(Belt_roller_space_between_walls+2*Belt_roller_wall_th)/2,0])
          left_rounded_cube2_2d([Depth_of_roller_base+flerp, Belt_roller_space_between_walls+2*Belt_roller_wall_th], r=3, $fn=4*5);
      }
      translate([0,Belt_roller_space_between_walls/2+Belt_roller_wall_th+flerp/2])
        Mounting_screw_countersink(twod=twod);
      translate([-Depth_of_roller_base/2-flerp/2,0])
        Mounting_screw_countersink(twod=twod);
    }
  }
}



module screw_placeout(){
  for(ang=[0:90:359])
    rotate([0,0,ang+45])
      translate([29.8/2,0,0])
        children();
}

//stationary_part();
module stationary_part(){
  difference(){
    scale([61.1/60.8,61.1/60.8,1])
      linear_extrude(height=7, convexity=6)
        scale(0.1550)
          for(i=[-1,0,1]){
            extra_wiggle_room = 0.2;
            wiggle_degs = i*extra_wiggle_room/(60.8/2)*(180/PI);
                rotate([0,0,-32-180+wiggle_degs])
                  translate([-102,-151.5])
                    import("./whitelabel_motor.svg");
          }
    screw_placeout()
      translate([0,0,-1])
        cylinder(d=3, h=10);
  }
}

module shaft(){
  translate([0,0,-20.2])
    cylinder(d=5, h=20.2 + 42);
}

module rotating_part(){
  difference() {
    translate([0,0,7.1])
      cylinder(d=60.8, h=28.7-7.1, $fn=100);
    translate([0,0,32]){
      rotate_extrude() {
        translate([22,0])
          rotate([0,0,-12])
            square([20, 10], center=true);
      }
    }
  }
}

//whitelabel_motor();
module whitelabel_motor(){
  color([0.4,0.4,1.0]) stationary_part();
  color("grey") shaft();
  color([0.6,0.6,1.0]) rotating_part();
}

//encoder();
module encoder(){
  difference(){
    union(){
      translate([-(33.8-27.6),-28.5/2,0])
      cube([34, 28.5, 8.9]);
      intersection(){
        cylinder(r=43.13-27.6, h=8.9,$fn=100);
        translate([-50,-28.5/2,-1])
          cube([100, 28.5, 10]);
      }
    }
  translate([0,0,-1])
    cylinder(d=13, h=10);
  }

  for(k=[0,1]){
    mirror([0,k,0]){
      difference(){
        hull(){
          translate([0,-52.4/2+3,0])
            cylinder(d=6, h=2.4, $fn=20);
          translate([-(33.8-27.6), -28.5/2, 0])
            cube([2*(33.8-27.6), 1, 2.4]);
        }
        translate([0,-45.5/2,-1])
          cylinder(d=3, h=5, $fn=10);
        translate([0,-32.5/2,-1])
          cylinder(d=3, h=5, $fn=10);
        translate([0,-32.5/2,0.5])
          cylinder(d=5, h=5, $fn=12);
      }
  }
  }
}


module erasor_cubes(cubesize_x, yextra) {
  translate([-51,-20,-1])
    cube([30,40,50]);
  for(k=[0,1]) mirror([0,k,0]) {
    translate([-50+6, -cubesize_x-1,-1])
      cube([50,50,50]);
    translate([6,-cubesize_x/2+6,-1])
      rotate([0,0,-90])
        inner_round_corner(r=2, h=11, $fn=24);
    translate([4,-cubesize_x/2-k*yextra,0])
      rotate([0,90,0])
        rotate([0,0,90])
          inner_round_corner(r=2, h=27, $fn=24);
    translate([31,-cubesize_x/2-k*yextra+2,2])
      rotate([0,90,0])
        rotate([0,0,-90])
          rotate_extrude(angle=90, $fn=24) translate([4,0]) circle(r=2, $fn=24);
  }
  translate([5,-cubesize_x/2,8])
    rotate([0,90,0])
      rotate([0,0,0])
        inner_round_corner(r=2, h=26, $fn=24);
  translate([31,-cubesize_x/2+2,6])
    rotate([0,90,0])
      rotate([0,0,180])
        rotate_extrude(angle=90, $fn=24) translate([4,0]) circle(r=2, $fn=24);

}

//!whitelabel_motor_render();
module whitelabel_motor_render(){
  rotate([0,-90,0])
    whitelabel_motor();
  translate([-33.7,0,0])
    rotate([90,0,-90])
      encoder();
}


//translate([-2.5,0,0])
//rotate([0,90,0])
//!motor_bracket(true);
module motor_bracket(leftHanded=false){
  cubesize_x = 60.8+6;
  yextra=8.6;
  cubesize_y = cubesize_x+yextra;

  difference(){
    union(){
      translate([-cubesize_x/2,-cubesize_x/2,0])
        cube([cubesize_x, cubesize_y,8]);
      translate([15,24,8])
        rotate([0,90,0])
          rotate([0,0,2*90])
            inner_round_corner(r=3, h=20, $fn=4*5);
    }
    difference(){
      translate([0,0,-1])
        cylinder(d=60.8-3,h=50, $fn=100);
      difference(){
        union(){
          for(k=[0,1]) {
            mirror([0,k,0]) {
              translate([-13,-4-29.6/(2*sqrt(2)),0])
                cube([cubesize_x-2, 8, 20]);
              translate([23.6,-29.6/(sqrt(8))-4.6,-1])
                  rotate([0,0,166])
                  inner_round_corner(r=2, h=10, ang=131, back=2, $fn=10*4);
              translate([28.49,-29.6/(sqrt(8))+3.95,-1])
                  rotate([0,0,90])
                  inner_round_corner(r=2, h=10, ang=74, back=2, $fn=10*4);
              rotate([0,0,57])
                rotate_extrude(angle=68, $fn=100)
                  translate([GT2_motor_gear_outer_dia/2+1,0])
                    square([8,9]);
            }
          }
        }
        cylinder(d=GT2_motor_gear_outer_dia+2, h=52, $fn=100);
      }

      screw_placeout()
        translate([0,0,2.5])
          cylinder(d=M3_screw_head_d+6, h=11,$fn=20);
    }
    if (leftHanded) {
      rotate([0,0,180])
        mirror([1,0,0])
          translate([0,0,-7+2.5])
            stationary_part();
    } else {
      mirror([1,0,0])
        translate([0,0,-7+2.5])
          stationary_part();
    }
    translate([0,0,-7+2.5])
      cylinder(d=55, h=7);


    erasor_cubes(cubesize_x, yextra);

    // Remove overhang for ease of printing upright
    if (leftHanded) {
      translate([7.075,-29.720,-0.5])
        rotate([0,0,45])
            cube(3);
    } else {
      translate([8.555,29.285,-0.5])
        rotate([0,0,45])
          translate([-3, -3, 0])
            cube(3);
    }


    // Screw holes
    screw_placeout() {
      translate([0,0,-1])
        cylinder(d=3.44, h=10, $fn=8);
      translate([0,0,2.5+3])
        cylinder(d=M3_screw_head_d, h=10,$fn=20);
    }
  }
  difference(){
    union(){
      difference(){
        translate([33,0,0])
          rotate([0,180,0])
            rotate([90,0,0])
              translate([0,0,-(cubesize_y+13)/2])
                inner_round_corner(r=2, h=cubesize_y+10, $fn=10*4);
        mirror([0,1,0])
          translate([0,24.4,9])
            rotate([45,0,0])
              translate([0,0,-50])
                cube(50);
        translate([0,42,9])
          translate([0,0,-50])
            cube(50);
      }

      mirror([0,1,0])
        intersection() {
        translate([ 33, cubesize_x / 2, -3 ])
          rotate([ 0, 0, 90 ])
           inner_round_corner(r=2, h=11, ang=90, $fn=10*4);
        translate([0,24.4,9])
          rotate([45,0,0])
            translate([0,0,-50])
              cube(50);
        }
    }
    for(k=[0,1]) mirror([0,k,0])
      translate([31,-cubesize_x/2-k*yextra+2,2])
        rotate([0,90,0])
          rotate([0,0,-90])
            rotate_extrude(angle=90, $fn=24) translate([4,0]) circle(r=2, $fn=24);

    translate([31,-cubesize_x/2+2,6])
      rotate([0,90,0])
        rotate([0,0,180])
          rotate_extrude(angle=90, $fn=24) translate([4,0]) circle(r=2, $fn=24);
  }
}



// encoder_bracket();
module encoder_bracket() {
  difference() {
    rotate([0,90,0]) {
      difference(){
        union(){
          translate([16,-20/2,-2.5])
            difference(){
              left_rounded_cube2([18, 20, 7+4], 3, $fn=5*4);
              translate([-1,-1,4])
                rotate([0,11,0])
                  translate([0,0,-50])
                    cube(50);
              translate([-1,-1,4.8])
                rotate([0,-11,0])
                  translate([0,0,2])
                    cube(50);
              translate([-0.1,3,7])
              hull(){
                cube([0.1, 20-2*3, 4]);
                translate([13, (20-2*3)/2, 0])
                  cylinder(d=4.5, h=4, $fn=5*4);
              }

            }
          intersection(){
            translate([33,0,0])
              rotate([90,-180,0])
                translate([0,1.66,-25/2])
                  inner_round_corner(r=2, h=25, $fn=10*4, ang=90-11, center=false);
            translate([0,0,-50*sqrt(2)+8.4])
              rotate([45,0,0])
                cube(50);
          }
          intersection(){
            translate([33,0,0])
              rotate([-90,180,0])
                translate([0,7.5,-25/2])
                  inner_round_corner(r=2, h=25, $fn=10*4, ang=90-11, center=false);
            translate([0,0,-2.5])
              rotate([45,0,0])
                cube(50);
          }

          difference(){
            for(k=[0,1])
              mirror([0,k,0])
                translate([33,20/2,0])
                    rotate([0,0,90])
                    translate([0,0,-6.5])
                      inner_round_corner(r=2, h=9+7, $fn=10*4, center=false);
            translate([0,0,-50*sqrt(2)+8.4])
              rotate([45,0,0])
                cube(50);
            translate([0,0,-2.5])
              rotate([45,0,0])
                cube(50);
          }
        }
      }
    }
    translate([0.1,0,0])
      rotate([90,0,-90]) {
        translate([0,-45.5/2,-5])
          hull(){
            translate([0,3,0])
              cylinder(d=3.1, h=16, $fn=10);
            translate([0,-1,0])
              cylinder(d=3.1, h=16, $fn=10);
          }
        translate([0,-45.5/2,-0.4-2])
          hull(){
            translate([0,3,0])
              rotate([0,0,30])
                cylinder(d=6.2, h=5, $fn=6);
            translate([0,-1,0])
              rotate([0,0,30])
                cylinder(d=6.2, h=5, $fn=6);
          }
    }
  }
}


motor_bracket_xpos = -46.5;
motor_bracket_ypos = -33;

// Four different brackets are needed
// All combinations of the two options
// |      leftHanded |     mirrored | C
// |      leftHanded | not mirrored | B
// |  not leftHanded |     mirrored | A
// |  not leftHanded | not mirrored | D
// It's recommended to use the named files
// motor_bracket_A.scad
// motor_bracket_B.scad
// motor_bracket_C.scad
// motor_bracket_D.scad
// or some kind of build system when compiling
// those stls. Doing it by hand easily leads to mistakes.

module base_hull_2d(){
  $fn=4*6;
  hull(){
    translate([-12,0,0])
      circle(r=4);
    translate([36-1.5,38,0])
      circle(r=4);
    translate([36-1.5-15+3,38,0])
      circle(r=4);
    translate([36-1.5,-38,0])
      circle(r=4);
    translate([36-1.5-15+3,-38,0])
      circle(r=4);
  }
}

//mirror([1,0,0])
motor_bracket_extreme(leftHanded=false, twod=false);
module motor_bracket_extreme(leftHanded=false, twod=false, text="A") {
  module placed_text(){
    translate([13,5,0])
      rotate([0,0,-90])
        // Poor man's stencil font
        difference(){
          text(text);
          translate([4.4,0])
            square([0.5, 20]);
        }
  }
  translate([motor_bracket_xpos, motor_bracket_ypos, 0]) {
  if(!twod) {
      difference(){
        union(){
          linear_extrude(height=Base_th) base_hull_2d();
          translate([36-1.5, 36, 0])
            cube([6, 6, Base_th]);
          translate([0,0,35]){
            translate([-2.5+33,0,0])
              rotate([0,90,0])
                motor_bracket(leftHanded);
            //%translate([33,0,0])
            //  if(leftHanded)
            //    rotate([180,0,0])
            //      import("../stl/for_render/whitelabel_motor.stl");
            //  else
            //    import("../stl/for_render/whitelabel_motor.stl");
            translate([4.5-0.7,0,0])
              rotate([0,0,2*90])
                encoder_bracket();
          }
        }
        translate([-12,0,0.5])
          Mounting_screw_countersink();
        translate([36-1.5-15+3,38,0.5])
          Mounting_screw_countersink();
        translate([36-1.5,-38,0.5])
          Mounting_screw_countersink();
        translate([36-1.5-15+3,-38,0.5])
          Mounting_screw_countersink();
        translate([0,0,-1])
          linear_extrude(height=Base_th+2)
            placed_text();
      }
    } else {
      // twod below here
      difference(){
        union(){
          base_hull_2d();
        }
        translate([-12,0,0])
          Mounting_screw_countersink(twod=twod);
        translate([36-1.5-15+3,38,0])
          Mounting_screw_countersink(twod=twod);
        translate([36-1.5,-38,0])
          Mounting_screw_countersink(twod=twod);
        translate([36-1.5-15+3,-38,0])
          Mounting_screw_countersink(twod=twod);
        placed_text();
      }
    }
  }

  rotate([0,0,-90])
    belt_roller(twod=twod);
}