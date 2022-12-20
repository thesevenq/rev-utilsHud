RegisterKeyMapping('+svacetiri', ' Blinkeri', 'keyboard', 'BACK')
RegisterKeyMapping('+lijeviblinker', ' Lijevi blinker', 'keyboard', 'LEFT')
RegisterKeyMapping('+desniblinker', ' Desni nlinker', 'keyboard', 'RIGHT')


Blinkeri = {
	lijevi = false,
	desni = false
}
RegisterCommand('+svacetiri', function()
	auto = GetVehiclePedIsIn(GetPlayerPed(-1),false)
	if Blinkeri.lijevi ~= Blinkeri.desni then
		Blinkeri.lijevi = false
		Blinkeri.desni = false
	end
	SetVehicleIndicatorLights(auto,0,not Blinkeri.desni)
	SetVehicleIndicatorLights(auto,1,not Blinkeri.lijevi)
	Blinkeri.lijevi = not Blinkeri.lijevi
	Blinkeri.desni = not Blinkeri.desni
end)

RegisterCommand('+lijeviblinker', function()
	auto = GetVehiclePedIsIn(GetPlayerPed(-1),false)
	SetVehicleIndicatorLights(auto,0,false)
	SetVehicleIndicatorLights(auto,1,not Blinkeri.lijevi)
	Blinkeri.lijevi = not Blinkeri.lijevi
	Blinkeri.desni = false
end)

RegisterCommand('+desniblinker', function()
	auto = GetVehiclePedIsIn(GetPlayerPed(-1),false)
	SetVehicleIndicatorLights(auto,1,false)
	SetVehicleIndicatorLights(auto,0,not Blinkeri.desni)
	Blinkeri.desni = not Blinkeri.desni
	Blinkeri.lijevi = false
end)



Citizen.CreateThread(function()
	while true do
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			Wait(100)
			entity = PlayerPedId()

			auto = GetVehiclePedIsIn(GetPlayerPed(-1),false)
			brzina = GetEntitySpeed(entity)*3.6
			gorivo = GetVehicleFuelLevel(auto)
			motor = GetVehicleBodyHealth(auto)/10

			obrtaji = GetVehicleCurrentRpm(auto)*100
			if motor == 0 then
				SetVehicleEngineOn(auto, false, true, true)
			end
			svijetla, kratka, duga = GetVehicleLightsState(auto)
			mjenjac = GetVehicleCurrentGear(auto)
			svijetla = 0
			if kratka == 1 then
				svijetla = 1
			end
			if duga == 1 then
				svijetla = 2
			end
			blinkeri = GetVehicleIndicatorLights(auto)
			SendNUIMessage({
				auto=true,

				novac = LocalPlayer.state.pare,
				banka = LocalPlayer.state.bankaPare,
				brzina = brzina,
				mjenjac = mjenjac,
				gorivo = gorivo,
				obrtaji = obrtaji,
				svijetla = svijetla,
				motor=motor,
				blinkeri = blinkeri
				--obrtaji = obrtaji,
				--kratka = kratka,
				--duga = duga
			})
		else
			Wait(1000)
			SendNUIMessage({
				auto=false,

				novac = LocalPlayer.state.pare,
				banka = LocalPlayer.state.bankaPare,
				brzina = 0,
				mjenjac = 0,
				gorivo = 0,
				svijetla = 0,
				motor=0,
				obrtaji = obrtaji,
				blinkeri = 0
				--obrtaji = obrtaji,
				--kratka = kratka,
				--duga = duga
			})
		end
	end

end)