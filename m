From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v5 5/5] drm/amdgpu: move PD/PT bos on LRU again
Date: Tue, 28 Aug 2018 11:14:16 +0200
Message-ID: <9528d248-f784-f5c8-28f2-12f694491cfe@daenzer.net>
References: <1534924375-5837-1-git-send-email-ray.huang@amd.com>
 <1534924375-5837-6-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------10B1FD8BC2715A551034F9A4"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1534924375-5837-6-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------10B1FD8BC2715A551034F9A4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


Hi Ray,


On 2018-08-22 9:52 a.m., Huang Rui wrote:
> The new bulk moving functionality is ready, the overhead of moving PD/PT bos to
> LRU is fixed. So move them on LRU again.
> 
> Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> Tested-by: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
> Tested-by: Dieter Nützel <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org>
> Acked-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db1f28a..d195a3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1107,7 +1107,7 @@ int amdgpu_vm_update_directories(struct amdgpu_device *adev,
>  					   struct amdgpu_vm_bo_base,
>  					   vm_status);
>  		bo_base->moved = false;
> -		list_del_init(&bo_base->vm_status);
> +		list_move(&bo_base->vm_status, &vm->idle);
>  
>  		bo = bo_base->bo->parent;
>  		if (!bo)
> 

Since this change, I'm getting various badness when running piglit using
radeonsi on Bonaire, see the attached dmesg excerpt.

Reverting just this change on top of current amd-staging-drm-next avoids
the problem.

Looks like some list manipulation isn't sufficiently protected against
concurrent execution?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------10B1FD8BC2715A551034F9A4
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Aug 27 17:34:59 kaveri kernel: [  567.429026] WARNING: CPU: 7 PID: 12214 =
at drivers/gpu/drm//ttm/ttm_bo.c:228 ttm_bo_move_to_lru_tail+0x28b/0x3d0 =
[ttm]
Aug 27 17:34:59 kaveri kernel: [  567.429029] Modules linked in: fuse(E) =
lz4(E) lz4_compress(E) amdkfd(OE) amdgpu(OE) cpufreq_powersave(E) cpufreq=
_userspace(E) cpufreq_conservative(E) chash(OE) gpu_sched(OE) binfmt_misc=
(E) nls_ascii(E) nls_cp437(E) vfat(E) edac_mce_amd(E) fat(E) kvm(E) irqby=
pass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) pcbc(E=
) radeon(OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_hda_co=
dec_hdmi(E) ttm(OE) snd_hda_intel(E) wmi_bmof(E) aesni_intel(E) efi_pstor=
e(E) aes_x86_64(E) crypto_simd(E) drm_kms_helper(OE) cryptd(E) glue_helpe=
r(E) pcspkr(E) efivars(E) snd_hda_codec(E) k10temp(E) drm(OE) snd_hda_cor=
e(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) i2c_algo_bit(E) fb_sys_fops(E) =
r8169(E) sp5100_tco(E) syscopyarea(E) snd(E) sysfillrect(E) ccp(E) sg(E) =
mii(E) sysimgblt(E) soundcore(E) i2c_piix4(E)
Aug 27 17:34:59 kaveri kernel: [  567.429118]  rng_core(E) wmi(E) button(=
E) acpi_cpufreq(E) tcp_bbr(E) sch_fq(E) sunrpc(E) nct6775(E) hwmon_vid(E)=
 efivarfs(E) ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) =
mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) mult=
ipath(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) =
hid(E) ahci(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_intel(=
E) scsi_mod(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Aug 27 17:34:59 kaveri kernel: [  567.429182] CPU: 7 PID: 12214 Comm: sha=
der_run:cs0 Tainted: G        W  OE     4.18.0-rc1+ #111
Aug 27 17:34:59 kaveri kernel: [  567.429184] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Aug 27 17:34:59 kaveri kernel: [  567.429191] RIP: 0010:ttm_bo_move_to_lr=
u_tail+0x28b/0x3d0 [ttm]
Aug 27 17:34:59 kaveri kernel: [  567.429192] Code: c1 ea 03 80 3c 02 00 =
0f 85 e6 00 00 00 48 8b 83 e8 01 00 00 be ff ff ff ff 48 8d 78 60 e8 1d 0=
8 1e c3 85 c0 0f 85 c3 fd ff ff <0f> 0b e9 bc fd ff ff 48 8d bb d0 01 00 =
00 48 b8 00 00 00 00 00 fc=20
Aug 27 17:34:59 kaveri kernel: [  567.429285] RSP: 0018:ffff8803e6aa76a8 =
EFLAGS: 00010246
Aug 27 17:34:59 kaveri kernel: [  567.429290] RAX: 0000000000000000 RBX: =
ffff8803d7f4aad0 RCX: 1ffff1007afe95f1
Aug 27 17:34:59 kaveri kernel: [  567.429292] RDX: 0000000000000000 RSI: =
ffff8803c61b57a0 RDI: 0000000000000246
Aug 27 17:34:59 kaveri kernel: [  567.429295] RBP: ffff8803d4c58638 R08: =
ffffed007cd54ebe R09: ffffed007cd54ebe
Aug 27 17:34:59 kaveri kernel: [  567.429297] R10: 0000000000000001 R11: =
ffffed007cd54ebe R12: ffff8803d4c58078
Aug 27 17:34:59 kaveri kernel: [  567.429299] R13: ffff8803d4c58000 R14: =
ffff8803d7f4aa80 R15: dffffc0000000000
Aug 27 17:34:59 kaveri kernel: [  567.429301] FS:  00007ff030b2d700(0000)=
 GS:ffff8803ee1c0000(0000) knlGS:0000000000000000
Aug 27 17:34:59 kaveri kernel: [  567.429304] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug 27 17:34:59 kaveri kernel: [  567.429306] CR2: 00007ff00cee6a90 CR3: =
00000003471e6000 CR4: 00000000003406e0
Aug 27 17:34:59 kaveri kernel: [  567.429307] Call Trace:
Aug 27 17:34:59 kaveri kernel: [  567.429363]  amdgpu_vm_move_to_lru_tail=
+0x128/0x240 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.429420]  amdgpu_cs_ioctl+0x967/0x4b=
a0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.429433]  ? lock_acquire+0x10b/0x330=

