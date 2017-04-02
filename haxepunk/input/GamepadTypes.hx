package haxepunk.input;

/**
 * Mapping to use a Xbox gamepad with `Gamepad`.
 */
class XBOX_GAMEPAD
{
#if mac
	/**
	 * Button IDs
	 */
	public static inline var A_BUTTON:Int = 0;
	public static inline var B_BUTTON:Int = 1;
	public static inline var X_BUTTON:Int = 2;
	public static inline var Y_BUTTON:Int = 3;
	public static inline var LB_BUTTON:Int = 4;
	public static inline var RB_BUTTON:Int = 5;
	public static inline var BACK_BUTTON:Int = 9;
	public static inline var START_BUTTON:Int = 8;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 6;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 7;

	public static inline var XBOX_BUTTON:Int = 10;

	public static inline var DPAD_UP:Int = 11;
	public static inline var DPAD_DOWN:Int = 12;
	public static inline var DPAD_LEFT:Int = 13;
	public static inline var DPAD_RIGHT:Int = 14;

	/**
	 * Axis array indicies
	 */
	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var RIGHT_ANALOGUE_X:Int = 3;
	public static inline var RIGHT_ANALOGUE_Y:Int = 4;
	public static inline var LEFT_TRIGGER:Int = 2;
	public static inline var RIGHT_TRIGGER:Int = 5;
#elseif ouya
	public static inline var A_BUTTON:Int = 0;
	public static inline var B_BUTTON:Int = 1;
	public static inline var X_BUTTON:Int = 3;
	public static inline var Y_BUTTON:Int = 4;
	public static inline var LB_BUTTON:Int = 6;
	public static inline var RB_BUTTON:Int = 7;
	public static inline var BACK_BUTTON:Int = 13;
	public static inline var START_BUTTON:Int = 12;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 10;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 11;

	public static inline var DPAD_UP:Int = 0;
	public static inline var DPAD_DOWN:Int = 1;
	public static inline var DPAD_LEFT:Int = 2;
	public static inline var DPAD_RIGHT:Int = 3;

	/**
	 * Axis array indicies
	 */
	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var RIGHT_ANALOGUE_X:Int = 12;
	public static inline var RIGHT_ANALOGUE_Y:Int = 13;
	public static inline var LEFT_TRIGGER:Int = 11;
	public static inline var RIGHT_TRIGGER:Int = 14;
#elseif linux
	/**
	 * Button IDs
	 */
	public static inline var A_BUTTON:Int = 0;
	public static inline var B_BUTTON:Int = 1;
	public static inline var X_BUTTON:Int = 2;
	public static inline var Y_BUTTON:Int = 3;
	public static inline var LB_BUTTON:Int = 4;
	public static inline var RB_BUTTON:Int = 5;
	public static inline var BACK_BUTTON:Int = 6;
	public static inline var START_BUTTON:Int = 7;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 9;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 10;

	public static inline var XBOX_BUTTON:Int = 8;

	public static inline var DPAD_UP:Int = 13;
	public static inline var DPAD_DOWN:Int = 14;
	public static inline var DPAD_LEFT:Int = 11;
	public static inline var DPAD_RIGHT:Int = 12;

	/**
	 * Axis array indicies
	 */
	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var RIGHT_ANALOGUE_X:Int = 3;
	public static inline var RIGHT_ANALOGUE_Y:Int = 4;
	public static inline var LEFT_TRIGGER:Int = 2;
	public static inline var RIGHT_TRIGGER:Int = 5;
#elseif android // android
	/**
	 * Button IDs
	 */
	public static inline var A_BUTTON:Int = 0;
	public static inline var B_BUTTON:Int = 1;
	public static inline var X_BUTTON:Int = 3;
	public static inline var Y_BUTTON:Int = 4;
	public static inline var LB_BUTTON:Int = 6;
	public static inline var RB_BUTTON:Int = 7;
	public static inline var BACK_BUTTON:Int = 13;
	public static inline var START_BUTTON:Int = 12;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 10;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 11;

	public static inline var DPAD_UP:Int = 0;
	public static inline var DPAD_DOWN:Int = 1;
	public static inline var DPAD_LEFT:Int = 2;
	public static inline var DPAD_RIGHT:Int = 3;

	/**
	 * Keep in mind that if TRIGGER axis returns value > 0 then LT is being pressed, and if it's < 0 then RT is being pressed
	 */
	public static inline var TRIGGER:Int = 2;
	/**
	 * Axis array indicies
	 */
	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var RIGHT_ANALOGUE_X:Int = 12;
	public static inline var RIGHT_ANALOGUE_Y:Int = 13;
	public static inline var LEFT_TRIGGER:Int = 4;
	public static inline var RIGHT_TRIGGER:Int = 5;
#else // windows
	/**
	 * Button IDs
	 */
	public static inline var A_BUTTON:Int = 10;
	public static inline var B_BUTTON:Int = 11;
	public static inline var X_BUTTON:Int = 12;
	public static inline var Y_BUTTON:Int = 13;
	public static inline var LB_BUTTON:Int = 8;
	public static inline var RB_BUTTON:Int = 9;
	public static inline var BACK_BUTTON:Int = 5;
	public static inline var START_BUTTON:Int = 4;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 6;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 7;

