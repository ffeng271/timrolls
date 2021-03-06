import processing.pdf.*;
import de.voidplus.leapmotion.*;

LeapMotion leap;

int captureX=0;
int captureY=0;
int captureZ=0;
HDrawable poly;

boolean record = false;

HDrawablePool pool;
HDrawablePool pool2;
HDrawablePool pool3;
HDrawablePool pool4;

HTimer timer;
HColorPool colors;
HColorPool colors2;

HPixelColorist pcolors;
HColorField colorField;

HCanvas canvas;

PShader flipHalf;
PShader flipHalfY;

void setup(){
	size(displayWidth-300,displayHeight-300, P3D);
	frameRate(30);

	PImage bg= loadImage("color.jpg");
	bg.resize(width,height);
	H.init(this).use3D(true).backgroundImg(bg);
	smooth();

	leap = new LeapMotion(this);

	blendMode(SCREEN);

	canvas = (HCanvas) H.add(new HCanvas(P3D).autoClear(false).fade(3));
	H.add(canvas);

	flipHalf = loadShader("flipHalf.glsl");
	// flipHalfY = loadShader("flipHalfY.glsl");

	// HImage BG = new HImage("BG.jpg");
	// H.add(BG).anchorAt(H.CENTER).locAt(H.CENTER).size(1500).z(-1);

	// //rotate Background
	// new HOscillator()
	// 	.target(BG)
	// 	.property(H.ROTATION)
	// 	.range(-180, 180)
	// 	.speed(.3)
	// 	.freq(2)
	// 	// .waveform(H.SAW)
	// 	// .currentStep(i)
	// ;

	// HImage hitObj2 = new HImage("cloudy4.png");
	// H.add(hitObj2).anchorAt(H.CENTER).loc(650,600).rotation(00).size(1000).visibility(false);
	// hsl2 = new HShapeLayout().target(hitObj2);

	pcolors= new HPixelColorist("BG.jpg")
	// .fillOnly()
	// .strokeOnly()
	.fillAndStroke()
	;

	// colorField = new HColorField(width, height)
	// 	.addPoint(0, height/2, #ff0066, 0.5f)
	// 	// .addPoint(width/2, height-200, #3300FF, 0.3f)
	// 	.addPoint(width/2, 0, #00ff2f, 0.2f)
	// 	.addPoint(width/2, height/2, #fff195, 0.2f)
	// 	// .fillOnly()
	// 	.strokeOnly()
	// 	// .fillAndStroke()
	// ;


	colors2 = new HColorPool()

		.add(#ffffff,10) //white
		.add(#FF7214,5) //grey
		.add(#dee7ff)
		.add(#bce8ef)
		// .fillOnly()
	;

	colors = new HColorPool()
		.add(#bbe8d4,2)  //green
		.add(#48225f,3) //purple
		.add(#eb7d96,2) //pink
		.add(#ffffff,10)
		.fillOnly()
	;

	 poly= new HPath().polygon(3);
     canvas.add(poly.x(captureX).x(captureY).fill(0).anchorAt(H.CENTER));

    	// 			 new HOscillator()
					// 	.target(poly)
					// 	.property(H.SIZE)
					// 	.range(20, 250)
					// 	.speed(random(0.1,2))
					// 	.freq(random(8))
					// 	// .waveform(H.SAW)
					// 	// .currentStep(i+10)
					// ;


					// new HOscillator()
					// 	.target(d)
					// 	.property(H.WIDTH)
					// 	.range(5, 300)
					// 	.speed(.1)
					// 	.freq(random(4))
					// 	// .waveform(H.SAW)
					// 	// .currentStep(i+10)
					// ;



					new HOscillator()
						.target(poly)
						.property(H.ROTATIONX)
						.range(-60, 60)
						.speed(.2)
						.freq(random(3))
						// .waveform(H.TRIANGLE)
						// .currentStep(i+100)
					;

					new HOscillator()
						.target(poly)
						.property(H.ROTATIONY)
						.range(-30, 30)
						.speed(.2)
						.freq(3)
						// .waveform(H.SAW)
						// .currentStep(i)
					;

					new HOscillator()
						.target(poly)
						.property(H.ROTATIONZ)
						.range(-360, 0)
						.speed(2)
						.freq(random(2,5))
						// .waveform(H.SAW)
					;


	// pool = new HDrawablePool(10); //Shapes
	// // pool.autoAddToStage()
	// pool.autoParent(canvas)

	// 	// .add(new HRect(1))
	// 	// .add(new HEllipse(10))
	// 	// .add (new HShape("peeta8.svg").enableStyle(false).anchorAt(H.CENTER))
	// 	// .add (new HShape("peeta10.svg").enableStyle(false).anchorAt(H.CENTER))
	// 	.add (new HShape("wave1.svg").enableStyle(false))
	// 	.add (new HShape("wave2.svg").enableStyle(false))
	// 	.add (new HShape("wave3.svg").enableStyle(false))
	// 	.add (new HShape("wave4.svg").enableStyle(false))
	// 	.add (new HShape("wave5.svg").enableStyle(false).anchorAt(H.CENTER))						
	// 	// .add ( new HPath().polygon(3) )
	// 	// .add ( new HPath().polygon(6) )

	// 	// .layout(
	// 	// 	new HGridLayout()
	// 	// 	.cols(35)
	// 	// 	.spacingX(20)
	// 	// 	.spacingY(10)
	// 	// 	.startX(160)
	// 	// 	.startY(160)
	// 	// )

	// 	// .layout(
	// 	// 	new HHexLayout()

	// 	// 	.spacing(15)
	// 	// 	.offsetX(0)
	// 	// 	.offsetY(0)
	// 	// )

	// 	.onCreate(
	// 		new HCallback() {
	// 			public void run(Object obj) {
	// 				int i = pool.currentIndex();
	// 				HDrawable d = (HDrawable) obj;
	// 				d
	// 					// .enableStyle(false)
	// 					// .strokeJoin(ROUND)
	// 					// .strokeCap(ROUND)
	// 					// .strokeWeight(1)
	// 					// .stroke(#000000)
	// 					// .noFill()
	// 					// .fill(#000000)
	// 					.noStroke()
	// 					// .anchorAt(H.CENTER)
	// 					.anchor(random(-100,100),random(-100,100))
	// 					// .rotate( (int)random(4) * 90 )
	// 					// .size((int)random(1,3)*100)
	// 					.x(random(0,width/2))
	// 					.y(height/2)
	// 					.size( ( (int)random(1,4) * 50 ) ) // 50, 100, 150, 200
	// 				;
	// 				// d.randomColors(colors.fillOnly());
	// 				// layout.applyLayout(d);
	// 				pcolors.applyColor(d);

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.SIZE)
	// 					.range(20, 250)
	// 					.speed(random(0.1,2))
	// 					.freq(random(8))
	// 					// .waveform(H.SAW)
	// 					.currentStep(i+10)
	// 				;

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.Z)
	// 					.range(0, 100)
	// 					.speed(.5)
	// 					.freq(2)
	// 					.waveform(H.SAW)
	// 					.currentStep(i)
	// 				;

	// 				// new HOscillator()
	// 				// 	.target(d)
	// 				// 	.property(H.WIDTH)
	// 				// 	.range(5, 300)
	// 				// 	.speed(.1)
	// 				// 	.freq(random(4))
	// 				// 	// .waveform(H.SAW)
	// 				// 	// .currentStep(i+10)
	// 				// ;

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.X)
	// 					.range(random(width/2), width-300)
	// 					.speed(random(0.1,1.5))
	// 					.freq(random(2))
	// 					.waveform(H.SAW)
	// 					.currentStep(i)
	// 				;

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.Y)
	// 					.range(300, height-300)
	// 					.speed(random(0.1,1))
	// 					.freq(random(4))
	// 					// .waveform(H.SAW)
	// 					.currentStep(i+120)
	// 				;

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.ROTATIONX)
	// 					.range(-60, 60)
	// 					.speed(.2)
	// 					.freq(random(3))
	// 					// .waveform(H.TRIANGLE)
	// 					// .currentStep(i+100)
	// 				;

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.ROTATIONY)
	// 					.range(-30, 30)
	// 					.speed(.2)
	// 					.freq(3)
	// 					// .waveform(H.SAW)
	// 					// .currentStep(i)
	// 				;

	// 				new HOscillator()
	// 					.target(d)
	// 					.property(H.ROTATIONZ)
	// 					.range(-360, 0)
	// 					.speed(.2)
	// 					.freq(random(2,5))
	// 					// .waveform(H.SAW)
	// 					.currentStep(i)
	// 				;

					
	// 			}
	// 		}
	// 	)
	// 	.requestAll()
	// ;

	pool4 = new HDrawablePool(91); //Grid
	// pool4.autoAddToStage()
	pool4.autoParent(canvas)
		.add( new HPath() )

		.layout(
			new HHexLayout()
			.spacing(45)
			.offsetX(0)
			.offsetY(0)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool4.currentIndex();
					HPath d = (HPath) obj;
					d
						.polygon(4)
						.rotate(30)
						.size(70)
						.anchorAt(H.CENTER)
						.strokeJoin(ROUND)
						.strokeCap(ROUND)
						.strokeWeight(1.5)
						.stroke(colors.getColor(),150)
						.noFill()
						.z(captureZ*5)
					;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.SIZE)
					// 	// .relativeVal(d.y())
					// 	.range(20, 150)
					// 	.speed(1.5)
					// 	.freq(random(8))

					// 	.currentStep(i)
					// ;

					// new HOscillator()
					// 	.target(d)
					// 	.property(H.X)
					// 	.relativeVal(captureX)
					// 	.range(20, width/2)
					// 	.speed(1.5)
					// 	.freq(random(8))

					// 	.currentStep(i)
					// ;

					new HOscillator()
						.target(d)
						.property(H.Y)
						.relativeVal(captureY)
						.range(20, height-20)
						.speed(1.5)
						.freq(random(8))

						.currentStep(i)
					;


				}
			}
		)

		.requestAll()
	;




}

 
void draw() {

	// background(255);

	int fps = leap.getFrameRate();
    
    // ========= HANDS =========
    
  for(Hand hand : leap.getHands()){

    // ----- BASICS -----
        
    // int     hand_id          = hand.getId();
    // PVector hand_position    = hand.getPosition();
    // PVector hand_stabilized  = hand.getStabilizedPosition();
    // PVector hand_direction   = hand.getDirection();
    // PVector hand_dynamics    = hand.getDynamics();
    // float   hand_roll        = hand.getRoll();
    // float   hand_pitch       = hand.getPitch();
    // float   hand_yaw         = hand.getYaw();
    // boolean hand_is_left     = hand.isLeft();
    // boolean hand_is_right    = hand.isRight();
    // float   hand_grab        = hand.getGrabStrength();
    // float   hand_pinch       = hand.getPinchStrength();
    // float   hand_time        = hand.getTimeVisible();
    // PVector sphere_position  = hand.getSpherePosition();
    // float   sphere_radius    = hand.getSphereRadius();


    // ----- SPECIFIC FINGER -----
        
    Finger  finger_thumb     = hand.getThumb();
    // or                      hand.getFinger("thumb");
    // or                      hand.getFinger(0);

    Finger  finger_index     = hand.getIndexFinger();
    // or                      hand.getFinger("index");
    // or                      hand.getFinger(1);

    Finger  finger_middle    = hand.getMiddleFinger();
    // or                      hand.getFinger("middle");
    // or                      hand.getFinger(2);

    Finger  finger_ring      = hand.getRingFinger();
    // or                      hand.getFinger("ring");
    // or                      hand.getFinger(3);

    Finger  finger_pink      = hand.getPinkyFinger();
    // or                      hand.getFinger("pinky");
    // or                      hand.getFinger(4);        


    // ----- DRAWING -----
        
    // hand.draw();

    

            // ========= FINGERS =========

        for(Finger finger : hand.getFingers()){


            // ----- BASICS -----

            int     finger_id         = finger.getId();
            PVector finger_position   = finger.getPosition();
            PVector finger_stabilized = finger.getStabilizedPosition();
            PVector finger_velocity   = finger.getVelocity();
            PVector finger_direction  = finger.getDirection();
            float   finger_time       = finger.getTimeVisible();


            // ----- SPECIFIC FINGER -----

            switch(finger.getType()){
                case 0:
                    // System.out.println("thumb");
                    break;
                case 1:
                    // System.out.println("index " + (int)finger_stabilized.x +" "+ (int)finger_stabilized.y);
                    break;
                case 2:
                    // System.out.println("middle");
                    break;
                case 3:
                    // System.out.println("ring");
                    break;
                case 4:
                    // System.out.println("pinky");
                    break;
            }

        captureX = (int)finger_index.getStabilizedPosition().x;
        captureY = (int)finger_index.getStabilizedPosition().y;
        captureZ = (int)finger_index.getPosition().z;

        poly.x(captureX).y(captureY).size(captureZ*3);
        pcolors.applyColor(poly).alpha(150);    
        
   }

   	for (HDrawable temp : pool4) {
		HDrawable d = (HDrawable) temp;
		pcolors.applyColor(d);
		d.x(captureX+random(200));
		d.size(captureZ);
	}

  	H.drawStage();
  	filter(flipHalf); //flip half composition with glsl shader

}



	// for (HDrawable temp : pool) {
	// 	HDrawable d = (HDrawable) temp;
	// 	pcolors.applyColor(d);
	// }

	// filter(flipHalfY); //flip half composition with glsl shader

	// if(frameCount % 1 == 0 && frameCount < 450){
	// 	saveFrame("../frames/image-#####.png");
	// }

	frame.setTitle(int(frameRate) + " fps"); //set framerate to window title
}


void keyPressed() {


	if (key == ' ') {
		if (paused) {
			loop();
			paused = false;
		} else {
			noLoop();
			paused = true;
		}
	}


	if (key == 'r') {
		record = true;
		saveFrame("tif/render_####.tif");
		// saveVector();
		// H.drawStage();
	}

}


void saveVector() {
	PGraphics tmp = null;
	tmp = beginRecord(PDF, "pdf/render_#####.pdf");

	if (tmp == null) {
		H.drawStage();
	} else {
		H.stage().paintAll(tmp, false, 1); // PGraphics, uses3D, alpha
	}

	endRecord();
}
