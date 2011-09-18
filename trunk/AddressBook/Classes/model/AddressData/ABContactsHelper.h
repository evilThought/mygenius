/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "ABContact.h"
#import "ABGroup.h"

@interface ABContactsHelper : NSObject

NSString *string1;
// Address Book
+ (ABAddressBookRef) addressBook;

// Sorting
+ (BOOL) firstNameSorting;

// Add contacts and groups
+ (BOOL) addContact: (ABContact *) aContact withError: (NSError **) error;


// Find contacts
+ (NSArray *) contactsMatchingName:  (NSString *) fname;
+ (NSArray *) contactsMatchingName:  (NSString *) fname andName: (NSString *) lname;
+ (NSArray *) contactsMatchingPhone: (NSString *) number;

@end

// For the simple utility of it. Feel free to comment out if desired
@interface NSString (cstring)
@property (readonly) char *UTF8String;
@end