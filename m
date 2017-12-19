From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Simplify amdgpu_lockup_timeout usage.
Date: Tue, 19 Dec 2017 18:26:08 +0100
Message-ID: <966ada12-9d57-b6bd-37a2-494f6dfa67cd@daenzer.net>
References: <1513194292-8416-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------5A9ACFB9EA085C8E4A579A97"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513194292-8416-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, christian.koenig-5C7GfCeVMHo@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------5A9ACFB9EA085C8E4A579A97
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 2017-12-13 08:44 PM, Andrey Grodzovsky wrote:
> With introduction of amdgpu_gpu_recovery we don't need any more
> to rely on amdgpu_lockup_timeout == 0 for disabling GPU reset.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>

Since this change landed, I'm once again unable to finish a piglit run
on my development machine, see the attached dmesg output (happens pretty
quickly, after ~5% of piglit tests have run). I realized that with
lockup_timeout != 0, the

	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_SYSTEM);

at the top of amdgpu_bo_gpu_offset has been triggering since the 4.15
development cycle. See the bisection result below. Note that I'm not
100% sure this is the correct guilty commit, since it's probably been
the most painful bisection I've ever done so far (14 skips, had to
revert 4 commits causing other regressions). But I'm quite sure this
regression happened in the
84d43463a2d09c28c9222fbb7d1082c078e2523a..3f3333f8a0e90ac26f84ed7b0aa344efce695c08
range.


3f3333f8a0e90ac26f84ed7b0aa344efce695c08 is the first bad commit
commit 3f3333f8a0e90ac26f84ed7b0aa344efce695c08
Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date:   Thu Aug 3 14:02:13 2017 +0200

    drm/amdgpu: track evicted page tables v2

    Instead of validating all page tables when one was evicted,
    track which one needs a validation.

    v2: simplify amdgpu_vm_ready as well

    Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org> (v1)
    Reviewed-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------5A9ACFB9EA085C8E4A579A97
Content-Type: text/x-patch;
 name="amdgpu_bo_gpu_offset-WARN.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="amdgpu_bo_gpu_offset-WARN.diff"

Dec 19 18:20:17 kaveri kernel: [   72.365066] WARNING: CPU: 7 PID: 3412 a=
t drivers/gpu/drm//amd/amdgpu/amdgpu_object.c:1027 amdgpu_bo_gpu_offset+0=
x2b7/0x380 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365089] Modules linked in: lz4 lz4_=
compress cpufreq_powersave cpufreq_userspace cpufreq_conservative binfmt_=
misc nls_ascii nls_cp437 vfat fat edac_mce_amd kvm amdkfd(O) irqbypass cr=
ct10dif_pclmul crc32_pclmul snd_hda_codec_realtek ghash_clmulni_intel amd=
gpu(O) radeon(O) pcbc snd_hda_codec_generic snd_hda_codec_hdmi efi_pstore=
 ttm(O) snd_hda_intel drm_kms_helper(O) ppdev wmi_bmof snd_hda_codec drm(=
O) snd_hda_core snd_hwdep aesni_intel ccp snd_pcm aes_x86_64 crypto_simd =
i2c_algo_bit glue_helper fb_sys_fops snd_timer r8169 syscopyarea sp5100_t=
co sysfillrect cryptd efivars pcspkr snd mfd_core sysimgblt soundcore rng=
_core i2c_piix4 mii sg parport_pc parport i2c_designware_platform i2c_des=
ignware_core wmi button acpi_cpufreq tcp_bbr sch_fq nct6775 hwmon_vid sun=
rpc efivarfs ip_tables x_tables autofs4
Dec 19 18:20:17 kaveri kernel: [   72.365154]  ext4 crc16 mbcache jbd2 fs=
crypto dm_mod raid10 raid1 raid0 multipath linear md_mod sd_mod evdev hid=
_generic usbhid hid ahci libahci xhci_pci crc32c_intel libata xhci_hcd us=
bcore scsi_mod shpchp gpio_amdpt gpio_generic
Dec 19 18:20:17 kaveri kernel: [   72.365179] CPU: 7 PID: 3412 Comm: amdg=
pu_cs:0 Tainted: G           O    4.13.0-rc5+ #53
Dec 19 18:20:17 kaveri kernel: [   72.365185] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 19 18:20:17 kaveri kernel: [   72.365187] task: ffff88039fc18f80 task=
=2Estack: ffff880392cb0000
Dec 19 18:20:17 kaveri kernel: [   72.365231] RIP: 0010:amdgpu_bo_gpu_off=
set+0x2b7/0x380 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365235] RSP: 0018:ffff880392cb6b30 =
EFLAGS: 00010246
Dec 19 18:20:17 kaveri kernel: [   72.365237] RAX: 0000000000000000 RBX: =
ffff880384f90000 RCX: 0000000000000000
Dec 19 18:20:17 kaveri kernel: [   72.365239] RDX: ffff880392cb6b98 RSI: =
0000000000000000 RDI: ffff880384f90000
Dec 19 18:20:17 kaveri kernel: [   72.365242] RBP: ffff880392cb6bc0 R08: =
ffff880392cb6cc8 R09: 0000000000000004
Dec 19 18:20:17 kaveri kernel: [   72.365244] R10: 0000000000100480 R11: =
0000000000100460 R12: ffff880384f900b4
Dec 19 18:20:17 kaveri kernel: [   72.365245] R13: ffff880358102800 R14: =
1ffff10072596d67 R15: dffffc0000000000
Dec 19 18:20:17 kaveri kernel: [   72.365247] FS:  00007fc0a896e700(0000)=
 GS:ffff8803ae5c0000(0000) knlGS:0000000000000000
