Public class SavingHandlerCLS{
    
    public static void CreateUpdateInvestmentData(List<ET_Saving__c> newSavingsList){
        
        List<ET_Saving__c> finalSavingsList = new List<ET_Saving__c>();
        
        for(ET_Saving__c eachRecord : newSavingsList){
            if(eachRecord.Type_Of_Saving__c == 'Investment'){
                finalSavingsList.add(eachRecord);
            }
        }
        
        if(!finalSavingsList.isEmpty()){
            processInvestmentData(finalSavingsList);
        }
    }
    
    public static void processInvestmentData(List<ET_Saving__c> newSavingsList){
        
        List<ET_Investment__c> investmentToInsertUpdateList = new List<ET_Investment__c>();
        Set<String> investmentModesSet = new Set<String>{'LIC','Mutual Fund','Stocks'};
        
        Set<Id> userAccountIdSet = new Set<Id>();
        for(ET_Saving__c eachRecord : newSavingsList){
            userAccountIdSet.add(eachRecord.User_Account__c);
        }
        
        List<ET_Investment__c> existingInvestmentList = [Select Id,User_Account__c,Investment_Type__c,Amount_Invested__c,Investment_Policy_No__c From ET_Investment__c Where User_Account__c IN: userAccountIdSet];
        Map<Id,List<ET_Investment__c>> userAccountInvestmentMap = new Map<Id,List<ET_Investment__c>>();
        Map<String,ET_Investment__c> userAccountInvestmentNoMap = new Map<String,ET_Investment__c>();
        
        for(ET_Investment__c existingRecord : existingInvestmentList){
            if(userAccountInvestmentMap.containsKey(existingRecord.User_Account__c)){
                List<ET_Investment__c> investmentList = userAccountInvestmentMap.get(existingRecord.User_Account__c);
                investmentList.add(existingRecord);
                userAccountInvestmentMap.put(existingRecord.User_Account__c,investmentList);
            }else{
                userAccountInvestmentMap.put(existingRecord.User_Account__c,new List<ET_Investment__c>{existingRecord});
            }
            String tempString = existingRecord.User_Account__c+'-'+existingRecord.Investment_Type__c+'-'+existingRecord.Investment_Policy_No__c;
            userAccountInvestmentNoMap.put(tempString,existingRecord);
        }
        
        for(ET_Saving__c eachRecord : newSavingsList){
            
            String tempString = eachRecord.User_Account__c+'-'+eachRecord.Mode_Of_Savings__c+'-'+eachRecord.Investment_Policy_No__c;
            
            if(userAccountInvestmentMap.containsKey(eachRecord.User_Account__c) && userAccountInvestmentNoMap.containsKey(tempString)){
                
                List<ET_Investment__c> allInvestmentRecord = userAccountInvestmentMap.get(eachRecord.User_Account__c);                
                
                
                if(eachRecord.Mode_Of_Savings__c != null && investmentModesSet.contains(eachRecord.Mode_Of_Savings__c)){
                    
                    if(userAccountInvestmentNoMap.containsKey(tempString)){                        
                        ET_Investment__c investmentToUpdate = updateInvestmentRecord(eachRecord,userAccountInvestmentNoMap.get(tempString));
                        investmentToInsertUpdateList.add(investmentToUpdate);
                    }else{
                        ET_Investment__c investmentToInsert = createInvestmentRecord(eachRecord);
                        investmentToInsertUpdateList.add(investmentToInsert);
                    }
                }else{
                    ET_Investment__c investmentToUpdate = updateInvestmentRecord(eachRecord,userAccountInvestmentNoMap.get(tempString));
                    investmentToInsertUpdateList.add(investmentToUpdate);
                }
                
                
                
                
            }else{
                ET_Investment__c investmentToInsert = createInvestmentRecord(eachRecord);
                investmentToInsertUpdateList.add(investmentToInsert);
            }
        }
        
        if(!investmentToInsertUpdateList.isEmpty()){
            upsert investmentToInsertUpdateList;
        }
        
    }
    
    public static ET_Investment__c createInvestmentRecord(ET_Saving__c savingrecord){
        
        ET_Investment__c newInvestment = new ET_Investment__c();
        newInvestment.Amount_Invested__c = savingrecord.Amount__c;
        newInvestment.Investment_Notes__c = 'This is an investment towards '+savingrecord.Mode_Of_Savings__c;
        newInvestment.Investment_Start_Date__c = null;
        newInvestment.Investment_Type__c = savingrecord.Mode_Of_Savings__c;
        newInvestment.Maturity_Date__c = null;
        newInvestment.User_Account__c = savingrecord.User_Account__c;
        newInvestment.Investment_Policy_No__c = savingrecord.Investment_Policy_No__c != null ? savingrecord.Investment_Policy_No__c : null;
        
        return newInvestment;
    }
    
    public static ET_Investment__c updateInvestmentRecord(ET_Saving__c savingrecord,ET_Investment__c investmentRecord){
        
        ET_Investment__c existingInvestment = new ET_Investment__c();
        existingInvestment.Amount_Invested__c = investmentRecord.Amount_Invested__c + savingrecord.Amount__c;
        existingInvestment.Id = investmentRecord.Id;      
          
        return existingInvestment;        
    }
        
}