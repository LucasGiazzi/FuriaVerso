# FuriaVerso

**FuriaVerso** é uma rede social feita especialmente para os fãs da FURIA! Este aplicativo permite que os usuários interajam, compartilhem postagens e explorem perfis de outros fãs, tudo em um ambiente inspirado no universo da FURIA.

---

## 📲 Funcionalidades

- 🔐 **Autenticação de Usuário**  
  Login e registro com validações e integração ao Firebase Authentication.

- 👤 **Perfil do Usuário**  
  Personalize seu perfil com nickname, bio e avatar.

- 🛡️ **Validações**  
  Verificação de unicidade para nickname e CPF, além de validações de senha e email.

- 🧭 **Navegação Intuitiva**  
  Navegação fluida entre as telas de login, registro, perfil, pesquisa e feed.

- 🔥 **Integração com Firebase**  
  Backend em tempo real para autenticação e armazenamento de dados.

- 🖼️ **Interface Moderna**  
  Design inspirado no universo FURIA, com tema escuro e elementos visuais personalizados.

- 📝 **Postagens**  
  Crie e visualize postagens no feed, com suporte a timestamps e avatares.

- 🔍 **Pesquisa de Usuários**  
  Busque usuários pelo nickname e visualize seus perfis (Em Desenvolvimento).

---

## 🚀 Tecnologias Utilizadas

- **Flutter** — Framework para desenvolvimento mobile multiplataforma.  
- **Firebase** — Autenticação e banco de dados em tempo real.  
- **Provider** — Gerenciamento de estado.  
- **Figma** — Design das telas e prototipagem.  
- **GitHub Copilot** — Assistente de desenvolvimento para otimização de código.

---

## 🎨 Layout

O design do aplicativo foi criado no Figma, com foco em simplicidade e usabilidade, mantendo a identidade visual da FURIA.  
🔗 [Link do Figma](https://www.figma.com/design/NXyfllxwmy4NVUVpM5qyTq/Telas---FuriaVerso?node-id=0-1&t=kS4lQ0CyrDWCGTzo-1)

---

## 🛠️ Estrutura do Projeto

- **`lib/`**  
  Contém o código principal do aplicativo, incluindo telas, widgets e lógica de negócios.

  - **`auth_service.dart`**  
    Serviço de autenticação com Firebase.

  - **`login.dart`**  
    Tela de login com validações e integração ao Firebase.

  - **`register.dart`**  
    Tela de registro com validações de nickname, CPF e email.

  - **`profile_page.dart`**  
    Tela de perfil do usuário, com suporte a edição de avatar, bio e localização.

  - **`search_page.dart`**  
    Tela de pesquisa de usuários pelo nickname.

  - **`home_screen.dart`**  
    Tela principal com feed de postagens e navegação entre abas.

  - **`visited_user.dart`**  
    Tela para visualizar o perfil de outros usuários.

- **`assets/`**  
  Contém imagens e ícones utilizados no aplicativo.

- **`firebase_options.dart`**  
  Configurações do Firebase para diferentes plataformas.

---

## 📦 Configuração do Ambiente

1. **Pré-requisitos**  
   - Flutter SDK instalado.  
   - Firebase configurado com as chaves no arquivo `.env`.

2. **Instalação**  
   Clone o repositório e execute os comandos abaixo:  
   ```bash
   flutter pub get
   flutter run
3. **Configuração do Firebase** 
    Certifique-se de adicionar os arquivos google-services.json (Android) e GoogleService-Info.plist (iOS) nas pastas correspondentes.

---

## 📝 Instruções de Uso

1. **Login ou Registro**  
   - Ao abrir o aplicativo, você será direcionado para a tela de login.  
   - Caso não tenha uma conta, clique em "Registrar" e preencha os campos obrigatórios (nickname, CPF, email e senha). Chegará uma mensagem no email preenchido para a validação da conta.

2. **Personalização do Perfil**  
   - Após o login, acesse seu perfil para personalizar sua bio, localização e avatar.  
   - Clique no botão "Editar Perfil" para fazer alterações.

3. **Postagens**  
   - Na tela inicial, você pode criar postagens clicando no botão de adicionar.  
   - Visualize as postagens de outros usuários no feed.

4. **Pesquisa de Usuários (em desenvolvimento)**  
   - Use a barra de pesquisa para encontrar outros usuários pelo nickname.  
   - Clique no resultado para visualizar o perfil do usuário.

---

## 👨‍💻 Autor

Desenvolvido por [Lucas Giazzi](https://github.com/LucasGiazzi)  
🎓 Estudante de Engenharia de Software na PUC-Campinas  
💙 Fã da FURIA desde sempre  
🔗 [LinkedIn](https://www.linkedin.com/in/lucasgiazzi/)

---

## 📄 Licença

Este projeto é de uso exclusivo para fins educacionais e demonstração de habilidades técnicas.