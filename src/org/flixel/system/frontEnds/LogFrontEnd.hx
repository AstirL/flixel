package org.flixel.system.frontEnds;

import org.flixel.FlxG;
import org.flixel.system.debug.LogStyle; 
import org.flixel.system.debug.Log;

class LogFrontEnd
{
	public function new() 
	{ 
		// Create functions that take a variable amount of arguments
		add = Reflect.makeVarArgs(_add);
		warn = Reflect.makeVarArgs(_warn);
		error = Reflect.makeVarArgs(_error);
		notice = Reflect.makeVarArgs(_notice);
	}
	
	/**
	 * Log data to the debugger. Example: <code>FlxG.add("Test", "1", "2", "3");</code> - will turn into "Test 1 2 3".
	 * Infinite amount of arguments allowed, they will be pieced together to one String. 
	 */
	public var add:Dynamic;
	
	inline private function _add(Data:Array<Dynamic>):Void
	{
		#if !FLX_NO_DEBUG
		if ((FlxG._game != null) && (FlxG._game.debugger != null))
			advanced(Data, Log.STYLE_NORMAL); 
		#end
	}
	
	/**
	 * Add a warning to the debugger. Example: <code>FlxG.log.warn("Test", "1", "2", "3");</code> - will turn into "[WARNING] Test 1 2 3".
	 * Infinite amount of arguments allowed, they will be pieced together to one String. 
	 */
	public var warn:Dynamic;
	
	inline private function _warn(Data:Array<Dynamic>):Void
	{
		#if !FLX_NO_DEBUG
		if ((FlxG._game != null) && (FlxG._game.debugger != null))
			advanced(Data, Log.STYLE_WARNING); 
		#end
	}
	
	/**
	 * Add an error to the debugger. Example: <code>FlxG.log.error("Test", "1", "2", "3");</code> - will turn into "[ERROR] Test 1 2 3".
	 * Infinite amount of arguments allowed, they will be pieced together to one String. 
	 */
	public var error:Dynamic;
	
	inline private function _error(Data:Array<Dynamic>):Void
	{
		#if !FLX_NO_DEBUG
		if ((FlxG._game != null) && (FlxG._game.debugger != null))
			advanced(Data, Log.STYLE_ERROR); 
		#end
	}
	
	/**
	 * Add a notice to the debugger. Example: <code>FlxG.log.notice("Test", "1", "2", "3");</code> - will turn into "[NOTICE] Test 1 2 3".
	 * Infinite amount of arguments allowed, they will be pieced together to one String. 
	 */
	public var notice:Dynamic;
	
	inline private function _notice(Data:Array<Dynamic>):Void
	{
		#if !FLX_NO_DEBUG
		if ((FlxG._game != null) && (FlxG._game.debugger != null))
			advanced(Data, Log.STYLE_NOTICE); 
		#end
	}
	
	/**
	 * Add an advanced log message to the debugger by also specifying a <code>LogStyle</code>. Backend to <code>FlxG.log.add(), FlxG.log.warn(), FlxG.log.error() and FlxG.log.notice()</code>.
	 * 
	 * @param  Data  Any Data to log.
	 * @param  Style   The <code>LogStyle</code> to use, for example <code>Log.STYLE_WARNING</code>. You can also create your own by importing the <code>LogStyle</code> class.
	 */ 
	public function advanced(Data:Dynamic, Style:LogStyle):Void
	{
		#if !FLX_NO_DEBUG
		if ((FlxG._game != null) && (FlxG._game.debugger != null))
		{
			if (!Std.is(Data, Array))
				Data = [Data]; 
			
			FlxG._game.debugger.log.add(Data, Style);
			
			if (Style.errorSound != null)
				FlxG.sound.play(Style.errorSound);
			if (Style.openConsole) 
				FlxG._game.debugger.visible = FlxG._game._debuggerUp = true;
			if (Reflect.isFunction(Style.callbackFunction))
				Reflect.callMethod(null, Style.callbackFunction, []);
		}
		#end
	}
	
	/**
	 * Clears the log output.
	 */
	public function clear():Void
	{
		#if !FLX_NO_DEBUG
		if ((FlxG._game != null) && (FlxG._game.debugger != null))
		{
			FlxG._game.debugger.log.clear();
		}
		#end
	}
}