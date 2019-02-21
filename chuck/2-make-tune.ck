SinOsc gen => ADSR adsr => dac;
dac => WvOut2 wav => blackhole;

"out" => wav.wavFilename;
0.1 => gen.gain;
adsr.set(50::ms, 80::ms, 0.5, 50::ms);

392 => float g4;
329.63 => float e4;
293.66 => float d4;
261.63 => float c4;
[e4, d4, c4, d4, e4, e4, e4, e4, d4, d4, d4, d4, e4, g4, g4, g4] @=> float notes[]; // declare notes as a sequence

// play the sequence
for(0 => int i; i < notes.cap(); i++) {
    notes[i] => gen.freq; // change frequency
    adsr.keyOn();
    260::ms => now;
    adsr.keyOff();
    240::ms => now;
}
