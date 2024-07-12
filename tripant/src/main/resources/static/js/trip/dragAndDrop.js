//드래그 앤 드랍
let after_i;
let after_j;
function dragAndDrop(){
/**
 * [x] 엘리먼트의 .draggable, .container의 배열로 선택자를 지정합니다.
 * [x] draggables를 전체를 루프하면서 dragstart, dragend를 이벤트를 발생시킵니다.
 * [x] dragstart, dragend 이벤트를 발생할때 .dragging라는 클래스를 토글시킨다.
 * [x] dragover 이벤트가 발생하는 동안 마우스 드래그하고 마지막 위치해놓은 Element를 리턴하는 함수를 만듭니다.
 */
 
 	//$자체에 함수? 선언 $() 안의 선택자를 가진 모든 요소들을 선택함
    //const $ = (select) => document.querySelectorAll(select);
    const draggables = document.querySelectorAll('.packing .draggable');
    const containers = document.querySelectorAll('.packing .container');
    
    draggables.forEach(el => {
        el.addEventListener('dragstart', (e) => {
			console.log("dragstart");
            //e.target.classList.add('dragging');
            el.classList.add('dragging');
        });

        el.addEventListener('dragend', (e)=>  {
			console.log("dragend");
			console.log(e.target);
			//var el = e.target;
		    el.classList.remove('dragging')
			console.log("************el");
			console.log(el);
		
		    console.log("--------- prev");
		    console.log($(el).prev().get(0));
			
			var el_i =$(el).data("i");
			var el_j =$(el).data("j");
			
			// 같은 컬럼
			// 아래 -> 위 (맨앞)
			// 위-> 아래 (맨뒤)
			
			// 다른 컬럼
			// (맨앞)
			// (맨뒤)
			            
			var prev_i =$(el).prev().data("i");
			var prev_j =$(el).prev().data("j");
			
			console.log("======");
			console.log("el_i: "+ el_i);
			console.log("el_j: "+ el_j);
			console.log("prev_i: "+ prev_i);
			console.log("prev_j: "+ prev_j);
			console.log("after_i: "+ after_i);
			console.log("after_j: "+ after_j);
			console.log("======");
						
						
			var temp_i = ((prev_i != undefined) ? prev_i : after_i); 
			//drop 위치가 같은 column인가
			if( temp_i== el_i){
// ++++++++++ 같은 컬럼
				var details = detailListEditMode[el_i];
				var daylength = details.dayDetailInfoEntity.length;  
				var temp = JSON.parse(JSON.stringify( detailListEditMode[el_i].dayDetailInfoEntity[el_j]));
				
				if(prev_j >= 0){
					//index 크기 비교
					if(el_j > prev_j){
						for(var j=el_j-1; j > prev_j; j-- ){
							details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
						}
					}else{
						for(var j=el_j; j < prev_j; j++ ){
							details.dayDetailInfoEntity[j] = details.dayDetailInfoEntity[j+1];
						}
					}
					// 옮겨진 객체 el --> prev 다음j 위치에 대입 
					detailListEditMode[el_i].dayDetailInfoEntity[prev_j+1] = temp;
				} else {
					//drop 위치가 0번째인가 
					// 맨앞
					//index 크기 비교 불필요
					for(var j=el_j-1; j >= 0; j-- ){
						details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
					}
					detailListEditMode[el_i].dayDetailInfoEntity[0] = temp;
				}
			}/*else if (el_i == 99){
//========== 장소 추가 (장소바구니 -> 일정)
				var details = detailListEditMode[temp_i];
				var daylength = details.dayDetailInfoEntity.length;  
				if(prev_j >= 0){
					// prev 다음j 모든 객체를 +1 위치로 대입
					for(var j=daylength-1; j > prev_j; j-- ){
						details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
					}
					var temp = JSON.parse(JSON.stringify( details.dayDetailInfoEntity[prev_j+1]));
					//					var temp = {};
					temp.contentid = spotArr[el_j].contentid;
					temp.title = spotArr[el_j].title;
					temp.stayTime = spotArr[el_j].stayTime;
					temp.placeType = spotArr[el_j].spottype;
					temp.placeCat = spotArr[el_j].placeCat;
					temp.lat = spotArr[el_j].mapy;
					temp.lng = spotArr[el_j].mapx;
					temp.firstimage = spotArr[el_j].img;
					temp.address = spotArr[el_j].addr;
					temp.memo = null;
					
					details.dayDetailInfoEntity[prev_j+1]=temp;
					// jjoggan *** 장소바구니, 장소 추가 설정 변경
					afterSpotTreat(el);
//					details.dayDetailInfoEntity.unshift(temp);
					
					
				}else{
					//details.dayDetailInfoEntity.unshift(spotArr[el_j]);
					
					//0번째에 drop 하는가
					for(var j=daylength-1; j >= 0; j-- ){
						details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
					}
					console.log(spotArr[el_j]);
					var temp = JSON.parse(JSON.stringify( details.dayDetailInfoEntity[0]));
//					var temp = {};
					temp.contentid = spotArr[el_j].contentid;
					temp.title = spotArr[el_j].title;
					temp.stayTime = spotArr[el_j].stayTime;
					temp.placeType = spotArr[el_j].spottype;
					temp.placeCat = spotArr[el_j].placeCat;
					temp.lat = spotArr[el_j].mapy;
					temp.lng = spotArr[el_j].mapx;
					temp.firstimage = spotArr[el_j].img;
					temp.address = spotArr[el_j].addr;
					temp.memo = null;
					details.dayDetailInfoEntity[0]=temp;
					// jjoggan *** 장소바구니, 장소 추가 설정 변경
					afterSpotTreat(el);
//					details.dayDetailInfoEntity.unshift(temp);
					
				}
				spotArr.splice(el_j,1);
			}else if (temp_i == 99){
//========== 일정에 있던 장소를 장소바구니로 옮길 때 (일정 -> 장소바구니)
				var details = detailListEditMode[el_i];
				console.log(temp_i);
				//드랍위치가 0번째가 아닐 때
				var temp_j =((prev_j) ? prev_j : after_j);
				console.log(temp_j);
				var temp = new Spot(JSON.parse(JSON.stringify(spotArr[temp_j]))) ; // 깊은 복사하기
				
				temp.addr = details.dayDetailInfoEntity[el_j].address;
				temp.contentid = details.dayDetailInfoEntity[el_j].contentid;
				temp.id = "spot-check" + details.dayDetailInfoEntity[el_j].contentid;   //확인해볼 것
				temp.img = details.dayDetailInfoEntity[el_j].firstimage;
				temp.mapx = details.dayDetailInfoEntity[el_j].lng;
				temp.mapy = details.dayDetailInfoEntity[el_j].lat;
				temp.placeCat = details.dayDetailInfoEntity[el_j].placeCat;
				temp.spottype = details.dayDetailInfoEntity[el_j].spottype;
				temp.stayTime = details.dayDetailInfoEntity[el_j].stayTime;
				temp.title = details.dayDetailInfoEntity[el_j].title;

				//jjoggan-console
				console.log("temp.id");
				console.log(temp.id);
				
				if(prev_j>=0){
					//드랍위치가 0번째가 아닐 때
					spotArr.splice(prev_j,0,temp); // 값추가
				}else{
					//드랍위치가 0번째 일 때
					spotArr.splice(after_j,0,temp); // 값추가
				}
				details.dayDetailInfoEntity.splice(el_j,1); // 일정에서 제거
				console.log("plz check!!!! ");
				console.log(spotArr);
				console.log(detailListEditMode);
				
			}*/else{
// ++++++++++ 다른 컬럼
				if(el_i!=99 && (temp_i==99 ||temp_i===undefined)){
		//일정 -> 바구니
					var details = detailListEditMode[el_i];
					var daylength = details.dayDetailInfoEntity.length;  
					
					var temp = JSON.parse(JSON.stringify(details.dayDetailInfoEntity[0]));
					
					var addr = details.dayDetailInfoEntity[el_j].address;
					var contentid = details.dayDetailInfoEntity[el_j].contentid;
					var id = "spot-check" + details.dayDetailInfoEntity[el_j].contentid;   //확인해볼 것
					var img = details.dayDetailInfoEntity[el_j].firstimage;
					var mapx = details.dayDetailInfoEntity[el_j].lng;
					var mapy = details.dayDetailInfoEntity[el_j].lat;
					var placeCat = details.dayDetailInfoEntity[el_j].placeCat;
					var spottype = details.dayDetailInfoEntity[el_j].placeType;
					var stayTime = details.dayDetailInfoEntity[el_j].stayTime;
					var title = details.dayDetailInfoEntity[el_j].title;
					
					var tempSpot = new Spot(id,contentid,title,mapx,mapy,spottype,img,stayTime,placeCat);
					tempSpot.addr = addr;
					
					if(prev_j===undefined){
					// 배열값이 있는 상황에서 0번째 배열에 아무것도 없을 때도 0번째
						spotArr.splice(0,0,tempSpot);
					}else{
					//1~n번째	
						spotArr.splice(prev_j,0,tempSpot);
					}
					details.dayDetailInfoEntity.splice(el_j,1);
					
// console				displayEditModeAfterDragEnd();		
					console.log("일정 -> 장바구니");
					console.log("temp_i : "+temp_i);
					console.log("el_i : "+el_i);
					
				}else if(el_i == 99 && temp_i!=99){
		//바구니 -> 일정
//========== 장소 추가 (바구니 -> 일정)
					var details = detailListEditMode[temp_i];
					var daylength = details.dayDetailInfoEntity.length;  
					if(prev_j >= 0){
						// prev 다음j 모든 객체를 +1 위치로 대입
						for(var j=daylength-1; j > prev_j; j-- ){
							details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
						}
						console.log("spotArr[el_j].contentid");
						console.log(spotArr[el_j].contentid);
						var temp = JSON.parse(JSON.stringify( details.dayDetailInfoEntity[0]));
						temp.contentid = spotArr[el_j].contentid;
						temp.title = spotArr[el_j].title;
						temp.stayTime = spotArr[el_j].stayTime;
						temp.placeType = spotArr[el_j].spottype;
						temp.placeCat = spotArr[el_j].placeCat;
						temp.lat = spotArr[el_j].mapy;
						temp.lng = spotArr[el_j].mapx;
						temp.firstimage = spotArr[el_j].img;
						temp.address = spotArr[el_j].addr;
						temp.memo = null;
						
						details.dayDetailInfoEntity[prev_j+1]=temp;
						// jjoggan *** 장소바구니, 장소 추가 설정 변경
						afterSpotTreat(el);
						
						
					}else{
						//0번째에 drop 하는가
						for(var j=daylength-1; j >= 0; j-- ){
							details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
						}
						console.log(spotArr[el_j]);
						var temp = JSON.parse(JSON.stringify( details.dayDetailInfoEntity[0]));
						temp.contentid = spotArr[el_j].contentid;
						temp.title = spotArr[el_j].title;
						temp.stayTime = spotArr[el_j].stayTime;
						temp.placeType = spotArr[el_j].spottype;
						temp.placeCat = spotArr[el_j].placeCat;
						temp.lat = spotArr[el_j].mapy;
						temp.lng = spotArr[el_j].mapx;
						temp.firstimage = spotArr[el_j].img;
						temp.address = spotArr[el_j].addr;
						temp.memo = null;
						details.dayDetailInfoEntity[0]=temp;
						// jjoggan *** 장소바구니, 장소 추가 설정 변경
						afterSpotTreat(el);
						
					}
					spotArr.splice(el_j,1);
// console			
					console.log("바구니 -> 일정");
					console.log("temp_i : "+temp_i);
					console.log("el_i : "+el_i);
				}else if(el_i != 99 && temp_i!=99){
		//일정 -> 일정
//========== 컬럼이 다를 때 (일정 -> 일정)
					if(prev_j >= 0){
						var details = detailListEditMode[prev_i];
						var daylength = details.dayDetailInfoEntity.length
						// prev 다음j 모든 객체를 +1 위치로 대입
						for(var j=daylength-1; j > prev_j; j-- ){
							details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
						}
			
						// 옮겨진 객체 el --> prev 다음j 위치에 대입 
						detailListEditMode[temp_i].dayDetailInfoEntity[prev_j+1] = 
							detailListEditMode[el_i].dayDetailInfoEntity[el_j];
			
						// 옮겨진 객체 el 다음 모든 객체를 -1 위치로 대입 
						var details = detailListEditMode[el_i];
						var daylength = details.dayDetailInfoEntity.length
						for(var j=el_j+1; j < daylength; j++ ){
							details.dayDetailInfoEntity[j-1] =  details.dayDetailInfoEntity[j];
						}
						details.dayDetailInfoEntity.pop();
					} else {
						var details = detailListEditMode[temp_i];
						var daylength = details.dayDetailInfoEntity.length
						//drop 위치가 0번째인가 
						// 맨앞
						for(var j=daylength-1; j >= 0; j-- ){
							details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
						}
						// 옮겨진 객체 el --> prev 다음j 위치에 대입 
						detailListEditMode[temp_i].dayDetailInfoEntity[0] = 
							detailListEditMode[el_i].dayDetailInfoEntity[el_j];
						// 옮겨진 객체 el 다음 모든 객체를 -1 위치로 대입 
						var details = detailListEditMode[el_i];
						var daylength = details.dayDetailInfoEntity.length
						for(var j=el_j+1; j < daylength; j++ ){
							details.dayDetailInfoEntity[j-1] =  details.dayDetailInfoEntity[j];
						}
						details.dayDetailInfoEntity.pop();
// console			
						console.log("일정 -> 일정");
						console.log("temp_i : "+temp_i);
						console.log("el_i : "+el_i);
					}	
				}
			}
			console.log("detailListEditMode===2 spot + arr");
			console.log(spotArr);
			console.log(detailListEditMode);
			// *** 편집된 내용 다시 display
			displayEditModeAfterDragEnd();
			//일차별 동그라미 색 변경
			circleColorHandler();
			//maker display - TODO
			displayMarker();
			//드래그 앤 드랍
			dragAndDrop();
		});
    });

    containers.forEach(container => {
        container.addEventListener('dragover', e => {
            //console.log("dragover");
            e.preventDefault()
            const afterElement = getDragAfterElement(container, e.clientY);
            const draggable = document.querySelector('.dragging')
            // container.appendChild(draggable)
/*			console.log(draggable);
			console.log(afterElement);
			console.log("========");*/
			after_i = $(afterElement).data("i");
			after_j = $(afterElement).data("j");
            container.insertBefore(draggable, afterElement)
        })
    });
    
    function getDragAfterElement(container, y) {
        const draggableElements = [...container.querySelectorAll('.draggable:not(.dragging)')]
        

        return draggableElements.reduce((closest, child) => {
          const box = child.getBoundingClientRect() //해당 엘리먼트에 top값, height값 담겨져 있는 메소드를 호출해 box변수에 할당
          const offset = y - box.top - box.height / 2 //수직 좌표 - top값 - height값 / 2의 연산을 통해서 offset변수에 할당
          if (offset < 0 && offset > closest.offset) { // (예외 처리) 0 이하 와, 음의 무한대 사이에 조건
            return { offset: offset, element: child } // Element를 리턴
          } else {
            return closest
          }

        }, { offset: Number.NEGATIVE_INFINITY }).element
    };
    
}// dragAndDrop()

