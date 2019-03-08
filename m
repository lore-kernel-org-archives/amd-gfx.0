From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: locking related bug detected since "drm/amdgpu: lookup vbios table to
 check ecc capability"
Date: Fri, 8 Mar 2019 11:08:28 +0100
Message-ID: <514948e4-5e4d-ce63-73ec-eefc6b3a15ba@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------3C02D515689FF11934E08555"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-CA
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
To: xinhui pan <xinhui.pan-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------3C02D515689FF11934E08555
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Hi Xinhui,


since this commit, amdgpu_ras_init runs on my development system with
Bonaire, and generates the attached BUG and lock debug warning reports.


Before this commit, amdgpu_ras_init returned early, because RAS isn't
supported. There's no mention of this change of behaviour in the commit
log, and it doesn't seem related to checking a VBIOS table for ECC
capability. Was it intended?


P.S. AFAICT this patch wasn't submitted to the amd-gfx list for review.
All changes must be reviewed here before being applied to
amd-staging-drm-next.

-- 
Earthling Michel Dänzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------3C02D515689FF11934E08555
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Mar  8 07:35:57 kaveri kernel: [    7.250187] BUG: key ffff88837b9e0040 n=
ot in .data!
Mar  8 07:35:57 kaveri kernel: [    7.250189] ------------[ cut here ]---=
---------
Mar  8 07:35:57 kaveri kernel: [    7.250190] DEBUG_LOCKS_WARN_ON(1)
Mar  8 07:35:57 kaveri kernel: [    7.250199] WARNING: CPU: 2 PID: 450 at=
 kernel/locking/lockdep.c:3129 lockdep_init_map.cold.44+0x9a/0xb6
Mar  8 07:35:57 kaveri kernel: [    7.250200] Modules linked in: amdgpu(O=
E+) binfmt_misc(E) chash(OE) gpu_sched(OE) nls_ascii(E) nls_cp437(E) vfat=
(E) fat(E) edac_mce_amd(E) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_=
pclmul(E) ghash_clmulni_intel(E) radeon(OE) snd_hda_codec_realtek(E) snd_=
hda_codec_generic(E) ledtrig_audio(E) snd_hda_codec_hdmi(E) ttm(OE) snd_h=
da_intel(E) drm_kms_helper(OE) snd_hda_codec(E) efi_pstore(E) snd_hda_cor=
e(E) drm(OE) realtek(E) snd_hwdep(E) aesni_intel(E) snd_pcm(E) snd_timer(=
E) aes_x86_64(E) i2c_algo_bit(E) r8169(E) crypto_simd(E) fb_sys_fops(E) c=
cp(E) sp5100_tco(E) snd(E) syscopyarea(E) cryptd(E) sysfillrect(E) wmi_bm=
of(E) glue_helper(E) efivars(E) pcspkr(E) sg(E) soundcore(E) rng_core(E) =
i2c_piix4(E) sysimgblt(E) k10temp(E) libphy(E) wmi(E) pcc_cpufreq(E) butt=
on(E) acpi_cpufreq(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc=
(E) efivarfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generi=
c(E) crc16(E) mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E)=
 raid0(E)
Mar  8 07:35:57 kaveri kernel: [    7.250237]  multipath(E) linear(E) md_=
mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahci(E) libahci=
(E) xhci_pci(E) crc32c_intel(E) libata(E) xhci_hcd(E) usbcore(E) scsi_mod=
(E) gpio_amdpt(E) gpio_generic(E)
Mar  8 07:35:57 kaveri kernel: [    7.250249] CPU: 2 PID: 450 Comm: syste=
md-udevd Tainted: G           OE     5.0.0-rc1-00651-g4a93cf78b903 #121
Mar  8 07:35:57 kaveri kernel: [    7.250250] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Mar  8 07:35:57 kaveri kernel: [    7.250253] RIP: 0010:lockdep_init_map.=
cold.44+0x9a/0xb6
Mar  8 07:35:57 kaveri kernel: [    7.250255] Code: c0 03 38 d0 7c 04 84 =
d2 75 35 83 3d 78 c8 4a 02 00 0f 85 66 56 ff ff 48 c7 c6 40 8a a7 8a 48 c=
7 c7 c0 89 a7 8a e8 16 e2 ec ff <0f> 0b e9 4c 56 ff ff 48 c7 c7 40 e2 d4 =
8c e8 28 cd 44 00 eb 85 e8
Mar  8 07:35:57 kaveri kernel: [    7.250257] RSP: 0018:ffff888372fdf050 =
EFLAGS: 00010286
Mar  8 07:35:57 kaveri kernel: [    7.250259] RAX: 0000000000000000 RBX: =
ffff88836d4e5188 RCX: ffffffff89061a74
Mar  8 07:35:57 kaveri kernel: [    7.250260] RDX: 0000000000000000 RSI: =
0000000000000004 RDI: ffffffff8b5049b8
Mar  8 07:35:57 kaveri kernel: [    7.250261] RBP: ffffffff8cd4e240 R08: =
fffffbfff161ea7d R09: fffffbfff161ea7c
Mar  8 07:35:57 kaveri kernel: [    7.250263] R10: fffffbfff161ea7c R11: =
ffffffff8b0f53e3 R12: ffff88837b9e0040
Mar  8 07:35:57 kaveri kernel: [    7.250264] R13: 0000000000000000 R14: =
ffff88836d4e4ee0 R15: 0000000000000000
Mar  8 07:35:57 kaveri kernel: [    7.250266] FS:  00007fccb9a67d40(0000)=
 GS:ffff88837de80000(0000) knlGS:0000000000000000
