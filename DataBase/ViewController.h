//
//  ViewController.h
//  DataBase
//
//  Created by Ocsmobi-5 on 12/05/17.
//  Copyright © 2017 com.oclocksoftware.SampleApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController
{
    NSMutableArray *tableDataArray;
}

@property (strong) NSManagedObject *device;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

