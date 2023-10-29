package com.zoppy.security;

import com.zoppy.entity.UserEntity;
import com.zoppy.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String phone) throws UsernameNotFoundException {

        UserEntity loggedUser =  userRepository.findOneByPhone(phone);
        if(loggedUser == null){
            throw new UsernameNotFoundException("Invalid Username");
        }
        return new User(loggedUser.getPhone(),loggedUser.getPassword(), new ArrayList<>());
    }

}
