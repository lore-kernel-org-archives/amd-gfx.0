From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Add fast path for cursor plane updates
Date: Thu, 13 Dec 2018 16:48:48 +0100
Message-ID: <d9cde6c1-90e1-da3e-7edd-eb3570da666c@daenzer.net>
References: <20181205195907.9501-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------CE6882F22C91527CA68D7B14"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181205195907.9501-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
To: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------CE6882F22C91527CA68D7B14
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-12-05 8:59 p.m., Nicholas Kazlauskas wrote:
> [Why]
> Legacy cursor plane updates from drm helpers go through the full
> atomic codepath. A high volume of cursor updates through this slow
> code path can cause subsequent page-flips to skip vblank intervals
> since each individual update is slow.
> 
> This problem is particularly noticeable for the compton compositor.
> 
> [How]
> A fast path for cursor plane updates is added by using DRM asynchronous
> commit support provided by async_check and async_update. These don't do
> a full state/flip_done dependency stall and they don't block other
> commit work.
> 
> However, DC still expects itself to be single-threaded for anything
> that can issue register writes. Screen corruption or hangs can occur
> if write sequences overlap. Every call that potentially perform
> register writes needs to be guarded for asynchronous updates to work.
> The dc_lock mutex was added for this.
> 
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=106175
> 
> Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> Cc: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>

Looks like this change introduced (or at least exposed) a reference
counting bug resulting in use-after-free when Xorg shuts down[0]. See
the attached dmesg excerpt (note that I wrapped the !bo->pin_count check
in amdgpu_bo_unpin in WARN_ON_ONCE).


[0] Only with
https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu/commit/0d60233d26ec70d4e1faa343b438e33829c6d5e4
, i.e. alternating between two BOs for the HW cursor, instead of always
using the same one.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------CE6882F22C91527CA68D7B14
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Dec 13 16:35:07 kaveri kernel: [   52.603334] WARNING: CPU: 13 PID: 2010 =
at drivers/gpu/drm//amd/amdgpu/amdgpu_object.c:915 amdgpu_bo_unpin+0x24e/=
0x340 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.603454] Modules linked in: fuse(E) =
ipt_MASQUERADE(E) nf_conntrack_netlink(E) xfrm_user(E) xfrm_algo(E) nft_c=
ounter(E) nft_chain_nat_ipv4(E) nf_nat_ipv4(E) xt_addrtype(E) nft_compat(=
E) nf_tables(E) nfnetlink(E) xt_conntrack(E) nf_nat(E) nf_conntrack(E) nf=
_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) br_netfilter(E) bridge(E) =
stp(E) llc(E) overlay(E) lz4(E) lz4_compress(E) cpufreq_powersave(E) cpuf=
req_userspace(E) cpufreq_conservative(E) binfmt_misc(E) amdgpu(OE) nls_as=
cii(E) nls_cp437(E) vfat(E) fat(E) chash(OE) gpu_sched(OE) edac_mce_amd(E=
) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_i=
ntel(E) radeon(OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_=
hda_codec_hdmi(E) ttm(OE) wmi_bmof(E) snd_hda_intel(E) drm_kms_helper(OE)=
 aesni_intel(E) snd_hda_codec(E) efi_pstore(E) aes_x86_64(E) snd_hda_core=
(E) crypto_simd(E) snd_hwdep(E) r8169(E) cryptd(E) drm(OE) glue_helper(E)=
 pcspkr(E) efivars(E) sg(E) k10temp(E) snd_pcm(E) i2c_algo_bit(E) libphy(=
E)
Dec 13 16:35:07 kaveri kernel: [   52.603509]  fb_sys_fops(E) syscopyarea=
(E) ccp(E) snd_timer(E) sysfillrect(E) sp5100_tco(E) sysimgblt(E) snd(E) =
soundcore(E) rng_core(E) i2c_piix4(E) wmi(E) pcc_cpufreq(E) button(E) acp=
i_cpufreq(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efiva=
rfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc1=
6(E) mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E)=
 multipath(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhi=
d(E) hid(E) ahci(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_i=
ntel(E) scsi_mod(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Dec 13 16:35:07 kaveri kernel: [   52.603555] CPU: 13 PID: 2010 Comm: Xor=
g Tainted: G           OE     4.20.0-rc3+ #118
Dec 13 16:35:07 kaveri kernel: [   52.603559] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 13 16:35:07 kaveri kernel: [   52.603628] RIP: 0010:amdgpu_bo_unpin+0=
x24e/0x340 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.603633] Code: 3c 11 00 0f 85 ff 00 =
00 00 49 8b bd 28 d4 ff ff 4c 89 e2 48 c7 c6 00 9a eb c2 89 04 24 e8 6a d=
4 5a ca 8b 04 24 e9 a9 fe ff ff <0f> 0b 49 8d bd 28 d4 ff ff 48 b8 00 00 =
00 00 00 fc ff df 48 89 fa
Dec 13 16:35:07 kaveri kernel: [   52.603636] RSP: 0018:ffff8883d403f3d8 =
EFLAGS: 00010246
Dec 13 16:35:07 kaveri kernel: [   52.603641] RAX: 0000000000000000 RBX: =
1ffff1107a807e96 RCX: ffff8883c445e650
Dec 13 16:35:07 kaveri kernel: [   52.603645] RDX: 1ffff1107888bd37 RSI: =
0000000000000000 RDI: ffff8883c445e9b8
Dec 13 16:35:07 kaveri kernel: [   52.603648] RBP: ffff8883c445e9e8 R08: =
fffffbfff83643a7 R09: fffffbfff83643a6
Dec 13 16:35:07 kaveri kernel: [   52.603652] R10: fffffbfff83643a6 R11: =
ffffffffc1b21d33 R12: ffff8883c445e600
Dec 13 16:35:07 kaveri kernel: [   52.603655] R13: ffff8883b1de2bd8 R14: =
1ffff1107a807e7e R15: ffff8883b1de2bd8
Dec 13 16:35:07 kaveri kernel: [   52.603659] FS:  00007fc8b8929940(0000)=
 GS:ffff8883ee140000(0000) knlGS:0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.603663] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Dec 13 16:35:07 kaveri kernel: [   52.603666] CR2: 00007fc8ba821178 CR3: =
00000003b4e0a000 CR4: 00000000003406e0
Dec 13 16:35:07 kaveri kernel: [   52.603669] Call Trace:
Dec 13 16:35:07 kaveri kernel: [   52.603741]  ? amdgpu_bo_unref+0x70/0x7=
0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.603836]  dm_plane_helper_cleanup_fb=
+0x184/0x470 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.603924]  ? perf_trace_amdgpu_dc_per=
formance+0x720/0x720 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.603932]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Dec 13 16:35:07 kaveri kernel: [   52.603940]  ? lockdep_hardirqs_on+0x37=
c/0x560
Dec 13 16:35:07 kaveri kernel: [   52.603954]  drm_atomic_helper_cleanup_=
planes+0x175/0x2c0 [drm_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.604044]  amdgpu_dm_atomic_commit_ta=
il+0x1b84/0x3310 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.604054]  ? wait_for_completion_io_t=
imeout+0x390/0x390
Dec 13 16:35:07 kaveri kernel: [   52.604060]  ? rwlock_bug.part.2+0x90/0=
x90
Dec 13 16:35:07 kaveri kernel: [   52.604150]  ? amdgpu_dm_do_flip+0xe50/=
0xe50 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.604163]  ? drm_atomic_helper_wait_f=
or_dependencies+0x494/0x7e0 [drm_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.604178]  commit_tail+0x96/0xe0 [drm=
_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.604190]  drm_atomic_helper_commit+0=
x177/0x240 [drm_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.604203]  drm_atomic_helper_disable_=
plane+0x109/0x1d0 [drm_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.604224]  drm_mode_cursor_universal+=
0x3e6/0xb30 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604250]  ? setplane_internal+0x330/=
0x330 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604260]  ? ww_mutex_lock_interrupti=
ble+0x34/0xa0
Dec 13 16:35:07 kaveri kernel: [   52.604264]  ? _cond_resched+0x15/0x30
Dec 13 16:35:07 kaveri kernel: [   52.604268]  ? ww_mutex_lock_interrupti=
ble+0x34/0xa0
Dec 13 16:35:07 kaveri kernel: [   52.604290]  drm_mode_cursor_common+0x4=
d0/0x8c0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604297]  ? mark_held_locks+0x140/0x=
140
Dec 13 16:35:07 kaveri kernel: [   52.604303]  ? __read_once_size_nocheck=
=2Econstprop.7+0x10/0x10
Dec 13 16:35:07 kaveri kernel: [   52.604322]  ? drm_mode_cursor_universa=
l+0xb30/0xb30 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604348]  ? drm_dev_exit+0x5/0x30 [d=
rm]
Dec 13 16:35:07 kaveri kernel: [   52.604367]  ? drm_mode_setplane+0x850/=
0x850 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604386]  drm_mode_cursor_ioctl+0x86=
/0xc0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604405]  ? drm_mode_setplane+0x850/=
0x850 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604424]  ? drm_is_current_master+0x=
6a/0x110 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604444]  drm_ioctl_kernel+0x1c6/0x2=
60 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604462]  ? drm_setversion+0x800/0x8=
00 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604485]  drm_ioctl+0x403/0x850 [drm=
]
Dec 13 16:35:07 kaveri kernel: [   52.604506]  ? drm_mode_setplane+0x850/=
0x850 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604524]  ? drm_ioctl_kernel+0x260/0=
x260 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.604528]  ? find_held_lock+0x33/0x1c=
0
Dec 13 16:35:07 kaveri kernel: [   52.604535]  ? __pm_runtime_resume+0xb2=
/0xf0
Dec 13 16:35:07 kaveri kernel: [   52.604543]  ? lock_downgrade+0x5d0/0x5=
d0
Dec 13 16:35:07 kaveri kernel: [   52.604547]  ? lock_acquire+0x103/0x2c0=

