//
//  ViewController.m
//  sistalabb2
//
//  Created by Marcus Nilsson on 2020-01-31.
//  Copyright © 2020 Marcus Nilsson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSMutableArray *todoList;
@property (nonatomic, strong) NSMutableArray *doneData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sections = [[NSMutableArray alloc] init];
    
    [_sections addObject:@"Pågående"];
    [_sections addObject:@"Klara"];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

-(void)viewDidAppear:(BOOL)animated{
    //Retrieving data from NSUserDefaults
    [self retrieveUserDefaults];
   
    //Reloading tableview data
    [_tableView reloadData];
}
 
- (void) retrieveUserDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _todoList = [[defaults objectForKey:@"savedTodoArray"] mutableCopy];
    _doneData = [[defaults objectForKey:@"doneTodoArray"] mutableCopy];
   
    //Check if "data" & "doneData" is not nil
    if(_todoList == nil){
        _todoList = [[NSMutableArray alloc] init];
    }
    if(_doneData == nil){
        _doneData = [[NSMutableArray alloc] init];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.sections count];
}
 
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sections objectAtIndex:section];
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return [_todoList count];
    }
    else{
        return [_doneData count];
    }
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
     if(indexPath.section == 0){
         cell.textLabel.text = _todoList[indexPath.row];
         cell.backgroundColor = [UIColor whiteColor];
     }
     else{
         cell.textLabel.text = _doneData[indexPath.row];
         cell.backgroundColor = [UIColor greenColor];
     }
     return cell;
}
 
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Delete the row from the data source
        if(indexPath.section == 0){
            [self.todoList removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
       
            //Spara todoList i NSUserDefaults igen.
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.todoList forKey:@"savedTodoArray"];
            [userDefaults synchronize];
        }else{
            [self.doneData removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
       
            //Spara todoList i NSUserDefaults igen.
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.doneData forKey:@"doneTodoArray"];
            [userDefaults synchronize];
        }
    }
}
 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(self.doneData == nil){
        _doneData = [[NSMutableArray alloc] init];
    }
   
    NSString *x = [_todoList objectAtIndex: indexPath.row];
    [_doneData addObject:x];
    [_todoList removeObjectAtIndex:indexPath.row];
   
    //Saving arrays in NSUserDefaults.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: _todoList forKey:@"savedTodoArray"];
    [defaults setObject:_doneData forKey:@"doneTodoArray"];
    [defaults synchronize];
    
    [_tableView reloadData];
 
}

@end
