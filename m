Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F45F506D0
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 13:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B8710E536;
	Mon, 16 Mar 2026 13:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=treblig.org header.i=@treblig.org header.b="j+Lwch1s";
	dkim-atps=neutral
X-Greylist: delayed 1179 seconds by postgrey-1.36 at gabe;
 Mon, 16 Mar 2026 01:16:43 UTC
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBC410E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 01:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=nTivt/P9tkl6EDvJKK9XbT4aoWSX6KcMnpNyHYR49KM=; b=j+Lwch1sHI+j3zfZ
 WpZ1y+m9AJEmYUvbGOfTbfZJoyninnfIjkA+tMbjtsCVdQZ0lwON4omuJM9Lcs2g5uuFZcGuimOvH
 tcDzKfJt8nQObKZABs9QVUJb61VgOVZO5eYZGXmlCr1P8p4+Vi+X3Nhur0uDPb31w2K8KabHOD/Yw
 gAVjBkhtQogtVv1Rc/+XD5SPsaJHbWe18pGAy4pUvqEPwfWt6eNTM/ghFv5fVcJ3HjdaH3nkFpLSj
 6LIkVIKrUQUbeJ3jpSpK//dhbybkVyo3nKXgx0ec9B8nEzAIhbQoLFIaIzYDFGOo0etptWW0iJ3f+
 IU1etqQNGzu4k5yEoQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1w1wGV-00000000XKY-2wYN;
 Mon, 16 Mar 2026 00:57:03 +0000
Date: Mon, 16 Mar 2026 00:57:03 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: oops/null pointer in 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
Message-ID: <abdVX_LJiNvkm4tW@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 00:44:37 up 3 days, 1:58, 3 users, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Mailman-Approved-At: Mon, 16 Mar 2026 13:28:00 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,
  I'm not sure if this is repeatable, but I landed with a null
pointer during a GPU reset, so thought I should probably
report it:
   6.19.7-300.fc44.x86_64
Mar 16 00:24:39 dalek kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
Mar 16 00:24:39 dalek kernel: #PF: supervisor read access in kernel mode
....
Mar 16 00:24:39 dalek kernel: Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]

see full oops below;

09:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Lexa PRO [Radeon 540/540X/550/550X / RX 540X/550/550X] (rev c7)
AMD Ryzen 9 3950X

I suspect the timeout was real, and caused by a runaway llama, I forgot the
flag to stop it trying to use the GPU for image encoding; but the null page
seems unfortunate.  Impressively the audio still kept playing via it:

I have the devcoredump copied if it's of interest
(Note for self: ~/amd.core-2026-03-16)

