Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16722E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 16:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B1910E74B;
	Thu,  2 Jan 2025 16:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tzxkfgwm";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F9710E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 05:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1735796544; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=8psySN2vNIzQunM6/UWGf18zDww9EZimLl+ZReAlQBs=;
 b=tzxkfgwmIqsy/q23IK0AaGybe1adtHVKu2HBtrZAxZi6UVUfvMD6SFm7z0hJpjSlHbZt9RaJvgOCTz+e0MKSK3q7rKlMV9aFJaKUpyObpuUsV5JggkFIr/JH4JXXBNZ3eOobEI0MKbTI09SCAQWvaQdubGU64kYNu2RGZd12lOI=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMk35w-_1735796240 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 02 Jan 2025 13:37:21 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
Date: Thu,  2 Jan 2025 13:36:55 +0800
Message-ID: <176921ed3539fb55e4a222212b638caf84ebf4aa.1735795671.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1735795671.git.gerry@linux.alibaba.com>
References: <cover.1735795671.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jan 2025 16:24:05 +0000
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

If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
after free bug related to amdgpu_driver_release_kms() as:
2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel mode
2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present page
2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
e024se+0x3c/0x90 [amdxcp]
2024-12-26 16:17:46 [16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
2024-12-26 16:17:46 [16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26

Fix it by unplugging xcp drm devices when failed to probe GPU devices.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 5ffe1dad9622..e7f35e3a6d2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -164,8 +164,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		DRM_WARN("smart shift update failed\n");
 
 out:
-	if (r)
+	if (r) {
+		amdgpu_xcp_dev_unplug(adev);
 		amdgpu_driver_unload_kms(dev);
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index a6d456ec6aeb..ef4eaacf67f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -382,6 +382,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
 		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
 		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+		adev->xcp_mgr->xcp[i].ddev = NULL;
 	}
 }
 
-- 
2.43.5

