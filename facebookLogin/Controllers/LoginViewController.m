//
//  LoginViewController.m
//  facebookLogin
//
//  Created by Deepakraj Murugesan on 12/10/15.
//  Copyright © 2015 tecsol. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "DashboardViewController.h"
#import "MBProgressHUD.h"

@interface LoginViewController (){
    /*!
     *properties of name, email,fbid and fburl.
     */
    NSString* name;
    NSString* email;
    NSString* fbid;
    NSURL *facebookurl;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*!
 *Fb signin button clicked.
 */
- (IBAction)facebookLoginClicked:(id)sender {
//saving the login method inorder to swap the main screen when the app goes background...
    [[NSUserDefaults standardUserDefaults]setObject:@"facebookSuccess" forKey:@"loginSuccess"];
    [[NSUserDefaults standardUserDefaults]synchronize];
//FBSDKLoginManager in order to read permission with the viewcontroller..
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"email", @"user_friends", @"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
           
             if (error) {
                 NSLog(@"Process error");
             } else if (result.isCancelled) {
                 NSLog(@"Cancelled");
             }
//On success case, the granted permission access will be email...
             else {
                 if ([result.grantedPermissions containsObject:@"email"])
                 {
                     NSLog(@"Logged in");
                     NSLog(@"result is:%@",result);
                     [self fetchedUser];
                 }
             }
         }];

}
/*!
 *This contains details of the fetched user details.
 */
-(void)fetchedUser{
    NSLog(@"the user token is :%@", [FBSDKAccessToken currentAccessToken]);
    
    //Checking for the usertoken of the current user is not null or nill...
    
    if ([FBSDKAccessToken currentAccessToken] != nil && ![[FBSDKAccessToken currentAccessToken]  isEqual: @"null"])
    {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
//Fetching the user details and saving it in the properties...
                 name = result[@"name"];
                 email = result[@"email"];
                 fbid = result[@"id"];
                 facebookurl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",result[@"id"]]];
/*Alter method to access the profile pic*/
// NSLog(@"picture: %@",result[@"picture"][@"data"][@"url"]);
 
                 
//saving this in the NSUserDefaults
                 [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"name"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [[NSUserDefaults standardUserDefaults]setObject:email forKey:@"email"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [[NSUserDefaults standardUserDefaults]setObject:fbid forKey:@"fbid"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 [[NSUserDefaults standardUserDefaults]setObject:[facebookurl absoluteString] forKey:@"facebookurl"];
                 [[NSUserDefaults standardUserDefaults]synchronize];
                 
//performing a segue to the dashboard view.
                 [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                 [self performSegueWithIdentifier:@"facebookSuccess" sender:self];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }

}


@end
