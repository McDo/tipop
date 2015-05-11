// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.


var POP = require("guy.mcdooooo.tipop");

var window = Ti.UI.createWindow({
	title: 'Tipop Demo'
});

var square = Ti.UI.createView({
	width: 100,
	height: 100,
	backgroundColor: "#52EDC7",
	borderRadius: 5
});

var circle = Ti.UI.createView({
	width: 30,
	height: 30,
	backgroundColor: "#FF2D55",
	borderRadius: 15
});

var btn = Ti.UI.createButton({
	title: "GO",
	tintColor: "#FF3B30",
   	width: 100,
   	height: 70,
   	bottom: 100
});

square.add( circle );
window.add( square );
window.add( btn );

btn.addEventListener('click', function() {
	
	POP
 /* .basic 
  * .spring 
  * .decay */
	.decay(square, {
		subTranslate: {
			x: -66,
			y: 75
		},
		color: "#EF4DB6",
		left: 10,
		top: 10,
		width: 202,
		height: 420,
		backgroundColor: "#c644fc",
		opacity: 0.45,
		rotate: {
			x: 145,
			// y: 145,
			z: 42
		},
		scale: {
			x: 4.5,
			y: 2.5
		},
		translate: {
			x: -220,
			y: 200,
			z: 830
		},
		borderRadius: 75,
		borderColor: "#FFD3E0",
		borderWidth: 1,
		shadowColor: "#55EFCB",
		shadowOpacity: 0.2,
		zIndex: 20,
		// duration: 1030,
		delay: 900,
		// repeatCount: 16,
		// addictive: true,
		// easing: "easeOutCirc",
		// springBounciness: 15,
		// springSpeed: 10
	}, function() {
		Ti.API.info('all animations completed.');
	});
});

window.open();


