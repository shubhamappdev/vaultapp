//
//  TouchIDViewController.m
//  vaultappv1
//
//  Created by Bhalachandra Banavalikar on 7/23/17.
//  Copyright © 2017 Shubham Banavalikar. All rights reserved.
//

#import "TouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AccountsDisplayViewController.h"

@interface TouchIDViewController () <UIAlertViewDelegate>

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) authenticateButtonTapped:(id)sender {
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
        localizedReason:@"Are you the device owner?"
        reply:^(BOOL success, NSError *error) {
        if (error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"There was a problem verifying your identity." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        if (success) {
            /*UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"You are the device owner!" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];*/
            [self performSegueWithIdentifier:@"Custom" sender:self];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"You are not the device owner." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        }];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Your device cannot authenticate using TouchID." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertController *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"Came");
    if (buttonIndex == 0)
    {
        NSLog(@"cancel");
    }
    else if([alertView.title  isEqual: @"Success"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle:nil];
        AccountsDisplayViewController *viewController = (AccountsDisplayViewController *)[storyboard instantiateViewControllerWithIdentifier:@"AccountsDisplayViewController"];
        [self presentViewController:viewController animated:YES completion:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