Dec 13 16:35:07 kaveri kernel: [   52.604552]  ? __pm_runtime_resume+0x98=
/0xf0
Dec 13 16:35:07 kaveri kernel: [   52.604557]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Dec 13 16:35:07 kaveri kernel: [   52.604563]  ? lockdep_hardirqs_on+0x37=
c/0x560
Dec 13 16:35:07 kaveri kernel: [   52.604633]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.604642]  do_vfs_ioctl+0x193/0xfd0
Dec 13 16:35:07 kaveri kernel: [   52.604647]  ? lock_downgrade+0x5d0/0x5=
d0
Dec 13 16:35:07 kaveri kernel: [   52.604653]  ? ioctl_preallocate+0x1b0/=
0x1b0
Dec 13 16:35:07 kaveri kernel: [   52.604662]  ? __fget+0x287/0x3e0
Dec 13 16:35:07 kaveri kernel: [   52.604670]  ? __ia32_sys_dup2+0x2e0/0x=
2e0
Dec 13 16:35:07 kaveri kernel: [   52.604676]  ? blkg_prfill_rwstat_field=
_recursive+0xf0/0xf0
Dec 13 16:35:07 kaveri kernel: [   52.604681]  ? _raw_spin_unlock_irq+0x2=
9/0x30
Dec 13 16:35:07 kaveri kernel: [   52.604691]  ksys_ioctl+0x60/0x90
Dec 13 16:35:07 kaveri kernel: [   52.604697]  __x64_sys_ioctl+0x6f/0xb0
Dec 13 16:35:07 kaveri kernel: [   52.604701]  ? lockdep_hardirqs_on+0x37=
c/0x560
Dec 13 16:35:07 kaveri kernel: [   52.604707]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.604713]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.604717] RIP: 0033:0x7fc8b94e07e7
Dec 13 16:35:07 kaveri kernel: [   52.604721] Code: 00 00 90 48 8b 05 a9 =
a6 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 79 =
a6 0c 00 f7 d8 64 89 01 48
Dec 13 16:35:07 kaveri kernel: [   52.604725] RSP: 002b:00007ffd15f91888 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Dec 13 16:35:07 kaveri kernel: [   52.604729] RAX: ffffffffffffffda RBX: =
000055b030265b60 RCX: 00007fc8b94e07e7
Dec 13 16:35:07 kaveri kernel: [   52.604732] RDX: 00007ffd15f918c0 RSI: =
00000000c01c64a3 RDI: 000000000000000d
Dec 13 16:35:07 kaveri kernel: [   52.604736] RBP: 00007ffd15f918b0 R08: =
0000000000000080 R09: 000055b0307f8940
Dec 13 16:35:07 kaveri kernel: [   52.604739] R10: 00007fc8ba86b560 R11: =
0000000000000246 R12: 00007ffd15f918c0
Dec 13 16:35:07 kaveri kernel: [   52.604742] R13: 00000000c01c64a3 R14: =
000000000000000d R15: 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.604755] irq event stamp: 626894
Dec 13 16:35:07 kaveri kernel: [   52.604760] hardirqs last  enabled at (=
626893): [<ffffffff8d3817ec>] _raw_spin_unlock_irqrestore+0x3c/0x50
Dec 13 16:35:07 kaveri kernel: [   52.604764] hardirqs last disabled at (=
626894): [<ffffffff8bc03552>] trace_hardirqs_off_thunk+0x1a/0x1c
Dec 13 16:35:07 kaveri kernel: [   52.604769] softirqs last  enabled at (=
626872): [<ffffffff8d6005d4>] __do_softirq+0x5d4/0x86e
Dec 13 16:35:07 kaveri kernel: [   52.604774] softirqs last disabled at (=
626861): [<ffffffff8bd3afc2>] irq_exit+0x1a2/0x1d0
Dec 13 16:35:07 kaveri kernel: [   52.604777] ---[ end trace 2ad62cfc2ba4=
843c ]---
Dec 13 16:35:07 kaveri kernel: [   52.604785] amdgpu 0000:23:00.0: 000000=
000f2d9ca9 unpin not necessary
Dec 13 16:35:07 kaveri kernel: [   52.788450] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Dec 13 16:35:07 kaveri kernel: [   52.788551] BUG: KASAN: use-after-free =
in drm_gem_object_release_handle+0x1a8/0x1d0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.788556] Read of size 8 at addr ffff=
8883c445e9f0 by task Xorg/2010
Dec 13 16:35:07 kaveri kernel: [   52.788559]=20
Dec 13 16:35:07 kaveri kernel: [   52.788565] CPU: 13 PID: 2010 Comm: Xor=
g Tainted: G        W  OE     4.20.0-rc3+ #118
Dec 13 16:35:07 kaveri kernel: [   52.788569] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 13 16:35:07 kaveri kernel: [   52.788573] Call Trace:
Dec 13 16:35:07 kaveri kernel: [   52.788581]  dump_stack+0x7c/0xc0
Dec 13 16:35:07 kaveri kernel: [   52.788588]  print_address_description+=
0x65/0x22e
Dec 13 16:35:07 kaveri kernel: [   52.788606]  ? drm_gem_object_release_h=
andle+0x1a8/0x1d0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.788611]  kasan_report.cold.5+0x241/=
0x306
Dec 13 16:35:07 kaveri kernel: [   52.788630]  ? drm_gem_object_handle_pu=
t_unlocked+0x260/0x260 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.788647]  drm_gem_object_release_han=
dle+0x1a8/0x1d0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.788665]  ? drm_gem_object_handle_pu=
t_unlocked+0x260/0x260 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.788670]  idr_for_each+0xef/0x1d0
Dec 13 16:35:07 kaveri kernel: [   52.788676]  ? idr_find+0x50/0x50
Dec 13 16:35:07 kaveri kernel: [   52.788684]  ? mark_held_locks+0xc1/0x1=
40
Dec 13 16:35:07 kaveri kernel: [   52.788691]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Dec 13 16:35:07 kaveri kernel: [   52.788712]  drm_gem_release+0x1c/0x30 =
[drm]
Dec 13 16:35:07 kaveri kernel: [   52.788729]  drm_file_free.part.3+0x96b=
/0xe30 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.788752]  drm_release+0x231/0x3f0 [d=
rm]
Dec 13 16:35:07 kaveri kernel: [   52.788758]  ? fsnotify_first_mark+0x13=
0/0x130
Dec 13 16:35:07 kaveri kernel: [   52.788776]  ? drm_lastclose+0x2c0/0x2c=
0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.788782]  ? security_file_free+0x3f/=
0x70
Dec 13 16:35:07 kaveri kernel: [   52.788791]  __fput+0x235/0x710
Dec 13 16:35:07 kaveri kernel: [   52.788800]  task_work_run+0x10e/0x180
Dec 13 16:35:07 kaveri kernel: [   52.788810]  do_exit+0x952/0x2880
Dec 13 16:35:07 kaveri kernel: [   52.788820]  ? mm_update_next_owner+0x6=
00/0x600
Dec 13 16:35:07 kaveri kernel: [   52.788826]  ? __do_page_fault+0x472/0x=
aa0
Dec 13 16:35:07 kaveri kernel: [   52.788834]  ? lock_downgrade+0x5d0/0x5=
d0
Dec 13 16:35:07 kaveri kernel: [   52.788839]  ? handle_mm_fault+0x4db/0x=
750
Dec 13 16:35:07 kaveri kernel: [   52.788850]  do_group_exit+0xf0/0x2e0
Dec 13 16:35:07 kaveri kernel: [   52.788857]  __x64_sys_exit_group+0x3a/=
0x50
Dec 13 16:35:07 kaveri kernel: [   52.788862]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.788868]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.788872] RIP: 0033:0x7fc8b94b6d76
Dec 13 16:35:07 kaveri kernel: [   52.788880] Code: Bad RIP value.
Dec 13 16:35:07 kaveri kernel: [   52.788883] RSP: 002b:00007ffd15f91bb8 =
EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec 13 16:35:07 kaveri kernel: [   52.788888] RAX: ffffffffffffffda RBX: =
00007fc8b95a7760 RCX: 00007fc8b94b6d76
Dec 13 16:35:07 kaveri kernel: [   52.788892] RDX: 0000000000000000 RSI: =
000000000000003c RDI: 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.788895] RBP: 0000000000000000 R08: =
00000000000000e7 R09: fffffffffffffd58
Dec 13 16:35:07 kaveri kernel: [   52.788899] R10: 0000000000000007 R11: =
0000000000000246 R12: 00007fc8b95a7760
Dec 13 16:35:07 kaveri kernel: [   52.788902] R13: 00000000000004b3 R14: =
00007fc8b95b0428 R15: 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.788914]=20
Dec 13 16:35:07 kaveri kernel: [   52.788918] Allocated by task 2010:
Dec 13 16:35:07 kaveri kernel: [   52.788922]  kasan_kmalloc+0xbf/0xe0
Dec 13 16:35:07 kaveri kernel: [   52.788926]  kmem_cache_alloc_trace+0x1=
2d/0x290
Dec 13 16:35:07 kaveri kernel: [   52.788998]  amdgpu_bo_do_create+0x25b/=
0x1050 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.789066]  amdgpu_bo_create+0xa3/0xa0=
0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.789134]  amdgpu_gem_object_create+0=
x140/0x240 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.789202]  amdgpu_gem_create_ioctl+0x=
4a8/0x8f0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.789219]  drm_ioctl_kernel+0x1c6/0x2=
60 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.789236]  drm_ioctl+0x403/0x850 [drm=
]
Dec 13 16:35:07 kaveri kernel: [   52.789306]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.789311]  do_vfs_ioctl+0x193/0xfd0
Dec 13 16:35:07 kaveri kernel: [   52.789315]  ksys_ioctl+0x60/0x90
Dec 13 16:35:07 kaveri kernel: [   52.789319]  __x64_sys_ioctl+0x6f/0xb0
Dec 13 16:35:07 kaveri kernel: [   52.789323]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.789327]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.789330]=20
Dec 13 16:35:07 kaveri kernel: [   52.789333] Freed by task 2010:
Dec 13 16:35:07 kaveri kernel: [   52.789337]  __kasan_slab_free+0x125/0x=
170
Dec 13 16:35:07 kaveri kernel: [   52.789341]  kfree+0xe2/0x290
Dec 13 16:35:07 kaveri kernel: [   52.789349]  ttm_bo_release_list+0x3f3/=
0x560 [ttm]
Dec 13 16:35:07 kaveri kernel: [   52.789357]  ttm_bo_vm_close+0x34/0x70 =
[ttm]
Dec 13 16:35:07 kaveri kernel: [   52.789361]  remove_vma+0x92/0x130
Dec 13 16:35:07 kaveri kernel: [   52.789365]  exit_mmap+0x292/0x400
Dec 13 16:35:07 kaveri kernel: [   52.789369]  mmput+0xb2/0x390
Dec 13 16:35:07 kaveri kernel: [   52.789373]  do_exit+0x8c4/0x2880
Dec 13 16:35:07 kaveri kernel: [   52.789377]  do_group_exit+0xf0/0x2e0
Dec 13 16:35:07 kaveri kernel: [   52.789381]  __x64_sys_exit_group+0x3a/=
0x50
Dec 13 16:35:07 kaveri kernel: [   52.789385]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.789389]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.789392]=20
Dec 13 16:35:07 kaveri kernel: [   52.789395] The buggy address belongs t=
o the object at ffff8883c445e600
Dec 13 16:35:07 kaveri kernel: [   52.789395]  which belongs to the cache=
 kmalloc-2k of size 2048
