#!/bin/bash
#
# The Super Simple Docker wrapper - generates random container names based on included dictionaries
# https://github.com/lukaszciechanowicz/dockerwrapper
#
# Adjectives list: https://describingwords.net/describing-words-to-describe-a-hero/
# Adjectives and Heroes list: https://github.com/moby/moby/blob/master/pkg/namesgenerator/names-generator.go

docker_bin=$(which docker) || exit 1
params=$@
max_retries=20

adjectives=(
    "admirable"
    "adventurous"
    "altruistic"
    "amazing"
    "assuming"
    "audacious"
    "aweless"
    "benevolent"
    "bighearted"
    "bold"
    "brassy"
    "caring"
    "celebrated"
    "charismatic"
    "cheeky"
    "chivalrous"
    "clever"
    "cocky"
    "commanding"
    "compassionate"
    "confident"
    "considerate"
    "courageous"
    "daring"
    "dashing"
    "dauntless"
    "dedicated"
    "defiant"
    "determined"
    "dignified"
    "disciplined"
    "distinguished"
    "dominating"
    "doughty"
    "eminent"
    "enterprising"
    "exalted"
    "excellent"
    "extraordinary"
    "faithful"
    "fearless"
    "firm"
    "foolhardy"
    "forward"
    "free"
    "gallant"
    "game"
    "generous"
    "gracious"
    "greathearted"
    "gritty"
    "gutsy"
    "hardy"
    "herculean"
    "hidden"
    "honorable"
    "humble"
    "idealist"
    "imposing"
    "imprudent"
    "indomitable"
    "ingenious"
    "inspiring"
    "intelligent"
    "intrepid"
    "kind"
    "knowledgeable"
    "leader"
    "liberal"
    "lionhearted"
    "lofty"
    "loyal"
    "magnanimous"
    "militant"
    "moral"
    "nervy"
    "noble"
    "outstanding"
    "persevering"
    "plucky"
    "powerful"
    "princely"
    "prodigious"
    "prominent"
    "protectors"
    "proud"
    "reckless"
    "relentless"
    "renowned"
    "resolute"
    "responsible"
    "selfless"
    "sincere"
    "spirited"
    "spunky"
    "stalwart"
    "stately"
    "storied"
    "stout"
    "stouthearted"
    "strong"
    "talented"
    "tenacious"
    "tough"
    "trustworthy"
    "unabashed"
    "unafraid"
    "undaunted"
    "undismayed"
    "unfearful"
    "unflinching"
    "unselfish"
    "unshakable"
    "valiant"
    "valorous"
    "venturesome"
    "virtuous"
    "wise"
    "witty"
    "worthy"
)

heroes=(
    "lukasz"
    "nathan"
    "jamie"
    "jose"
    "michael"
    "kevin"
    "warren"
    "dominic"
    "martin"
    "neil"
    "irshad"
    "jacques"
    "david"
    "mark"
    "alex"
    "jon"
    "james"
    "rennis"
)

generate_docker_name() {
    retry=$1
    left=${adjectives[$(( RANDOM % ${#adjectives[@]} ))]}
    right=${heroes[$(( RANDOM % ${#heroes[@]} ))]}
    docker_name="${left}_${right}"
    if [  $($docker_bin ps | grep $docker_name | wc -l) -ge 1 ] && [ "$retry" -le "$max_retries" ]
    then
        let retry++
        generate_docker_name $retry
    fi
}

if [[ $params != *"--name "* ]];
then
    generate_docker_name 0
    [[ $retry -gt $max_retries ]] || params="${params/run/run --name $docker_name}"
    $docker_bin $params
fi