Aug 27 17:34:59 kaveri kernel: [  567.429487]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.429491]  ? _raw_spin_unlock_irq+0x2=
9/0x40
Aug 27 17:34:59 kaveri kernel: [  567.429499]  ? __lock_acquire+0x605/0x3=
670
Aug 27 17:34:59 kaveri kernel: [  567.429502]  ? finish_task_switch+0x18e=
/0x670
Aug 27 17:34:59 kaveri kernel: [  567.429509]  ? __schedule+0x80b/0x1be0
Aug 27 17:34:59 kaveri kernel: [  567.429520]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 27 17:34:59 kaveri kernel: [  567.429607]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.429627]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Aug 27 17:34:59 kaveri kernel: [  567.429644]  ? drm_setversion+0x800/0x8=
00 [drm]
Aug 27 17:34:59 kaveri kernel: [  567.429652]  ? __check_object_size+0x14=
9/0x360
Aug 27 17:34:59 kaveri kernel: [  567.429671]  drm_ioctl+0x40e/0x860 [drm=
]
Aug 27 17:34:59 kaveri kernel: [  567.429727]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.429744]  ? drm_version+0x390/0x390 =
[drm]
Aug 27 17:34:59 kaveri kernel: [  567.429756]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:34:59 kaveri kernel: [  567.429763]  ? _raw_spin_unlock_irqrest=
ore+0x32/0x60
Aug 27 17:34:59 kaveri kernel: [  567.429769]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 27 17:34:59 kaveri kernel: [  567.429821]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.429829]  do_vfs_ioctl+0x192/0xf30
Aug 27 17:34:59 kaveri kernel: [  567.429835]  ? find_held_lock+0x32/0x1c=
0
Aug 27 17:34:59 kaveri kernel: [  567.429841]  ? ioctl_preallocate+0x1b0/=
0x1b0
Aug 27 17:34:59 kaveri kernel: [  567.429847]  ? __fget+0x1c8/0x300
Aug 27 17:34:59 kaveri kernel: [  567.429852]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:34:59 kaveri kernel: [  567.429864]  ? __fget+0x1e0/0x300
Aug 27 17:34:59 kaveri kernel: [  567.429876]  ksys_ioctl+0x70/0x80
Aug 27 17:34:59 kaveri kernel: [  567.429882]  __x64_sys_ioctl+0x6f/0xb0
Aug 27 17:34:59 kaveri kernel: [  567.429885]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 27 17:34:59 kaveri kernel: [  567.429889]  do_syscall_64+0xa5/0x3f0
Aug 27 17:34:59 kaveri kernel: [  567.429895]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Aug 27 17:34:59 kaveri kernel: [  567.429897] RIP: 0033:0x7ff037449067
Aug 27 17:34:59 kaveri kernel: [  567.429899] Code: b3 66 90 48 8b 05 21 =
7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 =
7d 0c 00 f7 d8 64 89 01 48=20
Aug 27 17:34:59 kaveri kernel: [  567.429991] RSP: 002b:00007ff030b2cbb8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 27 17:34:59 kaveri kernel: [  567.429996] RAX: ffffffffffffffda RBX: =
00007ff030b2cd28 RCX: 00007ff037449067
Aug 27 17:34:59 kaveri kernel: [  567.429998] RDX: 00007ff030b2cc30 RSI: =
00000000c0186444 RDI: 0000000000000006
Aug 27 17:34:59 kaveri kernel: [  567.430000] RBP: 00007ff030b2cbe0 R08: =
00007ff030b2cd80 R09: 00007ff030b2cd28
Aug 27 17:34:59 kaveri kernel: [  567.430002] R10: 00007ff030b2cd80 R11: =
0000000000000246 R12: 00007ff030b2cc30
Aug 27 17:34:59 kaveri kernel: [  567.430004] R13: 00000000c0186444 R14: =
0000000000000006 R15: 00005594f4e417d8
Aug 27 17:34:59 kaveri kernel: [  567.430019] irq event stamp: 5909674
Aug 27 17:34:59 kaveri kernel: [  567.430022] hardirqs last  enabled at (=
5909673): [<ffffffff85a00a60>] restore_regs_and_return_to_kernel+0x0/0x30=

Aug 27 17:34:59 kaveri kernel: [  567.430025] hardirqs last disabled at (=
5909674): [<ffffffff85a011ef>] error_entry+0x7f/0x100
Aug 27 17:34:59 kaveri kernel: [  567.430028] softirqs last  enabled at (=
5909646): [<ffffffff85c00620>] __do_softirq+0x620/0x919
Aug 27 17:34:59 kaveri kernel: [  567.430031] softirqs last disabled at (=
5909575): [<ffffffff8433443e>] irq_exit+0x19e/0x1d0
Aug 27 17:34:59 kaveri kernel: [  567.430033] ---[ end trace 701de91db573=
7054 ]---
Aug 27 17:34:59 kaveri kernel: [  567.430087] WARNING: CPU: 7 PID: 12214 =
at drivers/gpu/drm//ttm/ttm_bo.c:166 ttm_bo_add_to_lru+0x2ec/0x580 [ttm]
Aug 27 17:34:59 kaveri kernel: [  567.430091] Modules linked in: fuse(E) =
lz4(E) lz4_compress(E) amdkfd(OE) amdgpu(OE) cpufreq_powersave(E) cpufreq=
_userspace(E) cpufreq_conservative(E) chash(OE) gpu_sched(OE) binfmt_misc=
(E) nls_ascii(E) nls_cp437(E) vfat(E) edac_mce_amd(E) fat(E) kvm(E) irqby=
pass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) pcbc(E=
) radeon(OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_hda_co=
dec_hdmi(E) ttm(OE) snd_hda_intel(E) wmi_bmof(E) aesni_intel(E) efi_pstor=
e(E) aes_x86_64(E) crypto_simd(E) drm_kms_helper(OE) cryptd(E) glue_helpe=
r(E) pcspkr(E) efivars(E) snd_hda_codec(E) k10temp(E) drm(OE) snd_hda_cor=
e(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) i2c_algo_bit(E) fb_sys_fops(E) =
r8169(E) sp5100_tco(E) syscopyarea(E) snd(E) sysfillrect(E) ccp(E) sg(E) =
mii(E) sysimgblt(E) soundcore(E) i2c_piix4(E)
Aug 27 17:34:59 kaveri kernel: [  567.430250]  rng_core(E) wmi(E) button(=
E) acpi_cpufreq(E) tcp_bbr(E) sch_fq(E) sunrpc(E) nct6775(E) hwmon_vid(E)=
 efivarfs(E) ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) =
mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) mult=
ipath(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) =
hid(E) ahci(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_intel(=
E) scsi_mod(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Aug 27 17:34:59 kaveri kernel: [  567.430329] CPU: 7 PID: 12214 Comm: sha=
der_run:cs0 Tainted: G        W  OE     4.18.0-rc1+ #111
Aug 27 17:34:59 kaveri kernel: [  567.430333] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Aug 27 17:34:59 kaveri kernel: [  567.430341] RIP: 0010:ttm_bo_add_to_lru=
+0x2ec/0x580 [ttm]
Aug 27 17:34:59 kaveri kernel: [  567.430345] Code: c1 ea 03 80 3c 02 00 =
0f 85 ab 01 00 00 48 8b 83 e8 01 00 00 be ff ff ff ff 48 8d 78 60 e8 2c 3=
b 1e c3 85 c0 0f 85 87 fd ff ff <0f> 0b e9 80 fd ff ff 48 b8 00 00 00 00 =
00 fc ff df 49 8d 7c 24 10=20
Aug 27 17:34:59 kaveri kernel: [  567.430487] RSP: 0018:ffff8803e6aa7660 =
EFLAGS: 00010246
Aug 27 17:34:59 kaveri kernel: [  567.430491] RAX: 0000000000000000 RBX: =
ffff8803d7f4aad0 RCX: 0000000000000000
Aug 27 17:34:59 kaveri kernel: [  567.430493] RDX: 0000000000000000 RSI: =
ffff8803c61b57a0 RDI: 0000000000000246
Aug 27 17:34:59 kaveri kernel: [  567.430495] RBP: ffff8803d4c58638 R08: =
ffffed007cd54ec1 R09: ffffed007cd54ec1
Aug 27 17:34:59 kaveri kernel: [  567.430497] R10: 0000000000000001 R11: =
ffffed007cd54ec1 R12: ffff880371902c00
Aug 27 17:34:59 kaveri kernel: [  567.430499] R13: ffff8803d4c58000 R14: =
ffff8803d7f4aa80 R15: dffffc0000000000
Aug 27 17:34:59 kaveri kernel: [  567.430502] FS:  00007ff030b2d700(0000)=
 GS:ffff8803ee1c0000(0000) knlGS:0000000000000000
Aug 27 17:34:59 kaveri kernel: [  567.430504] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug 27 17:34:59 kaveri kernel: [  567.430506] CR2: 00007ff00cee6a90 CR3: =
00000003471e6000 CR4: 00000000003406e0
Aug 27 17:34:59 kaveri kernel: [  567.430508] Call Trace:
Aug 27 17:34:59 kaveri kernel: [  567.430522]  ttm_bo_move_to_lru_tail+0x=
5e/0x3d0 [ttm]
Aug 27 17:34:59 kaveri kernel: [  567.430580]  amdgpu_vm_move_to_lru_tail=
+0x128/0x240 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.430639]  amdgpu_cs_ioctl+0x967/0x4b=
a0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.430653]  ? lock_acquire+0x10b/0x330=

