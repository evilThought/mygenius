//
//  CustomDatePicker.h
//  AddressBook
//
//  Created by Peteo on 11-8-13.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomDatePicker : UIView 
{
	UIDatePicker * m_pDatePicker;
}

@property (retain,nonatomic) UIDatePicker * m_pDatePicker;

- (id)initWithFrame:(CGRect)frame target:(id)target actionCancel:(SEL)actionCancel actionDone:(SEL)actionDone;

@end
