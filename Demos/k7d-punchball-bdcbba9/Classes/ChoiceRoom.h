//
//  ChoiceRoom.h
//  punchball
//
//  Created by Peteo on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#include "chipmunk.h"
#include "cocos2d.h"
#include "ReplaceLayerAction.h"
#import  "Link.h"

typedef enum 
{
	EEnterRoomSelect_ReFresh,
	EEnterRoomSelect_Room1,
	EEnterRoomSelect_Room2,
	EEnterRoomSelect_Room3,
	EEnterRoomSelect_Room4,
	EEnterRoomSelect_Return,
	EEnterRoomSelect_SendChat,
	EEnterRoomSelect_Count
}EEnterRoomSelect;

@protocol ChoiceRoomDelegate

-(void) EnterRoom:(NSInteger) pIndex;
-(void) EnterRoomSendDate:(NSString*) pStr;

@end

@interface ChoiceRoom : Layer  <ReplaceLayerActionDelegate , UpDateRoomDelegate ,UITextFieldDelegate>
{
	id<ChoiceRoomDelegate> delegate;
	
	MenuItemLabel *item1;
	MenuItemLabel *item2;
	MenuItemLabel *item3;
	MenuItemLabel *item4;
	
	NSInteger m_nRoom1;
	NSInteger m_nRoom2;
	NSInteger m_nRoom3;
	NSInteger m_nRoom4;
	
	UIWindow     *window;
	UIScrollView *m_pChatList;
	
	UITextField  *nameField;
}

- (id) init: (id<ChoiceRoomDelegate>) _delegate window:(UIWindow*)_window;

- (void) UpDateRoomNum;

- (void) AddChatList:(NSString*)pStr;

@end