Aug 27 17:34:59 kaveri kernel: [  567.430709]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.430714]  ? _raw_spin_unlock_irq+0x2=
9/0x40
Aug 27 17:34:59 kaveri kernel: [  567.430725]  ? __lock_acquire+0x605/0x3=
670
Aug 27 17:34:59 kaveri kernel: [  567.430729]  ? finish_task_switch+0x18e=
/0x670
Aug 27 17:34:59 kaveri kernel: [  567.430739]  ? __schedule+0x80b/0x1be0
Aug 27 17:34:59 kaveri kernel: [  567.430753]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 27 17:34:59 kaveri kernel: [  567.430840]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.430858]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Aug 27 17:34:59 kaveri kernel: [  567.430875]  ? drm_setversion+0x800/0x8=
00 [drm]
Aug 27 17:34:59 kaveri kernel: [  567.430882]  ? __check_object_size+0x14=
9/0x360
Aug 27 17:34:59 kaveri kernel: [  567.430901]  drm_ioctl+0x40e/0x860 [drm=
]
Aug 27 17:34:59 kaveri kernel: [  567.430957]  ? amdgpu_cs_find_mapping+0=
x3c0/0x3c0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.430974]  ? drm_version+0x390/0x390 =
[drm]
Aug 27 17:34:59 kaveri kernel: [  567.430987]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:34:59 kaveri kernel: [  567.430994]  ? _raw_spin_unlock_irqrest=
ore+0x32/0x60
Aug 27 17:34:59 kaveri kernel: [  567.431000]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 27 17:34:59 kaveri kernel: [  567.431053]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Aug 27 17:34:59 kaveri kernel: [  567.431060]  do_vfs_ioctl+0x192/0xf30
Aug 27 17:34:59 kaveri kernel: [  567.431066]  ? find_held_lock+0x32/0x1c=
0
Aug 27 17:34:59 kaveri kernel: [  567.431070]  ? ioctl_preallocate+0x1b0/=
0x1b0
Aug 27 17:34:59 kaveri kernel: [  567.431076]  ? __fget+0x1c8/0x300
Aug 27 17:34:59 kaveri kernel: [  567.431082]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:34:59 kaveri kernel: [  567.431093]  ? __fget+0x1e0/0x300
Aug 27 17:34:59 kaveri kernel: [  567.431105]  ksys_ioctl+0x70/0x80
Aug 27 17:34:59 kaveri kernel: [  567.431112]  __x64_sys_ioctl+0x6f/0xb0
Aug 27 17:34:59 kaveri kernel: [  567.431116]  ? trace_hardirqs_on_caller=
+0x381/0x570
Aug 27 17:34:59 kaveri kernel: [  567.431120]  do_syscall_64+0xa5/0x3f0
Aug 27 17:34:59 kaveri kernel: [  567.431126]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Aug 27 17:34:59 kaveri kernel: [  567.431128] RIP: 0033:0x7ff037449067
Aug 27 17:34:59 kaveri kernel: [  567.431130] Code: b3 66 90 48 8b 05 21 =
7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 =
7d 0c 00 f7 d8 64 89 01 48=20
Aug 27 17:34:59 kaveri kernel: [  567.431223] RSP: 002b:00007ff030b2cbb8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 27 17:34:59 kaveri kernel: [  567.431227] RAX: ffffffffffffffda RBX: =
00007ff030b2cd28 RCX: 00007ff037449067
Aug 27 17:34:59 kaveri kernel: [  567.431229] RDX: 00007ff030b2cc30 RSI: =
00000000c0186444 RDI: 0000000000000006
Aug 27 17:34:59 kaveri kernel: [  567.431231] RBP: 00007ff030b2cbe0 R08: =
00007ff030b2cd80 R09: 00007ff030b2cd28
Aug 27 17:34:59 kaveri kernel: [  567.431234] R10: 00007ff030b2cd80 R11: =
0000000000000246 R12: 00007ff030b2cc30
Aug 27 17:34:59 kaveri kernel: [  567.431236] R13: 00000000c0186444 R14: =
0000000000000006 R15: 00005594f4e417d8
Aug 27 17:34:59 kaveri kernel: [  567.431249] irq event stamp: 5909680
Aug 27 17:34:59 kaveri kernel: [  567.431253] hardirqs last  enabled at (=
5909679): [<ffffffff85a00a60>] restore_regs_and_return_to_kernel+0x0/0x30=

