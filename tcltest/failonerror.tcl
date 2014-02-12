package require tcltest
package require -exact TclCurl 7.35.0

tcltest::test failonerror-1 {failonerror OK}  -setup {
    set tkn [curl::init]
} -body {
    unset -nocomplain errorMsg
    $tkn configure -url http://localhost:9080/noneexisting -failonerror 1 -bodyvar body
    $tkn perform
} -cleanup {
    unset -nocomplain ::body
    $tkn cleanup
} -returnCodes {error} -result {22}

tcltest::test failonerror-1 {dont failonerror OK}  -setup {
    set tkn [curl::init]
} -body {
    unset -nocomplain errorMsg
    $tkn configure -url http://localhost:9080/noneexisting -failonerror 0 -bodyvar body
    $tkn perform
} -cleanup {
    unset -nocomplain ::body
    $tkn cleanup
} -returnCodes {ok} -result {0}

# cleanup
::tcltest::cleanupTests
return
