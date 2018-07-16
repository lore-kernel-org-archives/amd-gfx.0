From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 6/7] drm/amdgpu: remove job->adev
Date: Mon, 16 Jul 2018 17:50:44 +0200
Message-ID: <e0930c99-0221-23b4-7357-9e7eee16945e@daenzer.net>
References: <20180713151949.13665-1-christian.koenig@amd.com>
 <20180713151949.13665-6-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------A9C91ADC1A0A65AF6822A6D4"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180713151949.13665-6-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------A9C91ADC1A0A65AF6822A6D4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-07-13 05:19 PM, Christian König wrote:
> We can get that from the ring.
> 
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This change introduced the attached oops when running the piglit
max-texture-size test, after which the test process hangs.

Note that the test always triggers the out of memory condition in
amdgpu_cs_ioctl, but before this change that was handled gracefully.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------A9C91ADC1A0A65AF6822A6D4
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Jul 16 17:35:32 kaveri kernel: [   97.203039] [drm:amdgpu_cs_ioctl [amdgp=
u]] *ERROR* amdgpu_cs_list_validate(validated) failed.
Jul 16 17:35:32 kaveri kernel: [   97.203299] [drm:amdgpu_cs_ioctl [amdgp=
u]] *ERROR* Not enough memory for command submission!
Jul 16 17:35:32 kaveri kernel: [   97.203388] BUG: unable to handle kerne=
l paging request at ffffffffffffff30
Jul 16 17:35:32 kaveri kernel: [   97.203398] PGD 1a6e16067 P4D 1a6e16067=
 PUD 1a6e18067 PMD 0=20
Jul 16 17:35:32 kaveri kernel: [   97.203414] Oops: 0000 [#1] SMP KASAN N=
OPTI
Jul 16 17:35:32 kaveri kernel: [   97.203423] CPU: 10 PID: 2009 Comm: max=
-textur:cs0 Tainted: G        W  OE     4.18.0-rc1+ #110
Jul 16 17:35:32 kaveri kernel: [   97.203428] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Jul 16 17:35:32 kaveri kernel: [   97.203555] RIP: 0010:amdgpu_job_free_r=
esources+0x122/0x1f0 [amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.203559] Code: 85 dc 00 00 00 48 8b =
44 24 08 89 ea 48 8d 34 92 49 8b 96 48 02 00 00 42 80 3c 38 00 48 8d 34 f=
2 0f 85 a2 00 00 00 48 8b 14 24 <49> 8b bc 24 30 ff ff ff 83 c5 01 e8 2e =
45 d9 ff 48 89 da 48 c1 ea=20
Jul 16 17:35:32 kaveri kernel: [   97.203664] RSP: 0018:ffff8803de2e7698 =
EFLAGS: 00010246
Jul 16 17:35:32 kaveri kernel: [   97.203671] RAX: 1fffffffffffffe6 RBX: =
ffff8803465969dc RCX: 1fffffffffffffe6
Jul 16 17:35:32 kaveri kernel: [   97.203677] RDX: 0000000000000000 RSI: =
ffff880346596a30 RDI: ffff8803465969d0
Jul 16 17:35:32 kaveri kernel: [   97.203682] RBP: 0000000000000000 R08: =
ffff8803de2e74b0 R09: 0000000000000000
Jul 16 17:35:32 kaveri kernel: [   97.203686] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
Jul 16 17:35:32 kaveri kernel: [   97.203691] R13: ffffed0068cb2d39 R14: =
ffff880346596780 R15: dffffc0000000000
Jul 16 17:35:32 kaveri kernel: [   97.203698] FS:  00007fca13089700(0000)=
 GS:ffff8803ee280000(0000) knlGS:0000000000000000
Jul 16 17:35:32 kaveri kernel: [   97.203703] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Jul 16 17:35:32 kaveri kernel: [   97.203708] CR2: ffffffffffffff30 CR3: =
00000003cf8f4000 CR4: 00000000003406e0
Jul 16 17:35:32 kaveri kernel: [   97.203712] Call Trace:
Jul 16 17:35:32 kaveri kernel: [   97.203843]  amdgpu_job_free+0xf/0x80 [=
amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.203947]  amdgpu_cs_ioctl+0x8dd/0x4e=
60 [amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.204058]  ? amdgpu_bo_list_ioctl+0x2=
d1/0x3e0 [amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.204160]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.204170]  ? do_vfs_ioctl+0x192/0xf30=

Jul 16 17:35:32 kaveri kernel: [   97.204176]  ? ksys_ioctl+0x70/0x80
Jul 16 17:35:32 kaveri kernel: [   97.204182]  ? __x64_sys_ioctl+0x6f/0xb=
0
Jul 16 17:35:32 kaveri kernel: [   97.204189]  ? do_syscall_64+0xa5/0x3f0=

Jul 16 17:35:32 kaveri kernel: [   97.204199]  ? __lock_acquire+0x605/0x3=
670
Jul 16 17:35:32 kaveri kernel: [   97.204207]  ? idr_get_free+0x4bc/0x980=

