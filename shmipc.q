/ shared memory IPC based on Chronocle Queue
/ set the KDB Timer resolution to 1ms then register the dispatch callback .shmipc.peek[] in .z.t

/ see also hpet.c/hpet.q for the high performance event timer

.shmipc.init:`:native/obj/shmipc 2:(`shmipc_init;1)
.shmipc.peek:`:native/obj/shmipc 2:(`shmipc_peek;1)
.shmipc.tailer:`:native/obj/shmipc 2:(`shmipc_tailer;3)
.shmipc.appender:`:native/obj/shmipc 2:(`shmipc_appender;2)
.shmipc.debug:`:native/obj/shmipc 2:(`shmipc_debug;1)

.timer.hpet_open:`:native/obj/hpet 2:(`hpet_open;2)

/ opening an appender or tailer first need watchers on the queue directory and the most
/ recent data file to be opened. The initial layout needs to be created by a Java
/ process
.shmipc.init[`:java/queue];
/.shmipc.init[`:java/queue]; / `shmipc dupe init

.shmipc.debug[0];

fd:.timer.hpet_open[{.shmipc.peek[0]}; 0D00:00:00.500000000];

.shmipc.peek[0];
.shmipc.debug[0];

/ add a tailer by using .shmipc.tailer[`:queue;cb;cycle] where cycle may be 0 to replay
/ from the beginning of time, and cb is the callback for each event in the queue. A replay
/ occurs 'inline' and any new records are dispatched by calls to .peek[]
cb:{0N!(x;y)}
.shmipc.tailer[`:java/queue;cb;0];

/ Note the standard Java wire implementations are largely ignored and returned as byte arrays

/ for debug tracing $ export SHMIPC_DEBUG=1 && ./q.sh native/shmipc.q

/ add a souce by .shmipc.appender[`:queue;data]
/ multiple appenders may write to the same queue, but there can be no more than one appender per
/ process. this is because file locks are used to synchronise some operations and these are issued
/ at the 'pid' level.
.shmipc.appender[`:java/queue;"message"];

/ under the covers the characters of symbol are used to lookup the queue directory. The symbol index
/ is then used firstly as a directory lookup