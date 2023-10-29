package com.zoppy.controller;

import com.zoppy.entity.UserEntity;
import com.zoppy.service.UserService;
import com.zoppy.wrapper.LoginRequestWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Objects;

@RestController
public class UserController {
    @Autowired
    private UserService service;

    @PostMapping(value = "/logIn")
    public ResponseEntity<?> logIn(@RequestBody LoginRequestWrapper inputData){
        if(Objects.isNull(inputData)){
            return ResponseEntity.badRequest().body("Invalid Input Data");
        }
        return service.logIn(inputData);
    }
    @PostMapping(value = "/signUp")
    public ResponseEntity<?> signUp(@RequestBody UserEntity inputData){
        if(Objects.isNull(inputData)){
            return ResponseEntity.badRequest().body("Invalid Input Data");
        }
        return service.signUp(inputData);
    }
    @GetMapping(value = "/testMethod")
    public String testMethod(){
        System.out.println("Sup");
        return "Wasssup";
    }

}
