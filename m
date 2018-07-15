From: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error on boot with Raven Ridge
Date: Sun, 15 Jul 2018 20:39:26 -0300
Message-ID: <CAJri6_teQGbQHeQeMsK2H2rjp+nyrtrSffz5i6PCtQVfLTyccA@mail.gmail.com>
References: <CAJri6_u2SxWPyGvib8X4akEvhOAw3Lkz2+5CPXXPmhyJPb5M-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1462131366=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAJri6_u2SxWPyGvib8X4akEvhOAw3Lkz2+5CPXXPmhyJPb5M-Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============1462131366==
Content-Type: multipart/alternative; boundary="000000000000e828d305711239bc"

--000000000000e828d305711239bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Now with the latest kernel from staging-next branch

[   13.244876] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.244877] Bluetooth: BNEP filters: protocol multicast
[   13.244882] Bluetooth: BNEP socket layer initialized
[   14.709064] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   15.282470] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   15.282533] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you need
this.
[   15.722052] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   15.722118] Bridge firewalling registered
[   15.833492] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready
[   16.021385] fuse init (API version 7.27)
[   16.317799] Initializing XFRM netlink socket
[   16.413054] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[   20.588915] Bluetooth: RFCOMM TTY layer initialized
[   20.588925] Bluetooth: RFCOMM socket layer initialized
[   20.588934] Bluetooth: RFCOMM ver 1.11
[   22.388724] core[1379]: segfault at 0 ip 0000000000441058 sp
00007fffffffd2f0 error 4
[   22.388730] Code: 40 00 31 c0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
55 48 89 f5 53 48 89 fb 48 83 ec 08 e8 8f ec fd ff 89 c7 e8 f8 f0 fd ff
<48> 8b 30 48 89 ea 48 89 df e8 fa eb fd ff 48 83 c4 08 b8 01 00 00



On Sun, Jul 15, 2018 at 8:02 PM Br=C3=A1ulio Bhavamitra <brauliobo-Re5JQEeQqe8@public.gmane.org=
m>
wrote:

