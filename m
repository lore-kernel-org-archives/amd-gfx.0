Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A5EC3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 06:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0414310E3DA;
	Tue, 30 Jul 2024 06:40:19 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB29E10E3DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 06:40:17 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46U6eCNg4185780; Tue, 30 Jul 2024 12:10:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46U6eC1j4185779;
 Tue, 30 Jul 2024 12:10:12 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: Clean up the register dump via debugfs list
Date: Tue, 30 Jul 2024 12:10:08 +0530
Message-Id: <20240730064008.4185728-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730064008.4185728-1-sunil.khatri@amd.com>
References: <20240730064008.4185728-1-sunil.khatri@amd.com>
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

debugfs register list for dump is cleaned as it have
some issues related to proper power state of the IP
before register read.

Since the above mentioned is removed we no longer want
this to be dumped part of the devcoredump and hence
removed.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 13 -------------
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 10 +---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 19 -------------------
 3 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 137a88b8de45..c54ddd3e68aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -823,17 +823,6 @@ struct amdgpu_mqd {
 struct amdgpu_reset_domain;
 struct amdgpu_fru_info;
 
-struct amdgpu_reset_info {
-	/* reset dump register */
-	u32 *reset_dump_reg_list;
-	u32 *reset_dump_reg_value;
-	int num_regs;
-
-#ifdef CONFIG_DEV_COREDUMP
-	struct amdgpu_coredump_info *coredump_info;
-#endif
-};
-
 /*
  * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
  */
@@ -1157,8 +1146,6 @@ struct amdgpu_device {
 
 	struct mutex			benchmark_mutex;
 
-	struct amdgpu_reset_info	reset_info;
-
 	bool                            scpm_enabled;
 	uint32_t                        scpm_status;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index f6806ae1c061..cf2b4dd4d865 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -203,7 +203,7 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 	struct amdgpu_coredump_info *coredump = data;
 	struct drm_print_iterator iter;
 	struct amdgpu_vm_fault_info *fault_info;
-	int i, ver;
+	int ver;
 
 	iter.data = buffer;
 	iter.offset = 0;
@@ -317,14 +317,6 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 
 	if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
-	if (coredump->adev->reset_info.num_regs) {
-		drm_printf(&p, "AMDGPU register dumps:\nOffset:     Value:\n");
-
-		for (i = 0; i < coredump->adev->reset_info.num_regs; i++)
-			drm_printf(&p, "0x%08x: 0x%08x\n",
-				   coredump->adev->reset_info.reset_dump_reg_list[i],
-				   coredump->adev->reset_info.reset_dump_reg_value[i]);
-	}
 
 	return count - iter.remain;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a2a1a3da17e3..3a43754e7f10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5277,23 +5277,6 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
-static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
-{
-	int i;
-
-	lockdep_assert_held(&adev->reset_domain->sem);
-
-	for (i = 0; i < adev->reset_info.num_regs; i++) {
-		adev->reset_info.reset_dump_reg_value[i] =
-			RREG32(adev->reset_info.reset_dump_reg_list[i]);
-
-		trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
-					     adev->reset_info.reset_dump_reg_value[i]);
-	}
-
-	return 0;
-}
-
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)
 {
@@ -5359,8 +5342,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		}
 
 		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
-			amdgpu_reset_reg_dumps(tmp_adev);
-
 			dev_info(tmp_adev->dev, "Dumping IP State\n");
 			/* Trigger ip dump before we reset the asic */
 			for (i = 0; i < tmp_adev->num_ip_blocks; i++)
-- 
2.34.1

