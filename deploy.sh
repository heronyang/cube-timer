#!/bin/bash
flutter build web
echo '<?php include_once("index.html"); ?>' > build/web/index.php
echo '{}' > build/web/composer.json

# Maybe do this manually.
# cd build/web/
# git init
# heroku git:remote -a cutimer
# git add .
# git commit -am "deploy"
# git push heroku master
