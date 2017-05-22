//
//  ViewController.m
//  DataBase
//
//  Created by Ocsmobi-5 on 12/05/17.
//  Copyright © 2017 com.oclocksoftware.SampleApp. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    UITextField *emp_nameTextField;
    UITextField *emp_IDTextField;
    NSManagedObject *selectedDataObject;
}
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    tableDataArray = [[NSMutableArray alloc]init];
    [self FetchDataFromDataBase];
}


-(void)FetchDataFromDataBase{
    [tableDataArray removeAllObjects];
    AppDelegate *appDel=(AppDelegate *)[UIApplication sharedApplication].delegate;
    _managedObjectContext=[appDel managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee"
                                              inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray  *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"no object");
    }
    else
    {
        for(NSManagedObject* currentObj in fetchedObjects) {
            [tableDataArray addObject:currentObj];
        }}
    [_mTableView reloadData];
}



            
- (IBAction)insertData:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Core Data" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"Save", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:0].placeholder = @"Emp_Name";
    [alert textFieldAtIndex:1].placeholder = @"Emp_Id";
    [alert textFieldAtIndex:1].secureTextEntry=NO;
    alert.tag=111;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /****************** Insert Data **********************/
    if (alertView.tag==111) {
        if (buttonIndex==1) {
           emp_nameTextField = [alertView textFieldAtIndex:0];
            emp_IDTextField = [alertView textFieldAtIndex:1];
            [self insertDataIntoDataBaseWithName:emp_nameTextField.text WithCity:emp_IDTextField.text];
        }
    }
    if (alertView.tag==222) {
        if (buttonIndex==1) {
            emp_nameTextField = [alertView textFieldAtIndex:0];
            emp_IDTextField = [alertView textFieldAtIndex:1];
            [self updateDataInDataBase:emp_nameTextField.text WithCity:emp_IDTextField.text];
        }

}

}
-(void)insertDataIntoDataBaseWithName:(NSString *)name WithCity:(NSString *)city
{
    AppDelegate *appDel=(AppDelegate *)[UIApplication sharedApplication].delegate;
    _managedObjectContext = [appDel managedObjectContext];
    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:_managedObjectContext];
    
    [newDevice setValue:emp_nameTextField.text forKey:@"emp_name"];
    [newDevice setValue:emp_IDTextField.text forKey:@"emp_id"];
    
    NSError *error = nil;
    if ([_managedObjectContext save:&error]) {
        NSLog(@"data saved");
        [tableDataArray addObject:newDevice];
        [_mTableView reloadData];
    }
    else{
        NSLog(@"Error occured while saving");
    }
}

-(void)updateDataInDataBase:(NSString *)name WithCity:(NSString *)city
{
    AppDelegate *appDel=(AppDelegate *)[UIApplication sharedApplication].delegate;
    _managedObjectContext = [appDel managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    [selectedDataObject setValue:emp_nameTextField.text forKey:@"emp_name"];
    [selectedDataObject setValue:emp_IDTextField.text forKey:@"emp_id"];
    NSLog(@"object edited");
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error editing  - error:%@",error);
    }
    [_mTableView reloadData];
}


- (IBAction)deleteData:(id)sender {
    
    [_mTableView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableDataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    NSManagedObject *obj=[tableDataArray objectAtIndex:indexPath.row ];
    
    cell.textLabel.text=[obj valueForKey:@"emp_name"];
    cell.detailTextLabel.text=[obj valueForKey:@"emp_id"];
    cell.backgroundColor=[UIColor colorWithRed:76/255.0 green:158/255.0 blue:235/255.0 alpha:1.0];
    cell.contentView.backgroundColor=[UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *obj=[tableDataArray objectAtIndex:indexPath.row ];
    selectedDataObject=obj;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Core Data" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"Save", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:0].placeholder = @"Emp_Name";
    [alert textFieldAtIndex:1].placeholder = @"Emp_Id";
    [alert textFieldAtIndex:1].secureTextEntry=NO;
    [alert textFieldAtIndex:0].text=[obj valueForKey:@"emp_name"];
    [alert textFieldAtIndex:1].text=[obj valueForKey:@"emp_id"];
    alert.tag=222;
    [alert show];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle) editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        AppDelegate *appDel=(AppDelegate *)[UIApplication sharedApplication].delegate;
        NSManagedObjectContext *context = [appDel managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee" inManagedObjectContext:context];
        [fetchRequest setEntity:entity];
        
        NSError *error;
        [_managedObjectContext deleteObject:[tableDataArray objectAtIndex:indexPath.row]];
        
        NSLog(@"object deleted");
        
        if (![_managedObjectContext save:&error])
        {
            NSLog(@"Error deleting  - error:%@",error);
        }
        
        [tableDataArray removeObjectAtIndex:indexPath.row];
        [_mTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_mTableView setEditing:NO animated:YES];
    }
    
}

@end