Aug 27 17:34:59 kaveri kernel: [  567.431256] hardirqs last disabled at (=
5909680): [<ffffffff85a011ef>] error_entry+0x7f/0x100
Aug 27 17:34:59 kaveri kernel: [  567.431259] softirqs last  enabled at (=
5909646): [<ffffffff85c00620>] __do_softirq+0x620/0x919
Aug 27 17:34:59 kaveri kernel: [  567.431262] softirqs last disabled at (=
5909575): [<ffffffff8433443e>] irq_exit+0x19e/0x1d0
Aug 27 17:34:59 kaveri kernel: [  567.431264] ---[ end trace 701de91db573=
7055 ]---
Aug 27 17:36:49 kaveri kernel: [  677.611767] list_del corruption. prev->=
next should be ffff8803c92400f8, but was ffff88033cd1f620
Aug 27 17:36:49 kaveri kernel: [  677.611878] ------------[ cut here ]---=
---------
Aug 27 17:36:49 kaveri kernel: [  677.611881] kernel BUG at lib/list_debu=
g.c:53!
Aug 27 17:36:49 kaveri kernel: [  677.611894] invalid opcode: 0000 [#1] S=
MP KASAN NOPTI
Aug 27 17:36:49 kaveri kernel: [  677.611901] CPU: 4 PID: 126 Comm: kwork=
er/4:1 Tainted: G        W  OE     4.18.0-rc1+ #111
Aug 27 17:36:49 kaveri kernel: [  677.611905] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Aug 27 17:36:49 kaveri kernel: [  677.611919] Workqueue: events ttm_bo_de=
layed_workqueue [ttm]
Aug 27 17:36:49 kaveri kernel: [  677.611929] RIP: 0010:__list_del_entry_=
valid+0xe6/0x150
Aug 27 17:36:49 kaveri kernel: [  677.611932] Code: 89 ea 48 c7 c7 80 b1 =
fe 85 e8 df 30 6e ff 0f 0b 48 c7 c7 e0 b1 fe 85 e8 d1 30 6e ff 0f 0b 48 c=
7 c7 40 b2 fe 85 e8 c3 30 6e ff <0f> 0b 48 c7 c7 a0 b2 fe 85 e8 b5 30 6e =
ff 0f 0b 48 89 df 48 89 34=20
Aug 27 17:36:49 kaveri kernel: [  677.611996] RSP: 0018:ffff8803ea59fc08 =
EFLAGS: 00010286
Aug 27 17:36:49 kaveri kernel: [  677.612000] RAX: 0000000000000054 RBX: =
ffff880371902fd8 RCX: ffffffff84d63612
Aug 27 17:36:49 kaveri kernel: [  677.612003] RDX: 0000000000000000 RSI: =
0000000000000008 RDI: ffff8803ee125a2c
Aug 27 17:36:49 kaveri kernel: [  677.612006] RBP: ffff8803df0255f8 R08: =
ffffed007dc24e51 R09: ffffed007dc24e51
Aug 27 17:36:49 kaveri kernel: [  677.612008] R10: 0000000000000001 R11: =
ffffed007dc24e50 R12: ffff8803c9240100
Aug 27 17:36:49 kaveri kernel: [  677.612011] R13: 0000000000000000 R14: =
0000000000000001 R15: 0000000000000001
Aug 27 17:36:49 kaveri kernel: [  677.612014] FS:  0000000000000000(0000)=
 GS:ffff8803ee100000(0000) knlGS:0000000000000000
Aug 27 17:36:49 kaveri kernel: [  677.612017] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug 27 17:36:49 kaveri kernel: [  677.612019] CR2: 00007fafc37fdf38 CR3: =
000000036a614000 CR4: 00000000003406e0
Aug 27 17:36:49 kaveri kernel: [  677.612021] Call Trace:
Aug 27 17:36:49 kaveri kernel: [  677.612027]  ? lock_acquire+0x10b/0x330=

Aug 27 17:36:49 kaveri kernel: [  677.612035]  ttm_bo_del_from_lru+0x17c/=
0x320 [ttm]
Aug 27 17:36:49 kaveri kernel: [  677.612043]  ttm_bo_cleanup_refs+0x14b/=
0x510 [ttm]
Aug 27 17:36:49 kaveri kernel: [  677.612052]  ttm_bo_delayed_delete+0x16=
5/0x570 [ttm]
Aug 27 17:36:49 kaveri kernel: [  677.612060]  ? ttm_bo_cleanup_refs+0x51=
0/0x510 [ttm]
Aug 27 17:36:49 kaveri kernel: [  677.612065]  ? process_one_work+0x76a/0=
x16c0
Aug 27 17:36:49 kaveri kernel: [  677.612074]  ttm_bo_delayed_workqueue+0=
x17/0x60 [ttm]
Aug 27 17:36:49 kaveri kernel: [  677.612078]  process_one_work+0x7fd/0x1=
6c0
Aug 27 17:36:49 kaveri kernel: [  677.612087]  ? drain_workqueue+0x380/0x=
380
Aug 27 17:36:49 kaveri kernel: [  677.612091]  ? lock_acquire+0x10b/0x330=

Aug 27 17:36:49 kaveri kernel: [  677.612102]  worker_thread+0x87/0xb50
Aug 27 17:36:49 kaveri kernel: [  677.612111]  ? process_one_work+0x16c0/=
0x16c0
Aug 27 17:36:49 kaveri kernel: [  677.612116]  kthread+0x2db/0x390
Aug 27 17:36:49 kaveri kernel: [  677.612120]  ? kthread_create_worker_on=
_cpu+0xc0/0xc0
Aug 27 17:36:49 kaveri kernel: [  677.612127]  ret_from_fork+0x27/0x50
Aug 27 17:36:49 kaveri kernel: [  677.612137] Modules linked in: fuse(E) =
lz4(E) lz4_compress(E) amdkfd(OE) amdgpu(OE) cpufreq_powersave(E) cpufreq=
_userspace(E) cpufreq_conservative(E) chash(OE) gpu_sched(OE) binfmt_misc=
(E) nls_ascii(E) nls_cp437(E) vfat(E) edac_mce_amd(E) fat(E) kvm(E) irqby=
pass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) pcbc(E=
) radeon(OE) snd_hda_codec_realtek(E) snd_hda_codec_generic(E) snd_hda_co=
dec_hdmi(E) ttm(OE) snd_hda_intel(E) wmi_bmof(E) aesni_intel(E) efi_pstor=
e(E) aes_x86_64(E) crypto_simd(E) drm_kms_helper(OE) cryptd(E) glue_helpe=
r(E) pcspkr(E) efivars(E) snd_hda_codec(E) k10temp(E) drm(OE) snd_hda_cor=
e(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) i2c_algo_bit(E) fb_sys_fops(E) =
r8169(E) sp5100_tco(E) syscopyarea(E) snd(E) sysfillrect(E) ccp(E) sg(E) =
mii(E) sysimgblt(E) soundcore(E) i2c_piix4(E)
Aug 27 17:36:49 kaveri kernel: [  677.612230]  rng_core(E) wmi(E) button(=
E) acpi_cpufreq(E) tcp_bbr(E) sch_fq(E) sunrpc(E) nct6775(E) hwmon_vid(E)=
 efivarfs(E) ip_tables(E) x_tables(E) ext4(E) crc32c_generic(E) crc16(E) =
mbcache(E) jbd2(E) fscrypto(E) dm_mod(E) raid10(E) raid1(E) raid0(E) mult=
ipath(E) linear(E) md_mod(E) sd_mod(E) evdev(E) hid_generic(E) usbhid(E) =
hid(E) ahci(E) libahci(E) xhci_pci(E) libata(E) xhci_hcd(E) crc32c_intel(=
E) scsi_mod(E) usbcore(E) gpio_amdpt(E) gpio_generic(E)
Aug 27 17:36:49 kaveri kernel: [  677.612274] ---[ end trace 701de91db573=
7056 ]---
Aug 27 17:36:49 kaveri kernel: [  677.612278] RIP: 0010:__list_del_entry_=
valid+0xe6/0x150
Aug 27 17:36:49 kaveri kernel: [  677.612280] Code: 89 ea 48 c7 c7 80 b1 =
fe 85 e8 df 30 6e ff 0f 0b 48 c7 c7 e0 b1 fe 85 e8 d1 30 6e ff 0f 0b 48 c=
7 c7 40 b2 fe 85 e8 c3 30 6e ff <0f> 0b 48 c7 c7 a0 b2 fe 85 e8 b5 30 6e =
ff 0f 0b 48 89 df 48 89 34=20
Aug 27 17:36:49 kaveri kernel: [  677.612331] RSP: 0018:ffff8803ea59fc08 =
EFLAGS: 00010286
Aug 27 17:36:49 kaveri kernel: [  677.612334] RAX: 0000000000000054 RBX: =
ffff880371902fd8 RCX: ffffffff84d63612
Aug 27 17:36:49 kaveri kernel: [  677.612336] RDX: 0000000000000000 RSI: =
0000000000000008 RDI: ffff8803ee125a2c
Aug 27 17:36:49 kaveri kernel: [  677.612339] RBP: ffff8803df0255f8 R08: =
ffffed007dc24e51 R09: ffffed007dc24e51
Aug 27 17:36:49 kaveri kernel: [  677.612341] R10: 0000000000000001 R11: =
ffffed007dc24e50 R12: ffff8803c9240100
Aug 27 17:36:49 kaveri kernel: [  677.612343] R13: 0000000000000000 R14: =
0000000000000001 R15: 0000000000000001
Aug 27 17:36:49 kaveri kernel: [  677.612346] FS:  0000000000000000(0000)=
 GS:ffff8803ee100000(0000) knlGS:0000000000000000
