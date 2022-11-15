trigger SavingTrigger on ET_Saving__c (after insert,after update) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TransactionHistoryHandlerCLS.createTransactionHistoryRecordForSaving(Trigger.New);
            SavingHandlerCLS.CreateUpdateInvestmentData(Trigger.New);
        }
    }
}