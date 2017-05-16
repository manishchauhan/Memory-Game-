//
//  NotesDataModel.swift
//  cooolDiary
//
//  Created by Manish on 23/11/16.
//  Copyright © 2016 Manish. All rights reserved.
//

import UIKit
import CoreData
class MemoryDataModel: NSObject {
    
    
 
    
    static func getAllNotes(str:String?=nil)->Array<MemoryEntity>?
    {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext

      let fetchRequest:NSFetchRequest! = NSFetchRequest(entityName: "MemoryEntity")
        let sortDescriptor = NSSortDescriptor(key: "userscore", ascending: false,
                                              selector: #selector(NSString.localizedStandardCompare));
        
        fetchRequest.sortDescriptors=[sortDescriptor];
        
        //3
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            
            let highScoreArray = results as! [MemoryEntity];

            return highScoreArray;
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return nil;
        }

    }
  
    static func updateNoteList(username:String,score:NSInteger,rank:Int, completeHandler: (status:Bool)-> Void)->Void
    {
        
        let managedObjectContext =
            (UIApplication.sharedApplication().delegate
                as! AppDelegate).managedObjectContext;
        let entityDescription =
            NSEntityDescription.entityForName("MemoryEntity",
                                              inManagedObjectContext: managedObjectContext)
        
        let newScore = MemoryEntity(entity: entityDescription!,
                            insertIntoManagedObjectContext: managedObjectContext)
        newScore.username=username;
        newScore.rank=rank;
        newScore.userscore=score;
        do {
            try managedObjectContext.save()
            print("the data is saved");
            completeHandler(status: true);
            
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            completeHandler(status: false);
        }
    
    }
 
}
