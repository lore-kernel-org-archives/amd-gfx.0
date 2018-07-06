From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Implement get_performance_level for legacy
 dgpu
Date: Fri, 6 Jul 2018 15:30:06 +0200
Message-ID: <87057e12-b948-3309-0b2d-2e535791846f@daenzer.net>
References: <1530799235-21697-1-git-send-email-rex.zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------C04A91C8671F556928D806FC"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1530799235-21697-1-git-send-email-rex.zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------C04A91C8671F556928D806FC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Hi Rex,


On 2018-07-05 04:00 PM, Rex Zhu wrote:
> display can get clock info through this function.
> implement this function for vega10 and old asics.
> from vega12, there is no power state management. so need other
> interface to notify display the clock info
> 
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

This change broke amdgpu initialization with my Tonga with DC enabled,
see the attached kernel log excerpt.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------C04A91C8671F556928D806FC
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Jul  6 15:19:56 kaveri kernel: [   55.653436] BUG: unable to handle kerne=
l paging request at ffffed016177eaea
Jul  6 15:19:56 kaveri kernel: [   55.653448] PGD 43f370067 P4D 43f370067=
 PUD 0=20
Jul  6 15:19:56 kaveri kernel: [   55.653457] Oops: 0000 [#1] SMP KASAN N=
OPTI
Jul  6 15:19:56 kaveri kernel: [   55.653462] CPU: 2 PID: 4371 Comm: Xorg=
 Tainted: G           OE     4.18.0-rc1+ #110
Jul  6 15:19:56 kaveri kernel: [   55.653466] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Jul  6 15:19:56 kaveri kernel: [   55.653551] RIP: 0010:dce_update_clocks=
+0x41c/0x790 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.653553] Code: 7b 03 00 00 41 39 e8 =
45 8b 7d 14 0f 83 69 01 00 00 44 89 c5 48 b8 00 00 00 00 00 fc ff df 49 8=
d 7c ed 50 48 89 f9 48 c1 e9 03 <0f> b6 04 01 84 c0 74 08 3c 03 0f 8e 2b =
03 00 00 4c 89 f1 48 b8 00=20
Jul  6 15:19:56 kaveri kernel: [   55.653616] RSP: 0018:ffff8803d2aff2d8 =
EFLAGS: 00010212
Jul  6 15:19:56 kaveri kernel: [   55.653621] RAX: dffffc0000000000 RBX: =
ffff8803e4dc5f14 RCX: 1ffff1016177eaea
Jul  6 15:19:56 kaveri kernel: [   55.653624] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: ffff880b0bbf5750
Jul  6 15:19:56 kaveri kernel: [   55.653627] RBP: 00000000e4dc5f00 R08: =
00000000e4dc5f00 R09: ffffed007dc14567
Jul  6 15:19:56 kaveri kernel: [   55.653630] R10: ffff8803d2aff380 R11: =
ffffed007dc14566 R12: 1ffff1007a55fe5d
Jul  6 15:19:56 kaveri kernel: [   55.653633] R13: ffff8803e4dc5f00 R14: =
ffff8803d2aff3b0 R15: 0000000000000000
Jul  6 15:19:56 kaveri kernel: [   55.653637] FS:  00007f6c226a5dc0(0000)=
 GS:ffff8803ee080000(0000) knlGS:0000000000000000
