//
//  ViewController.m
//  DreamCatcher
//
//  Created by ALIREZA TABRIZI on 2/25/16.
//  Copyright © 2016 AR-T.com, Inc. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *titles;
@property NSMutableArray *descriptions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titles = [NSMutableArray new];
    //same as above code but more explicit and more options with initWith, etc.
    self.descriptions = [[NSMutableArray alloc]init];
}


-(void)presentDreamEntry{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter New Dream" message:@"123" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Dream Title";
        
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Dream Description";
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //UITextField *textField1 = [alertController.textFields ObjectAtIndes:0];
        UITextField *textField1 = alertController.textFields.firstObject;
        [self.titles addObject:textField1.text];
        //[self.descriptions addObject:alertController.textFields.firstObject.text]; is same as
        //lines 46, 47 above the comment
        [self.descriptions addObject:alertController.textFields.lastObject.text];
        [self.tableView reloadData];
    }];

    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:false completion:nil];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.descriptions objectAtIndex:indexPath.row];
    return cell;
}

- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if(self.editing){
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
    }else {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
    }
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *title = [self.titles objectAtIndex:sourceIndexPath.row];
    [self.titles removeObject:title];
    [self.titles insertObject:title atIndex:destinationIndexPath.row];
    NSString *description = [self.descriptions objectAtIndex:sourceIndexPath.row];
    [self.descriptions removeObject:description];
    [self.descriptions insertObject:description atIndex:destinationIndexPath.row];
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    [self presentDreamEntry];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *dvc = segue.destinationViewController;
    dvc.titleString = [self.titles objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    dvc.descriptionStrng = [self.descriptions objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titles removeObjectAtIndex:indexPath.row];
    [self.descriptions removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}


@end
