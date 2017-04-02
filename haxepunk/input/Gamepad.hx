package haxepunk.input;

import flash.geom.Point;
#if ((nme || openfl_legacy) && (cpp || neko))
import flash.events.JoystickEvent;
#else
import flash.events.GameInputEvent;
import flash.ui.GameInput;
import flash.ui.GameInputDevice;
import flash.ui.GameInputControl;

#end
import haxepunk.HXP;

typedef GamepadID = Int;

typedef GamepadButton = Int;

enum JoyButtonState
{
	BUTTON_ON;
	BUTTON_OFF;
	BUTTON_PRESSED;
	BUTTON_RELEASED;
}

/**
 * A gamepad.
 *
 * Get one using `Input.gamepad`.
 *
 * Currently doesn't work with flash and html5 targets.
 */
class Gamepad
{
	public static function init()
	{
		#if ((nme || openfl_legacy) && (cpp || neko))
		HXP.stage.addEventListener(JoystickEvent.AXIS_MOVE, onJoyAxisMove);
		HXP.stage.addEventListener(JoystickEvent.BALL_MOVE, onJoyBallMove);
		HXP.stage.addEventListener(JoystickEvent.BUTTON_DOWN, onJoyButtonDown);
		HXP.stage.addEventListener(JoystickEvent.BUTTON_UP, onJoyButtonUp);
		HXP.stage.addEventListener(JoystickEvent.HAT_MOVE, onJoyHatMove);
		HXP.stage.addEventListener(JoystickEvent.DEVICE_ADDED, onJoyDeviceAdded);
		HXP.stage.addEventListener(JoystickEvent.DEVICE_REMOVED, onJoyDeviceRemoved);
		#else
		HXP.stage.addEventListener(GameInputEvent.DEVICE_ADDED, onJoyDeviceAdded);
		HXP.stage.addEventListener(GameInputEvent.DEVICE_REMOVED, onJoyDeviceRemoved);
		#end
	}

	/**
	 * Returns a gamepad object (creates one if not connected)
	 * @param  id The id of the gamepad, starting with 0
	 * @return    A Gamepad object
	 */
	public static function gamepad(id:GamepadID):Gamepad
	{
		var joy:Gamepad = _gamepads.get(id);
		if (joy == null)
		{
			joy = new Gamepad();
			_gamepads.set(id, joy);
		}
		return joy;
	}

	/**
	 * Returns the number of connected gamepads
	 */
	public static var gamepadCount(get, never):Int;
	static function get_gamepadCount():Int
	{
		var count:Int = 0;
		for (gamepad in _gamepads)
		{
			if (gamepad.connected)
			{
				count += 1;
			}
		}
		return count;
	}

#if ((nme || openfl_legacy) && (cpp || neko))
	static function onJoyAxisMove(e:JoystickEvent)
	{
		var joy:Gamepad = gamepad(e.device);
		joy.connected = true;
		joy.axis = e.axis;
	}

	static function onJoyBallMove(e:JoystickEvent)
	{
		var joy:Gamepad = gamepad(e.device);
		joy.connected = true;
		joy.ball.x = (Math.abs(e.x) < Gamepad.deadZone) ? 0 : e.x;
		joy.ball.y = (Math.abs(e.y) < Gamepad.deadZone) ? 0 : e.y;
	}

	static function onJoyButtonDown(e:JoystickEvent)
	{
		var joy:Gamepad = gamepad(e.device);
		joy.connected = true;
		joy.buttons.set(e.id, BUTTON_PRESSED);
	}

	static function onJoyButtonUp(e:JoystickEvent)
	{
		var joy:Gamepad = gamepad(e.device);
		joy.connected = true;
		joy.buttons.set(e.id, BUTTON_RELEASED);
	}

	static function onJoyHatMove(e:JoystickEvent)
	{
		var joy:Gamepad = gamepad(e.device);
		joy.connected = true;
		joy.hat.x = (Math.abs(e.x) < Gamepad.deadZone) ? 0 : e.x;
		joy.hat.y = (Math.abs(e.y) < Gamepad.deadZone) ? 0 : e.y;
	}

	static function onJoyDeviceAdded(e:JoystickEvent) {}
	static function onJoyDeviceRemoved(e:JoystickEvent) {}
#else
	// TODO
	static function onJoyDeviceAdded(e:GameInputEvent) {}
	static function onJoyDeviceRemoved(e:GameInputEvent) {}
#end