Jul  6 15:19:56 kaveri kernel: [   55.653640] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Jul  6 15:19:56 kaveri kernel: [   55.653643] CR2: ffffed016177eaea CR3: =
00000003c08d0000 CR4: 00000000003406e0
Jul  6 15:19:56 kaveri kernel: [   55.653646] Call Trace:
Jul  6 15:19:56 kaveri kernel: [   55.653727]  ? dce110_set_safe_displaym=
arks+0x12e/0x260 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.653808]  ? dce_clock_read_ss_info+0=
x420/0x420 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.653885]  ? generic_reg_update_ex+0x=
228/0x500 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.653967]  dce100_set_bandwidth+0x22b=
/0x300 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654047]  ? dce100_pplib_apply_displ=
ay_requirements+0x1b0/0x1b0 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654053]  ? rcu_read_lock_sched_held=
+0xdc/0x110
Jul  6 15:19:56 kaveri kernel: [   55.654134]  ? bios_set_scratch_acc_mod=
e_change+0x176/0x220 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654213]  dc_commit_state+0x700/0x16=
b0 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654295]  ? dc_destroy+0x90/0x90 [am=
dgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654316]  ? drm_dev_dbg+0x1a0/0x1a0 =
[drm]
Jul  6 15:19:56 kaveri kernel: [   55.654401]  amdgpu_dm_atomic_commit_ta=
il+0x961/0x3f90 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654409]  ? mark_held_locks+0xa8/0xf=
0
Jul  6 15:19:56 kaveri kernel: [   55.654414]  ? trace_hardirqs_on_caller=
+0x381/0x570
Jul  6 15:19:56 kaveri kernel: [   55.654419]  ? _raw_spin_unlock_irq+0x2=
9/0x40
Jul  6 15:19:56 kaveri kernel: [   55.654424]  ? wait_for_completion_time=
out+0xc1/0x390
Jul  6 15:19:56 kaveri kernel: [   55.654435]  ? drm_atomic_helper_swap_s=
tate+0x7a2/0x15b0 [drm_kms_helper]
Jul  6 15:19:56 kaveri kernel: [   55.654512]  ? amdgpu_dm_do_flip+0xab0/=
0xab0 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654517]  ? lock_downgrade+0x5e0/0x5=
e0
Jul  6 15:19:56 kaveri kernel: [   55.654593]  ? dm_plane_helper_prepare_=
fb+0x291/0xb00 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654607]  ? drm_atomic_helper_wait_f=
or_dependencies+0x255/0x7d0 [drm_kms_helper]
Jul  6 15:19:56 kaveri kernel: [   55.654620]  commit_tail+0x9a/0xf0 [drm=
_kms_helper]
Jul  6 15:19:56 kaveri kernel: [   55.654632]  drm_atomic_helper_commit+0=
x179/0x240 [drm_kms_helper]
Jul  6 15:19:56 kaveri kernel: [   55.654645]  drm_atomic_helper_set_conf=
ig+0xbb/0x100 [drm_kms_helper]
Jul  6 15:19:56 kaveri kernel: [   55.654665]  __drm_mode_set_config_inte=
rnal+0x199/0x4f0 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654686]  drm_mode_setcrtc+0x83f/0xf=
60 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654710]  ? drm_mode_getcrtc+0x760/0=
x760 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654716]  ? refcount_inc+0x30/0x30
Jul  6 15:19:56 kaveri kernel: [   55.654722]  ? find_held_lock+0x32/0x1c=
0
Jul  6 15:19:56 kaveri kernel: [   55.654748]  ? drm_mode_getcrtc+0x760/0=
x760 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654765]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654783]  ? drm_setversion+0x7d0/0x7=
d0 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654790]  ? __check_object_size+0x14=
9/0x360
Jul  6 15:19:56 kaveri kernel: [   55.654809]  drm_ioctl+0x60a/0x970 [drm=
]
Jul  6 15:19:56 kaveri kernel: [   55.654829]  ? drm_mode_getcrtc+0x760/0=
x760 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654847]  ? drm_ioctl_kernel+0x220/0=
x220 [drm]
Jul  6 15:19:56 kaveri kernel: [   55.654857]  ? _raw_spin_unlock_irqrest=
ore+0x32/0x60
Jul  6 15:19:56 kaveri kernel: [   55.654861]  ? trace_hardirqs_on_caller=
+0x381/0x570
Jul  6 15:19:56 kaveri kernel: [   55.654921]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.654928]  do_vfs_ioctl+0x192/0xf30
Jul  6 15:19:56 kaveri kernel: [   55.654933]  ? find_held_lock+0x32/0x1c=
0
Jul  6 15:19:56 kaveri kernel: [   55.654937]  ? ioctl_preallocate+0x1b0/=
0x1b0
Jul  6 15:19:56 kaveri kernel: [   55.654943]  ? __fget+0x1c8/0x300
Jul  6 15:19:56 kaveri kernel: [   55.654947]  ? lock_downgrade+0x5e0/0x5=
e0
Jul  6 15:19:56 kaveri kernel: [   55.654955]  ? __fget+0x1e0/0x300
Jul  6 15:19:56 kaveri kernel: [   55.654962]  ksys_ioctl+0x70/0x80
Jul  6 15:19:56 kaveri kernel: [   55.654968]  __x64_sys_ioctl+0x6f/0xb0
Jul  6 15:19:56 kaveri kernel: [   55.654972]  ? trace_hardirqs_on_caller=
+0x381/0x570
Jul  6 15:19:56 kaveri kernel: [   55.654976]  do_syscall_64+0xa5/0x3f0
Jul  6 15:19:56 kaveri kernel: [   55.654981]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Jul  6 15:19:56 kaveri kernel: [   55.654985] RIP: 0033:0x7f6c20640f07
Jul  6 15:19:56 kaveri kernel: [   55.654987] Code: b3 66 90 48 8b 05 81 =
5f 2c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 =
5f 2c 00 f7 d8 64 89 01 48=20
Jul  6 15:19:56 kaveri kernel: [   55.655050] RSP: 002b:00007fff96a66688 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jul  6 15:19:56 kaveri kernel: [   55.655055] RAX: ffffffffffffffda RBX: =
00007fff96a666c0 RCX: 00007f6c20640f07
Jul  6 15:19:56 kaveri kernel: [   55.655058] RDX: 00007fff96a666c0 RSI: =
00000000c06864a2 RDI: 000000000000000c
Jul  6 15:19:56 kaveri kernel: [   55.655061] RBP: 00007fff96a666b0 R08: =
0000000000000000 R09: 0000555e05c0a470
Jul  6 15:19:56 kaveri kernel: [   55.655064] R10: 00007fff96a667a0 R11: =
0000000000000246 R12: 00007fff96a666c0
Jul  6 15:19:56 kaveri kernel: [   55.655067] R13: 00000000c06864a2 R14: =
000000000000000c R15: 0000000000000000
Jul  6 15:19:56 kaveri kernel: [   55.655074] Modules linked in: amdkfd(O=
E) amdgpu(OE) chash(OE) gpu_sched(OE) lz4(E) lz4_compress(E) cpufreq_powe=
rsave(E) cpufreq_userspace(E) cpufreq_conservative(E) edac_mce_amd(E) bin=
fmt_misc(E) nls_ascii(E) nls_cp437(E) vfat(E) fat(E) kvm(E) irqbypass(E) =
crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) pcbc(E) snd_hd=
a_codec_realtek(E) radeon(OE) snd_hda_codec_generic(E) wmi_bmof(E) snd_hd=
a_codec_hdmi(E) snd_hda_intel(E) ttm(OE) snd_hda_codec(E) snd_hda_core(E)=
 drm_kms_helper(OE) snd_hwdep(E) snd_pcm(E) aesni_intel(E) drm(OE) efi_ps=
