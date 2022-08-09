$processes = Get-Counter '\Process(*)\% Processor Time'
$cpu_cores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
$tenpercent = ($cpu_cores * 100) * 0.10
foreach ($process in $processes.countersamples) {
  # $process.InstanceName
  if ($process.cookedvalue -gt $tenpercent -and $process.InstanceName -notLike 'idle' -and $process.InstanceName -notLike '_total') {
    write-host "Process name: $($process.InstanceName)"
    write-host "CPU usage: $($process.cookedvalue / $cpu_cores)"
  }
}
