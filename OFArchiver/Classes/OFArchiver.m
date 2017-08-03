//
//  OFArchiver.m
//  Pods
//
//  Created by Hanyahui on 2017/8/2.
//
//

#import "OFArchiver.h"

@implementation OFArchiver

static OFArchiver *shareArchiver;
+ (instancetype)sharedArchiver {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareArchiver = [self new];
    });
    return shareArchiver;
}

- (NSString *)pathForRootDirectory {
    NSString *docDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *rootPath = [docDirectory stringByAppendingPathComponent:OFArchivePathDomainRoot];
    BOOL result = [self createDirectoryAtPath:rootPath];
    NSLog(@"root path create result %d",result);
    return docDirectory;
}

- (BOOL)saveObject:(id<NSCoding>)object pathDomain:(OFArchivePathDomain)domain filename:(NSString *)filename {
    
    if (!object || !filename) {
        return NO;
    }
    
    NSString *path = [self pathByDomain:domain filename:filename];
    BOOL result =  [NSKeyedArchiver archiveRootObject:object toFile:path];
    return result;
}

- (id<NSCoding>)objectInPathDomain:(OFArchivePathDomain)domain filename:(NSString *)filename {
    
    if (!filename) {
        return nil;
    }
    
    NSString *path = [self pathByDomain:domain filename:filename];
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return object;
}

- (BOOL)removeObjectInPathDomain:(OFArchivePathDomain)domain filename:(NSString *)filename {
    
    NSString *path = [self pathByDomain:domain filename:filename];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileMgr removeItemAtPath:path error:&error];
    if (!result) {
        NSLog(@"remove item error %@",error.description);
    }
    return result;
}

- (BOOL)saveObject:(id<NSCoding>)object filename:(NSString *)filename {

   BOOL result = [self saveObject:object pathDomain:OFArchivePathDomainDefault filename:filename];
    return result;
}

- (id<NSCoding>)objectWithFileName:(NSString *)filename {

    id object = [self objectInPathDomain:OFArchivePathDomainDefault filename:filename];
    return object;
}

- (BOOL)saveSharedInstance:(id)instance {
    BOOL result =  [self saveObject:instance pathDomain:OFArchivePathDomainDefault filename:NSStringFromClass([instance class])];
    return result;
}

- (id)sharedInstanceForClass:(Class)anClass {
    id object = [self objectInPathDomain:OFArchivePathDomainDefault filename:NSStringFromClass(anClass)];
    return object;
}

#pragma mark - Private method

- (NSString *)pathByDomain:(OFArchivePathDomain)domain filename:(NSString *)filename {
    NSString *domainpath = [[self pathForRootDirectory] stringByAppendingPathComponent:domain];
    NSString *fullPath = [domainpath stringByAppendingPathComponent:filename];
    [self createDirectoryAtPath:fullPath];
    return fullPath;
}

- (BOOL)createDirectoryAtPath:(NSString *)path
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if (![fileMgr fileExistsAtPath:path]) {
        BOOL result =  [fileMgr createDirectoryAtPath:path
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:nil];
        return result;
    }
    
    return YES;
}


@end
