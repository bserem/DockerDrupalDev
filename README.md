# DockerDrupalDev
DDD or DockerDrupalDev is a bash script to facilitate working with Docker and
Drupal for local development.

## Start
To run right away type:  
`. DockerDrupalDev.sh` or `source DockerDrupalDev.sh` in your terminal.  
If you cloned this repo, and have the symlink in place, you can run it with:  
`. ddd` or `source ddd`.  
Do not execute the file, source it!  
Read http://superuser.com/questions/176783/what-is-the-difference-between-executing-a-bash-script-and-sourcing-a-bash-scrip
to understand why.

## Stop
Simply type `stopdev` on your terminal.

## About
DDD expects that you have a properly configured `docker-compose.yml` file. 
It is tested and working with http://docker4drupal.org/  
It enables docker, configuring Drupal if this is the first time you run it.

### Stage file proxy
By sourcing the script with an argument, you can enable stage_file_proxy in Drupal  
which will load your assets from the site you set.  
`. DockerDrupalDev.sh http://www.examle.com`

Read more: https://www.drupal.org/project/stage_file_proxy

## Credits
This script was created by [Bill Seremetis](http://srm.gr) for [Zehnplus.ch](http://zehnplus.ch)
