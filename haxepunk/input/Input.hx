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

	public static function touchPoints(touchCallback:Touch->Void)
	{
		for (touchId in _touchOrder)
		{
			touchCallback(_touches[touchId]);
		}
	}

	public static var touches(get, never):Map<Int, Touch>;
	static inline function get_touches():Map<Int, Touch> return _touches;

	public static var touchOrder(get, never):Array<Int>;
	static inline function get_touchOrder():Array<Int> return _touchOrder;

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
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

				HXP.stage.addEventListener(TouchEvent.TOUCH_BEGIN, onTouchBegin);
				HXP.stage.addEventListener(TouchEvent.TOUCH_MOVE, onTouchMove);
				HXP.stage.addEventListener(TouchEvent.TOUCH_END, onTouchEnd);
			}
		}
	}

	/**
	 * Updates the input states
	 */
	@:dox(hide)
	public static function update()
	{
		for (handler in handlers)
		{
			handler.update();
		}
		if (multiTouchSupported)
		{
			for (touchId in _touchOrder) _touches[touchId].update();

			if (Gesture.enabled) Gesture.update();

			var i:Int = 0;
			while (i < _touchOrder.length)
			{
				var touchId = _touchOrder[i],
					touch = _touches[touchId];
				if (touch.released && !touch.pressed)
				{
					_touches.remove(touchId);
					_touchOrder.remove(touchId);
				}
				else ++i;
			}
		}
	}

	public static function postUpdate()
	{
		for (handler in handlers) handler.postUpdate();
	}

	static function onTouchBegin(e:TouchEvent)
	{
		var touchPoint = new Touch(e.stageX / HXP.screen.fullScaleX, e.stageY / HXP.screen.fullScaleY, e.touchPointID);
		_touches.set(e.touchPointID, touchPoint);
		_touchOrder.push(e.touchPointID);
	}

	static function onTouchMove(e:TouchEvent)
	{
		// maybe we missed the begin event sometimes?
		if (_touches.exists(e.touchPointID))
		{
			var point = _touches.get(e.touchPointID);
			point.x = e.stageX / HXP.screen.fullScaleX;
			point.y = e.stageY / HXP.screen.fullScaleY;
		}
	}

	static function onTouchEnd(e:TouchEvent)
	{
		if (_touches.exists(e.touchPointID))
		{
			_touches.get(e.touchPointID).released = true;
		}
	}

	static var _enabled:Bool = false;
	static var _touches:Map<Int, Touch> = new Map<Int, Touch>();
	static var _touchOrder:Array<Int> = new Array();
}
