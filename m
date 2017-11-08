From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH 2/4] drm/ttm: consistently use reservation_object_unlock
Date: Wed, 8 Nov 2017 18:37:30 +0100
Message-ID: <048441ef-bff0-2d17-f0e8-de478e176847@daenzer.net>
References: <20171108145936.27071-1-christian.koenig@amd.com>
 <20171108145936.27071-2-christian.koenig@amd.com>
 <ebffaae6-675a-1a7b-9a48-b816c1c5bf40@daenzer.net>
 <089ed82b-02c9-0b73-6bfd-a0ef39215ba7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------4575859153FF741C9AFFFC3A"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <089ed82b-02c9-0b73-6bfd-a0ef39215ba7@gmail.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: christian.koenig@amd.com, Hongbo.He@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--------------4575859153FF741C9AFFFC3A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 08/11/17 05:41 PM, Christian König wrote:
> Am 08.11.2017 um 17:36 schrieb Michel Dänzer:
>> On 08/11/17 03:59 PM, Christian König wrote:
>>> Instead of having a pointless wrapper or call the underlying ww_mutex
>>> function directly.
>> Not sure I can agree it's pointless, since it recently took me a while
>> to realize that unlocking bo->resv is essentially the same as
>> unreserving the BO.
> 
> Ok in this case let's call this confusing. But yeah that
> __ttm_bo_unreserv(bo), reservation_object_unlock(bo->resv) and
> ww_mutex_unlock(&bo->resv->lock) are essentially the same thing is
> exactly what I want to fix here.

How about always using __ttm_bo_unreserve instead?


The first piglit run with this series applied hit the BUG_ON in
ttm_bo_add_to_lru, see the attached dmesg excerpt. The machine hung,
couldn't reboot cleanly. Haven't been able to reproduce it in three more
attempts though, so I'm not sure it's caused by this series, but I don't
remember seeing it before.


P.S. I just noticed I haven't had CONFIG_PROVE_LOCKING enabled in my
kernels for a while, I'll enable it again. Any other options that should
be enabled for testing?


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--------------4575859153FF741C9AFFFC3A
Content-Type: text/x-log;
 name="kern.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="kern.log"

