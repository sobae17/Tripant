package mclass.store.tripant.trip.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import mclass.store.tripant.trip.model.service.TripListService;

@Controller
@RequestMapping(value = "/trip")
public class TripListController {
	
	@Autowired
	private TripListService tripListService;
	
	@GetMapping("/list")
	public String tripList(Model model , Principal principal /* ,@RequestParam String memEmail */) {
		model.addAttribute("planlist", tripListService.selectTripList(principal.getName()));
		return "trip/tripList";
	}
	
	@PostMapping("/list/delete")//ajax
	@ResponseBody
	public int listDelete(Integer planId) {
		int result =  tripListService.delete(planId);
		return result;
	}
}
