Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC90C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 07:56:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77CD910EA7E;
	Fri, 17 Jan 2025 07:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="APgf9dkb";
	dkim-atps=neutral
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A4610EA7F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1737100559; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=X5dWAnZm/CcxWkSzB4GQi5321l84veo8UnYwWyjd/N0=;
 b=APgf9dkb9bnDscC7LiEegr64uHXWZIjEyTF3/htIzkYBwh7gcOxge4rMdQ4664JBcMQLAQiJysxkqPijT5e32n1uOEO8OHS8FRSCgRN8KGhoXZbswVGSQk+TuEl51ld7bvUN2F2wDvOzRa9p9YC+C24lTuLyDU6viUXYateBfMI=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNo5WhX_1737100558 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 17 Jan 2025 15:55:58 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v5 2/5] drm/amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
Date: Fri, 17 Jan 2025 15:55:50 +0800
Message-ID: <d1cb4733b02e805ec21e35fa56cb160010dfcffd.1737100293.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1737100293.git.gerry@linux.alibaba.com>
References: <cover.1737100293.git.gerry@linux.alibaba.com>
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

If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
after free bug related to amdgpu_driver_release_kms() as:
[16002.085540] BUG: kernel NULL pointer dereference, address: 0000000000000000
[16002.093792] #PF: supervisor read access in kernel mode
[16002.099993] #PF: error_code(0x0000) - not-present page
[16002.106188] PGD 0 P4D 0
[16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: loaded Tainted: G        W   E      6.10.0+ #2
[16002.125577] Hardware name: Alibaba Alibaba Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
[16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 [gpu_sched]
[16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 e4 48 8b
8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 8d 55 10 48 39
[16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: 00010246
[16002.171316] RAX: 0000000000000000 RBX: ffff96b0fdadc878 RCX: 0000000000000000
[16002.179784] RDX: 000fffffffe00000 RSI: 0000000000000000 RDI: ffff96b0fdadc8f8
[16002.188252] RBP: ffff96b0fdadc800 R08: ffff97abbd035040 R09: ffffffff9ac52540
[16002.196722] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[16002.205179] R13: 0000000000000000 R14: ffff96b0fdadfc00 R15: 0000000000000000
[16002.213648] FS:  00007f2737000740(0000) GS:ffff97abbd100000(0000) knlGS:0000000000000000
[16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16002.230103] CR2: 0000000000000000 CR3: 000000011be3a005 CR4: 0000000000f70ef0
[16002.238581] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16002.247053] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
dxcp]
[16002.337645]  __do_sys_delete_module.constprop.0+0x176/0x310
[16002.344324]  do_syscall_64+0x5d/0x170
[16002.348858]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[16002.354956] RIP: 0033:0x7f2736a620cb-12-26

Fix it by removing xcp drm devices when failed to probe GPU devices.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c    | 69 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  3 +-
 4 files changed, 62 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a121aab5c74..ee695e70fb4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4777,6 +4777,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	amdgpu_reset_put_reset_domain(adev->reset_domain);
 	adev->reset_domain = NULL;
 
+	amdgpu_xcp_mgr_fini(adev);
+
 	kfree(adev->pci_state);
 
 }
@@ -6677,7 +6679,7 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
 	struct pci_dev *pdev = adev->pdev;
 	struct drm_device *ddev = adev_to_drm(adev);
 
-	amdgpu_xcp_dev_unplug(adev);
+	amdgpu_xcp_dev_deregister(adev);
 	drm_dev_unplug(ddev);
 
 	amdgpu_irq_disable_all(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index acb9dc3705ac..3f26e850120c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2435,7 +2435,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
-	amdgpu_xcp_dev_unplug(adev);
+	amdgpu_xcp_dev_deregister(adev);
 	amdgpu_gmc_prepare_nps_mode_change(adev);
 	drm_dev_unplug(dev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index e209b5e101df..272954f6e476 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -268,21 +268,33 @@ static int amdgpu_xcp_dev_alloc(struct amdgpu_device *adev)
 			return ret;
 		}
 
-		/* Redirect all IOCTLs to the primary device */
-		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
-		adev->xcp_mgr->xcp[i].pdev = p_ddev->primary->dev;
-		adev->xcp_mgr->xcp[i].driver = (struct drm_driver *)p_ddev->driver;
-		adev->xcp_mgr->xcp[i].vma_offset_manager = p_ddev->vma_offset_manager;
-		p_ddev->render->dev = ddev;
-		p_ddev->primary->dev = ddev;
-		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
-		p_ddev->driver = &amdgpu_partition_driver;
 		adev->xcp_mgr->xcp[i].ddev = p_ddev;
 	}
 
 	return 0;
 }
 