	public static inline var XBOX_BUTTON:Int = 14;

	public static inline var DPAD_UP:Int = 0;
	public static inline var DPAD_DOWN:Int = 1;
	public static inline var DPAD_LEFT:Int = 2;
	public static inline var DPAD_RIGHT:Int = 3;

	/**
	 * Axis array indicies
	 */
	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var RIGHT_ANALOGUE_X:Int = 2;
	public static inline var RIGHT_ANALOGUE_Y:Int = 3;
	public static inline var LEFT_TRIGGER:Int = 4;
	public static inline var RIGHT_TRIGGER:Int = 5;
#end
}

/**
 * Mapping to use a Rock Candy PS3 gamepad with `Gamepad`.
 */
class ROCK_PS3_GAMEPAD
{
#if ouya
	public static inline var TRIANGLE_BUTTON:Int = 3;
	public static inline var CIRCLE_BUTTON:Int = 2;
	public static inline var X_BUTTON:Int = 1;
	public static inline var SQUARE_BUTTON:Int = 0;
	public static inline var L1_BUTTON:Int = 4;
	public static inline var R1_BUTTON:Int = 5;
	public static inline var L2_BUTTON:Int = 6;
	public static inline var R2_BUTTON:Int = 7;
	public static inline var SELECT_BUTTON:Int = 8;
	public static inline var START_BUTTON:Int = 9;
	public static inline var PS_BUTTON:Int = 14;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 10;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 11;
	public static inline var DPAD_UP:Int = -1;
	public static inline var DPAD_DOWN:Int = -1;
	public static inline var DPAD_LEFT:Int = -1;
	public static inline var DPAD_RIGHT:Int = -1;

	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var TRIANGLE_BUTTON_PRESSURE:Int = 16;
	public static inline var CIRCLE_BUTTON_PRESSURE:Int = 17;
	public static inline var X_BUTTON_PRESSURE:Int = 18;
	public static inline var SQUARE_BUTTON_PRESSURE:Int = 19;
	public static inline var RIGHT_ANALOGUE_X:Int = 11;
	public static inline var RIGHT_ANALOGUE_Y:Int = 14;
#elseif android
	public static inline var TRIANGLE_BUTTON:Int = 3;
	public static inline var CIRCLE_BUTTON:Int = 2;
	public static inline var X_BUTTON:Int = 1;
	public static inline var SQUARE_BUTTON:Int = 0;
	public static inline var L1_BUTTON:Int = 4;
	public static inline var R1_BUTTON:Int = 5;
	public static inline var L2_BUTTON:Int = 6;
	public static inline var R2_BUTTON:Int = 7;
	public static inline var SELECT_BUTTON:Int = 8;
	public static inline var START_BUTTON:Int = 9;
	public static inline var PS_BUTTON:Int = 14;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 13;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 12;
	public static inline var DPAD_UP:Int = -2;
	public static inline var DPAD_DOWN:Int = -2;
	public static inline var DPAD_LEFT:Int = -2;
	public static inline var DPAD_RIGHT:Int = -2;

	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var TRIANGLE_BUTTON_PRESSURE:Int = 16;
	public static inline var CIRCLE_BUTTON_PRESSURE:Int = 17;
	public static inline var X_BUTTON_PRESSURE:Int = 18;
	public static inline var SQUARE_BUTTON_PRESSURE:Int = 19;
	public static inline var RIGHT_ANALOGUE_X:Int = 2;
	public static inline var RIGHT_ANALOGUE_Y:Int = 3;
#else
	public static inline var TRIANGLE_BUTTON:Int = 12;
	public static inline var CIRCLE_BUTTON:Int = 13;
	public static inline var X_BUTTON:Int = 14;
	public static inline var SQUARE_BUTTON:Int = 15;
	public static inline var L1_BUTTON:Int = 10;
	public static inline var R1_BUTTON:Int = 11;
	public static inline var L2_BUTTON:Int = 8;
	public static inline var R2_BUTTON:Int = 9;
	public static inline var SELECT_BUTTON:Int = 0;
	public static inline var START_BUTTON:Int = 3;
	public static inline var PS_BUTTON:Int = 16;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 1;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 2;
	public static inline var DPAD_UP:Int = 4;
	public static inline var DPAD_DOWN:Int = 6;
	public static inline var DPAD_LEFT:Int = 7;
	public static inline var DPAD_RIGHT:Int = 5;

	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var TRIANGLE_BUTTON_PRESSURE:Int = 16;
	public static inline var CIRCLE_BUTTON_PRESSURE:Int = 17;
	public static inline var X_BUTTON_PRESSURE:Int = 18;
	public static inline var SQUARE_BUTTON_PRESSURE:Int = 19;
	public static inline var RIGHT_ANALOGUE_X:Int = 2;
	public static inline var RIGHT_ANALOGUE_Y:Int = 3;
#end
}

