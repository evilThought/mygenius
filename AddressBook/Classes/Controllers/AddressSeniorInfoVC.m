    //
//  AddressAddMoreVC.m
//  AddressBook
//
//  Created by Peteo on 11-8-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddressSeniorInfoVC.h"
#import "PublicData.h"
#import "AddressBaseInfoVC.h"
#import "AddFieldVC.h"
#import "AddressBookAppDelegate.h"

@implementation AddressSeniorInfoVC

@synthesize m_pTableView_IB;
//@synthesize m_pRightEdit;
@synthesize aBPersonNav;
@synthesize m_pContact;
@synthesize m_pButtonItemEdit;
@synthesize m_pButtonItemDone;
//@synthesize m_pButtonItemReturn;
@synthesize m_pButtonItemCancel;

typedef enum 
{
    SeniorInfo_TableView_Section_Group,
	SeniorInfo_TableView_Section_Blood,
	SeniorInfo_TableView_Section_Constellation,
	SeniorInfo_TableView_Section_Recommend,
	
	SeniorInfo_TableView_Section_Memo,
	SeniorInfo_TableView_Section_IM,
	SeniorInfo_TableView_Section_Account,
	SeniorInfo_TableView_Section_Certificate,
	SeniorInfo_TableView_Section_Relate,
	
	SeniorInfo_TableView_Section_AddField,
	
	SeniorInfo_TableView_Section_Count
}SeniorInfo_TableView_Section;

- (void)toggleStyle:(id)sender
{
	switch ([sender selectedSegmentIndex])
	{
		case 0:
		{
			[aBPersonNav popViewControllerAnimated:NO];
			
			AddressBaseInfoVC *pvc = [[AddressBaseInfoVC alloc] init];
			
			pvc.m_pContact    = m_pContact;
			pvc.allowsEditing = YES;
			//[pvc setAllowsDeletion:YES];
			pvc.personViewDelegate = pvc;
			
			pvc.aBPersonNav = aBPersonNav;
			
			[aBPersonNav pushViewController:pvc animated:NO];
			
			[pvc release];
			
			break;
		}
		case 1: 
		{
			break;
		}
	}
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//self.tableView.backgroundColor = [UIColor clearColor];
	//self.tableView.style = UITableViewStyleGrouped;
	m_pTableView_IB.allowsSelectionDuringEditing = YES;
	
	self.navigationItem.title = @"";
	self.navigationItem.rightBarButtonItem = m_pButtonItemEdit;
	
	//m_pButtonItemReturn = self.navigationItem.leftBarButtonItem;
	
	if(m_pSegmentedControl)
	{
		[m_pSegmentedControl setHidden:NO];
	}
	else
	{
		m_pSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"基本信息", @"高级信息", nil]];
		[m_pSegmentedControl addTarget:self action:@selector(toggleStyle:) forControlEvents:UIControlEventValueChanged];
		m_pSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
		m_pSegmentedControl.backgroundColor = [UIColor clearColor];
		[m_pSegmentedControl sizeToFit];
		m_pSegmentedControl.selectedSegmentIndex = 1;
		CGRect segmentedControlFrame = CGRectMake((320 - 166)/2,(45 - 30)/2,166,30);
		m_pSegmentedControl.frame = segmentedControlFrame;
		
		[self.navigationController.navigationBar addSubview:m_pSegmentedControl];
	}
	
	m_pContainer			= [[CAttributeContainer alloc] init];
	m_pMemoContainer		= [[CAttributeContainer alloc] init];
	m_pAccountsContainer	= [[CAttributeContainer alloc] init];
	m_pCertificateContainer = [[CAttributeContainer alloc] init];
	m_pIMContainer          = [[CAttributeContainer alloc] init];
	m_pRelateContainer      = [[CAttributeContainer alloc] init];
	
	[self LoadAttribute];
	
	[self setEditing:NO animated:NO];
}


