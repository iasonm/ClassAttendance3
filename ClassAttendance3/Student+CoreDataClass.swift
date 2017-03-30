import Foundation
import CoreData

@objc(Student)
public class Student: NSManagedObject {
    
    public var credit:Int {
        return Int(credit_)
    }
    
    public override func awakeFromInsert() {
        name = ""
        credit_ = 0
        notes = ""
    }

}
