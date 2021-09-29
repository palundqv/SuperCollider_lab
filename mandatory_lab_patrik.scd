//DM1595 Program Development for Interactive Media
//SuperCollider, Mandatory Lab
//
//
//Plase write your name(s): Patrik Lundqvist, Vivi Andersson
//
//
// Don't forget to comment your code!

// ctr + b server start
// ctrl + enter define function
// shift + enter run code
// ctrl + . stop playing



////////////////////////////
///                      ///
///        Task 1        ///
///                      ///
////////////////////////////
// Write a Synth using additive synthesis, no matter the method you want to implement,
// with the following properties: given a fundamental frequency \freq, it generates a
// sound based on its odd harmonics (at least 5), with decreasing amplitudes for each
// partial.


// Additive synthesis Synth
s.boot

(
SynthDef(\odd, {
    arg freq = 440, amp = 0.3;
    var
    sin1 = SinOsc.ar(freq*3, 0, amp/1),
    sin2 = SinOsc.ar(freq*5, 0, amp/2),
	sin3 = SinOsc.ar(freq*7, 0, amp/3),
	sin4 = SinOsc.ar(freq*9, 0, amp/4),
	sin5 = SinOsc.ar(freq*11, 0, amp/5),
	add_sin = sin1 + sin2 + sin3 + sin4 + sin5; // here we add all the sinusoids
    Out.ar(0, add_sin);
}).add;
)

Synth(\odd);


////////////////////////////
///                      ///
///        Task 2        ///
///                      ///
////////////////////////////

// Subtractive synthesis Synth
// Use the UGen Klank.ar. You can read about it using the documentation help.
// Watch the ` before the opening bracket of the parameter array!
// It is needed to make Klank properly read the array you will give to it.
//
// Here is an example:
{Klank.ar(`[[300, 389, 450, 560], [0.1, 0.2, 0.3, 0.1]], Impulse.ar(2, 0, 0.5))!2}.play;

// Write a Synth using Klank.ar with PinkNoise as its input source. Fill the frequency
// array with 10 harmonic partials randomly detuned by ±10%. (Hint: a value generated
// by rrand(0.9, 1.1) represents a 10% deviation). Pay attention to the amplitudes!


//Write your Synth here now:

(
SynthDef(\sub_synth, {
	var frequencies, amplitudes, klank_sound;
	frequencies = Array.fill(10, {arg i; i+1*440*rrand(0.9, 1.1)}); //create an 10-size array with random deviation of 10%
	amplitudes = Array.fill(10, {arg i; 0.5/(i+1)}); //10-size array with decreasing ampliuted for cool effect
	klank_sound = Klank.ar(`[frequencies, amplitudes], PinkNoise.ar([0.007, 0.007]));
    Out.ar(0, klank_sound);
}).add;
)

Synth(\sub_synth);


////////////////////////////
///                      ///
///        Task 3        ///
///                      ///
////////////////////////////

// The previous two synths with envelopes

// Rework both previous synths so the first one is shaped by a perc envelope with
// attackTime = 0.01s and releaseTime = 0.5s, and the second one by a triangle
// envelope with duration = 5s and level = 0.7.

(
SynthDef(\odd_env, {
    arg freq = 100, amp = 0.5;
    var
	envelope = Env.perc(0.01, 0.5, 1, -4.0),
    sin1 = SinOsc.ar(freq*3, 0, amp),
    sin2 = SinOsc.ar(freq*5, 0, amp/2),
	sin3 = SinOsc.ar(freq*7, 0, amp/3),
	sin4 = SinOsc.ar(freq*9, 0, amp/4),
	sin5 = SinOsc.ar(freq*11, 0, amp/5),
	add_sin = sin1 + sin2 + sin3 + sin4 + sin5, // here we add all the sinusoids
    sound = EnvGen.kr(envelope, doneAction:2)*add_sin;
	Out.ar(0, sound);
}).add;
)

Synth(\odd_env);



(
SynthDef(\sub_synth_env, {
	var frequencies, amplitudes, klank_sound, sound, envelope;
	envelope = Env.triangle(5, 0.7);
	frequencies = Array.fill(10, {arg i; i+1*440*rrand(0.9, 1.1)}); //create an 10-size array with random deviation of 10%
	amplitudes = Array.fill(10, {arg i; 0.5/(i+1)}); //10-size array with decreasing ampliuted for cool effect
	klank_sound = Klank.ar(`[frequencies, amplitudes], PinkNoise.ar([0.007, 0.007]));
	sound = EnvGen.kr(envelope, doneAction:5)*klank_sound;
    Out.ar(0, sound);
}).add;
)

Synth(\sub_synth_env);


////////////////////////////
///                      ///
///        Task 4        ///
///                      ///
////////////////////////////

// Granulation:

// The GrainIn.ar UGen is a granulator: it granulates an input signal, meaning it
// basically chunks the signal in microportions (grains) triggered by a given function.
// Give also a look at the help file for GrainIn.ar. This said, take the Task 1 (additive
// synthesis without the envelope) and set a fundamental frequency of 440Hz. Use that
// sound as input signal for the granulator. Also use the X cursor position to control the
// impulse frequency between 10 and 100 Hz and the Y position to control the grain size
// between 0.001 and 0.01 s. Run this new synth and make a video recording of your
// screen (with audio) while exploring the sound-space with the mouse. It will be useful
// having the FreqScope.new in foreground to visualize what is going on.


(
SynthDef(\grain, {
	arg freq = 440, amp = 0.5;

	var
	sin1 = SinOsc.ar(freq*3, 0, amp/1),
    sin2 = SinOsc.ar(freq*5, 0, amp/2),
	sin3 = SinOsc.ar(freq*7, 0, amp/3),
	sin4 = SinOsc.ar(freq*9, 0, amp/4),
	sin5 = SinOsc.ar(freq*11, 0, amp/5),
	sound = sin1 + sin2 + sin3 + sin4 + sin5, // here we add all the sinusoids

	panX = MouseX.kr(10, 100),
	panY = MouseY.kr(0.001, 0.01),

	grain = GrainIn.ar(2, Impulse.kr(panX), panY, sound); //Pay attention here: thanks to that "2" the granulator will produce a stereo sound. If you want a mono sound, then write 1 instead.

	Out.ar(0, grain!2);
}).add
)

FreqScope.new;
Synth(\grain);