Aug 27 17:36:49 kaveri kernel: [  677.612349] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug 27 17:36:49 kaveri kernel: [  677.612351] CR2: 00007fafc37fdf38 CR3: =
000000036a614000 CR4: 00000000003406e0
Aug 27 17:37:15 kaveri kernel: [  703.632630] INFO: rcu_sched self-detect=
ed stall on CPU
Aug 27 17:37:15 kaveri kernel: [  703.632632] INFO: rcu_sched self-detect=
ed stall on CPU
Aug 27 17:37:15 kaveri kernel: [  703.632634] INFO: rcu_sched self-detect=
ed stall on CPU
Aug 27 17:37:15 kaveri kernel: [  703.632645] 	10-....: (6500 ticks this =
GP) idle=3D74e/1/4611686018427387906 softirq=3D80088/80088 fqs=3D2719=20
Aug 27 17:37:15 kaveri kernel: [  703.632646] =09
Aug 27 17:37:15 kaveri kernel: [  703.632650] 	9-....: (6500 ticks this G=
P) idle=3D5a6/1/4611686018427387906 softirq=3D76170/76170 fqs=3D2719=20
Aug 27 17:37:15 kaveri kernel: [  703.632653]  (t=3D6500 jiffies g=3D1308=
7 c=3D13086 q=3D2517)
Aug 27 17:37:15 kaveri kernel: [  703.632653] =09
Aug 27 17:37:15 kaveri kernel: [  703.632656] Sending NMI from CPU 10 to =
CPUs 9:
Aug 27 17:37:15 kaveri kernel: [  703.633439]  (t=3D6500 jiffies g=3D1308=
7 c=3D13086 q=3D2517)
Aug 27 17:37:15 kaveri kernel: [  703.633654] NMI backtrace for cpu 9
Aug 27 17:37:15 kaveri kernel: [  703.633655] CPU: 9 PID: 5858 Comm: shad=
er_runner Tainted: G      D W  OE     4.18.0-rc1+ #111
Aug 27 17:37:15 kaveri kernel: [  703.633656] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Aug 27 17:37:15 kaveri kernel: [  703.633657] RIP: 0010:__memcpy+0x17/0x2=
0
Aug 27 17:37:15 kaveri kernel: [  703.633657] Code: f5 fb fe eb 9e e8 69 =
f5 fb fe e9 75 ff ff ff 90 90 90 90 0f 1f 44 00 00 48 89 f8 48 89 d1 48 c=
1 e9 03 83 e2 07 f3 48 a5 89 d1 <f3> a4 c3 66 0f 1f 44 00 00 48 89 f8 48 =
89 d1 f3 a4 c3 0f 1f 80 00=20
Aug 27 17:37:15 kaveri kernel: [  703.633675] RSP: 0018:ffff8803ee247b18 =
EFLAGS: 00000006
Aug 27 17:37:15 kaveri kernel: [  703.633677] RAX: ffffffff8810db82 RBX: =
ffff8803ee247b78 RCX: 0000000000000002
Aug 27 17:37:15 kaveri kernel: [  703.633677] RDX: 0000000000000003 RSI: =
ffffffff85e8913e RDI: ffffffff8810db83
Aug 27 17:37:15 kaveri kernel: [  703.633678] RBP: ffffffff8810df40 R08: =
fffffbfff1021b71 R09: fffffbfff1021b71
Aug 27 17:37:15 kaveri kernel: [  703.633679] R10: 0000000000000001 R11: =
fffffbfff1021b70 R12: ffffffff85e8913d
Aug 27 17:37:15 kaveri kernel: [  703.633679] R13: dffffc0000000000 R14: =
ffffffff85e89140 R15: ffffffff8810db82
Aug 27 17:37:15 kaveri kernel: [  703.633680] FS:  00007fafe6fd87c0(0000)=
 GS:ffff8803ee240000(0000) knlGS:0000000000000000
Aug 27 17:37:15 kaveri kernel: [  703.633681] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Aug 27 17:37:15 kaveri kernel: [  703.633681] CR2: 00007fafc97f9f38 CR3: =
0000000337028000 CR4: 00000000003406e0
Aug 27 17:37:15 kaveri kernel: [  703.633682] Call Trace:
Aug 27 17:37:15 kaveri kernel: [  703.633682]  <IRQ>
Aug 27 17:37:15 kaveri kernel: [  703.633683]  vsnprintf+0x1ff/0x10a0
Aug 27 17:37:15 kaveri kernel: [  703.633683]  ? pointer+0x660/0x660
Aug 27 17:37:15 kaveri kernel: [  703.633684]  ? native_queued_spin_lock_=
slowpath+0x179/0x7e0
Aug 27 17:37:15 kaveri kernel: [  703.633684]  vscnprintf+0x9/0x30
Aug 27 17:37:15 kaveri kernel: [  703.633685]  vprintk_emit+0xcb/0x6f0
Aug 27 17:37:15 kaveri kernel: [  703.633685]  printk+0x9c/0xc3
Aug 27 17:37:15 kaveri kernel: [  703.633685]  ? kmsg_dump_rewind_nolock+=
0xd9/0xd9
Aug 27 17:37:15 kaveri kernel: [  703.633686]  rcu_check_callbacks+0x1016=
/0x1e50
Aug 27 17:37:15 kaveri kernel: [  703.633686]  update_process_times+0x28/=
0x50
Aug 27 17:37:15 kaveri kernel: [  703.633687]  tick_sched_handle+0x73/0x1=
60
Aug 27 17:37:15 kaveri kernel: [  703.633687]  tick_sched_timer+0x37/0xf0=

