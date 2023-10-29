package com.zoppy;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloWorldController {
    @GetMapping("/hello")
    @CrossOrigin(origins = "http://localhost:59817") // Specify the allowed origin for this method
    public String sayHello(){
        return "Calling From Springboot";
    }
}