/**
 * Mapping to use a PS3 gamepad with `Gamepad`.
 */
class PS3_GAMEPAD
{
#if ouya
	public static inline var TRIANGLE_BUTTON:Int = 4;
	public static inline var CIRCLE_BUTTON:Int = 1;
	public static inline var X_BUTTON:Int = 0;
	public static inline var SQUARE_BUTTON:Int = 3;
	public static inline var L1_BUTTON:Int = 6;
	public static inline var R1_BUTTON:Int = 7;
	public static inline var L2_BUTTON:Int = 8;
	public static inline var R2_BUTTON:Int = 9;
	public static inline var SELECT_BUTTON:Int = -1;
	public static inline var START_BUTTON:Int = 12;
	public static inline var PS_BUTTON:Int = 16777234;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 10;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 11;
	public static inline var DPAD_UP:Int = -1;
	public static inline var DPAD_DOWN:Int = -1;
	public static inline var DPAD_LEFT:Int = -1;
	public static inline var DPAD_RIGHT:Int = -1;

	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var TRIANGLE_BUTTON_PRESSURE:Int = 16;
	public static inline var CIRCLE_BUTTON_PRESSURE:Int = 17;
	public static inline var X_BUTTON_PRESSURE:Int = 18;
	public static inline var SQUARE_BUTTON_PRESSURE:Int = 19;
	public static inline var RIGHT_ANALOGUE_X:Int = 11;
	public static inline var RIGHT_ANALOGUE_Y:Int = 14;
#elseif android
	public static inline var TRIANGLE_BUTTON:Int = 4;
	public static inline var CIRCLE_BUTTON:Int = 1;
	public static inline var X_BUTTON:Int = 0;
	public static inline var SQUARE_BUTTON:Int = 3;
	public static inline var L1_BUTTON:Int = 6;
	public static inline var R1_BUTTON:Int = 7;
	public static inline var L2_BUTTON:Int = 8;
	public static inline var R2_BUTTON:Int = 9;
	public static inline var SELECT_BUTTON:Int = 13;
	public static inline var START_BUTTON:Int = 12;
	//Triggers Back Button
	public static inline var PS_BUTTON:Int = -2;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 10;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 11;
	//Passed As OnHatMove
	public static inline var DPAD_UP:Int = -2;
	public static inline var DPAD_DOWN:Int = -2;
	public static inline var DPAD_LEFT:Int = -2;
	public static inline var DPAD_RIGHT:Int = -2;

	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var TRIANGLE_BUTTON_PRESSURE:Int = 16;
	public static inline var CIRCLE_BUTTON_PRESSURE:Int = 17;
	public static inline var X_BUTTON_PRESSURE:Int = 18;
	public static inline var SQUARE_BUTTON_PRESSURE:Int = 19;
	public static inline var RIGHT_ANALOGUE_X:Int = 11;
	public static inline var RIGHT_ANALOGUE_Y:Int = 14;
#else
	public static inline var TRIANGLE_BUTTON:Int = 12;
	public static inline var CIRCLE_BUTTON:Int = 13;
	public static inline var X_BUTTON:Int = 14;
	public static inline var SQUARE_BUTTON:Int = 15;
	public static inline var L1_BUTTON:Int = 10;
	public static inline var R1_BUTTON:Int = 11;
	public static inline var L2_BUTTON:Int = 8;
	public static inline var R2_BUTTON:Int = 9;
	public static inline var SELECT_BUTTON:Int = 0;
	public static inline var START_BUTTON:Int = 3;
	public static inline var PS_BUTTON:Int = 16;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 1;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 2;
	public static inline var DPAD_UP:Int = 4;
	public static inline var DPAD_DOWN:Int = 6;
	public static inline var DPAD_LEFT:Int = 7;
	public static inline var DPAD_RIGHT:Int = 5;

	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	public static inline var TRIANGLE_BUTTON_PRESSURE:Int = 16;
	public static inline var CIRCLE_BUTTON_PRESSURE:Int = 17;
	public static inline var X_BUTTON_PRESSURE:Int = 18;
	public static inline var SQUARE_BUTTON_PRESSURE:Int = 19;
	public static inline var RIGHT_ANALOGUE_X:Int = 2;
	public static inline var RIGHT_ANALOGUE_Y:Int = 3;
#end
}