Nov  8 17:54:48 kaveri kernel: [ 1084.244694] ------------[ cut here ]---=
---------
Nov  8 17:54:48 kaveri kernel: [ 1084.244697] kernel BUG at drivers/gpu/d=
rm//ttm/ttm_bo.c:172!
Nov  8 17:54:48 kaveri kernel: [ 1084.244703] invalid opcode: 0000 [#1] S=
MP KASAN
Nov  8 17:54:48 kaveri kernel: [ 1084.244705] Modules linked in: lz4 lz4_=
compress cpufreq_powersave cpufreq_userspace cpufreq_conservative binfmt_=
misc nls_ascii nls_cp437 vfat fat edac_mce_amd amdgpu(O) amdkfd(O) radeon=
(O) kvm snd_hda_codec_realtek chash irqbypass snd_hda_codec_generic ttm(O=
) snd_hda_codec_hdmi crct10dif_pclmul crc32_pclmul drm_kms_helper(O) ghas=
h_clmulni_intel efi_pstore snd_hda_intel pcbc snd_hda_codec drm(O) snd_hd=
a_core snd_hwdep wmi_bmof snd_pcm snd_timer i2c_algo_bit fb_sys_fops snd =
aesni_intel syscopyarea ccp sysfillrect aes_x86_64 r8169 crypto_simd sp51=
00_tco ppdev glue_helper cryptd sg sysimgblt mfd_core mii soundcore rng_c=
ore pcspkr efivars i2c_piix4 parport_pc wmi parport i2c_designware_platfo=
rm i2c_designware_core button acpi_cpufreq tcp_bbr sch_fq nct6775 hwmon_v=
id sunrpc efivarfs ip_tables x_tables
Nov  8 17:54:48 kaveri kernel: [ 1084.244743]  autofs4 ext4 crc16 mbcache=
 jbd2 fscrypto dm_mod raid10 raid1 raid0 multipath linear md_mod sd_mod e=
vdev hid_generic usbhid hid ahci xhci_pci libahci xhci_hcd libata crc32c_=
intel usbcore scsi_mod shpchp gpio_amdpt gpio_generic
Nov  8 17:54:48 kaveri kernel: [ 1084.244766] CPU: 13 PID: 4778 Comm: tex=
3d-maxsize Tainted: G           O    4.14.0-rc3+ #32
Nov  8 17:54:48 kaveri kernel: [ 1084.244768] Hardware name: Micro-Star I=
nternational Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.80 09/13/2=
017
Nov  8 17:54:48 kaveri kernel: [ 1084.244770] task: ffff880233de6c80 task=
=2Estack: ffff880225ce0000
Nov  8 17:54:48 kaveri kernel: [ 1084.244779] RIP: 0010:ttm_bo_add_to_lru=
+0x4fe/0x640 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244780] RSP: 0018:ffff880225ce6d60 =
EFLAGS: 00010206
Nov  8 17:54:48 kaveri kernel: [ 1084.244783] RAX: dffffc0000000000 RBX: =
ffff88038de24cd8 RCX: 0000000000000000
Nov  8 17:54:48 kaveri kernel: [ 1084.244784] RDX: 1ffff10044b9cdb4 RSI: =
0000000000000000 RDI: ffff88038de24ce0
Nov  8 17:54:48 kaveri kernel: [ 1084.244786] RBP: 1ffff10044b9cdb0 R08: =
0000000007cbd06c R09: 0000000000000000
Nov  8 17:54:48 kaveri kernel: [ 1084.244788] R10: ffffffff93daac8e R11: =
0000000000057de4 R12: 1ffff10044b9cdb4
Nov  8 17:54:48 kaveri kernel: [ 1084.244791] R13: ffff880388033c88 R14: =
ffff88038de24d88 R15: ffff88038a452718
Nov  8 17:54:48 kaveri kernel: [ 1084.244794] FS:  00007fa01e650300(0000)=
 GS:ffff8803ae740000(0000) knlGS:0000000000000000
Nov  8 17:54:48 kaveri kernel: [ 1084.244797] CS:  0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033
Nov  8 17:54:48 kaveri kernel: [ 1084.244799] CR2: 00007faecd0f06f0 CR3: =
000000038b7d3000 CR4: 00000000003406e0
Nov  8 17:54:48 kaveri kernel: [ 1084.244801] Call Trace:
Nov  8 17:54:48 kaveri kernel: [ 1084.244823]  ? drm_mm_init+0x4d0/0x4d0 =
[drm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244832]  ? ttm_bo_device_init+0x620=
/0x620 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244837]  ? __kernel_text_address+0x=
e/0x30
Nov  8 17:54:48 kaveri kernel: [ 1084.244841]  ? bpf_prog_alloc+0x2d0/0x2=
d0
Nov  8 17:54:48 kaveri kernel: [ 1084.244844]  ? deref_stack_reg+0x1f0/0x=
1f0
Nov  8 17:54:48 kaveri kernel: [ 1084.244851]  ttm_mem_evict_first+0x473/=
0x5c0 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244857]  ? ttm_bo_evict+0xc70/0xc70=
 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244863]  ttm_bo_mem_space+0x89d/0xe=
