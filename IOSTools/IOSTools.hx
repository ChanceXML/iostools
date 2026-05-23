package IOSTools;

#if ios
import lime.system.CFFI;
#end

class IOSTools {

    #if ios
    private static var iostools_request_permission = CFFI.load("IOSTools", "iostools_request_permission", 1);
    
    private static var iostools_show_alert = CFFI.load("IOSTools", "iostools_show_alert", 3);
    private static var iostools_show_confirm = CFFI.load("IOSTools", "iostools_show_confirm", 4);
    private static var iostools_show_triple_alert = CFFI.load("IOSTools", "iostools_show_triple_alert", 5);
    
    private static var iostools_trigger_haptic = CFFI.load("IOSTools", "iostools_trigger_haptic", 1);
    
    private static var iostools_save_string = CFFI.load("IOSTools", "iostools_save_string", 2);
    private static var iostools_get_string = CFFI.load("IOSTools", "iostools_get_string", 1);
    private static var iostools_get_bool = CFFI.load("IOSTools", "iostools_get_bool", 1);
    private static var iostools_get_int = CFFI.load("IOSTools", "iostools_get_int", 1);
    private static var iostools_remove_storage = CFFI.load("IOSTools", "iostools_remove_storage", 1);
    
    private static var iostools_get_battery = CFFI.load("IOSTools", "iostools_get_battery", 0);
    private static var iostools_is_charging = CFFI.load("IOSTools", "iostools_is_charging", 0);
    private static var iostools_get_os_version = CFFI.load("IOSTools", "iostools_get_os_version", 0);
    private static var iostools_get_model = CFFI.load("IOSTools", "iostools_get_model", 0);
    
    private static var iostools_pick_folder = CFFI.load("IOSTools", "iostools_pick_folder", 0);
    private static var iostools_pick_files = CFFI.load("IOSTools", "iostools_pick_files", 1);
    #end

    public static function requestPermission(type:Int):Void {
        #if ios iostools_request_permission(type); #end
    }

    public static function showAlert(title:String, message:String, buttonText:String = "OK"):Void {
        #if ios iostools_show_alert(title, message, buttonText); #end
    }

    public static function showConfirm(title:String, message:String, confirmText:String = "Yes", cancelText:String = "No"):Void {
        #if ios iostools_show_confirm(title, message, confirmText, cancelText); #end
    }

    public static function showTripleAlert(title:String, message:String, b1:String, b2:String, b3:String):Void {
        #if ios iostools_show_triple_alert(title, message, b1, b2, b3); #end
    }

    public static function triggerHaptic(style:Int):Void {
        #if ios iostools_trigger_haptic(style); #end
    }

    public static function saveString(key:String, value:String):Void {
        #if ios iostools_save_string(key, value); #end
    }

    public static function getString(key:String):String {
        #if ios return iostools_get_string(key); #end
        return "";
    }

    public static function getBool(key:String):Bool {
        #if ios return iostools_get_bool(key); #end
        return false;
    }

    public static function getInt(key:String):Int {
        #if ios return iostools_get_int(key); #end
        return 0;
    }

    public static function removeData(key:String):Void {
        #if ios iostools_remove_storage(key); #end
    }

    public static function getBatteryLevel():Float {
        #if ios return iostools_get_battery(); #end
        return 100.0;
    }

    public static function isCharging():Bool {
        #if ios return iostools_is_charging(); #end
        return false;
    }

    public static function getOSVersion():String {
        #if ios return iostools_get_os_version(); #end
        return "PC/Simulator";
    }

    public static function getDeviceModel():String {
        #if ios return iostools_get_model(); #end
        return "Mac/PC";
    }

    public static function pickFolder():Void {
        #if ios iostools_pick_folder(); #end
    }

    public static function pickFiles(allowMultiple:Bool = false):Void {
        #if ios iostools_pick_files(allowMultiple); #end
    }
}
