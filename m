From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Kernel deadlock in amdgpu_job_submit
Date: Wed, 17 Aug 2016 13:47:55 +0200
Message-ID: <a55ff119-39e0-0ddc-7e91-670746d18f4c@vodafone.de>
References: <CAAxE2A7Ls610ae20AUocC=a07Zm9uLLTV4yhBXSQ29ESGZ-0tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1725691859=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A7Ls610ae20AUocC=a07Zm9uLLTV4yhBXSQ29ESGZ-0tA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============1725691859==
Content-Type: multipart/alternative;
 boundary="------------C2875B4514862F560A03230D"

This is a multi-part message in MIME format.
--------------C2875B4514862F560A03230D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

[11160.387924] [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110 
[amdgpu]
[11160.387927]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11160.387943]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11160.387953]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11160.387963]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]

It's blocked waiting for previous swap jobs to complete.

Take a look at amdgpu_fence_info, could just be a GPU hang.

Christian.

Am 17.08.2016 um 13:22 schrieb Marek Olšák:
> Hi,
>
> I have a kernel deadlock here. Piglit tests running at the same time:
>
> marek    32295  0.0  0.6 472148 50100 ?        Ssl  12:53 0:00 
> /home/marek/dev/piglit/bin/gl-1.0-blend-func -auto -fbo
> marek    32403  0.0  0.6 532528 55908 ?        Ssl  12:53 0:00 
> /home/marek/dev/piglit/bin/tex3d -auto
> marek    32409  6.5  0.7 536616 62092 ?        Ssl  12:53 1:30 
> /home/marek/dev/piglit/bin/tex3d-maxsize -auto
> marek    32426  0.0  0.6 467872 48920 ?        Ssl  12:53 0:00 
> /home/marek/dev/piglit/bin/texture-packed-formats -auto
>
> dmesg:
>
> The failures are sort of expected behavior. The deadlock is not:
>
> [10757.929057] [TTM] Failed to find memory space for buffer 
> 0xffff88020f0c5468 eviction
> [10757.929061] [TTM] No space for ffff88020f0c5468 (263168 pages, 
> 1052672K, 1028M)
> [10757.929062] [TTM]   placement[0]=0x00060002 (1)
> [10757.929063] [TTM]     has_type: 1
> [10757.929063] [TTM]     use_type: 1
> [10757.929064] [TTM]     flags: 0x0000000A
> [10757.929065] [TTM]     gpu_offset: 0x80000000
> [10757.929065] [TTM]     size: 524288
> [10757.929066] [TTM]     available_caching: 0x00070000
> [10757.929066] [TTM]     default_caching: 0x00010000
> [10757.929105] [TTM] Failed to find memory space for buffer 
> 0xffff88020f0c5468 eviction
> [10757.929106] [TTM] No space for ffff88020f0c5468 (263168 pages, 
> 1052672K, 1028M)
> [10757.929107] [TTM]   placement[0]=0x00060002 (1)
> [10757.929108] [TTM]     has_type: 1
> [10757.929108] [TTM]     use_type: 1
> [10757.929109] [TTM]     flags: 0x0000000A
> [10757.929110] [TTM]     gpu_offset: 0x80000000
> [10757.929110] [TTM]     size: 524288
> [10757.929111] [TTM]     available_caching: 0x00070000
> [10757.929111] [TTM]     default_caching: 0x00010000
> [10757.929127] [TTM] Failed to find memory space for buffer 
> 0xffff88020f0c5468 eviction
> [10757.929128] [TTM] No space for ffff88020f0c5468 (263168 pages, 
> 1052672K, 1028M)
> [10757.929129] [TTM]   placement[0]=0x00060002 (1)
> [10757.929130] [TTM]     has_type: 1
> [10757.929131] [TTM]     use_type: 1
> [10757.929132] [TTM]     flags: 0x0000000A
> [10757.929132] [TTM]     gpu_offset: 0x80000000
> [10757.929133] [TTM]     size: 524288
> [10757.929133] [TTM]     available_caching: 0x00070000
> [10757.929134] [TTM]     default_caching: 0x00010000
> [10757.929136] [TTM] Failed to find memory space for buffer 
> 0xffff88020f0c5468 eviction
> [10757.929137] [TTM] No space for ffff88020f0c5468 (263168 pages, 
> 1052672K, 1028M)
> [10757.929138] [TTM]   placement[0]=0x00060002 (1)
> [10757.929138] [TTM]     has_type: 1
> [10757.929139] [TTM]     use_type: 1
> [10757.929139] [TTM]     flags: 0x0000000A
> [10757.929140] [TTM]     gpu_offset: 0x80000000
> [10757.929140] [TTM]     size: 524288
> [10757.929141] [TTM]     available_caching: 0x00070000
> [10757.929141] [TTM]     default_caching: 0x00010000
> [10757.929182] [drm:amdgpu_gem_object_create [amdgpu]] *ERROR* Failed 
> to allocate GEM object (1077936128, 6, 131072, -12)
> [10848.046814] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to 
> process the buffer list -16!
> [10938.047062] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to 
> process the buffer list -16!
> [11160.387854] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [11160.387859]       Not tainted 4.7.0-si+ #1
> [11160.387861] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [11160.387863] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [11160.387868]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [11160.387871]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [11160.387874]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [11160.387877] Call Trace:
> [11160.387885]  [<ffffffff8180f575>] schedule+0x35/0x80
> [11160.387924]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [11160.387927]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [11160.387943]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [11160.387953]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [11160.387963]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [11160.387973]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [11160.387977]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [11160.387979]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [11160.387990]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [11160.388000]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [11160.388003]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [11160.388013]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [11160.388023]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [11160.388031]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [11160.388034]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [11160.388035]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [11160.388037]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [11160.388039]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [11280.388317] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [11280.388322]       Not tainted 4.7.0-si+ #1
> [11280.388323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [11280.388325] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [11280.388331]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [11280.388334]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [11280.388337]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [11280.388340] Call Trace:
> [11280.388349]  [<ffffffff8180f575>] schedule+0x35/0x80
> [11280.388387]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [11280.388390]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [11280.388405]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [11280.388415]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [11280.388425]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [11280.388434]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [11280.388438]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [11280.388441]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [11280.388452]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [11280.388462]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [11280.388464]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [11280.388474]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [11280.388484]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [11280.388493]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [11280.388495]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [11280.388497]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [11280.388499]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [11280.388501]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [11400.388859] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [11400.388862]       Not tainted 4.7.0-si+ #1
> [11400.388863] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [11400.388864] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [11400.388866]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [11400.388868]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [11400.388869]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [11400.388870] Call Trace:
> [11400.388876]  [<ffffffff8180f575>] schedule+0x35/0x80
> [11400.388899]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [11400.388902]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [11400.388917]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [11400.388928]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [11400.388938]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [11400.388947]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [11400.388951]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [11400.388953]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [11400.388964]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [11400.388974]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [11400.388976]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [11400.388986]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [11400.388996]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [11400.389005]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [11400.389007]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [11400.389009]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [11400.389010]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [11400.389012]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [11520.389297] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [11520.389300]       Not tainted 4.7.0-si+ #1
> [11520.389301] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [11520.389302] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [11520.389304]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [11520.389306]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [11520.389307]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [11520.389309] Call Trace:
> [11520.389313]  [<ffffffff8180f575>] schedule+0x35/0x80
> [11520.389337]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [11520.389340]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [11520.389355]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [11520.389366]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [11520.389375]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [11520.389385]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [11520.389389]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [11520.389391]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [11520.389402]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [11520.389412]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [11520.389414]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [11520.389424]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [11520.389434]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [11520.389443]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [11520.389445]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [11520.389447]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [11520.389448]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [11520.389450]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [11640.389659] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [11640.389664]       Not tainted 4.7.0-si+ #1
> [11640.389665] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [11640.389667] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [11640.389672]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [11640.389676]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [11640.389679]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [11640.389682] Call Trace:
> [11640.389690]  [<ffffffff8180f575>] schedule+0x35/0x80
> [11640.389729]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [11640.389732]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [11640.389747]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [11640.389758]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [11640.389768]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [11640.389777]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [11640.389781]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [11640.389784]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [11640.389795]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [11640.389805]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [11640.389807]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [11640.389817]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [11640.389828]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [11640.389837]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [11640.389839]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [11640.389840]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [11640.389842]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [11640.389844]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [11760.390205] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [11760.390208]       Not tainted 4.7.0-si+ #1
> [11760.390208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [11760.390209] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [11760.390212]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [11760.390213]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [11760.390215]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [11760.390216] Call Trace:
> [11760.390221]  [<ffffffff8180f575>] schedule+0x35/0x80
> [11760.390244]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [11760.390247]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [11760.390262]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [11760.390273]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [11760.390282]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [11760.390291]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [11760.390296]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [11760.390298]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [11760.390309]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [11760.390319]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [11760.390321]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [11760.390331]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [11760.390341]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [11760.390350]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [11760.390352]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [11760.390353]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [11760.390355]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [11760.390357]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [11880.390520] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [11880.390525]       Not tainted 4.7.0-si+ #1
> [11880.390527] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [11880.390529] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [11880.390534]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [11880.390538]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [11880.390541]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [11880.390544] Call Trace:
> [11880.390552]  [<ffffffff8180f575>] schedule+0x35/0x80
> [11880.390591]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [11880.390594]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [11880.390609]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [11880.390619]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [11880.390629]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [11880.390639]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [11880.390643]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [11880.390646]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [11880.390657]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [11880.390667]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [11880.390669]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [11880.390679]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [11880.390690]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [11880.390699]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [11880.390701]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [11880.390703]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [11880.390704]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [11880.390706]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [12000.390944] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [12000.390949]       Not tainted 4.7.0-si+ #1
> [12000.390950] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [12000.390953] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [12000.390958]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [12000.390961]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [12000.390964]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [12000.390967] Call Trace:
> [12000.390976]  [<ffffffff8180f575>] schedule+0x35/0x80
> [12000.391014]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [12000.391017]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [12000.391032]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [12000.391043]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [12000.391053]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [12000.391062]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [12000.391066]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [12000.391069]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [12000.391080]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [12000.391090]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [12000.391092]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [12000.391103]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [12000.391113]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [12000.391122]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [12000.391124]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [12000.391126]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [12000.391127]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [12000.391129]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [12120.391376] INFO: task Xorg:2636 blocked for more than 120 seconds.
> [12120.391381]       Not tainted 4.7.0-si+ #1
> [12120.391383] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [12120.391385] Xorg            D ffff88020f643898     0 2636   2624 
> 0x00400004
> [12120.391390]  ffff88020f643898 ffff880034ba0000 ffff88021522c740 
> ffff88020e9b0e40
> [12120.391393]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 
> ffff880034ba1ee0
> [12120.391396]  0000000000000000 ffff880034ba0000 ffff88020f6438b0 
> ffffffff8180f575
> [12120.391399] Call Trace:
> [12120.391407]  [<ffffffff8180f575>] schedule+0x35/0x80
> [12120.391445]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [12120.391448]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [12120.391463]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [12120.391474]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [12120.391484]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [12120.391493]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
> [12120.391497]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [12120.391500]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [12120.391511]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [12120.391522]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
> [12120.391524]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
> [12120.391534]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [12120.391544]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [12120.391553]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [12120.391555]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [12120.391557]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
> [12120.391558]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [12120.391560]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
> [12120.391583] INFO: task qtcreator:712 blocked for more than 120 seconds.
> [12120.391584]       Not tainted 4.7.0-si+ #1
> [12120.391584] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
> disables this message.
> [12120.391585] qtcreator       D ffff8800854af7c8     0 712   2661 
> 0x00000000
> [12120.391586]  ffff8800854af7c8 ffff880034ba0000 ffff88021522c740 
> ffff8801a0870000
> [12120.391588]  ffff880034ba1f00 ffff8800854b0000 ffff8800854af8e8 
> ffff880034ba1ee0
> [12120.391589]  0000000000000000 ffff880034ba0000 ffff8800854af7e0 
> ffffffff8180f575
> [12120.391590] Call Trace:
> [12120.391592]  [<ffffffff8180f575>] schedule+0x35/0x80
> [12120.391606]  [<ffffffffc01b1a57>] 
> amd_sched_entity_push_job+0x77/0x110 [amdgpu]
> [12120.391608]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
> [12120.391621]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
> [12120.391630]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 
> [amdgpu]
> [12120.391640]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
> [12120.391649]  [<ffffffffc0145d24>] amdgpu_move_ram_vram+0x134/0x170 
> [amdgpu]
> [12120.391651]  [<ffffffff811ba4e8>] ? krealloc+0x28/0xc0
> [12120.391661]  [<ffffffffc0145fa1>] amdgpu_bo_move+0x241/0x270 [amdgpu]
> [12120.391664]  [<ffffffffc00e9bc9>] 
> ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]
> [12120.391666]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
> [12120.391668]  [<ffffffff811ba4e8>] ? krealloc+0x28/0xc0
> [12120.391678]  [<ffffffffc014d30f>] 
> amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]
> [12120.391688]  [<ffffffffc014e450>] amdgpu_cs_ioctl+0xe50/0x10c0 [amdgpu]
> [12120.391696]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
> [12120.391705]  [<ffffffffc014d600>] ? 
> amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]
> [12120.391707]  [<ffffffff81191f96>] ? unlock_page+0x76/0x80
> [12120.391709]  [<ffffffff811c828a>] ? handle_mm_fault+0x11ea/0x1d90
> [12120.391717]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
> [12120.391719]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
> [12120.391721]  [<ffffffff81069515>] ? __do_page_fault+0x205/0x4d0
> [12120.391722]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
> [12120.391724]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
>
> Marek
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------C2875B4514862F560A03230D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">[11160.387924] 
      [&lt;ffffffffc01b1a57&gt;] amd_sched_entity_push_job+0x77/0x110
      [amdgpu]<br>
      [11160.387927]  [&lt;ffffffff810c3490&gt;] ?
      wake_atomic_t_function+0x60/0x60<br>
      [11160.387943]  [&lt;ffffffffc01b2454&gt;]
      amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
      [11160.387953]  [&lt;ffffffffc01458aa&gt;]
      amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
      [11160.387963]  [&lt;ffffffffc01459bd&gt;]
      amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
      <br>
      It's blocked waiting for previous swap jobs to complete.<br>
      <br>
      Take a look at amdgpu_fence_info, could just be a GPU hang.<br>
      <br>
      Christian.<br>
      <br>
      Am 17.08.2016 um 13:22 schrieb Marek Olšák:<br>
    </div>
    <blockquote
