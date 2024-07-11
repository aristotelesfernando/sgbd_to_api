-- habilita o plugin da linguagem python no postgresql e deve ser executado no banco de dados em que a funcção vai ser criada
CREATE EXTENSION IF NOT EXISTS plpython3u;

-- cria a function que envia a primeira linha da tabelka
CREATE OR REPLACE FUNCTION send_post_request()
RETURNS void AS $$
import httplib2
import json

cursor = plpy.execute("SELECT * FROM public.people")

result = cursor[0]

json_data = json.dumps(result)

url = ' https://1c9f-187-13-32-189.ngrok-free.app/post_request'

headers = {'Content-type': 'application/json'}
http = httplib2.Http()

response, content = http.request(url, 'POST', headers=headers, body=json_data)

if response.status != 200:
    plpy.error('Erro ao enviar a requisição POST: ' + response.reason)
$$ LANGUAGE plpython3u;


-- cria a function que envia todas as linhas da tabela
CREATE OR REPLACE FUNCTION send_post_request()
RETURNS void AS $$
import httplib2
import json

cursor = plpy.execute("SELECT * FROM public.people")

json_data = json.dumps([dict(row) for row in cursor])

url = ' https://1c9f-187-13-32-189.ngrok-free.app/post_request'

headers = {'Content-type': 'application/json'}
http = httplib2.Http()

response, content = http.request(url, 'POST', headers=headers, body=json_data)

if response.status != 200:
    plpy.error('Erro ao enviar a requisição POST: ' + response.reason)
$$ LANGUAGE plpython3u;


-- executa a function
SELECT send_post_request();
