From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix "Revert "drm/amdgpu: move PD/PT bos on
 LRU again""
Date: Thu, 30 Aug 2018 10:49:32 +0200
Message-ID: <f2660a0a-6abf-ffeb-7fb6-7985c33e405d@daenzer.net>
References: <20180830080811.28700-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2BBF37237C1075898DFB082B"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180830080811.28700-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
--------------2BBF37237C1075898DFB082B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2018-08-30 10:08 a.m., Christian König wrote:
> This reverts commit 1156da3d4034957e7927ea68007b981942f5cbd5.
>
> We should review reverts as well cause that one only added an incomplete band
> aided to the problem.

Sorry about that. I didn't notice any issues with the same testing
procedure that easily reproduced issues without the revert, so I thought
it should be at least an improvement.


> Correctly disable bulk moves until we have figured out why they corrupt
> the lists.
> 
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 72f8c750e128..4a2d31e45c17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -283,12 +283,15 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
>  	struct ttm_bo_global *glob = adev->mman.bdev.glob;
>  	struct amdgpu_vm_bo_base *bo_base;
>  
> +	/* TODO: Fix list corruption caused by this */
> +#if 0
>  	if (vm->bulk_moveable) {
>  		spin_lock(&glob->lru_lock);
>  		ttm_bo_bulk_move_lru_tail(&vm->lru_bulk_move);
>  		spin_unlock(&glob->lru_lock);
>  		return;
>  	}
> +#endif

Code should be removed, not #if 0'd.


Anyway, with this patch, the attached warning dumps appear in dmesg
about 1000 times per second at the GDM login prompt, can't even attempt
to run piglit. Something else is needed, I'm afraid.

In case it's relevant, note that my development machine has a secondary
Turks card installed.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------2BBF37237C1075898DFB082B
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Aug 30 10:36:03 kaveri kernel: [   12.338157] WARNING: CPU: 9 PID: 1485 a=
t drivers/gpu/drm//ttm/ttm_bo.c:228 ttm_bo_move_to_lru_tail+0x28b/0x3d0 [=
ttm]
Aug 30 10:36:03 kaveri kernel: [   12.338182] Modules linked in: lz4(E) l=
z4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cpufreq_conserva=
tive(E) amdgpu(OE) chash(OE) gpu_sched(OE) binfmt_misc(E) nls_ascii(E) nl=
s_cp437(E) vfat(E) fat(E) edac_mce_amd(E) radeon(OE) kvm(E) irqbypass(E) =
crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) snd_hda_codec_=
realtek(E) pcbc(E) snd_hda_codec_generic(E) ttm(OE) snd_hda_codec_hdmi(E)=
 drm_kms_helper(OE) snd_hda_intel(E) aesni_intel(E) snd_hda_codec(E) aes_=
x86_64(E) crypto_simd(E) wmi_bmof(E) snd_hda_core(E) drm(OE) cryptd(E) gl=
ue_helper(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) r8169(E) i2c_algo_bit(E=
) fb_sys_fops(E) syscopyarea(E) efi_pstore(E) sp5100_tco(E) sysfillrect(E=
) pcspkr(E) ccp(E) snd(E) sysimgblt(E) mii(E) sg(E) efivars(E) soundcore(=
E) rng_core(E) i2c_piix4(E) k10temp(E)
Aug 30 10:36:03 kaveri kernel: [   12.338287]  wmi(E) button(E) acpi_cpuf=
req(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efivarfs(E)=
 ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) j=
