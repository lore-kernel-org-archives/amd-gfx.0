From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Kernel deadlock in amdgpu_job_submit
Date: Wed, 17 Aug 2016 13:22:44 +0200
Message-ID: <CAAxE2A7Ls610ae20AUocC=a07Zm9uLLTV4yhBXSQ29ESGZ-0tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2122998153=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============2122998153==
Content-Type: multipart/alternative; boundary=001a1141f53498f0b5053a42b12b

--001a1141f53498f0b5053a42b12b
Content-Type: text/plain; charset=UTF-8

Hi,

I have a kernel deadlock here. Piglit tests running at the same time:

marek    32295  0.0  0.6 472148 50100 ?        Ssl  12:53   0:00
/home/marek/dev/piglit/bin/gl-1.0-blend-func -auto -fbo
marek    32403  0.0  0.6 532528 55908 ?        Ssl  12:53   0:00
/home/marek/dev/piglit/bin/tex3d -auto
marek    32409  6.5  0.7 536616 62092 ?        Ssl  12:53   1:30
/home/marek/dev/piglit/bin/tex3d-maxsize -auto
marek    32426  0.0  0.6 467872 48920 ?        Ssl  12:53   0:00
/home/marek/dev/piglit/bin/texture-packed-formats -auto

dmesg:

The failures are sort of expected behavior. The deadlock is not:

