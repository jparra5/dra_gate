#!/bin/bash

#********************************************************************************
# Copyright 2014 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#********************************************************************************

#############
# Colors    #
#############
export green='\e[0;32m'
export red='\e[0;31m'
export label_color='\e[0;33m'
export no_color='\e[0m' # No Color

##################################################
# Simple function to only run command if DEBUG=1 # 
### ###############################################
debugme() {
  [[ $DEBUG = 1 ]] && "$@" || :
}

set +e
set +x 


npm install grunt
npm install grunt-cli
npm install grunt-idra


if [ -z "${CRITERIA}" ] && [ "${CRITERIA}" == " " ]; then
    echo -e "${red}A Criteria must be specified.${no_color}"
    exit 1
fi


dra_grunt_command="grunt --gruntfile=node_modules/grunt-idra/idra.js -decision=${CRITERIA}"


if [ -n "${SERVER}" ] && [ "${SERVER}" != " " ]; then
    dra_grunt_command="$dra_grunt_command -deployAnalyticsServer=${SERVER}"
fi


echo -e "\tFINAL dra_grunt_command: $dra_grunt_command"
echo ""


eval $dra_grunt_command