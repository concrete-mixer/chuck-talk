PulseOsc gen => Envelope env => dac;

dac => WvOut2 wav => blackhole;
"out" => wav.wavFilename;
env => Delay delay => dac;
0.01 => gen.gain;

SinOsc pwmOsc => blackhole;
0.125 => pwmOsc.freq;

spork ~ pwm();
333::ms => delay.max;
333::ms => delay.delay;
0.5 => delay.gain;

392 => float g4;
329.63 => float e4;
293.66 => float d4;
261.63 => float c4;
[e4, d4, c4, d4, e4, e4, e4, e4, d4, d4, d4, d4, e4, g4, g4, g4] @=> float notes[]; // declare notes as a sequence

// play the sequence as before
for(0 => int i; i < notes.cap(); i++) {
    notes[i] => gen.freq; // change frequency
    env.keyOn();
    260::ms => now;
    env.keyOff();
    240::ms => now;
    <<< i, notes[i] >>>;
}

fun void pwm() {
    while (true) {
        pwmOsc.last() * .95 => gen.width;
        1::ms => now;
    }
}