Dec 19 18:20:17 kaveri kernel: [   72.365249] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Dec 19 18:20:17 kaveri kernel: [   72.365250] CR2: 00007f6a85312000 CR3: =
00000003806de000 CR4: 00000000003406e0
Dec 19 18:20:17 kaveri kernel: [   72.365251] Call Trace:
Dec 19 18:20:17 kaveri kernel: [   72.365298]  ? amdgpu_bo_fence+0x70/0x7=
0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365305]  ? unwind_get_return_addres=
s+0x66/0xb0
Dec 19 18:20:17 kaveri kernel: [   72.365351]  amdgpu_vm_update_ptes+0x4d=
5/0xa20 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365397]  ? amdgpu_vm_free_mapping.i=
sra.21+0x70/0x70 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365450]  ? amdgpu_vm_free_mapping.i=
sra.21+0x70/0x70 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365502]  ? amdgpu_vm_get_entry+0x37=
0/0x370 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365554]  ? amdgpu_sync_create+0x90/=
0x90 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365559]  ? __kmalloc+0x105/0x230
Dec 19 18:20:17 kaveri kernel: [   72.365604]  amdgpu_vm_frag_ptes+0x18a/=
0x1d0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365609]  ? reservation_object_reser=
ve_shared+0x167/0x200
Dec 19 18:20:17 kaveri kernel: [   72.365663]  amdgpu_vm_bo_update_mappin=
g.constprop.25+0x7f0/0x1020 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365668]  ? entry_SYSCALL_64_fastpat=
h+0x1e/0xa9
Dec 19 18:20:17 kaveri kernel: [   72.365671]  ? show_initstate+0xb0/0xb0=

Dec 19 18:20:17 kaveri kernel: [   72.365719]  ? amdgpu_vm_frag_ptes+0x1d=
0/0x1d0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365722]  ? unwind_next_frame.part.5=
+0x1bb/0xc90
Dec 19 18:20:17 kaveri kernel: [   72.365724]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:17 kaveri kernel: [   72.365727]  ? __free_insn_slot+0x6a0/0=
x6a0
Dec 19 18:20:17 kaveri kernel: [   72.365729]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:17 kaveri kernel: [   72.365769]  ? amdgpu_vm_free_mapping.i=
sra.21+0x70/0x70 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365805]  amdgpu_vm_bo_update+0x986/=
0x16f0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365843]  ? amdgpu_vm_bo_update_mapp=
ing.constprop.25+0x1020/0x1020 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365879]  ? amdgpu_vm_bo_update+0xae=
2/0x16f0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365882]  ? save_stack_trace+0x1b/0x=
20
Dec 19 18:20:17 kaveri kernel: [   72.365884]  ? kasan_slab_alloc+0x12/0x=
20
Dec 19 18:20:17 kaveri kernel: [   72.365885]  ? kmem_cache_alloc+0xb7/0x=
1c0
Dec 19 18:20:17 kaveri kernel: [   72.365919]  ? amdgpu_cs_ioctl+0x3e9d/0=
x75f0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365934]  ? drm_ioctl_kernel+0x1ce/0=
x330 [drm]
Dec 19 18:20:17 kaveri kernel: [   72.365936]  ? entry_SYSCALL_64_fastpat=
h+0x1e/0xa9
Dec 19 18:20:17 kaveri kernel: [   72.365973]  ? amdgpu_vm_bo_update_mapp=
ing.constprop.25+0x1020/0x1020 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.365975]  ? kasan_slab_free+0x88/0xc=
0
Dec 19 18:20:17 kaveri kernel: [   72.366023]  ? amdgpu_job_free+0x6d/0x8=
0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366025]  ? kfree+0x94/0x1a0
Dec 19 18:20:17 kaveri kernel: [   72.366061]  ? amdgpu_vm_update_level+0=
xb48/0x11f0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366064]  ? kasan_unpoison_shadow+0x=
35/0x50
Dec 19 18:20:17 kaveri kernel: [   72.366065]  ? kasan_kmalloc+0xad/0xe0
Dec 19 18:20:17 kaveri kernel: [   72.366102]  amdgpu_vm_clear_moved+0x17=
4/0x270 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366139]  ? amdgpu_sync_fence+0x164/=
0x7c0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366175]  ? amdgpu_vm_clear_freed+0x=
690/0x690 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366208]  ? amdgpu_cs_list_validate+=
0x1fb/0x350 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366242]  amdgpu_cs_ioctl+0x7096/0x7=
5f0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366277]  ? amdgpu_cs_find_mapping+0=
x470/0x470 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366279]  ? show_initstate+0xb0/0xb0=

