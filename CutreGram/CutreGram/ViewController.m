//
//  ViewController.m
//  CutreGram
//
//  Created by Juan Antonio Martin Noguera on 19/01/15.
//  Copyright (c) 2015 cloudonmobile. All rights reserved.
//

#import "ViewController.h"

#import "AWSCore.h"
#import "Cognito.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self warmUpCognitoCredentials];
    [self storeAndSyncData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Cognito 

- (void) warmUpCognitoCredentials{
    
    AWSCognitoCredentialsProvider *credentialsProvider = [AWSCognitoCredentialsProvider
                                                          credentialsWithRegionType:AWSRegionEUWest1
                                                          accountId:@"299724642337"
                                                          identityPoolId:@"eu-west-1:29df6d38-205c-48f5-8219-94da7d8281fc"
                                                          unauthRoleArn:@"arn:aws:iam::299724642337:role/Cognito_CursoMBaaSUnauth_DefaultRole"
                                                          authRoleArn:@"arn:aws:iam::299724642337:role/Cognito_CursoMBaaSAuth_DefaultRole"];
    
    AWSServiceConfiguration *configuration = [AWSServiceConfiguration configurationWithRegion:AWSRegionEUWest1
                                                                          credentialsProvider:credentialsProvider];
    
    [AWSServiceManager defaultServiceManager].defaultServiceConfiguration = configuration;
}

- (void) storeAndSyncData{
    AWSCognito *syncClient = [AWSCognito defaultCognito];
    AWSCognitoDataset *dataset = [syncClient openOrCreateDataset:@"myDataset"];
    [dataset setString:@"ejemplo" forKey:@"Ejemplo"];
    [dataset synchronize];
}

@end