Dave


Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State
Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State Completed
Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] AMDGPU device coredump file has been created
Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] Check your /sys/class/drm/card1/device/devcoredump/data
Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: ring gfx timeout, signaled seq=1705630, emitted seq=1705633
Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu:  Process llama-mtmd-cli pid 299886 thread llama-mtmd-cli pid 299886
Mar 16 00:24:28 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset begin!. Source:  1
Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: failed to suspend display audio
Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Guilty job already signaled, skipping HW reset
Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset(1) succeeded!
Mar 16 00:24:32 dalek kernel: amdgpu 0000:09:00.0: [drm] device wedged, but recovered through reset
Mar 16 00:24:34 dalek lightdm[40555]: ATTENTION: default value of option mesa_glthread overridden by environment.
Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State
Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: Dumping IP State Completed
Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] AMDGPU device coredump file has been created
Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: [drm] Check your /sys/class/drm/card1/device/devcoredump/data
Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: ring gfx timeout, signaled seq=1705632, emitted seq=1705637
Mar 16 00:24:34 dalek kernel: amdgpu 0000:09:00.0: amdgpu: GPU reset begin!. Source:  1
Mar 16 00:24:38 dalek kernel: amdgpu 0000:09:00.0: amdgpu: failed to suspend display audio
Mar 16 00:24:39 dalek kernel: BUG: kernel NULL pointer dereference, address: 0000000000000018
Mar 16 00:24:39 dalek kernel: #PF: supervisor read access in kernel mode
Mar 16 00:24:39 dalek kernel: #PF: error_code(0x0000) - not-present page
Mar 16 00:24:39 dalek kernel: PGD 849708067 P4D 849708067 PUD 15d277067 PMD 0 
Mar 16 00:24:39 dalek kernel: Oops: Oops: 0000 [#1] SMP NOPTI
Mar 16 00:24:39 dalek kernel: CPU: 7 UID: 0 PID: 298062 Comm: kworker/u128:2 Not tainted 6.19.7-300.fc44.x86_64 #1 PREEMPT(lazy) 
Mar 16 00:24:39 dalek kernel: Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./X570 Pro4, BIOS P3.10 07/13/2020
Mar 16 00:24:39 dalek kernel: Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
Mar 16 00:24:39 dalek kernel: Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 47 30 48 d1 e8 89 c2 83 e2 01 75 2c 48 8b>
Mar 16 00:24:39 dalek kernel: RSP: 0018:ffffcf349c553d20 EFLAGS: 00010246
Mar 16 00:24:39 dalek kernel: RAX: 0000000000000000 RBX: ffffcf349c553da0 RCX: 0000000000000000
Mar 16 00:24:39 dalek kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8bce4ecd4380
Mar 16 00:24:39 dalek kernel: RBP: 0000000000000000 R08: 0000000010000020 R09: ffff8bc9c0400b68
Mar 16 00:24:39 dalek kernel: R10: 0000000000000080 R11: ffffffffa16760a0 R12: ffff8bc9e9100000
Mar 16 00:24:39 dalek kernel: R13: ffff8bca7ccab200 R14: 0000000000000000 R15: 0000000000000000
Mar 16 00:24:39 dalek kernel: FS:  0000000000000000(0000) GS:ffff8bd90c066000(0000) knlGS:0000000000000000
Mar 16 00:24:39 dalek kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018 CR3: 00000001c591f000 CR4: 0000000000350ef0
Mar 16 00:24:39 dalek kernel: Call Trace:
Mar 16 00:24:39 dalek kernel:  <TASK>
Mar 16 00:24:39 dalek kernel:  amdgpu_device_gpu_recover.cold+0x244/0x2ec [amdgpu]
Mar 16 00:24:39 dalek kernel:  amdgpu_job_timedout.cold+0x218/0x258 [amdgpu]
Mar 16 00:24:39 dalek kernel:  ? srso_return_thunk+0x5/0x5f
Mar 16 00:24:39 dalek kernel:  drm_sched_job_timedout+0x8b/0x190 [gpu_sched]
Mar 16 00:24:39 dalek kernel:  ? srso_return_thunk+0x5/0x5f
Mar 16 00:24:39 dalek kernel:  process_one_work+0x190/0x350
Mar 16 00:24:39 dalek kernel:  worker_thread+0x18d/0x2f0
Mar 16 00:24:39 dalek kernel:  ? __pfx_worker_thread+0x10/0x10
Mar 16 00:24:39 dalek kernel:  kthread+0xfa/0x240
Mar 16 00:24:39 dalek kernel:  ? finish_task_switch.isra.0+0x82/0x2a0
Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
Mar 16 00:24:39 dalek kernel:  ret_from_fork+0x130/0x1a0
Mar 16 00:24:39 dalek kernel:  ? __pfx_kthread+0x10/0x10
Mar 16 00:24:39 dalek kernel:  ret_from_fork_asm+0x1a/0x30
Mar 16 00:24:39 dalek kernel:  </TASK>
Mar 16 00:24:39 dalek kernel: Modules linked in: dm_crypt snd_seq_dummy snd_hrtimer nft_masq nft_reject_ipv4 act_csum cls_u32 sch_htb nf_nat_tftp nf_conntr>
Mar 16 00:24:39 dalek kernel:  drm_panel_backlight_quirks gpu_sched drm_suballoc_helper video drm_buddy drm_display_helper nvme nvme_core cec ghash_clmulni>
Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018
Mar 16 00:24:39 dalek kernel: ---[ end trace 0000000000000000 ]---
Mar 16 00:24:39 dalek kernel: RIP: 0010:dma_fence_is_signaled+0x12/0x60 [amdgpu]
Mar 16 00:24:39 dalek kernel: Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 48 8b 47 30 48 d1 e8 89 c2 83 e2 01 75 2c 48 8b>
Mar 16 00:24:39 dalek kernel: RSP: 0018:ffffcf349c553d20 EFLAGS: 00010246
Mar 16 00:24:39 dalek kernel: RAX: 0000000000000000 RBX: ffffcf349c553da0 RCX: 0000000000000000
Mar 16 00:24:39 dalek kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8bce4ecd4380
Mar 16 00:24:39 dalek kernel: RBP: 0000000000000000 R08: 0000000010000020 R09: ffff8bc9c0400b68
Mar 16 00:24:39 dalek kernel: R10: 0000000000000080 R11: ffffffffa16760a0 R12: ffff8bc9e9100000
Mar 16 00:24:39 dalek kernel: R13: ffff8bca7ccab200 R14: 0000000000000000 R15: 0000000000000000
Mar 16 00:24:39 dalek kernel: FS:  0000000000000000(0000) GS:ffff8bd90c066000(0000) knlGS:0000000000000000
Mar 16 00:24:39 dalek kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 16 00:24:39 dalek kernel: CR2: 0000000000000018 CR3: 00000001c591f000 CR4: 0000000000350ef0
Mar 16 00:24:39 dalek kernel: note: kworker/u128:2[298062] exited with irqs disabled

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
