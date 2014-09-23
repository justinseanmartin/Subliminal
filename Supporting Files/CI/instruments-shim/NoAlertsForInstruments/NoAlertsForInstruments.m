//
//  NoAlertsForInstruments.m
//  NoAlertsForInstruments
//
//  Created by Justin Martin on 9/22/14.
//

#import "NoAlertsForInstruments.h"

#import <Foundation/Foundation.h>
#import "objc/runtime.h"

@implementation NSAlert (NoAlertsForInstruments)

+ (void)load;
{
    Class class;
    SEL originalSelector, swizzledSelector;
    Method originalMethod, swizzledMethod;
    
    class = [NSAlert class];
    originalSelector = @selector(runModal);
    swizzledSelector = @selector(xxx_runModal);
    originalMethod = class_getInstanceMethod(class, originalSelector);
    swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (NSInteger)xxx_runModal;
{
    return NSAlertFirstButtonReturn;
}

@end

@implementation NSProcessInfo (NoAlertsForInstruments)

+ (void)load;
{
    Class class;
    SEL originalSelector, swizzledSelector;
    Method originalMethod, swizzledMethod;
    
    class = [NSProcessInfo class];
    originalSelector = @selector(environment);
    swizzledSelector = @selector(xxx_environment);
    originalMethod = class_getInstanceMethod(class, originalSelector);
    swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (NSDictionary *)xxx_environment;
{
    NSMutableDictionary *xxx_env = [NSMutableDictionary dictionaryWithDictionary:self.xxx_environment];
    [xxx_env removeObjectForKey:@"DYLD_INSERT_LIBRARIES"];
    return [xxx_env copy];
}

@end