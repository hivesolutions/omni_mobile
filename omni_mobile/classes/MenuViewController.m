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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "MenuViewController.h"

@implementation MenuViewController

@synthesize menuItemGroup = _menuItemGroup;

- (id)init {
    // calls the super
    self = [super init];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the menu item group
    [_menuItemGroup release];

    // calls the super
    [super dealloc];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    // calls the super
    [super viewDidAppear:animated];

    // initializes the login view controller
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];

    // pushes the login view controller
    [self.navigationController presentModalViewController:loginViewController animated:YES];

    // releases the login view controller reference
    [loginViewController release];
}
*/

- (void)constructStructures {
    // changes the title's image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 74, 22)];
    UIImage *logoImage = [UIImage imageNamed:@"header_logo.png"];
    [imageView setImage:logoImage];
    self.navigationItem.titleView = imageView;

    // creates the users button item
    HMTableCellItem *usersItem = [[HMTableCellItem alloc] initWithIdentifier:@"users"];
    usersItem.name = NSLocalizedString(@"Users", @"Users");
    usersItem.icon = @"icon_users.png";
    usersItem.highlightedIcon = @"icon_users_white.png";
    usersItem.accessoryType = @"disclosure_indicator";
    usersItem.selectable = YES;

    // creates the sales button item
    HMTableCellItem *salesItem = [[HMTableCellItem alloc] initWithIdentifier:@"sales"];
    salesItem.name = NSLocalizedString(@"Sales", @"Sales");
    salesItem.icon = @"icon_sales.png";
    salesItem.highlightedIcon = @"icon_sales_white.png";
    salesItem.accessoryType = @"disclosure_indicator";
    salesItem.selectable = YES;

    // creates the purchases button item
    HMTableCellItem *purchasesItem = [[HMTableCellItem alloc] initWithIdentifier:@"purchases"];
    purchasesItem.name = NSLocalizedString(@"Purchases", @"Purchases");
    purchasesItem.icon = @"icon_purchases.png";
    purchasesItem.highlightedIcon = @"icon_purchases_white.png";
    purchasesItem.accessoryType = @"disclosure_indicator";
    purchasesItem.selectable = YES;

    // creates the inventory button item
    HMTableCellItem *inventoryItem = [[HMTableCellItem alloc] initWithIdentifier:@"inventory"];
    inventoryItem.name = NSLocalizedString(@"Inventory", @"Inventory");
    inventoryItem.icon = @"icon_inventory.png";
    inventoryItem.highlightedIcon = @"icon_inventory_white.png";
    inventoryItem.accessoryType = @"disclosure_indicator";
    inventoryItem.selectable = YES;

    // creates the stores button item
    HMTableCellItem *storesItem = [[HMTableCellItem alloc] initWithIdentifier:@"stores"];
    storesItem.name = NSLocalizedString(@"Stores", @"Stores");
    storesItem.icon = @"icon_stores.png";
    storesItem.highlightedIcon = @"icon_stores_white.png";
    storesItem.accessoryType = @"disclosure_indicator";
    storesItem.selectable = YES;

    // creates the employees button item
    HMTableCellItem *employeesItem = [[HMTableCellItem alloc] initWithIdentifier:@"employees"];
    employeesItem.name = NSLocalizedString(@"Employees", @"Employees");
    employeesItem.icon = @"icon_users.png";
    employeesItem.highlightedIcon = @"icon_users_white.png";
    employeesItem.accessoryType = @"disclosure_indicator";

    // creates the highlights button item
    HMTableCellItem *highlightsItem = [[HMTableCellItem alloc] initWithIdentifier:@"highlights"];
    highlightsItem.name = NSLocalizedString(@"Highlights", @"Highlights");
    highlightsItem.icon = @"icon_highlights.png";
    highlightsItem.highlightedIcon = @"icon_highlights_white.png";
    highlightsItem.accessoryType = @"disclosure_indicator";
    highlightsItem.selectable = YES;

    // creates the notifications button item
    HMTableCellItem *notificationsItem = [[HMTableCellItem alloc] initWithIdentifier:@"notifications"];
    notificationsItem.name = NSLocalizedString(@"Notifications", @"Notifications");
    notificationsItem.accessoryType = @"switch";

    // creates the first section item group
    HMTableSectionItemGroup *firstSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"first_section"];

    // creates the second section item group
    HMTableSectionItemGroup *secondSectionItemGroup = [[HMTableSectionItemGroup alloc] initWithIdentifier:@"second_section"];
    secondSectionItemGroup.footerString = NSLocalizedString(@"Sentence000001", @"Sentence000001");

    // creates the menu list group
    HMItemGroup *menuListGroup = [[HMItemGroup alloc] initWithIdentifier:@"menu_list"];

    // creates the menu named item group
    HMNamedItemGroup *menuNamedItemGroup = [[HMNamedItemGroup alloc] initWithIdentifier:@"menu"];

    // populates the menu
    [firstSectionItemGroup addItem:usersItem];
    [firstSectionItemGroup addItem:salesItem];
    [firstSectionItemGroup addItem:purchasesItem];
    [firstSectionItemGroup addItem:inventoryItem];
    [firstSectionItemGroup addItem:storesItem];
    [firstSectionItemGroup addItem:employeesItem];
    [firstSectionItemGroup addItem:highlightsItem];
    [secondSectionItemGroup addItem:notificationsItem];

    [menuListGroup addItem:firstSectionItemGroup];
    [menuListGroup addItem:secondSectionItemGroup];

    // adds the menu items to the menu item group
    [menuNamedItemGroup addItem:@"list" item:menuListGroup];

    // stores the menu item group
    self.menuItemGroup = menuNamedItemGroup;

    // releases the objects
    [menuNamedItemGroup release];
    [menuListGroup release];
    [secondSectionItemGroup release];
    [firstSectionItemGroup release];
    [notificationsItem release];
    [highlightsItem release];
    [inventoryItem release];
    [employeesItem release];
    [storesItem release];
    [purchasesItem release];
    [salesItem release];
    [usersItem release];
}

