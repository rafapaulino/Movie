//
//  PrincipalViewController.h
//  Movie
//
//  Created by Rafael Brigagão Paulino on 21/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PrincipalViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//local onde o player sera exibido
@property (nonatomic, weak) IBOutlet UIView *playerView;

@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;

-(IBAction)tocarLocalClicado:(id)sender;
-(IBAction)tocarRemotoClicado:(id)sender;
-(IBAction)tocarGravadoClicado:(id)sender;
-(IBAction)gravarClicado:(id)sender;

@end