Dec 19 18:20:17 kaveri kernel: [   72.366282]  ? bpf_prog_alloc+0x320/0x3=
20
Dec 19 18:20:17 kaveri kernel: [   72.366285]  ? unwind_next_frame.part.5=
+0x1bb/0xc90
Dec 19 18:20:17 kaveri kernel: [   72.366286]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:17 kaveri kernel: [   72.366288]  ? __free_insn_slot+0x6a0/0=
x6a0
Dec 19 18:20:17 kaveri kernel: [   72.366290]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:17 kaveri kernel: [   72.366293]  ? radix_tree_node_alloc.co=
nstprop.19+0x4a/0x2d0
Dec 19 18:20:17 kaveri kernel: [   72.366295]  ? __radix_tree_lookup+0xa9=
/0x8b0
Dec 19 18:20:17 kaveri kernel: [   72.366299]  ? __kernel_text_address+0x=
bf/0xf0
Dec 19 18:20:17 kaveri kernel: [   72.366300]  ? unwind_get_return_addres=
s+0x66/0xb0
Dec 19 18:20:17 kaveri kernel: [   72.366302]  ? __save_stack_trace+0x92/=
0x100
Dec 19 18:20:17 kaveri kernel: [   72.366305]  ? depot_save_stack+0x121/0=
x470
Dec 19 18:20:17 kaveri kernel: [   72.366310]  ? radix_tree_delete+0x10/0=
x10
Dec 19 18:20:17 kaveri kernel: [   72.366313]  ? radix_tree_iter_tag_clea=
r+0x86/0xe0
Dec 19 18:20:17 kaveri kernel: [   72.366315]  ? radix_tree_iter_replace+=
0x3a/0x60
Dec 19 18:20:17 kaveri kernel: [   72.366317]  ? idr_alloc+0x10b/0x1f0
Dec 19 18:20:17 kaveri kernel: [   72.366320]  ? kvfree+0x51/0x70
Dec 19 18:20:17 kaveri kernel: [   72.366321]  ? kfree+0x94/0x1a0
Dec 19 18:20:17 kaveri kernel: [   72.366323]  ? kvfree+0x51/0x70
Dec 19 18:20:17 kaveri kernel: [   72.366360]  ? amdgpu_bo_list_ioctl+0x3=
b7/0x960 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366397]  ? amdgpu_bo_list_free+0x14=
0/0x140 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366400]  ? put_prev_entity+0xef/0x3=
70
Dec 19 18:20:17 kaveri kernel: [   72.366403]  ? __check_object_size+0x22=
e/0x560
Dec 19 18:20:17 kaveri kernel: [   72.366437]  ? amdgpu_cs_find_mapping+0=
x470/0x470 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366450]  drm_ioctl_kernel+0x1ce/0x3=
30 [drm]
Dec 19 18:20:17 kaveri kernel: [   72.366464]  ? drm_ioctl_permit+0x2c0/0=
x2c0 [drm]
Dec 19 18:20:17 kaveri kernel: [   72.366466]  ? kasan_check_write+0x14/0=
x20
Dec 19 18:20:17 kaveri kernel: [   72.366479]  drm_ioctl+0x79a/0xc30 [drm=
]
Dec 19 18:20:17 kaveri kernel: [   72.366513]  ? amdgpu_cs_find_mapping+0=
x470/0x470 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366527]  ? drm_getstats+0x20/0x20 [=
drm]
Dec 19 18:20:17 kaveri kernel: [   72.366530]  ? __fget+0x4c/0x5b0
Dec 19 18:20:17 kaveri kernel: [   72.366533]  ? schedule+0x10e/0x450
Dec 19 18:20:17 kaveri kernel: [   72.366562]  amdgpu_drm_ioctl+0xd8/0x1b=
0 [amdgpu]
Dec 19 18:20:17 kaveri kernel: [   72.366565]  do_vfs_ioctl+0x197/0x1490
Dec 19 18:20:17 kaveri kernel: [   72.366567]  ? exit_to_usermode_loop+0x=
12a/0x230
Dec 19 18:20:17 kaveri kernel: [   72.366569]  ? ioctl_preallocate+0x2c0/=
0x2c0
Dec 19 18:20:17 kaveri kernel: [   72.366571]  ? __fget_light+0x2be/0x410=

Dec 19 18:20:17 kaveri kernel: [   72.366634]  ? iterate_fd+0x2e0/0x2e0
Dec 19 18:20:17 kaveri kernel: [   72.366637]  ? SyS_futex+0x271/0x430
Dec 19 18:20:17 kaveri kernel: [   72.366639]  ? syscall_return_slowpath+=
0x1d8/0x240
Dec 19 18:20:17 kaveri kernel: [   72.366642]  ? do_futex+0x23c0/0x23c0
Dec 19 18:20:17 kaveri kernel: [   72.366643]  ? prepare_exit_to_usermode=
+0x124/0x160
Dec 19 18:20:17 kaveri kernel: [   72.366645]  SyS_ioctl+0x79/0x90
Dec 19 18:20:17 kaveri kernel: [   72.366648]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Dec 19 18:20:17 kaveri kernel: [   72.366650] RIP: 0033:0x7fc0b39a55d7
Dec 19 18:20:17 kaveri kernel: [   72.366651] RSP: 002b:00007fc0a896dcb8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Dec 19 18:20:17 kaveri kernel: [   72.366654] RAX: ffffffffffffffda RBX: =
0000000138bf30d8 RCX: 00007fc0b39a55d7
Dec 19 18:20:17 kaveri kernel: [   72.366655] RDX: 00007fc0a896dd20 RSI: =
00000000c0186444 RDI: 0000000000000006
Dec 19 18:20:17 kaveri kernel: [   72.366656] RBP: 00007fc0a896de90 R08: =
00007fc0a896ddd0 R09: 00007fc0a896dda8
Dec 19 18:20:17 kaveri kernel: [   72.366657] R10: 00007fc0a896ddd0 R11: =
0000000000000246 R12: 0000000138bf3100
Dec 19 18:20:17 kaveri kernel: [   72.366659] R13: 0000000138ba01e0 R14: =
0000000000000000 R15: 0000000138bf30d0
Dec 19 18:20:17 kaveri kernel: [   72.366661] Code: 00 00 48 89 95 70 ff =
ff ff e8 46 36 ff ff 84 c0 48 8b 95 70 ff ff ff 0f 85 02 fe ff ff 0f ff e=
9 fb fd ff ff 0f ff e9 e1 fe ff ff <0f> ff e9 ed fd ff ff 4c 89 e7 e8 0a =
4c f1 dc e9 f7 fe ff ff 4c=20