Jul 16 17:35:32 kaveri kernel: [   97.204215]  ? find_held_lock+0x32/0x1c=
0
Jul 16 17:35:32 kaveri kernel: [   97.204228]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Jul 16 17:35:32 kaveri kernel: [   97.204235]  ? __fprop_inc_percpu_max+0=
x1d0/0x1d0
Jul 16 17:35:32 kaveri kernel: [   97.204361]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.204391]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Jul 16 17:35:32 kaveri kernel: [   97.204422]  ? drm_setversion+0x7d0/0x7=
d0 [drm]
Jul 16 17:35:32 kaveri kernel: [   97.204432]  ? __check_object_size+0x14=
9/0x360
Jul 16 17:35:32 kaveri kernel: [   97.204464]  drm_ioctl+0x60a/0x970 [drm=
]
Jul 16 17:35:32 kaveri kernel: [   97.204568]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.204599]  ? drm_ioctl_kernel+0x220/0=
x220 [drm]
Jul 16 17:35:32 kaveri kernel: [   97.204612]  ? lock_downgrade+0x5e0/0x5=
e0
Jul 16 17:35:32 kaveri kernel: [   97.204621]  ? _raw_spin_unlock_irqrest=
ore+0x32/0x60
Jul 16 17:35:32 kaveri kernel: [   97.204629]  ? trace_hardirqs_on_caller=
+0x381/0x570
Jul 16 17:35:32 kaveri kernel: [   97.204729]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Jul 16 17:35:32 kaveri kernel: [   97.204739]  do_vfs_ioctl+0x192/0xf30
Jul 16 17:35:32 kaveri kernel: [   97.204747]  ? find_held_lock+0x32/0x1c=
0
Jul 16 17:35:32 kaveri kernel: [   97.204754]  ? ioctl_preallocate+0x1b0/=
0x1b0
Jul 16 17:35:32 kaveri kernel: [   97.204763]  ? __fget+0x1c8/0x300
Jul 16 17:35:32 kaveri kernel: [   97.204771]  ? lock_downgrade+0x5e0/0x5=
e0
Jul 16 17:35:32 kaveri kernel: [   97.204783]  ? __fget+0x1e0/0x300
Jul 16 17:35:32 kaveri kernel: [   97.204796]  ksys_ioctl+0x70/0x80
Jul 16 17:35:32 kaveri kernel: [   97.204805]  __x64_sys_ioctl+0x6f/0xb0
Jul 16 17:35:32 kaveri kernel: [   97.204811]  ? trace_hardirqs_on_caller=
+0x381/0x570
Jul 16 17:35:32 kaveri kernel: [   97.204818]  do_syscall_64+0xa5/0x3f0
Jul 16 17:35:32 kaveri kernel: [   97.204826]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Jul 16 17:35:32 kaveri kernel: [   97.204832] RIP: 0033:0x7fca1ae40097
Jul 16 17:35:32 kaveri kernel: [   97.204836] Code: b3 66 90 48 8b 05 f1 =
7d 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 =
7d 0c 00 f7 d8 64 89 01 48=20
Jul 16 17:35:32 kaveri kernel: [   97.204941] RSP: 002b:00007fca13088c68 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Jul 16 17:35:32 kaveri kernel: [   97.204949] RAX: ffffffffffffffda RBX: =
00007fca13088d58 RCX: 00007fca1ae40097
Jul 16 17:35:32 kaveri kernel: [   97.204954] RDX: 00007fca13088cd0 RSI: =
00000000c0186444 RDI: 0000000000000006
Jul 16 17:35:32 kaveri kernel: [   97.204959] RBP: 00007fca13088c90 R08: =
00007fca13088d80 R09: 00007fca13088d58
Jul 16 17:35:32 kaveri kernel: [   97.204964] R10: 00007fca13088d80 R11: =
0000000000000246 R12: 00007fca13088cd0
Jul 16 17:35:32 kaveri kernel: [   97.204968] R13: 00000000c0186444 R14: =
0000000000000006 R15: 0000000000000000
Jul 16 17:35:32 kaveri kernel: [   97.204981] Modules linked in: lz4(E) l=
z4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cpufreq_conserva=
tive(E) binfmt_misc(E) amdkfd(OE) nls_ascii(E) nls_cp437(E) vfat(E) fat(E=
) amdgpu(OE) edac_mce_amd(E) chash(OE) gpu_sched(OE) snd_hda_codec_realte=
k(E) radeon(OE) snd_hda_codec_generic(E) kvm(E) snd_hda_codec_hdmi(E) irq=
bypass(E) snd_hda_intel(E) ttm(OE) crct10dif_pclmul(E) crc32_pclmul(E) gh=
ash_clmulni_intel(E) snd_hda_codec(E) pcbc(E) wmi_bmof(E) drm_kms_helper(=
OE) snd_hda_core(E) snd_hwdep(E) efi_pstore(E) drm(OE) snd_pcm(E) aesni_i=
ntel(E) aes_x86_64(E) snd_timer(E) i2c_algo_bit(E) crypto_simd(E) fb_sys_=
fops(E) r8169(E) syscopyarea(E) cryptd(E) snd(E) sysfillrect(E) pcspkr(E)=
 glue_helper(E) efivars(E) k10temp(E) mii(E) sg(E) sysimgblt(E) soundcore=
(E) ccp(E) sp5100_tco(E) rng_core(E) i2c_piix4(E)
Jul 16 17:35:32 kaveri kernel: [   97.205092]  wmi(E) button(E) acpi_cpuf=
req(E) tcp_bbr(E) sch_fq(E) sunrpc(E) nct6775(E) hwmon_vid(E) efivarfs(E)=
 ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) j=
bd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multipath(E) lin=
ear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahci(=
E) xhci_pci(E) libahci(E) xhci_hcd(E) libata(E) crc32c_intel(E) usbcore(E=
) scsi_mod(E) gpio_amdpt(E) gpio_generic(E)
Jul 16 17:35:32 kaveri kernel: [   97.205167] CR2: ffffffffffffff30

--------------A9C91ADC1A0A65AF6822A6D4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------A9C91ADC1A0A65AF6822A6D4--