[10757.929057] [TTM] Failed to find memory space for buffer
0xffff88020f0c5468 eviction
[10757.929061] [TTM] No space for ffff88020f0c5468 (263168 pages, 1052672K,
1028M)
[10757.929062] [TTM]   placement[0]=0x00060002 (1)
[10757.929063] [TTM]     has_type: 1
[10757.929063] [TTM]     use_type: 1
[10757.929064] [TTM]     flags: 0x0000000A
[10757.929065] [TTM]     gpu_offset: 0x80000000
[10757.929065] [TTM]     size: 524288
[10757.929066] [TTM]     available_caching: 0x00070000
[10757.929066] [TTM]     default_caching: 0x00010000
[10757.929105] [TTM] Failed to find memory space for buffer
0xffff88020f0c5468 eviction
[10757.929106] [TTM] No space for ffff88020f0c5468 (263168 pages, 1052672K,
1028M)
[10757.929107] [TTM]   placement[0]=0x00060002 (1)
[10757.929108] [TTM]     has_type: 1
[10757.929108] [TTM]     use_type: 1
[10757.929109] [TTM]     flags: 0x0000000A
[10757.929110] [TTM]     gpu_offset: 0x80000000
[10757.929110] [TTM]     size: 524288
[10757.929111] [TTM]     available_caching: 0x00070000
[10757.929111] [TTM]     default_caching: 0x00010000
[10757.929127] [TTM] Failed to find memory space for buffer
0xffff88020f0c5468 eviction
[10757.929128] [TTM] No space for ffff88020f0c5468 (263168 pages, 1052672K,
1028M)
[10757.929129] [TTM]   placement[0]=0x00060002 (1)
[10757.929130] [TTM]     has_type: 1
[10757.929131] [TTM]     use_type: 1
[10757.929132] [TTM]     flags: 0x0000000A
[10757.929132] [TTM]     gpu_offset: 0x80000000
[10757.929133] [TTM]     size: 524288
[10757.929133] [TTM]     available_caching: 0x00070000
[10757.929134] [TTM]     default_caching: 0x00010000
[10757.929136] [TTM] Failed to find memory space for buffer
0xffff88020f0c5468 eviction
[10757.929137] [TTM] No space for ffff88020f0c5468 (263168 pages, 1052672K,
1028M)
[10757.929138] [TTM]   placement[0]=0x00060002 (1)
[10757.929138] [TTM]     has_type: 1
[10757.929139] [TTM]     use_type: 1
[10757.929139] [TTM]     flags: 0x0000000A
[10757.929140] [TTM]     gpu_offset: 0x80000000
[10757.929140] [TTM]     size: 524288
[10757.929141] [TTM]     available_caching: 0x00070000
[10757.929141] [TTM]     default_caching: 0x00010000
[10757.929182] [drm:amdgpu_gem_object_create [amdgpu]] *ERROR* Failed to
allocate GEM object (1077936128, 6, 131072, -12)
[10848.046814] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process the
buffer list -16!
[10938.047062] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to process the
buffer list -16!
[11160.387854] INFO: task Xorg:2636 blocked for more than 120 seconds.
[11160.387859]       Not tainted 4.7.0-si+ #1
[11160.387861] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[11160.387863] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[11160.387868]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[11160.387871]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[11160.387874]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[11160.387877] Call Trace:
[11160.387885]  [<ffffffff8180f575>] schedule+0x35/0x80
[11160.387924]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[11160.387927]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11160.387943]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11160.387953]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11160.387963]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[11160.387973]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[11160.387977]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[11160.387979]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[11160.387990]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[11160.388000]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[11160.388003]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[11160.388013]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[11160.388023]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[11160.388031]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[11160.388034]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[11160.388035]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[11160.388037]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[11160.388039]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[11280.388317] INFO: task Xorg:2636 blocked for more than 120 seconds.
[11280.388322]       Not tainted 4.7.0-si+ #1
[11280.388323] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[11280.388325] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[11280.388331]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[11280.388334]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[11280.388337]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[11280.388340] Call Trace:
[11280.388349]  [<ffffffff8180f575>] schedule+0x35/0x80
[11280.388387]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[11280.388390]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11280.388405]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11280.388415]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11280.388425]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[11280.388434]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[11280.388438]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[11280.388441]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[11280.388452]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[11280.388462]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[11280.388464]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[11280.388474]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[11280.388484]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[11280.388493]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[11280.388495]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[11280.388497]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[11280.388499]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[11280.388501]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[11400.388859] INFO: task Xorg:2636 blocked for more than 120 seconds.
[11400.388862]       Not tainted 4.7.0-si+ #1
[11400.388863] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[11400.388864] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[11400.388866]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[11400.388868]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[11400.388869]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[11400.388870] Call Trace:
[11400.388876]  [<ffffffff8180f575>] schedule+0x35/0x80
[11400.388899]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[11400.388902]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11400.388917]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11400.388928]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11400.388938]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[11400.388947]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[11400.388951]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[11400.388953]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[11400.388964]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[11400.388974]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[11400.388976]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[11400.388986]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[11400.388996]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[11400.389005]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[11400.389007]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[11400.389009]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[11400.389010]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[11400.389012]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[11520.389297] INFO: task Xorg:2636 blocked for more than 120 seconds.
[11520.389300]       Not tainted 4.7.0-si+ #1
[11520.389301] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[11520.389302] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[11520.389304]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[11520.389306]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[11520.389307]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[11520.389309] Call Trace:
[11520.389313]  [<ffffffff8180f575>] schedule+0x35/0x80
[11520.389337]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[11520.389340]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11520.389355]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11520.389366]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11520.389375]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[11520.389385]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[11520.389389]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[11520.389391]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[11520.389402]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[11520.389412]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[11520.389414]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[11520.389424]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[11520.389434]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[11520.389443]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[11520.389445]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[11520.389447]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[11520.389448]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[11520.389450]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[11640.389659] INFO: task Xorg:2636 blocked for more than 120 seconds.
[11640.389664]       Not tainted 4.7.0-si+ #1
[11640.389665] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[11640.389667] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[11640.389672]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[11640.389676]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[11640.389679]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[11640.389682] Call Trace:
[11640.389690]  [<ffffffff8180f575>] schedule+0x35/0x80
[11640.389729]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[11640.389732]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11640.389747]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11640.389758]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11640.389768]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[11640.389777]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[11640.389781]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[11640.389784]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[11640.389795]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[11640.389805]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[11640.389807]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[11640.389817]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[11640.389828]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[11640.389837]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[11640.389839]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[11640.389840]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[11640.389842]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[11640.389844]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[11760.390205] INFO: task Xorg:2636 blocked for more than 120 seconds.
[11760.390208]       Not tainted 4.7.0-si+ #1
[11760.390208] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[11760.390209] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[11760.390212]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[11760.390213]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[11760.390215]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[11760.390216] Call Trace:
[11760.390221]  [<ffffffff8180f575>] schedule+0x35/0x80
[11760.390244]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[11760.390247]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11760.390262]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11760.390273]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11760.390282]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[11760.390291]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[11760.390296]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[11760.390298]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[11760.390309]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[11760.390319]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[11760.390321]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[11760.390331]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[11760.390341]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[11760.390350]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[11760.390352]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[11760.390353]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[11760.390355]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[11760.390357]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[11880.390520] INFO: task Xorg:2636 blocked for more than 120 seconds.
[11880.390525]       Not tainted 4.7.0-si+ #1
[11880.390527] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[11880.390529] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[11880.390534]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[11880.390538]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[11880.390541]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[11880.390544] Call Trace:
[11880.390552]  [<ffffffff8180f575>] schedule+0x35/0x80
[11880.390591]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[11880.390594]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[11880.390609]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[11880.390619]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[11880.390629]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[11880.390639]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[11880.390643]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[11880.390646]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[11880.390657]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[11880.390667]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[11880.390669]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[11880.390679]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[11880.390690]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[11880.390699]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[11880.390701]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[11880.390703]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[11880.390704]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[11880.390706]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[12000.390944] INFO: task Xorg:2636 blocked for more than 120 seconds.
[12000.390949]       Not tainted 4.7.0-si+ #1
[12000.390950] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[12000.390953] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[12000.390958]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[12000.390961]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[12000.390964]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[12000.390967] Call Trace:
[12000.390976]  [<ffffffff8180f575>] schedule+0x35/0x80
[12000.391014]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[12000.391017]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[12000.391032]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[12000.391043]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[12000.391053]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[12000.391062]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[12000.391066]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[12000.391069]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[12000.391080]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[12000.391090]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[12000.391092]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[12000.391103]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[12000.391113]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[12000.391122]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[12000.391124]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[12000.391126]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[12000.391127]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[12000.391129]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[12120.391376] INFO: task Xorg:2636 blocked for more than 120 seconds.
[12120.391381]       Not tainted 4.7.0-si+ #1
[12120.391383] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[12120.391385] Xorg            D ffff88020f643898     0  2636   2624
0x00400004
[12120.391390]  ffff88020f643898 ffff880034ba0000 ffff88021522c740
ffff88020e9b0e40
[12120.391393]  ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8
ffff880034ba1ee0
[12120.391396]  0000000000000000 ffff880034ba0000 ffff88020f6438b0
ffffffff8180f575
[12120.391399] Call Trace:
[12120.391407]  [<ffffffff8180f575>] schedule+0x35/0x80
[12120.391445]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[12120.391448]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[12120.391463]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[12120.391474]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[12120.391484]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[12120.391493]  [<ffffffffc0145e2a>] amdgpu_bo_move+0xca/0x270 [amdgpu]
[12120.391497]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[12120.391500]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[12120.391511]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[12120.391522]  [<ffffffffc014e4ab>] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]
[12120.391524]  [<ffffffff8113f300>] ? __delayacct_tsk_init+0x40/0x40
[12120.391534]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[12120.391544]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[12120.391553]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[12120.391555]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[12120.391557]  [<ffffffff81090fd4>] ? restore_altstack+0x24/0x40
[12120.391558]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[12120.391560]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8
[12120.391583] INFO: task qtcreator:712 blocked for more than 120 seconds.
[12120.391584]       Not tainted 4.7.0-si+ #1
[12120.391584] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[12120.391585] qtcreator       D ffff8800854af7c8     0   712   2661
0x00000000
[12120.391586]  ffff8800854af7c8 ffff880034ba0000 ffff88021522c740
ffff8801a0870000
[12120.391588]  ffff880034ba1f00 ffff8800854b0000 ffff8800854af8e8
ffff880034ba1ee0
[12120.391589]  0000000000000000 ffff880034ba0000 ffff8800854af7e0
ffffffff8180f575
[12120.391590] Call Trace:
[12120.391592]  [<ffffffff8180f575>] schedule+0x35/0x80
[12120.391606]  [<ffffffffc01b1a57>] amd_sched_entity_push_job+0x77/0x110
[amdgpu]
[12120.391608]  [<ffffffff810c3490>] ? wake_atomic_t_function+0x60/0x60
[12120.391621]  [<ffffffffc01b2454>] amdgpu_job_submit+0x84/0xc0 [amdgpu]
[12120.391630]  [<ffffffffc01458aa>] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]
[12120.391640]  [<ffffffffc01459bd>] amdgpu_move_blit+0x9d/0x140 [amdgpu]
[12120.391649]  [<ffffffffc0145d24>] amdgpu_move_ram_vram+0x134/0x170
[amdgpu]
[12120.391651]  [<ffffffff811ba4e8>] ? krealloc+0x28/0xc0
[12120.391661]  [<ffffffffc0145fa1>] amdgpu_bo_move+0x241/0x270 [amdgpu]
[12120.391664]  [<ffffffffc00e9bc9>] ttm_bo_handle_move_mem+0x279/0x5a0
[ttm]
[12120.391666]  [<ffffffffc00ead4a>] ttm_bo_validate+0x13a/0x150 [ttm]
[12120.391668]  [<ffffffff811ba4e8>] ? krealloc+0x28/0xc0
[12120.391678]  [<ffffffffc014d30f>] amdgpu_cs_list_validate+0xaf/0x1c0
[amdgpu]
[12120.391688]  [<ffffffffc014e450>] amdgpu_cs_ioctl+0xe50/0x10c0 [amdgpu]
[12120.391696]  [<ffffffffc0071d7d>] drm_ioctl+0x2cd/0x490 [drm]
[12120.391705]  [<ffffffffc014d600>] ? amdgpu_cs_find_mapping+0xa0/0xa0
[amdgpu]
[12120.391707]  [<ffffffff81191f96>] ? unlock_page+0x76/0x80
[12120.391709]  [<ffffffff811c828a>] ? handle_mm_fault+0x11ea/0x1d90
[12120.391717]  [<ffffffffc013304c>] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]
[12120.391719]  [<ffffffff8122de41>] do_vfs_ioctl+0xa1/0x5b0
[12120.391721]  [<ffffffff81069515>] ? __do_page_fault+0x205/0x4d0
[12120.391722]  [<ffffffff8122e3c9>] SyS_ioctl+0x79/0x90
[12120.391724]  [<ffffffff818138b6>] entry_SYSCALL_64_fastpath+0x1e/0xa8

