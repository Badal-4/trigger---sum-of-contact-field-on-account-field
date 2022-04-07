trigger trg2 on Contact (after insert, after update, after delete)
{
  /*  Map<Id, List<Contact>> acctIdOpptyListMap = new Map<Id, List<Contact>>();
    Set<Id> acctIds = new Set<Id>();
    List<Contact> opptyList = new List<Contact>();
    if(trigger.isUpdate || trigger.isInsert)
    {
        for(Contact oppty : trigger.New)
        {
            if(oppty.AccountId != null)
            {
                acctIds.add(oppty.AccountId);
            }
        }    
    }
    if(trigger.isDelete){
        for(Contact oppty : trigger.old)
        {
            if(oppty.AccountId != null)
            {
                acctIds.add(oppty.AccountId);
            }
        }    
    }
    if(acctIds.size() > 0){
        opptyList = [SELECT StoryPoints__c, AccountId FROM Contact WHERE AccountId IN : acctIds];
        for(Contact oppty : opptyList)
        {
            if(!acctIdOpptyListMap.containsKey(oppty.AccountId))
            {
                acctIdOpptyListMap.put(oppty.AccountId, new List<Contact>());
            }
            acctIdOpptyListMap.get(oppty.AccountId).add(oppty); 
        }   
        List<Account> acctList = new List<Account>();
        acctList = [SELECT nop__c FROM Account WHERE Id IN: acctIds];
        for(Account acct : acctList){
            List<Contact> tempOpptyList = new List<Contact>();
            tempOpptyList = acctIdOpptyListMap.get(acct.Id);
            Double totalOpptyAmount = 0;
            for(Contact oppty : tempOpptyList){
                if(oppty.StoryPoints__c != null){
                    totalOpptyAmount += oppty.StoryPoints__c;
                }
            }
            acct.nop__c = totalOpptyAmount;
        }
        update acctList;
    }*/
  /*  Set<Id> accId =  new Set<Id>();
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        for(Contact c : trigger.new)
        {
            if(c.StoryPoints__c != null)
            {
                accId.add(c.AccountId);
            }
        }
    }
    if(trigger.isAfter && trigger.isDelete)
    {
        for(Contact c : trigger.old)
        {
            if(c.StoryPoints__c != null)
            {
                accId.add(c.AccountId);
            }
        }
    }
    List<Contact> conList = [Select AccountId,StoryPoints__c from Contact where AccountId IN : accId];
    List<Account> acctList = new List<Account>([Select Id,nop__c from Account where Id IN : accId]);
    List<Account> accList = new List<Account>();
    Double am = 0;
    for(Contact con : conList)
    {
            am += con.StoryPoints__c;           
    }
 
    for(Account acc : acctList)
    {
        acc.nop__c = am;
        accList.add(acc);
    }
    update accList;*/
   Set<Id> accId = new Set<Id>();
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        for(Contact c : trigger.new)
        {
            if(c.StoryPoints__c != null && c.AccountId != null)
            {
                accId.add(c.AccountId);
            }
        }
    }
    if(trigger.isAfter && trigger.isDelete)
    {
       for(Contact c : trigger.old)
        {
            if(c.StoryPoints__c != null && c.AccountId != null)
            {
                accId.add(c.AccountId);
            }
        }   
    }
    
    List<Account> accList = [Select Id,nop__c from Account where Id IN : accId];
    List<Account> acctList = new List<Account>();
    List<Contact> conList = [Select AccountId,StoryPoints__c from Contact where AccountId IN : accId];
    Double totalStoryPoints = 0;
    for(Contact con : conList)
    {
        totalStoryPoints += con.StoryPoints__c;
    }
    for(Account acc  : accList)
    {
        acc.nop__c = totalStoryPoints;
        acctList.add(acc);
    }
    if(acctList.size() != null)
    {
        update acctList;
    }
}
