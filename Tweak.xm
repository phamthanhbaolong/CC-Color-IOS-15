#import <UIKit/UIKit.h>

static BOOL enableBrightness = NO;
static NSString *brightnessColorHex = @"#FFD60A"; // Vàng mặc định
static BOOL enableVolume = NO;
static NSString *volumeColorHex = @"#0A84FF";    // Xanh mặc định

// Hàm chuyển đổi mã màu HEX sang màu hệ thống (UIColor)
static UIColor* colorFromHex(NSString *hexString) {
    unsigned rgbValue = 0;
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

// Hàm đọc cài đặt từ Menu
static void loadPrefs() {
    // Hỗ trợ cả Rootless và Rootful
    NSString *path = @"/var/jb/var/mobile/Library/Preferences/com.bro.ccslidercolors.plist";
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        path = @"/var/mobile/Library/Preferences/com.bro.ccslidercolors.plist";
    }
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:path];
    if (prefs) {
        enableBrightness = [prefs objectForKey:@"enableBrightness"] ? [[prefs objectForKey:@"enableBrightness"] boolValue] : NO;
        brightnessColorHex = [prefs objectForKey:@"brightnessColor"] ? [prefs objectForKey:@"brightnessColor"] : @"#FFD60A";
        
        enableVolume = [prefs objectForKey:@"enableVolume"] ? [[prefs objectForKey:@"enableVolume"] boolValue] : NO;
        volumeColorHex = [prefs objectForKey:@"volumeColor"] ? [prefs objectForKey:@"volumeColor"] : @"#0A84FF";
    }
}

// Móc vào các thanh trượt trong Control Center
%hook CCUIBaseSliderView

- (void)layoutSubviews {
    %orig;
    UIImageView *glyphImageView = MSHookIvar<UIImageView *>(self, "_glyphImageView");
    
    if (glyphImageView) {
        NSString *imageDesc = glyphImageView.image.description;
        
        // Nhận diện thanh Độ sáng (Chứa icon mặt trời)
        if ([imageDesc containsString:@"sun"] || [imageDesc containsString:@"brightness"]) {
            if (enableBrightness) {
                glyphImageView.tintColor = colorFromHex(brightnessColorHex);
                if (glyphImageView.image) {
                    glyphImageView.image = [glyphImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                }
            }
        }
        // Nhận diện thanh Âm lượng (Chứa icon cái loa)
        else if ([imageDesc containsString:@"speaker"] || [imageDesc containsString:@"volume"]) {
            if (enableVolume) {
                glyphImageView.tintColor = colorFromHex(volumeColorHex);
                if (glyphImageView.image) {
                    glyphImageView.image = [glyphImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
                }
            }
        }
    }
}

%end

// Khởi chạy Tweak và cập nhật màu ngay khi đổi trong Cài đặt (Không cần Respring)
%ctor {
    loadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.bro.ccslidercolors/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorCoalesce);
}