[...]

Dec 19 18:20:23 kaveri kernel: [   73.670912] BUG: unable to handle kerne=
l paging request at 00000000003f8070
Dec 19 18:20:23 kaveri kernel: [   73.670929] IP: kmem_cache_alloc+0x7b/0=
x1c0
Dec 19 18:20:23 kaveri kernel: [   73.670932] PGD 38ba2c067=20
Dec 19 18:20:23 kaveri kernel: [   73.670934] P4D 38ba2c067=20
Dec 19 18:20:23 kaveri kernel: [   73.670936] PUD 0=20
Dec 19 18:20:23 kaveri kernel: [   73.670938]=20
Dec 19 18:20:23 kaveri kernel: [   73.670943] Oops: 0000 [#1] SMP KASAN
Dec 19 18:20:23 kaveri kernel: [   73.670946] Modules linked in: lz4 lz4_=
compress cpufreq_powersave cpufreq_userspace cpufreq_conservative binfmt_=
misc nls_ascii nls_cp437 vfat fat edac_mce_amd kvm amdkfd(O) irqbypass cr=
ct10dif_pclmul crc32_pclmul snd_hda_codec_realtek ghash_clmulni_intel amd=
gpu(O) radeon(O) pcbc snd_hda_codec_generic snd_hda_codec_hdmi efi_pstore=
 ttm(O) snd_hda_intel drm_kms_helper(O) ppdev wmi_bmof snd_hda_codec drm(=
O) snd_hda_core snd_hwdep aesni_intel ccp snd_pcm aes_x86_64 crypto_simd =
i2c_algo_bit glue_helper fb_sys_fops snd_timer r8169 syscopyarea sp5100_t=
co sysfillrect cryptd efivars pcspkr snd mfd_core sysimgblt soundcore rng=
_core i2c_piix4 mii sg parport_pc parport i2c_designware_platform i2c_des=
ignware_core wmi button acpi_cpufreq tcp_bbr sch_fq nct6775 hwmon_vid sun=
rpc efivarfs ip_tables x_tables autofs4
Dec 19 18:20:23 kaveri kernel: [   73.671009]  ext4 crc16 mbcache jbd2 fs=
crypto dm_mod raid10 raid1 raid0 multipath linear md_mod sd_mod evdev hid=
_generic usbhid hid ahci libahci xhci_pci crc32c_intel libata xhci_hcd us=
bcore scsi_mod shpchp gpio_amdpt gpio_generic
Dec 19 18:20:23 kaveri kernel: [   73.671036] CPU: 1 PID: 6892 Comm: amdg=
pu_cs:0 Tainted: G    B   W  O    4.13.0-rc5+ #53
Dec 19 18:20:23 kaveri kernel: [   73.671040] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 19 18:20:23 kaveri kernel: [   73.671043] task: ffff8803a9c6be00 task=
=2Estack: ffff8803590d0000
Dec 19 18:20:23 kaveri kernel: [   73.671048] RIP: 0010:kmem_cache_alloc+=
0x7b/0x1c0
Dec 19 18:20:23 kaveri kernel: [   73.671051] RSP: 0018:ffff8803590d6c30 =
EFLAGS: 00010202
Dec 19 18:20:23 kaveri kernel: [   73.671055] RAX: 0000000000000000 RBX: =
00000000014000c0 RCX: 0000000000007c70
Dec 19 18:20:23 kaveri kernel: [   73.671058] RDX: 0000000000007c6f RSI: =
00000000014000c0 RDI: 000060fc51601470
Dec 19 18:20:23 kaveri kernel: [   73.671060] RBP: ffff8803590d6c60 R08: =
ffffe8ffffa41470 R09: 1ffff10071a50c00
Dec 19 18:20:23 kaveri kernel: [   73.671062] R10: ffff88038d280000 R11: =
1ffff1007538d91b R12: 00000000003f8070
Dec 19 18:20:23 kaveri kernel: [   73.671064] R13: 00000000014000c0 R14: =
ffff88039dc42680 R15: ffff88039dc42680
Dec 19 18:20:23 kaveri kernel: [   73.671066] FS:  00007f5eb90c4700(0000)=
 GS:ffff8803ae440000(0000) knlGS:0000000000000000
Dec 19 18:20:23 kaveri kernel: [   73.671068] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Dec 19 18:20:23 kaveri kernel: [   73.671070] CR2: 00000000003f8070 CR3: =
0000000386156000 CR4: 00000000003406e0
Dec 19 18:20:23 kaveri kernel: [   73.671072] Call Trace:
Dec 19 18:20:23 kaveri kernel: [   73.671115]  ? amdgpu_sync_fence+0x23b/=
0x7c0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671155]  amdgpu_sync_fence+0x23b/0x=
7c0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671194]  ? amdgpu_sync_create+0x90/=
0x90 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671197]  ? __kmalloc+0x105/0x230
Dec 19 18:20:23 kaveri kernel: [   73.671236]  amdgpu_sync_resv+0xe7/0x2b=
0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671275]  amdgpu_vm_bo_update_mappin=
g.constprop.25+0x6cc/0x1020 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671280]  ? entry_SYSCALL_64_fastpat=
h+0x1e/0xa9
Dec 19 18:20:23 kaveri kernel: [   73.671283]  ? show_initstate+0xb0/0xb0=

