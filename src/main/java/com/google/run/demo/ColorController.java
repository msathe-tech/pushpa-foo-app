package com.google.run.demo;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Configuration
@PropertySource("classpath:foo.properties")
public class ColorController {
    
    HashMap<String, String> map = new HashMap<>();
    
    @Value("${page.color:BLUE}")
    private String color;

    @GetMapping("/metadata")
    public Map<String, String> metadata() {
        
        if (map.isEmpty()) {
            
            map.put("color", color);
            map.put("Node_Name", System.getenv().get("NODE_NAME"));
            map.put("Host_IP", System.getenv().get("HOST_IP"));
            map.put("Pod_IP", System.getenv().get("POD_IP"));
            map.put("Pod_Namespace", System.getenv().get("POD_NAMESPACE"));
            map.put("Pod_Name", System.getenv().get("POD_NAME"));
            map.put("Service_Account", System.getenv().get("POD_SERVICE_ACCOUNT"));
            
        }
        return map;
    }
    

}
