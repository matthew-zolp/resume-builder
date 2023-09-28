public with sharing class ResumeBuilderController {

    @AuraEnabled
    public static String getResume(){
        try {
            Resume__c resume = [SELECT Id, (SELECT Id FROM Experiences__r),(SELECT Id FROM Education__r), (SELECT Id, Certification__c FROM Resume_Certifications__r) FROM Resume__c LIMIT 1];
            List<Id> certIds = new List<Id>();
            for(Resume_Certification__c resumeCert : resume.Resume_Certifications__r){
                certIds.add(resumeCert.Certification__c);
            }
            List<Certifications__c> certs = [SELECT Id FROM Certifications__c WHERE Id IN: certIds];
            ResumeDetails resumeDetails = new ResumeDetails(resume,certs);
            system.debug('This was called' + JSON.serializePretty(resumeDetails));
            return JSON.serialize(resumeDetails);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class ResumeDetails{
        @AuraEnabled
        public Resume__c resume;
        @AuraEnabled
        public List<Certifications__c> certifications;
        @AuraEnabled
        public List<Education__c> education;
        @AuraEnabled
        public List<Experience__c> experiences;
        public ResumeDetails(Resume__c resume, List<Certifications__c> certifications) {
                this.certifications = certifications;
                this.resume = resume;
                this.education = resume.Education__r;
                this.experiences = resume.Experiences__r;
        }
    }
}