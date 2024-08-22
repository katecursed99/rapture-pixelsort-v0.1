
//  ,_  _   ,_  ___,  , ,_   _,  ,_  ___,,  , _,,  _,  _, ,_  ___, 
//  |_)'|\  |_)' | |  | |_) /_,  |_)' |  \_/ /_,| (_, / \,|_)' |   
// '| \ |-\'|    |'\__|'| \'\_   |   _|_,/ \'\_'|___)'\_/'| \  |'   
//  '  `'  `'    '    ` '  `  `  '  '   '   `  `  '   '   '  ` '   
                                                               
//rapture_pixelsort
//a tool for shaping order from the chaos
//by Katherina "Kate the Cursed" Jesek
//2024
//free to use, modify, whatever. go make art <3
//inspired by ASDFpixelsort and Rutt-Etra synthesis
//
//s key saves still image
//a and d keys to switch modes on the fly
//hold 1 and 2 keys to shift threshold for effect
//change base values for all settings down in void setup
//
//animated mode depends on gifAnimation library
//livestream from camera depends on processing.video library
//



//import processing.video.*;  // livestream cam

//import gifAnimation.*; // un-comment for GIFs
//GifMaker gifExport; // un-comment for GIFs

//declaring some global variables we may or may not need
PGraphics pg2;
PImage   pg;
//Capture cam; // for livestreams, comment out for images
int vshift=0;
float mode;
String filename;
boolean animated;
String inputFilename;
int intensity;
float animLength;
float startFrame;

void setup() {
  
  // SETTINGS //
  
  mode = 2; // determines how it processes each pixel. 0-8 currently, more soon
  
  intensity = 87; // threshold for determining which pixels are processed
  vshift = -30; // factor for scaling how far each pixel travels from its original home.
              //     if you're new, try -10 through 10 first
  inputFilename = "dead internet.png"; // make sure name and file extension are correct
  size(1000,1000,P3D); // first two numbers scale the output. helpful for preview, best to 
                     //     use original dimensions once settings are dialled in
                     
                       
 // animated = false; // turning this on will output a GIF. 
                    //     make sure to un-comment the 2 lines for the library 
                    //     at the top, the 5 lines in void setup, and the 2 
                    //     addframe and export.finish lines at the end of void draw
                    //     or it won't save your GIF
  animLength = 100; // how many frames of animation to save for GIF
  startFrame = 1; // what frame to start recording the animation at
                    
  // /SETTINGS //
  
  frameRate(12);
  
  if (animated == true) {
  // for GIF stuff
//  filename = ("dead internet_" + floor(mode) + ".gif");
 // gifExport = new GifMaker(this,filename);
//  gifExport.setRepeat(0);
 // gifExport.setTransparent(0,0,255);
//  gifExport.setQuality(8);
  // for GIF stuff
  }
  // for live cam 
 // String[] cameras = Capture.list();
//  cam = new Capture(this, cameras[1]);
//  cam.start();
  // for live cam
  
 
  
  
  
  
  
  pg = loadImage(inputFilename);
  pg2 = createGraphics(width, height, P3D);
  
}

