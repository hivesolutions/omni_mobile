// Hive Omni Erp
// Copyright (C) 2008-2016 Hive Solutions Lda.
//
// This file is part of Hive Omni Erp.
//
// Hive Omni Erp is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Omni Erp is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Omni Erp. If not, see <http://www.gnu.org/licenses/>.

// __author__    = Luís Martinho <lmartinho@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "EmployeeViewController.h"

@implementation EmployeeViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"Employee", @"Employee");
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"employees" serializerName:@"json"];
}

- (NSString *)getItemName {
    return @"employee";
}

- (NSString *)getItemTitleName {
    return @"name";
}

- (void)processEmpty {
    // calls the super
    [super processEmpty];

    // creates the empty remote data dictionary
    NSDictionary *emptyRemoteData = [[NSDictionary alloc] init];

    // processes the empty remote data
    [self processRemoteData:emptyRemoteData];

    // releases the objects
    [emptyRemoteData release];
}

- (void)processRemoteData:(NSDictionary *)remoteData {
    // calls the super
    [super processRemoteData:remoteData];

    // retrieves the remote data attributes
    NSString *name = AVOID_NULL([remoteData objectForKey:@"name"]);
    NSNumber *commission = AVOID_NULL([remoteData objectForKey:@"commission"]);
    NSDictionary *primaryAddress = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_address"]);
    NSDictionary *primaryContactInformation = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_contact_information"]);
    NSString *streetName = AVOID_NULL([primaryAddress objectForKey:@"street_name"]);
    NSString *country = AVOID_NULL([primaryAddress objectForKey:@"country"]);
    NSString *email = AVOID_NULL([primaryContactInformation objectForKey:@"email"]);
    NSString *phoneNumber = AVOID_NULL([primaryContactInformation objectForKey:@"phone_number"]);
    NSDictionary *primaryMedia = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_media"]);
    NSString *base64Data = AVOID_NULL([primaryMedia objectForKey:@"base_64_data"]);

    // creates a string representation of
    // the commission in percentage format
    float commissionPercentageFloat = commission.floatValue * 100;
    NSNumber *commissionPercentageNumber = [NSNumber numberWithFloat:commissionPercentageFloat];
    int commissionPercentageInteger = commissionPercentageNumber.intValue;
    NSString *commissionString = [NSString stringWithFormat:@"%d", commissionPercentageInteger];

    // creates the colors
    HMColor *backgroundColor = [[HMColor alloc] initWithColorRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    HMColor *descriptionColor = [[HMColor alloc] initWithColorRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    HMColor *descriptionColorHighlighted = [[HMColor alloc] initWithColorRed:0.54 green:0.56 blue:0.62 alpha:1.0];

    // creates the images
    HMImage *badgeImage = [[HMImage alloc] initWithImageName:@"badge" leftCap:4 topCap:4];
    HMImage *badgeHighlightedImage = [[HMImage alloc] initWithImageName:@"badge_highlighted" leftCap:4 topCap:4];

    // creates the percentage accessory item
    HMAccessoryItem *percentageAccessoryItem = [[HMAccessoryItem alloc] init];
    percentageAccessoryItem.description = @"%";
    percentageAccessoryItem.descriptionColor = descriptionColor;
    percentageAccessoryItem.descriptionColorHighlighted = descriptionColorHighlighted;
    percentageAccessoryItem.imageNormal = badgeImage;
    percentageAccessoryItem.imageHighlighted = badgeHighlightedImage;

    // creates the title item
    HMStringTableCellItem *titleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"title"];
    titleItem.defaultValue = NSLocalizedString(@"Name", @"Name");
    titleItem.description = name;
    titleItem.clearable = YES;
    titleItem.backgroundColor = backgroundColor;

    // creates the subtitle item
    HMStringTableCellItem *subTitleItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"subTitle"];
    subTitleItem.description = @"";
    subTitleItem.clearable = YES;
    subTitleItem.backgroundColor = backgroundColor;

    // creates the image item
    HMItem *imageItem = [[HMItem alloc] initWithIdentifier:@"image"];
    imageItem.description = @"person_header.png";
    imageItem.data = [HMBase64Util decodeBase64WithString:base64Data];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the street name string table cell item
    HMStringTableCellItem *streetNameItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"street_name"];
    streetNameItem.name = NSLocalizedString(@"Street Name", @"Street Name");
    streetNameItem.nameAlignment = HMTextAlignmentRight;
    streetNameItem.description = streetName;
    streetNameItem.multipleLines = YES;
    streetNameItem.backgroundColor = backgroundColor;

    // creates the country string table cell item
    HMStringTableCellItem *countryItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"country"];
    countryItem.name = NSLocalizedString(@"Country", @"Country");
    countryItem.nameAlignment = HMTextAlignmentRight;
    countryItem.description = country;
    countryItem.backgroundColor = backgroundColor;

    // creates the phone number string table cell item
    HMStringTableCellItem *phoneNumberItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"phone_number"];
    phoneNumberItem.name = NSLocalizedString(@"Phone", @"Phone");
    phoneNumberItem.nameAlignment = HMTextAlignmentRight;
    phoneNumberItem.description = phoneNumber;
    phoneNumberItem.backgroundColor = backgroundColor;

    // creates the email string table cell item
    HMStringTableCellItem *emailItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"email"];
    emailItem.name = NSLocalizedString(@"E-mail", @"E-mail");
    emailItem.nameAlignment = HMTextAlignmentRight;
    emailItem.description = email;
    emailItem.backgroundColor = backgroundColor;

    // creates the commission string table cell item
    HMStringTableCellItem *commissionItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"commission"];
    commissionItem.name = NSLocalizedString(@"Commission", @"Commission");
    commissionItem.nameAlignment = HMTextAlignmentRight;
    commissionItem.description = commissionString;
    commissionItem.accessory = percentageAccessoryItem;
    commissionItem.backgroundColor = backgroundColor;

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    firstSectionItemGroup.data = primaryAddress;

    // creates the second section item group
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.data = primaryContactInformation;

    // creates the third section item group
    HMTableSectionItemGroup *thirdSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"third_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:titleItem];
    [menuHeaderGroup addItem:@"subTitle" item:subTitleItem];
    [menuHeaderGroup addItem:@"image" item:imageItem];

    // populates the first section item group
    [firstSectionItemGroup addItem:streetNameItem];
    [firstSectionItemGroup addItem:countryItem];

    // populates the second section item group
    [secondSectionItemGroup addItem:phoneNumberItem];
    [secondSectionItemGroup addItem:emailItem];

    // populates the third section item group
    [thirdSectionItemGroup addItem:commissionItem];

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];
    [menuListGroup addItem:thirdSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [thirdSectionItemGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [commissionItem release];
    [emailItem release];
    [phoneNumberItem release];
    [countryItem release];
    [streetNameItem release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
    [percentageAccessoryItem release];
    [descriptionColorHighlighted release];
    [descriptionColor release];
    [backgroundColor release];
    [badgeHighlightedImage release];
    [badgeImage release];
}

- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType {
    // calls the super
    NSMutableArray *remoteData = [super convertRemoteGroup:operationType];

    // retrieves the menu header named group
    HMNamedItemGroup *menuHeaderNamedGroup = (HMNamedItemGroup *) [self.remoteGroup getItem:@"header"];

    // retrieves the header items
    HMItem *nameItem = [menuHeaderNamedGroup getItem:@"title"];
    HMItem *imageItem = [menuHeaderNamedGroup getItem:@"image"];

    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retrieves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];
    HMItemGroup *secondSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:1];
    HMItemGroup *thirdSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:2];

    // retrieves the first section items
    HMItem *streetNameItem = [firstSectionItemGroup getItem:0];
    HMItem *countryItem = [firstSectionItemGroup getItem:1];

    // retrieves the second section items
    HMItem *phoneNumberItem = [secondSectionItemGroup getItem:0];
    HMItem *emailItem = [secondSectionItemGroup getItem:1];

    // retrieves the commission section items
    HMItem *commissionItem = [thirdSectionItemGroup getItem:0];

    // calculates the commission value
    NSString *commissionPercentageString = commissionItem.description;
    float commissionPercentage = commissionPercentageString.floatValue;
    float commission = commissionPercentage / 100;
    NSString *commissionString = [NSString stringWithFormat:@"%f", commission];

    // sets the items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[name]", AVOID_NIL(nameItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[commission]", AVOID_NIL(commissionString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_address][street_name]", AVOID_NIL(streetNameItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_address][country]", AVOID_NIL(countryItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_contact_information][phone_number]", AVOID_NIL(phoneNumberItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_contact_information][email]", AVOID_NIL(emailItem.description, NSString), nil]];

    // in case the image data is not set
    if(imageItem.data != nil) {
        // retrieves the base 64 data from the image data
        NSString *base64Data = [HMBase64Util encodeBase64WithData:(NSData *) imageItem.data];

        // sets the primary media attributes
        [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_media][base_64_data]", AVOID_NIL(base64Data, NSString), nil]];
    }

    // returns the remote data
    return remoteData;
}

