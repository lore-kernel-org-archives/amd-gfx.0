From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Subject: Re: [PATCH libdrm 0/4] Dynamicly disable suites and tets.
Date: Fri, 10 Nov 2017 18:43:44 -0500
Message-ID: <58c5d164-078d-74cc-b3ab-07bf6d39287c@amd.com>
References: <1510288203-21716-1-git-send-email-andrey.grodzovsky@amd.com>
 <fbf19682-a259-4105-7f4b-193524fe2dae@amd.com>
 <407f0a79-e15b-61b7-2e3a-8f4b680c9c6c@amd.com>
 <ebac16f5-4d16-d6e9-8bc0-5ee0de061719@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------218BCAF4D78BE7D3C138DE2D"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <ebac16f5-4d16-d6e9-8bc0-5ee0de061719@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--------------218BCAF4D78BE7D3C138DE2D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/10/2017 10:48 AM, Christian König wrote:
> Am 10.11.2017 um 16:36 schrieb Andrey Grodzovsky:
>>
>>
>> On 11/10/2017 07:17 AM, Christian König wrote:
>>> Series is Acked-by: Christian König <christian.koenig@amd.com>.
>>>
>>> Please note that I think your OOM killer test shows quite a bug we 
>>> currently have in the kernel driver.
>>>
>>> A single allocation of 1TB shouldn't trigger the OOM killer, but 
>>> rather be reacted immediately.
>>
>> Maybe we should add a second test which does incremental 1GB 
>> allocations but still keep this tests ? With this test  i get a 
>> callstack as bellow + crash of the test suite
>> with general protection fault - As normal behavior I would have 
>> expected just some errno returning from the amdgpu_bo_alloc which we 
>> could check in the test.
>
> Yeah, totally agree. And when this works correctly we should really 
> enable this test case by default as well.
>
> When I implemented scattered eviction I completely removed the check 
> which limited the BO size. That was probably a bit to extreme.
>
> We still need to check the size here so that we don't create a BO 
> larger than what makes sense for the domain it should be stored in.

Patch attached, tested with the DRM tester, call stack is gone but I 
still get SIGSEV and tester crashes, attaching debugger shows SIGSEV 
recived when the tester is still in the IOCTL -
r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_GEM_CREATE,
                 &args, sizeof(args));

dmesg

[  104.608664 <   16.227791>] [drm:amdgpu_bo_do_create [amdgpu]] *ERROR* 
BO size 1000000000000 > total memory in domain: 1073741824
[  104.608911 <    0.000247>] [drm:amdgpu_bo_do_create [amdgpu]] *ERROR* 
BO size 1000000000000 > total memory in domain: 3221225472
[  104.609168 <    0.000257>] [drm:amdgpu_gem_object_create [amdgpu]] 
*ERROR* Failed to allocate GEM object (1000000000000, 6, 4096, -12)
[  104.609301 <    0.000133>] traps: lt-amdgpu_test[1142] general 
protection ip:7f21c9ed6007 sp:7ffe08ae1e30 error:0 in 
libdrm_amdgpu.so.1.0.0[7f21c9ed2000+b000]


Thanks,
Andrey

