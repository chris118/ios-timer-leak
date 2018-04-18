//
//  PTProxy.m
//  MiaowShow
//
//  Created by Chris on 2018/4/18.
//  Copyright © 2018年 ALin. All rights reserved.
//

#import "PTProxy.h"

@implementation PTProxy

/**
 这个函数让重载方有机会抛出一个函数的签名，再由后面的forwardInvocation:去执行
 为给定消息提供参数类型信息
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *sig = nil;
    sig = [self.obj methodSignatureForSelector:aSelector];
    return sig;
}

/**
 *  NSInvocation封装了NSMethodSignature，通过invokeWithTarget方法将消息转发给其他对象.这里转发给控制器执行。
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    [anInvocation invokeWithTarget:self.obj];
}

@end