> Although it is reported on dmesg, the system still boots normally
>
> [    8.253073] amdgpu: [powerplay] dpm has been enabled
> [    8.253210] [drm] DM_PPLIB:   400000 in kHz
> [    8.253211] [drm] DM_PPLIB:   933000 in kHz
> [    8.253212] [drm] DM_PPLIB:   1067000 in kHz
> [    8.253380] WARNING: CPU: 6 PID: 361 at
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1355
> dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]
> [    8.253381] Modules linked in: ext4 mbcache jbd2 fscrypto joydev
> mousedev amdkfd amd_iommu_v2 amdgpu(+) arc4 r8822be(C) uvcvideo btusb btr=
tl
> btbcm btintel videobuf2_vmalloc videobuf2_memops hid_sensor_accel_3d
> hid_sensor_magn_3d videobuf2_v4l2 chash hid_sensor_rotation
> hid_sensor_incl_3d hid_sensor_gyro_3d bluetooth videobuf2_common gpu_sche=
d
> hid_sensor_trigger industrialio_triggered_buffer videodev i2c_algo_bit
> kfifo_buf hid_sensor_iio_common ecdh_generic industrialio media crc16 ttm
> mac80211 drm_kms_helper hp_wmi edac_mce_amd snd_hda_codec_realtek
> sparse_keymap snd_hda_codec_generic drm wmi_bmof snd_hda_codec_hdmi kvm_a=
md
> snd_hda_intel ccp snd_hda_codec rng_core cfg80211 snd_hda_core snd_hwdep
> kvm snd_pcm snd_timer psmouse agpgart snd syscopyarea sysfillrect irqbypa=
ss
> rtsx_pci_ms sysimgblt input_leds
> [    8.253444]  fb_sys_fops rfkill memstick soundcore sp5100_tco k10temp
> hp_accel lis3lv02d i2c_piix4 battery ac rtc_cmos wmi input_polldev
> led_class i2c_hid evdev acpi_cpufreq pinctrl_amd mac_hid i2c_scmi
> hp_wireless vboxnetflt(O) vboxnetadp(O) vboxpci(O) vboxdrv(O) msr sg
> crypto_user ip_tables x_tables dm_crypt dm_mod btrfs libcrc32c
> crc32c_generic xor zstd_decompress zstd_compress xxhash hid_sensor_hub
> hid_generic usbhid hid raid6_pq sd_mod crct10dif_pclmul crc32_pclmul
> crc32c_intel ghash_clmulni_intel pcbc rtsx_pci_sdmmc serio_raw atkbd libp=
s2
> mmc_core ahci libahci aesni_intel xhci_pci aes_x86_64 libata crypto_simd
> xhci_hcd cryptd glue_helper usbcore scsi_mod usb_common rtsx_pci i8042
> serio lz4 lz4_compress
> [    8.253511] CPU: 6 PID: 361 Comm: systemd-udevd Tainted: G         C O
>     4.18.0-1-custom+ #7
> [    8.253512] Hardware name: HP HP ENVY x360 Convertible 15m-bq1xx/83C6,
> BIOS F.17 03/29/2018
> [    8.253630] RIP: 0010:dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]
> [    8.253631] Code: d8 ca d8 f1 d9 5a 50 8b 44 fc 14 49 8b 94 24 70 01 0=
0
> 00 48 89 04 24 df 2c 24 d8 f1 db 42 78 de c9 de ca de f9 d9 5a 4c eb 02
> <0f> 0b 48 89 da be 04 00 00 00 48 89 ef e8 13 5b fe ff 84 c0 0f 84
> [    8.253675] RSP: 0018:ffff9bc383b037b8 EFLAGS: 00010246
> [    8.253678] RAX: 0000000000000001 RBX: ffff9bc383b03818 RCX:
> 0000000000000000
> [    8.253679] RDX: 0000000000000000 RSI: 0000000000000004 RDI:
> 00000000ffffffff
> [    8.253681] RBP: ffff918c85651a40 R08: 0000000000000001 R09:
> 000000000000039f
> [    8.253683] R10: 0000000000000004 R11: 0000000000000000 R12:
> ffff918c733ae000
> [    8.253684] R13: ffff918c73293300 R14: ffff918c733ae000 R15:
> 0000000000000000
> [    8.253687] FS:  00007ffff7f85d40(0000) GS:ffff918c8ab80000(0000)
> knlGS:0000000000000000
> [    8.253688] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    8.253690] CR2: 00007ffff7a28000 CR3: 0000000505f02000 CR4:
> 00000000003406e0
> [    8.253692] Call Trace:
> [    8.253817]  dcn10_create_resource_pool+0x756/0x990 [amdgpu]
> [    8.253933]  dc_create_resource_pool+0x42/0x180 [amdgpu]
> [    8.253940]  ? __kmalloc+0x1aa/0x230
> [    8.254053]  ? dal_gpio_service_create+0x7c/0x110 [amdgpu]
> [    8.254165]  dc_create+0x228/0x650 [amdgpu]
> [    8.254273]  ? amdgpu_cgs_create_device+0x23/0x50 [amdgpu]
> [    8.254385]  dm_hw_init+0xc8/0x130 [amdgpu]
> [    8.254496]  amdgpu_device_init.cold.15+0x1041/0x1253 [amdgpu]
> [    8.254585]  amdgpu_driver_load_kms+0x86/0x2c0 [amdgpu]
> [    8.254607]  drm_dev_register+0x109/0x140 [drm]
> [    8.254693]  amdgpu_pci_probe+0x13c/0x1c0 [amdgpu]
> [    8.254699]  ? _raw_spin_unlock_irqrestore+0x20/0x40
> [    8.254704]  local_pci_probe+0x41/0x90
> [    8.254709]  pci_device_probe+0x189/0x1a0
> [    8.254715]  driver_probe_device+0x2b9/0x460
> [    8.254719]  __driver_attach+0xdd/0x110
> [    8.254722]  ? driver_probe_device+0x460/0x460
> [    8.254725]  bus_for_each_dev+0x76/0xc0
> [    8.254729]  bus_add_driver+0x152/0x230
> [    8.254732]  ? 0xffffffffc1240000
> [    8.254735]  driver_register+0x6b/0xb0
> [    8.254738]  ? 0xffffffffc1240000
> [    8.254742]  do_one_initcall+0x46/0x1f5
> [    8.254746]  ? kmem_cache_alloc_trace+0x181/0x1d0
> [    8.254751]  ? do_init_module+0x22/0x210
> [    8.254755]  do_init_module+0x5a/0x210
> [    8.254759]  load_module+0x2295/0x24b0
> [    8.254766]  ? vmap_page_range_noflush+0x243/0x320
> [    8.254772]  ? __se_sys_init_module+0x10c/0x170
> [    8.254776]  __se_sys_init_module+0x10c/0x170
> [    8.254781]  do_syscall_64+0x5b/0x170
> [    8.254786]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    8.254789] RIP: 0033:0x7ffff78f6f3a
> [    8.254789] Code: 48 8b 0d 19 cf 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 6=
6
> 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00 00 0f 05
> <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e6 ce 2b 00 f7 d8 64 89 01 48
> [    8.254834] RSP: 002b:00007fffffffd648 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [    8.254837] RAX: ffffffffffffffda RBX: 00005555557bc1c0 RCX:
> 00007ffff78f6f3a
> [    8.254839] RDX: 00007ffff7193ecd RSI: 0000000000605250 RDI:
> 00005555561c1cd0
> [    8.254840] RBP: 00007ffff7193ecd R08: 0000000000000007 R09:
> 0000000000000006
> [    8.254842] R10: 00005555557b3010 R11: 0000000000000246 R12:
> 00005555561c1cd0
> [    8.254843] R13: 00005555557c3f20 R14: 0000000000020000 R15:
> 00005555557bc1c0
> [    8.254847] ---[ end trace 9134c6e0a3766f30 ]---
> [    8.254869] [drm] DM_PPLIB: values for Invalid clock
> [    8.254871] [drm] DM_PPLIB:   300000 in kHz
> [    8.254871] [drm] DM_PPLIB:   600000 in kHz
> [    8.254872] [drm] DM_PPLIB:   626000 in kHz
> [    8.254873] [drm] DM_PPLIB:   654000 in kHz
> [    8.255669] [drm:construct [amdgpu]] *ERROR* construct: Invalid
> Connector ObjectID from Adapter Service for connector index:2! type 0
> expected 3
> [    8.262434] [drm] Display Core initialized with v3.1.52!
> [    8.270244] [drm] SADs count is: -2, don't need to read it
> [    8.271703] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
.
> [    8.271704] [drm] Driver supports precise vblank timestamp query.
> [    8.295109] [drm] VCN decode and encode initialized successfully.
> [    8.296988] [drm] fb mappable at 0xD1100000
> [    8.296990] [drm] vram apper at 0xD0000000
> [    8.296991] [drm] size 8294400
> [    8.296992] [drm] fb depth is 24
> [    8.296993] [drm]    pitch is 7680
> [    8.297159] fbcon: amdgpudrmfb (fb0) is primary device
> [    8.314740] Console: switching to colour frame buffer device 240x67
> [    8.336232] amdgpu 0000:03:00.0: fb0: amdgpudrmfb frame buffer device
> [    8.345240] amdgpu 0000:03:00.0: ring 0(gfx) uses VM inv eng 4 on hub =
0
> [    8.345244] amdgpu 0000:03:00.0: ring 1(comp_1.0.0) uses VM inv eng 5
> on hub 0
> [    8.345247] amdgpu 0000:03:00.0: ring 2(comp_1.1.0) uses VM inv eng 6
> on hub 0
> [    8.345250] amdgpu 0000:03:00.0: ring 3(comp_1.2.0) uses VM inv eng 7
> on hub 0
> [    8.345252] amdgpu 0000:03:00.0: ring 4(comp_1.3.0) uses VM inv eng 8
> on hub 0
> [    8.345255] amdgpu 0000:03:00.0: ring 5(comp_1.0.1) uses VM inv eng 9
> on hub 0
> [    8.345258] amdgpu 0000:03:00.0: ring 6(comp_1.1.1) uses VM inv eng 10
> on hub 0
> [    8.345260] amdgpu 0000:03:00.0: ring 7(comp_1.2.1) uses VM inv eng 11
> on hub 0
> [    8.345263] amdgpu 0000:03:00.0: ring 8(comp_1.3.1) uses VM inv eng 12
> on hub 0
> [    8.345266] amdgpu 0000:03:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13
> on hub 0
> [    8.345269] amdgpu 0000:03:00.0: ring 10(sdma0) uses VM inv eng 4 on
> hub 1
> [    8.345272] amdgpu 0000:03:00.0: ring 11(vcn_dec) uses VM inv eng 5 on
> hub 1
> [    8.345275] amdgpu 0000:03:00.0: ring 12(vcn_enc0) uses VM inv eng 6 o=
n
> hub 1
> [    8.345278] amdgpu 0000:03:00.0: ring 13(vcn_enc1) uses VM inv eng 7 o=
n
> hub 1
> [    8.345280] amdgpu 0000:03:00.0: ring 14(vcn_jpeg) uses VM inv eng 8 o=
n
> hub 1
> [    8.858530] [drm] Initialized amdgpu 3.26.0 20150101 for 0000:03:00.0
> on minor 0
>
>