bd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multipath(E) lin=
ear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahci(=
E) xhci_pci(E) libahci(E) xhci_hcd(E) libata(E) crc32c_intel(E) usbcore(E=
) scsi_mod(E) gpio_amdpt(E) gpio_generic(E)
Aug 30 10:36:03 kaveri kernel: [   12.338364] CPU: 9 PID: 1485 Comm: gnom=
e-shel:cs0 Tainted: G           OE     4.18.0-rc1+ #111
Aug 30 10:36:03 kaveri kernel: [   12.338367] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Aug 30 10:36:03 kaveri kernel: [   12.338377] RIP: 0010:ttm_bo_move_to_lr=
u_tail+0x28b/0x3d0 [ttm]
Aug 30 10:36:03 kaveri kernel: [   12.338379] Code: c1 ea 03 80 3c 02 00 =
0f 85 e6 00 00 00 48 8b 83 e8 01 00 00 be ff ff ff ff 48 8d 78 60 e8 cd 0=
7 9d ef 85 c0 0f 85 c3 fd ff ff <0f> 0b e9 bc fd ff ff 48 8d bb d0 01 00 =
00 48 b8 00 00 00 00 00 fc=20
Aug 30 10:36:03 kaveri kernel: [   12.338506] RSP: 0018:ffff88036174f6b0 =
EFLAGS: 00010246
Aug 30 10:36:03 kaveri kernel: [   12.338512] RAX: 0000000000000000 RBX: =
ffff8803cb865550 RCX: ffffffffb0a4c9ed
Aug 30 10:36:03 kaveri kernel: [   12.338515] RDX: 0000000000000000 RSI: =
ffff8803eb560b20 RDI: 0000000000000246
Aug 30 10:36:03 kaveri kernel: [   12.338517] RBP: ffff880376121738 R08: =
ffffed0079fa274b R09: ffffed0079fa274b
Aug 30 10:36:03 kaveri kernel: [   12.338520] R10: 0000000000000001 R11: =
ffffed0079fa274a R12: ffff880376121178
Aug 30 10:36:03 kaveri kernel: [   12.338523] R13: ffff880376121738 R14: =
ffff880376121100 R15: dffffc0000000000
Aug 30 10:36:03 kaveri kernel: [   12.338527] FS:  00007fa7f8caa700(0000)=
 GS:ffff8803ee240000(0000) knlGS:0000000000000000
Aug 30 10:36:03 kaveri kernel: [   12.338530] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug 30 10:36:03 kaveri kernel: [   12.338533] CR2: 00007fa7f0000010 CR3: =
00000003746be000 CR4: 00000000003406e0
Aug 30 10:36:03 kaveri kernel: [   12.338535] Call Trace:
Aug 30 10:36:03 kaveri kernel: [   12.338624]  amdgpu_vm_move_to_lru_tail=
+0xee/0x1d0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.338699]  amdgpu_cs_ioctl+0x967/0x4b=
a0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.338713]  ? lock_acquire+0x10b/0x330=