Dec 13 16:35:07 kaveri kernel: [   52.789401] The buggy address is locate=
d 1008 bytes inside of
Dec 13 16:35:07 kaveri kernel: [   52.789401]  2048-byte region [ffff8883=
c445e600, ffff8883c445ee00)
Dec 13 16:35:07 kaveri kernel: [   52.789404] The buggy address belongs t=
o the page:
Dec 13 16:35:07 kaveri kernel: [   52.789409] page:ffffea000f111600 count=
:1 mapcount:0 mapping:ffff8883ed80e800 index:0xffff8883c445f700 compound_=
mapcount: 0
Dec 13 16:35:07 kaveri kernel: [   52.789415] flags: 0x17fffc000010200(sl=
ab|head)
Dec 13 16:35:07 kaveri kernel: [   52.789420] raw: 017fffc000010200 ffffe=
a000efef808 ffffea000eb08608 ffff8883ed80e800
Dec 13 16:35:07 kaveri kernel: [   52.789425] raw: ffff8883c445f700 00000=
000000f000e 00000001ffffffff 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.789428] page dumped because: kasan:=
 bad access detected
Dec 13 16:35:07 kaveri kernel: [   52.789431]=20
Dec 13 16:35:07 kaveri kernel: [   52.789434] Memory state around the bug=
gy address:
Dec 13 16:35:07 kaveri kernel: [   52.789438]  ffff8883c445e880: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 13 16:35:07 kaveri kernel: [   52.789442]  ffff8883c445e900: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 13 16:35:07 kaveri kernel: [   52.789446] >ffff8883c445e980: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 13 16:35:07 kaveri kernel: [   52.789449]                            =
                                  ^
