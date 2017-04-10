//
//  ZYCDeviceInfo.h
//  DeviceInfo
//
//  Created by 赵永闯 on 2017/4/10.
//  Copyright © 2017年 赵永闯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZYCDeviceInfo : NSObject

/** method  获取设备IDFA */
+(NSString *)ZYC_getDeviceIDFA;

/** method  获取设备IDFV  */
+(NSString *)ZYC_getDeviceIDFV;

/** method  获取设备IMEI */
+(NSString*)ZYC_getDeviceIMEI;

/**  method  获取设备MAC */
+(NSString*)ZYC_getDeviceMAC;

/** method  获取设备UUID  */
+(NSString*)ZYC_getDeviceUUID;

/** method  获取设备UDID  */
+(NSString*)ZYC_getDeviceUDID;


@end
