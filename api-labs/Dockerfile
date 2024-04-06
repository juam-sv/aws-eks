FROM python:3.8-slim-buster

# Definir variáveis de ambiente para aumentar a segurança
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Definir diretório de trabalho
WORKDIR /app

# Atualizar pacotes e instalar dependências do sistema
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

# Copiar arquivos de código fonte
COPY . /app

# Instalar dependências Python especificadas no requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Remover pacotes de build para reduzir o tamanho da imagem
RUN apt-get remove -y gcc && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Definir usuário não privilegiado para execução do aplicativo
RUN useradd -m -U appuser
USER appuser

# Executar o aplicativo
CMD ["python", "app.py", "--host=0.0.0.0"]