	/**
	 * A map of buttons and their states
	 */
	public var buttons:Map<Int, JoyButtonState>;
	/**
	 * Each axis contained in an array.
	 */
	public var axis(null, default):Array<Float>;
	/**
	 * A Point containing the gamepad's hat value.
	 */
	public var hat:Point;
	/**
	 * A Point containing the gamepad's ball value.
	 */
	public var ball:Point;

	/**
	 * Determines the gamepad's deadZone. Anything under this value will be considered 0 to prevent jitter.
	 */
	public static var deadZone:Float = 0.15;

	/**
	 * Creates and initializes a new Gamepad.
	 */
	@:dox(hide)
	public function new()
	{
		buttons = new Map<Int, JoyButtonState>();
		ball = new Point(0, 0);
		axis = new Array<Float>();
		hat = new Point(0, 0);
		connected = false;
		_timeout = 0;
	}

	/**
	 * Updates the gamepad's state.
	 */
	@:dox(hide)
	public function update()
	{
		_timeout -= HXP.elapsed;
		for (button in buttons.keys())
		{
			switch (buttons.get(button))
			{
				case BUTTON_PRESSED:
					buttons.set(button, BUTTON_ON);
				case BUTTON_RELEASED:
					buttons.set(button, BUTTON_OFF);
				default:
			}
		}
	}

	public function defineButton(input:InputType, buttons:Array<GamepadButton>)
	{
		// undefine any pre-existing key mappings
		if (_control.exists(input))
		{
			for (button in _control[input])
			{
				_buttonMap[button].remove(input);
			}
		}
		_control.set(input, buttons);
		for (button in buttons)
		{
			if (!_buttonMap.exists(button)) _buttonMap[button] = new Array();
			if (_buttonMap[button].indexOf(input) < 0) _buttonMap[button].push(input);
		}
	}

	// TODO: defineAxis

	public function checkInput(input:InputType)
	{
		if (_control.exists(input))
		{
			for (button in _control[input])
			{
				if (check(button)) return true;
			}
		}
		return false;
	}

	public function pressedInput(input:InputType)
	{
		if (_control.exists(input))
		{
			for (button in _control[input])
			{
				if (pressed(button)) return true;
			}
		}
		return false;
	}

	public function releasedInput(input:InputType)
	{
		if (_control.exists(input))
		{
			for (button in _control[input])
			{
				if (released(button)) return true;
			}
		}
		return false;
	}

	public function pressed(button:GamepadButton):Bool
	{
		return (buttons.exists(button)) ? buttons.get(button) == BUTTON_PRESSED : false;
	}

	/**
	 * If the gamepad button was released this frame.
	 * Omit argument to check for any button.
	 * @param  button The button index to check.
	 */
	public function released(button:GamepadButton):Bool
	{
		return (buttons.exists(button)) ? buttons.get(button) == BUTTON_RELEASED : false;
	}

	/**
	 * If the gamepad button is held down.
	 * Omit argument to check for any button.
	 * @param  button The button index to check.
	 */
	public function check(button:GamepadButton):Bool
	{
		return (buttons.exists(button)) ? (buttons[button] != BUTTON_OFF && buttons[button] != BUTTON_RELEASED) : false;
	}

	/**
	 * Returns the axis value (from 0 to 1)
	 * @param  a The axis index to retrieve starting at 0
	 */
	public inline function getAxis(a:Int):Float
	{
		if (a < 0 || a >= axis.length) return 0;
		else return (Math.abs(axis[a]) < deadZone) ? 0 : axis[a];
	}

	/**
	 * If the gamepad is currently connected.
	 */
	public var connected(get, set):Bool;
	function get_connected():Bool return _timeout > 0;
	function set_connected(value:Bool):Bool
	{
		if (value) _timeout = 3; // 3 seconds to timeout
		else _timeout = 0;
		return value;
	}

	var _timeout:Float;
	var _control:Map<InputType, Array<GamepadButton>> = new Map();
	var _buttonMap:Map<GamepadButton, Array<InputType>> = new Map();

	static var _gamepads:Map<Int, Gamepad> = new Map<Int, Gamepad>();
}
