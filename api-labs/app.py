from flask import Flask, request
from flask_restful import Resource, Api
from functools import wraps
import os
from datetime import datetime

app = Flask(__name__)
api = Api(app)

# Dicionário simulando um banco de dados de usuários
users = {
    "john": "password1",
    "jane": "password2"
}

# Função para verificar o token de autenticação


def authenticate(func):
    @wraps(func)
    def decorated(*args, **kwargs):
        token = request.headers.get('Authorization')
        if token or os.environ.get('AUTH_TOKEN'):
            if token == os.environ.get('AUTH_TOKEN', 'SUP3RT0K3N'):
                # Verificar o token aqui (pode ser um processo mais complexo)
                return func(*args, **kwargs)
            else:
                return {'message': 'Token de autenticação inválido.'}, 401
        else:
            return {'message': 'Token de autenticação não fornecido.'}, 401
    return decorated

# Classe para o endpoint /user


class User(Resource):
    @authenticate
    def get(self):
        return {'message': 'Endpoint /user chamado com sucesso.'}

# Classe para o endpoint /dashboard


class Dashboard(Resource):
    @authenticate
    def get(self):
        return {'message': 'Endpoint /dashboard chamado com sucesso.'}

# Classe para o endpoint /login


class Login(Resource):
    def post(self):
        username = request.json.get('username')
        password = request.json.get('password')

        if username in users and password == users[username]:
            # Lógica de geração do token de autenticação
            token = 'token_gerado_aqui'
            return {'token': token}
        else:
            return {'message': 'Credenciais inválidas.'}, 401

# Classe para o endpoint /logoff


class Logoff(Resource):
    @authenticate
    def post(self):
        # Lógica de invalidação do token de autenticação
        return {'message': 'Usuário deslogado com sucesso.'}

# Classe para o endpoint /report


class Report(Resource):
    @authenticate
    def get(self):
        return {'message': 'Endpoint /report chamado com sucesso.'}

# Classe para o endpoint /health


class Health(Resource):
    def get(self):
        return {'status': 'OK'}

# Classe para o endpoint /time


class Time(Resource):
    def get(self):
        current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        return {'time': current_time}


# Adicionar os recursos/endpoints à API
api.add_resource(User, '/user')
api.add_resource(Dashboard, '/dashboard')
api.add_resource(Login, '/login')
api.add_resource(Logoff, '/logoff')
api.add_resource(Report, '/report')
api.add_resource(Health, '/health')
api.add_resource(Time, '/time')

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