Dec 19 18:20:23 kaveri kernel: [   73.671322]  ? amdgpu_vm_frag_ptes+0x1d=
0/0x1d0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671325]  ? unwind_next_frame.part.5=
+0x1bb/0xc90
Dec 19 18:20:23 kaveri kernel: [   73.671328]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:23 kaveri kernel: [   73.671331]  ? __free_insn_slot+0x6a0/0=
x6a0
Dec 19 18:20:23 kaveri kernel: [   73.671333]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:23 kaveri kernel: [   73.671371]  ? amdgpu_vm_free_mapping.i=
sra.21+0x70/0x70 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671410]  amdgpu_vm_bo_update+0x986/=
0x16f0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671457]  ? amdgpu_vm_bo_update_mapp=
ing.constprop.25+0x1020/0x1020 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671512]  ? amdgpu_vm_bo_update+0xae=
2/0x16f0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671516]  ? save_stack_trace+0x1b/0x=
20
Dec 19 18:20:23 kaveri kernel: [   73.671519]  ? kasan_slab_alloc+0x12/0x=
20
Dec 19 18:20:23 kaveri kernel: [   73.671522]  ? kmem_cache_alloc+0xb7/0x=
1c0
Dec 19 18:20:23 kaveri kernel: [   73.671567]  ? amdgpu_cs_ioctl+0x3e9d/0=
x75f0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671593]  ? drm_ioctl_kernel+0x1ce/0=
x330 [drm]
Dec 19 18:20:23 kaveri kernel: [   73.671598]  ? entry_SYSCALL_64_fastpat=
h+0x1e/0xa9
Dec 19 18:20:23 kaveri kernel: [   73.671664]  ? amdgpu_vm_bo_update_mapp=
ing.constprop.25+0x1020/0x1020 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671669]  ? kasan_slab_free+0x88/0xc=
0
Dec 19 18:20:23 kaveri kernel: [   73.671737]  ? amdgpu_job_free+0x6d/0x8=
0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671740]  ? kfree+0x94/0x1a0
Dec 19 18:20:23 kaveri kernel: [   73.671778]  ? amdgpu_vm_update_level+0=
xb48/0x11f0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671782]  ? kasan_unpoison_shadow+0x=
35/0x50
Dec 19 18:20:23 kaveri kernel: [   73.671784]  ? kasan_kmalloc+0xad/0xe0
Dec 19 18:20:23 kaveri kernel: [   73.671823]  amdgpu_vm_clear_moved+0x17=
4/0x270 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671861]  ? amdgpu_sync_fence+0x164/=
0x7c0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671900]  ? amdgpu_vm_clear_freed+0x=
690/0x690 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671936]  ? amdgpu_cs_list_validate+=
0x1fb/0x350 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.671973]  amdgpu_cs_ioctl+0x7096/0x7=
5f0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.672011]  ? amdgpu_cs_find_mapping+0=
x470/0x470 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.672014]  ? show_initstate+0xb0/0xb0=