Aug 30 10:36:03 kaveri kernel: [   12.338785]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.338790]  ? _raw_spin_unlock_irq+0x2=
9/0x40
Aug 30 10:36:03 kaveri kernel: [   12.338799]  ? __lock_acquire+0x605/0x3=
670
Aug 30 10:36:03 kaveri kernel: [   12.338802]  ? finish_task_switch+0x18e=
/0x670
Aug 30 10:36:03 kaveri kernel: [   12.338811]  ? __schedule+0x80b/0x1be0
Aug 30 10:36:03 kaveri kernel: [   12.338822]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 30 10:36:03 kaveri kernel: [   12.338927]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.338946]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Aug 30 10:36:03 kaveri kernel: [   12.338965]  ? drm_setversion+0x800/0x8=
00 [drm]
Aug 30 10:36:03 kaveri kernel: [   12.338970]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 30 10:36:03 kaveri kernel: [   12.338977]  ? __check_object_size+0x14=
9/0x360
Aug 30 10:36:03 kaveri kernel: [   12.338997]  drm_ioctl+0x40e/0x860 [drm=
]
Aug 30 10:36:03 kaveri kernel: [   12.339072]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.339090]  ? drm_version+0x390/0x390 =
[drm]
Aug 30 10:36:03 kaveri kernel: [   12.339103]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 30 10:36:03 kaveri kernel: [   12.339110]  ? _raw_spin_unlock_irqrest=
ore+0x32/0x60
Aug 30 10:36:03 kaveri kernel: [   12.339116]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 30 10:36:03 kaveri kernel: [   12.339188]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.339196]  do_vfs_ioctl+0x192/0xf30
Aug 30 10:36:03 kaveri kernel: [   12.339202]  ? find_held_lock+0x32/0x1c=
0
Aug 30 10:36:03 kaveri kernel: [   12.339207]  ? ioctl_preallocate+0x1b0/=
0x1b0
Aug 30 10:36:03 kaveri kernel: [   12.339213]  ? __fget+0x1c8/0x300
Aug 30 10:36:03 kaveri kernel: [   12.339219]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 30 10:36:03 kaveri kernel: [   12.339231]  ? __fget+0x1e0/0x300
Aug 30 10:36:03 kaveri kernel: [   12.339244]  ksys_ioctl+0x70/0x80
Aug 30 10:36:03 kaveri kernel: [   12.339251]  __x64_sys_ioctl+0x6f/0xb0
Aug 30 10:36:03 kaveri kernel: [   12.339254]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 30 10:36:03 kaveri kernel: [   12.339259]  do_syscall_64+0xa5/0x3f0
Aug 30 10:36:03 kaveri kernel: [   12.339265]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Aug 30 10:36:03 kaveri kernel: [   12.339268] RIP: 0033:0x7fa819b3e067
Aug 30 10:36:03 kaveri kernel: [   12.339270] Code: b3 66 90 48 8b 05 21 =
7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 =
7d 0c 00 f7 d8 64 89 01 48=20
Aug 30 10:36:03 kaveri kernel: [   12.339386] RSP: 002b:00007fa7f8ca96f8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 30 10:36:03 kaveri kernel: [   12.339391] RAX: ffffffffffffffda RBX: =
00007fa7f8ca9828 RCX: 00007fa819b3e067
Aug 30 10:36:03 kaveri kernel: [   12.339394] RDX: 00007fa7f8ca9770 RSI: =
00000000c0186444 RDI: 000000000000000e
Aug 30 10:36:03 kaveri kernel: [   12.339397] RBP: 00007fa7f8ca9720 R08: =
00007fa7f8ca9880 R09: 00007fa7f8ca9828
Aug 30 10:36:03 kaveri kernel: [   12.339400] R10: 00007fa7f8ca9880 R11: =
0000000000000246 R12: 00007fa7f8ca9770
Aug 30 10:36:03 kaveri kernel: [   12.339402] R13: 00000000c0186444 R14: =
000000000000000e R15: 0000561378159b78
Aug 30 10:36:03 kaveri kernel: [   12.339420] irq event stamp: 158
Aug 30 10:36:03 kaveri kernel: [   12.339425] hardirqs last  enabled at (=
157): [<ffffffffb1eccc32>] _raw_spin_unlock_irqrestore+0x32/0x60
Aug 30 10:36:03 kaveri kernel: [   12.339429] hardirqs last disabled at (=
158): [<ffffffffb20011ef>] error_entry+0x7f/0x100
Aug 30 10:36:03 kaveri kernel: [   12.339435] softirqs last  enabled at (=
0): [<ffffffffb09164ca>] copy_process.part.32+0x113a/0x60d0
Aug 30 10:36:03 kaveri kernel: [   12.339438] softirqs last disabled at (=
0): [<0000000000000000>]           (null)
Aug 30 10:36:03 kaveri kernel: [   12.339441] ---[ end trace 8ee43ab8fe54=
85f6 ]---
Aug 30 10:36:03 kaveri kernel: [   12.339571] WARNING: CPU: 9 PID: 1485 a=
t drivers/gpu/drm//ttm/ttm_bo.c:166 ttm_bo_add_to_lru+0x2ec/0x580 [ttm]
Aug 30 10:36:03 kaveri kernel: [   12.339573] Modules linked in: lz4(E) l=
z4_compress(E) cpufreq_powersave(E) cpufreq_userspace(E) cpufreq_conserva=
tive(E) amdgpu(OE) chash(OE) gpu_sched(OE) binfmt_misc(E) nls_ascii(E) nl=
s_cp437(E) vfat(E) fat(E) edac_mce_amd(E) radeon(OE) kvm(E) irqbypass(E) =
crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) snd_hda_codec_=
realtek(E) pcbc(E) snd_hda_codec_generic(E) ttm(OE) snd_hda_codec_hdmi(E)=
 drm_kms_helper(OE) snd_hda_intel(E) aesni_intel(E) snd_hda_codec(E) aes_=
