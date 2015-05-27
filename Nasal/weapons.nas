##########################################################
# General initiatizers
#  
var ammo_weight=1.4/20; # 20 rounds of .303 180gr ammo weighs 1.4 pounds 
                    # per http://www.ammo-sale.com/proddetail.asp?prod=1699# 

var r_gun_ammo_count="ai/submodels/submodel[0]/count";  
var l_gun_ammo_count="ai/submodels/submodel[3]/count";
var r_gun_tracer_count="ai/submodels/submodel[1]/count"; 
var l_gun_tracer_count="ai/submodels/submodel[4]/count";
var r_gun_smoke_count="ai/submodels/submodel[2]/count";
var l_gun_smoke_count="ai/submodels/submodel[5]/count";

var r_ammo_weight="yasim/weights/ammo-r-lb";
var l_ammo_weight="yasim/weights/ammo-l-lb";



##############################################################
#update ammo weight update every 5 seconds
#
# todo: make this work for other FDM other than YASIM
# 
var update_ammo_weight = func {

                         
    setprop (r_ammo_weight, ammo_weight * getprop(r_gun_ammo_count));
    setprop (l_ammo_weight, ammo_weight * getprop(l_gun_ammo_count));

    #updating once every 5 seconds should be sufficient--
    #this is fairly lightweight ammo 
    #and you can only shoot about 4 pounds from each gun in 5 seconds.           
    settimer (update_ammo_weight, 5);
}


##############################################################
#init update ammo weight
#
# todo: make this work for other FDM other than YASIM


#start the timer to update the ammo weights
settimer (update_ammo_weight, 5);
    
##############################################################

reload_guns  = func {

    
    setprop ( r_gun_ammo_count, 125); #ammo r
    setprop ( r_gun_ammo_count, 125); #ammo l
    setprop ( r_gun_tracer_count, 125); #tracer r
    setprop ( r_gun_tracer_count, 125); #tracer l
    setprop ( r_gun_smoke_count, 125); #smoke r
    setprop ( r_gun_smoke_count, 125); #smoke l
    
    gui.popupTip ("Howitzer Reloaded and ready to fire", 5)
    
#  } else {
#   
#    gui.popupTip ("Nasal isn't working",5)
#  
#  }

}  

##############################################################
#GAU-12 machine gun fire command by Skyop(later added to by Jack Mermod)

fire_gau12 = func
 {
 if (getprop("master/armed") and getprop("sim/model/A-10/weapons/gun-rate-switch") and getprop("power/on"))
  {
  setprop("controls/armament/trigger", 1);
  }
 }
stop_gau12 = func
 {
 setprop("controls/armament/trigger", 0);
 }

##############################################################
#40mm cannon fire command by Skyop(later added to by Jack Mermod)

fire_40mm = func
 {
 if (getprop("master/armed") and getprop("sim/model/A-10/weapons/dual-AIM-9/aim9-knob") and getprop("power/on"))
  {
  setprop("controls/armament/cannon-firing", 1);
  setprop("controls/armament/trigger1", 1);

  var triggerSwitch = func
   {
   if (getprop("controls/armament/cannon-firing"))
    {
    if (getprop("controls/armament/trigger1"))
     {
     setprop("controls/armament/trigger1", 0);
     }
    else
     {
     setprop("controls/armament/trigger1", 1);
     }

    settimer(triggerSwitch, 0.125);
    }
   else
    {
    setprop("controls/armament/trigger1", 0);
    }
   }
  settimer(triggerSwitch, 0.125);
  }
 }
stop_40mm = func
 {
 setprop("controls/armament/cannon-firing", 0);
 }

