From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Crash report from dmesg after suspend/resume
Date: Sun, 15 Jul 2018 19:59:58 -0300
Message-ID: <CAJri6_sUSMrCQKAsEds6S202DUSjxgf1nKXSVd-akM2jU+F_0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1019026949=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1019026949==
Content-Type: multipart/alternative; boundary="000000000000b7d5c6057111ac3c"

--000000000000b7d5c6057111ac3c
Content-Type: text/plain; charset="UTF-8"

Everything still works.


[36725.271678] BUG: unable to handle kernel NULL pointer dereference at
0000000000000000
[36725.271688] PGD 0 P4D 0
[36725.271697] Oops: 0002 [#1] PREEMPT SMP NOPTI
[36725.271704] CPU: 6 PID: 27625 Comm: amdgpu_cs:0 Tainted: G        WC O
     4.18.0-1-custom+ #7
[36725.271708] Hardware name: HP HP ENVY x360 Convertible 15m-bq1xx/83C6,
BIOS F.17 03/29/2018
[36725.271720] RIP: 0010:_raw_spin_lock+0x1a/0x40
[36725.271724] Code: e8 fb d7 97 ff 66 90 5b c3 0f 1f 80 00 00 00 00 0f 1f
44 00 00 53 48 89 fb bf 01 00 00 00 e8 4d 28 95 ff 31 c0 ba 01 00 00 00
<f0> 0f b1 13 85 c0 75 02 5b c3 89 c6 48 8
9 df e8 c2 d7 97 ff 66 90
[36725.271778] RSP: 0018:ffff9bc388d6fb18 EFLAGS: 00010246
[36725.271783] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000001
[36725.271786] RDX: 0000000000000001 RSI: ffff918b55c492d8 RDI:
0000000000000001
[36725.271790] RBP: ffff918b55c492f0 R08: 0000000000000000 R09:
ffff9189dfa75700
[36725.271794] R10: ffff918c717b2800 R11: 0000000000000000 R12:
0000000000000000
[36725.271797] R13: ffff918c717b67d8 R14: 00000000000005a0 R15:
0000000000000000
[36725.271803] FS:  00007fffcfb7b700(0000) GS:ffff918c8ab80000(0000)
knlGS:0000000000000000
[36725.271807] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[36725.271811] CR2: 0000000000000000 CR3: 0000000352ff2000 CR4:
00000000003406e0
[36725.271815] Call Trace:
[36725.271831]  drm_sched_entity_push_job+0x122/0x150 [gpu_sched]
[36725.271918]  amdgpu_cs_ioctl+0x1469/0x1af0 [amdgpu]
[36725.272004]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
[36725.272025]  drm_ioctl_kernel+0xa7/0xf0 [drm]
[36725.272044]  drm_ioctl+0x30e/0x3c0 [drm]
[36725.272111]  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
[36725.272166]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[36725.272174]  do_vfs_ioctl+0xa4/0x620
[36725.272181]  ksys_ioctl+0x60/0x90
[36725.272186]  __x64_sys_ioctl+0x16/0x20
[36725.272192]  do_syscall_64+0x5b/0x170
[36725.272198]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[36725.272203] RIP: 0033:0x7ffff36e2667
[36725.272205] Code: 00 00 90 48 8b 05 e9 67 2c 00 64 c7 00 26 00 00 00 48
c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b9 6
7 2c 00 f7 d8 64 89 01 48
[36725.272253] RSP: 002b:00007fffcfb7abd8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[36725.272258] RAX: ffffffffffffffda RBX: 00007fffcfb7acc8 RCX:
00007ffff36e2667
[36725.272262] RDX: 00007fffcfb7ac40 RSI: 00000000c0186444 RDI:
000000000000000b
[36725.272266] RBP: 00007fffcfb7ac40 R08: 00007fffcfb7acf0 R09:
0000000000000010
[36725.272269] R10: 00007fffcfb7acf0 R11: 0000000000000246 R12:
00000000c0186444
[36725.272272] R13: 000000000000000b R14: 0000000000000002 R15:
0000000000000000
[36725.272278] Modules linked in: ccm rfcomm fuse ipt_MASQUERADE
nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 xt_addrtype ipta
ble_filter xt_conntrack nf_nat nf_conntrack br_netfilter bridge stp llc
bnep ext4 mbcache jbd2 fscrypto joydev mousedev amdkfd amd_iommu_v2 amdgpu
arc4 r8822be(C) uvcvideo btusb btrtl btbcm
btintel videobuf2_vmalloc videobuf2_memops hid_sensor_accel_3d
hid_sensor_magn_3d videobuf2_v4l2 chash hid_sensor_rotation
hid_sensor_incl_3d hid_sensor_gyro_3d bluetooth videobuf2_common
gpu_sched hid_sensor_trigger industrialio_triggered_buffer videodev
i2c_algo_bit kfifo_buf hid_sensor_iio_common ecdh_generic industrialio
media crc16 ttm mac80211 drm_kms_helper hp_wmi eda
c_mce_amd snd_hda_codec_realtek sparse_keymap snd_hda_codec_generic
[36725.272352]  drm wmi_bmof snd_hda_codec_hdmi kvm_amd snd_hda_intel ccp
snd_hda_codec rng_core cfg80211 snd_hda_core snd_hwdep kvm snd_pcm
snd_timer psmouse agpgart snd syscopyarea sysfil
lrect irqbypass rtsx_pci_ms sysimgblt input_leds fb_sys_fops rfkill
memstick soundcore sp5100_tco k10temp hp_accel lis3lv02d i2c_piix4 battery
ac rtc_cmos wmi input_polldev led_class i2c_hi
d evdev acpi_cpufreq pinctrl_amd mac_hid i2c_scmi hp_wireless vboxnetflt(O)
vboxnetadp(O) vboxpci(O) vboxdrv(O) msr sg crypto_user ip_tables x_tables
dm_crypt dm_mod btrfs libcrc32c crc32c_
generic xor zstd_decompress zstd_compress xxhash hid_sensor_hub hid_generic
usbhid hid raid6_pq sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel pcbc rtsx_pci_sdmmc ser
io_raw atkbd libps2 mmc_core ahci libahci aesni_intel
[36725.272440]  xhci_pci aes_x86_64 libata crypto_simd xhci_hcd cryptd
glue_helper usbcore scsi_mod usb_common rtsx_pci i8042 serio lz4
lz4_compress
[36725.272460] CR2: 0000000000000000
[36725.272465] ---[ end trace 9134c6e0a3766f31 ]---
[36725.272473] RIP: 0010:_raw_spin_lock+0x1a/0x40
[36725.272476] Code: e8 fb d7 97 ff 66 90 5b c3 0f 1f 80 00 00 00 00 0f 1f
44 00 00 53 48 89 fb bf 01 00 00 00 e8 4d 28 95 ff 31 c0 ba 01 00 00 00
<f0> 0f b1 13 85 c0 75 02 5b c3 89 c6 48 8
9 df e8 c2 d7 97 ff 66 90
[36725.272535] RSP: 0018:ffff9bc388d6fb18 EFLAGS: 00010246
[36725.272539] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
0000000000000001
[36725.272541] RDX: 0000000000000001 RSI: ffff918b55c492d8 RDI:
0000000000000001
[36725.272544] RBP: ffff918b55c492f0 R08: 0000000000000000 R09:
ffff9189dfa75700
[36725.272547] R10: ffff918c717b2800 R11: 0000000000000000 R12:
0000000000000000
[36725.272549] R13: ffff918c717b67d8 R14: 00000000000005a0 R15:
0000000000000000
[36725.272553] FS:  00007fffcfb7b700(0000) GS:ffff918c8ab80000(0000)
knlGS:0000000000000000
[36725.272556] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[36725.272559] CR2: 0000000000000000 CR3: 0000000352ff2000 CR4:
00000000003406e0
[36725.272584] note: amdgpu_cs:0[27625] exited with preempt_count 2

--000000000000b7d5c6057111ac3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Everything still works.<div><br></div><div><br></div><div>=
<span style=3D"font-family:monospace"><span style=3D"color:rgb(24,178,24)">=
[36725.271678] </span><span style=3D"color:rgb(178,104,24)">BUG</span><span=
 style=3D"color:rgb(255,255,255);background-color:rgb(178,24,24)">: unable =
to handle kernel NULL pointer dereference at 0000000000000000</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.271688] </span>PGD 0 P4D 0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br><span style=3D"color:rg=
b(24,178,24)">[36725.271697] </span><span style=3D"color:rgb(178,104,24)">O=
ops</span><span style=3D"font-weight:bold">: 0002 [#1] PREEMPT SMP NOPTI</s=
pan>=C2=A0<br><span style=3D"color:rgb(24,178,24)">[36725.271704] </span><s=
pan style=3D"color:rgb(178,104,24)">CPU</span><span style=3D"font-weight:bo=
ld">: 6 PID: 27625 Comm: amdgpu_cs:0 Tainted: G =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0WC O =C2=A0=C2=A0=C2=A0=C2=A0=C2=A04.18.0-1-custom+ #7</span=
>=C2=A0<br><span style=3D"color:rgb(24,178,24)">[36725.271708] </span><span=
 style=3D"color:rgb(178,104,24)">Hardware name</span><span style=3D"font-we=
ight:bold">: HP HP ENVY x360 Convertible 15m-bq1xx/83C6, BIOS F.17 03/29/20=
18</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.271720] </span><span style=
=3D"color:rgb(178,104,24)">RIP</span><span style=3D"font-weight:bold">: 001=
0:_raw_spin_lock+0x1a/0x40</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br><span=
 style=3D"color:rgb(24,178,24)">[36725.271724] </span><span style=3D"color:=
