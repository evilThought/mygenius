//
//  CheckBox.h
//  AddressBook
//
//  Created by Peteo on 11-10-4.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//	
//  通讯录长按弹出框

#import <UIKit/UIKit.h>


@interface CheckBox : UIView 
{
	id  Target;
	SEL Selector;
}

@property (nonatomic, assign) id  Target;
@property (nonatomic, assign) SEL Selector;

@end
