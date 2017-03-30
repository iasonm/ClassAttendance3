import Foundation
import CoreData


extension Student {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Student> {
        return NSFetchRequest<Student>(entityName: "Student");
    }

    @NSManaged public var name: String
    @NSManaged public var credit_: Int16
    @NSManaged public var notes: String

}
