trigger ExpenseTrigger on ET_Expense__c (before insert,before update,after insert) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            TransactionHistoryHandlerCLS.createTransactionHistoryRecordForExpense(Trigger.New);
        }
    }
}