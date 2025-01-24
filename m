Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C11C02181
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2025 05:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2EE10E8CF;
	Fri, 24 Jan 2025 05:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pi3cZFDh";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E2410E253
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2025 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1737695963; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=sf+YBPR39kGqAQVwAU0Z/Wo0ZMMfWkoBAKoAIgy5piQ=;
 b=pi3cZFDhunxLLDT7Qm3e85oGs8knCD0B9gf/sIm+Pbea3Tb0GJLFkVp2KubKl4wwhwatpHppW9Glua/yF9+HeyV/sssfEkjh4Xoub99A42menmFqPZx1L4VeMlts7XRUY4b3UImVu5iQpqJIL7N53SNwjgGXiBsMwXGMp92fj+c=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WODTwjF_1737695961 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 24 Jan 2025 13:19:22 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v6 3/5] drm/amdgpu: fix invalid memory access in
 amdgpu_xcp_cfg_sysfs_fini()
Date: Fri, 24 Jan 2025 13:19:16 +0800
Message-ID: <7e79844abed04b9f6f70565aafff736fe19d19ce.1737695869.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1737695869.git.gerry@linux.alibaba.com>
References: <cover.1737695869.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When AMD gpu firmware files are missing, loading the amdgpu driver will
cause following invalid memory access:

[   89.735573] amdgpu 0000:0a:00.0: amdgpu: Fetched VBIOS from platform
[   89.735583] amdgpu: ATOM BIOS: 113-M3080202-101
[   89.735676] amdgpu 0000:0a:00.0: Direct firmware load for amdgpu/psp_13_0_14_sos.bin failed with error -2
[   89.735684] [drm:amdgpu_device_init [amdgpu]] *ERROR* early_init of IP block <psp> failed -19
[   89.746649] amdgpu 0000:0a:00.0: Direct firmware load for amdgpu/smu_13_0_14.bin failed with error -2
[   89.746657] [drm:amdgpu_device_init [amdgpu]] *ERROR* early_init of IP block <smu> failed -19
[   89.757203] amdgpu 0000:0a:00.0: Direct firmware load for amdgpu/gc_9_4_4_rlc.bin failed with error -2
[   89.757209] [drm:amdgpu_device_init [amdgpu]] *ERROR* early_init of IP block <gfx_v9_4_3> failed -19
[   89.768331] amdgpu 0000:0a:00.0: Direct firmware load for amdgpu/sdma_4_4_5.bin failed with error -2
[   89.768341] [drm:amdgpu_device_init [amdgpu]] *ERROR* early_init of IP block <sdma_v4_4_2> failed -19
[   89.779385] amdgpu 0000:0a:00.0: Direct firmware load for amdgpu/vcn_4_0_3.bin failed with error -2
[   89.779389] [drm:amdgpu_device_init [amdgpu]] *ERROR* early_init of IP block <vcn_v4_0_3> failed -19
[   89.790320] amdgpu 0000:0a:00.0: amdgpu: Fatal error during GPU init
[   89.797498] amdgpu 0000:0a:00.0: amdgpu: amdgpu: finishing device.
[   89.797519] BUG: kernel NULL pointer dereference, address: 0000000000000010
[   89.805377] #PF: supervisor read access in kernel mode
[   89.811639] #PF: error_code(0x0000) - not-present page
[   89.817825] PGD 0
[   89.820455] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[   89.826296] CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.12.0+ #3
[   89.834265] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.091.02 08/04/2024
[   89.845430] Workqueue: events work_for_cpu_fn
[   89.850649] RIP: 0010:amdgpu_device_fini_hw+0x1f2/0x570 [amdgpu]
[   89.858316] Code: 65 49 63 f5 48 83 fe 11 0f 83 0c 03 00 00 4c 89 ff 49 83 ec 20 4d 8d 7f e0 48 85 ff 74 48 41 83 ed 01 49 8b 84 24 18 6f 04 00 <48> 8b 40 10 48 8b 40 28 48 85 c0 74 c4 ff d0 0f 1f 00 41 89 c1 85
[   89.879966] RSP: 0018:ff23a0f9401dbd18 EFLAGS: 00010206
[   89.886123] RAX: 0000000000000000 RBX: ff13ecb721800000 RCX: 0000000000000000
[   89.894411] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ff13ecb721847028
[   89.902705] RBP: ff23a0f9401dbd68 R08: 0000000000000000 R09: 0000000000000000
[   89.910983] R10: 0000000000000000 R11: 0000000000000000 R12: ff13ecb721800120
[   89.919249] R13: 0000000000000008 R14: ff13ecb721800010 R15: ff13ecb721847008
[   89.927505] FS:  0000000000000000(0000) GS:ff13edb1fd000000(0000) knlGS:0000000000000000
[   89.936828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   89.943513] CR2: 0000000000000010 CR3: 000001a8de63e001 CR4: 0000000000f73ef0
[   89.951761] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   89.960010] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   89.968252] PKRU: 55555554
[   89.971516] Call Trace:
[   89.974487]  <TASK>
[   89.977067]  ? show_regs+0x6c/0x80
[   89.981115]  ? __die+0x24/0x80
[   89.984761]  ? page_fault_oops+0x175/0x5c0
[   89.989580]  ? vprintk_emit+0x127/0x400
[   89.994106]  ? do_user_addr_fault+0x4b2/0x870
[   89.999222]  ? exc_page_fault+0x82/0x1b0
[   90.003858]  ? asm_exc_page_fault+0x27/0x30
[   90.008804]  ? amdgpu_device_fini_hw+0x1f2/0x570 [amdgpu]
[   90.015539]  ? amdgpu_device_fini_hw+0x16d/0x570 [amdgpu]
[   90.022274]  ? blocking_notifier_chain_unregister+0x38/0x70
[   90.028773]  amdgpu_driver_unload_kms+0x4b/0x70 [amdgpu]
[   90.035419]  amdgpu_driver_load_kms+0x91/0xd0 [amdgpu]
[   90.041865]  amdgpu_pci_probe+0x1d1/0x650 [amdgpu]
[   90.047920]  local_pci_probe+0x44/0xb0
[   90.052388]  work_for_cpu_fn+0x17/0x30
[   90.056847]  process_one_work+0x178/0x3d0
[   90.061607]  worker_thread+0x2de/0x410
[   90.066066]  ? __pfx_worker_thread+0x10/0x10
[   90.071114]  kthread+0xe1/0x110
[   90.074891]  ? __pfx_kthread+0x10/0x10
[   90.079353]  ret_from_fork+0x44/0x70
[   90.083627]  ? __pfx_kthread+0x10/0x10
[   90.088085]  ret_from_fork_asm+0x1a/0x30
[   90.092742]  </TASK>
[   90.252277] ---[ end trace 0000000000000000 ]---

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 272954f6e476..d430fab12355 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -752,7 +752,7 @@ void amdgpu_xcp_cfg_sysfs_fini(struct amdgpu_device *adev)
 	struct amdgpu_xcp_cfg *xcp_cfg;
 	int i;
 
-	if (!adev->xcp_mgr)
+	if (!adev->xcp_mgr || !adev->xcp_mgr->xcp_cfg)
 		return;
 
 	xcp_cfg =  adev->xcp_mgr->xcp_cfg;
-- 
2.43.5

