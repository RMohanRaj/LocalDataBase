//
//  AppDelegate.h
//  DataBase
//
//  Created by Ocsmobi-5 on 12/05/17.
//  Copyright © 2017 com.oclocksoftware.SampleApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//@property (strong, nonatomic) UIWindow *window;
//
//@property (readonly, strong) NSPersistentContainer *persistentContainer;
//
//- (void)saveContext;


{
@public
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel  *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator  *persistentStoreCoordinator;

@end

