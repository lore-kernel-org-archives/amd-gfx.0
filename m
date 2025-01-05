Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47067E77197
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Jan 2025 16:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD51410E119;
	Sun,  5 Jan 2025 16:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x7Om6yWC";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBBD10E4E3
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jan 2025 05:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736054187; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
 bh=rf5Vu7W1w7cURQyfpZExiNnRmaGYiLRV5ojB+AGsTU8=;
 b=x7Om6yWCzM860iQnyutLvmqonNsa7Dj4vI0577jt0S8kKKoWhnsJezgJY1OzjPGWjVAGa6FFlHvwjX3pDb9ngOnRItZbeEwTB1NzVw1mtrQ1xwBVyXU7Kc/PYbfwuhYS/vIQ7+GAZXbJS4DjKNEeGZ1IfFwekHMKtlPxyjpFu28=
Received: from localhost(mailfrom:shuox.liu@linux.alibaba.com
 fp:SMTPD_---0WMxmA35_1736054186 cluster:ay36) by smtp.aliyun-inc.com;
 Sun, 05 Jan 2025 13:16:27 +0800
Date: Sun, 5 Jan 2025 13:16:26 +0800
From: Shuo Liu <shuox.liu@linux.alibaba.com>
To: Jiang Liu <gerry@linux.alibaba.com>
Cc: amd-gfx@lists.freedesktop.org, xiaogang.chen@amd.com,
 lijo.lazar@amd.com, Kent.Russell@amd.com
Subject: Re: [PATCH v2 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
Message-ID: <Z3oVqiw61/JcX2HZ@shuo-ali-mbp.local>
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@linux.alibaba.com>
X-Mailman-Approved-At: Sun, 05 Jan 2025 16:40:26 +0000
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

On Sun  5.Jan'25 at 10:45:32 +0800, Jiang Liu wrote:
>If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
>after free bug related to amdgpu_driver_release_kms() as:
>2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
>2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
>2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
>2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
>2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
>2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
>2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
>43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
>2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
>2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
>2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
>2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
>2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
>2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
>2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
>2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
>e024se+0x3c/0x90 [amdxcp]
This calltrace seems corrupted.
You can use this one from my test.

BUG: unable to handle page fault for address: 000000010000008f
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 139 PID: 10172 Comm: rmmod Kdump: loaded Tainted: G            E      6.10.0 #5
RIP: 0010:amdgpu_fence_driver_sw_fini+0x3b/0xd0 [amdgpu]
Code: 00 41 55 49 89 fd 41 54 49 81 c5 78 07 01 00 41 bc ff ff ff ff 55 53 eb 09 49 83 c6 08 4d 39 ee 74 7d 49 8b 2e 48 85 ed 74 ef <80> 7d 28 00 74 e9 48 83 7d 78 00 74 09 48 8d 7d 78 e8 ff 65 e1 ff
RSP: 0018:ffffb8e77badfde0 EFLAGS: 00010202
RAX: ffffffffc09e13b0 RBX: ffffa1461a4287f0 RCX: 00000000000000c0
RDX: 00000000000000c0 RSI: 00000000000000c0 RDI: ffffa1461a4287f0
RBP: 0000000100000067 R08: 00000000000000c0 R09: ffffa146112a6c48
R10: 0000000000040000 R11: 0000000000000007 R12: 00000000ffffffff
R13: ffffa1461a438f68 R14: ffffa1461a438b88 R15: 0000000000000000
FS:  00007f98ed908740(0000) GS:ffffa141ffd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000008f CR3: 0000000127d40003 CR4: 0000000000f70ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
  <TASK>
  ? __die+0x24/0x70
  ? page_fault_oops+0x65/0x140
  ? exc_page_fault+0x68/0x140
  ? asm_exc_page_fault+0x26/0x30
  ? __pfx_amdgpu_driver_release_kms+0x10/0x10 [amdgpu]
  ? amdgpu_fence_driver_sw_fini+0x3b/0xd0 [amdgpu]
  amdgpu_device_fini_sw+0x16/0x220 [amdgpu]
  amdgpu_driver_release_kms+0x16/0x30 [amdgpu]
  devm_drm_dev_init_release+0x4e/0x70 [drm]
  release_nodes+0x35/0xb0
  devres_release_group+0xa0/0xf0
  amdgpu_xcp_drv_release+0x3c/0x90 [amdxcp]

shuo
>2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
>2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
>2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26

>
>Fix it by unplugging xcp drm devices when failed to probe GPU devices.
>
>Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
>Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>index d2a046736edd..9ebc0d47d1cb 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>@@ -165,8 +165,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
> 		DRM_WARN("smart shift update failed\n");
>
> out:
>-	if (r)
>+	if (r) {
>+		amdgpu_xcp_dev_unplug(adev);
> 		amdgpu_driver_unload_kms(dev);
>+	}
>
> 	return r;
> }
>-- 
>2.43.5
