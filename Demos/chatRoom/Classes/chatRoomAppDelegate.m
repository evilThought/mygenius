//
//  chatRoomAppDelegate.m
//  chatRoom
//
//  Created by Peteo on 11-8-5.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "chatRoomAppDelegate.h"



@implementation chatRoomAppDelegate

@synthesize window;
@synthesize m_PhotonLib;
@synthesize l;
@synthesize m_pchat,m_pchooiceRoom;

- (void) onTime:(NSTimer*)Timer
{
	[m_PhotonLib Run];
	
	//if(m_pchat && m_pchat.advTable)
	//{
		//[m_pchat.advTable reloadData];
	//}
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	m_pchat = [[chat alloc]init];
	
	m_PhotonLib = [CPhotonLib alloc];
	[m_PhotonLib InitCPhotonLib];
	l = [Listener alloc];
	[l InitListener:m_PhotonLib];
	[m_PhotonLib InitLib:l];
	
	m_timer = [[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTime:) userInfo:nil repeats:YES]retain];
	
	
	m_pchooiceRoom = [[chooiceRoom alloc]init];
	
	[window addSubview:m_pchooiceRoom.view];
	
    [window makeKeyAndVisible];
	
	bRun = true;
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc 
{
	[m_pchat release];
	[m_pchooiceRoom release];
	
	[m_PhotonLib release];
	[l			 release];
	[m_timer     release];
	
    [window release];
	
    [super dealloc];
}

+(chatRoomAppDelegate*)getAppDelegate
{
    return (chatRoomAppDelegate*)[UIApplication sharedApplication].delegate;
}

@end
