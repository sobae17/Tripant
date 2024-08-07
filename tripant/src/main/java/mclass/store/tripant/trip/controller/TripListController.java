package mclass.store.tripant.trip.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import mclass.store.tripant.trip.domain.TripShareEntity;
import mclass.store.tripant.trip.model.service.TripListService;

@Controller
@RequestMapping(value = "/trip")
public class TripListController {
	
	@Autowired
	private TripListService tripListService;
	
	//여행목록 불러오기 + 항목별 생성자,공유자 구별
	@GetMapping("/list")
	public String tripList(Model model , Principal principal /* ,@RequestParam String memEmail */) {
		model.addAttribute("planlist", tripListService.selectTripList(principal.getName()));
		
		return "trip/tripList";
	}
	
	//여행 삭제
	@PostMapping("/list/delete")//ajax
	@ResponseBody
	public int listDelete(Integer planId ,String role,Principal principal) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("planId", planId);
		map.put("memEmail",principal.getName());
		
		int result = 0;
		try {
			//생성자 : 1 , 공유자 : 0
			if(role.equals("1")) {
				//생성자
				result = tripListService.delete(planId);
			}else if(role.equals("0")) {
				//공유자
				result = tripListService.deleteRole(map);
			}
		} catch (DataAccessException e) {
			result = -2;
		}
		
		return result;
	}
	
	//유저검색
	@PostMapping("/search/nick")//ajax+thymeleaf-fragmenet
	public String seachNick(Model model,Integer planId, String findNick,Principal principal) {
		Map<String, Object> map = new HashMap<>();
		map.put("planId", planId);
		map.put("findNick", findNick);
		map.put("memEmail",principal.getName());
		List<TripShareEntity> nickList = tripListService.find(map);
		model.addAttribute("shareList", nickList);
		return "trip/shareMember";
	}
	
	//공유 중인 유저 리스트
	@PostMapping("/share/nick")//ajax+thymeleaf-fragmenet
	public String shareNick(Model model, Integer planId,Principal principal) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("planId", planId);
		map.put("memEmail",principal.getName());
		List<TripShareEntity> shareList = tripListService.share(map);
		//model로 데이터 보내기
		model.addAttribute("shareList", shareList);
		return "trip/shareMember";
	}
	
	
	//여행목록에 일행 추가
	@PostMapping("/add/nick")//ajax
	@ResponseBody
	public int addNick(Integer planId,String addNick)  {
		Map<String, Object> map = new HashMap<>();
		map.put("planId", planId);
		map.put("addNick",addNick);
		int result = 0;
		try {
			result = tripListService.add(map);
		} catch (DataAccessException e) {
			result = -2;
		} 
		return result;
	}
	
	//여행목록의 일행 삭제
	@PostMapping("/remove/nick")//ajax
	@ResponseBody
	public int removeNick(Integer planId,String removeNick) {
		Map<String, Object> map = new HashMap<>();
		map.put("planId", planId);
		map.put("removeNick",removeNick);
		int result = 0 ;
		try {
			result= tripListService.remove(map);
		} catch (DataAccessException e) {
			result = -2;
		}
		return result;
	}
}
