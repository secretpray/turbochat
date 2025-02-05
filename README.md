## Turbochat

<details>
  <summary>Description</summary>

  Simple chat with Hotwire, Turbo and Stimulus.

  Implemented in Ruby 3.0 using Rails 7.0 and PostgreSQL.

</details>

<details>
  <summary>Launching</summary>

  ## Prepare

  - Redis

  ```bash
  brew install redis
  ```
  ```bash
  redis-server --daemonize yes
  ```
  - Vips

  ```bash
  brew install vips
  ```

  ## Install

  1. Download or clone repo. Install all dependencies and prepare database

  ```bash
  $ bin/setup
  ```

  2. Start server

  ```bash
  $ bin/dev
  ```
</details>

<details>
  <summary>Preview</summary>
  1-3 stage (frontend)

  https://user-images.githubusercontent.com/17977331/153748789-258c035c-e526-4a61-916a-157a29fea960.mp4

  4 stage (avatar)

  ![screen](https://user-images.githubusercontent.com/17977331/153748810-73dfad43-8e3a-437a-bdc3-eb144d617484.jpg)

  5 stage (online status)

  https://user-images.githubusercontent.com/17977331/153748830-4440b4a7-ea8f-442b-800e-720d235ecbd8.mov

  6 stage (profile modal)

  https://user-images.githubusercontent.com/17977331/153777545-1482caec-b894-418c-92e1-e6b4dda8708d.mov

  7 stage (Favorites)

  https://user-images.githubusercontent.com/17977331/154814541-ff5928f4-aaf8-4343-9821-97a8c33185f5.mov

  8 stage (Turbo Frames refactoring)

  https://user-images.githubusercontent.com/17977331/154828223-4af159e1-ef0a-4cdd-b0db-4ddfe393e07d.mov

  9 stage (User favorires, move all in :rooms Turbo Frame, fixed create Room issue)

  https://user-images.githubusercontent.com/17977331/154912660-f115923e-b92a-44bd-a2e6-0c919c81e19a.mov

  10 stage (User roles)
  
  https://user-images.githubusercontent.com/17977331/155677173-ae58cf3e-f709-4fce-abd2-0a30052d9969.mov

</details>

<details>
  <summary>License</summary>

  MIT – see `LICENSE`
</details>