- (void)convertRemoteGroupUpdate:(NSMutableArray *)remoteData {
    // retrieves the menu list group
    HMItemGroup *menuListGroup = (HMItemGroup *) [self.remoteGroup getItem:@"list"];

    // retrieves the section item groups
    HMItemGroup *firstSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:0];
    HMItemGroup *secondSectionItemGroup = (HMItemGroup *) [menuListGroup getItem:1];

    // retrieves the attributes
    NSNumber *objectId = [self.entity objectForKey:@"object_id"];
    NSString *objectIdString = objectId.stringValue;
    NSDictionary *primaryAddress = AVOID_NULL_DICTIONARY(firstSectionItemGroup.data);
    NSDictionary *primaryContactInformation = AVOID_NULL_DICTIONARY(secondSectionItemGroup.data);
    NSNumber *primaryAddressObjectId = [primaryAddress objectForKey:@"object_id"];
    NSNumber *primaryContactInformationObjectId = [primaryContactInformation objectForKey:@"object_id"];

    // sets the object id (structured and unstructured)
    [remoteData addObject:[NSArray arrayWithObjects:@"employee[object_id]", AVOID_NIL(objectIdString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"object_id", AVOID_NIL(objectIdString, NSString), nil]];

    // sets the primary address's object id in case it's defined
    if(primaryAddressObjectId != nil) {
        NSString *primaryAddressObjectIdString = primaryAddressObjectId.stringValue;
        [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_address][object_id]", AVOID_NIL(primaryAddressObjectIdString, NSString), nil]];
    }

    // sets the primary contact information's object id in case it's defined
    if(primaryContactInformationObjectId != nil) {
        NSString *primaryContactInformationObjectIdString = primaryContactInformationObjectId.stringValue;
        [remoteData addObject:[NSArray arrayWithObjects:@"employee[primary_contact_information][object_id]", AVOID_NIL(primaryContactInformationObjectIdString, NSString), nil]];
    }
}

- (BOOL)deleteHidden {
    return YES;
}

@end