d0 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244869]  ? ttm_bo_mem_compat+0x6b/0=
x130 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244874]  ttm_bo_validate+0x301/0x53=
0 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244879]  ? ttm_bo_evict_mm+0xa0/0xa=
0 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244882]  ? SyS_membarrier+0x2b0/0x2=
b0
Nov  8 17:54:48 kaveri kernel: [ 1084.244896]  ? drm_vma_offset_add+0xb4/=
0x180 [drm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244902]  ttm_bo_init_reserved+0xaf3=
/0x1200 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244908]  ? ttm_bo_validate+0x530/0x=
530 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244913]  ? get_empty_filp+0x27b/0x5=
30
Nov  8 17:54:48 kaveri kernel: [ 1084.244914]  ? proc_nr_files+0x30/0x30
Nov  8 17:54:48 kaveri kernel: [ 1084.244919]  ? _copy_to_user+0x90/0x90
Nov  8 17:54:48 kaveri kernel: [ 1084.244922]  ? alloc_file+0x16d/0x440
Nov  8 17:54:48 kaveri kernel: [ 1084.244926]  ? __shmem_file_setup+0x2af=
/0x480
Nov  8 17:54:48 kaveri kernel: [ 1084.244981]  ? amdgpu_vm_clear_freed+0x=
28d/0x5d0 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.244993]  ? drm_gem_private_object_i=
nit+0x18a/0x2e0 [drm]
Nov  8 17:54:48 kaveri kernel: [ 1084.244997]  ? kasan_kmalloc+0xa0/0xd0
Nov  8 17:54:48 kaveri kernel: [ 1084.245038]  amdgpu_bo_do_create+0x549/=
0x1260 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245079]  ? amdgpu_fill_buffer+0x9f0=
/0x9f0 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245082]  ? show_initstate+0xb0/0xb0=

Nov  8 17:54:48 kaveri kernel: [ 1084.245122]  ? amdgpu_ttm_placement_fro=
m_domain+0x8a0/0x8a0 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245126]  ? reservation_object_test_=
signaled_rcu+0xb40/0xb40
Nov  8 17:54:48 kaveri kernel: [ 1084.245128]  ? deref_stack_reg+0x1f0/0x=
1f0
Nov  8 17:54:48 kaveri kernel: [ 1084.245132]  ? __free_insn_slot+0x4c0/0=
x4c0
Nov  8 17:54:48 kaveri kernel: [ 1084.245134]  ? reservation_object_add_e=
xcl_fence+0x380/0x380
Nov  8 17:54:48 kaveri kernel: [ 1084.245137]  ? is_bpf_text_address+0xa/=
0x20
Nov  8 17:54:48 kaveri kernel: [ 1084.245139]  ? __kernel_text_address+0x=
e/0x30
Nov  8 17:54:48 kaveri kernel: [ 1084.245141]  ? unwind_get_return_addres=
s+0x5f/0xa0
Nov  8 17:54:48 kaveri kernel: [ 1084.245182]  amdgpu_bo_create+0xba/0x88=
0 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245188]  ? ttm_bo_release_list+0x7d=
0/0x7d0 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.245228]  ? amdgpu_bo_do_create+0x12=
60/0x1260 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245233]  ? ttm_bo_unref+0x493/0x9e0=
 [ttm]
Nov  8 17:54:48 kaveri kernel: [ 1084.245237]  ? __radix_tree_insert+0x7e=
0/0x7e0
Nov  8 17:54:48 kaveri kernel: [ 1084.245278]  amdgpu_gem_object_create+0=
x10d/0x210 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245320]  ? amdgpu_gem_object_free+0=
x180/0x180 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245323]  ? __ww_mutex_lock_interrup=
tible_slowpath+0x20/0x20
Nov  8 17:54:48 kaveri kernel: [ 1084.245325]  ? __radix_tree_delete+0x13=
f/0x1c0
Nov  8 17:54:48 kaveri kernel: [ 1084.245367]  amdgpu_gem_create_ioctl+0x=
37d/0xa10 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245408]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245410]  ? radix_tree_lookup+0x10/0=
x10
Nov  8 17:54:48 kaveri kernel: [ 1084.245413]  ? memset+0x1f/0x40
Nov  8 17:54:48 kaveri kernel: [ 1084.245416]  ? __inode_attach_wb+0xb90/=
0xb90
Nov  8 17:54:48 kaveri kernel: [ 1084.245420]  ? __check_object_size+0x21=
7/0x4a0
Nov  8 17:54:48 kaveri kernel: [ 1084.245461]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245472]  drm_ioctl_kernel+0x1ba/0x2=
c0 [drm]
Nov  8 17:54:48 kaveri kernel: [ 1084.245484]  ? drm_ioctl_permit+0x2b0/0=
x2b0 [drm]
Nov  8 17:54:48 kaveri kernel: [ 1084.245486]  ? get_device_system_crosst=
stamp+0x850/0x850
Nov  8 17:54:48 kaveri kernel: [ 1084.245498]  drm_ioctl+0x720/0xa30 [drm=
]
Nov  8 17:54:48 kaveri kernel: [ 1084.245540]  ? amdgpu_gem_object_close+=
0x790/0x790 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245551]  ? drm_getstats+0x20/0x20 [=
drm]
Nov  8 17:54:48 kaveri kernel: [ 1084.245555]  ? pipe_write+0x633/0xe30
Nov  8 17:54:48 kaveri kernel: [ 1084.245594]  amdgpu_drm_ioctl+0xcc/0x1a=
0 [amdgpu]
Nov  8 17:54:48 kaveri kernel: [ 1084.245598]  do_vfs_ioctl+0x18f/0x1270
Nov  8 17:54:48 kaveri kernel: [ 1084.245600]  ? ioctl_preallocate+0x2a0/=
0x2a0
Nov  8 17:54:48 kaveri kernel: [ 1084.245603]  ? __fget_light+0x2b0/0x3b0=