Marek

--001a1141f53498f0b5053a42b12b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I have a kernel deadlock h=
ere. Piglit tests running at the same time:<br><br>marek=C2=A0=C2=A0=C2=A0 =
32295=C2=A0 0.0=C2=A0 0.6 472148 50100 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Ssl=C2=A0 12:53=C2=A0=C2=A0 0:00 /home/marek/dev/piglit/bin/gl-1.=
0-blend-func -auto -fbo<br>marek=C2=A0=C2=A0=C2=A0 32403=C2=A0 0.0=C2=A0 0.=
6 532528 55908 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ssl=C2=A0 12:53=
=C2=A0=C2=A0 0:00 /home/marek/dev/piglit/bin/tex3d -auto<br>marek=C2=A0=C2=
=A0=C2=A0 32409=C2=A0 6.5=C2=A0 0.7 536616 62092 ?=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Ssl=C2=A0 12:53=C2=A0=C2=A0 1:30 /home/marek/dev/piglit/=
bin/tex3d-maxsize -auto<br>marek=C2=A0=C2=A0=C2=A0 32426=C2=A0 0.0=C2=A0 0.=
6 467872 48920 ?=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ssl=C2=A0 12:53=
=C2=A0=C2=A0 0:00 /home/marek/dev/piglit/bin/texture-packed-formats -auto<b=
r><br></div>dmesg:<br><br></div>The failures are sort of expected behavior.=
 The deadlock is not:<br><div><div><br>[10757.929057] [TTM] Failed to find =
memory space for buffer 0xffff88020f0c5468 eviction<br>[10757.929061] [TTM]=
 No space for ffff88020f0c5468 (263168 pages, 1052672K, 1028M)<br>[10757.92=
9062] [TTM]=C2=A0=C2=A0 placement[0]=3D0x00060002 (1)<br>[10757.929063] [TT=
M]=C2=A0=C2=A0=C2=A0=C2=A0 has_type: 1<br>[10757.929063] [TTM]=C2=A0=C2=A0=
=C2=A0=C2=A0 use_type: 1<br>[10757.929064] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 fl=
ags: 0x0000000A<br>[10757.929065] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 gpu_offset:=
 0x80000000<br>[10757.929065] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 size: 524288<br=
