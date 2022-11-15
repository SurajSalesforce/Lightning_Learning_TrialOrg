trigger ExpenseTrackerPlatformEvent on Expense_Tracker_App__e (after insert) {
    
    Map<String,String> userAccountEmailMap = new Map<String,String>();
    List<User> userToUpdateList = new List<User>();
    
    for(Expense_Tracker_App__e eachPE : Trigger.New){
        userAccountEmailMap.put(eachPE.User_Account_Email_Id__c,eachPE.User_Account_Record_Id__c);
    }
    
    List<User> userList = [Select Id,Name,Related_To_User_Id__c,Email From User Where Email IN: userAccountEmailMap.keySet()];
    
    if(!userList.isEmpty()){
        for(User user : userList ){
            
            if(userAccountEmailMap.containsKey(user.Email)){
                user.Related_To_User_Id__c = userAccountEmailMap.get(user.Email);
                userToUpdateList.add(user);
            }
        }
    }
    
    if(!userToUpdateList.isEmpty()){
        update userToUpdateList;
    }
    
}