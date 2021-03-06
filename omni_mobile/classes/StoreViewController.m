// Hive Omni ERP
// Copyright (c) 2008-2020 Hive Solutions Lda.
//
// This file is part of Hive Omni ERP.
//
// Hive Omni ERP is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Omni ERP is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Omni ERP. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2020 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "StoreViewController.h"

@implementation StoreViewController

- (NSString *)getTitle {
    return NSLocalizedString(@"Store", @"Store");
}

- (NSString *)getRemoteUrl {
    // returns the url using the current operation type
    return [self getRemoteUrlForOperation:self.operationType];
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return [self.entityAbstraction getRemoteUrlForOperation:operationType entityName:@"stores" serializerName:@"json"];
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
    NSDictionary *primaryAddress = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_address"]);
    NSDictionary *primaryContactInformation = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_contact_information"]);
    NSString *streetName = AVOID_NULL([primaryAddress objectForKey:@"street_name"]);
    NSString *country = AVOID_NULL([primaryAddress objectForKey:@"country"]);
    NSString *email = AVOID_NULL([primaryContactInformation objectForKey:@"email"]);
    NSString *phoneNumber = AVOID_NULL([primaryContactInformation objectForKey:@"phone_number"]);
    NSDictionary *primaryMedia = AVOID_NULL_DICTIONARY([remoteData objectForKey:@"primary_media"]);
    NSString *base64Data = AVOID_NULL([primaryMedia objectForKey:@"base_64_data"]);

    // creates the colors
    HMColor *backgroundColor = [[HMColor alloc] initWithColorRed:0.96 green:0.96 blue:0.96 alpha:1.0];

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
    imageItem.description = @"building_header.png";
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

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];
    firstSectionItemGroup.data = primaryAddress;

    // creates the second section item group
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.data = primaryContactInformation;

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

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [emailItem release];
    [phoneNumberItem release];
    [countryItem release];
    [streetNameItem release];
    [menuHeaderGroup release];
    [imageItem release];
    [subTitleItem release];
    [titleItem release];
    [backgroundColor release];
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

    // retrieves the first section items
    HMItem *streetNameItem = [firstSectionItemGroup getItem:0];
    HMItem *countryItem = [firstSectionItemGroup getItem:1];

    // retrieves the second section items
    HMItem *phoneNumberItem = [secondSectionItemGroup getItem:0];
    HMItem *emailItem = [secondSectionItemGroup getItem:1];

    // sets the items in the remote data
    [remoteData addObject:[NSArray arrayWithObjects:@"store[name]", AVOID_NIL(nameItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"store[primary_address][street_name]", AVOID_NIL(streetNameItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"store[primary_address][country]", AVOID_NIL(countryItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"store[primary_contact_information][phone_number]", AVOID_NIL(phoneNumberItem.description, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"store[primary_contact_information][email]", AVOID_NIL(emailItem.description, NSString), nil]];

    // in case the image data is not set
    if(imageItem.data != nil) {
        // retrieves the base 64 data from the image data
        NSString *base64Data = [HMBase64Util encodeBase64WithData:(NSData *) imageItem.data];

        // sets the primary media attributes
        [remoteData addObject:[NSArray arrayWithObjects:@"store[primary_media][base_64_data]", AVOID_NIL(base64Data, NSString), nil]];
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
    [remoteData addObject:[NSArray arrayWithObjects:@"store[object_id]", AVOID_NIL(objectIdString, NSString), nil]];
    [remoteData addObject:[NSArray arrayWithObjects:@"object_id", AVOID_NIL(objectIdString, NSString), nil]];

    // sets the primary address's object id in case it's defined
    if(primaryAddressObjectId != nil) {
        NSString *primaryAddressObjectIdString = primaryAddressObjectId.stringValue;
        [remoteData addObject:[NSArray arrayWithObjects:@"store[primary_address][object_id]", AVOID_NIL(primaryAddressObjectIdString, NSString), nil]];
    }

    // sets the primary contact information's object id in case it's defined
    if(primaryContactInformationObjectId != nil) {
        NSString *primaryContactInformationObjectIdString = primaryContactInformationObjectId.stringValue;
        [remoteData addObject:[NSArray arrayWithObjects:@"store[primary_contact_information][object_id]", AVOID_NIL(primaryContactInformationObjectIdString, NSString), nil]];
    }
}

- (BOOL)deleteHidden {
    return YES;
}

@end
