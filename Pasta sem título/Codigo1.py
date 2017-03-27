import urllib.request
import time

for x in range(1,24):
    page = urllib.request.urlopen("http://dadosabertos.rio.rj.gov.br/apiTransporte/apresentacao/csv/onibus.cfm")
    teste=page.read()
    text = teste.decode('utf-8')
    text_file= open("/home/santanna/Documents/Projeto/codigo/saida20170112_hora%x.txt"%(x), "w")
    text_file.write(text)
    text_file.close
    time.sleep(3600)
    
