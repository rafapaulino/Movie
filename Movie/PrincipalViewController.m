//
//  PrincipalViewController.m
//  Movie
//
//  Created by Rafael Brigagão Paulino on 21/09/12.
//  Copyright (c) 2012 rafapaulino.com. All rights reserved.
//

#import "PrincipalViewController.h"

@interface PrincipalViewController ()
{
    MPMoviePlayerController *meuPlayer;
    NSURL *urlVideo;
    
}

@end

@implementation PrincipalViewController


-(IBAction)tocarLocalClicado:(id)sender
{
    //localizar o arquivo
    NSString *pathArquivo = [[NSBundle mainBundle] pathForResource:@"filme" ofType:@"mov"];
    
    NSURL *url = [NSURL fileURLWithPath:pathArquivo];
    
    if (meuPlayer != nil)
    {
        //se o player ja existe e eu clico novamente no botao, anes de alocar um novo player, estou descartando o anterior
        [meuPlayer stop];
        
        //OBS: addSubview ->mandamos essa msn para a iew que vai receber a subview
        //----removeFromSuperView -> mandamos essa msn para a view que vai sair da tela
        [meuPlayer.view removeFromSuperview];
        meuPlayer = nil;
    }
    
    meuPlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    
    //ajustar o frame do player
    meuPlayer.view.frame = CGRectMake(0, 0, _playerView.frame.size.width, _playerView.frame.size.height);
    
    //adicioando o player a view branca
    [_playerView addSubview:meuPlayer.view];
    
    [meuPlayer play];
}

-(IBAction)tocarRemotoClicado:(id)sender
{
    NSURL *urlRemoto = [NSURL URLWithString:@"http://tinyurl.com/4zwzmf7"];
    
    if (meuPlayer != nil)
    {
        [meuPlayer stop];
        [meuPlayer.view removeFromSuperview];
        meuPlayer = nil;
    }
    meuPlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlRemoto];
    
    _spinner.hidden = NO;
    
    //me cadastrar em uma das notificacoes do player para saber quando o video carregou e devo esconder o spinner
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(esconderSpinner:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    
    //ajustar o frame do player
    meuPlayer.view.frame = CGRectMake(0, 0, _playerView.frame.size.width, _playerView.frame.size.height);
    
    //adicioando o player a view branca
    [_playerView addSubview:meuPlayer.view];
    
    [meuPlayer play];
    
}

-(void)esconderSpinner:(NSNotification*)notificacao
{
    if (meuPlayer.loadState == MPMovieLoadStatePlayable)
    {
        //o video foi carregado e escondo o sppiner
        _spinner.hidden = YES;
        
       [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    }
    else
    {
        _spinner.hidden = NO;
    }
}

-(IBAction)gravarClicado:(id)sender
{
    if (meuPlayer != nil)
    {
        [meuPlayer stop];
        meuPlayer = nil;
    }
    
    //se o device possui camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *pickerVideo = [[UIImagePickerController alloc] init];
        
        pickerVideo.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        pickerVideo.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeMovie];
        
        pickerVideo.delegate = self;
        
        [self presentModalViewController:pickerVideo animated:YES];
    }
    else
    {
        //alertview
        NSLog(@"Glu,Glu");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //descobrindo onde o picker video salvou o video no meu device
    urlVideo = [info objectForKey:UIImagePickerControllerMediaURL];
    
    [self dismissModalViewControllerAnimated:YES];
    
}


-(IBAction)tocarGravadoClicado:(id)sender
{
    if (meuPlayer != nil)
    {
        [meuPlayer stop];
        [meuPlayer.view removeFromSuperview];
        meuPlayer = nil;
    }
    
    meuPlayer = [[MPMoviePlayerController alloc] initWithContentURL:urlVideo];
    
    meuPlayer.view.frame = CGRectMake(0, 0, _playerView.frame.size.width, _playerView.frame.size.height);
    
    [_playerView addSubview:meuPlayer.view];
    
    [meuPlayer play];
    //mudar o tocar gravado para exibir os videos gravados pelo device
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
