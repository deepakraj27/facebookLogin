//
//  DashboardViewController.m
//  facebookLogin
//
//  Created by Deepakraj Murugesan on 12/10/15.
//  Copyright © 2015 tecsol. All rights reserved.
//

#import "DashboardViewController.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface DashboardViewController (){
    /*!
     *properties of name, email,fbid and fburl.
     */
    NSString* fetchedName;
    NSString* fetchedEmail;
    NSURL* fetachedURL;
    NSString* fetchedFBid;
    NSString* fetchedFbCount;
}
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *facebookName;
@property (strong, nonatomic) IBOutlet UILabel *facebookEmailid;
@property (strong, nonatomic) IBOutlet UILabel *facebookID;
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //calling the methods
    [self settingProperty];
    [self updateOutlet];
}
/*!
 *setting the value of name, email,fbid and fburl from NSUserDefaults.
 */
-(void)settingProperty{
    fetchedName = [[NSUserDefaults standardUserDefaults]valueForKey:@"name"];
    fetchedEmail = [[NSUserDefaults standardUserDefaults]valueForKey:@"email"];
    fetchedFBid = [[NSUserDefaults standardUserDefaults]valueForKey:@"fbid"];
    fetachedURL = [[NSUserDefaults standardUserDefaults]valueForKey:@"facebookurl"];
}

/*!
 *setting the values of name, email,fbid and fburl to the PROPERTY.
 */

-(void)updateOutlet{
    self.facebookName.text = fetchedName;
    self.facebookEmailid.text = fetchedEmail;
    self.facebookID.text = fetchedFBid;
   [self.profilePicture sd_setImageWithURL:fetachedURL
                         placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    self.profilePicture.layer.cornerRadius = 50;
    self.profilePicture.layer.masksToBounds = YES;
    [self.profilePicture.layer setBorderColor:[[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:0.75]CGColor]];
    [self.profilePicture.layer setBorderWidth:6.0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 *LOGOUT button is clicked in the dashboard screen.
 */

- (IBAction)logoutButtonClicked:(id)sender {
    UIAlertController * alertLogout = [UIAlertController alertControllerWithTitle:@"Logout" message:@"Are you sure you want to Logout" preferredStyle:UIAlertControllerStyleAlert];
    
    //if YES...
    [alertLogout addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self Logoutaction];
    }]];
    
    //if NO...
    [alertLogout addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Logout Cancelled");
    }]];
    [self presentViewController:alertLogout animated:YES completion:nil];
}

//Logout action will be perfomed with this funciton...
-(void)Logoutaction
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //This calls [FBSDKAccessToken setCurrentAccessToken:nil] and [FBSDKProfile setCurrentProfile:nil].
    FBSDKLoginManager * logoutManager = [[FBSDKLoginManager alloc]init];
    [logoutManager logOut];
    
    //Making home screen as topmost screen if it is logged out...
    LoginViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:@"Home"];
    [self presentViewController:home animated:NO completion:nil];
    NSLog(@"logout successfully");
    
    //clearing the userdefaults....
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"loginSuccess"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"the token is : %@",[FBSDKAccessToken currentAccessToken]);
}
@end
