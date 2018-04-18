//
//  PTProxy.h
//  MiaowShow
//
//  Created by Chris on 2018/4/18.
//  Copyright © 2018年 ALin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTProxy: NSProxy

/**
 *  代理的对象
 */
@property (nonatomic,weak)id obj;

@end