+static void amdgpu_xcp_dev_free(struct amdgpu_device *adev)
+{
+	struct drm_device *p_ddev;
+	int i;
+
+	if (!adev->xcp_mgr)
+		return;
+
+	for (i = 1; i < MAX_XCP; i++) {
+		if (!adev->xcp_mgr->xcp[i].ddev)
+			break;
+
+		p_ddev = adev->xcp_mgr->xcp[i].ddev;
+		adev->xcp_mgr->xcp[i].ddev = NULL;
+
+		amdgpu_xcp_drm_dev_free(p_ddev);
+	}
+
+	adev->xcp_mgr->xcp->ddev = NULL;
+}
+
 int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 			int init_num_xcps,
 			struct amdgpu_xcp_mgr_funcs *xcp_funcs)
@@ -310,6 +322,13 @@ int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 	return amdgpu_xcp_dev_alloc(adev);
 }
 
+void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev)
+{
+	amdgpu_xcp_dev_free(adev);
+	kfree(adev->xcp_mgr);
+	adev->xcp_mgr = NULL;
+}
+
 int amdgpu_xcp_get_partition(struct amdgpu_xcp_mgr *xcp_mgr,
 			     enum AMDGPU_XCP_IP_BLOCK ip, int instance)
 {
@@ -348,23 +367,44 @@ int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 			const struct pci_device_id *ent)
 {
 	int i, ret;
+	struct drm_device *p_ddev;
+	struct drm_device *ddev;
 
 	if (!adev->xcp_mgr)
 		return 0;
 
+	ddev = adev_to_drm(adev);
+
 	for (i = 1; i < MAX_XCP; i++) {
-		if (!adev->xcp_mgr->xcp[i].ddev)
+		if (!adev->xcp_mgr->xcp[i].ddev || adev->xcp_mgr->xcp[i].driver)
 			break;
 
+		/* Redirect all IOCTLs to the primary device */
+		p_ddev = adev->xcp_mgr->xcp[i].ddev;
+		adev->xcp_mgr->xcp[i].rdev = p_ddev->render->dev;
+		adev->xcp_mgr->xcp[i].pdev = p_ddev->primary->dev;
+		adev->xcp_mgr->xcp[i].driver = (struct drm_driver *)p_ddev->driver;
+		adev->xcp_mgr->xcp[i].vma_offset_manager = p_ddev->vma_offset_manager;
+		p_ddev->render->dev = ddev;
+		p_ddev->primary->dev = ddev;
+		p_ddev->driver = &amdgpu_partition_driver;
+		p_ddev->vma_offset_manager = ddev->vma_offset_manager;
+
 		ret = drm_dev_register(adev->xcp_mgr->xcp[i].ddev, ent->driver_data);
-		if (ret)
+		if (ret) {
+			p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
+			p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
+			p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
+			p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+			adev->xcp_mgr->xcp[i].driver = NULL;
 			return ret;
+		}
 	}
 
 	return 0;
 }
 
-void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
+void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev)
 {
 	struct drm_device *p_ddev;
 	int i;
@@ -373,15 +413,18 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		return;
 
 	for (i = 1; i < MAX_XCP; i++) {
-		if (!adev->xcp_mgr->xcp[i].ddev)
+		if (!adev->xcp_mgr->xcp[i].ddev || !adev->xcp_mgr->xcp[i].driver)
 			break;
 
+		// Restore and free the original drm_device.
 		p_ddev = adev->xcp_mgr->xcp[i].ddev;
 		drm_dev_unplug(p_ddev);
+
 		p_ddev->render->dev = adev->xcp_mgr->xcp[i].rdev;
 		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
 		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
 		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+		adev->xcp_mgr->xcp[i].driver = NULL;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index b63f53242c57..97daf1a9236f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -155,6 +155,7 @@ int amdgpu_xcp_resume(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id);
 
 int amdgpu_xcp_mgr_init(struct amdgpu_device *adev, int init_mode,
 			int init_xcps, struct amdgpu_xcp_mgr_funcs *xcp_funcs);
+void amdgpu_xcp_mgr_fini(struct amdgpu_device *adev);
 int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode);
 int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags);
 int amdgpu_xcp_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, int mode);
@@ -168,7 +169,7 @@ int amdgpu_xcp_get_inst_details(struct amdgpu_xcp *xcp,
 
 int amdgpu_xcp_dev_register(struct amdgpu_device *adev,
 				const struct pci_device_id *ent);
-void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev);
+void amdgpu_xcp_dev_deregister(struct amdgpu_device *adev);
 int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 			   struct amdgpu_fpriv *fpriv,
 			   struct drm_file *file_priv);
-- 
2.43.5

