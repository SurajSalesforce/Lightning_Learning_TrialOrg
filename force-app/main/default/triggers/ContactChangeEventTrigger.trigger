trigger ContactChangeEventTrigger on ContactChangeEvent (after insert) {
	
    ChangeDataCaptureTriggerHandler.executeChangeDataCapture(Trigger.New);
    
}