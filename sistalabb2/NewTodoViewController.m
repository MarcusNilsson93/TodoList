//
//  NewTodoViewController.m
//  sistalabb2
//
//  Created by Marcus Nilsson on 2020-01-31.
//  Copyright © 2020 Marcus Nilsson. All rights reserved.
//

#import "NewTodoViewController.h"

@interface NewTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *todoText;

@property (nonatomic, strong) NSMutableArray *todoList;
@end

@implementation NewTodoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)saveNewTodo:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _todoList = [[defaults objectForKey:@"savedTodoArray"] mutableCopy];
     
    if(self.todoList == nil){
        _todoList = [[NSMutableArray alloc] init];
    }

    [_todoList addObject: _todoText.text];
     
    [defaults setObject:_todoList forKey:@"savedTodoArray"];
    [defaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
