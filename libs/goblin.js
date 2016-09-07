/**
 * Created by jonathanjackson on 28/04/15.
 */
var allSpan = document.getElementsByTagName('SPAN');
for(var i = 0; i < allSpan.length; i++){
    allSpan[i].onclick=function(){
        if(this.parentNode){
            var childList = this.parentNode.getElementsByTagName('UL');
            for(var j = 0; j< childList.length;j++){
                var currentState = childList[j].style.display;
                if(currentState=="none"){
                    childList[j].style.display="block";
                }else{
                    childList[j].style.display="none";
                }
            }
        }
    }
}