rgb(178,104,24)">Code</span><span style=3D"font-weight:bold">: e8 fb d7 97 =
ff 66 90 5b c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 53 48 89 fb bf 01 00 00 =
00 e8 4d 28 95 ff 31 c0 ba 01 00 00 00 &lt;f0&gt; 0f b1 13 85 c0 75 02 5b c=
3 89 c6 48 8</span>
<br><span style=3D"font-weight:bold">9 df e8 c2 d7 97 ff 66 90 </span>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<b=
r><span style=3D"color:rgb(24,178,24)">[36725.271778] </span><span style=3D=
"color:rgb(178,104,24)">RSP</span><span style=3D"font-weight:bold">: 0018:f=
fff9bc388d6fb18 EFLAGS: 00010246</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<br><span style=3D"color:rgb(24,178,24)">[36725.=
271783] </span><span style=3D"color:rgb(178,104,24)">RAX</span><span style=
=3D"font-weight:bold">: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000001</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br><span style=3D"color:r=
gb(24,178,24)">[36725.271786] </span><span style=3D"color:rgb(178,104,24)">=
RDX</span><span style=3D"font-weight:bold">: 0000000000000001 RSI: ffff918b=
55c492d8 RDI: 0000000000000001</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0<br><span style=3D"color:rgb(24,178,24)">[36725.271790] </span><span sty=
le=3D"color:rgb(178,104,24)">RBP</span><span style=3D"font-weight:bold">: f=
fff918b55c492f0 R08: 0000000000000000 R09: ffff9189dfa75700</span>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br><span style=3D"co=
lor:rgb(24,178,24)">[36725.271794] </span><span style=3D"color:rgb(178,104,=
24)">R10</span><span style=3D"font-weight:bold">: ffff918c717b2800 R11: 000=
0000000000000 R12: 0000000000000000</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br><span style=3D"colo=
r:rgb(24,178,24)">[36725.271797] </span><span style=3D"color:rgb(178,104,24=
)">R13</span><span style=3D"font-weight:bold">: ffff918c717b67d8 R14: 00000=
000000005a0 R15: 0000000000000000</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<b=
r><span style=3D"color:rgb(24,178,24)">[36725.271803] </span><span style=3D=
"color:rgb(178,104,24)">FS</span><span style=3D"font-weight:bold">: =C2=A00=
0007fffcfb7b700(0000) GS:ffff918c8ab80000(0000) knlGS:0000000000000000</spa=
n>=C2=A0=C2=A0<br><span style=3D"color:rgb(24,178,24)">[36725.271807] </spa=
n><span style=3D"color:rgb(178,104,24)">CS</span><span style=3D"font-weight=
:bold">: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033</span> =C2=A0=
=C2=A0=C2=A0<br><span style=3D"color:rgb(24,178,24)">[36725.271811] </span>=
<span style=3D"color:rgb(178,104,24)">CR2</span><span style=3D"font-weight:=
bold">: 0000000000000000 CR3: 0000000352ff2000 CR4: 00000000003406e0</span>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br><span style=3D"color:rgb(24,178,24)">[=
36725.271815] </span><span style=3D"font-weight:bold">Call Trace:</span>=C2=
=A0<br><span style=3D"color:rgb(24,178,24)">[36725.271831] </span><span sty=
le=3D"font-weight:bold">=C2=A0drm_sched_entity_push_job+0x122/0x150 [gpu_sc=
hed]</span>=C2=A0 =C2=A0 =C2=A0=C2=A0<br><span style=3D"color:rgb(24,178,24=
)">[36725.271918] </span><span style=3D"font-weight:bold">=C2=A0amdgpu_cs_i=
octl+0x1469/0x1af0 [amdgpu]</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br><spa=
n style=3D"color:rgb(24,178,24)">[36725.272004] </span><span style=3D"font-=
weight:bold">=C2=A0? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272025] </span><span style=
=3D"font-weight:bold">=C2=A0drm_ioctl_kernel+0xa7/0xf0 [drm]</span>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br><span style=3D"color:rgb(24,178,24)">[36725.272044]=
 </span><span style=3D"font-weight:bold">=C2=A0drm_ioctl+0x30e/0x3c0 [drm]<=