Aug 27 17:37:15 kaveri kernel: [  703.633688]  ? tick_sched_do_timer+0x14=
0/0x140
Aug 27 17:37:15 kaveri kernel: [  703.633688]  __hrtimer_run_queues+0x291=
/0xa20
Aug 27 17:37:15 kaveri kernel: [  703.633689]  ? hrtimer_cancel+0x20/0x20=

Aug 27 17:37:15 kaveri kernel: [  703.633689]  ? ktime_get_update_offsets=
_now+0xed/0x2d0
Aug 27 17:37:15 kaveri kernel: [  703.633690]  hrtimer_interrupt+0x29a/0x=
770
Aug 27 17:37:15 kaveri kernel: [  703.633690]  ? rcu_nmi_enter+0x60/0x110=

Aug 27 17:37:15 kaveri kernel: [  703.633691]  smp_apic_timer_interrupt+0=
xd5/0x490
Aug 27 17:37:15 kaveri kernel: [  703.633691]  apic_timer_interrupt+0xf/0=
x20
Aug 27 17:37:15 kaveri kernel: [  703.633692]  </IRQ>
Aug 27 17:37:15 kaveri kernel: [  703.633692] RIP: 0010:native_queued_spi=
n_lock_slowpath+0x290/0x7e0
Aug 27 17:37:15 kaveri kernel: [  703.633693] Code: fc ff df 49 c1 ef 03 =
41 83 e5 07 49 01 c7 41 83 c5 03 f3 90 41 0f b6 07 41 38 c5 7c 08 84 c0 0=
f 85 c3 04 00 00 8b 45 08 85 c0 <74> e6 48 89 ea 48 b8 00 00 00 00 00 fc =
ff df 48 c1 ea 03 80 3c 02=20
Aug 27 17:37:15 kaveri kernel: [  703.633711] RSP: 0018:ffff8803c460f600 =
EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
Aug 27 17:37:15 kaveri kernel: [  703.633712] RAX: 0000000000000000 RBX: =
ffff8803dc592b50 RCX: ffffffff844475f9
Aug 27 17:37:15 kaveri kernel: [  703.633713] RDX: 0000000000000000 RSI: =
0000000000000004 RDI: ffffffff8633d780
Aug 27 17:37:15 kaveri kernel: [  703.633713] RBP: ffff8803ee26b700 R08: =
ffffed007b8b256b R09: ffffed007b8b256b
Aug 27 17:37:15 kaveri kernel: [  703.633714] R10: 0000000000000001 R11: =
ffffed007b8b256a R12: 0000000000280000
Aug 27 17:37:15 kaveri kernel: [  703.633715] R13: 0000000000000003 R14: =
ffff8803ee26b708 R15: ffffed007dc4d6e1
Aug 27 17:37:15 kaveri kernel: [  703.633715]  ? native_queued_spin_lock_=
slowpath+0x179/0x7e0
Aug 27 17:37:15 kaveri kernel: [  703.633716]  do_raw_spin_lock+0x160/0x1=
f0
Aug 27 17:37:15 kaveri kernel: [  703.633716]  amdgpu_bo_do_create+0xc36/=
0x1030 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633717]  ? deref_stack_reg+0xad/0xe=
0
Aug 27 17:37:15 kaveri kernel: [  703.633717]  ? amdgpu_bo_placement_from=
_domain+0x860/0x860 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633718]  ? unwind_next_frame+0xf0f/=
0x1820
Aug 27 17:37:15 kaveri kernel: [  703.633718]  amdgpu_bo_create+0xa3/0x92=
0 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633719]  ? amdgpu_bo_do_create+0x10=
30/0x1030 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633719]  ? alloc_pid+0x48/0x770
Aug 27 17:37:15 kaveri kernel: [  703.633720]  ? is_bpf_text_address+0x78=
/0xe0
Aug 27 17:37:15 kaveri kernel: [  703.633721]  ? kernel_text_address+0x11=
1/0x120
Aug 27 17:37:15 kaveri kernel: [  703.633721]  amdgpu_gem_object_create+0=
x140/0x240 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633722]  ? amdgpu_gem_object_free+0=
xa0/0xa0 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633722]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 27 17:37:15 kaveri kernel: [  703.633723]  ? save_stack+0x89/0xb0
Aug 27 17:37:15 kaveri kernel: [  703.633723]  ? drm_dev_enter+0x5/0xf0 [=
drm]
Aug 27 17:37:15 kaveri kernel: [  703.633724]  amdgpu_gem_create_ioctl+0x=
4ef/0x800 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633724]  ? amdgpu_gem_object_close+=
0x420/0x420 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633725]  ? drm_dev_exit+0x5/0x30 [d=
rm]
Aug 27 17:37:15 kaveri kernel: [  703.633725]  ? lock_acquire+0x10b/0x330=

