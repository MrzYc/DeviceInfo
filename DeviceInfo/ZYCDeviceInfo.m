//
//  ZYCDeviceInfo.m
//  DeviceInfo
//
//  Created by 赵永闯 on 2017/4/10.
//  Copyright © 2017年 赵永闯. All rights reserved.
//

#import "ZYCDeviceInfo.h"
//获取idfa
#import <AdSupport/ASIdentifierManager.h>
//获取mac
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>


#ifdef DEBUG
#define ZYCLog(...) NSLog(@"%s\n %@\n\n", __func__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define ZYCLog(...)
#endif


@implementation ZYCDeviceInfo


+(NSString *)ZYC_getDeviceIDFA{
    ASIdentifierManager *asIM = [[ASIdentifierManager alloc] init];
    NSString *idfaStr = [asIM.advertisingIdentifier UUIDString];
    
    ZYCLog(@"idfaStr------》%@",idfaStr);
    return idfaStr;
}

+(NSString *)ZYC_getDeviceIDFV{
    NSString* idfvStr      = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
    ZYCLog(@"idfvStr------》%@",idfvStr);
    return idfvStr;
}
//Git上的erica的UIDevice扩展文件，以前可用但由于IOKit framework没有公开，所以也无法使用。就算手动导入，依旧无法使用，看来获取IMEI要失败了,同时失败的还有IMSI。不过还存在另外一种可能，Stack Overflow上有人提供采用com.apple.coretelephony.Identity.get entitlement方法，but device must be jailbroken；在此附上链接，供大家参考：http://stackoverflow.com/questions/16667988/how-to-get-imei-on-iphone-5/16677043#16677043
+(NSString *)ZYC_getDeviceIMEI{
    NSString* imeiStr = @"回头吧，翻遍国内外了，failed，快看代码注释";
    return imeiStr;
}

+(NSString*)ZYC_getDeviceMAC{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macStr = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",*ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    ZYCLog(@"macStr------》%@",macStr);
    return macStr;
}

+(NSString*)ZYC_getDeviceUUID{
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    
    ZYCLog(@"uuidStr------》%@",uuidStr);
    return (__bridge NSString *)(uuidStr);
}

//no way，UDID是肯定要被苹果拒绝的，炸了！Stack Overflow提供了另外一种方法，越狱可尝试：http://stackoverflow.com/questions/27602368/how-to-get-serial-number-of-a-device-using-iokit-in-ios8-as-ioplatformserialnumb/27686125#27686125
+(NSString*)ZYC_getDeviceUDID{
    NSString* udidStr = @"回头吧，翻遍国内外了，failed，快来看注释";
    
    return udidStr;
}


@end
