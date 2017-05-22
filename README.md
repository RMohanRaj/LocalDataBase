# LocalDataBase
Its is to SAVE and FETCH data from local database
CoreData-> insert,update and delete,
Add Two buttons and Tableview in mainstoryboard,
Create IBAction for the buttons one is for insert and another is for delete,

![alt text](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)

Create the NsmutableArray to store and display values in tableview.
```
NSMutableArray *tableDataArray;
```

Add the below code to insert button
```
 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Core Data" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Cancel",@"Save", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert textFieldAtIndex:0].placeholder = @"Emp_Name";
    [alert textFieldAtIndex:1].placeholder = @"Emp_Id";
    [alert textFieldAtIndex:1].secureTextEntry=NO;
    alert.tag=111;
    [alert show];
```
Add Alertview Delegate method:-
```
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
```
tag - 111 is for insert and tag -222 is for update,
Added the insert method:-
```
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
```
once You added the data needs to fetch it to display in Tableview,for fetch data added the below code,call this method in viewdidload{}
```
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
```
For Further codes Refer the viewController.m file.
