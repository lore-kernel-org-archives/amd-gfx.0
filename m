Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB7CC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Dec 2021 17:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2103F10EAF9;
	Sun, 12 Dec 2021 17:54:42 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:8234::])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6B110F0E9
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Dec 2021 11:53:43 +0000 (UTC)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74]
 helo=[192.168.66.200]); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1mwNQD-0002j9-UD; Sun, 12 Dec 2021 12:53:42 +0100
Message-ID: <ebb7331b-f343-b6b9-7e1f-8193189713b7@leemhuis.info>
Date: Sun, 12 Dec 2021 12:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-BS
To: Mark Boddington <lkml@badpenguin.co.uk>, amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <99797fb7-76eb-9d86-ad2f-591243eca404@badpenguin.co.uk>
 <7e1fd10f-ecd7-a4b7-bd46-327970baeb66@leemhuis.info>
 <8e42f35b-2377-e0a3-3c8b-cab844c51412@badpenguin.co.uk>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: kernel 5.15.x: AMD RX 6700 XT - Fails to resume after screen blank
In-Reply-To: <8e42f35b-2377-e0a3-3c8b-cab844c51412@badpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1639310024;
 8de55134; 
X-HE-SMSGID: 1mwNQD-0002j9-UD
X-Mailman-Approved-At: Sun, 12 Dec 2021 17:54:38 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, regressions@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi, this is your Linux kernel regression tracker speaking.

On 26.11.21 12:52, Mark Boddington wrote:
> On 25/11/2021 11:09, Thorsten Leemhuis wrote:
>> On 24.11.21 20:14, Mark Boddington wrote:
>>>
>>> TL;DR - git bisection points to
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.15.4&id=61d861cf478576d85d6032f864360a34b26084b1
>>>
>>> as causing an issue when changing power state after idle.
>>> I have been running 5.15.4 with 61d861cf478576d85d6032f864360a34b26084b1
>>> backed out for a few hours with multiple periods of power saving, and so
>>> far so good.
>>>
> 
> My 5.15.4 image with the above patch reversed has now failed :-/
> 
> I may have to start the bisection again, I'm going to run 5.14.x for a
> while to double check that I'm not seeing failures with that kernel.

Mark, we afaics haven't heard anything from you for more than two weeks
now. I'm thus removing this regression from the tracking:

#regzbot invalid needs further investigation, might not be a regression
#regzbot ignore-activity

If the issue still exists, please report it freshly in a new thread
(with regressions lists CCed if it is a regression), as continuing this
thread would make things hard to understand.

Ciao, Thorsten

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply. That's in everyone's interest, as
what I wrote above might be misleading to everyone reading this; any
suggestion I gave thus might sent someone reading this down the wrong
rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.


