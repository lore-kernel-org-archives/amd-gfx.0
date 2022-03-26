Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7812FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 07:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB1710E4F0;
	Mon, 28 Mar 2022 07:25:47 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E023510E40A
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Mar 2022 17:37:56 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id q14so14014610ljc.12
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Mar 2022 10:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:from:subject:to:cc
 :references:content-language:in-reply-to:content-transfer-encoding;
 bh=C98l3JHGxltTHXZO0ik6pVDbFxd4eMZJb2rRDUHupI8=;
 b=NyWV08MmQIAB+7cYTFrs3ViqpoxEPf+M/v+8IciOhxzkzR3uN2kBLczZgawQAv34Ly
 0+/1WPz827RxhR+TDh4KW7rnBGPnRxweGwr/GzeY8JJ2HOljfL7+srNDey968549iRZh
 hNOpbueArXN/Reue+a3plB7c0hTCW/BBjvQ8p7TR23+vBMZdkmq56aEQG7CX4qZCX5Yp
 wclQllNNzasrAABjFIwPNO2JKIyg/0Ai9cjFTWp3oNBVfHjldosSfy4Te8N7rfRLgPpO
 5zzNESjf9m6OYayWmgJhCRoN036RleLkbUxQjoyi48++PFSuW6LC43KiugIsBNsgA1nb
 qzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:from
 :subject:to:cc:references:content-language:in-reply-to
 :content-transfer-encoding;
 bh=C98l3JHGxltTHXZO0ik6pVDbFxd4eMZJb2rRDUHupI8=;
 b=q0/npbLi+quPm4kV0+cX9mJy3l4lcvUkuLQ71AjM4vIu/4/hUu5MQv1pnwuXhTKwn3
 hnCPnOdqVFbDgSKxkcUgKv0mxSwNZ1fXX3Hxhl/CMRuROMj0jFWkJAN9VuKcOBw9T7GD
 AR8eKva47ppzCDa9Uc+LGfw6uOQnlX2K1fgNPKXA1RNYNNNu1a7EDn4DoO5E33aKVUbh
 FL9tiWRIgynNIju3OVLAHU+O4emawY2yefzdCqeBCXTbnTxjk+jBeLeKjA5lTaaj/SL4
 1li9pBMqqVzErMvKaPBC7x3n7dDIPzlU6p5sT8IbhBz3UzrOtkhYfREpSMrSS9cf1E+C
 zc+w==
X-Gm-Message-State: AOAM531u6Cia67dE5YYZE7GWPVCgND+wz4NnTVFPSs25NhInMmZgJ3nd
 DP4LV2ZE2C/D9pysLdKb1qOTkHpv5rfaBg==
X-Google-Smtp-Source: ABdhPJzjEsBpwr+vHokgGR0qQsA7Pg+2lZf+47wACf9b+YsGfU1h510Oq6bW2TCjZWuyiftesK7ZAg==
X-Received: by 2002:a2e:a881:0:b0:249:6f85:d4a4 with SMTP id
 m1-20020a2ea881000000b002496f85d4a4mr12874334ljq.231.1648316274980; 
 Sat, 26 Mar 2022 10:37:54 -0700 (PDT)
Received: from [172.16.41.128] (078088109026.wroclaw.vectranet.pl.
 [78.88.109.26]) by smtp.gmail.com with ESMTPSA id
 c4-20020a19e344000000b0044846bce74esm1113479lfk.283.2022.03.26.10.37.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Mar 2022 10:37:54 -0700 (PDT)
Message-ID: <0b126447-e270-557c-1f88-13fa46e367f0@gmail.com>
Date: Sat, 26 Mar 2022 18:37:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: =?UTF-8?Q?Tomasz_Mo=c5=84?= <desowin@gmail.com>
Subject: Re: Waiting for fences timed out on MacBook Pro 2019
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CAOHtt3_wfx1kpcjA3s63x+TaHS8DmCSk629OAN+Bi5nZzwrb5Q@mail.gmail.com>
 <CAOHtt39VcCNYwHcEj3NB3904tw4cKBDc-wH_CWvGr3NWM_vH=A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOHtt39VcCNYwHcEj3NB3904tw4cKBDc-wH_CWvGr3NWM_vH=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Mar 2022 07:25:47 +0000
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Tomasz_Mo=c5=84?= <desowin@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2/6/22 09:17, Tomasz Moń wrote:
> On Mon, Jul 12, 2021 at 11:56 AM Tomasz Moń <desowin@gmail.com> wrote:
>> I am having trouble getting Linux to run on MacBook Pro 2019 with
>> Radeon Pro Vega 20 4 GB. Basically as soon as graphical user interface
>> starts, the whole system freezes. This happens with every Linux kernel
>> version I have tried over the last few months, including 5.13.
> 
> It is significantly better on 5.17-rc2. That is, the whole system is
> not frozen. just the screen keeps blinking and visual artifacts show.
> Graphical desktop is not usable, but switching between virtual
> terminals works just fine.