Dec 19 18:20:23 kaveri kernel: [   73.672017]  ? bpf_prog_alloc+0x320/0x3=
20
Dec 19 18:20:23 kaveri kernel: [   73.672020]  ? unwind_next_frame.part.5=
+0x1bb/0xc90
Dec 19 18:20:23 kaveri kernel: [   73.672023]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:23 kaveri kernel: [   73.672026]  ? __free_insn_slot+0x6a0/0=
x6a0
Dec 19 18:20:23 kaveri kernel: [   73.672028]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:23 kaveri kernel: [   73.672032]  ? radix_tree_node_alloc.co=
nstprop.19+0x4a/0x2d0
Dec 19 18:20:23 kaveri kernel: [   73.672037]  ? __kernel_text_address+0x=
bf/0xf0
Dec 19 18:20:23 kaveri kernel: [   73.672039]  ? unwind_get_return_addres=
s+0x66/0xb0
Dec 19 18:20:23 kaveri kernel: [   73.672042]  ? __save_stack_trace+0x92/=
0x100
Dec 19 18:20:23 kaveri kernel: [   73.672045]  ? depot_save_stack+0x121/0=
x470
Dec 19 18:20:23 kaveri kernel: [   73.672050]  ? radix_tree_delete+0x10/0=
x10
Dec 19 18:20:23 kaveri kernel: [   73.672054]  ? radix_tree_iter_tag_clea=
r+0x86/0xe0
Dec 19 18:20:23 kaveri kernel: [   73.672056]  ? radix_tree_iter_replace+=
0x3a/0x60
Dec 19 18:20:23 kaveri kernel: [   73.672059]  ? idr_alloc+0x10b/0x1f0
Dec 19 18:20:23 kaveri kernel: [   73.672063]  ? kvfree+0x51/0x70
Dec 19 18:20:23 kaveri kernel: [   73.672065]  ? kfree+0x94/0x1a0
Dec 19 18:20:23 kaveri kernel: [   73.672068]  ? kvfree+0x51/0x70
Dec 19 18:20:23 kaveri kernel: [   73.672106]  ? amdgpu_bo_list_ioctl+0x3=
b7/0x960 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.672146]  ? amdgpu_bo_list_free+0x14=
0/0x140 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.672149]  ? __check_object_size+0x22=
e/0x560
Dec 19 18:20:23 kaveri kernel: [   73.672186]  ? amdgpu_cs_find_mapping+0=
x470/0x470 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.672201]  drm_ioctl_kernel+0x1ce/0x3=
30 [drm]
Dec 19 18:20:23 kaveri kernel: [   73.672216]  ? drm_ioctl_permit+0x2c0/0=
x2c0 [drm]
Dec 19 18:20:23 kaveri kernel: [   73.672218]  ? depot_save_stack+0x121/0=
x470
Dec 19 18:20:23 kaveri kernel: [   73.672221]  ? kasan_check_write+0x14/0=
x20
Dec 19 18:20:23 kaveri kernel: [   73.672235]  drm_ioctl+0x79a/0xc30 [drm=
]
Dec 19 18:20:23 kaveri kernel: [   73.672271]  ? amdgpu_cs_find_mapping+0=
x470/0x470 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.672287]  ? drm_getstats+0x20/0x20 [=
drm]
Dec 19 18:20:23 kaveri kernel: [   73.672290]  ? unmap_region+0x32c/0x4f0=

Dec 19 18:20:23 kaveri kernel: [   73.672293]  ? do_vfs_ioctl+0x197/0x149=
0
Dec 19 18:20:23 kaveri kernel: [   73.672300]  ? ttm_bo_move_to_lru_tail+=
0x20/0x20 [ttm]
Dec 19 18:20:23 kaveri kernel: [   73.672302]  ? reusable_anon_vma+0x590/=
0x590
Dec 19 18:20:23 kaveri kernel: [   73.672305]  ? schedule+0x10e/0x450
Dec 19 18:20:23 kaveri kernel: [   73.672348]  amdgpu_drm_ioctl+0xd8/0x1b=
0 [amdgpu]
Dec 19 18:20:23 kaveri kernel: [   73.672352]  do_vfs_ioctl+0x197/0x1490
Dec 19 18:20:23 kaveri kernel: [   73.672358]  ? userfaultfd_unmap_prep+0=
x580/0x580
Dec 19 18:20:23 kaveri kernel: [   73.672362]  ? kasan_slab_free+0x88/0xc=
0
Dec 19 18:20:23 kaveri kernel: [   73.672365]  ? ioctl_preallocate+0x2c0/=
0x2c0
Dec 19 18:20:23 kaveri kernel: [   73.672370]  ? __fget_light+0x2be/0x410=

Dec 19 18:20:23 kaveri kernel: [   73.672373]  ? iterate_fd+0x2e0/0x2e0
Dec 19 18:20:23 kaveri kernel: [   73.672378]  ? SyS_futex+0x271/0x430
Dec 19 18:20:23 kaveri kernel: [   73.672383]  ? do_futex+0x23c0/0x23c0
Dec 19 18:20:23 kaveri kernel: [   73.672387]  ? do_munmap+0xf00/0xf00
Dec 19 18:20:23 kaveri kernel: [   73.672390]  ? do_vfs_ioctl+0x11/0x1490=

