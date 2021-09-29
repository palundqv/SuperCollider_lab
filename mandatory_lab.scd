//DM1595 Program Development for Interactive Media
//SuperCollider, Mandatory Lab
//
//
//Plase write your name(s):
//
//
// Don't forget to comment your code!


////////////////////////////
///                      ///
///        Task 1        ///
///                      ///
////////////////////////////

// Additive synthesis Synth




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

//Write your Synth here now:




////////////////////////////
///                      ///
///        Task 3        ///
///                      ///
////////////////////////////

// The previous two synths with envelopes




////////////////////////////
///                      ///
///        Task 4        ///
///                      ///
////////////////////////////

// Granulation:

(
SynthDef(\grain, {
	arg ...

	var
	sound = // ... //
	grain = GrainIn.ar(2, ...), //Pay attention here: thanks to that "2" the granulator will produce a stereo sound. If you want a mono sound, then write 1 instead.

	Out.ar(0, grain);
}).add
)

