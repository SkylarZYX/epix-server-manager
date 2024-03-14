updatevars () {
        javacommand=`sed -n 's/^javacommand=\(.*\)/\1/p' < server-info`
        servername=`sed -n 's/^servername=\(.*\)/\1/p' < server-info`
        sessionname=`sed -n 's/^sessionname=\(.*\)/\1/p' < server-info`
        worldname=`sed -n 's/^worldname=\(.*\)/\1/p' < server-info`
}
updatevars

$javacommand