--000000000000e828d305711239bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Now with the latest kernel from staging-next branch<div><b=
r></div><div>[=C2=A0 =C2=A013.244876] Bluetooth: BNEP (Ethernet Emulation) =
ver 1.3</div><div>[=C2=A0 =C2=A013.244877] Bluetooth: BNEP filters: protoco=
l multicast</div><div>[=C2=A0 =C2=A013.244882] Bluetooth: BNEP socket layer=
 initialized</div><div>[=C2=A0 =C2=A014.709064] IPv6: ADDRCONF(NETDEV_UP): =
wlp2s0: link is not ready</div><div>[=C2=A0 =C2=A015.282470] IPv6: ADDRCONF=
(NETDEV_UP): wlp2s0: link is not ready</div><div>[=C2=A0 =C2=A015.282533] b=
ridge: filtering via arp/ip/ip6tables is no longer available by default. Up=
date your scripts to load br_netfilter if you need this.</div><div>[=C2=A0 =
=C2=A015.722052] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready</div>=
<div>[=C2=A0 =C2=A015.722118] Bridge firewalling registered</div><div>[=C2=
=A0 =C2=A015.833492] IPv6: ADDRCONF(NETDEV_UP): wlp2s0: link is not ready</=
div><div>[=C2=A0 =C2=A016.021385] fuse init (API version 7.27)</div><div>[=
=C2=A0 =C2=A016.317799] Initializing XFRM netlink socket</div><div>[=C2=A0 =
=C2=A016.413054] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready</div=
><div>[=C2=A0 =C2=A020.588915] Bluetooth: RFCOMM TTY layer initialized</div=
><div>[=C2=A0 =C2=A020.588925] Bluetooth: RFCOMM socket layer initialized</=
div><div>[=C2=A0 =C2=A020.588934] Bluetooth: RFCOMM ver 1.11</div><div>[=C2=
=A0 =C2=A022.388724] core[1379]: segfault at 0 ip 0000000000441058 sp 00007=
fffffffd2f0 error 4</div><div>[=C2=A0 =C2=A022.388730] Code: 40 00 31 c0 c3=
 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 55 48 89 f5 53 48 89 fb 48 83 ec 08=
 e8 8f ec fd ff 89 c7 e8 f8 f0 fd ff &lt;48&gt; 8b 30 48 89 ea 48 89 df e8 =