/span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272111] </span><span style=
=3D"font-weight:bold">=C2=A0? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]</=
span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272166] </span><span style=
=3D"font-weight:bold">=C2=A0amdgpu_drm_ioctl+0x49/0x80 [amdgpu]</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272174] </span><span style=
=3D"font-weight:bold">=C2=A0do_vfs_ioctl+0xa4/0x620</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272181] </span><span style=
=3D"font-weight:bold">=C2=A0ksys_ioctl+0x60/0x90</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272186] </span><span style=
=3D"font-weight:bold">=C2=A0__x64_sys_ioctl+0x16/0x20</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272192] </span><span style=
=3D"font-weight:bold">=C2=A0do_syscall_64+0x5b/0x170</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272198] </span><span style=
=3D"font-weight:bold">=C2=A0entry_SYSCALL_64_after_hwframe+0x44/0xa9</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272203] </span><span style=
=3D"color:rgb(178,104,24)">RIP</span><span style=3D"font-weight:bold">: 003=
3:0x7ffff36e2667</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272205] </span><span style=
=3D"color:rgb(178,104,24)">Code</span><span style=3D"font-weight:bold">: 00=
 00 90 48 8b 05 e9 67 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66=
 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff =
73 01 c3 48 8b 0d b9 6</span>
<br><span style=3D"font-weight:bold">7 2c 00 f7 d8 64 89 01 48 </span>=C2=
=A0<br><span style=3D"color:rgb(24,178,24)">[36725.272253] </span><span sty=
le=3D"color:rgb(178,104,24)">RSP</span><span style=3D"font-weight:bold">: 0=
02b:00007fffcfb7abd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272258] </span><span style=
=3D"color:rgb(178,104,24)">RAX</span><span style=3D"font-weight:bold">: fff=
fffffffffffda RBX: 00007fffcfb7acc8 RCX: 00007ffff36e2667</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272262] </span><span style=
=3D"color:rgb(178,104,24)">RDX</span><span style=3D"font-weight:bold">: 000=
07fffcfb7ac40 RSI: 00000000c0186444 RDI: 000000000000000b</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272266] </span><span style=
=3D"color:rgb(178,104,24)">RBP</span><span style=3D"font-weight:bold">: 000=
07fffcfb7ac40 R08: 00007fffcfb7acf0 R09: 0000000000000010</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272269] </span><span style=
=3D"color:rgb(178,104,24)">R10</span><span style=3D"font-weight:bold">: 000=
07fffcfb7acf0 R11: 0000000000000246 R12: 00000000c0186444</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272272] </span><span style=
=3D"color:rgb(178,104,24)">R13</span><span style=3D"font-weight:bold">: 000=
000000000000b R14: 0000000000000002 R15: 0000000000000000</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272278] </span><span style=
=3D"color:rgb(178,104,24)">Modules linked in</span><span style=3D"font-weig=
ht:bold">: ccm rfcomm fuse ipt_MASQUERADE nf_conntrack_netlink nfnetlink xf=
rm_user xfrm_algo iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 =
xt_addrtype ipta</span>
<br><span style=3D"font-weight:bold">ble_filter xt_conntrack nf_nat nf_conn=
track br_netfilter bridge stp llc bnep ext4 mbcache jbd2 fscrypto joydev mo=
usedev amdkfd amd_iommu_v2 amdgpu arc4 r8822be(C) uvcvideo btusb btrtl btbc=
m</span>
<br><span style=3D"font-weight:bold"> btintel videobuf2_vmalloc videobuf2_m=
emops hid_sensor_accel_3d hid_sensor_magn_3d videobuf2_v4l2 chash hid_senso=
r_rotation hid_sensor_incl_3d hid_sensor_gyro_3d bluetooth videobuf2_common=
 </span>=C2=A0<br><span style=3D"font-weight:bold">gpu_sched hid_sensor_tri=
