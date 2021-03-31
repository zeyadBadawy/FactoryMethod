import Foundation

struct Contact{
    var name: String
    var email: String
    var job: Job
    var desiredSalary: Double
    
    enum Job {
        case iOS
        case Android
        case Web
        case QA
    }
}
//====================================================================================================================================//
//MARK:- Common Interface
protocol JobContactProtocol{
    func sendRequestResumeEmail()->String
}

//====================================================================================================================================//
//MARK:- Concrete classes
struct iOSDeveloperJobSeeker: JobContactProtocol{
    var contact: Contact
    
    init(contact: Contact){
        self.contact = contact
    }
    
    func sendRequestResumeEmail()->String{
        return "Dear \(contact.name), this is the best time to be an iOS developer! Send me you're resume today! I have job opportunities that pay \(contact.desiredSalary)."
    }
}

struct AndroidDeveloperJobSeeker: JobContactProtocol{
    var contact: Contact
    
    init(contact: Contact){
        self.contact = contact
    }
    
    func sendRequestResumeEmail()->String{
        return "Dear \(contact.name), this is as decent time to be an Android developer! Send me you're resume today! I have job opportunities that pay close to the \(contact.desiredSalary) you are looking for"
    }
}

struct WebDeveloperJobSeeker: JobContactProtocol{
    var contact: Contact
    
    init(contact: Contact){
        self.contact = contact
    }
    
    func sendRequestResumeEmail()->String{
        return "Dear \(contact.name), Send me you're resume today! I have job opportunities for you."
    }
}

struct QADeveloperJobSeeker: JobContactProtocol{
    var contact: Contact
    
    init(contact: Contact){
        self.contact = contact
    }
    
    func sendRequestResumeEmail()->String{
        return "Dear \(contact.name), The market is tough but the code is still buggy!  Good news for you because I know the best companies for buggy code and they need you!"
    }
}

//====================================================================================================================================//
//MARK:- Our Factory

//Another way to create factory using protocol

protocol JobContacterProtocol {
    func getJobSeekers() -> JobContactProtocol
}

// then make you factory conform to that protocol

struct JobContacterFactory{
    static func getJobSeeker(contact:Contact) -> JobContactProtocol{
        switch contact.job {
        case .Android:
            return AndroidDeveloperJobSeeker(contact: contact)
        case .iOS:
            return iOSDeveloperJobSeeker(contact: contact)
        case .Web:
            return WebDeveloperJobSeeker(contact: contact)
        case .QA:
            return QADeveloperJobSeeker(contact: contact)
        }
    }
}

//====================================================================================================================================//
//MARK:- Client Code (with factory)

var contacts = [Contact]()
contacts.append(Contact(name: "J Rob", email: "jrob@example.com", job: .iOS, desiredSalary: 135000))

contacts.append(Contact(name: "K Rock", email: "krock@example.com", job: .Android, desiredSalary: 134000))

contacts.append(Contact(name: "P Money", email: "pmoney@example.com", job: .Web, desiredSalary: 110000))

contacts.append(Contact(name: "S Sham", email: "ssham@example.com", job: .QA, desiredSalary: 95000))



for contact in contacts{
    let client = JobContacterFactory.getJobSeeker(contact: contact)
    print (client.sendRequestResumeEmail())
}

//====================================================================================================================================//
//MARK:- Client Code (No Pattern)


for contact in contacts {
    switch contact.job {
    case .Android:
        AndroidDeveloperJobSeeker(contact: contact).sendRequestResumeEmail()
    case .iOS:
        iOSDeveloperJobSeeker(contact: contact).sendRequestResumeEmail()
    case .Web:
        WebDeveloperJobSeeker(contact: contact).sendRequestResumeEmail()
    case .QA:
        QADeveloperJobSeeker(contact: contact).sendRequestResumeEmail()
    }
}