Dec 13 16:35:07 kaveri kernel: [   52.789453]  ffff8883c445ea00: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 13 16:35:07 kaveri kernel: [   52.789457]  ffff8883c445ea80: fb fb fb=
 fb fb fb fb fb fb fb fb fb fb fb fb fb
Dec 13 16:35:07 kaveri kernel: [   52.789460] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Dec 13 16:35:07 kaveri kernel: [   52.789463] Disabling lock debugging du=
e to kernel taint
Dec 13 16:35:07 kaveri kernel: [   52.789487] ------------[ cut here ]---=
---------
Dec 13 16:35:07 kaveri kernel: [   52.789490] refcount_t: increment on 0;=
 use-after-free.
Dec 13 16:35:07 kaveri kernel: [   52.789504] WARNING: CPU: 13 PID: 2010 =
at lib/refcount.c:153 refcount_inc_checked+0x26/0x30
Dec 13 16:35:07 kaveri kernel: [   52.789506] Modules linked in: fuse(E) =
ipt_MASQUERADE(E) nf_conntrack_netlink(E) xfrm_user(E) xfrm_algo(E) nft_c=
ounter(E) nft_chain_nat_ipv4(E) nf_nat_ipv4(E) xt_addrtype(E) nft_compat(=
E) nf_tables(E) nfnetlink(E) xt_conntrack(E) nf_nat(E) nf_conntrack(E) nf=
_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) br_netfilter(E) bridge(E) =
stp(E) llc(E) overlay(E) lz4(E) lz4_compress(E) cpufreq_powersave(E) cpuf=
req_userspace(E) cpufreq_conservative(E) binfmt_misc(E) amdgpu(OE) nls_as=
cii(E) nls_cp437(E) vfat(E) fat(E) chash(OE) gpu_sched(OE) edac_mce_amd(E=
) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_i=
ntel(E) radeon(OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_=
hda_codec_hdmi(E) ttm(OE) wmi_bmof(E) snd_hda_intel(E) drm_kms_helper(OE)=
 aesni_intel(E) snd_hda_codec(E) efi_pstore(E) aes_x86_64(E) snd_hda_core=
(E) crypto_simd(E) snd_hwdep(E) r8169(E) cryptd(E) drm(OE) glue_helper(E)=
 pcspkr(E) efivars(E) sg(E) k10temp(E) snd_pcm(E) i2c_algo_bit(E) libphy(=
E)
Dec 13 16:35:07 kaveri kernel: [   52.789543]  fb_sys_fops(E) syscopyarea=
(E) ccp(E) snd_timer(E) sysfillrect(E) sp5100_tco(E) sysimgblt(E) snd(E) =
soundcore(E) rng_core(E) i2c_piix4(E) wmi(E) pcc_cpufreq(E) button(E) acp=
i_cpufreq(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efiva=
rfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc1=
6(E) mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E)=
 multipath(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhi=
d(E) hid(E) ahci(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_i=
ntel(E) scsi_mod(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Dec 13 16:35:07 kaveri kernel: [   52.789578] CPU: 13 PID: 2010 Comm: Xor=
g Tainted: G    B   W  OE     4.20.0-rc3+ #118
Dec 13 16:35:07 kaveri kernel: [   52.789581] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 13 16:35:07 kaveri kernel: [   52.789585] RIP: 0010:refcount_inc_chec=
ked+0x26/0x30
Dec 13 16:35:07 kaveri kernel: [   52.789588] Code: 00 00 00 00 e8 ab fe =
ff ff 84 c0 74 01 c3 80 3d 20 40 b2 01 00 75 f6 48 c7 c7 00 c8 9e 8d c6 0=
5 10 40 b2 01 01 e8 d5 49 57 ff <0f> 0b c3 0f 1f 80 00 00 00 00 41 56 41 =
55 41 54 41 89 fc 55 48 bd
Dec 13 16:35:07 kaveri kernel: [   52.789591] RSP: 0018:ffff8883d403f788 =
EFLAGS: 00010282
Dec 13 16:35:07 kaveri kernel: [   52.789594] RAX: 0000000000000000 RBX: =
ffff8883c445e650 RCX: ffffffff8c0634c0
Dec 13 16:35:07 kaveri kernel: [   52.789597] RDX: 0000000000000000 RSI: =
0000000000000008 RDI: ffff8883ee15ea40
Dec 13 16:35:07 kaveri kernel: [   52.789600] RBP: ffff8883b1de2e78 R08: =
ffffed107dc2bd49 R09: ffffed107dc2bd48
Dec 13 16:35:07 kaveri kernel: [   52.789602] R10: ffffed107dc2bd48 R11: =
ffff8883ee15ea47 R12: ffff8883b1de2bd8
Dec 13 16:35:07 kaveri kernel: [   52.789605] R13: ffff8883c445e828 R14: =
ffff8883c445e67c R15: ffff8883b1de2fa0
Dec 13 16:35:07 kaveri kernel: [   52.789608] FS:  00007fc8b8929940(0000)=
 GS:ffff8883ee140000(0000) knlGS:0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.789611] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Dec 13 16:35:07 kaveri kernel: [   52.789614] CR2: 00007fc8b94b6d4c CR3: =
00000003b7e14000 CR4: 00000000003406e0
Dec 13 16:35:07 kaveri kernel: [   52.789616] Call Trace:
Dec 13 16:35:07 kaveri kernel: [   52.789624]  ttm_bo_add_to_lru+0x242/0x=
570 [ttm]
Dec 13 16:35:07 kaveri kernel: [   52.789633]  ttm_eu_backoff_reservation=
+0x123/0x390 [ttm]
Dec 13 16:35:07 kaveri kernel: [   52.789707]  amdgpu_gem_object_close+0x=
22b/0x410 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.789781]  ? amdgpu_gem_object_open+0=
x5e0/0x5e0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.789785]  ? do_raw_spin_unlock+0x54/=
0x220
Dec 13 16:35:07 kaveri kernel: [   52.789790]  ? console_unlock+0x45f/0xa=
40
Dec 13 16:35:07 kaveri kernel: [   52.789794]  ? vprintk_emit+0x203/0x3d0=

Dec 13 16:35:07 kaveri kernel: [   52.789799]  ? irq_work_claim+0x40/0x70=

Dec 13 16:35:07 kaveri kernel: [   52.789802]  ? irq_work_queue+0x9/0x90
Dec 13 16:35:07 kaveri kernel: [   52.789806]  ? wake_up_klogd+0x30/0x40
Dec 13 16:35:07 kaveri kernel: [   52.789809]  ? vprintk_emit+0x211/0x3d0=

Dec 13 16:35:07 kaveri kernel: [   52.789812]  ? wake_up_klogd+0x30/0x40
Dec 13 16:35:07 kaveri kernel: [   52.789830]  ? drm_gem_object_release_h=
andle+0x1a8/0x1d0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.789835]  ? print_shadow_for_address=
+0xbf/0x11c
Dec 13 16:35:07 kaveri kernel: [   52.789840]  ? kasan_end_report+0x33/0x=
4e
Dec 13 16:35:07 kaveri kernel: [   52.789842]  ? kasan_report.cold.5+0x75=
/0x306
Dec 13 16:35:07 kaveri kernel: [   52.789857]  drm_gem_object_release_han=
dle+0x94/0x1d0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.789870]  ? drm_gem_object_handle_pu=
t_unlocked+0x260/0x260 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.789874]  idr_for_each+0xef/0x1d0
Dec 13 16:35:07 kaveri kernel: [   52.789877]  ? idr_find+0x50/0x50
Dec 13 16:35:07 kaveri kernel: [   52.789881]  ? mark_held_locks+0xc1/0x1=
40
Dec 13 16:35:07 kaveri kernel: [   52.789884]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Dec 13 16:35:07 kaveri kernel: [   52.789899]  drm_gem_release+0x1c/0x30 =
[drm]
Dec 13 16:35:07 kaveri kernel: [   52.789912]  drm_file_free.part.3+0x96b=
/0xe30 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.789928]  drm_release+0x231/0x3f0 [d=
rm]
Dec 13 16:35:07 kaveri kernel: [   52.789931]  ? fsnotify_first_mark+0x13=
0/0x130
Dec 13 16:35:07 kaveri kernel: [   52.789945]  ? drm_lastclose+0x2c0/0x2c=
0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.789948]  ? security_file_free+0x3f/=
0x70
Dec 13 16:35:07 kaveri kernel: [   52.789953]  __fput+0x235/0x710
Dec 13 16:35:07 kaveri kernel: [   52.789957]  task_work_run+0x10e/0x180
Dec 13 16:35:07 kaveri kernel: [   52.789962]  do_exit+0x952/0x2880
Dec 13 16:35:07 kaveri kernel: [   52.789967]  ? mm_update_next_owner+0x6=
00/0x600
Dec 13 16:35:07 kaveri kernel: [   52.789970]  ? __do_page_fault+0x472/0x=
aa0
Dec 13 16:35:07 kaveri kernel: [   52.789974]  ? lock_downgrade+0x5d0/0x5=
d0
Dec 13 16:35:07 kaveri kernel: [   52.789977]  ? handle_mm_fault+0x4db/0x=
750
Dec 13 16:35:07 kaveri kernel: [   52.789982]  do_group_exit+0xf0/0x2e0
Dec 13 16:35:07 kaveri kernel: [   52.789986]  __x64_sys_exit_group+0x3a/=
0x50
Dec 13 16:35:07 kaveri kernel: [   52.789989]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.789993]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.789995] RIP: 0033:0x7fc8b94b6d76
Dec 13 16:35:07 kaveri kernel: [   52.789998] Code: Bad RIP value.
Dec 13 16:35:07 kaveri kernel: [   52.790000] RSP: 002b:00007ffd15f91bb8 =
EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec 13 16:35:07 kaveri kernel: [   52.790003] RAX: ffffffffffffffda RBX: =
00007fc8b95a7760 RCX: 00007fc8b94b6d76
Dec 13 16:35:07 kaveri kernel: [   52.790005] RDX: 0000000000000000 RSI: =
000000000000003c RDI: 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.790007] RBP: 0000000000000000 R08: =
00000000000000e7 R09: fffffffffffffd58
Dec 13 16:35:07 kaveri kernel: [   52.790009] R10: 0000000000000007 R11: =
0000000000000246 R12: 00007fc8b95a7760
Dec 13 16:35:07 kaveri kernel: [   52.790011] R13: 00000000000004b3 R14: =
00007fc8b95b0428 R15: 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.790017] irq event stamp: 653260
Dec 13 16:35:07 kaveri kernel: [   52.790020] hardirqs last  enabled at (=
653259): [<ffffffff8c292cb7>] quarantine_put+0xb7/0x150
Dec 13 16:35:07 kaveri kernel: [   52.790023] hardirqs last disabled at (=
653260): [<ffffffff8d3815e2>] _raw_spin_lock_irqsave+0x12/0x40
Dec 13 16:35:07 kaveri kernel: [   52.790026] softirqs last  enabled at (=
652688): [<ffffffff8d6005d4>] __do_softirq+0x5d4/0x86e
Dec 13 16:35:07 kaveri kernel: [   52.790029] softirqs last disabled at (=
652681): [<ffffffff8bd3afc2>] irq_exit+0x1a2/0x1d0
Dec 13 16:35:07 kaveri kernel: [   52.790031] ---[ end trace 2ad62cfc2ba4=
843d ]---
Dec 13 16:35:07 kaveri kernel: [   52.790038] ------------[ cut here ]---=
---------
Dec 13 16:35:07 kaveri kernel: [   52.790040] refcount_t: underflow; use-=
after-free.
Dec 13 16:35:07 kaveri kernel: [   52.790049] WARNING: CPU: 13 PID: 2010 =
at lib/refcount.c:187 refcount_sub_and_test_checked+0x147/0x160
Dec 13 16:35:07 kaveri kernel: [   52.790051] Modules linked in: fuse(E) =
ipt_MASQUERADE(E) nf_conntrack_netlink(E) xfrm_user(E) xfrm_algo(E) nft_c=
ounter(E) nft_chain_nat_ipv4(E) nf_nat_ipv4(E) xt_addrtype(E) nft_compat(=
E) nf_tables(E) nfnetlink(E) xt_conntrack(E) nf_nat(E) nf_conntrack(E) nf=
_defrag_ipv6(E) nf_defrag_ipv4(E) libcrc32c(E) br_netfilter(E) bridge(E) =
stp(E) llc(E) overlay(E) lz4(E) lz4_compress(E) cpufreq_powersave(E) cpuf=
req_userspace(E) cpufreq_conservative(E) binfmt_misc(E) amdgpu(OE) nls_as=
cii(E) nls_cp437(E) vfat(E) fat(E) chash(OE) gpu_sched(OE) edac_mce_amd(E=
) kvm(E) irqbypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_i=
ntel(E) radeon(OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_=
hda_codec_hdmi(E) ttm(OE) wmi_bmof(E) snd_hda_intel(E) drm_kms_helper(OE)=
 aesni_intel(E) snd_hda_codec(E) efi_pstore(E) aes_x86_64(E) snd_hda_core=
(E) crypto_simd(E) snd_hwdep(E) r8169(E) cryptd(E) drm(OE) glue_helper(E)=
 pcspkr(E) efivars(E) sg(E) k10temp(E) snd_pcm(E) i2c_algo_bit(E) libphy(=
E)
Dec 13 16:35:07 kaveri kernel: [   52.790077]  fb_sys_fops(E) syscopyarea=
(E) ccp(E) snd_timer(E) sysfillrect(E) sp5100_tco(E) sysimgblt(E) snd(E) =
soundcore(E) rng_core(E) i2c_piix4(E) wmi(E) pcc_cpufreq(E) button(E) acp=
i_cpufreq(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efiva=
rfs(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) crc32c_generic(E) crc1=
6(E) mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E)=
 multipath(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhi=
d(E) hid(E) ahci(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_i=
ntel(E) scsi_mod(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Dec 13 16:35:07 kaveri kernel: [   52.790102] CPU: 13 PID: 2010 Comm: Xor=
g Tainted: G    B   W  OE     4.20.0-rc3+ #118
Dec 13 16:35:07 kaveri kernel: [   52.790104] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 13 16:35:07 kaveri kernel: [   52.790107] RIP: 0010:refcount_sub_and_=
test_checked+0x147/0x160
Dec 13 16:35:07 kaveri kernel: [   52.790110] Code: c2 44 29 e0 89 c5 85 =
d2 74 8a 80 3d d2 3e b2 01 00 74 04 31 c0 eb aa 48 c7 c7 60 c8 9e 8d c6 0=
5 be 3e b2 01 01 e8 84 48 57 ff <0f> 0b 31 c0 eb 91 48 89 df e8 8b 0e ae =
ff e9 34 ff ff ff e8 61 42
Dec 13 16:35:07 kaveri kernel: [   52.790112] RSP: 0018:ffff8883d403f8f0 =
EFLAGS: 00010282
Dec 13 16:35:07 kaveri kernel: [   52.790115] RAX: 0000000000000000 RBX: =
ffff8883c445e678 RCX: ffffffff8c0634c0
Dec 13 16:35:07 kaveri kernel: [   52.790117] RDX: 0000000000000000 RSI: =
0000000000000008 RDI: ffff8883ee15ea40
Dec 13 16:35:07 kaveri kernel: [   52.790119] RBP: 00000000ffffffff R08: =
ffffed107dc2bd49 R09: ffffed107dc2bd48
Dec 13 16:35:07 kaveri kernel: [   52.790121] R10: ffffed107dc2bd48 R11: =
ffff8883ee15ea47 R12: 0000000000000001
Dec 13 16:35:07 kaveri kernel: [   52.790123] R13: ffff8883d403f918 R14: =
1ffff1107a807f1f R15: ffff8883c445e650
Dec 13 16:35:07 kaveri kernel: [   52.790126] FS:  00007fc8b8929940(0000)=
 GS:ffff8883ee140000(0000) knlGS:0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.790128] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Dec 13 16:35:07 kaveri kernel: [   52.790130] CR2: 00007fc8b94b6d4c CR3: =
00000003b7e14000 CR4: 00000000003406e0
Dec 13 16:35:07 kaveri kernel: [   52.790132] Call Trace:
Dec 13 16:35:07 kaveri kernel: [   52.790146]  ? drm_gem_object_release_h=
andle+0x146/0x1d0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.790149]  ? refcount_inc_checked+0x3=
0/0x30
Dec 13 16:35:07 kaveri kernel: [   52.790153]  ? __mutex_unlock_slowpath+=
0xe1/0x680
Dec 13 16:35:07 kaveri kernel: [   52.790159]  ttm_bo_put+0x1f/0xca0 [ttm=
]
Dec 13 16:35:07 kaveri kernel: [   52.790229]  ? amdgpu_mn_unregister+0x2=
3f/0x310 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.790288]  amdgpu_bo_unref+0x31/0x70 =
[amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.790346]  amdgpu_gem_object_free+0x7=
2/0xa0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.790404]  ? amdgpu_debugfs_gem_info+=
0x310/0x310 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.790418]  ? drm_gem_object_free+0x16=
c/0x1b0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.790432]  drm_gem_object_release_han=
dle+0x12a/0x1d0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.790446]  ? drm_gem_object_handle_pu=
t_unlocked+0x260/0x260 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.790449]  idr_for_each+0xef/0x1d0
Dec 13 16:35:07 kaveri kernel: [   52.790453]  ? idr_find+0x50/0x50
Dec 13 16:35:07 kaveri kernel: [   52.790457]  ? mark_held_locks+0xc1/0x1=
40
Dec 13 16:35:07 kaveri kernel: [   52.790460]  ? _raw_spin_unlock_irqrest=
ore+0x3c/0x50
Dec 13 16:35:07 kaveri kernel: [   52.790475]  drm_gem_release+0x1c/0x30 =
[drm]
Dec 13 16:35:07 kaveri kernel: [   52.790488]  drm_file_free.part.3+0x96b=
/0xe30 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.790504]  drm_release+0x231/0x3f0 [d=
rm]
Dec 13 16:35:07 kaveri kernel: [   52.790507]  ? fsnotify_first_mark+0x13=
0/0x130
Dec 13 16:35:07 kaveri kernel: [   52.790520]  ? drm_lastclose+0x2c0/0x2c=
0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.790524]  ? security_file_free+0x3f/=
0x70
Dec 13 16:35:07 kaveri kernel: [   52.790528]  __fput+0x235/0x710
Dec 13 16:35:07 kaveri kernel: [   52.790533]  task_work_run+0x10e/0x180
Dec 13 16:35:07 kaveri kernel: [   52.790537]  do_exit+0x952/0x2880
Dec 13 16:35:07 kaveri kernel: [   52.790542]  ? mm_update_next_owner+0x6=
00/0x600
Dec 13 16:35:07 kaveri kernel: [   52.790545]  ? __do_page_fault+0x472/0x=
aa0
Dec 13 16:35:07 kaveri kernel: [   52.790550]  ? lock_downgrade+0x5d0/0x5=
d0
Dec 13 16:35:07 kaveri kernel: [   52.790553]  ? handle_mm_fault+0x4db/0x=
750
Dec 13 16:35:07 kaveri kernel: [   52.790558]  do_group_exit+0xf0/0x2e0
Dec 13 16:35:07 kaveri kernel: [   52.790562]  __x64_sys_exit_group+0x3a/=
0x50
Dec 13 16:35:07 kaveri kernel: [   52.790565]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.790568]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.790571] RIP: 0033:0x7fc8b94b6d76
Dec 13 16:35:07 kaveri kernel: [   52.790573] Code: Bad RIP value.
Dec 13 16:35:07 kaveri kernel: [   52.790575] RSP: 002b:00007ffd15f91bb8 =
EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec 13 16:35:07 kaveri kernel: [   52.790578] RAX: ffffffffffffffda RBX: =
00007fc8b95a7760 RCX: 00007fc8b94b6d76
Dec 13 16:35:07 kaveri kernel: [   52.790580] RDX: 0000000000000000 RSI: =
000000000000003c RDI: 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.790582] RBP: 0000000000000000 R08: =
00000000000000e7 R09: fffffffffffffd58
Dec 13 16:35:07 kaveri kernel: [   52.790584] R10: 0000000000000007 R11: =
0000000000000246 R12: 00007fc8b95a7760
Dec 13 16:35:07 kaveri kernel: [   52.790586] R13: 00000000000004b3 R14: =
00007fc8b95b0428 R15: 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.790592] irq event stamp: 653260
Dec 13 16:35:07 kaveri kernel: [   52.790595] hardirqs last  enabled at (=
653259): [<ffffffff8c292cb7>] quarantine_put+0xb7/0x150
Dec 13 16:35:07 kaveri kernel: [   52.790598] hardirqs last disabled at (=
653260): [<ffffffff8d3815e2>] _raw_spin_lock_irqsave+0x12/0x40
Dec 13 16:35:07 kaveri kernel: [   52.790601] softirqs last  enabled at (=
652688): [<ffffffff8d6005d4>] __do_softirq+0x5d4/0x86e
Dec 13 16:35:07 kaveri kernel: [   52.790603] softirqs last disabled at (=
652681): [<ffffffff8bd3afc2>] irq_exit+0x1a2/0x1d0
Dec 13 16:35:07 kaveri kernel: [   52.790605] ---[ end trace 2ad62cfc2ba4=
843e ]---
Dec 13 16:35:07 kaveri kernel: [   52.815205] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
Dec 13 16:35:07 kaveri kernel: [   52.815217] BUG: KASAN: double-free or =
invalid-free in rcu_process_callbacks+0x8fc/0xf40
Dec 13 16:35:07 kaveri kernel: [   52.815220]=20
Dec 13 16:35:07 kaveri kernel: [   52.815226] CPU: 13 PID: 0 Comm: swappe=
r/13 Tainted: G    B   W  OE     4.20.0-rc3+ #118
Dec 13 16:35:07 kaveri kernel: [   52.815230] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 13 16:35:07 kaveri kernel: [   52.815233] Call Trace:
Dec 13 16:35:07 kaveri kernel: [   52.815236]  <IRQ>
Dec 13 16:35:07 kaveri kernel: [   52.815243]  dump_stack+0x7c/0xc0
Dec 13 16:35:07 kaveri kernel: [   52.815249]  print_address_description+=
0x65/0x22e
Dec 13 16:35:07 kaveri kernel: [   52.815253]  ? rcu_process_callbacks+0x=
8fc/0xf40
Dec 13 16:35:07 kaveri kernel: [   52.815258]  kasan_report_invalid_free+=
0x65/0xa0
Dec 13 16:35:07 kaveri kernel: [   52.815263]  ? rcu_process_callbacks+0x=
8fc/0xf40
Dec 13 16:35:07 kaveri kernel: [   52.815267]  __kasan_slab_free+0x157/0x=
170
Dec 13 16:35:07 kaveri kernel: [   52.815271]  ? rcu_process_callbacks+0x=
8fc/0xf40
Dec 13 16:35:07 kaveri kernel: [   52.815275]  kfree+0xe2/0x290
Dec 13 16:35:07 kaveri kernel: [   52.815280]  rcu_process_callbacks+0x8f=
c/0xf40
Dec 13 16:35:07 kaveri kernel: [   52.815286]  ? rcu_note_context_switch+=
0x380/0x380
Dec 13 16:35:07 kaveri kernel: [   52.815293]  ? run_rebalance_domains+0x=
1f8/0x2b0
Dec 13 16:35:07 kaveri kernel: [   52.815299]  __do_softirq+0x20f/0x86e
Dec 13 16:35:07 kaveri kernel: [   52.815307]  irq_exit+0x1a2/0x1d0
Dec 13 16:35:07 kaveri kernel: [   52.815311]  smp_apic_timer_interrupt+0=
xfe/0x450
Dec 13 16:35:07 kaveri kernel: [   52.815316]  apic_timer_interrupt+0xf/0=
x20
Dec 13 16:35:07 kaveri kernel: [   52.815319]  </IRQ>
Dec 13 16:35:07 kaveri kernel: [   52.815325] RIP: 0010:cpuidle_enter_sta=
te+0x104/0x7c0
Dec 13 16:35:07 kaveri kernel: [   52.815329] Code: 00 31 ff e8 7e bf 03 =
ff 80 7c 24 0c 00 74 12 9c 58 f6 c4 02 0f 85 39 05 00 00 31 ff e8 b5 dd 1=
6 ff e8 80 02 28 ff fb 45 85 e4 <0f> 88 a8 04 00 00 48 b8 ff ff ff ff f3 =
01 00 00 48 2b 2c 24 48 39
Dec 13 16:35:07 kaveri kernel: [   52.815333] RSP: 0018:ffff8883eb8ffd80 =
EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
Dec 13 16:35:07 kaveri kernel: [   52.815338] RAX: 0000000000000007 RBX: =
ffff8883e51d3f00 RCX: 000000000000001f
Dec 13 16:35:07 kaveri kernel: [   52.815341] RDX: 0000000000000000 RSI: =
000000002aaaac88 RDI: ffffffff8e2f9d74
Dec 13 16:35:07 kaveri kernel: [   52.815345] RBP: 0000000c4c069a24 R08: =
0000000000000002 R09: 000000000002a500
Dec 13 16:35:07 kaveri kernel: [   52.815348] R10: 00000033a422e73c R11: =
ffff8883ee16bc7b R12: 0000000000000002
Dec 13 16:35:07 kaveri kernel: [   52.815351] R13: 0000000000000002 R14: =
0000000000000002 R15: 00000000000000c0
Dec 13 16:35:07 kaveri kernel: [   52.815363]  do_idle+0x325/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.815368]  ? arch_cpu_idle_exit+0x40/=
0x40
Dec 13 16:35:07 kaveri kernel: [   52.815376]  cpu_startup_entry+0x19/0x2=
0
Dec 13 16:35:07 kaveri kernel: [   52.815381]  start_secondary+0x3ae/0x4c=
0
Dec 13 16:35:07 kaveri kernel: [   52.815386]  ? set_cpu_sibling_map+0x17=
30/0x1730
Dec 13 16:35:07 kaveri kernel: [   52.815396]  secondary_startup_64+0xa4/=
0xb0
Dec 13 16:35:07 kaveri kernel: [   52.815403]=20
Dec 13 16:35:07 kaveri kernel: [   52.815406] Allocated by task 2010:
Dec 13 16:35:07 kaveri kernel: [   52.815411]  kasan_kmalloc+0xbf/0xe0
Dec 13 16:35:07 kaveri kernel: [   52.815415]  kmem_cache_alloc_trace+0x1=
2d/0x290
Dec 13 16:35:07 kaveri kernel: [   52.815420]  reservation_object_reserve=
_shared+0xdd/0x740
Dec 13 16:35:07 kaveri kernel: [   52.815429]  ttm_bo_mem_space+0x8b/0xf2=
0 [ttm]
Dec 13 16:35:07 kaveri kernel: [   52.815437]  ttm_bo_validate+0x2df/0x4a=
0 [ttm]
Dec 13 16:35:07 kaveri kernel: [   52.815521]  amdgpu_bo_pin_restricted+0=
x39f/0x840 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.815627]  dm_plane_helper_prepare_fb=
+0x1d9/0xcf0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.815640]  drm_atomic_helper_prepare_=
planes+0x12e/0x500 [drm_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.815652]  drm_atomic_helper_commit+0=
x4a/0x240 [drm_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.815663]  drm_atomic_helper_update_p=
lane+0x2a0/0x350 [drm_kms_helper]
Dec 13 16:35:07 kaveri kernel: [   52.815685]  drm_mode_cursor_universal+=
0x3e6/0xb30 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.815706]  drm_mode_cursor_common+0x4=
d0/0x8c0 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.815725]  drm_ioctl_kernel+0x1c6/0x2=
60 [drm]
Dec 13 16:35:07 kaveri kernel: [   52.815744]  drm_ioctl+0x403/0x850 [drm=
]
Dec 13 16:35:07 kaveri kernel: [   52.815825]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Dec 13 16:35:07 kaveri kernel: [   52.815829]  do_vfs_ioctl+0x193/0xfd0
Dec 13 16:35:07 kaveri kernel: [   52.815833]  ksys_ioctl+0x60/0x90
Dec 13 16:35:07 kaveri kernel: [   52.815836]  __x64_sys_ioctl+0x6f/0xb0
Dec 13 16:35:07 kaveri kernel: [   52.815840]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.815844]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.815846]=20
Dec 13 16:35:07 kaveri kernel: [   52.815849] Freed by task 2010:
Dec 13 16:35:07 kaveri kernel: [   52.815853]  __kasan_slab_free+0x125/0x=
170
Dec 13 16:35:07 kaveri kernel: [   52.815856]  kfree+0xe2/0x290
Dec 13 16:35:07 kaveri kernel: [   52.815864]  ttm_bo_release_list+0x3b0/=
0x560 [ttm]
Dec 13 16:35:07 kaveri kernel: [   52.815872]  ttm_bo_vm_close+0x34/0x70 =
[ttm]
Dec 13 16:35:07 kaveri kernel: [   52.815876]  remove_vma+0x92/0x130
Dec 13 16:35:07 kaveri kernel: [   52.815879]  exit_mmap+0x292/0x400
Dec 13 16:35:07 kaveri kernel: [   52.815883]  mmput+0xb2/0x390
Dec 13 16:35:07 kaveri kernel: [   52.815887]  do_exit+0x8c4/0x2880
Dec 13 16:35:07 kaveri kernel: [   52.815891]  do_group_exit+0xf0/0x2e0
Dec 13 16:35:07 kaveri kernel: [   52.815895]  __x64_sys_exit_group+0x3a/=
0x50
Dec 13 16:35:07 kaveri kernel: [   52.815898]  do_syscall_64+0x9c/0x3d0
Dec 13 16:35:07 kaveri kernel: [   52.815902]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Dec 13 16:35:07 kaveri kernel: [   52.815904]=20
Dec 13 16:35:07 kaveri kernel: [   52.815908] The buggy address belongs t=
o the object at ffff8883d620e060
Dec 13 16:35:07 kaveri kernel: [   52.815908]  which belongs to the cache=
 kmalloc-64 of size 64
