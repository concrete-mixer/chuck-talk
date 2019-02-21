SinOsc gen; // declare a sine oscillator (440hz is default frequency)
gen => dac; // connect to sound card, note => "chuck" operator
0.1 => gen.gain; // make not extremely loud
dac => WvOut2 wav => blackhole;
"out" => wav.wavFilename;
while (1) {
    1::second => now; // yield for one second, audio from gen is generated and passed to sound card
    // REPEATS ETERNALLY
}
