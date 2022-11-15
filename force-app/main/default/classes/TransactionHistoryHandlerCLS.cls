Public class TransactionHistoryHandlerCLS{

    public static void createTransactionHistoryRecordForCredit(List<ET_Credit__c> newCreditList){
        
        List<Transactions_History__c> transactionHistoryList = new List<Transactions_History__c>();
        
        for(ET_Credit__c eachCredit : newCreditList){
            Transactions_History__c newTransactionHistoryRecord = createTransactionHistory(eachCredit.User_Account__c,'Credit',eachCredit.Date_Of_Credit__c,eachCredit.Credit_Notes__c);
            transactionHistoryList.add(newTransactionHistoryRecord);
        }    
        
        if(!transactionHistoryList.isEmpty()){
            insert transactionHistoryList;
        }
    }    
    
    public static void createTransactionHistoryRecordForSaving(List<ET_Saving__c> newSavingList){
        
        List<Transactions_History__c> transactionHistoryList = new List<Transactions_History__c>();
        
        for(ET_Saving__c eachSaving : newSavingList){
            Transactions_History__c newTransactionHistoryRecord = createTransactionHistory(eachSaving.User_Account__c,'Saving',eachSaving.Saving_Date__c,eachSaving.Savings_Notes__c);
            transactionHistoryList.add(newTransactionHistoryRecord);
        }    
        
        if(!transactionHistoryList.isEmpty()){
            insert transactionHistoryList;
        }
    }
    
    public static void createTransactionHistoryRecordForExpense(List<ET_Expense__c> newExpenseList){
        
        List<Transactions_History__c> transactionHistoryList = new List<Transactions_History__c>();
        
        for(ET_Expense__c eachExpense : newExpenseList){
            Transactions_History__c newTransactionHistoryRecord = createTransactionHistory(eachExpense.User_Account__c,'Expense',eachExpense.Expense_Date__c,eachExpense.Expense_Notes__c);
            transactionHistoryList.add(newTransactionHistoryRecord);
        }    
        
        if(!transactionHistoryList.isEmpty()){
            insert transactionHistoryList;
        }
    }
    
    public static Transactions_History__c createTransactionHistory(Id userAccountId,String transactionType,Date transactionDate,String notes){
        
        Transactions_History__c newTransactionHistory = new Transactions_History__c();
        newTransactionHistory.User_Account__c = userAccountId;
        newTransactionHistory.Transaction_Type__c = transactionType;
        newTransactionHistory.Transaction_Date__c = transactionDate;
        newTransactionHistory.Transaction_Notes__c = notes;
        
        return newTransactionHistory;
    }
    
}