Dec 13 16:35:07 kaveri kernel: [   52.815912] The buggy address is locate=
d 0 bytes inside of
Dec 13 16:35:07 kaveri kernel: [   52.815912]  64-byte region [ffff8883d6=
20e060, ffff8883d620e0a0)
Dec 13 16:35:07 kaveri kernel: [   52.815916] The buggy address belongs t=
o the page:
Dec 13 16:35:07 kaveri kernel: [   52.815920] page:ffffea000f588380 count=
:1 mapcount:0 mapping:ffff8883ed80f600 index:0x0
Dec 13 16:35:07 kaveri kernel: [   52.815924] flags: 0x17fffc000000200(sl=
ab)
Dec 13 16:35:07 kaveri kernel: [   52.815930] raw: 017fffc000000200 ffffe=
a000f63ad80 0000001000000010 ffff8883ed80f600
Dec 13 16:35:07 kaveri kernel: [   52.815934] raw: 0000000000000000 00000=
000002a002a 00000001ffffffff 0000000000000000
Dec 13 16:35:07 kaveri kernel: [   52.815937] page dumped because: kasan:=
 bad access detected
Dec 13 16:35:07 kaveri kernel: [   52.815939]=20
Dec 13 16:35:07 kaveri kernel: [   52.815941] Memory state around the bug=
gy address:
Dec 13 16:35:07 kaveri kernel: [   52.815945]  ffff8883d620df00: fb fb fb=
 fb fc fc fb fb fb fb fc fc 00 00 00 00
Dec 13 16:35:07 kaveri kernel: [   52.815949]  ffff8883d620df80: fc fc fb=
 fb fb fb fc fc fb fb fb fb fc fc fc fc
Dec 13 16:35:07 kaveri kernel: [   52.815952] >ffff8883d620e000: fb fb fb=
 fb fb fb fb fb fc fc fc fc fb fb fb fb
Dec 13 16:35:07 kaveri kernel: [   52.815955]                            =
                            ^
Dec 13 16:35:07 kaveri kernel: [   52.815958]  ffff8883d620e080: fb fb fb=
 fb fc fc fc fc fb fb fb fb fb fb fb fb
Dec 13 16:35:07 kaveri kernel: [   52.815962]  ffff8883d620e100: fc fc fc=
 fc 00 00 00 00 00 00 00 fc fc fc fc fc
Dec 13 16:35:07 kaveri kernel: [   52.815965] =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

--------------CE6882F22C91527CA68D7B14
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------CE6882F22C91527CA68D7B14--
