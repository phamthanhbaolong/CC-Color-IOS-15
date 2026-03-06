#import <UIKit/UIKit.h>

// Móc vào class quản lý thanh kéo của Control Center
%hook CCUIBaseSliderView

- (void)layoutSubviews {
    %orig;

    // Truy tìm cái icon ẩn (glyph) bên trong thanh trượt
    UIImageView *glyphImageView = MSHookIvar<UIImageView *>(self, "_glyphImageView");

    if (glyphImageView) {
        // Phủ phép đổi màu (Mặc định đang để màu Vàng)
        glyphImageView.tintColor = [UIColor systemYellowColor];
        
        // Ép iOS phải hiển thị icon theo màu mới thay vì màu trắng gốc
        if (glyphImageView.image) {
            glyphImageView.image = [glyphImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
    }
}

%end