fa eb fd ff 48 83 c4 08 b8 01 00 00=C2=A0=C2=A0<div><br></div><div><br></di=
v></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Sun, Jul 1=
5, 2018 at 8:02 PM Br=C3=A1ulio Bhavamitra &lt;<a href=3D"mailto:brauliobo@=
gmail.com">brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><div dir=3D"ltr">Although it is reported on dmesg, the system st=
ill boots normally<br><div><br></div><div><div>[=C2=A0 =C2=A0 8.253073] amd=
gpu: [powerplay] dpm has been enabled</div><div>[=C2=A0 =C2=A0 8.253210] [d=
rm] DM_PPLIB:=C2=A0 =C2=A0400000 in kHz</div><div>[=C2=A0 =C2=A0 8.253211] =
[drm] DM_PPLIB:=C2=A0 =C2=A0933000 in kHz</div><div>[=C2=A0 =C2=A0 8.253212=
] [drm] DM_PPLIB:=C2=A0 =C2=A01067000 in kHz</div><div>[=C2=A0 =C2=A0 8.253=
380] WARNING: CPU: 6 PID: 361 at drivers/gpu/drm/amd/amdgpu/../display/dc/c=
alcs/dcn_calcs.c:1355 dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]</div><d=
iv>[=C2=A0 =C2=A0 8.253381] Modules linked in: ext4 mbcache jbd2 fscrypto j=
oydev mousedev amdkfd amd_iommu_v2 amdgpu(+) arc4 r8822be(C) uvcvideo btusb=
 btrtl btbcm btintel videobuf2_vmalloc videobuf2_memops hid_sensor_accel_3d=
 hid_sensor_magn_3d videobuf2_v4l2 chash hid_sensor_rotation hid_sensor_inc=
