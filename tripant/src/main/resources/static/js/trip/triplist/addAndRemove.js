function addAndRemoveHandler(){
	//유저삭제
	$('.btn.remove').on('click',removeHandler);
	//유저추가
	$('.btn.add').on('click',addHandler);
}
//삭제
function removeHandler(){
	var removeNick =$(this).prev().text();
	var planId =$(this).parents(".trip-list.wfull").data('plan-id');
	$.ajax({
		url: "/trip/remove/nick",
		beforeSend : function(xhr){
			/* 데이터를 전송하기 전에 헤더에 csrf값을 설정 */
			xhr.setRequestHeader(header,token);},
		method:"post",
		context:this,//.btn.add
    	data: {planId:planId,removeNick: removeNick},
		success : function(result) {
			$(this).removeClass('remove');
			$(this).addClass('add');
			$(this).text('추가');
			addAndRemoveHandler();
		},
		error:ajaxErrorHandler
	});
}
//추가
function addHandler(){
	var addNick =$(this).prev().text();
	var planId =$(this).parents(".trip-list.wfull").data('plan-id');
	$.ajax({
		url: "/trip/add/nick",
		beforeSend : function(xhr){
			/* 데이터를 전송하기 전에 헤더에 csrf값을 설정 */
			xhr.setRequestHeader(header,token);},
		method:"post",
		context:this,//.btn.add
    	data: {planId:planId,addNick: addNick},
		success : function(result) {
			$(this).removeClass('add');
			$(this).addClass('remove');
			$(this).text('삭제');
			addAndRemoveHandler();
		},
		error:ajaxErrorHandler
	});
}