Dec 19 18:20:23 kaveri kernel: [   73.672394]  SyS_ioctl+0x79/0x90
Dec 19 18:20:23 kaveri kernel: [   73.672399]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Dec 19 18:20:23 kaveri kernel: [   73.672402] RIP: 0033:0x7f5ec40fb5d7
Dec 19 18:20:23 kaveri kernel: [   73.672405] RSP: 002b:00007f5eb90c3cb8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Dec 19 18:20:23 kaveri kernel: [   73.672409] RAX: ffffffffffffffda RBX: =
00007f5eb90c3da8 RCX: 00007f5ec40fb5d7
Dec 19 18:20:23 kaveri kernel: [   73.672412] RDX: 00007f5eb90c3d20 RSI: =
00000000c0186444 RDI: 0000000000000006
Dec 19 18:20:23 kaveri kernel: [   73.672415] RBP: 00007f5eb90c3ce0 R08: =
00007f5eb90c3dd0 R09: 00007f5eb90c3da8
Dec 19 18:20:23 kaveri kernel: [   73.672418] R10: 00007f5eb90c3dd0 R11: =
0000000000000246 R12: 00007f5eb90c3d20
Dec 19 18:20:23 kaveri kernel: [   73.672421] R13: 00000000c0186444 R14: =
0000000000000006 R15: 0000004949663b68
Dec 19 18:20:23 kaveri kernel: [   73.672425] Code: 08 65 4c 03 05 37 be =
4b 61 49 83 78 10 00 4d 8b 20 0f 84 03 01 00 00 4d 85 e4 0f 84 fa 00 00 0=
0 49 63 47 20 49 8b 3f 48 8d 4a 01 <49> 8b 1c 04 4c 89 e0 65 48 0f c7 0f =
0f 94 c0 84 c0 74 bb 49 63=20
Dec 19 18:20:23 kaveri kernel: [   73.672479] RIP: kmem_cache_alloc+0x7b/=
0x1c0 RSP: ffff8803590d6c30
Dec 19 18:20:23 kaveri kernel: [   73.672481] CR2: 00000000003f8070
Dec 19 18:20:23 kaveri kernel: [   73.672486] ---[ end trace 434e2dbb9068=
85f3 ]---
Dec 19 18:20:23 kaveri kernel: [   77.783092] BUG: Bad page map in proces=
s depthrange-clea  pte:00000070 pmd:25f3c6067
Dec 19 18:20:23 kaveri kernel: [   77.783368] addr:00007f5378190000 vm_fl=
ags:08200070 anon_vma:          (null) mapping:          (null) index:7f5=
378190
Dec 19 18:20:23 kaveri kernel: [   77.783371] file:          (null) fault=
:          (null) mmap:          (null) readpage:          (null)
Dec 19 18:20:23 kaveri kernel: [   77.783376] CPU: 3 PID: 7110 Comm: dept=
hrange-clea Tainted: G    B D W  O    4.13.0-rc5+ #53
Dec 19 18:20:23 kaveri kernel: [   77.783378] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Dec 19 18:20:23 kaveri kernel: [   77.783380] Call Trace:
Dec 19 18:20:23 kaveri kernel: [   77.783387]  dump_stack+0xb8/0x152
Dec 19 18:20:23 kaveri kernel: [   77.783390]  ? dma_virt_map_sg+0x1fe/0x=
1fe
Dec 19 18:20:23 kaveri kernel: [   77.783396]  print_bad_pte+0x593/0x9d0
Dec 19 18:20:23 kaveri kernel: [   77.783399]  ? pmd_devmap_trans_unstabl=
e+0xd0/0xd0
Dec 19 18:20:23 kaveri kernel: [   77.783403]  ? __get_free_pages+0xf/0x8=
0
Dec 19 18:20:23 kaveri kernel: [   77.783408]  unmap_page_range+0xfd0/0x1=
a30
Dec 19 18:20:23 kaveri kernel: [   77.783411]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:23 kaveri kernel: [   77.783415]  ? vm_normal_page_pmd+0x260=
/0x260
Dec 19 18:20:23 kaveri kernel: [   77.783417]  ? is_bpf_text_address+0xe/=
0x20
Dec 19 18:20:23 kaveri kernel: [   77.783421]  ? __kernel_text_address+0x=
bf/0xf0
Dec 19 18:20:23 kaveri kernel: [   77.783423]  ? unwind_get_return_addres=
s+0x66/0xb0
Dec 19 18:20:23 kaveri kernel: [   77.783426]  ? __khugepaged_exit+0x40e/=
0x630
Dec 19 18:20:23 kaveri kernel: [   77.783429]  ? save_stack+0xa3/0xd0
Dec 19 18:20:23 kaveri kernel: [   77.783431]  ? save_stack+0x43/0xd0
Dec 19 18:20:23 kaveri kernel: [   77.783699]  ? kasan_slab_free+0x72/0xc=
0
Dec 19 18:20:23 kaveri kernel: [   77.783701]  ? kmem_cache_free+0x7a/0x1=
e0
Dec 19 18:20:23 kaveri kernel: [   77.783704]  ? __khugepaged_exit+0x40e/=
0x630
Dec 19 18:20:23 kaveri kernel: [   77.783707]  ? mmput+0x46a/0x5c0
Dec 19 18:20:23 kaveri kernel: [   77.783709]  ? do_exit+0x7ec/0x1490
Dec 19 18:20:23 kaveri kernel: [   77.783711]  ? do_group_exit+0x130/0x3a=
0
Dec 19 18:20:23 kaveri kernel: [   77.783714]  ? entry_SYSCALL_64_fastpat=
h+0x1e/0xa9
Dec 19 18:20:23 kaveri kernel: [   77.783716]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:23 kaveri kernel: [   77.783719]  ? __free_insn_slot+0x6a0/0=
x6a0
Dec 19 18:20:23 kaveri kernel: [   77.783721]  ? unwind_dump+0x4e0/0x4e0
Dec 19 18:20:23 kaveri kernel: [   77.783723]  ? wake_up_page_bit+0x310/0=
x310
Dec 19 18:20:23 kaveri kernel: [   77.783726]  ? uprobe_mmap+0xcc0/0xcc0
Dec 19 18:20:23 kaveri kernel: [   77.783729]  ? unwind_get_return_addres=
s+0x66/0xb0
Dec 19 18:20:23 kaveri kernel: [   77.783731]  unmap_single_vma+0x12a/0x3=
00
Dec 19 18:20:23 kaveri kernel: [   77.783734]  unmap_vmas+0xdd/0x190
Dec 19 18:20:23 kaveri kernel: [   77.783736]  exit_mmap+0x1dd/0x3b0
Dec 19 18:20:23 kaveri kernel: [   77.783738]  ? SyS_munmap+0x30/0x30
Dec 19 18:20:23 kaveri kernel: [   77.783740]  ? __khugepaged_exit+0x40e/=
0x630
Dec 19 18:20:23 kaveri kernel: [   77.783743]  ? __delayacct_add_tsk+0x4b=
a/0x670
Dec 19 18:20:23 kaveri kernel: [   77.783745]  mmput+0x16d/0x5c0
Dec 19 18:20:23 kaveri kernel: [   77.783748]  ? mmdrop_async_fn+0x20/0x2=
0
Dec 19 18:20:23 kaveri kernel: [   77.783750]  ? mm_release+0x156/0x4f0
Dec 19 18:20:23 kaveri kernel: [   77.783752]  ? down_read+0x72/0x140
Dec 19 18:20:23 kaveri kernel: [   77.783754]  ? mm_access+0x120/0x120
Dec 19 18:20:23 kaveri kernel: [   77.783756]  ? down_read+0x72/0x140
Dec 19 18:20:23 kaveri kernel: [   77.783758]  ? __down_interruptible+0x6=
b0/0x6b0
Dec 19 18:20:23 kaveri kernel: [   77.783761]  ? acct_collect+0x20a/0x7d0=