>[10757.929066] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 available_caching: 0x00070000=
<br>[10757.929066] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 default_caching: 0x0001000=
0<br>[10757.929105] [TTM] Failed to find memory space for buffer 0xffff8802=
0f0c5468 eviction<br>[10757.929106] [TTM] No space for ffff88020f0c5468 (26=
3168 pages, 1052672K, 1028M)<br>[10757.929107] [TTM]=C2=A0=C2=A0 placement[=
0]=3D0x00060002 (1)<br>[10757.929108] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 has_typ=
e: 1<br>[10757.929108] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 use_type: 1<br>[10757.=
929109] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 flags: 0x0000000A<br>[10757.929110] [=
TTM]=C2=A0=C2=A0=C2=A0=C2=A0 gpu_offset: 0x80000000<br>[10757.929110] [TTM]=
=C2=A0=C2=A0=C2=A0=C2=A0 size: 524288<br>[10757.929111] [TTM]=C2=A0=C2=A0=
=C2=A0=C2=A0 available_caching: 0x00070000<br>[10757.929111] [TTM]=C2=A0=C2=
=A0=C2=A0=C2=A0 default_caching: 0x00010000<br>[10757.929127] [TTM] Failed =
to find memory space for buffer 0xffff88020f0c5468 eviction<br>[10757.92912=
8] [TTM] No space for ffff88020f0c5468 (263168 pages, 1052672K, 1028M)<br>[=
10757.929129] [TTM]=C2=A0=C2=A0 placement[0]=3D0x00060002 (1)<br>[10757.929=
130] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 has_type: 1<br>[10757.929131] [TTM]=C2=
=A0=C2=A0=C2=A0=C2=A0 use_type: 1<br>[10757.929132] [TTM]=C2=A0=C2=A0=C2=A0=
=C2=A0 flags: 0x0000000A<br>[10757.929132] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 gp=
u_offset: 0x80000000<br>[10757.929133] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 size: =
524288<br>[10757.929133] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 available_caching: 0=
x00070000<br>[10757.929134] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 default_caching: =
0x00010000<br>[10757.929136] [TTM] Failed to find memory space for buffer 0=
xffff88020f0c5468 eviction<br>[10757.929137] [TTM] No space for ffff88020f0=
c5468 (263168 pages, 1052672K, 1028M)<br>[10757.929138] [TTM]=C2=A0=C2=A0 p=
lacement[0]=3D0x00060002 (1)<br>[10757.929138] [TTM]=C2=A0=C2=A0=C2=A0=C2=
=A0 has_type: 1<br>[10757.929139] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 use_type: 1=
<br>[10757.929139] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 flags: 0x0000000A<br>[1075=
7.929140] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 gpu_offset: 0x80000000<br>[10757.92=
9140] [TTM]=C2=A0=C2=A0=C2=A0=C2=A0 size: 524288<br>[10757.929141] [TTM]=C2=
=A0=C2=A0=C2=A0=C2=A0 available_caching: 0x00070000<br>[10757.929141] [TTM]=
=C2=A0=C2=A0=C2=A0=C2=A0 default_caching: 0x00010000<br>[10757.929182] [drm=
:amdgpu_gem_object_create [amdgpu]] *ERROR* Failed to allocate GEM object (=
1077936128, 6, 131072, -12)<br>[10848.046814] [drm:amdgpu_cs_ioctl [amdgpu]=
] *ERROR* Failed to process the buffer list -16!<br>[10938.047062] [drm:amd=
gpu_cs_ioctl [amdgpu]] *ERROR* Failed to process the buffer list -16!<br>[1=
1160.387854] INFO: task Xorg:2636 blocked for more than 120 seconds.<br>[11=
160.387859]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 4.7.0-si+ #1<br=
>[11160.387861] &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs&q=
uot; disables this message.<br>[11160.387863] Xorg=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D ffff88020f643898=C2=A0=C2=A0=
=C2=A0=C2=A0 0=C2=A0 2636=C2=A0=C2=A0 2624 0x00400004<br>[11160.387868]=C2=
=A0 ffff88020f643898 ffff880034ba0000 ffff88021522c740 ffff88020e9b0e40<br>=
[11160.387871]=C2=A0 ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 fff=
f880034ba1ee0<br>[11160.387874]=C2=A0 0000000000000000 ffff880034ba0000 fff=
f88020f6438b0 ffffffff8180f575<br>[11160.387877] Call Trace:<br>[11160.3878=
85]=C2=A0 [&lt;ffffffff8180f575&gt;] schedule+0x35/0x80<br>[11160.387924]=
=C2=A0 [&lt;ffffffffc01b1a57&gt;] amd_sched_entity_push_job+0x77/0x110 [amd=
gpu]<br>[11160.387927]=C2=A0 [&lt;ffffffff810c3490&gt;] ? wake_atomic_t_fun=
ction+0x60/0x60<br>[11160.387943]=C2=A0 [&lt;ffffffffc01b2454&gt;] amdgpu_j=
ob_submit+0x84/0xc0 [amdgpu]<br>[11160.387953]=C2=A0 [&lt;ffffffffc01458aa&=
gt;] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>[11160.387963]=C2=A0 [&lt;f=
fffffffc01459bd&gt;] amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>[11160.387973]=
=C2=A0 [&lt;ffffffffc0145e2a&gt;] amdgpu_bo_move+0xca/0x270 [amdgpu]<br>[11=
160.387977]=C2=A0 [&lt;ffffffffc00e9bc9&gt;] ttm_bo_handle_move_mem+0x279/0=
x5a0 [ttm]<br>[11160.387979]=C2=A0 [&lt;ffffffffc00ead4a&gt;] ttm_bo_valida=
te+0x13a/0x150 [ttm]<br>[11160.387990]=C2=A0 [&lt;ffffffffc014d30f&gt;] amd=
gpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>[11160.388000]=C2=A0 [&lt;fffff=
fffc014e4ab&gt;] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>[11160.388003]=C2=
=A0 [&lt;ffffffff8113f300&gt;] ? __delayacct_tsk_init+0x40/0x40<br>[11160.3=
88013]=C2=A0 [&lt;ffffffffc0071d7d&gt;] drm_ioctl+0x2cd/0x490 [drm]<br>[111=
60.388023]=C2=A0 [&lt;ffffffffc014d600&gt;] ? amdgpu_cs_find_mapping+0xa0/0=
xa0 [amdgpu]<br>[11160.388031]=C2=A0 [&lt;ffffffffc013304c&gt;] amdgpu_drm_=
ioctl+0x4c/0x80 [amdgpu]<br>[11160.388034]=C2=A0 [&lt;ffffffff8122de41&gt;]=
 do_vfs_ioctl+0xa1/0x5b0<br>[11160.388035]=C2=A0 [&lt;ffffffff81090fd4&gt;]=
 ? restore_altstack+0x24/0x40<br>[11160.388037]=C2=A0 [&lt;ffffffff8122e3c9=
&gt;] SyS_ioctl+0x79/0x90<br>[11160.388039]=C2=A0 [&lt;ffffffff818138b6&gt;=
] entry_SYSCALL_64_fastpath+0x1e/0xa8<br>[11280.388317] INFO: task Xorg:263=
6 blocked for more than 120 seconds.<br>[11280.388322]=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Not tainted 4.7.0-si+ #1<br>[11280.388323] &quot;echo 0 &gt=
; /proc/sys/kernel/hung_task_timeout_secs&quot; disables this message.<br>[=
11280.388325] Xorg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 D ffff88020f643898=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 2636=C2=A0=C2=
=A0 2624 0x00400004<br>[11280.388331]=C2=A0 ffff88020f643898 ffff880034ba00=
00 ffff88021522c740 ffff88020e9b0e40<br>[11280.388334]=C2=A0 ffff880034ba1f=
00 ffff88020f644000 ffff88020f6439b8 ffff880034ba1ee0<br>[11280.388337]=C2=
=A0 0000000000000000 ffff880034ba0000 ffff88020f6438b0 ffffffff8180f575<br>=
[11280.388340] Call Trace:<br>[11280.388349]=C2=A0 [&lt;ffffffff8180f575&gt=
;] schedule+0x35/0x80<br>[11280.388387]=C2=A0 [&lt;ffffffffc01b1a57&gt;] am=
d_sched_entity_push_job+0x77/0x110 [amdgpu]<br>[11280.388390]=C2=A0 [&lt;ff=
ffffff810c3490&gt;] ? wake_atomic_t_function+0x60/0x60<br>[11280.388405]=C2=
=A0 [&lt;ffffffffc01b2454&gt;] amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>[112=
80.388415]=C2=A0 [&lt;ffffffffc01458aa&gt;] amdgpu_copy_buffer+0x14a/0x1c0 =
[amdgpu]<br>[11280.388425]=C2=A0 [&lt;ffffffffc01459bd&gt;] amdgpu_move_bli=
t+0x9d/0x140 [amdgpu]<br>[11280.388434]=C2=A0 [&lt;ffffffffc0145e2a&gt;] am=
dgpu_bo_move+0xca/0x270 [amdgpu]<br>[11280.388438]=C2=A0 [&lt;ffffffffc00e9=
bc9&gt;] ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>[11280.388441]=C2=A0 [=
&lt;ffffffffc00ead4a&gt;] ttm_bo_validate+0x13a/0x150 [ttm]<br>[11280.38845=
2]=C2=A0 [&lt;ffffffffc014d30f&gt;] amdgpu_cs_list_validate+0xaf/0x1c0 [amd=
gpu]<br>[11280.388462]=C2=A0 [&lt;ffffffffc014e4ab&gt;] amdgpu_cs_ioctl+0xe=
ab/0x10c0 [amdgpu]<br>[11280.388464]=C2=A0 [&lt;ffffffff8113f300&gt;] ? __d=
elayacct_tsk_init+0x40/0x40<br>[11280.388474]=C2=A0 [&lt;ffffffffc0071d7d&g=
t;] drm_ioctl+0x2cd/0x490 [drm]<br>[11280.388484]=C2=A0 [&lt;ffffffffc014d6=
00&gt;] ? amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>[11280.388493]=C2=A0=
 [&lt;ffffffffc013304c&gt;] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>[11280.3=
88495]=C2=A0 [&lt;ffffffff8122de41&gt;] do_vfs_ioctl+0xa1/0x5b0<br>[11280.3=
88497]=C2=A0 [&lt;ffffffff81090fd4&gt;] ? restore_altstack+0x24/0x40<br>[11=
280.388499]=C2=A0 [&lt;ffffffff8122e3c9&gt;] SyS_ioctl+0x79/0x90<br>[11280.=
388501]=C2=A0 [&lt;ffffffff818138b6&gt;] entry_SYSCALL_64_fastpath+0x1e/0xa=
8<br>[11400.388859] INFO: task Xorg:2636 blocked for more than 120 seconds.=
<br>[11400.388862]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 4.7.0-si=
+ #1<br>[11400.388863] &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout=
_secs&quot; disables this message.<br>[11400.388864] Xorg=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D ffff88020f643898=C2=A0=
=C2=A0=C2=A0=C2=A0 0=C2=A0 2636=C2=A0=C2=A0 2624 0x00400004<br>[11400.38886=
6]=C2=A0 ffff88020f643898 ffff880034ba0000 ffff88021522c740 ffff88020e9b0e4=
0<br>[11400.388868]=C2=A0 ffff880034ba1f00 ffff88020f644000 ffff88020f6439b=
8 ffff880034ba1ee0<br>[11400.388869]=C2=A0 0000000000000000 ffff880034ba000=
0 ffff88020f6438b0 ffffffff8180f575<br>[11400.388870] Call Trace:<br>[11400=
.388876]=C2=A0 [&lt;ffffffff8180f575&gt;] schedule+0x35/0x80<br>[11400.3888=
99]=C2=A0 [&lt;ffffffffc01b1a57&gt;] amd_sched_entity_push_job+0x77/0x110 [=
amdgpu]<br>[11400.388902]=C2=A0 [&lt;ffffffff810c3490&gt;] ? wake_atomic_t_=
function+0x60/0x60<br>[11400.388917]=C2=A0 [&lt;ffffffffc01b2454&gt;] amdgp=
u_job_submit+0x84/0xc0 [amdgpu]<br>[11400.388928]=C2=A0 [&lt;ffffffffc01458=
aa&gt;] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>[11400.388938]=C2=A0 [&l=
t;ffffffffc01459bd&gt;] amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>[11400.3889=
47]=C2=A0 [&lt;ffffffffc0145e2a&gt;] amdgpu_bo_move+0xca/0x270 [amdgpu]<br>=
[11400.388951]=C2=A0 [&lt;ffffffffc00e9bc9&gt;] ttm_bo_handle_move_mem+0x27=
9/0x5a0 [ttm]<br>[11400.388953]=C2=A0 [&lt;ffffffffc00ead4a&gt;] ttm_bo_val=
idate+0x13a/0x150 [ttm]<br>[11400.388964]=C2=A0 [&lt;ffffffffc014d30f&gt;] =
amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>[11400.388974]=C2=A0 [&lt;ff=
ffffffc014e4ab&gt;] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>[11400.388976]=
=C2=A0 [&lt;ffffffff8113f300&gt;] ? __delayacct_tsk_init+0x40/0x40<br>[1140=
0.388986]=C2=A0 [&lt;ffffffffc0071d7d&gt;] drm_ioctl+0x2cd/0x490 [drm]<br>[=
11400.388996]=C2=A0 [&lt;ffffffffc014d600&gt;] ? amdgpu_cs_find_mapping+0xa=
0/0xa0 [amdgpu]<br>[11400.389005]=C2=A0 [&lt;ffffffffc013304c&gt;] amdgpu_d=
rm_ioctl+0x4c/0x80 [amdgpu]<br>[11400.389007]=C2=A0 [&lt;ffffffff8122de41&g=
t;] do_vfs_ioctl+0xa1/0x5b0<br>[11400.389009]=C2=A0 [&lt;ffffffff81090fd4&g=
t;] ? restore_altstack+0x24/0x40<br>[11400.389010]=C2=A0 [&lt;ffffffff8122e=
3c9&gt;] SyS_ioctl+0x79/0x90<br>[11400.389012]=C2=A0 [&lt;ffffffff818138b6&=
gt;] entry_SYSCALL_64_fastpath+0x1e/0xa8<br>[11520.389297] INFO: task Xorg:=
2636 blocked for more than 120 seconds.<br>[11520.389300]=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Not tainted 4.7.0-si+ #1<br>[11520.389301] &quot;echo 0 =
&gt; /proc/sys/kernel/hung_task_timeout_secs&quot; disables this message.<b=
r>[11520.389302] Xorg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 D ffff88020f643898=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 2636=C2=A0=
=C2=A0 2624 0x00400004<br>[11520.389304]=C2=A0 ffff88020f643898 ffff880034b=
a0000 ffff88021522c740 ffff88020e9b0e40<br>[11520.389306]=C2=A0 ffff880034b=
a1f00 ffff88020f644000 ffff88020f6439b8 ffff880034ba1ee0<br>[11520.389307]=
=C2=A0 0000000000000000 ffff880034ba0000 ffff88020f6438b0 ffffffff8180f575<=
br>[11520.389309] Call Trace:<br>[11520.389313]=C2=A0 [&lt;ffffffff8180f575=
&gt;] schedule+0x35/0x80<br>[11520.389337]=C2=A0 [&lt;ffffffffc01b1a57&gt;]=
 amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>[11520.389340]=C2=A0 [&lt=
;ffffffff810c3490&gt;] ? wake_atomic_t_function+0x60/0x60<br>[11520.389355]=
=C2=A0 [&lt;ffffffffc01b2454&gt;] amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>[=
11520.389366]=C2=A0 [&lt;ffffffffc01458aa&gt;] amdgpu_copy_buffer+0x14a/0x1=
c0 [amdgpu]<br>[11520.389375]=C2=A0 [&lt;ffffffffc01459bd&gt;] amdgpu_move_=
blit+0x9d/0x140 [amdgpu]<br>[11520.389385]=C2=A0 [&lt;ffffffffc0145e2a&gt;]=
 amdgpu_bo_move+0xca/0x270 [amdgpu]<br>[11520.389389]=C2=A0 [&lt;ffffffffc0=
0e9bc9&gt;] ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>[11520.389391]=C2=
=A0 [&lt;ffffffffc00ead4a&gt;] ttm_bo_validate+0x13a/0x150 [ttm]<br>[11520.=
389402]=C2=A0 [&lt;ffffffffc014d30f&gt;] amdgpu_cs_list_validate+0xaf/0x1c0=
 [amdgpu]<br>[11520.389412]=C2=A0 [&lt;ffffffffc014e4ab&gt;] amdgpu_cs_ioct=
