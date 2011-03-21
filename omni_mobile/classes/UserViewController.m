// Hive Omni Erp
// Copyright (C) 2008 Hive Solutions Lda.
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

// __author__    = Jo�o Magalh�es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "UserViewController.h"

@implementation UserViewController

@synthesize entity = _entity;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the entity
    [self.entity release];

    // calls the super
    [super dealloc];
}

- (NSString *)getRemoteUrl {
    // retrieves the entity object id
    NSNumber *entityObjectId = [self.entity objectForKey:@"object_id"];

    // creates the url from the object id
    NSString *url = [NSString stringWithFormat:@"http://172.16.0.24:8080/colony_mod_python/rest/mvc/omni/users/%@.json", [entityObjectId stringValue]];

    // returns the url
    return url;
}

- (void)changeEntity:(NSDictionary *)entity {
    // sets the entity
    self.entity = entity;

    // updates the remote
    [self updateRemote];
}

- (void)processRemoteData:(NSDictionary *)remoteData {
    // calls the super
    [super processRemoteData:remoteData];

    // retrieves the remote data attributes
    NSString *username = [remoteData objectForKey:@"username"];
    NSString *password = [remoteData objectForKey:@"password_hash"];
    NSString *email = [remoteData objectForKey:@"email"];
    NSString *secretQuestion = [remoteData objectForKey:@"secret_question"];
    NSString *secretAnswer = [remoteData objectForKey:@"secret_answer"];

    // creates the menu header items
    HMItem *title = [[HMItem alloc] initWithIdentifier:username];
    HMItem *subTitle = [[HMItem alloc] initWithIdentifier:username];
    HMItem *image = [[HMItem alloc] initWithIdentifier:@"user.png"];

    // creates the menu header group
    HMNamedItemGroup *menuHeaderGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu_header"];

    // creates the password string table cell
    HMStringTableCellItem *passwordItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"password"];
    passwordItem.name = NSLocalizedString(@"Password", @"Password");
    passwordItem.description = password;
    passwordItem.highlightable = YES;

    // creates the password string table cell
    HMStringTableCellItem *emailItem = [[HMStringTableCellItem alloc] initWithIdentifier:@"email"];
    emailItem.name = NSLocalizedString(@"E-mail", @"E-mail");
    emailItem.description = email;
    emailItem.highlightable = YES;

    // creates the first section item group
    HMItemGroup *firstSectionItemGroup = [[HMItemGroup alloc] initWithIdentifier:@"first_section"];

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu header
    [menuHeaderGroup addItem:@"title" item:title];
    [menuHeaderGroup addItem:@"subTitle" item:subTitle];
    [menuHeaderGroup addItem:@"image" item:image];

    // populates the menu list
    [firstSectionItemGroup addItem:passwordItem];
    [firstSectionItemGroup addItem:emailItem];

    // adds the sections to the menu list
    [menuListGroup addItem:firstSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"header" item:menuHeaderGroup];
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // sets the attributes
    self.remoteGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [firstSectionItemGroup release];
    [passwordItem release];
    [emailItem release];
    [menuHeaderGroup release];
    [image release];
    [subTitle release];
    [title release];
}

- (void)convertRemoteGroup:(HMNamedItemGroup *)remoteGroup {
    // calls the super
    [super convertRemoteGroup:remoteGroup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