/*
function dragendHandler(e)  {
	console.log("dragend");
	console.log(e.target);
	var el = e.target;
    el.classList.remove('dragging')
	console.log("************el");
	console.log(el);

    console.log("--------- prev");
    console.log($(el).prev().get(0));
	
	var el_i =$(el).data("i");
	var el_j =$(el).data("j");
	
	// 같은 컬럼
	// 아래 -> 위 (맨앞)
	// 위-> 아래 (맨뒤)
	
	// 다른 컬럼
	// (맨앞)
	// (맨뒤)
	            
	var prev_i =$(el).prev().data("i");
	var prev_j =$(el).prev().data("j");
	
	console.log("======");
	console.log("el_i: "+ el_i);
	console.log("el_j: "+ el_j);
	console.log("prev_i: "+ prev_i);
	console.log("prev_j: "+ prev_j);
	console.log("after_i: "+ after_i);
	console.log("after_j: "+ after_j);
	console.log("======");
				
	var details = detailListEditMode[el_i];
	var daylength = details.dayDetailInfoEntity.length;
				
	var temp_i = ((prev_i) ? prev_i : after_i); 
	//drop 위치가 같은 column인가
	if( temp_i== el_i){  
		// 같은 컬럼
		var temp = JSON.parse(JSON.stringify( detailListEditMode[el_i].dayDetailInfoEntity[el_j]));
		
		if(prev_j){
			//index 크기 비교
			if(el_j > prev_j){
				for(var j=el_j-1; j > prev_j; j-- ){
					details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
				}
			}else{
				for(var j=el_j; j < prev_j; j++ ){
					details.dayDetailInfoEntity[j] = details.dayDetailInfoEntity[j+1];
				}
			}
			// 옮겨진 객체 el --> prev 다음j 위치에 대입 
			detailListEditMode[el_i].dayDetailInfoEntity[prev_j+1] = temp;
		} else {
			//drop 위치가 0번째인가 
			// 맨앞
			//index 크기 비교 불필요
			for(var j=el_j-1; j >= 0; j-- ){
				details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
			}
			detailListEditMode[el_i].dayDetailInfoEntity[0] = temp;
		}
	}else{
		//컬럼이 다를 때
		if(prev_j){
			// prev 다음j 모든 객체를 +1 위치로 대입
			for(var j=daylength-1; j > prev_j; j-- ){
				details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
			}

			// 옮겨진 객체 el --> prev 다음j 위치에 대입 
			detailListEditMode[temp_i].dayDetailInfoEntity[prev_j+1] = 
				detailListEditMode[el_i].dayDetailInfoEntity[el_j];

			// 옮겨진 객체 el 다음 모든 객체를 -1 위치로 대입 
			details = detailListEditMode[el_i];
			var daylength = details.dayDetailInfoEntity.length
			for(var j=el_j+1; j < daylength; j++ ){
				details.dayDetailInfoEntity[j-1] =  details.dayDetailInfoEntity[j];
			}
			details.dayDetailInfoEntity.pop();
		} else {
			//drop 위치가 0번째인가 
			// 맨앞
			for(var j=daylength-1; j >= 0; j-- ){
				details.dayDetailInfoEntity[j+1] =  details.dayDetailInfoEntity[j];
			}
			// 옮겨진 객체 el --> prev 다음j 위치에 대입 
			detailListEditMode[temp_i].dayDetailInfoEntity[0] = 
				detailListEditMode[el_i].dayDetailInfoEntity[el_j];
			// 옮겨진 객체 el 다음 모든 객체를 -1 위치로 대입 
			details = detailListEditMode[el_i];
			var daylength = details.dayDetailInfoEntity.length
			for(var j=el_j+1; j < daylength; j++ ){
				details.dayDetailInfoEntity[j-1] =  details.dayDetailInfoEntity[j];
			}
			details.dayDetailInfoEntity.pop();
		}
	}
	console.log("detailListEditMode===2");
	console.log(detailListEditMode);
	//편집된 내용 다시 display
	displayEditModeAfterDragEnd();
	//일차별 동그라미 색 변경
	circleColorHandler();
	//maker display - TODO
	displayMarker();
	//드래그 앤 드랍
	dragAndDrop();
}// dragendHandler()*/
