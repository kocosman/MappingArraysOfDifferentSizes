
float[] input;

float[] small;
float[] smallRef;
float[] smallError;

float[] large;
float[] largeRef;
float[] largeError;

int inputSize = 100;
int smallSize = 15;
int largeSize = 105;

float smallErrorMax = 0;
float largeErrorMax = 0;

void setup() {
  size(800, 600);
  background(0);

  input = new float[inputSize];
  
  small = new float[smallSize];
  smallRef = new float[smallSize];
  smallError = new float[smallSize];
  
  large = new float[largeSize];
  largeRef = new float[largeSize];
  largeError = new float[largeSize];

  for (int i = 0; i < input.length; i++) {
    input[i] = 30*sin(map(i, 0, input.length, 0, TWO_PI));
  }

  for (int i = 0; i < small.length; i++) {
    small[i] = 1;
    smallRef[i] = 30*sin(map(i, 0, small.length, 0, TWO_PI));
  }

  for (int i = 0; i < large.length; i++) {
    large[i] = 1;
    largeRef[i] = 30*sin(map(i, 0, large.length, 0, TWO_PI));
  }


  small = mapArrays(input, small.length);
  large = mapArrays(input, large.length);

  for (int i = 0; i < small.length; i++) {
    smallError[i] = small[i] - smallRef[i];
  }

  for (int i = 0; i < large.length; i++) {
    largeError[i] = large[i] - largeRef[i];
  }

  smallErrorMax = max(smallError);
  largeErrorMax = max(largeError);

  println("SmallErrorMax: " + smallErrorMax);
  println("LargeErrorMax: " + largeErrorMax);
}

void draw() {
  background(0);

  stroke(255);
  strokeWeight(1);
  for (int i = 0; i < input.length; i++) {
    float x = map(i, 0, input.length, 0, width);
    line(x, height/2, x, height/2+input[i]);
  }


  for (int i = 0; i < small.length; i++) {
    float x = map(i, 0, small.length, 0, width);
    line(x, height/4, x, height/4+small[i]);
  }


  for (int i = 0; i < large.length; i++) {
    float x = map(i, 0, large.length, 0, width);
    line(x, height*3/4, x, height*3/4+large[i]);
  }
}


float[] mapArrays(float[] in, int outputLength) {
  float[] out = new float[outputLength];

  if (in.length == out.length) {
    return in;
  } else {
    for (int i = 0; i < out.length; i++) {
      float index = map(i, 0, out.length, 0, in.length);
      int indexBase = floor(index);
      float indexLerp = index-indexBase;
      out[i] = lerp(in[indexBase], in[constrain(indexBase+1, 0, in.length-1)], indexLerp);
    }
  }
  return out;
}