- (void)didSelectUsersButton {
    // initializes the users view controller
    UsersViewController *usersViewController = [[UsersViewController alloc] initWithNibName:@"UsersViewController" bundle:[NSBundle mainBundle]];

    // pushes the user view controller
    [self.navigationController pushViewController:usersViewController animated:YES];

    // releases the users view controller reference
    [usersViewController release];
}

- (void)didSelectSalesButton {
    // initializes the sales view controller
    SalesViewController *salesViewController = [[SalesViewController alloc] initWithNibName:@"SalesViewController" bundle:[NSBundle mainBundle]];

    // pushes the sales view controller
    [self.navigationController pushViewController:salesViewController animated:YES];

    // releases the sales view controller reference
    [salesViewController release];
}

- (void)didSelectStoresButton {
    // initializes the stores view controller
    StoresViewController *storesViewController = [[StoresViewController alloc] initWithNibName:@"StoresViewController" bundle:[NSBundle mainBundle]];

    // pushes the store view controller
    [self.navigationController pushViewController:storesViewController animated:YES];

    // releases the stores view controller reference
    [storesViewController release];
}

- (void)didSelectInventoryButton {
    // initializes the inventory view controller
    InventoryViewController *inventoryViewController = [[InventoryViewController alloc] initWithNibName:@"InventoryViewController" bundle:[NSBundle mainBundle]];

    // pushes the inventory view controller
    [self.navigationController pushViewController:inventoryViewController animated:YES];

    // releases the users view controller reference
    [inventoryViewController release];
}

- (void)didSelectEmployeesButton {
    // initializes the employees view controller
    EmployeesViewController *employeesViewController = [[EmployeesViewController alloc] initWithNibName:@"EmployeesViewController" bundle:[NSBundle mainBundle]];

    // pushes the employees view controller
    [self.navigationController pushViewController:employeesViewController animated:YES];

    // releases the employees view controller reference
    [employeesViewController release];
}

- (HMNamedItemGroup *)getItemSpecification {
    return self.menuItemGroup;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didSelectItemRowWithItem:(HMItem *)item {
    if([item.identifier isEqualToString:@"users"]) {
        // calls the did select users button
        [self didSelectUsersButton];
    }
    else if([item.identifier isEqualToString:@"sales"]) {
        // calls the did select sales button
        [self didSelectSalesButton];
    }
    else if([item.identifier isEqualToString:@"inventory"]) {
        // calls the did select inventory button
        [self didSelectInventoryButton];
    }
    else if([item.identifier isEqualToString:@"stores"]) {
        // calls the did select stores button
        [self didSelectStoresButton];
    }
    else if([item.identifier isEqualToString:@"employees"]) {
        // calls the did select employees button
        [self didSelectEmployeesButton];
    }
    else {
        // initializes the menu view controller
        MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:[NSBundle mainBundle]];

        // pushes the menu view controller into the navigation controller
        [self.navigationController pushViewController:menuViewController animated:YES];

        // releases the menu view controller reference
        [menuViewController release];
    }
}

- (void)didDeselectItemRowWithItem:(HMItem *)item {
}

@end