gger industrialio_triggered_buffer videodev i2c_algo_bit kfifo_buf hid_sens=
or_iio_common ecdh_generic industrialio media crc16 ttm mac80211 drm_kms_he=
lper hp_wmi eda</span>
<br><span style=3D"font-weight:bold">c_mce_amd snd_hda_codec_realtek sparse=
_keymap snd_hda_codec_generic</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272352] </span><span style=
=3D"font-weight:bold">=C2=A0drm wmi_bmof snd_hda_codec_hdmi kvm_amd snd_hda=
_intel ccp snd_hda_codec rng_core cfg80211 snd_hda_core snd_hwdep kvm snd_p=
cm snd_timer psmouse agpgart snd syscopyarea sysfil</span>
<br><span style=3D"font-weight:bold">lrect irqbypass rtsx_pci_ms sysimgblt =
input_leds fb_sys_fops rfkill memstick soundcore sp5100_tco k10temp hp_acce=
l lis3lv02d i2c_piix4 battery ac rtc_cmos wmi input_polldev led_class i2c_h=
i</span>
<br><span style=3D"font-weight:bold">d evdev acpi_cpufreq pinctrl_amd mac_h=
id i2c_scmi hp_wireless vboxnetflt(O) vboxnetadp(O) vboxpci(O) vboxdrv(O) m=
sr sg crypto_user ip_tables x_tables dm_crypt dm_mod btrfs libcrc32c crc32c=
_</span>
<br><span style=3D"font-weight:bold">generic xor zstd_decompress zstd_compr=
ess xxhash hid_sensor_hub hid_generic usbhid hid raid6_pq sd_mod crct10dif_=
pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel pcbc rtsx_pci_sdmmc se=
r</span>
<br><span style=3D"font-weight:bold">io_raw atkbd libps2 mmc_core ahci liba=
hci aesni_intel</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272440] </span><span style=
=3D"font-weight:bold">=C2=A0xhci_pci aes_x86_64 libata crypto_simd xhci_hcd=
 cryptd glue_helper usbcore scsi_mod usb_common rtsx_pci i8042 serio lz4 lz=