x86_64(E) crypto_simd(E) wmi_bmof(E) snd_hda_core(E) drm(OE) cryptd(E) gl=
ue_helper(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) r8169(E) i2c_algo_bit(E=
) fb_sys_fops(E) syscopyarea(E) efi_pstore(E) sp5100_tco(E) sysfillrect(E=
) pcspkr(E) ccp(E) snd(E) sysimgblt(E) mii(E) sg(E) efivars(E) soundcore(=
E) rng_core(E) i2c_piix4(E) k10temp(E)
Aug 30 10:36:03 kaveri kernel: [   12.339691]  wmi(E) button(E) acpi_cpuf=
req(E) tcp_bbr(E) sch_fq(E) nct6775(E) hwmon_vid(E) sunrpc(E) efivarfs(E)=
 ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) mbcache(E) j=
bd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) multipath(E) lin=
ear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) hid(E) ahci(=
E) xhci_pci(E) libahci(E) xhci_hcd(E) libata(E) crc32c_intel(E) usbcore(E=
) scsi_mod(E) gpio_amdpt(E) gpio_generic(E)
Aug 30 10:36:03 kaveri kernel: [   12.339773] CPU: 9 PID: 1485 Comm: gnom=
e-shel:cs0 Tainted: G        W  OE     4.18.0-rc1+ #111
Aug 30 10:36:03 kaveri kernel: [   12.339775] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Aug 30 10:36:03 kaveri kernel: [   12.339784] RIP: 0010:ttm_bo_add_to_lru=
+0x2ec/0x580 [ttm]
Aug 30 10:36:03 kaveri kernel: [   12.339786] Code: c1 ea 03 80 3c 02 00 =
0f 85 ab 01 00 00 48 8b 83 e8 01 00 00 be ff ff ff ff 48 8d 78 60 e8 2c 3=
b 9d ef 85 c0 0f 85 87 fd ff ff <0f> 0b e9 80 fd ff ff 48 b8 00 00 00 00 =
00 fc ff df 49 8d 7c 24 10=20
Aug 30 10:36:03 kaveri kernel: [   12.339911] RSP: 0018:ffff88036174f668 =
EFLAGS: 00010246
Aug 30 10:36:03 kaveri kernel: [   12.339916] RAX: 0000000000000000 RBX: =
ffff8803cb865550 RCX: 0000000000000000
Aug 30 10:36:03 kaveri kernel: [   12.339919] RDX: 0000000000000000 RSI: =
ffff8803eb560b20 RDI: 0000000000000246
Aug 30 10:36:03 kaveri kernel: [   12.339922] RBP: ffff880376121738 R08: =
ffffed006c2e9ec2 R09: ffffed006c2e9ec2
Aug 30 10:36:03 kaveri kernel: [   12.339924] R10: 0000000000000001 R11: =
ffffed006c2e9ec2 R12: ffff8803708a2c00
Aug 30 10:36:03 kaveri kernel: [   12.339927] R13: ffff880376121738 R14: =
ffff880376121100 R15: dffffc0000000000
Aug 30 10:36:03 kaveri kernel: [   12.339931] FS:  00007fa7f8caa700(0000)=
 GS:ffff8803ee240000(0000) knlGS:0000000000000000
Aug 30 10:36:03 kaveri kernel: [   12.339933] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug 30 10:36:03 kaveri kernel: [   12.339936] CR2: 00007fa7f0000010 CR3: =
00000003746be000 CR4: 00000000003406e0
Aug 30 10:36:03 kaveri kernel: [   12.339938] Call Trace:
Aug 30 10:36:03 kaveri kernel: [   12.339954]  ttm_bo_move_to_lru_tail+0x=
5e/0x3d0 [ttm]
Aug 30 10:36:03 kaveri kernel: [   12.340043]  amdgpu_vm_move_to_lru_tail=
+0xee/0x1d0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.340133]  amdgpu_cs_ioctl+0x967/0x4b=
a0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.340148]  ? lock_acquire+0x10b/0x330=

