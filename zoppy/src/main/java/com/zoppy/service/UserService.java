package com.zoppy.service;

import com.zoppy.entity.UserEntity;
import com.zoppy.exception.ValidationException;
import com.zoppy.repository.UserRepository;
import com.zoppy.security.CustomUserDetailsService;
import com.zoppy.security.JwtHelper;
import com.zoppy.wrapper.LoginRequestWrapper;
import com.zoppy.wrapper.LoginResponseWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.regex.Pattern;

@Service
public class UserService {
    @Autowired
    private AuthenticationManager manager;

    @Autowired
    private CustomUserDetailsService userDetailsService;

    @Autowired
    private JwtHelper helper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    UserRepository userRepository;

    public ResponseEntity<?> logIn(LoginRequestWrapper credentials) {
        ResponseEntity<?> response;
        UsernamePasswordAuthenticationToken authentication =
                new UsernamePasswordAuthenticationToken(credentials.getPhone(),credentials.getPassword());

        try {
            //Login Here
            manager.authenticate(authentication);
            UserDetails userDetails = userDetailsService.loadUserByUsername(credentials.getPhone());
            String token = this.helper.generateToken(userDetails);
            LoginResponseWrapper wrapper = new LoginResponseWrapper(token);
            response = new ResponseEntity(wrapper, HttpStatus.OK);
        } catch (BadCredentialsException e) {
            response = ResponseEntity.badRequest().body("Invalid Username or Password ");
        } catch (Exception e) {
            response = ResponseEntity.badRequest().body("Something went wrong try again later :" + e.getMessage());
        }
        return response;
    }

    public ResponseEntity<?> signUp(UserEntity user) {
        //insert new user
        ResponseEntity<?> response;
        try {
            if (validateNewUser(user)) {
                user.setPassword(passwordEncoder.encode(user.getPassword()));
                userRepository.save(user);
            }
            UserDetails userDetails = new User(user.getPhone(),user.getPassword(), new ArrayList<>());
            String token = this.helper.generateToken(userDetails);
            LoginResponseWrapper wrapper = new LoginResponseWrapper(token);
            response = new ResponseEntity(wrapper, HttpStatus.OK);
        }catch(ValidationException ve){
            response = ResponseEntity.badRequest().body(ve.getMessage());
        }catch(Exception e){
            response = ResponseEntity.badRequest().body(e.getMessage());
        }
        return response;
    }

    private boolean validateNewUser(UserEntity user) throws ValidationException {
        String phoneRegex = "^[0-9]{10}$";
        if (user.getPhone() == null || user.getPhone().isEmpty() || !Pattern.matches(phoneRegex, user.getPhone())) {
            throw new ValidationException("Invalid Phone Number");
        }
        if (userRepository.findOneByPhone(user.getPhone()) != null) {
            throw new ValidationException("User Already Exists");
        }
        if (user.getName() == null || user.getName().isEmpty()) {
            throw new ValidationException("Invalid Name");
        }
        if (user.getPassword() == null || user.getPassword().length() < 6) {
            throw new ValidationException("Invalid Password");
        }
        return true;
    }


}