void draw() {
  colorMode(RGB);
  if (animated == true) {
    vshift++;
  }

// image buffer in case you want to add pre-FX or generate the input

  pg2.beginDraw();
  pg2.image(pg,0,0,width,height);
  if (mode == 6) {
     pg2.rotateX(0.3);
     pg2.translate(0,height/8*3,10);
     translate(0,0,-100);
  } else if (mode == 7) {
     translate(0,0,-200);
     rotateX(0.7);
     pg2.translate(0,0,-50);
     translate(0,(vshift*10)-100,vshift-100);

  } else if (mode == 8) {
     translate(0,0,-200);
     rotateX(0.7);
     pg2.translate(0,0,-50);
     translate(0,-100,vshift-100);

  }
  
  

    //more cam stuff you can comment out
 // background(0,0,0,100);
 // if (cam.available() == true) {
 //   cam.read();
  //}
  // pg2.clear();
  // pg2.image(cam,0,0,width,height);

  
  
    // draw stuff here
  pg2.endDraw();
  //pg2.beginDraw();
  //pg2.push();
 // pg2.background(0);

 // pg2.rotate(frameCount*0.02);
//  pg2.stroke(255);
 // pg2.fill(200);
//  pg2.rectMode(CENTER);
//  pg2.box(width/2,height/2,height/8);
 // pg2.rect(width/2,height/2,height/8,height/8);
//  pg2.pop();
//  pg2.endDraw();
  

   
  
  // the glitch algo
  
  
  int index = 0;

  pg2.loadPixels();
  for (int y = 1; y < pg2.height; y++) {
   translate(0,  1);
    pushMatrix();
    for (int x = 0; x < pg2.width; x++) {
      int pixelColor = pg2.pixels[index];
    
    translate(1,  0);
    noStroke();


    int r = (pixelColor >> 16) & 0xFF;  
    int g = (pixelColor >> 8) & 0xFF;   
    int b = pixelColor & 0xFF;          
    fill(r, g, b);
    color pixCol = color(r, g, b);
    int v = r+g+b/3;

  
  if (mode == 0) {
    colorMode(RGB);
      
    if (v < intensity) {
      if (v < intensity/5) {
        noFill();
        rect((int(-vshift)*0.05*v),0,1,1);
      }
      rect(int(vshift)*0.05*v,v*0.02,1,1);
    } else {
      if (v > intensity) {
      rect((int(-vshift)*0.05*v),(int((-vshift*1.618))*0.05*hue(pixCol)),1,1);
     
     
      fill(r, g, b);
   
    }else {
      rect(0,0,1,1);
    }
    }
  } else  if (mode == 1) {
     if (v > intensity) {
      if (v > intensity*2.3) {
        
        rect((int(-vshift)*0.05*v),0.07*v,2,1);
      }
      rect(int(vshift)*0.05*v,(int((-vshift*1.618))*0.05*hue(pixCol)),1,1);
    } else {
      if (v < intensity) {
      rect((int(-vshift)*0.05*v),0,1,1);
     
     
      fill(r, g, b);
   
    }else {
      rect(0,0,1,1);
    }
    
  }
  } else  if (mode == 2) {
     
     
     if (v < intensity) {
      if (v < intensity/5) {
        
        rect((int(-vshift)*0.05*hue(pixCol)),(int((vshift*1.618))*0.05*hue(pixCol)),1,1);
      }
      rect(int(vshift)*0.05*hue(pixCol),(int((-vshift*1.618))*0.05*hue(pixCol)),1,1);
    } else {
      if (v > 100) {
      rect((int(-vshift)*0.05*hue(pixCol)),0,1,1);
     
     
      fill(pixCol);
   
    }else {
      rect(0,0,1,1);
    }
    }
      
    
    
  
  } else  if (mode == 3) {
        float h = hue(pixCol);
        float s = saturation(pixCol);
        colorMode(HSB);
        color pixCol2 = color(h,s,v);
        colorMode(RGB);
        fill(pixCol);
        if (s < intensity) {
        blendMode(BLEND);
        rect(int(vshift)*0.05*hue(pixCol2),0,1,1);
        } else {
        blendMode(BLEND);
        fill(pixCol);
        rect(int(vshift)*0.05*hue(pixCol2),(int(-vshift)*0.05*hue(pixCol2))*1.618,1,1);
        }

    
    } else  if (mode == 4) {
        float h = hue(pixCol);
        float s = saturation(pixCol);
        colorMode(HSB);
        color pixCol2 = color(h,s,v);
        colorMode(RGB);
        fill(pixCol);
        blendMode(BLEND);
        rect(int(vshift)*0.05*hue(pixCol2),0,1,1);
        blendMode(BLEND);
        fill(pixCol);
        rect(int(vshift)*0.05*hue(pixCol2),(int(-vshift)*0.05*hue(pixCol2))*1.618,1,1);

    
    } else  if (mode == 5) {
        float h = hue(pixCol);
        float s = saturation(pixCol);

        fill(pixCol);
        blendMode(BLEND);
        rect(int(vshift)*0.05*s,0,1,1);
        blendMode(BLEND);
        fill(pixCol);
        rect(int(vshift)*0.05*-s,(int(-vshift)*0.05*hue(pixCol))*1.618,1,1);

    } else  if (mode == 6) {
        float h = hue(pixCol);
        float s = saturation(pixCol);
       
        fill(pixCol);
        blendMode(BLEND);
        rect(int(vshift)*0.05*s,0,1,1);
        blendMode(BLEND);
        fill(pixCol);
         push();
        if (v > intensity) {
       
        translate(0,0,v*vshift*0.05);
        rect(int(vshift)*0.05*-s,(int(-vshift)*0.05)*1.618,1,1);
        } else {
        rect(int(vshift)*0.05*-s,(int(-vshift)*0.05)*1.618,1,1);
        }
        pop();
  

    } else  if (mode == 7) {
        float h = hue(pixCol);
        float s = saturation(pixCol);
        push();
        blendMode(BLEND);
        fill(pixCol, 100);
        
        if (v > intensity) {
        
        translate(0,0,v*vshift*0.05);
        rect(0,0,1,1);
        
        } else {
        rect(0,0,1,1);
        }
        pop();
    }   else  if (mode == 8) {
        float h = hue(pixCol);
        float s = saturation(pixCol);
        push();
        blendMode(BLEND);
        fill(pixCol, 100);
        
        if (h > intensity) {
        
        translate(0,0,h*vshift*0.05);
        rect(0,0,1,1);
        
        } else {
        rect(v*vshift*0.03,h*vshift*0.08,1,1);
        }
        pop();
      
    }
    
  
    
    index++;

  
    }
    popMatrix();
  }


  

  if (keyPressed) {
      if (key == 's') {
      saveFrame("output_" + floor(mode) + ".png");
      println("saved output_" + floor(mode) + ".png");
      } else if (key == 'a') {
      mode = mode+1;
      println("mode = " + mode);
      } else if (key == 'd') {
      mode = mode-1;
      println("mode = " + mode);
      } else if (key == '2') {
      intensity = intensity+5;
      println("intensity threshold = " + intensity);
      } else if (key == '1') {
      intensity=intensity-5;
      println("intensity threshold = " + intensity);
    }
  }
  
    if (frameCount > startFrame) {
      if (animated == true) {
  //  gifExport.addFrame();
      }
    }
  if (frameCount == startFrame+animLength) {
    if (animated == true) {
//    gifExport.finish();
  }
    }
  }

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      vshift=vshift+1;
      println("vshift = " + vshift);
    } else if (keyCode == DOWN) {
      vshift=vshift-1;
      println("vshift = " + vshift);
    
    }
}
}
