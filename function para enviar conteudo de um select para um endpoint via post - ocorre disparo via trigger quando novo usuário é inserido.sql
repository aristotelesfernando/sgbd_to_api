-- habilita o plugin da linguagem python no postgresql e deve ser executado no banco de dados em que a funcção vai ser criada
CREATE EXTENSION IF NOT EXISTS plpython3u;

-- cria a function que é chamada pela trigger toda vez que um novo registro for inserido na tabela
CREATE OR REPLACE FUNCTION send_post_request_trigger()
RETURNS trigger AS $$
import httplib2
import json

new_row = TD["new"]
json_data = json.dumps(new_row)

url = ' https://1c9f-187-13-32-189.ngrok-free.app/post_request'

headers = {'Content-type': 'application/json'}
http = httplib2.Http()

response, content = http.request(url, 'POST', headers=headers, body=json_data)

if response.status != 200:
    plpy.error('Erro ao enviar a requisição POST: ' + response.reason)

return None
$$ LANGUAGE plpython3u;


-- trigger que dispara a function no evento de insert da table 
CREATE TRIGGER after_insert_people
AFTER INSERT ON public.people
FOR EACH ROW
EXECUTE FUNCTION send_post_request_trigger();




INSERT INTO public.people (name, email, mobile, country_name) VALUES ('Fernando Oliveira', 'fernando.oliveira@gmail.com', '777-999', 'Brasil');

