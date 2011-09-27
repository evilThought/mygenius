//
//  CAttributeString.h
//
//  左边标签，右边编辑内容

#import <Foundation/Foundation.h>

#import "CAttribute.h"
#import "PublicData.h"

/*	
 Attributes for short text strings. 
*/
@interface CAttributeString : CAttribute 
{
	NSString* stringValue;
	
	UINavigationController * nvController;
	
	Tag_Type m_nType;
}

@property (nonatomic, retain) NSString* stringValue;

@property (nonatomic, assign) UINavigationController* nvController;
@property (nonatomic, assign) Tag_Type m_nType;

@end
