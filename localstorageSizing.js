/**
 * Created by jonathanjackson on 15/07/2014.
 */
var total = 0;
for(var x in localStorage) {
    var amount = (localStorage[x].length * 2) / 1024 / 1024;
    total += amount;
    console.log( x + " = " + amount.toFixed(2) + " MB");
}
console.log( "Total: " + total.toFixed(2) + " MB");