#Run this to get call holidais + ID
Get-CsOnlineSchedule

$HolidayID = Get-CsOnlineSchedule -Id "" 

$HolidayID.FixedSchedule.DateTimeRanges += New-CsOnlineDateTimeRange -Start "05/06/2022" -End "06/06/2022"

Set-CsOnlineSchedule -Instance $HolidayID -Verbose