Aug 30 10:36:03 kaveri kernel: [   12.340231]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.340235]  ? _raw_spin_unlock_irq+0x2=
9/0x40
Aug 30 10:36:03 kaveri kernel: [   12.340243]  ? __lock_acquire+0x605/0x3=
670
Aug 30 10:36:03 kaveri kernel: [   12.340246]  ? finish_task_switch+0x18e=
/0x670
Aug 30 10:36:03 kaveri kernel: [   12.340255]  ? __schedule+0x80b/0x1be0
Aug 30 10:36:03 kaveri kernel: [   12.340266]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 30 10:36:03 kaveri kernel: [   12.340371]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.340389]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Aug 30 10:36:03 kaveri kernel: [   12.340407]  ? drm_setversion+0x800/0x8=
00 [drm]
Aug 30 10:36:03 kaveri kernel: [   12.340412]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 30 10:36:03 kaveri kernel: [   12.340418]  ? __check_object_size+0x14=
9/0x360
Aug 30 10:36:03 kaveri kernel: [   12.340439]  drm_ioctl+0x40e/0x860 [drm=
]
Aug 30 10:36:03 kaveri kernel: [   12.340513]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.340532]  ? drm_version+0x390/0x390 =
[drm]
Aug 30 10:36:03 kaveri kernel: [   12.340544]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 30 10:36:03 kaveri kernel: [   12.340552]  ? _raw_spin_unlock_irqrest=
ore+0x32/0x60
Aug 30 10:36:03 kaveri kernel: [   12.340557]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 30 10:36:03 kaveri kernel: [   12.340629]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Aug 30 10:36:03 kaveri kernel: [   12.340637]  do_vfs_ioctl+0x192/0xf30
Aug 30 10:36:03 kaveri kernel: [   12.340643]  ? find_held_lock+0x32/0x1c=
0
Aug 30 10:36:03 kaveri kernel: [   12.340647]  ? ioctl_preallocate+0x1b0/=
0x1b0
Aug 30 10:36:03 kaveri kernel: [   12.340654]  ? __fget+0x1c8/0x300
Aug 30 10:36:03 kaveri kernel: [   12.340659]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 30 10:36:03 kaveri kernel: [   12.340671]  ? __fget+0x1e0/0x300
Aug 30 10:36:03 kaveri kernel: [   12.340684]  ksys_ioctl+0x70/0x80
Aug 30 10:36:03 kaveri kernel: [   12.340691]  __x64_sys_ioctl+0x6f/0xb0
Aug 30 10:36:03 kaveri kernel: [   12.340694]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 30 10:36:03 kaveri kernel: [   12.340698]  do_syscall_64+0xa5/0x3f0
Aug 30 10:36:03 kaveri kernel: [   12.340704]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Aug 30 10:36:03 kaveri kernel: [   12.340707] RIP: 0033:0x7fa819b3e067
Aug 30 10:36:03 kaveri kernel: [   12.340709] Code: b3 66 90 48 8b 05 21 =
7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 =
7d 0c 00 f7 d8 64 89 01 48=20
Aug 30 10:36:03 kaveri kernel: [   12.340813] RSP: 002b:00007fa7f8ca96f8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 30 10:36:03 kaveri kernel: [   12.340818] RAX: ffffffffffffffda RBX: =
00007fa7f8ca9828 RCX: 00007fa819b3e067
Aug 30 10:36:03 kaveri kernel: [   12.340820] RDX: 00007fa7f8ca9770 RSI: =
00000000c0186444 RDI: 000000000000000e
Aug 30 10:36:03 kaveri kernel: [   12.340822] RBP: 00007fa7f8ca9720 R08: =
00007fa7f8ca9880 R09: 00007fa7f8ca9828
Aug 30 10:36:03 kaveri kernel: [   12.340824] R10: 00007fa7f8ca9880 R11: =
0000000000000246 R12: 00007fa7f8ca9770
Aug 30 10:36:03 kaveri kernel: [   12.340826] R13: 00000000c0186444 R14: =
000000000000000e R15: 0000561378159b78
Aug 30 10:36:03 kaveri kernel: [   12.340841] irq event stamp: 160
Aug 30 10:36:03 kaveri kernel: [   12.340845] hardirqs last  enabled at (=
159): [<ffffffffb2000a60>] restore_regs_and_return_to_kernel+0x0/0x30
Aug 30 10:36:03 kaveri kernel: [   12.340848] hardirqs last disabled at (=
160): [<ffffffffb20011ef>] error_entry+0x7f/0x100
Aug 30 10:36:03 kaveri kernel: [   12.340852] softirqs last  enabled at (=
0): [<ffffffffb09164ca>] copy_process.part.32+0x113a/0x60d0
Aug 30 10:36:03 kaveri kernel: [   12.340855] softirqs last disabled at (=
0): [<0000000000000000>]           (null)

--------------2BBF37237C1075898DFB082B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------2BBF37237C1075898DFB082B--
