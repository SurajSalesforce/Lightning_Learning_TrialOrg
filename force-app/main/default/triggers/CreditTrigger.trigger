trigger CreditTrigger on ET_Credit__c (before insert,before update,after insert,after update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            CreditHandlerCLS.populateCreditFields(Trigger.new,null);
            CreditHandlerCLS.triggerCreditValidation(Trigger.new,Trigger.OldMap);
        }
        if(Trigger.isUpdate){
            //CreditHandlerCLS.triggerCreditValidation(Trigger.new,Trigger.OldMap);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TransactionHistoryHandlerCLS.createTransactionHistoryRecordForCredit(Trigger.New);
        }
    }
    
}