cite="mid:CAAxE2A7Ls610ae20AUocC=a07Zm9uLLTV4yhBXSQ29ESGZ-0tA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <div dir="ltr">
        <div>
          <div>
            <div>Hi,<br>
              <br>
            </div>
            I have a kernel deadlock here. Piglit tests running at the
            same time:<br>
            <br>
            marek    32295  0.0  0.6 472148 50100 ?        Ssl  12:53  
            0:00 /home/marek/dev/piglit/bin/gl-1.0-blend-func -auto -fbo<br>
            marek    32403  0.0  0.6 532528 55908 ?        Ssl  12:53  
            0:00 /home/marek/dev/piglit/bin/tex3d -auto<br>
            marek    32409  6.5  0.7 536616 62092 ?        Ssl  12:53  
            1:30 /home/marek/dev/piglit/bin/tex3d-maxsize -auto<br>
            marek    32426  0.0  0.6 467872 48920 ?        Ssl  12:53  
            0:00 /home/marek/dev/piglit/bin/texture-packed-formats -auto<br>
            <br>
          </div>
          dmesg:<br>
          <br>
        </div>
        The failures are sort of expected behavior. The deadlock is not:<br>
        <div>
          <div><br>
            [10757.929057] [TTM] Failed to find memory space for buffer
            0xffff88020f0c5468 eviction<br>
            [10757.929061] [TTM] No space for ffff88020f0c5468 (263168
            pages, 1052672K, 1028M)<br>
            [10757.929062] [TTM]   placement[0]=0x00060002 (1)<br>
            [10757.929063] [TTM]     has_type: 1<br>
            [10757.929063] [TTM]     use_type: 1<br>
            [10757.929064] [TTM]     flags: 0x0000000A<br>
            [10757.929065] [TTM]     gpu_offset: 0x80000000<br>
            [10757.929065] [TTM]     size: 524288<br>
            [10757.929066] [TTM]     available_caching: 0x00070000<br>
            [10757.929066] [TTM]     default_caching: 0x00010000<br>
            [10757.929105] [TTM] Failed to find memory space for buffer
            0xffff88020f0c5468 eviction<br>
            [10757.929106] [TTM] No space for ffff88020f0c5468 (263168
            pages, 1052672K, 1028M)<br>
            [10757.929107] [TTM]   placement[0]=0x00060002 (1)<br>
            [10757.929108] [TTM]     has_type: 1<br>
            [10757.929108] [TTM]     use_type: 1<br>
            [10757.929109] [TTM]     flags: 0x0000000A<br>
            [10757.929110] [TTM]     gpu_offset: 0x80000000<br>
            [10757.929110] [TTM]     size: 524288<br>
            [10757.929111] [TTM]     available_caching: 0x00070000<br>
            [10757.929111] [TTM]     default_caching: 0x00010000<br>
            [10757.929127] [TTM] Failed to find memory space for buffer
            0xffff88020f0c5468 eviction<br>
            [10757.929128] [TTM] No space for ffff88020f0c5468 (263168
            pages, 1052672K, 1028M)<br>
            [10757.929129] [TTM]   placement[0]=0x00060002 (1)<br>
            [10757.929130] [TTM]     has_type: 1<br>
            [10757.929131] [TTM]     use_type: 1<br>
            [10757.929132] [TTM]     flags: 0x0000000A<br>
            [10757.929132] [TTM]     gpu_offset: 0x80000000<br>
            [10757.929133] [TTM]     size: 524288<br>
            [10757.929133] [TTM]     available_caching: 0x00070000<br>
            [10757.929134] [TTM]     default_caching: 0x00010000<br>
            [10757.929136] [TTM] Failed to find memory space for buffer
            0xffff88020f0c5468 eviction<br>
            [10757.929137] [TTM] No space for ffff88020f0c5468 (263168
            pages, 1052672K, 1028M)<br>
            [10757.929138] [TTM]   placement[0]=0x00060002 (1)<br>
            [10757.929138] [TTM]     has_type: 1<br>
            [10757.929139] [TTM]     use_type: 1<br>
            [10757.929139] [TTM]     flags: 0x0000000A<br>
            [10757.929140] [TTM]     gpu_offset: 0x80000000<br>
            [10757.929140] [TTM]     size: 524288<br>
            [10757.929141] [TTM]     available_caching: 0x00070000<br>
            [10757.929141] [TTM]     default_caching: 0x00010000<br>
            [10757.929182] [drm:amdgpu_gem_object_create [amdgpu]]
            *ERROR* Failed to allocate GEM object (1077936128, 6,
            131072, -12)<br>
            [10848.046814] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed
            to process the buffer list -16!<br>
            [10938.047062] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed
            to process the buffer list -16!<br>
            [11160.387854] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [11160.387859]       Not tainted 4.7.0-si+ #1<br>
            [11160.387861] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [11160.387863] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [11160.387868]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [11160.387871]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [11160.387874]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [11160.387877] Call Trace:<br>
            [11160.387885]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [11160.387924]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [11160.387927]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [11160.387943]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [11160.387953]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [11160.387963]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [11160.387973]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [11160.387977]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [11160.387979]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [11160.387990]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [11160.388000]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [11160.388003]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [11160.388013]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [11160.388023]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [11160.388031]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [11160.388034]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [11160.388035]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [11160.388037]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [11160.388039]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [11280.388317] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [11280.388322]       Not tainted 4.7.0-si+ #1<br>
            [11280.388323] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [11280.388325] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [11280.388331]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [11280.388334]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [11280.388337]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [11280.388340] Call Trace:<br>
            [11280.388349]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [11280.388387]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [11280.388390]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [11280.388405]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [11280.388415]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [11280.388425]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [11280.388434]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [11280.388438]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [11280.388441]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [11280.388452]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [11280.388462]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [11280.388464]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [11280.388474]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [11280.388484]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [11280.388493]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [11280.388495]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [11280.388497]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [11280.388499]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [11280.388501]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [11400.388859] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [11400.388862]       Not tainted 4.7.0-si+ #1<br>
            [11400.388863] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [11400.388864] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [11400.388866]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [11400.388868]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [11400.388869]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [11400.388870] Call Trace:<br>
            [11400.388876]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [11400.388899]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [11400.388902]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [11400.388917]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [11400.388928]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [11400.388938]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [11400.388947]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [11400.388951]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [11400.388953]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [11400.388964]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [11400.388974]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [11400.388976]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [11400.388986]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [11400.388996]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [11400.389005]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [11400.389007]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [11400.389009]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [11400.389010]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [11400.389012]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [11520.389297] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [11520.389300]       Not tainted 4.7.0-si+ #1<br>
            [11520.389301] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [11520.389302] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [11520.389304]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [11520.389306]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [11520.389307]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [11520.389309] Call Trace:<br>
            [11520.389313]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [11520.389337]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [11520.389340]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [11520.389355]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [11520.389366]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [11520.389375]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [11520.389385]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [11520.389389]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [11520.389391]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [11520.389402]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [11520.389412]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [11520.389414]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [11520.389424]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [11520.389434]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [11520.389443]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [11520.389445]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [11520.389447]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [11520.389448]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [11520.389450]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [11640.389659] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [11640.389664]       Not tainted 4.7.0-si+ #1<br>
            [11640.389665] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [11640.389667] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [11640.389672]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [11640.389676]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [11640.389679]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [11640.389682] Call Trace:<br>
            [11640.389690]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [11640.389729]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [11640.389732]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [11640.389747]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [11640.389758]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [11640.389768]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [11640.389777]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [11640.389781]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [11640.389784]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [11640.389795]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [11640.389805]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [11640.389807]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [11640.389817]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [11640.389828]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [11640.389837]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [11640.389839]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [11640.389840]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [11640.389842]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [11640.389844]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [11760.390205] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [11760.390208]       Not tainted 4.7.0-si+ #1<br>
            [11760.390208] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [11760.390209] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [11760.390212]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [11760.390213]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [11760.390215]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [11760.390216] Call Trace:<br>
            [11760.390221]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [11760.390244]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [11760.390247]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [11760.390262]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [11760.390273]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [11760.390282]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [11760.390291]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [11760.390296]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [11760.390298]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [11760.390309]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [11760.390319]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [11760.390321]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [11760.390331]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [11760.390341]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [11760.390350]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [11760.390352]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [11760.390353]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [11760.390355]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [11760.390357]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [11880.390520] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [11880.390525]       Not tainted 4.7.0-si+ #1<br>
            [11880.390527] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [11880.390529] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [11880.390534]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [11880.390538]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [11880.390541]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [11880.390544] Call Trace:<br>
            [11880.390552]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [11880.390591]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [11880.390594]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [11880.390609]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [11880.390619]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [11880.390629]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [11880.390639]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [11880.390643]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [11880.390646]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [11880.390657]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [11880.390667]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [11880.390669]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [11880.390679]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [11880.390690]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [11880.390699]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [11880.390701]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [11880.390703]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [11880.390704]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [11880.390706]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [12000.390944] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [12000.390949]       Not tainted 4.7.0-si+ #1<br>
            [12000.390950] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [12000.390953] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [12000.390958]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [12000.390961]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [12000.390964]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [12000.390967] Call Trace:<br>
            [12000.390976]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [12000.391014]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [12000.391017]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [12000.391032]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [12000.391043]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [12000.391053]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [12000.391062]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [12000.391066]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [12000.391069]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [12000.391080]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [12000.391090]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [12000.391092]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [12000.391103]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [12000.391113]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [12000.391122]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [12000.391124]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [12000.391126]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [12000.391127]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [12000.391129]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [12120.391376] INFO: task Xorg:2636 blocked for more than
            120 seconds.<br>
            [12120.391381]       Not tainted 4.7.0-si+ #1<br>
            [12120.391383] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [12120.391385] Xorg            D ffff88020f643898     0 
            2636   2624 0x00400004<br>
            [12120.391390]  ffff88020f643898 ffff880034ba0000
            ffff88021522c740 ffff88020e9b0e40<br>
            [12120.391393]  ffff880034ba1f00 ffff88020f644000
            ffff88020f6439b8 ffff880034ba1ee0<br>
            [12120.391396]  0000000000000000 ffff880034ba0000
            ffff88020f6438b0 ffffffff8180f575<br>
            [12120.391399] Call Trace:<br>
            [12120.391407]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [12120.391445]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [12120.391448]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [12120.391463]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [12120.391474]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [12120.391484]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [12120.391493]  [&lt;ffffffffc0145e2a&gt;]
            amdgpu_bo_move+0xca/0x270 [amdgpu]<br>
            [12120.391497]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [12120.391500]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [12120.391511]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [12120.391522]  [&lt;ffffffffc014e4ab&gt;]
            amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>
            [12120.391524]  [&lt;ffffffff8113f300&gt;] ?
            __delayacct_tsk_init+0x40/0x40<br>
            [12120.391534]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [12120.391544]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [12120.391553]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [12120.391555]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [12120.391557]  [&lt;ffffffff81090fd4&gt;] ?
            restore_altstack+0x24/0x40<br>
            [12120.391558]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [12120.391560]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            [12120.391583] INFO: task qtcreator:712 blocked for more
            than 120 seconds.<br>
            [12120.391584]       Not tainted 4.7.0-si+ #1<br>
            [12120.391584] "echo 0 &gt;
            /proc/sys/kernel/hung_task_timeout_secs" disables this
            message.<br>
            [12120.391585] qtcreator       D ffff8800854af7c8     0  
            712   2661 0x00000000<br>
            [12120.391586]  ffff8800854af7c8 ffff880034ba0000
            ffff88021522c740 ffff8801a0870000<br>
            [12120.391588]  ffff880034ba1f00 ffff8800854b0000
            ffff8800854af8e8 ffff880034ba1ee0<br>
            [12120.391589]  0000000000000000 ffff880034ba0000
            ffff8800854af7e0 ffffffff8180f575<br>
            [12120.391590] Call Trace:<br>
            [12120.391592]  [&lt;ffffffff8180f575&gt;]
            schedule+0x35/0x80<br>
            [12120.391606]  [&lt;ffffffffc01b1a57&gt;]
            amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>
            [12120.391608]  [&lt;ffffffff810c3490&gt;] ?
            wake_atomic_t_function+0x60/0x60<br>
            [12120.391621]  [&lt;ffffffffc01b2454&gt;]
            amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>
            [12120.391630]  [&lt;ffffffffc01458aa&gt;]
            amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>
            [12120.391640]  [&lt;ffffffffc01459bd&gt;]
            amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>
            [12120.391649]  [&lt;ffffffffc0145d24&gt;]
            amdgpu_move_ram_vram+0x134/0x170 [amdgpu]<br>
            [12120.391651]  [&lt;ffffffff811ba4e8&gt;] ?
            krealloc+0x28/0xc0<br>
            [12120.391661]  [&lt;ffffffffc0145fa1&gt;]
            amdgpu_bo_move+0x241/0x270 [amdgpu]<br>
            [12120.391664]  [&lt;ffffffffc00e9bc9&gt;]
            ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>
            [12120.391666]  [&lt;ffffffffc00ead4a&gt;]
            ttm_bo_validate+0x13a/0x150 [ttm]<br>
            [12120.391668]  [&lt;ffffffff811ba4e8&gt;] ?
            krealloc+0x28/0xc0<br>
            [12120.391678]  [&lt;ffffffffc014d30f&gt;]
            amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>
            [12120.391688]  [&lt;ffffffffc014e450&gt;]
            amdgpu_cs_ioctl+0xe50/0x10c0 [amdgpu]<br>
            [12120.391696]  [&lt;ffffffffc0071d7d&gt;]
            drm_ioctl+0x2cd/0x490 [drm]<br>
            [12120.391705]  [&lt;ffffffffc014d600&gt;] ?
            amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>
            [12120.391707]  [&lt;ffffffff81191f96&gt;] ?
            unlock_page+0x76/0x80<br>
            [12120.391709]  [&lt;ffffffff811c828a&gt;] ?
            handle_mm_fault+0x11ea/0x1d90<br>
            [12120.391717]  [&lt;ffffffffc013304c&gt;]
            amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>
            [12120.391719]  [&lt;ffffffff8122de41&gt;]
            do_vfs_ioctl+0xa1/0x5b0<br>
            [12120.391721]  [&lt;ffffffff81069515&gt;] ?
            __do_page_fault+0x205/0x4d0<br>
            [12120.391722]  [&lt;ffffffff8122e3c9&gt;]
            SyS_ioctl+0x79/0x90<br>
            [12120.391724]  [&lt;ffffffff818138b6&gt;]
            entry_SYSCALL_64_fastpath+0x1e/0xa8<br>
            <br>
          </div>
          <div>Marek<br>
          </div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------C2875B4514862F560A03230D--

--===============1725691859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1725691859==--
