// Tencent is pleased to support the open source community by making Mars available.
// Copyright (C) 2016 THL A29 Limited, a Tencent company. All rights reserved.

// Licensed under the MIT License (the "License"); you may not use this file except in 
// compliance with the License. You may obtain a copy of the License at
// http://opensource.org/licenses/MIT

// Unless required by applicable law or agreed to in writing, software distributed under the License is
// distributed on an "AS IS" basis, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied. See the License for the specific language governing permissions and
// limitations under the License.

//
//  LogHelper.m
//  iOSDemo
//
//  Created by caoshaokun on 16/11/30.
//  Copyright © 2016年 caoshaokun. All rights reserved.
//

#import "XLogHelper.h"
#import <mars/xlog/xlogger.h>
#import <mars/xlog/appender.h>
#include <stdio.h>
#import <sys/xattr.h>


static NSUInteger g_processID = 0;

@implementation XLogHelper

+(void)initKHXlogger{
    
    [self initXlogger:debug releaseLevel:info path:@"/xlog" prefix:"kaihiela"];
}


+(void)initXlogger: (XloggerType)debugLevel releaseLevel: (XloggerType)releaseLevel path: (NSString*)path prefix: (const char*)prefix{
    
    NSString* logPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:path];
    
    const char* attrName = "io.jinkey";
    u_int8_t attrValue = 1;
    setxattr([logPath UTF8String], attrName, &attrValue, sizeof(attrValue), 0, 0);
    
    // init xlog
//    #if DEBUG
//
//    xlogger_SetLevel((TLogLevel)debugLevel);
//    mars::xlog::appender_set_console_log(true);
//    #else
   
    xlogger_SetLevel((TLogLevel)releaseLevel);
    mars::xlog::appender_set_console_log(false);
//    #endif

    mars::xlog::XLogConfig config;
    config.mode_ = mars::xlog::kAppenderAsync;
    config.logdir_ = [logPath UTF8String];
    config.nameprefix_ = prefix;
    config.pub_key_ = "";
    config.compress_mode_ = mars::xlog::kZlib;
    config.compress_level_ = 0;
    config.cachedir_ = "";
    config.cache_days_ = 5;
    appender_open(config);
    
}

// 封装了关闭 Xlogger 方法
// deinitialize Xlogger
+(void)deinitXlogger {
    mars::xlog::appender_close();
}

+(void) log: (XloggerType) level tag: (const char*)tag content: (NSString*)content{
    
    
    [self logWithLevel:(TLogLevel)level moduleName:tag fileName:"" lineNumber:0 funcName:"" message:content];
    
//    NSString* levelDescription = @"";
//
//    switch (level) {
//        case debug:
////            LOG_DEBUG(tag, content);
//            levelDescription = @"Debug";
//            break;
//        case info:
////            LOG_INFO(tag, content);
//            levelDescription = @"Info";
//            break;
//        case warning:
////            LOG_WARNING(tag, content);
//            levelDescription = @"Warn";
//            break;
//        case error:
////            LOG_ERROR(tag, content);
//            levelDescription = @"Error";
//            break;
//        default:
//            break;
//    }
    
}


+ (void)logWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName message:(NSString *)message {
    XLoggerInfo info;
    info.level = logLevel;
    info.tag = moduleName;
    info.filename = fileName;
    info.func_name = funcName;
    info.line = lineNumber;
    gettimeofday(&info.timeval, NULL);
    info.tid = (uintptr_t)[NSThread currentThread];
    info.maintid = (uintptr_t)[NSThread mainThread];
    info.pid = g_processID;
    xlogger_Write(&info, message.UTF8String);
}

+ (void)logWithLevel:(TLogLevel)logLevel moduleName:(const char*)moduleName fileName:(const char*)fileName lineNumber:(int)lineNumber funcName:(const char*)funcName format:(NSString *)format, ... {
    if ([self shouldLog:logLevel]) {
        va_list argList;
        va_start(argList, format);
        NSString* message = [[NSString alloc] initWithFormat:format arguments:argList];
        [self logWithLevel:logLevel moduleName:moduleName fileName:fileName lineNumber:lineNumber funcName:funcName message:message];
        va_end(argList);
    }
}

+ (BOOL)shouldLog:(int)level {
    if (level >= xlogger_Level()) {
        return YES;
    }
    
    return NO;
}

@end