Nov  8 17:54:48 kaveri kernel: [ 1084.245605]  ? iterate_fd+0x2a0/0x2a0
Nov  8 17:54:48 kaveri kernel: [ 1084.245607]  ? vfs_write+0x32d/0x450
Nov  8 17:54:48 kaveri kernel: [ 1084.245610]  ? do_page_fault+0x93/0x320=

Nov  8 17:54:48 kaveri kernel: [ 1084.245612]  ? SyS_write+0x128/0x1e0
Nov  8 17:54:48 kaveri kernel: [ 1084.245614]  ? SyS_read+0x1e0/0x1e0
Nov  8 17:54:48 kaveri kernel: [ 1084.245616]  SyS_ioctl+0x74/0x80
Nov  8 17:54:48 kaveri kernel: [ 1084.245619]  entry_SYSCALL_64_fastpath+=
0x1e/0xa9
Nov  8 17:54:48 kaveri kernel: [ 1084.245621] RIP: 0033:0x7fa01b2f4dc7
Nov  8 17:54:48 kaveri kernel: [ 1084.245622] RSP: 002b:00007ffc3e617fb8 =
EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Nov  8 17:54:48 kaveri kernel: [ 1084.245625] RAX: ffffffffffffffda RBX: =
0000562a26dd0d80 RCX: 00007fa01b2f4dc7
Nov  8 17:54:48 kaveri kernel: [ 1084.245626] RDX: 00007ffc3e618000 RSI: =
00000000c0206440 RDI: 0000000000000006
Nov  8 17:54:48 kaveri kernel: [ 1084.245627] RBP: 00007ffc3e617ef0 R08: =
00007fa01b5ac158 R09: 0000000000000060
Nov  8 17:54:48 kaveri kernel: [ 1084.245629] R10: 0000000000000004 R11: =
0000000000000246 R12: 0000562a26dcfea0
Nov  8 17:54:48 kaveri kernel: [ 1084.245630] R13: 0000000000000001 R14: =
00000000000000c0 R15: 0000000000000000
Nov  8 17:54:48 kaveri kernel: [ 1084.245632] Code: 03 80 3c 02 00 0f 85 =
f8 00 00 00 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df 4d 89 7d 00 41 c6 0=
4 04 f8 f0 ff 43 34 e9 49 fe ff ff <0f> 0b e8 5b 06 cf d0 e9 99 fb ff ff =
e8 51 06 cf d0 e9 2b fe ff=20
Nov  8 17:54:48 kaveri kernel: [ 1084.245661] RIP: ttm_bo_add_to_lru+0x4f=
e/0x640 [ttm] RSP: ffff880225ce6d60
Nov  8 17:54:48 kaveri kernel: [ 1084.245676] ---[ end trace da3cb1c26802=
a840 ]---


--------------4575859153FF741C9AFFFC3A
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--------------4575859153FF741C9AFFFC3A--