l+0xeab/0x10c0 [amdgpu]<br>[11520.389414]=C2=A0 [&lt;ffffffff8113f300&gt;] =
? __delayacct_tsk_init+0x40/0x40<br>[11520.389424]=C2=A0 [&lt;ffffffffc0071=
d7d&gt;] drm_ioctl+0x2cd/0x490 [drm]<br>[11520.389434]=C2=A0 [&lt;ffffffffc=
014d600&gt;] ? amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>[11520.389443]=
=C2=A0 [&lt;ffffffffc013304c&gt;] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>[1=
1520.389445]=C2=A0 [&lt;ffffffff8122de41&gt;] do_vfs_ioctl+0xa1/0x5b0<br>[1=
1520.389447]=C2=A0 [&lt;ffffffff81090fd4&gt;] ? restore_altstack+0x24/0x40<=
br>[11520.389448]=C2=A0 [&lt;ffffffff8122e3c9&gt;] SyS_ioctl+0x79/0x90<br>[=
11520.389450]=C2=A0 [&lt;ffffffff818138b6&gt;] entry_SYSCALL_64_fastpath+0x=
1e/0xa8<br>[11640.389659] INFO: task Xorg:2636 blocked for more than 120 se=
conds.<br>[11640.389664]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 4.=
7.0-si+ #1<br>[11640.389665] &quot;echo 0 &gt; /proc/sys/kernel/hung_task_t=
imeout_secs&quot; disables this message.<br>[11640.389667] Xorg=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D ffff88020f643898=
=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 2636=C2=A0=C2=A0 2624 0x00400004<br>[11640=
.389672]=C2=A0 ffff88020f643898 ffff880034ba0000 ffff88021522c740 ffff88020=
e9b0e40<br>[11640.389676]=C2=A0 ffff880034ba1f00 ffff88020f644000 ffff88020=
f6439b8 ffff880034ba1ee0<br>[11640.389679]=C2=A0 0000000000000000 ffff88003=
4ba0000 ffff88020f6438b0 ffffffff8180f575<br>[11640.389682] Call Trace:<br>=
[11640.389690]=C2=A0 [&lt;ffffffff8180f575&gt;] schedule+0x35/0x80<br>[1164=
0.389729]=C2=A0 [&lt;ffffffffc01b1a57&gt;] amd_sched_entity_push_job+0x77/0=
x110 [amdgpu]<br>[11640.389732]=C2=A0 [&lt;ffffffff810c3490&gt;] ? wake_ato=
mic_t_function+0x60/0x60<br>[11640.389747]=C2=A0 [&lt;ffffffffc01b2454&gt;]=
 amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>[11640.389758]=C2=A0 [&lt;ffffffff=
c01458aa&gt;] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>[11640.389768]=C2=
=A0 [&lt;ffffffffc01459bd&gt;] amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>[116=
40.389777]=C2=A0 [&lt;ffffffffc0145e2a&gt;] amdgpu_bo_move+0xca/0x270 [amdg=
pu]<br>[11640.389781]=C2=A0 [&lt;ffffffffc00e9bc9&gt;] ttm_bo_handle_move_m=
em+0x279/0x5a0 [ttm]<br>[11640.389784]=C2=A0 [&lt;ffffffffc00ead4a&gt;] ttm=
_bo_validate+0x13a/0x150 [ttm]<br>[11640.389795]=C2=A0 [&lt;ffffffffc014d30=
f&gt;] amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>[11640.389805]=C2=A0 =
[&lt;ffffffffc014e4ab&gt;] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>[11640.=
389807]=C2=A0 [&lt;ffffffff8113f300&gt;] ? __delayacct_tsk_init+0x40/0x40<b=
r>[11640.389817]=C2=A0 [&lt;ffffffffc0071d7d&gt;] drm_ioctl+0x2cd/0x490 [dr=
m]<br>[11640.389828]=C2=A0 [&lt;ffffffffc014d600&gt;] ? amdgpu_cs_find_mapp=
ing+0xa0/0xa0 [amdgpu]<br>[11640.389837]=C2=A0 [&lt;ffffffffc013304c&gt;] a=
mdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>[11640.389839]=C2=A0 [&lt;ffffffff812=
2de41&gt;] do_vfs_ioctl+0xa1/0x5b0<br>[11640.389840]=C2=A0 [&lt;ffffffff810=
90fd4&gt;] ? restore_altstack+0x24/0x40<br>[11640.389842]=C2=A0 [&lt;ffffff=
ff8122e3c9&gt;] SyS_ioctl+0x79/0x90<br>[11640.389844]=C2=A0 [&lt;ffffffff81=
8138b6&gt;] entry_SYSCALL_64_fastpath+0x1e/0xa8<br>[11760.390205] INFO: tas=
k Xorg:2636 blocked for more than 120 seconds.<br>[11760.390208]=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 4.7.0-si+ #1<br>[11760.390208] &quo=
t;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs&quot; disables this m=
essage.<br>[11760.390209] Xorg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 D ffff88020f643898=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 26=
36=C2=A0=C2=A0 2624 0x00400004<br>[11760.390212]=C2=A0 ffff88020f643898 fff=
f880034ba0000 ffff88021522c740 ffff88020e9b0e40<br>[11760.390213]=C2=A0 fff=
f880034ba1f00 ffff88020f644000 ffff88020f6439b8 ffff880034ba1ee0<br>[11760.=
390215]=C2=A0 0000000000000000 ffff880034ba0000 ffff88020f6438b0 ffffffff81=
80f575<br>[11760.390216] Call Trace:<br>[11760.390221]=C2=A0 [&lt;ffffffff8=
180f575&gt;] schedule+0x35/0x80<br>[11760.390244]=C2=A0 [&lt;ffffffffc01b1a=
57&gt;] amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>[11760.390247]=C2=
=A0 [&lt;ffffffff810c3490&gt;] ? wake_atomic_t_function+0x60/0x60<br>[11760=
.390262]=C2=A0 [&lt;ffffffffc01b2454&gt;] amdgpu_job_submit+0x84/0xc0 [amdg=
pu]<br>[11760.390273]=C2=A0 [&lt;ffffffffc01458aa&gt;] amdgpu_copy_buffer+0=
x14a/0x1c0 [amdgpu]<br>[11760.390282]=C2=A0 [&lt;ffffffffc01459bd&gt;] amdg=
pu_move_blit+0x9d/0x140 [amdgpu]<br>[11760.390291]=C2=A0 [&lt;ffffffffc0145=
e2a&gt;] amdgpu_bo_move+0xca/0x270 [amdgpu]<br>[11760.390296]=C2=A0 [&lt;ff=
ffffffc00e9bc9&gt;] ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>[11760.3902=
98]=C2=A0 [&lt;ffffffffc00ead4a&gt;] ttm_bo_validate+0x13a/0x150 [ttm]<br>[=
11760.390309]=C2=A0 [&lt;ffffffffc014d30f&gt;] amdgpu_cs_list_validate+0xaf=
/0x1c0 [amdgpu]<br>[11760.390319]=C2=A0 [&lt;ffffffffc014e4ab&gt;] amdgpu_c=
s_ioctl+0xeab/0x10c0 [amdgpu]<br>[11760.390321]=C2=A0 [&lt;ffffffff8113f300=
&gt;] ? __delayacct_tsk_init+0x40/0x40<br>[11760.390331]=C2=A0 [&lt;fffffff=
fc0071d7d&gt;] drm_ioctl+0x2cd/0x490 [drm]<br>[11760.390341]=C2=A0 [&lt;fff=
fffffc014d600&gt;] ? amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>[11760.39=
0350]=C2=A0 [&lt;ffffffffc013304c&gt;] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<=
br>[11760.390352]=C2=A0 [&lt;ffffffff8122de41&gt;] do_vfs_ioctl+0xa1/0x5b0<=
br>[11760.390353]=C2=A0 [&lt;ffffffff81090fd4&gt;] ? restore_altstack+0x24/=
0x40<br>[11760.390355]=C2=A0 [&lt;ffffffff8122e3c9&gt;] SyS_ioctl+0x79/0x90=
<br>[11760.390357]=C2=A0 [&lt;ffffffff818138b6&gt;] entry_SYSCALL_64_fastpa=
th+0x1e/0xa8<br>[11880.390520] INFO: task Xorg:2636 blocked for more than 1=
20 seconds.<br>[11880.390525]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not taint=
ed 4.7.0-si+ #1<br>[11880.390527] &quot;echo 0 &gt; /proc/sys/kernel/hung_t=
ask_timeout_secs&quot; disables this message.<br>[11880.390529] Xorg=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D ffff88020f64=
3898=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 2636=C2=A0=C2=A0 2624 0x00400004<br>[1=
1880.390534]=C2=A0 ffff88020f643898 ffff880034ba0000 ffff88021522c740 ffff8=
8020e9b0e40<br>[11880.390538]=C2=A0 ffff880034ba1f00 ffff88020f644000 ffff8=
8020f6439b8 ffff880034ba1ee0<br>[11880.390541]=C2=A0 0000000000000000 ffff8=
80034ba0000 ffff88020f6438b0 ffffffff8180f575<br>[11880.390544] Call Trace:=
<br>[11880.390552]=C2=A0 [&lt;ffffffff8180f575&gt;] schedule+0x35/0x80<br>[=
11880.390591]=C2=A0 [&lt;ffffffffc01b1a57&gt;] amd_sched_entity_push_job+0x=
77/0x110 [amdgpu]<br>[11880.390594]=C2=A0 [&lt;ffffffff810c3490&gt;] ? wake=
_atomic_t_function+0x60/0x60<br>[11880.390609]=C2=A0 [&lt;ffffffffc01b2454&=
gt;] amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>[11880.390619]=C2=A0 [&lt;ffff=
ffffc01458aa&gt;] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>[11880.390629]=
=C2=A0 [&lt;ffffffffc01459bd&gt;] amdgpu_move_blit+0x9d/0x140 [amdgpu]<br>[=
11880.390639]=C2=A0 [&lt;ffffffffc0145e2a&gt;] amdgpu_bo_move+0xca/0x270 [a=
mdgpu]<br>[11880.390643]=C2=A0 [&lt;ffffffffc00e9bc9&gt;] ttm_bo_handle_mov=
e_mem+0x279/0x5a0 [ttm]<br>[11880.390646]=C2=A0 [&lt;ffffffffc00ead4a&gt;] =
ttm_bo_validate+0x13a/0x150 [ttm]<br>[11880.390657]=C2=A0 [&lt;ffffffffc014=
d30f&gt;] amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>[11880.390667]=C2=
=A0 [&lt;ffffffffc014e4ab&gt;] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>[11=
880.390669]=C2=A0 [&lt;ffffffff8113f300&gt;] ? __delayacct_tsk_init+0x40/0x=
40<br>[11880.390679]=C2=A0 [&lt;ffffffffc0071d7d&gt;] drm_ioctl+0x2cd/0x490=
 [drm]<br>[11880.390690]=C2=A0 [&lt;ffffffffc014d600&gt;] ? amdgpu_cs_find_=