l_3d hid_sensor_gyro_3d bluetooth videobuf2_common gpu_sched hid_sensor_tri=
gger industrialio_triggered_buffer videodev i2c_algo_bit kfifo_buf hid_sens=
or_iio_common ecdh_generic industrialio media crc16 ttm mac80211 drm_kms_he=
lper hp_wmi edac_mce_amd snd_hda_codec_realtek sparse_keymap snd_hda_codec_=
generic drm wmi_bmof snd_hda_codec_hdmi kvm_amd snd_hda_intel ccp snd_hda_c=
odec rng_core cfg80211 snd_hda_core snd_hwdep kvm snd_pcm snd_timer psmouse=
 agpgart snd syscopyarea sysfillrect irqbypass rtsx_pci_ms sysimgblt input_=
leds</div><div>[=C2=A0 =C2=A0 8.253444]=C2=A0 fb_sys_fops rfkill memstick s=
oundcore sp5100_tco k10temp hp_accel lis3lv02d i2c_piix4 battery ac rtc_cmo=
s wmi input_polldev led_class i2c_hid evdev acpi_cpufreq pinctrl_amd mac_hi=
d i2c_scmi hp_wireless vboxnetflt(O) vboxnetadp(O) vboxpci(O) vboxdrv(O) ms=
r sg crypto_user ip_tables x_tables dm_crypt dm_mod btrfs libcrc32c crc32c_=
generic xor zstd_decompress zstd_compress xxhash hid_sensor_hub hid_generic=
 usbhid hid raid6_pq sd_mod crct10dif_pclmul crc32_pclmul crc32c_intel ghas=
h_clmulni_intel pcbc rtsx_pci_sdmmc serio_raw atkbd libps2 mmc_core ahci li=
bahci aesni_intel xhci_pci aes_x86_64 libata crypto_simd xhci_hcd cryptd gl=
ue_helper usbcore scsi_mod usb_common rtsx_pci i8042 serio lz4 lz4_compress=
</div><div>[=C2=A0 =C2=A0 8.253511] CPU: 6 PID: 361 Comm: systemd-udevd Tai=
nted: G=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0C O=C2=A0 =C2=A0 =C2=A0 4.18.0-1-c=
ustom+ #7</div><div>[=C2=A0 =C2=A0 8.253512] Hardware name: HP HP ENVY x360=
 Convertible 15m-bq1xx/83C6, BIOS F.17 03/29/2018</div><div>[=C2=A0 =C2=A0 =
8.253630] RIP: 0010:dcn_bw_update_from_pplib+0x16b/0x280 [amdgpu]</div><div=
>[=C2=A0 =C2=A0 8.253631] Code: d8 ca d8 f1 d9 5a 50 8b 44 fc 14 49 8b 94 2=
4 70 01 00 00 48 89 04 24 df 2c 24 d8 f1 db 42 78 de c9 de ca de f9 d9 5a 4=
c eb 02 &lt;0f&gt; 0b 48 89 da be 04 00 00 00 48 89 ef e8 13 5b fe ff 84 c0=
 0f 84</div><div>[=C2=A0 =C2=A0 8.253675] RSP: 0018:ffff9bc383b037b8 EFLAGS=
