CreateThread(function()
    while true do
        Wait(100)

        local ped = PlayerPedId()
        if IsPedInAnyPlane(ped) then
            local plane = GetVehiclePedIsIn(ped, false)
            if GetPedInVehicleSeat(plane, -1) == ped then
                if not GetIsVehicleEngineRunning(plane) then
                    SetVehicleEngineOn(plane, true, true, false)
                end
            end
        end
    end
end)


CreateThread(function()
    while true do
        Wait(0)

        local ped = PlayerPedId()
        if IsPedInAnyPlane(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            SetPlaneTurbulenceMultiplier(vehicle, 0.0)          -- disables turbulence
            SetVehicleReduceGrip(vehicle, false)                -- ensures grip isn't reduced
            SetVehicleGravityAmount(vehicle, 9.81)              -- normal Earth gravity
            SetWind(0.0)                                        -- disables global wind
            SetWindSpeed(0.0)                                   -- disables wind speed
            SetWindDirection(0.0)                               -- resets wind direction
        end
    end
end)