tore(E) aes_x86_64(E) i2c_algo_bit(E) snd_timer(E) fb_sys_fops(E) crypto_=
simd(E) ccp(E) r8169(E) syscopyarea(E) cryptd(E) sysfillrect(E) sp5100_tc=
o(E) snd(E) glue_helper(E) pcspkr(E) sysimgblt(E) efivars(E) k10temp(E) m=
ii(E) sg(E) rng_core(E) soundcore(E) i2c_piix4(E)
Jul  6 15:19:56 kaveri kernel: [   55.655146]  wmi(E) button(E) acpi_cpuf=
req(E) tcp_bbr(E) sch_fq(E) sunrpc(E) nct6775(E) hwmon_vid(E) efivarfs(E)=
 ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) j=
bd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multipath(E) lin=
ear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahci(=
E) libahci(E) libata(E) xhci_pci(E) xhci_hcd(E) crc32c_intel(E) scsi_mod(=
E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Jul  6 15:19:56 kaveri kernel: [   55.655194] CR2: ffffed016177eaea
Jul  6 15:19:56 kaveri kernel: [   55.655198] ---[ end trace 44ec1e02c521=
af9e ]---
Jul  6 15:19:56 kaveri kernel: [   55.655276] RIP: 0010:dce_update_clocks=
+0x41c/0x790 [amdgpu]
Jul  6 15:19:56 kaveri kernel: [   55.655279] Code: 7b 03 00 00 41 39 e8 =
45 8b 7d 14 0f 83 69 01 00 00 44 89 c5 48 b8 00 00 00 00 00 fc ff df 49 8=
d 7c ed 50 48 89 f9 48 c1 e9 03 <0f> b6 04 01 84 c0 74 08 3c 03 0f 8e 2b =
03 00 00 4c 89 f1 48 b8 00=20
Jul  6 15:19:56 kaveri kernel: [   55.655341] RSP: 0018:ffff8803d2aff2d8 =
EFLAGS: 00010212
Jul  6 15:19:56 kaveri kernel: [   55.655345] RAX: dffffc0000000000 RBX: =
ffff8803e4dc5f14 RCX: 1ffff1016177eaea
Jul  6 15:19:56 kaveri kernel: [   55.655348] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: ffff880b0bbf5750
Jul  6 15:19:56 kaveri kernel: [   55.655351] RBP: 00000000e4dc5f00 R08: =
00000000e4dc5f00 R09: ffffed007dc14567
Jul  6 15:19:56 kaveri kernel: [   55.655354] R10: ffff8803d2aff380 R11: =
ffffed007dc14566 R12: 1ffff1007a55fe5d
Jul  6 15:19:56 kaveri kernel: [   55.655357] R13: ffff8803e4dc5f00 R14: =
ffff8803d2aff3b0 R15: 0000000000000000
Jul  6 15:19:56 kaveri kernel: [   55.655360] FS:  00007f6c226a5dc0(0000)=
 GS:ffff8803ee080000(0000) knlGS:0000000000000000
Jul  6 15:19:56 kaveri kernel: [   55.655363] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Jul  6 15:19:56 kaveri kernel: [   55.655366] CR2: ffffed016177eaea CR3: =
00000003c08d0000 CR4: 00000000003406e0

--------------C04A91C8671F556928D806FC
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------C04A91C8671F556928D806FC--
