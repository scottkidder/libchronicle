
.shmipc.init2:`:native/obj/shmipc 2:(`shmipc_init;2)
.shmipc.close:`:native/obj/shmipc 2:(`shmipc_close;1)
.shmipc.peek:`:native/obj/shmipc 2:(`shmipc_peek;1)
.shmipc.tailer:`:native/obj/shmipc 2:(`shmipc_tailer;3)
.shmipc.append:`:native/obj/shmipc 2:(`shmipc_append;2)
.shmipc.debug:`:native/obj/shmipc 2:(`shmipc_debug;1)

.timer.hpet_open:`:native/obj/hpet 2:(`hpet_open;2)

.shmipc.init:{[dir;fmt]
  // check if the queue directory exists, create if missing and

  system " " sv ("mkdir";"-p";1_string dir);

  dl:`$(string dir),"/directory-listing.cq4t";
  @[{(enlist 4;enlist"i")1:(x;0;4)};dl;{[dl;e]
    -1 " " sv ("shmipc: creating";string dl);
    // dlist:read1[(`$":native/test/shm001/directory-listing.cq4t";0;512)]
    dlist:0x6c000040b906686561646572b607535453746f72658256000000c87769726554797065b6085769726554797065ec42494e4152595f4c49474854c87265636f76657279b61254696d656453746f72655265636f766572798214000000c974696d655374616d708fa7000000000000000024000000b9146c697374696e672e686967686573744379636c658e00000000a7104500000000000024000000b9136c697374696e672e6c6f776573744379636c658e0100000000a7094500000000000024000000b9156c697374696e672e6578636c75736976654c6f636b8f8f8f8fa700000000000000001c000000b9106c697374696e672e6d6f64436f756e748fa711;
    outf:dlist,(65536-count dlist)#0x00;
    dl 1: outf;
  }[dl;]];

  qf:`$(string dir),"/20180529.cq4";
  @[{(enlist 4;enlist"i")1:(x;0;4)};qf;{[qf;e]
    -1 " " sv ("shmipc: creating queue ";string qf);
    // qfh:read1[(`$":native/test/shm002/20180605.cq4";0;496)]
    qfh:0xb6010040b906686561646572b60853435153746f7265829f010000c87769726554797065b6085769726554797065ec42494e4152595f4c494748548e00000000cd7772697465506f736974696f6e8f8d0200000000000000020000000000000000020200000000000000000000020200c4726f6c6cb60853435153526f6c6c8223000000c66c656e677468a6005c2605c6666f726d6174e8797979794d4d6464c565706f636800c8696e646578696e67b60c53435153496e646578696e67824d000000ca696e646578436f756e74a50020cc696e64657853706163696e6740cb696e64657832496e6465788f8f8f8fa7ba01000000000000c96c617374496e6465788e00000000a74000000000000000df6c61737441636b6e6f776c6564676564496e6465785265706c6963617465648e020000000000a7ffffffffffffffffc87265636f76657279b61254696d656453746f72655265636f766572798216000000c974696d655374616d708f8f8fa70000000000000000d764656c7461436865636b706f696e74496e74657276616c00d36c617374496e6465785265706c6963617465648f8fa7ffffffffffffffffc8736f7572636549640022000140b90b696e64657832696e6465788f8f8f8f8d00200000000000000100000000000000e00101;
    //qfi:read1[(`$":native/test/shm002/20180605.cq4";66016;48)]
    qfi:0x1c000140b905696e6465788f8f8f8f8d0020000000000000010000000000000000020200000000000000000000000000;
    // data all zeros starts from 0x00020200
    qfsz:83754496; / 0x5000000-0x00020200, 80mb
    data:0x0500000068656c6c6f; / "hello"
    outf:qfh,((66016-count qfh)#0x00),qfi,((65568-count qfi)#0x00),data,((qfsz-count data)#0x00);
    qf 1: outf;
  }[qf;]];

  .shmipc.init2[dir;fmt];
 }
