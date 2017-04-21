package haxepunk.input;

import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.ui.Mouse as FlashMouse;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import haxe.ds.Either.Left;
import haxe.ds.Either.Right;
import haxepunk.ds.OneOf;
import haxepunk.HXP;

/**
 * Manage the different inputs.
 */
class Input
{
	/**
	 * Array of currently active InputHandlers.
	 */
	public static var handlers:Array<InputHandler> = [Key, Mouse];

	/**
	 * Returns true if the device supports multi touch
	 */
	public static var multiTouchSupported(default, null):Bool = false;

	/**
	 * Trigger any callbacks meant for this type of input.
	 * @since 4.0.0
	 */
	public static function triggerPress(type:InputType)
	{
		if (HXP.engine.inputPressed.exists(type)) HXP.engine.inputPressed.resolve(type).invoke();
		if (HXP.scene.inputPressed.exists(type)) HXP.scene.inputPressed.resolve(type).invoke();
	}

	/**
	 * Trigger any callbacks meant for this type of input.
	 * @since 4.0.0
	 */
	public static function triggerRelease(type:InputType)
	{
		if (HXP.engine.inputReleased.exists(type)) HXP.engine.inputReleased.resolve(type).invoke();
		if (HXP.scene.inputReleased.exists(type)) HXP.scene.inputReleased.resolve(type).invoke();
	}

	/**
	 * @deprecated use Key.define
	 */
	public static inline function define(input:InputType, keys:Array<Key>)
	{
		Key.define(input, keys);
	}

	/**
	 * If the input or key is held down.
	 * @param	input		An input name or key to check for.
	 * @return	True or false.
	 */
	public static function check(input:InputType):Bool
	{
		for (handler in handlers)
		{
			if (handler.checkInput(input)) return true;
		}
		return false;
	}

	/**
	 * If the input or key was pressed this frame.
	 * @param	input		An input name or key to check for.
	 * @return	True or false.
	 */
	public static function pressed(input:InputType):Bool
	{
		for (handler in handlers)
		{
			if (handler.pressedInput(input)) return true;
		}
		return false;
	}

	/**
	 * If the input or key was released this frame.
	 * @param	input		An input name or key to check for.
	 * @return	True or false.
	 */
	public static function released(input:InputType):Bool
	{
		for (handler in handlers)
		{
			if (handler.releasedInput(input)) return true;
		}
		return false;
	}

	/**
	 * Enables input handling
	 */
	@:dox(hide)
	public static function enable()
	{
		if (!_enabled && HXP.stage != null)
		{
			Key.init();
			Mouse.init();
			Gamepad.init();

			multiTouchSupported = Multitouch.supportsTouchEvents;
			if (multiTouchSupported)
			{
				Touch.init();
			}
		}
	}

	/**
	 * Updates the input states
	 */
	@:dox(hide)
	public static function update()
	{
		for (handler in handlers) handler.update();
	}

	public static function postUpdate()
	{
		for (handler in handlers) handler.postUpdate();
	}

	static var _enabled:Bool = false;
}
