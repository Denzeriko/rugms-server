function AutoBindOnSpawn(ply)
	 ply.AllowWeaponPickupFix = 1
     ply:ConCommand( "bind m dropweapon" )
end

hook.Add("PlayerInitialSpawn","AutobindDropWeapon",AutoBindOnSpawn)

function RePickupFix(ply,weapon)
         if ply.AllowWeaponPickupFix == 0 then return false end
end

hook.Add("PlayerCanPickupWeapon","FixForPickup",RePickupFix)


