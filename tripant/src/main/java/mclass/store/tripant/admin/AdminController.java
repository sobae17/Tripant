package mclass.store.tripant.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("/admin")
	public String login() {
		return "admin/admin";
	}
	
}