mapping+0xa0/0xa0 [amdgpu]<br>[11880.390699]=C2=A0 [&lt;ffffffffc013304c&gt=
;] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>[11880.390701]=C2=A0 [&lt;fffffff=
f8122de41&gt;] do_vfs_ioctl+0xa1/0x5b0<br>[11880.390703]=C2=A0 [&lt;fffffff=
f81090fd4&gt;] ? restore_altstack+0x24/0x40<br>[11880.390704]=C2=A0 [&lt;ff=
ffffff8122e3c9&gt;] SyS_ioctl+0x79/0x90<br>[11880.390706]=C2=A0 [&lt;ffffff=
ff818138b6&gt;] entry_SYSCALL_64_fastpath+0x1e/0xa8<br>[12000.390944] INFO:=
 task Xorg:2636 blocked for more than 120 seconds.<br>[12000.390949]=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 4.7.0-si+ #1<br>[12000.390950] &=
quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs&quot; disables thi=
s message.<br>[12000.390953] Xorg=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 D ffff88020f643898=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
 2636=C2=A0=C2=A0 2624 0x00400004<br>[12000.390958]=C2=A0 ffff88020f643898 =
ffff880034ba0000 ffff88021522c740 ffff88020e9b0e40<br>[12000.390961]=C2=A0 =
ffff880034ba1f00 ffff88020f644000 ffff88020f6439b8 ffff880034ba1ee0<br>[120=
00.390964]=C2=A0 0000000000000000 ffff880034ba0000 ffff88020f6438b0 fffffff=
f8180f575<br>[12000.390967] Call Trace:<br>[12000.390976]=C2=A0 [&lt;ffffff=
ff8180f575&gt;] schedule+0x35/0x80<br>[12000.391014]=C2=A0 [&lt;ffffffffc01=
b1a57&gt;] amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>[12000.391017]=
=C2=A0 [&lt;ffffffff810c3490&gt;] ? wake_atomic_t_function+0x60/0x60<br>[12=
000.391032]=C2=A0 [&lt;ffffffffc01b2454&gt;] amdgpu_job_submit+0x84/0xc0 [a=
mdgpu]<br>[12000.391043]=C2=A0 [&lt;ffffffffc01458aa&gt;] amdgpu_copy_buffe=
r+0x14a/0x1c0 [amdgpu]<br>[12000.391053]=C2=A0 [&lt;ffffffffc01459bd&gt;] a=
mdgpu_move_blit+0x9d/0x140 [amdgpu]<br>[12000.391062]=C2=A0 [&lt;ffffffffc0=
145e2a&gt;] amdgpu_bo_move+0xca/0x270 [amdgpu]<br>[12000.391066]=C2=A0 [&lt=
;ffffffffc00e9bc9&gt;] ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>[12000.3=
91069]=C2=A0 [&lt;ffffffffc00ead4a&gt;] ttm_bo_validate+0x13a/0x150 [ttm]<b=
r>[12000.391080]=C2=A0 [&lt;ffffffffc014d30f&gt;] amdgpu_cs_list_validate+0=
xaf/0x1c0 [amdgpu]<br>[12000.391090]=C2=A0 [&lt;ffffffffc014e4ab&gt;] amdgp=
u_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>[12000.391092]=C2=A0 [&lt;ffffffff8113f=
300&gt;] ? __delayacct_tsk_init+0x40/0x40<br>[12000.391103]=C2=A0 [&lt;ffff=
ffffc0071d7d&gt;] drm_ioctl+0x2cd/0x490 [drm]<br>[12000.391113]=C2=A0 [&lt;=
ffffffffc014d600&gt;] ? amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>[12000=
.391122]=C2=A0 [&lt;ffffffffc013304c&gt;] amdgpu_drm_ioctl+0x4c/0x80 [amdgp=
u]<br>[12000.391124]=C2=A0 [&lt;ffffffff8122de41&gt;] do_vfs_ioctl+0xa1/0x5=
b0<br>[12000.391126]=C2=A0 [&lt;ffffffff81090fd4&gt;] ? restore_altstack+0x=
24/0x40<br>[12000.391127]=C2=A0 [&lt;ffffffff8122e3c9&gt;] SyS_ioctl+0x79/0=
x90<br>[12000.391129]=C2=A0 [&lt;ffffffff818138b6&gt;] entry_SYSCALL_64_fas=
tpath+0x1e/0xa8<br>[12120.391376] INFO: task Xorg:2636 blocked for more tha=
n 120 seconds.<br>[12120.391381]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not ta=
inted 4.7.0-si+ #1<br>[12120.391383] &quot;echo 0 &gt; /proc/sys/kernel/hun=
g_task_timeout_secs&quot; disables this message.<br>[12120.391385] Xorg=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 D ffff88020=
f643898=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 2636=C2=A0=C2=A0 2624 0x00400004<br=
>[12120.391390]=C2=A0 ffff88020f643898 ffff880034ba0000 ffff88021522c740 ff=
ff88020e9b0e40<br>[12120.391393]=C2=A0 ffff880034ba1f00 ffff88020f644000 ff=
ff88020f6439b8 ffff880034ba1ee0<br>[12120.391396]=C2=A0 0000000000000000 ff=
ff880034ba0000 ffff88020f6438b0 ffffffff8180f575<br>[12120.391399] Call Tra=
ce:<br>[12120.391407]=C2=A0 [&lt;ffffffff8180f575&gt;] schedule+0x35/0x80<b=
r>[12120.391445]=C2=A0 [&lt;ffffffffc01b1a57&gt;] amd_sched_entity_push_job=
+0x77/0x110 [amdgpu]<br>[12120.391448]=C2=A0 [&lt;ffffffff810c3490&gt;] ? w=
ake_atomic_t_function+0x60/0x60<br>[12120.391463]=C2=A0 [&lt;ffffffffc01b24=
54&gt;] amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>[12120.391474]=C2=A0 [&lt;f=
fffffffc01458aa&gt;] amdgpu_copy_buffer+0x14a/0x1c0 [amdgpu]<br>[12120.3914=
84]=C2=A0 [&lt;ffffffffc01459bd&gt;] amdgpu_move_blit+0x9d/0x140 [amdgpu]<b=
r>[12120.391493]=C2=A0 [&lt;ffffffffc0145e2a&gt;] amdgpu_bo_move+0xca/0x270=
 [amdgpu]<br>[12120.391497]=C2=A0 [&lt;ffffffffc00e9bc9&gt;] ttm_bo_handle_=
