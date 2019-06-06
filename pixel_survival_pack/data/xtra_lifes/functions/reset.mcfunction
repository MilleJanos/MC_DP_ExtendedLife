# Resets the function

scoreboard objectives remove lifes
scoreboard objectives remove hp
scoreboard objectives remove as_helper 
scoreboard objectives remove xDeaths 

scoreboard objectives add lifes dummy "Lifes"
scoreboard objectives add hp health "HP"
scoreboard objectives add as_helper dummy "as_helper"
scoreboard objectives add xDeaths deathCount "xDeaths"

scoreboard players add count lifes 0
# checks if the armor stand is alive  (bool):
scoreboard players add AsIsAlive as_helper 0 			
# checks if the armor stand lived 1 tick long:
scoreboard players add AsTickLived as_helper 0 
# delay after life count modifications
# iterates 0 to 1001:
scoreboard players add TurnOffTimer as_helper 0 
# TurnOffTimerInv = 1000 - TurnOffTimer:
scoreboard players add TurnOffTimerInv as_helper 0 
# keepInventory controller:
scoreboard players add KeepInventory as_helper 0 
# show/hide timer and run timer if is 1 (bool):
scoreboard players add RunTimer as_helper 0 
# constants:
scoreboard players add _100 as_helper 1000

# Display Scoraboards:
scoreboard objectives setdisplay belowName hp
scoreboard objectives setdisplay sidebar lifes

# DEBUG
# scoreboard objectives setdisplay sidebar as_helper