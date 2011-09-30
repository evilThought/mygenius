    //
//  AddFieldVC.m
//  AddressBook
//
//  Created by Peteo on 11-9-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddFieldVC.h"

typedef enum 
{
    AddField_TableView_Section_Memo,        //纪念日
	AddField_TableView_Section_Account,     //帐号
	AddField_TableView_Section_ID,			//证件
	AddField_TableView_Section_Count
}AddField_TableView_Section;

@implementation AddFieldVC

@synthesize m_pTableView_IB;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	self.navigationItem.title = @"添加字段";
	
	m_pSource = [NSArray arrayWithObjects:
				 [NSDictionary dictionaryWithObjectsAndKeys:
				  @"纪念日", @"name",
				  @"CAttributeString", @"className",
				  @"Short strings (eg: character name)", @"description",
				  nil],
				 [NSDictionary dictionaryWithObjectsAndKeys:
				  @"帐号", @"name",
				  @"CAttributeText", @"className",
				  @"Longer strings (eg: novel contents)", @"description",
				  nil],
				 [NSDictionary dictionaryWithObjectsAndKeys:
				  @"证件", @"name",
				  @"CAttributeInteger", @"className",
				  @"A simple counter with +/- keys (eg: fate points)", @"description",
				  nil],
				 nil];
	
	[m_pSource retain];
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[m_pTableView_IB release];
	[m_pSource       release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return AddField_TableView_Section_Count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	NSInteger retval = 1;
    return retval;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"AddFieldCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    if (m_pSource != nil && indexPath.section < [m_pSource count])
	{
		id item = [m_pSource objectAtIndex:indexPath.section];
		NSString *text;
		text = [item valueForKey:@"name"];
		if (text) 
			cell.textLabel.text = text;
		
		/*
		text = [item valueForKey:@"description"];
		if ([text length] > SUBSTRING_SIZE)
			text = [text substringToIndex:SUBSTRING_SIZE];
		if (text) cell.detailTextLabel.text = text;
		*/
	}
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

/**
 *	Call the target object (insertTarget) with the appropriate selector (insertSelector)
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	/*
	id resultItem;
	
	if (source && indexPath.row < [source count]) {
		resultItem = [source objectAtIndex:indexPath.row];
	}
	
	if (insertTarget && insertSelector && [insertTarget respondsToSelector:insertSelector]) {
		[insertTarget performSelector:insertSelector withObject:resultItem];
	}
	[self.navigationController popViewControllerAnimated:YES];
	*/
}

@end