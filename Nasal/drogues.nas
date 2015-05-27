###############################################
# Drogues system by Jano. Thanks to him. 2010 #
###############################################

toggle_refuelling_drogues = func {
  if(getprop("controls/refuelling/refuelling-drogues-pos-norm") > 0) {
    interpolate("controls/refuelling/refuelling-drogues-pos-norm", 0, 5);
  } else {
    interpolate("controls/refuelling/refuelling-drogues-pos-norm", 1, 5);
  }
}