>
> Regards,
> Christian.
>
>>
>> Thanks,
>> Andrey
>>
>> [169053.128981 <72032.811683>] ------------[ cut here ]------------
>> [169053.129006 <    0.000025>] WARNING: CPU: 0 PID: 22883 at 
>> mm/page_alloc.c:3883 __alloc_pages_slowpath+0xf03/0x14e0
>> [169053.129007 <    0.000001>] Modules linked in: amdgpu chash ttm 
>> drm_kms_helper drm i2c_algo_bit fb_sys_fops syscopyarea sysfillrect 
>> sysimgblt edac_mce_amd kvm_amd kvm irqbypass crct10dif_pclmul 
>> crc32_pclmul snd_hda_codec_realtek ghash_clmulni_intel 
>> snd_hda_codec_generic pcbc snd_hda_codec_hdmi snd_hda_intel 
>> aesni_intel snd_hda_codec aes_x86_64 snd_hda_core crypto_simd 
>> glue_helper snd_hwdep rfkill_gpio cryptd snd_pcm snd_seq_midi 
>> snd_seq_midi_event serio_raw snd_rawmidi snd_seq cdc_ether usbnet 
>> snd_seq_device joydev fam15h_power k10temp r8152 snd_timer mii 
>> i2c_piix4 rtsx_pci_ms snd memstick soundcore shpchp 8250_dw 
>> i2c_designware_platform i2c_designware_core mac_hid binfmt_misc nfsd 
>> auth_rpcgss nfs_acl lockd grace sunrpc parport_pc ppdev lp parport 
>> autofs4 rtsx_pci_sdmmc psmouse rtsx_pci sdhci_pci ahci sdhci libahci
>> [169053.129084 <    0.000077>]  video i2c_hid hid_generic usbhid hid
>> [169053.129096 <    0.000012>] CPU: 0 PID: 22883 Comm: lt-amdgpu_test 
>> Tainted: G        W       4.14.0-rc3+ #1
>> [169053.129097 <    0.000001>] Hardware name: AMD Gardenia/Gardenia, 
>> BIOS RGA1101C 07/20/2015
>> [169053.129099 <    0.000002>] task: ffff880048803d80 task.stack: 
>> ffff880064688000
>> [169053.129103 <    0.000004>] RIP: 
>> 0010:__alloc_pages_slowpath+0xf03/0x14e0
>> [169053.129105 <    0.000002>] RSP: 0018:ffff88006468f108 EFLAGS: 
>> 00010246
>> [169053.129108 <    0.000003>] RAX: 0000000000000000 RBX: 
>> 00000000014000c0 RCX: ffffffff81279065
>> [169053.129109 <    0.000001>] RDX: dffffc0000000000 RSI: 
>> 000000000000000f RDI: ffffffff82609000
>> [169053.129111 <    0.000002>] RBP: ffff88006468f328 R08: 
>> 0000000000000000 R09: ffffffffffff8576
>> [169053.129113 <    0.000002>] R10: 000000005c2044e7 R11: 
>> 0000000000000000 R12: ffff88006468f3d8
>> [169053.129114 <    0.000001>] R13: ffff880048803d80 R14: 
>> 000000000140c0c0 R15: 000000000000000f
>> [169053.129117 <    0.000003>] FS:  00007f707863b700(0000) 
>> GS:ffff88006ce00000(0000) knlGS:0000000000000000
>> [169053.129119 <    0.000002>] CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>> [169053.129120 <    0.000001>] CR2: 0000000001250000 CR3: 
>> 00000000644cf000 CR4: 00000000001406f0
>> [169053.129122 <    0.000002>] Call Trace:
>> [169053.129131 <    0.000009>]  ? __module_address+0x145/0x190
>> [169053.129135 <    0.000004>]  ? is_bpf_text_address+0xe/0x20
>> [169053.129140 <    0.000005>]  ? __kernel_text_address+0x12/0x40
>> [169053.129144 <    0.000004>]  ? unwind_get_return_address+0x36/0x50
>> [169053.129150 <    0.000006>]  ? memcmp+0x5b/0x90
>> [169053.129152 <    0.000002>]  ? warn_alloc+0x250/0x250
>> [169053.129156 <    0.000004>]  ? get_page_from_freelist+0x147/0x10f0
>> [169053.129160 <    0.000004>]  ? save_stack_trace+0x1b/0x20
>> [169053.129164 <    0.000004>]  ? kasan_kmalloc+0xad/0xe0
>> [169053.129186 <    0.000022>]  ? ttm_bo_mem_space+0x79/0x6b0 [ttm]
>> [169053.129196 <    0.000010>]  ? ttm_bo_validate+0x178/0x220 [ttm]
>> [169053.129200 <    0.000004>] __alloc_pages_nodemask+0x3c4/0x400
>> [169053.129203 <    0.000003>]  ? __alloc_pages_slowpath+0x14e0/0x14e0
>> [169053.129205 <    0.000002>]  ? __save_stack_trace+0x66/0xd0
>> [169053.129209 <    0.000004>]  ? rb_insert_color+0x32/0x3e0
>> [169053.129213 <    0.000004>]  ? do_syscall_64+0xea/0x280
>> [169053.129217 <    0.000004>] alloc_pages_current+0x75/0x110
>> [169053.129221 <    0.000004>]  kmalloc_order+0x1f/0x80
>> [169053.129223 <    0.000002>] kmalloc_order_trace+0x24/0xa0
>> [169053.129226 <    0.000003>]  __kmalloc+0x264/0x280
>> [169053.129383 <    0.000157>] amdgpu_vram_mgr_new+0x11b/0x3b0 [amdgpu]
>> [169053.129391 <    0.000008>]  ? 
>> reservation_object_reserve_shared+0x64/0xf0
>> [169053.129401 <    0.000010>] ttm_bo_mem_space+0x196/0x6b0 [ttm]
>> [169053.129478 <    0.000077>]  ? add_hole+0x20a/0x220 [drm]
>> [169053.129489 <    0.000011>] ttm_bo_validate+0x178/0x220 [ttm]
>> [169053.129498 <    0.000009>]  ? ttm_bo_evict_mm+0x70/0x70 [ttm]
>> [169053.129508 <    0.000010>]  ? ttm_check_swapping+0xf6/0x110 [ttm]
>> [169053.129541 <    0.000033>]  ? drm_vma_offset_add+0x5b/0x80 [drm]
>> [169053.129572 <    0.000031>]  ? drm_vma_offset_add+0x68/0x80 [drm]
>> [169053.129584 <    0.000012>] ttm_bo_init_reserved+0x546/0x630 [ttm]
>> [169053.129716 <    0.000132>] amdgpu_bo_do_create+0x28b/0x630 [amdgpu]
>> [169053.129816 <    0.000100>]  ? amdgpu_fill_buffer+0x580/0x580 
>> [amdgpu]
>> [169053.129952 <    0.000136>]  ? 
>> amdgpu_ttm_placement_from_domain+0x320/0x320 [amdgpu]
>> [169053.129956 <    0.000004>]  ? try_to_wake_up+0xbe/0x720
>> [169053.130054 <    0.000098>] amdgpu_bo_create+0x85/0x400 [amdgpu]
>> [169053.130153 <    0.000099>]  ? amdgpu_bo_do_create+0x630/0x630 
>> [amdgpu]
>> [169053.130155 <    0.000002>]  ? wake_up_process+0x15/0x20
>> [169053.130158 <    0.000003>]  ? insert_work+0xf3/0x110
>> [169053.130257 <    0.000099>] amdgpu_gem_object_create+0x101/0x190 
>> [amdgpu]
>> [169053.130356 <    0.000099>]  ? amdgpu_gem_object_free+0xe0/0xe0 
>> [amdgpu]
>> [169053.130360 <    0.000004>]  ? 
>> tty_insert_flip_string_fixed_flag+0xab/0x110
>> [169053.130468 <    0.000108>] amdgpu_gem_create_ioctl+0x364/0x460 
>> [amdgpu]
>> [169053.130695 <    0.000227>]  ? amdgpu_gem_object_close+0x320/0x320 
>> [amdgpu]
>> [169053.130767 <    0.000072>]  ? drm_dev_printk+0x120/0x120 [drm]
>> [169053.130840 <    0.000073>]  ? __wake_up_common_lock+0xe9/0x170
>> [169053.130989 <    0.000149>]  ? amdgpu_gem_object_close+0x320/0x320 
>> [amdgpu]
>> [169053.131061 <    0.000072>]  drm_ioctl_kernel+0xae/0xf0 [drm]
>> [169053.131115 <    0.000054>]  drm_ioctl+0x466/0x520 [drm]
>> [169053.131238 <    0.000123>]  ? amdgpu_gem_object_close+0x320/0x320 
>> [amdgpu]
>> [169053.131291 <    0.000053>]  ? drm_getunique+0xf0/0xf0 [drm]
>> [169053.131426 <    0.000135>]  amdgpu_drm_ioctl+0x78/0xd0 [amdgpu]
>> [169053.131451 <    0.000025>]  do_vfs_ioctl+0x12e/0x860
>> [169053.131466 <    0.000015>]  ? apparmor_file_permission+0x1a/0x20
>> [169053.131489 <    0.000023>]  ? ioctl_preallocate+0x130/0x130
>> [169053.131503 <    0.000014>]  ? rw_verify_area+0x78/0x140
>> [169053.131520 <    0.000017>]  ? vfs_write+0x1a2/0x260
>> [169053.131544 <    0.000024>]  ? syscall_trace_enter+0x1fd/0x520
>> [169053.131568 <    0.000024>]  ? sched_clock+0x9/0x10
>> [169053.131584 <    0.000016>]  ? exit_to_usermode_loop+0xc0/0xc0
>> [169053.131607 <    0.000023>]  ? __fget_light+0xa7/0xc0
>> [169053.131631 <    0.000024>]  SyS_ioctl+0x79/0x90
>> [169053.131651 <    0.000020>]  ? 
>> __context_tracking_exit.part.4+0x53/0xc0
>> [169053.131672 <    0.000021>]  ? do_vfs_ioctl+0x860/0x860
>> [169053.131683 <    0.000011>]  do_syscall_64+0xea/0x280
>> [169053.131708 <    0.000025>] entry_SYSCALL64_slow_path+0x25/0x25
>> [169053.131720 <    0.000012>] RIP: 0033:0x7f70778eef07
>> [169053.131740 <    0.000020>] RSP: 002b:00007ffc509d13d8 EFLAGS: 
>> 00000202 ORIG_RAX: 0000000000000010
>> [169053.131756 <    0.000016>] RAX: ffffffffffffffda RBX: 
>> 000000000000001e RCX: 00007f70778eef07
>> [169053.131778 <    0.000022>] RDX: 00007ffc509d1490 RSI: 
>> 00000000c0206440 RDI: 0000000000000004
>> [169053.131798 <    0.000020>] RBP: 00007ffc509d1410 R08: 
>> 000000000124c660 R09: 0000000000000000
>> [169053.131815 <    0.000017>] R10: 000000000000006e R11: 
>> 0000000000000202 R12: 000000000124b530
>> [169053.131835 <    0.000020>] R13: 00007ffc509d1800 R14: 
>> 0000000000000000 R15: 0000000000000000
>> [169053.131854 <    0.000019>] Code: 89 85 c8 fe ff ff e9 5d fc ff ff 
>> 8d 42 ff 45 31 f6 c6 85 d0 fe ff ff 01 89 85 c8 fe ff ff e9 45 fc ff 
>> ff 41 89 c5 e9 10 fc ff ff <0f> ff e9 ba f1 ff ff 0f ff 89 d8 25 ff 
>> ff f7 ff 89 85 8c fe ff
>> [169053.131933 <    0.000079>] ---[ end trace 8253dc1e92579724 ]---
>> [169053.132622 <    0.000689>] [drm:amdgpu_gem_object_create 
>> [amdgpu]] *ERROR* Failed to allocate GEM object (1000000000000, 6, 
>> 4096, -12)
>> [169053.132877 <    0.000255>] traps: lt-amdgpu_test[22883] general 
>> protection ip:7f7077ff6007 sp:7ffc509d13e0 error:0 in 
>> libdrm_amdgpu.so.1.0.0[7f7077ff2000+b000]
>>
>>
>>>
>>> Instead I expected that we need to do multiple 1GB allocations to 
>>> trigger the next problem that our TTM code doesn't imply a global 
>>> limit.
>>>
>>> Regards,
>>> Christian.
>>>
>>> Am 10.11.2017 um 05:29 schrieb Andrey Grodzovsky:
>>>> THe following  patch series intoroduce dynamic tests 
>>>> dusabling/enabling
>>>> in amdgpu  tester using Cunit API. Today test suits that
>>>> don't apply to specific HW just return success w/o executing while
>>>> single tests that can't be executed properly are commented out.
>>>>
>>>> Suits are diasbled based on hooks they provide (e.g incompatible
>>>> ASIC or missing blocks) while single tests are diasbled explicitly 
>>>> since this is
>>>> usually due to some bug preventing from the tester  or the system  
>>>> to handle
>>>> the test w/o crashing or killing the tester.
>>>>
>>>> Inside this series also a minor cleanup and new test for memory 
>>>> over allocation.
>>>>
>>>> Andrey Grodzovsky (4):
>>>>    amdgpu: Add functions to disable suites and tests.
>>>>    amdgpu: Use new suite/test disabling functionality.
>>>>    amdgpu: Move memory alloc tests in bo suite.
>>>>    amdgpu: Add memory over allocation test.
>>>>
>>>>   tests/amdgpu/amdgpu_test.c    | 169 
>>>> +++++++++++++++++++++++++++++++++++++-----
>>>>   tests/amdgpu/amdgpu_test.h    |  46 ++++++++++++
>>>>   tests/amdgpu/basic_tests.c    |  49 ------------
>>>>   tests/amdgpu/bo_tests.c       |  69 +++++++++++++++++
>>>>   tests/amdgpu/deadlock_tests.c |   8 +-
>>>>   tests/amdgpu/uvd_enc_tests.c  |  81 ++++++++------------
>>>>   tests/amdgpu/vce_tests.c      |  65 ++++++++--------
>>>>   tests/amdgpu/vcn_tests.c      |  74 ++++++++----------
>>>>   8 files changed, 363 insertions(+), 198 deletions(-)
>>>>
>>>
>>
>


