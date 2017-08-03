/******************************************************************************
 *  @file   : OFArchiver.h
 *  @author : hanyahui
 *  @date   : 2017-8-2
 *  @brief  : 此类用于实现对象的归档与解档，归档对象统一保存在 /document/cn_com_company_archive/domain/filename 路径下
 ******************************************************************************/

#import <Foundation/Foundation.h>

#import "OFArchiverDomainConstants.h"

@interface OFArchiver : NSObject

+ (instancetype)sharedArchiver;

//- (NSString *)pathForRootDirectory;

// 归档 object 需指定 domain 和 filename，参数不可为空
- (BOOL)saveObject:(id<NSCoding>)object pathDomain:(OFArchivePathDomain)domain filename:(NSString *)filename;
// 通过 domain 和 file 解档 object， object path is document/domain/file 参数不可为空
- (id<NSCoding>)objectInPathDomain:(OFArchivePathDomain)domain filename:(NSString *)filename;
// 通过 domain 和 file 移除 object， object path is document/domain/file 参数不可为空
- (BOOL)removeObjectInPathDomain:(OFArchivePathDomain)domain filename:(NSString *)filename;


//归档 object 需指定 filename  domain defualt is OFArchivePathDomainDefault(/default)
- (BOOL)saveObject:(id<NSCoding>)object filename:(NSString *)filename;
// 通过 /defualt/filename 解档 object
- (id<NSCoding>)objectWithFileName:(NSString *)filename;

// 归档 object 在 /default/[instance class] 目录下。注意：此方法只用于归档单例对象
- (BOOL)saveSharedInstance:(id)instance;
// 通过 /default/anClass 解档出 object，注意：此方法只用于解档单例对象
- (id)sharedInstanceForClass:(Class)anClass;

@end