-(void)LoadAttribute
{
	[m_pContainer		      removeAllObject];
	[m_pMemoContainer		  removeAllObject];
	[m_pAccountsContainer     removeAllObject];
	[m_pCertificateContainer  removeAllObject];
	[m_pIMContainer           removeAllObject];
	[m_pRelateContainer       removeAllObject];
	
	CAttribute *attr = nil;
	ABRecordID  pRecordID  = ABRecordGetRecordID(m_pContact.record);
	
	attr = [[[CAttributeGroup alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"分组"];
	((CAttributeGroup*)attr).stringValue = [DataStore GetGroupName:[DataStore GetGroupID2:pRecordID]];
	
	attr = [[[CAttributeBlood alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"血型"];
	((CAttributeBlood*)attr).stringValue = [DataStore getBlood:pRecordID];
	
	attr = [[[CAttributeConstellation alloc] init] autorelease];
	[m_pContainer setValue:attr forKey:@"星座"];
	((CAttributeConstellation*)attr).stringValue = [DataStore getConstellation:pRecordID];
	
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	ContactData * AllContactData = (ContactData *)[app.m_arrContactData objectAtIndex:0];
	
	attr = [[[CAttributeRecommend alloc] init] autorelease];
	((CAttributeString*)attr).nvController = self.navigationController;
	[m_pContainer setValue:attr forKey:@"推荐人"];
	((CAttributeRecommend*)attr).stringValue = [AllContactData getContactsNameByID:[DataStore getRecommend:pRecordID]];
	
	attr = [[[CAttributeMemo alloc] init] autorelease];
	((CAttributeMemo*)attr).nvController = self.navigationController;
	((CAttributeMemo*)attr).m_nType      = Tag_Type_Memo;
	[m_pMemoContainer setValue:attr        forKey:@"纪念日"];
	
	//IM帐号
	NSArray * pArryIM = [DataStore getInstantMessages:pRecordID:1];
	for(LabelAndContent * pLabelAndContent in pArryIM)
	{
		attr = [[[CAttributeString alloc] init] autorelease];
		((CAttributeString*)attr).nvController = self.navigationController;
		((CAttributeString*)attr).m_nType      = Tag_Type_InstantMessage;
		[m_pIMContainer setValue:attr    forKey:pLabelAndContent.m_strLabel];
		((CAttributeString*)attr).stringValue  = pLabelAndContent.m_strContent;
	}
	
	//银行帐号
	NSArray * pArryAccount = [DataStore getAccounts:pRecordID];
	for(LabelAndContent * pLabelAndContent in pArryAccount)
	{
		attr = [[[CAttributeString alloc] init] autorelease];
		((CAttributeString*)attr).nvController = self.navigationController;
		((CAttributeString*)attr).m_nType      = Tag_Type_Account;
		[m_pAccountsContainer setValue:attr    forKey:pLabelAndContent.m_strLabel];
		((CAttributeString*)attr).stringValue  = pLabelAndContent.m_strContent;
	}
	
	//证件
	NSArray * pArryCertificate = [DataStore getCertificate:pRecordID];
	for(LabelAndContent * pLabelAndContent in pArryCertificate)
	{
		attr = [[[CAttributeString alloc] init] autorelease];
		((CAttributeString*)attr).nvController = self.navigationController;
		((CAttributeString*)attr).m_nType      = Tag_Type_Certificate;
		[m_pCertificateContainer setValue:attr forKey:pLabelAndContent.m_strLabel];
		((CAttributeString*)attr).stringValue  = pLabelAndContent.m_strContent;
	}
	
	//相关联系人
	NSArray * pArryRelate = [DataStore getRelate:pRecordID];
	for(LabelAndContent * pLabelAndContent in pArryRelate)
	{
		attr = [[[CAttributeRelate alloc] init] autorelease];
		((CAttributeRelate*)attr).nvController = self.navigationController;
		((CAttributeRelate*)attr).m_nType      = Tag_Type_Relate;
		[m_pRelateContainer setValue:attr forKey:pLabelAndContent.m_strLabel];
		//m_strContent是一个ID
		((CAttributeRelate*)attr).stringValue  = [AllContactData getContactsNameByID:[pLabelAndContent.m_strContent intValue]];
	}
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

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate 
{
	[super setEditing:editing animated:animate];
	[m_pTableView_IB setEditing:editing animated:animate];
	
	if (editing)
	{
		self.navigationItem.rightBarButtonItem = m_pButtonItemDone;
		//self.navigationItem.leftBarButtonItem  = m_pButtonItemCancel;
	} 
	else
	{
		self.navigationItem.rightBarButtonItem = m_pButtonItemEdit;
		//self.navigationItem.leftBarButtonItem  = m_pButtonItemReturn;
	}
 	[m_pTableView_IB reloadData];
}

- (void)dealloc 
{
	[m_pTableView_IB	 release];
	[m_pSegmentedControl release];
	[aBPersonNav		 release];
	[m_pContact			 release];
	[m_pButtonItemEdit   release];
	[m_pButtonItemDone   release];
	//[m_pButtonItemReturn release];
	[m_pButtonItemCancel release];
	
	[m_pContainer		  release];
	[m_pMemoContainer	  release];
	[m_pIMContainer       release];
	[m_pAccountsContainer release];
	[m_pCertificateContainer release];
	[m_pRelateContainer   release];
	
    [super dealloc];
}

-(IBAction)doneItemBtn:    (id)sender
{
	//保存属性
	//CFErrorRef   errorRef;
	NSError    * error;
	
	//ABAddressBookAddRecord(addressBook,m_pContact.record,&errorRef);
	//ABAddressBookSave(addressBook, &errorRef);
	
	ABRecordID  pRecordID  = ABRecordGetRecordID(m_pContact.record);
	AddressBookAppDelegate * app = [AddressBookAppDelegate getAppDelegate];
	
	CAttributeGroup *attrGroup = nil;
	//分组
	attrGroup = [m_pContainer.attributes objectAtIndex:0];
	if(attrGroup && attrGroup.stringValue)
	{
		//移除之前分组
		int nowGroupID = [DataStore GetGroupID2:pRecordID];
		ABGroup * pNowGroup = nil;
		if(nowGroupID > 0)
		{
			for(pNowGroup in app.m_arrGroup)
			{
				if(ABRecordGetRecordID(pNowGroup.record) == nowGroupID)
				{
					break;
				}
			}
			
			if([pNowGroup removeMember:m_pContact withError:&error])
			{
				[DataStore updateGroup:pRecordID:0];
			}
			
		}
		
		//设置新分组
		ABRecordID pGroupID = [DataStore GetGroupID:attrGroup.stringValue];
		
		//ABGroup * pGroup = [app.m_arrGroup objectAtIndex:2];
		ABGroup * pGroup = nil;
		
		for(pGroup in app.m_arrGroup)
		{
			if(ABRecordGetRecordID(pGroup.record) == pGroupID)
			{
				break;
			}
		}
		
		if([pGroup addMember:m_pContact withError:&error])
		{
			[DataStore updateGroup:pRecordID:pGroupID];
		}
	}
	
	//血型
	CAttributeBlood *attrBlood = nil;
	attrBlood = [m_pContainer.attributes objectAtIndex:1];
	if(attrBlood && attrBlood.stringValue)
	{
		[DataStore updateBlood:pRecordID:attrBlood.stringValue];
	}
	
	//星座
	CAttributeConstellation *attrConstellation = nil;
	attrConstellation = [m_pContainer.attributes objectAtIndex:2];
	if(attrConstellation && attrConstellation.stringValue)
	{
		[DataStore updateConstellation:pRecordID:attrConstellation.stringValue];
	}
	
	//推荐人
	CAttributeRecommend *attrRecommend = nil;
	attrRecommend = [m_pContainer.attributes objectAtIndex:3];
	if(attrRecommend && attrRecommend.m_pABContact)
	{
		[DataStore updateRecommend:pRecordID:ABRecordGetRecordID(attrRecommend.m_pABContact.record)];
	}
	
	//IM信息
	[DataStore removeInstantMessage:pRecordID:1];
	CAttributeString * attrInstantMessage = nil;
	for(int i = 0;i < [m_pIMContainer.attributes count];i++)
	{
		attrInstantMessage = [m_pIMContainer.attributes objectAtIndex:i];
		NSString *pContent = attrInstantMessage.m_pCell.textField.text;
		if(attrInstantMessage.label && pContent)
		{		
			[DataStore insertInstantMessage:pRecordID:pContent:nil:attrInstantMessage.label:i:1];
		}
	}
	
	//帐号
	[DataStore removeAllAccounts:pRecordID];
	
	CAttributeString * attrAccount = nil;
	for(int i = 0;i < [m_pAccountsContainer.attributes count];i++)
	{
		attrAccount = [m_pAccountsContainer.attributes objectAtIndex:i];
		NSString *pContent = attrAccount.m_pCell.textField.text;
		if(attrAccount.label && pContent)
		{
			[DataStore insertAccounts:pRecordID :pContent
									 :attrAccount.label :i];
		}
	}
	
	//证件
	[DataStore removeAllCertificate:pRecordID];
	
	CAttributeString * attrCertificate = nil;
	for(int i = 0;i < [m_pCertificateContainer.attributes count];i++)
	{
		attrCertificate = [m_pCertificateContainer.attributes objectAtIndex:i];
		NSString *pContent = attrCertificate.m_pCell.textField.text;
		if(attrCertificate.label && pContent)
		{
			[DataStore insertCertificate:pRecordID :pContent
										:attrCertificate.label :i];
		}
	}
	
	//相关联系人
	[DataStore removeAllRelate:pRecordID];
	CAttributeRelate * attrRelate = nil;
	for(int i = 0;i < [m_pRelateContainer.attributes count];i++)
	{
		attrRelate = [m_pRelateContainer.attributes objectAtIndex:i];
		if(attrRelate && attrRelate.m_pABContact)
		{
			[DataStore insertRelate:pRecordID:ABRecordGetRecordID(attrRelate.m_pABContact.record):attrRelate.label:i];
		}
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"changeAddress" object:nil];
	
	[self setEditing:NO animated:YES];
}

-(IBAction)cancelItemBtn:  (id)sender
{
	[self setEditing:NO animated:YES];
}

//-(IBAction)returnItemBtn:  (id)sender
//{
//	[self.navigationController	popViewControllerAnimated:YES];
//}

-(IBAction)editItemBtn:    (id)sender
{
	[self setEditing:YES animated:YES];
	
}

#pragma mark - UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[m_pSegmentedControl setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[m_pSegmentedControl setHidden:YES];
}

#pragma mark - AddField delegates
- (void)GetAddField:(id)pDic
{
	NSDictionary * resultItem = (NSDictionary * )pDic;
	NSString *text = nil;
	text = [resultItem valueForKey:@"name"];
	if(text)
	{
		CAttribute *attr = nil;
		
		NSLog(@"[%@]",text);
		if([text isEqual:@"纪念日"])
		{
			attr = [[[CAttributeMemo alloc] init] autorelease];
			((CAttributeMemo*)attr).nvController = self.navigationController;
			((CAttributeMemo*)attr).m_nType      = Tag_Type_Memo;
			[m_pMemoContainer setValue:attr forKey:@"纪念日"];
		}
		else if([text isEqual:@"证件"])
		{
			attr = [[[CAttributeString alloc] init] autorelease];
			((CAttributeString*)attr).nvController = self.navigationController;
			((CAttributeString*)attr).m_nType      = Tag_Type_Certificate;
			[m_pCertificateContainer setValue:attr forKey:@"证件"];
		}
		else if([text isEqual:@"银行帐号"])
		{
			attr = [[[CAttributeString alloc] init] autorelease];
			((CAttributeString*)attr).nvController = self.navigationController;
			((CAttributeString*)attr).m_nType      = Tag_Type_Account;
			[m_pAccountsContainer setValue:attr forKey:@"银行帐号"];
		}
		else if([text isEqual:@"IM帐号"])
		{
			attr = [[[CAttributeString alloc] init] autorelease];
			((CAttributeString*)attr).nvController = self.navigationController;
			((CAttributeString*)attr).m_nType      = Tag_Type_InstantMessage;
			[m_pIMContainer setValue:attr forKey:@"IM帐号"];
		}
		else if([text isEqual:@"相关联系人"])
		{
			attr = [[[CAttributeRelate alloc] init] autorelease];
			((CAttributeRelate*)attr).nvController = self.navigationController;
			((CAttributeRelate*)attr).m_nType      = Tag_Type_Relate;
			[m_pRelateContainer setValue:attr forKey:@"相关联系人"];
		}
		
		[m_pTableView_IB reloadData];
	}
}

#pragma mark - UITableView delegates

// if you want the entire table to just be re-orderable then just return UITableViewCellEditingStyleNone
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if(indexPath.section == SeniorInfo_TableView_Section_AddField)
		return UITableViewCellEditingStyleInsert;
	
	return UITableViewCellEditingStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if(!self.editing)
	{
		return (SeniorInfo_TableView_Section_Count - 1);
	}
	return SeniorInfo_TableView_Section_Count;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSInteger pRetNum = 1;
	
	switch (section)
	{
		case SeniorInfo_TableView_Section_Group:
		{
			pRetNum = 1;
			break;
		}
		case SeniorInfo_TableView_Section_Blood:
		{
			pRetNum = 1;
			break;
		}
		case SeniorInfo_TableView_Section_Recommend:
		{
			pRetNum = 1;
			break;
		}
		case SeniorInfo_TableView_Section_Constellation:
		{
			pRetNum = 1;
			break;
		}
		case SeniorInfo_TableView_Section_AddField:
		{
			pRetNum = 1;
			break;
		}
		case SeniorInfo_TableView_Section_Memo:
		{
			pRetNum = [m_pMemoContainer.attributes count];
			break;
		}
		case SeniorInfo_TableView_Section_Account:
		{
			pRetNum = [m_pAccountsContainer.attributes count];
			break;
		}
		case SeniorInfo_TableView_Section_Certificate:
		{
			pRetNum = [m_pCertificateContainer.attributes count];
			break;
		}
		case SeniorInfo_TableView_Section_IM:
		{
			pRetNum = [m_pIMContainer.attributes count];
			break;
		}
		case SeniorInfo_TableView_Section_Relate:
		{
			pRetNum = [m_pRelateContainer.attributes count];
			break;
		}
		default:
			break;
	}
	
	return pRetNum;
}

// to determine specific row height for each cell, override this.  In this example, each row is determined
// buy the its subviews that are embedded.
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat result = 40.0f;
	return  result;
}

// to determine which UITableViewCell to be used on a given row.
//
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	UITableViewCell *cell = nil;
	CAttribute      *attr = nil;
	
	switch (indexPath.section)
	{
		case SeniorInfo_TableView_Section_Group:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:0];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Blood:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:1];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Constellation:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:2];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Recommend:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:3];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Memo:
		{
			attr = [m_pMemoContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_Account:
		{
			attr = [m_pAccountsContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_Certificate:
		{
			attr = [m_pCertificateContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_IM:
		{
			attr = [m_pIMContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_Relate:
		{
			attr = [m_pRelateContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_AddField:
		{
			if (row == 0)
			{
				static NSString* cellIdentifier = @"AddFieldCell";
				UITableViewCell * cell2 = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
				if (![cell2 isKindOfClass:[UITableViewCell class]])
				{
					cell2 = [[[CAttributeCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier] autorelease];
					cell2.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
				}
				if (cell2 != nil)
				{
					cell2.textLabel.text = @"添加字段";
				}
				return cell2;
			}
			break;
		}
		default:
			break;
	}
	
	cell = [attr cellForTableView:tableView];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if(!m_pTableView_IB.editing)
	{
		return;
	}
	
	UIViewController *vc = nil;
	NSInteger row = [indexPath row];
	
	if(indexPath.section == SeniorInfo_TableView_Section_AddField)
	{
		NSLog(@"AddField");
		
		AddFieldVC * pVC = [[AddFieldVC alloc] init];
		
		pVC.Target   = self;
		pVC.Selector = @selector(GetAddField:);
		
		[self.navigationController pushViewController:pVC animated:YES];
		
		[pVC release];
		
		return;
	}
	
	CAttribute *attr = nil;
	
	switch (indexPath.section)
	{
		case SeniorInfo_TableView_Section_Group:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:0];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Blood:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:1];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Constellation:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:2];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Recommend:
		{
			if (row == 0)
			{
				attr = [m_pContainer.attributes objectAtIndex:3];
			}
			break;
		}
		case SeniorInfo_TableView_Section_Memo:
		{
			attr = [m_pMemoContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_Account:
		{
			attr = [m_pAccountsContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_Certificate:
		{
			attr = [m_pCertificateContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_IM:
		{
			attr = [m_pIMContainer.attributes objectAtIndex:row];
			
			break;
		}
		case SeniorInfo_TableView_Section_Relate:
		{
			attr = [m_pRelateContainer.attributes objectAtIndex:row];
			
			break;
		}
		default:
			break;
	}
	
	if (attr)
	{
		vc = [attr detailViewController:self.editing];
	}
	
	if (vc && attr)
	{
		[attr Show:vc];
	}
}

@end