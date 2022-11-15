Public class CreditHandlerCLS{

    public static void populateCreditFields(List<ET_Credit__c> newCreditList,Map<Id,ET_Credit__c> oldCreditMap){
        
        for(ET_Credit__c eachRecord : newCreditList ){
            
            if(eachRecord.Date_Of_Credit__c == null){
               eachRecord.Date_Of_Credit__c = System.today(); 
            }
            if(eachRecord.Amount__c != null && eachRecord.Savings_Target__c != null && eachRecord.Expense_Target__c == null){
            
                eachRecord.Expense_Target__c = eachRecord.Amount__c - eachRecord.Savings_Target__c;                
            }else if(eachRecord.Amount__c != null && eachRecord.Savings_Target__c == null && eachRecord.Expense_Target__c != null){
                
                eachRecord.Savings_Target__c = eachRecord.Amount__c - eachRecord.Expense_Target__c;
            }
            
        }
    }
    
    public static void triggerCreditValidation(List<ET_Credit__c> newCreditList,Map<Id,ET_Credit__c> oldCreditMap){
        
        Set<Id> userAccountIdSet = new Set<Id>();
        
        for(ET_Credit__c eachRecord : newCreditList ){
            userAccountIdSet.add(eachRecord.User_Account__c);
        }
        
        List<ET_Credit__c> existingcreditRecordList = [Select Id,Name,Date_Of_Credit__c From ET_Credit__c Where User_Account__c IN: userAccountIdSet Order By Createddate desc limit 1];
        
        if(!existingcreditRecordList.isEmpty()){
            Map<String,ET_Credit__c> latestCreditMap = new Map<String,ET_Credit__c>();
            
            for(ET_Credit__c eachRecord : existingcreditRecordList ){
                latestCreditMap.put(String.valueOf(eachRecord.Date_Of_Credit__c.month())+'-'+String.valueOf(eachRecord.Date_Of_Credit__c.year()),eachRecord);
            }
            
            System.debug('-------latestCreditMap-------'+latestCreditMap);
            
            for(ET_Credit__c eachRecord : newCreditList ){
                String currentMonthUniqueKey = String.valueOf(eachRecord.Date_Of_Credit__c.month())+'-'+String.valueOf(eachRecord.Date_Of_Credit__c.year());
                if(latestCreditMap.containsKey(currentMonthUniqueKey)){
                    eachRecord.addError('There can be only one Credit per Month');
                }
            }
        
        }
        
    }    
    
}