Mar  8 07:35:57 kaveri kernel: [    7.250267] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Mar  8 07:35:57 kaveri kernel: [    7.250268] CR2: 00007f75f19de028 CR3: =
0000000372f44000 CR4: 00000000003406e0
Mar  8 07:35:57 kaveri kernel: [    7.250269] Call Trace:
Mar  8 07:35:57 kaveri kernel: [    7.250275]  __kernfs_create_file+0xf9/=
0x2d0
Mar  8 07:35:57 kaveri kernel: [    7.250278]  sysfs_add_file_mode_ns+0x1=
b2/0x4f0
Mar  8 07:35:57 kaveri kernel: [    7.250283]  internal_create_group+0x2a=
4/0xa20
Mar  8 07:35:57 kaveri kernel: [    7.250287]  ? remove_files.isra.1+0x17=
0/0x170
Mar  8 07:35:57 kaveri kernel: [    7.250291]  ? rcu_read_lock_sched_held=
+0xd8/0x110
Mar  8 07:35:57 kaveri kernel: [    7.250383]  ? amdgpu_ras_create_obj+0x=
211/0x390 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.250470]  ? __amdgpu_ras_feature_ena=
ble+0x313/0x4f0 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.250473]  ? is_module_address+0xa/0x=
20
Mar  8 07:35:57 kaveri kernel: [    7.250475]  ? static_obj+0x2d/0x50
Mar  8 07:35:57 kaveri kernel: [    7.250562]  amdgpu_ras_init+0x6f9/0xaa=
0 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.250649]  ? amdgpu_ras_reserve_bad_p=
ages+0xa20/0xa20 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.250654]  ? idr_alloc_u32+0x2a0/0x2a=
0
Mar  8 07:35:57 kaveri kernel: [    7.250674]  ? drm_property_create+0x24=
e/0x430 [drm]
Mar  8 07:35:57 kaveri kernel: [    7.250770]  amdgpu_device_init.cold.33=
+0x3bc9/0x51ec [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.250855]  ? amdgpu_device_has_dc_sup=
port+0x50/0x50 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.338883]  ? rcu_read_lock_sched_held=
+0xd8/0x110
Mar  8 07:35:57 kaveri kernel: [    7.338886]  ? __alloc_pages_nodemask+0=
x524/0x5e0
Mar  8 07:35:57 kaveri kernel: [    7.338889]  ? pointer+0x650/0x650
Mar  8 07:35:57 kaveri kernel: [    7.338892]  ? __alloc_pages_slowpath+0=
x2230/0x2230
Mar  8 07:35:57 kaveri kernel: [    7.338895]  ? __lock_is_held+0xad/0x14=
0
Mar  8 07:35:57 kaveri kernel: [    7.338973]  ? amdgpu_driver_load_kms+0=
x105/0xb00 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.338977]  ? rcu_read_lock_sched_held=
+0xd8/0x110
Mar  8 07:35:57 kaveri kernel: [    7.352447]  amdgpu_driver_load_kms+0x1=
aa/0xb00 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.352530]  ? amdgpu_driver_unload_kms=
+0x430/0x430 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.356375]  ? __kasan_slab_free+0x13f/=
0x170
Mar  8 07:35:57 kaveri kernel: [    7.356393]  drm_dev_register+0x311/0x4=
e0 [drm]
Mar  8 07:35:57 kaveri kernel: [    7.356477]  amdgpu_pci_probe+0x144/0x2=
00 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.362434]  ? amdgpu_pci_remove+0x90/0=
x90 [amdgpu]
Mar  8 07:35:57 kaveri kernel: [    7.364436]  local_pci_probe+0xd4/0x180=

Mar  8 07:35:57 kaveri kernel: [    7.366503]  pci_device_probe+0x4b1/0x5=
70
Mar  8 07:35:57 kaveri kernel: [    7.366507]  ? pci_device_remove+0x290/=
0x290
Mar  8 07:35:57 kaveri kernel: [    7.366515]  really_probe+0x231/0x9f0
Mar  8 07:35:57 kaveri kernel: [    7.366519]  ? driver_probe_device+0x2f=
0/0x2f0
Mar  8 07:35:57 kaveri kernel: [    7.366521]  driver_probe_device+0x1c7/=
0x2f0
Mar  8 07:35:57 kaveri kernel: [    7.366525]  ? driver_probe_device+0x2f=
0/0x2f0
Mar  8 07:35:57 kaveri kernel: [    7.378288]  __driver_attach+0x22c/0x2c=
0
Mar  8 07:35:57 kaveri kernel: [    7.378291]  bus_for_each_dev+0x11c/0x1=
b0
Mar  8 07:35:57 kaveri kernel: [    7.378294]  ? lock_downgrade+0x5d0/0x5=
d0
Mar  8 07:35:57 kaveri kernel: [    7.378296]  ? subsys_dev_iter_exit+0x1=
0/0x10
Mar  8 07:35:57 kaveri kernel: [    7.378301]  bus_add_driver+0x397/0x650=

