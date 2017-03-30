import XCTest
import CoreData
@testable import ClassAttendance3

enum Result<T> {
    case success(T)
    case failure(Error)
}

class CoreDataTests: XCTestCase {
    
    lazy var dataController:DataController = {
        return DataController()
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataControllerCreation() {
        XCTAssertNotNil(dataController, "Unable to create DataController")
    }
    
    func testManagedObjectContextCreation() {
        XCTAssertNotNil(dataController.managedObjectContext, "Unable to create managed object context on data controller")
    }
    
    func createStudent() -> Student? {
        guard let student = NSEntityDescription.insertNewObject(forEntityName: "Student", into: dataController.managedObjectContext) as? Student else { return nil }
        return student
    }
    
    func testStudentCreation() {
        if let student = createStudent() {
            XCTAssertTrue(student.name == "", "Wrong default name value for student")
            XCTAssertTrue(student.credit_ == 0, "Wrong default credit_ value for student")
            XCTAssertTrue(student.credit == 0, "Wrong default credit value for student")
            XCTAssertTrue(student.notes == "", "Wrong default notes value for student")
        } else {
            XCTAssertTrue(false, "Could not create Student entity")
        }
    }
    
    func fetchStudents()->Result<[Student]> {
        let studentFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Student")
        var fetchedStudents:[Student]
        do {
            fetchedStudents = try dataController.managedObjectContext.fetch(studentFetch) as! [Student]
            return Result.success(fetchedStudents)
        } catch {
            return Result.failure(error)
        }
    }
    
    func testStudentFetchRequest() {
        var fetchResult = fetchStudents()
        var count = 0
        switch fetchResult {
        case .success(let students):
            print("Students: \(students)")
            count = students.count
        case .failure(let error):
            XCTAssertTrue(false, "Student fetch request failed with error: \(error.localizedDescription)")
        }
        let _ = createStudent()
        fetchResult = fetchStudents()
        switch fetchResult {
        case .success(let students):
            print("Students: \(students)")
            XCTAssertTrue(students.count == count + 1)
        case .failure(let error):
            XCTAssertTrue(false, "Student fetch request failed with error: \(error.localizedDescription)")
        }
    }
}