> dmesg output below:
> 
> [   19.649223] Bluetooth: RFCOMM TTY layer initialized
> [   19.649229] Bluetooth: RFCOMM socket layer initialized
> [   19.649233] Bluetooth: RFCOMM ver 1.11
> [ 1561.099516] TCP: ovs0: Driver has suspect GRO implementation, TCP
> performance may be compromised.
> [ 6138.725493] [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error
> waiting for DMUB idle: status=3
> [ 6144.795396] amdgpu 0000:0d:00.0: amdgpu: Failed to export SMU metrics
> table!
> [ 6150.119936] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6150.119942] amdgpu 0000:0d:00.0: amdgpu: Failed to export SMU metrics
> table!
> [ 6152.705334] [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error
> waiting for DMUB idle: status=3
> [ 6155.568460] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6155.568464] amdgpu 0000:0d:00.0: amdgpu: Failed to export SMU metrics
> table!
> [ 6160.995903] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6160.995908] amdgpu 0000:0d:00.0: amdgpu: Failed to export SMU metrics
> table!
> [ 6162.497789] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
> timeout, signaled seq=1594, emitted seq=1595
> [ 6162.498065] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> information: process  pid 0 thread  pid 0
> [ 6162.498319] amdgpu 0000:0d:00.0: amdgpu: GPU reset begin!
> [ 6162.507789] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_0.0.0
> timeout, signaled seq=475098, emitted seq=475100
> [ 6162.507932] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> information: process Xorg pid 2161 thread Xorg:cs0 pid 2377
> [ 6162.508070] amdgpu 0000:0d:00.0: amdgpu: GPU reset begin!
> [ 6162.508072] amdgpu 0000:0d:00.0: amdgpu: Bailing on TDR for
> s_job:739f4, as another already in progress
> [ 6166.225793] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6166.225797] amdgpu 0000:0d:00.0: amdgpu:
> [smu_v11_0_get_current_power_limit] get PPT limit failed!
> [ 6171.643572] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6171.643577] amdgpu 0000:0d:00.0: amdgpu: Failed to disable gfxoff!
> [ 6172.255793] [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error
> waiting for DMUB idle: status=3
> [ 6174.939024] [drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error
> waiting for DMUB idle: status=3
> [ 6182.406334] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to
> initialize parser -125!
> [ 6189.245229] amdgpu 0000:0d:00.0: [drm:amdgpu_ring_test_helper
> [amdgpu]] *ERROR* ring kiq_2.1.0 test failed (-110)
> [ 6189.245375] [drm:gfx_v10_0_hw_fini [amdgpu]] *ERROR* KGQ disable failed
> [ 6189.566305] amdgpu 0000:0d:00.0: [drm:amdgpu_ring_test_helper
> [amdgpu]] *ERROR* ring kiq_2.1.0 test failed (-110)
> [ 6189.566438] [drm:gfx_v10_0_hw_fini [amdgpu]] *ERROR* KCQ disable failed
> [ 6194.992043] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6194.992047] amdgpu 0000:0d:00.0: amdgpu: Failed to disable smu features.
> [ 6194.992051] amdgpu 0000:0d:00.0: amdgpu: Fail to disable dpm features!
> [ 6194.992052] [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR*
> suspend of IP block <smu> failed -62
> [ 6194.998471] [drm] free PSP TMR buffer
> [ 6196.097613] [drm] psp gfx command DESTROY_TMR(0x7) failed and
> response status is (0x80000306)
> [ 6196.118600] amdgpu 0000:0d:00.0: amdgpu: MODE1 reset
> [ 6196.118603] amdgpu 0000:0d:00.0: amdgpu: GPU mode1 reset
> [ 6196.118687] amdgpu 0000:0d:00.0: amdgpu: GPU smu mode1 reset
> [ 6201.448499] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6201.448504] amdgpu 0000:0d:00.0: amdgpu: GPU mode1 reset failed
> [ 6201.448613] amdgpu 0000:0d:00.0: amdgpu: ASIC reset failed with
> error, -62 for drm dev, 0000:0d:00.0
> [ 6212.510187] amdgpu 0000:0d:00.0: amdgpu: GPU reset succeeded, trying
> to resume
> [ 6212.510455] [drm] PCIE GART of 512M enabled (table at
> 0x0000008000300000).
> [ 6212.510484] [drm] VRAM is lost due to GPU reset!
> [ 6212.511461] [drm] PSP is resuming...
> [ 6213.625806] [drm] failed to load ucode SMC(0x18)
> [ 6213.625824] [drm] psp gfx command LOAD_IP_FW(0x6) failed and response
> status is (0x80000306)
> [ 6213.625829] [drm] reserve 0xa00000 from 0x82fe000000 for PSP TMR
> [ 6213.852751] amdgpu 0000:0d:00.0: amdgpu: RAS: optional ras ta ucode
> is not available
> [ 6213.862032] amdgpu 0000:0d:00.0: amdgpu: SECUREDISPLAY: securedisplay
> ta ucode is not available
> [ 6213.862035] amdgpu 0000:0d:00.0: amdgpu: SMU is resuming...
> [ 6219.071568] amdgpu 0000:0d:00.0: amdgpu: SMU: I'm not done with your
> previous command!
> [ 6219.071572] amdgpu 0000:0d:00.0: amdgpu: Failed to SetDriverDramAddr!
> [ 6219.071574] amdgpu 0000:0d:00.0: amdgpu: Failed to setup smc hw!
> [ 6219.071575] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR*
> resume of IP block <smu> failed -62
> [ 6219.071741] amdgpu 0000:0d:00.0: amdgpu: GPU reset(2) failed
> [ 6219.088069] snd_hda_intel 0000:0d:00.1: refused to change power state
> from D3hot to D0
> [ 6219.192673] snd_hda_intel 0000:0d:00.1: CORB reset timeout#2, CORBRP
> = 65535
> [ 6219.192686] amdgpu 0000:0d:00.0: amdgpu: GPU reset end with ret = -62
> [ 6229.312058] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0
> timeout, signaled seq=1595, emitted seq=1595
> [ 6229.312240] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process
> information: process  pid 0 thread  pid 0
> [ 6229.312395] amdgpu 0000:0d:00.0: amdgpu: GPU reset begin!
> [ 6405.179186] INFO: task kworker/6:0:9999 blocked for more than 120
> seconds.
> [ 6405.179193]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6405.179195] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6405.179196] task:kworker/6:0     state:D stack:    0 pid: 9999
> ppid:     2 flags:0x00004000
> [ 6405.179201] Workqueue: events drm_sched_job_timedout [gpu_sched]
> [ 6405.179210] Call Trace:
> [ 6405.179211]  <TASK>
> [ 6405.179214]  __schedule+0x2aa/0x7c0
> [ 6405.179219]  schedule+0x4e/0xb0
> [ 6405.179221]  schedule_timeout+0x202/0x290
> [ 6405.179223]  ? ttwu_do_wakeup+0x53/0x170
> [ 6405.179227]  ? raw_spin_rq_lock_nested.constprop.0+0x10/0x20
> [ 6405.179230]  dma_fence_default_wait+0x174/0x200
> [ 6405.179233]  ? dma_fence_release+0x140/0x140
> [ 6405.179235]  dma_fence_wait_timeout+0xb7/0xd0
> [ 6405.179237]  drm_sched_stop+0xf7/0x170 [gpu_sched]
> [ 6405.179242]  amdgpu_device_gpu_recover.cold+0xa7a/0xab3 [amdgpu]
> [ 6405.179436]  ? amdgpu_job_timedout+0xf5/0x170 [amdgpu]
> [ 6405.179603]  amdgpu_job_timedout+0x14f/0x170 [amdgpu]
> [ 6405.179751]  drm_sched_job_timedout+0x76/0xf0 [gpu_sched]
> [ 6405.179754]  process_one_work+0x229/0x3d0
> [ 6405.179758]  worker_thread+0x4d/0x3f0
> [ 6405.179760]  ? process_one_work+0x3d0/0x3d0
> [ 6405.179762]  kthread+0x12a/0x150
> [ 6405.179764]  ? set_kthread_struct+0x40/0x40
> [ 6405.179765]  ret_from_fork+0x22/0x30
> [ 6405.179770]  </TASK>
> [ 6405.179782] INFO: task cinnamon:18527 blocked for more than 120 seconds.
> [ 6405.179784]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6405.179786] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6405.179786] task:cinnamon        state:D stack:    0 pid:18527 ppid: 
> 3109 flags:0x00000000
> [ 6405.179789] Call Trace:
> [ 6405.179790]  <TASK>
> [ 6405.179791]  __schedule+0x2aa/0x7c0
> [ 6405.179793]  ? posix_lock_inode+0x156/0x7f0
> [ 6405.179797]  schedule+0x4e/0xb0
> [ 6405.179799]  schedule_preempt_disabled+0xe/0x10
> [ 6405.179800]  __mutex_lock.isra.0+0x208/0x470
> [ 6405.179803]  __mutex_lock_slowpath+0x13/0x20
> [ 6405.179805]  mutex_lock+0x32/0x40
> [ 6405.179807]  amdgpu_ctx_mgr_entity_flush+0x40/0xf0 [amdgpu]
> [ 6405.179945]  amdgpu_flush+0x2b/0x50 [amdgpu]
> [ 6405.180067]  filp_close+0x37/0x70
> [ 6405.180071]  put_files_struct+0x6d/0xc0
> [ 6405.180074]  exit_files+0x49/0x50
> [ 6405.180076]  do_exit+0x345/0xad0
> [ 6405.180078]  do_group_exit+0x43/0xb0
> [ 6405.180080]  __x64_sys_exit_group+0x18/0x20
> [ 6405.180082]  do_syscall_64+0x5c/0xc0
> [ 6405.180085]  ? vfs_write+0x185/0x260
> [ 6405.180088]  ? exit_to_user_mode_prepare+0x3d/0x1c0
> [ 6405.180090]  ? filp_close+0x60/0x70
> [ 6405.180092]  ? syscall_exit_to_user_mode+0x27/0x50
> [ 6405.180094]  ? __x64_sys_close+0x12/0x40
> [ 6405.180096]  ? do_syscall_64+0x69/0xc0
> [ 6405.180098]  ? exc_page_fault+0x89/0x160
> [ 6405.180100]  ? asm_exc_page_fault+0x8/0x30
> [ 6405.180102]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 6405.180105] RIP: 0033:0x7f13be0472c6
> [ 6405.180107] RSP: 002b:00007fff80e7b878 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [ 6405.180109] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f13be0472c6
> [ 6405.180111] RDX: 0000000000000000 RSI: 000000000000003c RDI:
> 0000000000000000
> [ 6405.180112] RBP: 000055f28bde3d80 R08: 00000000000000e7 R09:
> ffffffffffffff80
> [ 6405.180113] R10: 00007f13b7defe10 R11: 0000000000000246 R12:
> 00007fff80e7ebc4
> [ 6405.180114] R13: 00007fff80e7ba00 R14: 0000000000000001 R15:
> 00007fff80e7be00
> [ 6405.180116]  </TASK>
> [ 6526.007925] INFO: task kworker/6:0:9999 blocked for more than 241
> seconds.
> [ 6526.007932]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6526.007935] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6526.007936] task:kworker/6:0     state:D stack:    0 pid: 9999
> ppid:     2 flags:0x00004000
> [ 6526.007941] Workqueue: events drm_sched_job_timedout [gpu_sched]
> [ 6526.007950] Call Trace:
> [ 6526.007951]  <TASK>
> [ 6526.007954]  __schedule+0x2aa/0x7c0
> [ 6526.007959]  schedule+0x4e/0xb0
> [ 6526.007961]  schedule_timeout+0x202/0x290
> [ 6526.007964]  ? ttwu_do_wakeup+0x53/0x170
> [ 6526.007968]  ? raw_spin_rq_lock_nested.constprop.0+0x10/0x20
> [ 6526.007971]  dma_fence_default_wait+0x174/0x200
> [ 6526.007975]  ? dma_fence_release+0x140/0x140
> [ 6526.007977]  dma_fence_wait_timeout+0xb7/0xd0
> [ 6526.007979]  drm_sched_stop+0xf7/0x170 [gpu_sched]
> [ 6526.007983]  amdgpu_device_gpu_recover.cold+0xa7a/0xab3 [amdgpu]
> [ 6526.008181]  ? amdgpu_job_timedout+0xf5/0x170 [amdgpu]
> [ 6526.008350]  amdgpu_job_timedout+0x14f/0x170 [amdgpu]
> [ 6526.008501]  drm_sched_job_timedout+0x76/0xf0 [gpu_sched]
> [ 6526.008505]  process_one_work+0x229/0x3d0
> [ 6526.008509]  worker_thread+0x4d/0x3f0
> [ 6526.008511]  ? process_one_work+0x3d0/0x3d0
> [ 6526.008513]  kthread+0x12a/0x150
> [ 6526.008515]  ? set_kthread_struct+0x40/0x40
> [ 6526.008517]  ret_from_fork+0x22/0x30
> [ 6526.008521]  </TASK>
> [ 6526.008537] INFO: task cinnamon:18527 blocked for more than 241 seconds.
> [ 6526.008539]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6526.008540] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6526.008541] task:cinnamon        state:D stack:    0 pid:18527 ppid: 
> 3109 flags:0x00000000
> [ 6526.008544] Call Trace:
> [ 6526.008545]  <TASK>
> [ 6526.008546]  __schedule+0x2aa/0x7c0
> [ 6526.008549]  ? posix_lock_inode+0x156/0x7f0
> [ 6526.008552]  schedule+0x4e/0xb0
> [ 6526.008554]  schedule_preempt_disabled+0xe/0x10
> [ 6526.008556]  __mutex_lock.isra.0+0x208/0x470
> [ 6526.008558]  __mutex_lock_slowpath+0x13/0x20
> [ 6526.008560]  mutex_lock+0x32/0x40
> [ 6526.008562]  amdgpu_ctx_mgr_entity_flush+0x40/0xf0 [amdgpu]
> [ 6526.008698]  amdgpu_flush+0x2b/0x50 [amdgpu]
> [ 6526.008823]  filp_close+0x37/0x70
> [ 6526.008827]  put_files_struct+0x6d/0xc0
> [ 6526.008830]  exit_files+0x49/0x50
> [ 6526.008832]  do_exit+0x345/0xad0
> [ 6526.008835]  do_group_exit+0x43/0xb0
> [ 6526.008837]  __x64_sys_exit_group+0x18/0x20
> [ 6526.008838]  do_syscall_64+0x5c/0xc0
> [ 6526.008841]  ? vfs_write+0x185/0x260
> [ 6526.008844]  ? exit_to_user_mode_prepare+0x3d/0x1c0
> [ 6526.008847]  ? filp_close+0x60/0x70
> [ 6526.008849]  ? syscall_exit_to_user_mode+0x27/0x50
> [ 6526.008851]  ? __x64_sys_close+0x12/0x40
> [ 6526.008853]  ? do_syscall_64+0x69/0xc0
> [ 6526.008855]  ? exc_page_fault+0x89/0x160
> [ 6526.008857]  ? asm_exc_page_fault+0x8/0x30
> [ 6526.008859]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 6526.008862] RIP: 0033:0x7f13be0472c6
> [ 6526.008864] RSP: 002b:00007fff80e7b878 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [ 6526.008866] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f13be0472c6
> [ 6526.008868] RDX: 0000000000000000 RSI: 000000000000003c RDI:
> 0000000000000000
> [ 6526.008869] RBP: 000055f28bde3d80 R08: 00000000000000e7 R09:
> ffffffffffffff80
> [ 6526.008870] R10: 00007f13b7defe10 R11: 0000000000000246 R12:
> 00007fff80e7ebc4
> [ 6526.008871] R13: 00007fff80e7ba00 R14: 0000000000000001 R15:
> 00007fff80e7be00
> [ 6526.008873]  </TASK>
> [ 6646.836793] INFO: task kworker/6:0:9999 blocked for more than 362
> seconds.
> [ 6646.836800]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6646.836803] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6646.836804] task:kworker/6:0     state:D stack:    0 pid: 9999
> ppid:     2 flags:0x00004000
> [ 6646.836809] Workqueue: events drm_sched_job_timedout [gpu_sched]
> [ 6646.836817] Call Trace:
> [ 6646.836819]  <TASK>
> [ 6646.836821]  __schedule+0x2aa/0x7c0
> [ 6646.836826]  schedule+0x4e/0xb0
> [ 6646.836827]  schedule_timeout+0x202/0x290
> [ 6646.836830]  ? ttwu_do_wakeup+0x53/0x170
> [ 6646.836833]  ? raw_spin_rq_lock_nested.constprop.0+0x10/0x20
> [ 6646.836837]  dma_fence_default_wait+0x174/0x200
> [ 6646.836840]  ? dma_fence_release+0x140/0x140
> [ 6646.836842]  dma_fence_wait_timeout+0xb7/0xd0
> [ 6646.836844]  drm_sched_stop+0xf7/0x170 [gpu_sched]
> [ 6646.836849]  amdgpu_device_gpu_recover.cold+0xa7a/0xab3 [amdgpu]
> [ 6646.837043]  ? amdgpu_job_timedout+0xf5/0x170 [amdgpu]
> [ 6646.837211]  amdgpu_job_timedout+0x14f/0x170 [amdgpu]
> [ 6646.837359]  drm_sched_job_timedout+0x76/0xf0 [gpu_sched]
> [ 6646.837363]  process_one_work+0x229/0x3d0
> [ 6646.837367]  worker_thread+0x4d/0x3f0
> [ 6646.837369]  ? process_one_work+0x3d0/0x3d0
> [ 6646.837371]  kthread+0x12a/0x150
> [ 6646.837373]  ? set_kthread_struct+0x40/0x40
> [ 6646.837374]  ret_from_fork+0x22/0x30
> [ 6646.837379]  </TASK>
> [ 6646.837392] INFO: task cinnamon:18527 blocked for more than 362 seconds.
> [ 6646.837394]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6646.837395] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6646.837396] task:cinnamon        state:D stack:    0 pid:18527 ppid: 
> 3109 flags:0x00000000
> [ 6646.837399] Call Trace:
> [ 6646.837400]  <TASK>
> [ 6646.837401]  __schedule+0x2aa/0x7c0
> [ 6646.837403]  ? posix_lock_inode+0x156/0x7f0
> [ 6646.837406]  schedule+0x4e/0xb0
> [ 6646.837408]  schedule_preempt_disabled+0xe/0x10
> [ 6646.837410]  __mutex_lock.isra.0+0x208/0x470
> [ 6646.837413]  __mutex_lock_slowpath+0x13/0x20
> [ 6646.837415]  mutex_lock+0x32/0x40
> [ 6646.837417]  amdgpu_ctx_mgr_entity_flush+0x40/0xf0 [amdgpu]
> [ 6646.837550]  amdgpu_flush+0x2b/0x50 [amdgpu]
> [ 6646.837673]  filp_close+0x37/0x70
> [ 6646.837676]  put_files_struct+0x6d/0xc0
> [ 6646.837679]  exit_files+0x49/0x50
> [ 6646.837681]  do_exit+0x345/0xad0
> [ 6646.837684]  do_group_exit+0x43/0xb0
> [ 6646.837686]  __x64_sys_exit_group+0x18/0x20
> [ 6646.837687]  do_syscall_64+0x5c/0xc0
> [ 6646.837690]  ? vfs_write+0x185/0x260
> [ 6646.837693]  ? exit_to_user_mode_prepare+0x3d/0x1c0
> [ 6646.837696]  ? filp_close+0x60/0x70
> [ 6646.837697]  ? syscall_exit_to_user_mode+0x27/0x50
> [ 6646.837700]  ? __x64_sys_close+0x12/0x40
> [ 6646.837702]  ? do_syscall_64+0x69/0xc0
> [ 6646.837703]  ? exc_page_fault+0x89/0x160
> [ 6646.837705]  ? asm_exc_page_fault+0x8/0x30
> [ 6646.837708]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 6646.837711] RIP: 0033:0x7f13be0472c6
> [ 6646.837713] RSP: 002b:00007fff80e7b878 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [ 6646.837715] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f13be0472c6
> [ 6646.837717] RDX: 0000000000000000 RSI: 000000000000003c RDI:
> 0000000000000000
> [ 6646.837718] RBP: 000055f28bde3d80 R08: 00000000000000e7 R09:
> ffffffffffffff80
> [ 6646.837719] R10: 00007f13b7defe10 R11: 0000000000000246 R12:
> 00007fff80e7ebc4
> [ 6646.837720] R13: 00007fff80e7ba00 R14: 0000000000000001 R15:
> 00007fff80e7be00
> [ 6646.837722]  </TASK>
> [ 6767.665728] INFO: task kworker/6:0:9999 blocked for more than 483
> seconds.
> [ 6767.665735]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6767.665737] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6767.665738] task:kworker/6:0     state:D stack:    0 pid: 9999
> ppid:     2 flags:0x00004000
> [ 6767.665743] Workqueue: events drm_sched_job_timedout [gpu_sched]
> [ 6767.665752] Call Trace:
> [ 6767.665753]  <TASK>
> [ 6767.665756]  __schedule+0x2aa/0x7c0
> [ 6767.665761]  schedule+0x4e/0xb0
> [ 6767.665763]  schedule_timeout+0x202/0x290
> [ 6767.665765]  ? ttwu_do_wakeup+0x53/0x170
> [ 6767.665769]  ? raw_spin_rq_lock_nested.constprop.0+0x10/0x20
> [ 6767.665772]  dma_fence_default_wait+0x174/0x200
> [ 6767.665775]  ? dma_fence_release+0x140/0x140
> [ 6767.665777]  dma_fence_wait_timeout+0xb7/0xd0
> [ 6767.665780]  drm_sched_stop+0xf7/0x170 [gpu_sched]
> [ 6767.665784]  amdgpu_device_gpu_recover.cold+0xa7a/0xab3 [amdgpu]
> [ 6767.665980]  ? amdgpu_job_timedout+0xf5/0x170 [amdgpu]
> [ 6767.666146]  amdgpu_job_timedout+0x14f/0x170 [amdgpu]
> [ 6767.666293]  drm_sched_job_timedout+0x76/0xf0 [gpu_sched]
> [ 6767.666297]  process_one_work+0x229/0x3d0
> [ 6767.666300]  worker_thread+0x4d/0x3f0
> [ 6767.666302]  ? process_one_work+0x3d0/0x3d0
> [ 6767.666304]  kthread+0x12a/0x150
> [ 6767.666306]  ? set_kthread_struct+0x40/0x40
> [ 6767.666307]  ret_from_fork+0x22/0x30
> [ 6767.666312]  </TASK>
> [ 6767.666325] INFO: task cinnamon:18527 blocked for more than 483 seconds.
> [ 6767.666328]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6767.666329] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6767.666330] task:cinnamon        state:D stack:    0 pid:18527 ppid: 
> 3109 flags:0x00000000
> [ 6767.666333] Call Trace:
> [ 6767.666334]  <TASK>
> [ 6767.666335]  __schedule+0x2aa/0x7c0
> [ 6767.666337]  ? posix_lock_inode+0x156/0x7f0
> [ 6767.666340]  schedule+0x4e/0xb0
> [ 6767.666342]  schedule_preempt_disabled+0xe/0x10
> [ 6767.666344]  __mutex_lock.isra.0+0x208/0x470
> [ 6767.666347]  __mutex_lock_slowpath+0x13/0x20
> [ 6767.666349]  mutex_lock+0x32/0x40
> [ 6767.666351]  amdgpu_ctx_mgr_entity_flush+0x40/0xf0 [amdgpu]
> [ 6767.666484]  amdgpu_flush+0x2b/0x50 [amdgpu]
> [ 6767.666606]  filp_close+0x37/0x70
> [ 6767.666609]  put_files_struct+0x6d/0xc0
> [ 6767.666612]  exit_files+0x49/0x50
> [ 6767.666615]  do_exit+0x345/0xad0
> [ 6767.666617]  do_group_exit+0x43/0xb0
> [ 6767.666619]  __x64_sys_exit_group+0x18/0x20
> [ 6767.666620]  do_syscall_64+0x5c/0xc0
> [ 6767.666623]  ? vfs_write+0x185/0x260
> [ 6767.666627]  ? exit_to_user_mode_prepare+0x3d/0x1c0
> [ 6767.666629]  ? filp_close+0x60/0x70
> [ 6767.666631]  ? syscall_exit_to_user_mode+0x27/0x50
> [ 6767.666634]  ? __x64_sys_close+0x12/0x40
> [ 6767.666635]  ? do_syscall_64+0x69/0xc0
> [ 6767.666637]  ? exc_page_fault+0x89/0x160
> [ 6767.666639]  ? asm_exc_page_fault+0x8/0x30
> [ 6767.666642]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 6767.666644] RIP: 0033:0x7f13be0472c6
> [ 6767.666646] RSP: 002b:00007fff80e7b878 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [ 6767.666649] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f13be0472c6
> [ 6767.666650] RDX: 0000000000000000 RSI: 000000000000003c RDI:
> 0000000000000000
> [ 6767.666651] RBP: 000055f28bde3d80 R08: 00000000000000e7 R09:
> ffffffffffffff80
> [ 6767.666652] R10: 00007f13b7defe10 R11: 0000000000000246 R12:
> 00007fff80e7ebc4
> [ 6767.666653] R13: 00007fff80e7ba00 R14: 0000000000000001 R15:
> 00007fff80e7be00
> [ 6767.666655]  </TASK>
> [ 6888.494793] INFO: task kworker/6:0:9999 blocked for more than 604
> seconds.
> [ 6888.494800]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6888.494802] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6888.494803] task:kworker/6:0     state:D stack:    0 pid: 9999
> ppid:     2 flags:0x00004000
> [ 6888.494808] Workqueue: events drm_sched_job_timedout [gpu_sched]
> [ 6888.494817] Call Trace:
> [ 6888.494819]  <TASK>
> [ 6888.494821]  __schedule+0x2aa/0x7c0
> [ 6888.494826]  schedule+0x4e/0xb0
> [ 6888.494828]  schedule_timeout+0x202/0x290
> [ 6888.494831]  ? ttwu_do_wakeup+0x53/0x170
> [ 6888.494834]  ? raw_spin_rq_lock_nested.constprop.0+0x10/0x20
> [ 6888.494838]  dma_fence_default_wait+0x174/0x200
> [ 6888.494842]  ? dma_fence_release+0x140/0x140
> [ 6888.494844]  dma_fence_wait_timeout+0xb7/0xd0
> [ 6888.494846]  drm_sched_stop+0xf7/0x170 [gpu_sched]
> [ 6888.494850]  amdgpu_device_gpu_recover.cold+0xa7a/0xab3 [amdgpu]
> [ 6888.495048]  ? amdgpu_job_timedout+0xf5/0x170 [amdgpu]
> [ 6888.495219]  amdgpu_job_timedout+0x14f/0x170 [amdgpu]
> [ 6888.495369]  drm_sched_job_timedout+0x76/0xf0 [gpu_sched]
> [ 6888.495374]  process_one_work+0x229/0x3d0
> [ 6888.495377]  worker_thread+0x4d/0x3f0
> [ 6888.495379]  ? process_one_work+0x3d0/0x3d0
> [ 6888.495381]  kthread+0x12a/0x150
> [ 6888.495383]  ? set_kthread_struct+0x40/0x40
> [ 6888.495385]  ret_from_fork+0x22/0x30
> [ 6888.495389]  </TASK>
> [ 6888.495404] INFO: task cinnamon:18527 blocked for more than 604 seconds.
> [ 6888.495406]       Not tainted 5.15.4-051504-generic #202111241530
> [ 6888.495407] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 6888.495408] task:cinnamon        state:D stack:    0 pid:18527 ppid: 
> 3109 flags:0x00000000
> [ 6888.495411] Call Trace:
> [ 6888.495412]  <TASK>
> [ 6888.495413]  __schedule+0x2aa/0x7c0
> [ 6888.495415]  ? posix_lock_inode+0x156/0x7f0
> [ 6888.495419]  schedule+0x4e/0xb0
> [ 6888.495421]  schedule_preempt_disabled+0xe/0x10
> [ 6888.495423]  __mutex_lock.isra.0+0x208/0x470
> [ 6888.495426]  __mutex_lock_slowpath+0x13/0x20
> [ 6888.495428]  mutex_lock+0x32/0x40
> [ 6888.495430]  amdgpu_ctx_mgr_entity_flush+0x40/0xf0 [amdgpu]
> [ 6888.495566]  amdgpu_flush+0x2b/0x50 [amdgpu]
> [ 6888.495691]  filp_close+0x37/0x70
> [ 6888.495694]  put_files_struct+0x6d/0xc0
> [ 6888.495697]  exit_files+0x49/0x50
> [ 6888.495699]  do_exit+0x345/0xad0
> [ 6888.495702]  do_group_exit+0x43/0xb0
> [ 6888.495704]  __x64_sys_exit_group+0x18/0x20
> [ 6888.495705]  do_syscall_64+0x5c/0xc0
> [ 6888.495709]  ? vfs_write+0x185/0x260
> [ 6888.495712]  ? exit_to_user_mode_prepare+0x3d/0x1c0
> [ 6888.495714]  ? filp_close+0x60/0x70
> [ 6888.495716]  ? syscall_exit_to_user_mode+0x27/0x50
> [ 6888.495719]  ? __x64_sys_close+0x12/0x40
> [ 6888.495721]  ? do_syscall_64+0x69/0xc0
> [ 6888.495722]  ? exc_page_fault+0x89/0x160
> [ 6888.495724]  ? asm_exc_page_fault+0x8/0x30
> [ 6888.495727]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 6888.495730] RIP: 0033:0x7f13be0472c6
> [ 6888.495732] RSP: 002b:00007fff80e7b878 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000e7
> [ 6888.495734] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> 00007f13be0472c6
> [ 6888.495736] RDX: 0000000000000000 RSI: 000000000000003c RDI:
> 0000000000000000
> [ 6888.495737] RBP: 000055f28bde3d80 R08: 00000000000000e7 R09:
> ffffffffffffff80
> [ 6888.495738] R10: 00007f13b7defe10 R11: 0000000000000246 R12:
> 00007fff80e7ebc4
> [ 6888.495739] R13: 00007fff80e7ba00 R14: 0000000000000001 R15:
> 00007fff80e7be00
> [ 6888.495741]  </TASK>
> 
> 
> 
