//
//  LabelAndContent.m
//  AddressBook
//
//  Created by Peteo on 11-10-2.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LabelAndContent.h"

@implementation LabelAndContent

@synthesize m_strLabel;
@synthesize m_strContent;

- (id)init
{
    if ((self = [super init]))
	{
		m_strLabel				= nil;
		m_strContent		    = nil;
	}
	return self;
}

- (void)dealloc
{
	[m_strLabel		release];
	[m_strContent	release];

    [super dealloc];
}

@end



@implementation date_info

@synthesize m_nDate;
@synthesize m_pLabel;
@synthesize m_nRemind;

- (id)init
{
    if ((self = [super init]))
	{
		m_pLabel		    = nil;
	}
	return self;
}

- (void)dealloc
{
	[m_pLabel	release];
	
    [super dealloc];
}

@end