I have tried on amd-drm-next-5.18-2022-03-25 with following options:
   amdgpu.vm_debug=1 amdgpu.debug_evictions=1 amdgpu.dcdebugmask=0xffffffff amdgpu.dc=1 amdgpu.dcdebugmask=0xffffffff

Unfortunately I am not familiar with the domain so my understanding is
very limited. However the UNLOAD_TA command returning 0x117 stands out.

What does the status 0x117 from UNLOAD_TA mean? Is the documentation for
commands publicly available?

[   24.931035] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
[   24.931035] [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
[   29.847661] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=1712, emitted seq=1713
[   29.847970] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process Xorg pid 572 thread Xorg:cs0 pid 573
[   29.848244] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
[   32.746329] audit: type=1131 audit(1648314775.912:67): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   32.847653] audit: type=1334 audit(1648314776.015:68): prog-id=0 op=UNLOAD
[   32.847658] audit: type=1334 audit(1648314776.015:69): prog-id=0 op=UNLOAD
[   32.847660] audit: type=1334 audit(1648314776.015:70): prog-id=0 op=UNLOAD
[   33.848255] amdgpu 0000:03:00.0: amdgpu: failed to suspend display audio
[   33.848260] ------------[ cut here ]------------
[   33.848261] Evicting all processes
[   33.848276] WARNING: CPU: 10 PID: 469 at drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1888 kfd_suspend_all_processes+0xfa/0x110 [amdgpu]
[   33.848554] Modules linked in: amdgpu drm_ttm_helper gpu_sched
[   33.848558] CPU: 10 PID: 469 Comm: kworker/u32:4 Not tainted 5.17.0-rc6-amd #1 771afb710c57d59790c0f2362731ed3ffe6af1f8
[   33.848561] Hardware name: Apple Inc. MacBookPro15,3/Mac-1E7E29AD0135F9BC, BIOS 1731.100.130.0.0 (iBridge: 19.16.14242.0.0,0) 02/15/2022
[   33.848563] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
[   33.848568] RIP: 0010:kfd_suspend_all_processes+0xfa/0x110 [amdgpu]
[   33.848817] Code: c7 c7 40 9b 85 c0 41 5c 41 5d e9 c1 e8 98 f1 be 03 00 00 00 e8 27 16 e3 f1 e9 5b ff ff ff 48 c7 c7 4a cc 6f c0 e8 6d 2c 8c f2 <0f> 0b e9 26 ff ff ff 0f 0b eb c5 66 66 2e 0f 1f 84 00 00 00 00 00
[   33.848819] RSP: 0018:ffffade780a83d08 EFLAGS: 00010246
[   33.848821] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[   33.848823] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   33.848824] RBP: ffff8d1fc4d68000 R08: 0000000000000000 R09: 0000000000000000
[   33.848825] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d1fd79e0000
[   33.848826] R13: 0000000000000000 R14: ffff8d1fc2a270d0 R15: ffff8d1fd79e0000
[   33.848828] FS:  0000000000000000(0000) GS:ffff8d271ec80000(0000) knlGS:0000000000000000
[   33.848830] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.848831] CR2: 00007fc180bfb200 CR3: 00000004a8c10003 CR4: 00000000003706e0
[   33.848833] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   33.848834] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   33.848835] Call Trace:
[   33.848837]  <TASK>
[   33.848839]  kgd2kfd_suspend.part.0+0x3d/0x40 [amdgpu 9abbe9b6fc2429e6d465345bc384def6ac94e6a9]
[   33.849084]  kgd2kfd_pre_reset+0x43/0x60 [amdgpu 9abbe9b6fc2429e6d465345bc384def6ac94e6a9]
[   33.849326]  amdgpu_device_gpu_recover_imp.cold+0x120/0x8e9 [amdgpu 9abbe9b6fc2429e6d465345bc384def6ac94e6a9]
[   33.849628]  amdgpu_job_timedout+0x18f/0x1c0 [amdgpu 9abbe9b6fc2429e6d465345bc384def6ac94e6a9]
[   33.849887]  ? finish_task_switch.isra.0+0xaa/0x290
[   33.849892]  drm_sched_job_timedout+0x77/0x120 [gpu_sched 721b514943d9cddbec8b63d5dd19fd642806bd31]
[   33.849898]  process_one_work+0x1e2/0x3b0
[   33.849901]  ? rescuer_thread+0x3a0/0x3a0
[   33.849903]  worker_thread+0x50/0x3a0
[   33.849905]  ? rescuer_thread+0x3a0/0x3a0
[   33.849906]  kthread+0xd6/0x100
[   33.849910]  ? kthread_complete_and_exit+0x20/0x20
[   33.849913]  ret_from_fork+0x1f/0x30
[   33.849918]  </TASK>
[   33.849919] ---[ end trace 0000000000000000 ]---
[   34.072819] [drm] psp gfx command UNLOAD_TA(0x2) failed and response status is (0x117)
[   34.072824] [drm] free PSP TMR buffer
[   34.108151] CPU: 12 PID: 469 Comm: kworker/u32:4 Tainted: G        W         5.17.0-rc6-amd #1 771afb710c57d59790c0f2362731ed3ffe6af1f8
[   34.108156] Hardware name: Apple Inc. MacBookPro15,3/Mac-1E7E29AD0135F9BC, BIOS 1731.100.130.0.0 (iBridge: 19.16.14242.0.0,0) 02/15/2022
[   34.108158] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
[   34.108165] Call Trace:
[   34.108167]  <TASK>
[   34.108168]  dump_stack_lvl+0x48/0x66
[   34.108174]  amdgpu_do_asic_reset+0x28/0x45c [amdgpu 9abbe9b6fc2429e6d465345bc384def6ac94e6a9]
[   34.108523]  amdgpu_device_gpu_recover_imp.cold+0x60e/0x8e9 [amdgpu 9abbe9b6fc2429e6d465345bc384def6ac94e6a9]
[   34.108835]  amdgpu_job_timedout+0x18f/0x1c0 [amdgpu 9abbe9b6fc2429e6d465345bc384def6ac94e6a9]
[   34.109109]  ? finish_task_switch.isra.0+0xaa/0x290
[   34.109114]  drm_sched_job_timedout+0x77/0x120 [gpu_sched 721b514943d9cddbec8b63d5dd19fd642806bd31]
[   34.109120]  process_one_work+0x1e2/0x3b0
[   34.109123]  ? rescuer_thread+0x3a0/0x3a0
[   34.109125]  worker_thread+0x50/0x3a0
[   34.109127]  ? rescuer_thread+0x3a0/0x3a0
[   34.109129]  kthread+0xd6/0x100
[   34.109132]  ? kthread_complete_and_exit+0x20/0x20
[   34.109135]  ret_from_fork+0x1f/0x30
[   34.109141]  </TASK>
[   34.109144] amdgpu 0000:03:00.0: amdgpu: MODE1 reset
[   34.109146] amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset
[   34.109196] amdgpu 0000:03:00.0: amdgpu: GPU psp mode1 reset
[   34.637593] [drm] psp mode1 reset succeed
[   34.708779] amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying to resume
[   34.708884] [drm] PCIE GART of 512M enabled.
[   34.708886] [drm] PTB located at 0x000000F400000000
[   34.708906] [drm] VRAM is lost due to GPU reset!
[   34.708907] [drm] PSP is resuming...
[   34.896778] [drm] reserve 0x400000 from 0xf4fec00000 for PSP TMR
[   36.604868] [drm] kiq ring mec 2 pipe 1 q 0
[   36.626895] [drm] UVD and UVD ENC initialized successfully.
[   36.727142] [drm] VCE initialized successfully.
[   36.727148] amdgpu 0000:03:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[   36.727151] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[   36.727153] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[   36.727154] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[   36.727155] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[   36.727157] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[   36.727158] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[   36.727159] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[   36.727160] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[   36.727162] amdgpu 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[   36.727163] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[   36.727164] amdgpu 0000:03:00.0: amdgpu: ring sdma1 uses VM inv eng 1 on hub 1
[   36.727166] amdgpu 0000:03:00.0: amdgpu: ring uvd_0 uses VM inv eng 4 on hub 1
[   36.727167] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.0 uses VM inv eng 5 on hub 1
[   36.727168] amdgpu 0000:03:00.0: amdgpu: ring uvd_enc_0.1 uses VM inv eng 6 on hub 1
[   36.727169] amdgpu 0000:03:00.0: amdgpu: ring vce0 uses VM inv eng 7 on hub 1
[   36.727170] amdgpu 0000:03:00.0: amdgpu: ring vce1 uses VM inv eng 8 on hub 1
[   36.727171] amdgpu 0000:03:00.0: amdgpu: ring vce2 uses VM inv eng 9 on hub 1
[   36.729758] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow start
[   36.729762] amdgpu 0000:03:00.0: amdgpu: recover vram bo from shadow done
[   36.729765] [drm] Skip scheduling IBs!
[   36.729785] amdgpu 0000:03:00.0: amdgpu: GPU reset(2) succeeded!
[   36.729811] [drm] Skip scheduling IBs!
...
[   36.731540] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!
