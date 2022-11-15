({
	doInit : function(component, event, helper) {
		//alert('---- Generate Transactions History Triggered!! ----');
        window.setTimeout($A.getCallback(function(){
            component.set("v.spinner", false); 
        }), 6);
	}
})