: 00010246</div><div>[=C2=A0 =C2=A0 8.253678] RAX: 0000000000000001 RBX: ff=
ff9bc383b03818 RCX: 0000000000000000</div><div>[=C2=A0 =C2=A0 8.253679] RDX=
: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff</div><div>[=
=C2=A0 =C2=A0 8.253681] RBP: ffff918c85651a40 R08: 0000000000000001 R09: 00=
0000000000039f</div><div>[=C2=A0 =C2=A0 8.253683] R10: 0000000000000004 R11=
: 0000000000000000 R12: ffff918c733ae000</div><div>[=C2=A0 =C2=A0 8.253684]=
 R13: ffff918c73293300 R14: ffff918c733ae000 R15: 0000000000000000</div><di=
v>[=C2=A0 =C2=A0 8.253687] FS:=C2=A0 00007ffff7f85d40(0000) GS:ffff918c8ab8=
0000(0000) knlGS:0000000000000000</div><div>[=C2=A0 =C2=A0 8.253688] CS:=C2=
=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033</div><div>[=C2=A0 =C2=A0 8=
.253690] CR2: 00007ffff7a28000 CR3: 0000000505f02000 CR4: 00000000003406e0<=
/div><div>[=C2=A0 =C2=A0 8.253692] Call Trace:</div><div>[=C2=A0 =C2=A0 8.2=
53817]=C2=A0 dcn10_create_resource_pool+0x756/0x990 [amdgpu]</div><div>[=C2=
=A0 =C2=A0 8.253933]=C2=A0 dc_create_resource_pool+0x42/0x180 [amdgpu]</div=
><div>[=C2=A0 =C2=A0 8.253940]=C2=A0 ? __kmalloc+0x1aa/0x230</div><div>[=C2=
=A0 =C2=A0 8.254053]=C2=A0 ? dal_gpio_service_create+0x7c/0x110 [amdgpu]</d=
iv><div>[=C2=A0 =C2=A0 8.254165]=C2=A0 dc_create+0x228/0x650 [amdgpu]</div>=
<div>[=C2=A0 =C2=A0 8.254273]=C2=A0 ? amdgpu_cgs_create_device+0x23/0x50 [a=
mdgpu]</div><div>[=C2=A0 =C2=A0 8.254385]=C2=A0 dm_hw_init+0xc8/0x130 [amdg=
pu]</div><div>[=C2=A0 =C2=A0 8.254496]=C2=A0 amdgpu_device_init.cold.15+0x1=
041/0x1253 [amdgpu]</div><div>[=C2=A0 =C2=A0 8.254585]=C2=A0 amdgpu_driver_=
load_kms+0x86/0x2c0 [amdgpu]</div><div>[=C2=A0 =C2=A0 8.254607]=C2=A0 drm_d=
ev_register+0x109/0x140 [drm]</div><div>[=C2=A0 =C2=A0 8.254693]=C2=A0 amdg=
pu_pci_probe+0x13c/0x1c0 [amdgpu]</div><div>[=C2=A0 =C2=A0 8.254699]=C2=A0 =
? _raw_spin_unlock_irqrestore+0x20/0x40</div><div>[=C2=A0 =C2=A0 8.254704]=
=C2=A0 local_pci_probe+0x41/0x90</div><div>[=C2=A0 =C2=A0 8.254709]=C2=A0 p=
ci_device_probe+0x189/0x1a0</div><div>[=C2=A0 =C2=A0 8.254715]=C2=A0 driver=
_probe_device+0x2b9/0x460</div><div>[=C2=A0 =C2=A0 8.254719]=C2=A0 __driver=
_attach+0xdd/0x110</div><div>[=C2=A0 =C2=A0 8.254722]=C2=A0 ? driver_probe_=
device+0x460/0x460</div><div>[=C2=A0 =C2=A0 8.254725]=C2=A0 bus_for_each_de=
v+0x76/0xc0</div><div>[=C2=A0 =C2=A0 8.254729]=C2=A0 bus_add_driver+0x152/0=
x230</div><div>[=C2=A0 =C2=A0 8.254732]=C2=A0 ? 0xffffffffc1240000</div><di=
v>[=C2=A0 =C2=A0 8.254735]=C2=A0 driver_register+0x6b/0xb0</div><div>[=C2=
=A0 =C2=A0 8.254738]=C2=A0 ? 0xffffffffc1240000</div><div>[=C2=A0 =C2=A0 8.=
254742]=C2=A0 do_one_initcall+0x46/0x1f5</div><div>[=C2=A0 =C2=A0 8.254746]=
=C2=A0 ? kmem_cache_alloc_trace+0x181/0x1d0</div><div>[=C2=A0 =C2=A0 8.2547=
51]=C2=A0 ? do_init_module+0x22/0x210</div><div>[=C2=A0 =C2=A0 8.254755]=C2=
=A0 do_init_module+0x5a/0x210</div><div>[=C2=A0 =C2=A0 8.254759]=C2=A0 load=
_module+0x2295/0x24b0</div><div>[=C2=A0 =C2=A0 8.254766]=C2=A0 ? vmap_page_=
range_noflush+0x243/0x320</div><div>[=C2=A0 =C2=A0 8.254772]=C2=A0 ? __se_s=
ys_init_module+0x10c/0x170</div><div>[=C2=A0 =C2=A0 8.254776]=C2=A0 __se_sy=
s_init_module+0x10c/0x170</div><div>[=C2=A0 =C2=A0 8.254781]=C2=A0 do_sysca=
ll_64+0x5b/0x170</div><div>[=C2=A0 =C2=A0 8.254786]=C2=A0 entry_SYSCALL_64_=
after_hwframe+0x44/0xa9</div><div>[=C2=A0 =C2=A0 8.254789] RIP: 0033:0x7fff=
f78f6f3a</div><div>[=C2=A0 =C2=A0 8.254789] Code: 48 8b 0d 19 cf 2b 00 f7 d=
8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 8=
9 ca b8 af 00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d e6 ce=
 2b 00 f7 d8 64 89 01 48</div><div>[=C2=A0 =C2=A0 8.254834] RSP: 002b:00007=