move_mem+0x279/0x5a0 [ttm]<br>[12120.391500]=C2=A0 [&lt;ffffffffc00ead4a&gt=
;] ttm_bo_validate+0x13a/0x150 [ttm]<br>[12120.391511]=C2=A0 [&lt;ffffffffc=
014d30f&gt;] amdgpu_cs_list_validate+0xaf/0x1c0 [amdgpu]<br>[12120.391522]=
=C2=A0 [&lt;ffffffffc014e4ab&gt;] amdgpu_cs_ioctl+0xeab/0x10c0 [amdgpu]<br>=
[12120.391524]=C2=A0 [&lt;ffffffff8113f300&gt;] ? __delayacct_tsk_init+0x40=
/0x40<br>[12120.391534]=C2=A0 [&lt;ffffffffc0071d7d&gt;] drm_ioctl+0x2cd/0x=
490 [drm]<br>[12120.391544]=C2=A0 [&lt;ffffffffc014d600&gt;] ? amdgpu_cs_fi=
nd_mapping+0xa0/0xa0 [amdgpu]<br>[12120.391553]=C2=A0 [&lt;ffffffffc013304c=
&gt;] amdgpu_drm_ioctl+0x4c/0x80 [amdgpu]<br>[12120.391555]=C2=A0 [&lt;ffff=
ffff8122de41&gt;] do_vfs_ioctl+0xa1/0x5b0<br>[12120.391557]=C2=A0 [&lt;ffff=
ffff81090fd4&gt;] ? restore_altstack+0x24/0x40<br>[12120.391558]=C2=A0 [&lt=
;ffffffff8122e3c9&gt;] SyS_ioctl+0x79/0x90<br>[12120.391560]=C2=A0 [&lt;fff=
fffff818138b6&gt;] entry_SYSCALL_64_fastpath+0x1e/0xa8<br>[12120.391583] IN=
FO: task qtcreator:712 blocked for more than 120 seconds.<br>[12120.391584]=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 4.7.0-si+ #1<br>[12120.391=
584] &quot;echo 0 &gt; /proc/sys/kernel/hung_task_timeout_secs&quot; disabl=
es this message.<br>[12120.391585] qtcreator=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 D ffff8800854af7c8=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0 712=C2=A0=
=C2=A0 2661 0x00000000<br>[12120.391586]=C2=A0 ffff8800854af7c8 ffff880034b=
a0000 ffff88021522c740 ffff8801a0870000<br>[12120.391588]=C2=A0 ffff880034b=
a1f00 ffff8800854b0000 ffff8800854af8e8 ffff880034ba1ee0<br>[12120.391589]=
=C2=A0 0000000000000000 ffff880034ba0000 ffff8800854af7e0 ffffffff8180f575<=
br>[12120.391590] Call Trace:<br>[12120.391592]=C2=A0 [&lt;ffffffff8180f575=
&gt;] schedule+0x35/0x80<br>[12120.391606]=C2=A0 [&lt;ffffffffc01b1a57&gt;]=
 amd_sched_entity_push_job+0x77/0x110 [amdgpu]<br>[12120.391608]=C2=A0 [&lt=
;ffffffff810c3490&gt;] ? wake_atomic_t_function+0x60/0x60<br>[12120.391621]=
=C2=A0 [&lt;ffffffffc01b2454&gt;] amdgpu_job_submit+0x84/0xc0 [amdgpu]<br>[=
12120.391630]=C2=A0 [&lt;ffffffffc01458aa&gt;] amdgpu_copy_buffer+0x14a/0x1=
c0 [amdgpu]<br>[12120.391640]=C2=A0 [&lt;ffffffffc01459bd&gt;] amdgpu_move_=
blit+0x9d/0x140 [amdgpu]<br>[12120.391649]=C2=A0 [&lt;ffffffffc0145d24&gt;]=
 amdgpu_move_ram_vram+0x134/0x170 [amdgpu]<br>[12120.391651]=C2=A0 [&lt;fff=
fffff811ba4e8&gt;] ? krealloc+0x28/0xc0<br>[12120.391661]=C2=A0 [&lt;ffffff=
ffc0145fa1&gt;] amdgpu_bo_move+0x241/0x270 [amdgpu]<br>[12120.391664]=C2=A0=
 [&lt;ffffffffc00e9bc9&gt;] ttm_bo_handle_move_mem+0x279/0x5a0 [ttm]<br>[12=
120.391666]=C2=A0 [&lt;ffffffffc00ead4a&gt;] ttm_bo_validate+0x13a/0x150 [t=
tm]<br>[12120.391668]=C2=A0 [&lt;ffffffff811ba4e8&gt;] ? krealloc+0x28/0xc0=
<br>[12120.391678]=C2=A0 [&lt;ffffffffc014d30f&gt;] amdgpu_cs_list_validate=
+0xaf/0x1c0 [amdgpu]<br>[12120.391688]=C2=A0 [&lt;ffffffffc014e450&gt;] amd=
gpu_cs_ioctl+0xe50/0x10c0 [amdgpu]<br>[12120.391696]=C2=A0 [&lt;ffffffffc00=
71d7d&gt;] drm_ioctl+0x2cd/0x490 [drm]<br>[12120.391705]=C2=A0 [&lt;fffffff=
fc014d600&gt;] ? amdgpu_cs_find_mapping+0xa0/0xa0 [amdgpu]<br>[12120.391707=
]=C2=A0 [&lt;ffffffff81191f96&gt;] ? unlock_page+0x76/0x80<br>[12120.391709=
]=C2=A0 [&lt;ffffffff811c828a&gt;] ? handle_mm_fault+0x11ea/0x1d90<br>[1212=
0.391717]=C2=A0 [&lt;ffffffffc013304c&gt;] amdgpu_drm_ioctl+0x4c/0x80 [amdg=
pu]<br>[12120.391719]=C2=A0 [&lt;ffffffff8122de41&gt;] do_vfs_ioctl+0xa1/0x=
5b0<br>[12120.391721]=C2=A0 [&lt;ffffffff81069515&gt;] ? __do_page_fault+0x=
205/0x4d0<br>[12120.391722]=C2=A0 [&lt;ffffffff8122e3c9&gt;] SyS_ioctl+0x79=
/0x90<br>[12120.391724]=C2=A0 [&lt;ffffffff818138b6&gt;] entry_SYSCALL_64_f=
astpath+0x1e/0xa8<br><br></div><div></div><div>Marek<br></div></div></div>

--001a1141f53498f0b5053a42b12b--

--===============2122998153==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2122998153==--