--------------218BCAF4D78BE7D3C138DE2D
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-Implement-BO-size-validation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-Implement-BO-size-validation.patch"

>From 183abb730742cfc5b61374a3af575ca9ca4d731d Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Fri, 10 Nov 2017 18:35:56 -0500
Subject: drm/amdgpu: Implement BO size validation.

Validates BO size against each requested domain's total memory.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index a937c49..2737631 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -281,6 +281,42 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 		*cpu_addr = NULL;
 }
 
+/* Validate bo size is bit bigger then the request domain */
+static inline bool amdgpu_bo_validate_bo_size(struct amdgpu_device *adev,
+					  unsigned long size, u32 domain)
+{
+	struct ttm_mem_type_manager *man = NULL;
+
+	if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
+		man = &adev->mman.bdev.man[TTM_PL_VRAM];
+
+		if (man && size < (man->size << PAGE_SHIFT))
+			return true;
+	}
+
+	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
+		man = &adev->mman.bdev.man[TTM_PL_TT];
+
+		if (man && size < (man->size << PAGE_SHIFT))
+			return true;
+	}
+
+	if (domain & AMDGPU_GEM_DOMAIN_CPU) {
+		man = &adev->mman.bdev.man[TTM_PL_SYSTEM];
+
+		if (man && size < (man->size << PAGE_SHIFT))
+			return true;
+	}
+
+	if (man) {
+		DRM_ERROR("BO size %lu > total memory in domain: %llu\n", size,
+						      man->size << PAGE_SHIFT);
+		return false;
+	}
+
+	return true;
+}
+
 static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 			       unsigned long size, int byte_align,
 			       bool kernel, u32 domain, u64 flags,
@@ -299,6 +335,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	page_align = roundup(byte_align, PAGE_SIZE) >> PAGE_SHIFT;
 	size = ALIGN(size, PAGE_SIZE);
 
+	if (!amdgpu_bo_validate_bo_size(adev, size, domain))
+		return -ENOMEM;
+
 	if (kernel) {
 		type = ttm_bo_type_kernel;
 	} else if (sg) {
-- 
2.7.4


--------------218BCAF4D78BE7D3C138DE2D
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--------------218BCAF4D78BE7D3C138DE2D--