4_compress</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272460] </span><span style=
=3D"color:rgb(178,104,24)">CR2</span><span style=3D"font-weight:bold">: 000=
0000000000000</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272465] </span><span style=
=3D"font-weight:bold">---[ end trace 9134c6e0a3766f31 ]---</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272473] </span><span style=
=3D"color:rgb(178,104,24)">RIP</span><span style=3D"font-weight:bold">: 001=
0:_raw_spin_lock+0x1a/0x40</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272476] </span><span style=
=3D"color:rgb(178,104,24)">Code</span><span style=3D"font-weight:bold">: e8=
 fb d7 97 ff 66 90 5b c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 53 48 89 fb bf=
 01 00 00 00 e8 4d 28 95 ff 31 c0 ba 01 00 00 00 &lt;f0&gt; 0f b1 13 85 c0 =
75 02 5b c3 89 c6 48 8</span>
<br><span style=3D"font-weight:bold">9 df e8 c2 d7 97 ff 66 90 </span><br><=
/span><div><div><span style=3D"font-family:monospace"><span style=3D"color:=
rgb(24,178,24)">[36725.272535] </span><span style=3D"color:rgb(178,104,24)"=
>RSP</span><span style=3D"font-weight:bold">: 0018:ffff9bc388d6fb18 EFLAGS:=
 00010246</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272539] </span><span style=