Aug 27 17:37:15 kaveri kernel: [  703.633726]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:37:15 kaveri kernel: [  703.633726]  ? amdgpu_gem_object_close+=
0x420/0x420 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633727]  drm_ioctl_kernel+0x197/0x2=
20 [drm]
Aug 27 17:37:15 kaveri kernel: [  703.633727]  ? drm_setversion+0x800/0x8=
00 [drm]
Aug 27 17:37:15 kaveri kernel: [  703.633728]  ? __check_object_size+0x14=
9/0x360
Aug 27 17:37:15 kaveri kernel: [  703.633728]  drm_ioctl+0x40e/0x860 [drm=
]
Aug 27 17:37:15 kaveri kernel: [  703.633729]  ? amdgpu_gem_object_close+=
0x420/0x420 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633729]  ? drm_version+0x390/0x390 =
[drm]
Aug 27 17:37:15 kaveri kernel: [  703.633730]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:37:15 kaveri kernel: [  703.633730]  ? __pm_runtime_resume+0x79=
/0x100
Aug 27 17:37:15 kaveri kernel: [  703.633731]  ? debug_check_no_locks_fre=
ed+0x2c0/0x2c0
Aug 27 17:37:15 kaveri kernel: [  703.633731]  ? do_raw_spin_unlock+0x54/=
0x220
Aug 27 17:37:15 kaveri kernel: [  703.633732]  amdgpu_drm_ioctl+0xcc/0x1b=
0 [amdgpu]
Aug 27 17:37:15 kaveri kernel: [  703.633732]  do_vfs_ioctl+0x192/0xf30
Aug 27 17:37:15 kaveri kernel: [  703.633733]  ? cpu_cgroup_fork+0x120/0x=
120
Aug 27 17:37:15 kaveri kernel: [  703.633733]  ? wake_up_new_task+0x645/0=
xb10
Aug 27 17:37:15 kaveri kernel: [  703.633734]  ? ioctl_preallocate+0x1b0/=
0x1b0
Aug 27 17:37:15 kaveri kernel: [  703.633734]  ? __fget+0x1c8/0x300
Aug 27 17:37:15 kaveri kernel: [  703.633735]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:37:15 kaveri kernel: [  703.633735]  ? __fget+0x49/0x300
Aug 27 17:37:15 kaveri kernel: [  703.633736]  ? lock_downgrade+0x5e0/0x5=
e0
Aug 27 17:37:15 kaveri kernel: [  703.633736]  ? __fget+0x1e0/0x300
Aug 27 17:37:15 kaveri kernel: [  703.633737]  ksys_ioctl+0x70/0x80
Aug 27 17:37:15 kaveri kernel: [  703.633737]  __x64_sys_ioctl+0x6f/0xb0
Aug 27 17:37:15 kaveri kernel: [  703.633737]  do_syscall_64+0xa5/0x3f0
Aug 27 17:37:15 kaveri kernel: [  703.633738]  entry_SYSCALL_64_after_hwf=
rame+0x49/0xbe
Aug 27 17:37:15 kaveri kernel: [  703.633738] RIP: 0033:0x7fafe8f46067
Aug 27 17:37:15 kaveri kernel: [  703.633739] Code: b3 66 90 48 8b 05 21 =
7e 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 0=
0 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 =
7d 0c 00 f7 d8 64 89 01 48=20
Aug 27 17:37:15 kaveri kernel: [  703.633757] RSP: 002b:00007fffc739b858 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 27 17:37:15 kaveri kernel: [  703.633758] RAX: ffffffffffffffda RBX: =
00007fffc739b940 RCX: 00007fafe8f46067
Aug 27 17:37:15 kaveri kernel: [  703.633759] RDX: 00007fffc739b8b0 RSI: =
00000000c0206440 RDI: 0000000000000006
Aug 27 17:37:15 kaveri kernel: [  703.633759] RBP: 00007fffc739b880 R08: =
000055919dcce650 R09: 0000000000000004
Aug 27 17:37:15 kaveri kernel: [  703.633760] R10: 0000000000000000 R11: =
0000000000000246 R12: 00007fffc739b8b0
Aug 27 17:37:15 kaveri kernel: [  703.633761] R13: 00000000c0206440 R14: =
0000000000000006 R15: 000055919dcce650
Aug 27 17:37:15 kaveri kernel: [  703.633763] NMI backtrace for cpu 10
Aug 27 17:37:15 kaveri kernel: [  703.633863] CPU: 10 PID: 5853 Comm: sha=
der_runner Tainted: G      D W  OE     4.18.0-rc1+ #111
Aug 27 17:37:15 kaveri kernel: [  703.633865] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Aug 27 17:37:15 kaveri kernel: [  703.633867] Call Trace:
Aug 27 17:37:15 kaveri kernel: [  703.633870]  <IRQ>
Aug 27 17:37:15 kaveri kernel: [  703.633875]  dump_stack+0x9a/0xeb
Aug 27 17:37:15 kaveri kernel: [  703.633880]  nmi_cpu_backtrace+0x126/0x=
140
Aug 27 17:37:15 kaveri kernel: [  703.633884]  ? lapic_can_unplug_cpu+0xa=
0/0xa0
Aug 27 17:37:15 kaveri kernel: [  703.633888]  nmi_trigger_cpumask_backtr=
ace+0xb9/0xf0
Aug 27 17:37:15 kaveri kernel: [  703.633892]  rcu_dump_cpu_stacks+0x18b/=
0x1d9
Aug 27 17:37:15 kaveri kernel: [  703.633897]  rcu_check_callbacks+0x1026=
/0x1e50
Aug 27 17:37:15 kaveri kernel: [  703.633905]  update_process_times+0x28/=
0x50
Aug 27 17:37:15 kaveri kernel: [  703.633908]  tick_sched_handle+0x73/0x1=
60
Aug 27 17:37:15 kaveri kernel: [  703.633912]  tick_sched_timer+0x37/0xf0=

Aug 27 17:37:15 kaveri kernel: [  703.633915]  ? tick_sched_do_timer+0x14=
0/0x140
Aug 27 17:37:15 kaveri kernel: [  703.633918]  __hrtimer_run_queues+0x291=
/0xa20
Aug 27 17:37:15 kaveri kernel: [  703.633924]  ? hrtimer_cancel+0x20/0x20=

Aug 27 17:37:15 kaveri kernel: [  703.633927]  ? ktime_get_update_offsets=
_now+0xed/0x2d0
Aug 27 17:37:15 kaveri kernel: [  703.633932]  hrtimer_interrupt+0x29a/0x=
770
Aug 27 17:37:15 kaveri kernel: [  703.633937]  ? rcu_nmi_enter+0x60/0x110=

Aug 27 17:37:15 kaveri kernel: [  703.633941]  smp_apic_timer_interrupt+0=
xd5/0x490
Aug 27 17:37:15 kaveri kernel: [  703.633945]  apic_timer_interrupt+0xf/0=
x20
Aug 27 17:37:15 kaveri kernel: [  703.633948]  </IRQ>

--------------10B1FD8BC2715A551034F9A4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------10B1FD8BC2715A551034F9A4--
