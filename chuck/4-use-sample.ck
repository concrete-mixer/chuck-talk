SndBuf2 wave => Envelope env => dac;
dac => WvOut2 wav => blackhole;
"out" => wav.wavFilename;
me.dir() + "/baa1.wav" => wave.read;

0.2 => wave.gain;

// Speeds of sample to generate different pitches
0 => float none; 1.0 => float root;
1.5 => float dom; 1.25 => float third;
1.143 => float sec;

[
    third, sec, root, sec, third, third, third, none, sec, sec, sec, none, third, dom, dom, none,
    third, sec, root, sec, third, third, third, third, sec, sec, third, sec, root, none, root, none
] @=> float notes[]; // declare notes as a sequence

[
    1, 1, 1, 1, 1, 1, 2, 0, 1, 1, 2, 0, 1, 1, 2, 0,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0, 2, 0
] @=> int durations[]; // declare notes as a sequence

// play the sequence
for(0 => int i; i < notes.cap(); i++) {
    if (durations[i] == 0) {
        continue;
    }

    0 => wave.pos;
    notes[i] => wave.rate;
    env.keyOn();

    if (durations[i] == 2) {
        760::ms => now;
    } else {
        260::ms => now;
    }

    env.keyOff();
    240::ms => now;
}
