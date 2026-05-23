#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>
#import "IOSTools-Swift.h" 

#define LIB_EXPORT __attribute__((visibility("default")))

extern "C" {

    LIB_EXPORT void iostools_request_permission(int permissionType) {
        [[PermissionManager shared] request:permissionType completion:^(BOOL granted) {
        }];
    }

    LIB_EXPORT void iostools_show_alert(const char* title, const char* message, const char* buttonText) {
        NSString *nsTitle = [NSString stringWithUTF8String:title];
        NSString *nsMessage = [NSString stringWithUTF8String:message];
        NSString *nsBtn = [NSString stringWithUTF8String:buttonText];
        [[AlertManager shared] showAlertWithTitle:nsTitle message:nsMessage buttonText:nsBtn onClick:nil];
    }

    LIB_EXPORT void iostools_show_confirm(const char* title, const char* message, const char* confirmText, const char* cancelText) {
        NSString *nsTitle = [NSString stringWithUTF8String:title];
        NSString *nsMessage = [NSString stringWithUTF8String:message];
        NSString *nsConfirm = [NSString stringWithUTF8String:confirmText];
        NSString *nsCancel = [NSString stringWithUTF8String:cancelText];
        
        [[AlertManager shared] showConfirmWithTitle:nsTitle message:nsMessage confirmText:nsConfirm cancelText:nsCancel onAction:^(BOOL confirmed) {
        }];
    }

    LIB_EXPORT void iostools_show_triple_alert(const char* title, const char* message, const char* b1, const char* b2, const char* b3) {
        NSString *nsTitle = [NSString stringWithUTF8String:title];
        NSString *nsMessage = [NSString stringWithUTF8String:message];
        NSString *nsB1 = [NSString stringWithUTF8String:b1];
        NSString *nsB2 = [NSString stringWithUTF8String:b2];
        NSString *nsB3 = [NSString stringWithUTF8String:b3];
        
        [[AlertManager shared] showTripleButtonAlertWithTitle:nsTitle message:nsMessage buttonOneText:nsB1 buttonTwoText:nsB2 buttonThreeText:nsB3 onButtonClick:^(NSInteger clicked) {
        }];
    }

    LIB_EXPORT void iostools_trigger_haptic(int styleType) {
        [[FeedbackManager shared] triggerHaptic:styleType];
    }

    LIB_EXPORT void iostools_save_string(const char* key, const char* value) {
        NSString *nsKey = [NSString stringWithUTF8String:key];
        NSString *nsValue = [NSString stringWithUTF8String:value];
        [[StorageManager shared] saveWithKey:nsKey value:nsValue];
    }

    LIB_EXPORT const char* iostools_get_string(const char* key) {
        NSString *nsKey = [NSString stringWithUTF8String:key];
        NSString *result = [[StorageManager shared] getStringWithKey:nsKey];
        if (!result) return "";
        return [result UTF8String];
    }

    LIB_EXPORT bool iostools_get_bool(const char* key) {
        return [[StorageManager shared] getBoolWithKey:[NSString stringWithUTF8String:key]];
    }

    LIB_EXPORT int iostools_get_int(const char* key) {
        return [[StorageManager shared] getIntWithKey:[NSString stringWithUTF8String:key]];
    }

    LIB_EXPORT void iostools_remove_storage(const char* key) {
        [[StorageManager shared] removeWithKey:[NSString stringWithUTF8String:key]];
    }

    LIB_EXPORT float iostools_get_battery() {
        return [[DeviceManager shared] batteryLevel];
    }

    LIB_EXPORT bool iostools_is_charging() {
        return [[DeviceManager shared] isBatteryCharging];
    }

    LIB_EXPORT const char* iostools_get_os_version() {
        return [[[DeviceManager shared] osVersion] UTF8String];
    }

    LIB_EXPORT const char* iostools_get_model() {
        return [[[DeviceManager shared] deviceModel] UTF8String];
    }

    LIB_EXPORT void iostools_pick_folder() {
        [[FilePermissionManager shared] pickFolderWithCompletion:^(NSURL * _Nullable url) {
        }];
    }

    LIB_EXPORT void iostools_pick_files(bool allowMultiple) {
        [[FilePickerManager shared] pickFilesWithAllowedTypes:@[[UTType item]] allowMultiple:allowMultiple completion:^(NSArray<NSURL *> * _Nonnull urls) {
        }];
    }
}