Mar  8 07:35:57 kaveri kernel: [    7.378306]  driver_register+0x18e/0x31=
0
Mar  8 07:35:57 kaveri kernel: [    7.378309]  ? 0xffffffffc0ef8000
Mar  8 07:35:57 kaveri kernel: [    7.391834]  do_one_initcall+0xa9/0x3c5=

Mar  8 07:35:57 kaveri kernel: [    7.391837]  ? perf_trace_initcall_leve=
l+0x450/0x450
Mar  8 07:35:57 kaveri kernel: [    7.391840]  ? kasan_unpoison_shadow+0x=
35/0x40
Mar  8 07:35:57 kaveri kernel: [    7.391842]  ? kasan_unpoison_shadow+0x=
35/0x40
Mar  8 07:35:57 kaveri kernel: [    7.391846]  do_init_module+0x1f2/0x710=

Mar  8 07:35:57 kaveri kernel: [    7.391849]  load_module+0x7d70/0x9320
Mar  8 07:35:57 kaveri kernel: [    7.391861]  ? module_frob_arch_section=
s+0x20/0x20
Mar  8 07:35:57 kaveri kernel: [    7.391865]  ? vfs_read+0x256/0x2e0
Mar  8 07:35:57 kaveri kernel: [    7.406572]  ? kernel_read+0x90/0x130
Mar  8 07:35:57 kaveri kernel: [    7.406575]  ? kernel_read_file+0x213/0=
x4f0
Mar  8 07:35:57 kaveri kernel: [    7.406585]  ? __do_sys_finit_module+0x=
11a/0x1b0
Mar  8 07:35:57 kaveri kernel: [    7.406587]  __do_sys_finit_module+0x11=
a/0x1b0
Mar  8 07:35:57 kaveri kernel: [    7.406589]  ? __ia32_sys_init_module+0=
xa0/0xa0
Mar  8 07:35:57 kaveri kernel: [    7.406594]  ? syscall_trace_enter+0x49=
0/0xcc0
Mar  8 07:35:57 kaveri kernel: [    7.414960]  ? do_syscall_64+0x18/0x3d0=

Mar  8 07:35:57 kaveri kernel: [    7.414963]  do_syscall_64+0x9c/0x3d0
Mar  8 07:35:57 kaveri kernel: [    7.414966]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Mar  8 07:35:57 kaveri kernel: [    7.414968] RIP: 0033:0x7fccba2522a9
Mar  8 07:35:57 kaveri kernel: [    7.414970] Code: 00 c3 66 2e 0f 1f 84 =
00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c=
2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 =
6b 0c 00 f7 d8 64 89 01 48
Mar  8 07:35:57 kaveri kernel: [    7.414971] RSP: 002b:00007ffe722be5c8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000139
Mar  8 07:35:57 kaveri kernel: [    7.414973] RAX: ffffffffffffffda RBX: =
00005580a025ae60 RCX: 00007fccba2522a9
Mar  8 07:35:57 kaveri kernel: [    7.414974] RDX: 0000000000000000 RSI: =
00005580a024fdf0 RDI: 0000000000000013
Mar  8 07:35:57 kaveri kernel: [    7.414975] RBP: 00005580a024fdf0 R08: =
0000000000000000 R09: 0000000000000000
Mar  8 07:35:57 kaveri kernel: [    7.414976] R10: 0000000000000013 R11: =
0000000000000246 R12: 0000000000000000
Mar  8 07:35:57 kaveri kernel: [    7.414977] R13: 00005580a0298520 R14: =
0000000000020000 R15: 00005580a025ae60
Mar  8 07:35:57 kaveri kernel: [    7.414982] irq event stamp: 259905
Mar  8 07:35:57 kaveri kernel: [    7.430273] hardirqs last  enabled at (=
259905): [<ffffffff8907d564>] vprintk_emit+0x384/0x3d0
Mar  8 07:35:57 kaveri kernel: [    7.430276] hardirqs last disabled at (=
259904): [<ffffffff8907d40d>] vprintk_emit+0x22d/0x3d0
Mar  8 07:35:57 kaveri kernel: [    7.430278] softirqs last  enabled at (=
259372): [<ffffffff8a8005d4>] __do_softirq+0x5d4/0x86e
Mar  8 07:35:57 kaveri kernel: [    7.430281] softirqs last disabled at (=
259365): [<ffffffff88f3c022>] irq_exit+0x1a2/0x1d0

--------------3C02D515689FF11934E08555
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------3C02D515689FF11934E08555--
