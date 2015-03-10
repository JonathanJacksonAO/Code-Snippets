src="https://ajax.microsoft.com/ajax/jQuery/jquery-1.4.2.min.js"

$.ajax({
    url: 'http://www.google.com',
    success:function(data){
        alert(data);
    }
});