public class ChangeDataCaptureTriggerHandler {

    public static void executeChangeDataCapture(List<ContactChangeEvent> newContactChangeEventList){
        System.debug('======= List ========='+newContactChangeEventList);
        for(ContactChangeEvent eachEvent : newContactChangeEventList){
            EventBus.ChangeEventHeader header = eachEvent.ChangeEventHeader;
            System.debug('======= ChangeOrigin ========='+header.ChangeOrigin);
            System.debug('======= ChangeType ========='+header.ChangeType);
            System.debug('======= CommitNumber ========='+header.CommitNumber);
            System.debug('======= CommitTimestamp ========='+header.CommitTimestamp);
            System.debug('======= DiffFields ========='+header.DiffFields);
            System.debug('======= EntityName ========='+header.EntityName);
            System.debug('======= RecordIds ========='+header.RecordIds);
        }
    }
}