upstream goweb {
    server 127.0.0.1:9990 max_fails=0;
}

server {
        server_name hithttp.com www.hithttp.com;
        
        location / {
           proxy_pass http://goweb;
           proxy_redirect off; 
           proxy_set_header Host $host ; 
           proxy_set_header X-Real-IP $remote_addr ; 
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for ;
        }
}
