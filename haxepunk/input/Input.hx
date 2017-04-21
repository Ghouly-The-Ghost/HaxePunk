package haxepunk.input;

import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.ui.Mouse;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;
import haxe.ds.Either.Left;
import haxe.ds.Either.Right;
import haxepunk.ds.OneOf;
import haxepunk.HXP;
import haxepunk.input.Mouse as HXPMouse;

/**
 * Manage the different inputs.
 */
class Input
{
	/**
	 * Array of currently active InputHandlers.
	 */
	public static var handlers:Array<InputHandler> = [Key];

	/**
	 * If the left button mouse is held down
	 */
	public static var mouseDown:Bool;
	/**
	 * If the left button mouse is up
	 */
	public static var mouseUp:Bool;
	/**
	 * If the left button mouse was recently pressed
	 */
	public static var mousePressed:Bool;
	/**
	 * If the left button mouse was recently released
	 */
	public static var mouseReleased:Bool;

#if !js
	/**
	 * If the right button mouse is held down.
	 * Not available in html5.
	 */
	public static var rightMouseDown:Bool;
	/**
	 * If the right button mouse is up.
	 * Not available in html5.
	 */
	public static var rightMouseUp:Bool;
	/**
	 * If the right button mouse was recently pressed.
	 * Not available in html5.
	 */
	public static var rightMousePressed:Bool;
	/**
	 * If the right button mouse was recently released.
	 * Not available in html5.
	 */
	public static var rightMouseReleased:Bool;

	/**
	 * If the middle button mouse is held down.
	 * Not available in html5.
	 */
	public static var middleMouseDown:Bool;
	/**
	 * If the middle button mouse is up.
	 * Not available in html5.
	 */
	public static var middleMouseUp:Bool;
	/**
	 * If the middle button mouse was recently pressed.
	 * Not available in html5.
	 */
	public static var middleMousePressed:Bool;
	/**
	 * If the middle button mouse was recently released.
	 * Not available in html5.
	 */
	public static var middleMouseReleased:Bool;
#end

	/**
	 * If the mouse wheel has moved
	 */
	public static var mouseWheel:Bool;

	/**
	 * Returns true if the device supports multi touch
	 */
	public static var multiTouchSupported(default, null):Bool = false;

	/**
	 * If the mouse wheel was moved this frame, this was the delta.
	 */
	public static var mouseWheelDelta(get, never):Int;
	static function get_mouseWheelDelta():Int
	{
		if (mouseWheel)
		{
			mouseWheel = false;
			return _mouseWheelDelta;
		}
		return 0;
	}

	/**
	 * Shows the native cursor
	 */
	public static function showCursor()
	{
		Mouse.show();
	}

	/**
	 * Hides the native cursor
	 */
	public static function hideCursor()
	{
		Mouse.hide();
	}

	/**
	 * X position of the mouse on the screen.
	 */
	public static var mouseX(get, never):Int;
	static function get_mouseX():Int
	{
		return HXP.screen.mouseX;
	}

	/**
	 * Y position of the mouse on the screen.
	 */
	public static var mouseY(get, never):Int;
	static function get_mouseY():Int
	{
		return HXP.screen.mouseY;
	}

	/**
	 * The absolute mouse x position on the screen (unscaled).
	 */
	public static var mouseFlashX(get, never):Int;
	static function get_mouseFlashX():Int
	{
		return Std.int(HXP.stage.mouseX - HXP.screen.x);
	}

	/**
	 * The absolute mouse y position on the screen (unscaled).
	 */
	public static var mouseFlashY(get, never):Int;
	static function get_mouseFlashY():Int
	{
		return Std.int(HXP.stage.mouseY - HXP.screen.y);
	}

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
			HXPMouse.init();
			Gamepad.init();

			HXP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false,  2);
			HXP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false,  2);
			HXP.stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel, false,  2);

		#if !js
			HXP.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, onMiddleMouseDown, false, 2);
			HXP.stage.addEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMiddleMouseUp, false, 2);
			HXP.stage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, onRightMouseDown, false, 2);
			HXP.stage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, onRightMouseUp, false, 2);
		#end

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

		if (mousePressed) mousePressed = false;
		if (mouseReleased) mouseReleased = false;

#if !js
		if (middleMousePressed) middleMousePressed = false;
		if (middleMouseReleased) middleMouseReleased = false;
		if (rightMousePressed) rightMousePressed = false;
		if (rightMouseReleased) rightMouseReleased = false;
#end
	}

	static function onMouseDown(e:MouseEvent)
	{
		if (!mouseDown)
		{
			mouseDown = true;
			mouseUp = false;
			mousePressed = true;
		}
	}

	static function onMouseUp(e:MouseEvent)
	{
		mouseDown = false;
		mouseUp = true;
		mouseReleased = true;
	}

	static function onMouseWheel(e:MouseEvent)
	{
		mouseWheel = true;
		_mouseWheelDelta = e.delta;
	}

#if !js
	static function onMiddleMouseDown(e:MouseEvent)
	{
		if (!middleMouseDown)
		{
			middleMouseDown = true;
			middleMouseUp = false;
			middleMousePressed = true;
		}
	}

	static function onMiddleMouseUp(e:MouseEvent)
	{
		middleMouseDown = false;
		middleMouseUp = true;
		middleMouseReleased = true;
	}

	static function onRightMouseDown(e:MouseEvent)
	{
		if (!rightMouseDown)
		{
			rightMouseDown = true;
			rightMouseUp = false;
			rightMousePressed = true;
		}
	}

	static function onRightMouseUp(e:MouseEvent)
	{
		rightMouseDown = false;
		rightMouseUp = true;
		rightMouseReleased = true;
	}
#end

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
	static var _mouseWheelDelta:Int = 0;
	static var _touches:Map<Int, Touch> = new Map<Int, Touch>();
	static var _touchOrder:Array<Int> = new Array();
}