=3D"color:rgb(178,104,24)">RAX</span><span style=3D"font-weight:bold">: 000=
0000000000000 RBX: 0000000000000000 RCX: 0000000000000001</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272541] </span><span style=
=3D"color:rgb(178,104,24)">RDX</span><span style=3D"font-weight:bold">: 000=
0000000000001 RSI: ffff918b55c492d8 RDI: 0000000000000001</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272544] </span><span style=
=3D"color:rgb(178,104,24)">RBP</span><span style=3D"font-weight:bold">: fff=
f918b55c492f0 R08: 0000000000000000 R09: ffff9189dfa75700</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272547] </span><span style=
=3D"color:rgb(178,104,24)">R10</span><span style=3D"font-weight:bold">: fff=
f918c717b2800 R11: 0000000000000000 R12: 0000000000000000</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272549] </span><span style=
=3D"color:rgb(178,104,24)">R13</span><span style=3D"font-weight:bold">: fff=
f918c717b67d8 R14: 00000000000005a0 R15: 0000000000000000</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272553] </span><span style=
=3D"color:rgb(178,104,24)">FS</span><span style=3D"font-weight:bold">: =C2=
=A000007fffcfb7b700(0000) GS:ffff918c8ab80000(0000) knlGS:0000000000000000<=
/span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272556] </span><span style=
=3D"color:rgb(178,104,24)">CS</span><span style=3D"font-weight:bold">: =C2=
=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272559] </span><span style=
=3D"color:rgb(178,104,24)">CR2</span><span style=3D"font-weight:bold">: 000=
0000000000000 CR3: 0000000352ff2000 CR4: 00000000003406e0</span>
<br><span style=3D"color:rgb(24,178,24)">[36725.272584] </span><span style=
=3D"color:rgb(178,104,24)">note</span>: amdgpu_cs:0[27625] exited with pree=
mpt_count 2<br>
<br></span></div><div><br></div></div></div></div>

--000000000000b7d5c6057111ac3c--

--===============1019026949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1019026949==--