fffffffd648 EFLAGS: 00000246 ORIG_RAX: 00000000000000af</div><div>[=C2=A0 =
=C2=A0 8.254837] RAX: ffffffffffffffda RBX: 00005555557bc1c0 RCX: 00007ffff=
78f6f3a</div><div>[=C2=A0 =C2=A0 8.254839] RDX: 00007ffff7193ecd RSI: 00000=
00000605250 RDI: 00005555561c1cd0</div><div>[=C2=A0 =C2=A0 8.254840] RBP: 0=
0007ffff7193ecd R08: 0000000000000007 R09: 0000000000000006</div><div>[=C2=
=A0 =C2=A0 8.254842] R10: 00005555557b3010 R11: 0000000000000246 R12: 00005=
555561c1cd0</div><div>[=C2=A0 =C2=A0 8.254843] R13: 00005555557c3f20 R14: 0=
000000000020000 R15: 00005555557bc1c0</div><div>[=C2=A0 =C2=A0 8.254847] --=
-[ end trace 9134c6e0a3766f30 ]---</div><div>[=C2=A0 =C2=A0 8.254869] [drm]=
 DM_PPLIB: values for Invalid clock</div><div>[=C2=A0 =C2=A0 8.254871] [drm=
] DM_PPLIB:=C2=A0 =C2=A0300000 in kHz</div><div>[=C2=A0 =C2=A0 8.254871] [d=
rm] DM_PPLIB:=C2=A0 =C2=A0600000 in kHz</div><div>[=C2=A0 =C2=A0 8.254872] =
[drm] DM_PPLIB:=C2=A0 =C2=A0626000 in kHz</div><div>[=C2=A0 =C2=A0 8.254873=
] [drm] DM_PPLIB:=C2=A0 =C2=A0654000 in kHz</div><div>[=C2=A0 =C2=A0 8.2556=
69] [drm:construct [amdgpu]] *ERROR* construct: Invalid Connector ObjectID =
from Adapter Service for connector index:2! type 0 expected 3</div><div>[=
=C2=A0 =C2=A0 8.262434] [drm] Display Core initialized with v3.1.52!</div><=
div>[=C2=A0 =C2=A0 8.270244] [drm] SADs count is: -2, don&#39;t need to rea=
d it</div><div>[=C2=A0 =C2=A0 8.271703] [drm] Supports vblank timestamp cac=
hing Rev 2 (21.10.2013).</div><div>[=C2=A0 =C2=A0 8.271704] [drm] Driver su=
pports precise vblank timestamp query.</div><div>[=C2=A0 =C2=A0 8.295109] [=
drm] VCN decode and encode initialized successfully.</div><div>[=C2=A0 =C2=
=A0 8.296988] [drm] fb mappable at 0xD1100000</div><div>[=C2=A0 =C2=A0 8.29=
6990] [drm] vram apper at 0xD0000000</div><div>[=C2=A0 =C2=A0 8.296991] [dr=
m] size 8294400</div><div>[=C2=A0 =C2=A0 8.296992] [drm] fb depth is 24</di=
v><div>[=C2=A0 =C2=A0 8.296993] [drm]=C2=A0 =C2=A0 pitch is 7680</div><div>=
[=C2=A0 =C2=A0 8.297159] fbcon: amdgpudrmfb (fb0) is primary device</div><d=
iv>[=C2=A0 =C2=A0 8.314740] Console: switching to colour frame buffer devic=
e 240x67</div><div>[=C2=A0 =C2=A0 8.336232] amdgpu 0000:03:00.0: fb0: amdgp=
udrmfb frame buffer device</div><div>[=C2=A0 =C2=A0 8.345240] amdgpu 0000:0=
3:00.0: ring 0(gfx) uses VM inv eng 4 on hub 0</div><div>[=C2=A0 =C2=A0 8.3=
45244] amdgpu 0000:03:00.0: ring 1(comp_1.0.0) uses VM inv eng 5 on hub 0</=
div><div>[=C2=A0 =C2=A0 8.345247] amdgpu 0000:03:00.0: ring 2(comp_1.1.0) u=
ses VM inv eng 6 on hub 0</div><div>[=C2=A0 =C2=A0 8.345250] amdgpu 0000:03=
:00.0: ring 3(comp_1.2.0) uses VM inv eng 7 on hub 0</div><div>[=C2=A0 =C2=
=A0 8.345252] amdgpu 0000:03:00.0: ring 4(comp_1.3.0) uses VM inv eng 8 on =
hub 0</div><div>[=C2=A0 =C2=A0 8.345255] amdgpu 0000:03:00.0: ring 5(comp_1=
.0.1) uses VM inv eng 9 on hub 0</div><div>[=C2=A0 =C2=A0 8.345258] amdgpu =
0000:03:00.0: ring 6(comp_1.1.1) uses VM inv eng 10 on hub 0</div><div>[=C2=
=A0 =C2=A0 8.345260] amdgpu 0000:03:00.0: ring 7(comp_1.2.1) uses VM inv en=
g 11 on hub 0</div><div>[=C2=A0 =C2=A0 8.345263] amdgpu 0000:03:00.0: ring =
8(comp_1.3.1) uses VM inv eng 12 on hub 0</div><div>[=C2=A0 =C2=A0 8.345266=
] amdgpu 0000:03:00.0: ring 9(kiq_2.1.0) uses VM inv eng 13 on hub 0</div><=
div>[=C2=A0 =C2=A0 8.345269] amdgpu 0000:03:00.0: ring 10(sdma0) uses VM in=
v eng 4 on hub 1</div><div>[=C2=A0 =C2=A0 8.345272] amdgpu 0000:03:00.0: ri=
ng 11(vcn_dec) uses VM inv eng 5 on hub 1</div><div>[=C2=A0 =C2=A0 8.345275=
] amdgpu 0000:03:00.0: ring 12(vcn_enc0) uses VM inv eng 6 on hub 1</div><d=
iv>[=C2=A0 =C2=A0 8.345278] amdgpu 0000:03:00.0: ring 13(vcn_enc1) uses VM =
inv eng 7 on hub 1</div><div>[=C2=A0 =C2=A0 8.345280] amdgpu 0000:03:00.0: =
ring 14(vcn_jpeg) uses VM inv eng 8 on hub 1</div><div>[=C2=A0 =C2=A0 8.858=
530] [drm] Initialized amdgpu 3.26.0 20150101 for 0000:03:00.0 on minor 0</=
div></div><div><br></div></div>
</blockquote></div>

--000000000000e828d305711239bc--

--===============1462131366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1462131366==--