Dec 19 18:20:23 kaveri kernel: [   77.783763]  do_exit+0x7ec/0x1490
Dec 19 18:20:23 kaveri kernel: [   77.783766]  ? alloc_pages_current+0xd9=
/0x1b0
Dec 19 18:20:23 kaveri kernel: [   77.784033]  ? _raw_write_lock_irqsave+=
0x40/0x40
Dec 19 18:20:23 kaveri kernel: [   77.784035]  ? mm_update_next_owner+0xe=
b0/0xeb0
Dec 19 18:20:23 kaveri kernel: [   77.784038]  ? __pmd_alloc+0x300/0x300
Dec 19 18:20:23 kaveri kernel: [   77.784041]  ? firmware_map_remove+0x80=
/0x80
Dec 19 18:20:23 kaveri kernel: [   77.784045]  ? __wake_up+0x44/0x50
Dec 19 18:20:23 kaveri kernel: [   77.784047]  ? schedule+0x10e/0x450
Dec 19 18:20:23 kaveri kernel: [   77.784049]  ? __schedule+0x1c80/0x1c80=

Dec 19 18:20:23 kaveri kernel: [   77.784052]  ? mem_cgroup_oom_synchroni=
ze+0xa80/0xa80
Dec 19 18:20:23 kaveri kernel: [   77.784054]  ? filp_close+0x169/0x210
Dec 19 18:20:23 kaveri kernel: [   77.784056]  ? file_path+0x20/0x20
Dec 19 18:20:23 kaveri kernel: [   77.784058]  ? mem_cgroup_reset+0x2c0/0=
x2c0
Dec 19 18:20:23 kaveri kernel: [   77.784061]  ? exit_to_usermode_loop+0x=
191/0x230
Dec 19 18:20:23 kaveri kernel: [   77.784064]  ? handle_mm_fault+0x292/0x=
800
Dec 19 18:20:23 kaveri kernel: [   77.784066]  ? __handle_mm_fault+0x5070=
/0x5070
Dec 19 18:20:23 kaveri kernel: [   77.784068]  do_group_exit+0x130/0x3a0
Dec 19 18:20:23 kaveri kernel: [   77.784070]  ? SyS_exit+0x30/0x30
Dec 19 18:20:23 kaveri kernel: [   77.784072]  ? __do_page_fault+0x43a/0x=
a00
Dec 19 18:20:23 kaveri kernel: [   77.784074]  ? perf_trace_sys_enter+0x1=
080/0x1080
Dec 19 18:20:23 kaveri kernel: [   77.784077]  SyS_exit_group+0x1d/0x20
Dec 19 18:20:23 kaveri kernel: [   77.784079]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Dec 19 18:20:23 kaveri kernel: [   77.784082] RIP: 0033:0x7f5390131a38
Dec 19 18:20:23 kaveri kernel: [   77.784084] RSP: 002b:00007ffc63d3dd68 =
EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
Dec 19 18:20:23 kaveri kernel: [   77.784087] RAX: ffffffffffffffda RBX: =
000000750884e600 RCX: 00007f5390131a38
Dec 19 18:20:23 kaveri kernel: [   77.784088] RDX: 0000000000000000 RSI: =
000000000000003c RDI: 0000000000000000
Dec 19 18:20:23 kaveri kernel: [   77.784092] RBP: 00007ffc63d3dd60 R08: =
00000000000000e7 R09: ffffffffffffff60
Dec 19 18:20:23 kaveri kernel: [   77.784093] R10: 00007f53842f1150 R11: =
0000000000000246 R12: 00007f5386f329d8
Dec 19 18:20:23 kaveri kernel: [   77.784095] R13: 00007ffc63d3dc88 R14: =
00007f5393526040 R15: 0000000000000000
Dec 19 18:20:23 kaveri kernel: [   77.784098] swap_info_get: Bad swap fil=
e entry 1000000000000000

[lots of similar splats omitted]

--------------5A9ACFB9EA085C8E4A579A97
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------5A9ACFB9EA085C8E4A579A97--
