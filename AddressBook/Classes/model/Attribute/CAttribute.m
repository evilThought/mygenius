//
//  CAttribute.m
//

#import "CAttribute.h"


@implementation CAttribute

@synthesize label;

- (NSString*)type
{
	return @"attribute";
}

- (id)initWithString:(NSString*)inputString 
{
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder 
{
	if (self)
		self.label = [decoder decodeObjectForKey:@"label"];
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder 
{
    [encoder encodeObject:label forKey:@"label"];	
}

- (void)dealloc 
{
	[label release];
	
	[super dealloc];
}

- (CAttributeCell*)cellForTableView:(UITableView *)tableView 
{
	static NSString* cellIdentifier = @"CAttributeCell";
	CAttributeCell* cell = (CAttributeCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (![cell isKindOfClass:[CAttributeCell class]]) 
	{
		cell = [[[CAttributeCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
	}
	
	if (cell != nil)
	{
		[cell setTarget:self withLabel:@"label" withkey:@"stringValue"];
		cell.textLabel.text = self.label;
		//cell.detailTextLabel.text = @"huh?";
	}
	
	return cell;
}

- (UIViewController*) detailViewController:(BOOL)editing 
{ 
	return nil;
}

- (void) Show :(id) pVc
{
	
}

@end
