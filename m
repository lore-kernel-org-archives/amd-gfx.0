Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCFBC49EA1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 12:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A36010E979;
	Fri, 26 Jul 2024 12:48:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9860710E979
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 12:48:04 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46QCluv53121357; Fri, 26 Jul 2024 18:17:56 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46QCltBw3121356;
 Fri, 26 Jul 2024 18:17:55 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
Date: Fri, 26 Jul 2024 18:17:51 +0530
Message-Id: <20240726124751.3121312-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726124751.3121312-1-sunil.khatri@amd.com>
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
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

Problem:
IP dump right now is done post suspend of
all IP's which for some IP's could change power
state and software state too which we do not want
to reflect in the dump as it might not be same at
the time of hang.

Solution:
IP should be dumped as close to the HW state when
the GPU was in hung state without trying to reinitialize
any resource.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++-----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 730dae77570c..74f6f15e73b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	return ret;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	int i;
+
+	lockdep_assert_held(&adev->reset_domain->sem);
+
+	for (i = 0; i < adev->reset_info.num_regs; i++) {
+		adev->reset_info.reset_dump_reg_value[i] =
+			RREG32(adev->reset_info.reset_dump_reg_list[i]);
+
+		trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
+					     adev->reset_info.reset_dump_reg_value[i]);
+	}
+
+	return 0;
+}
+
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context)
 {
 	int i, r = 0;
 	struct amdgpu_job *job = NULL;
+	struct amdgpu_device *tmp_adev = reset_context->reset_req_dev;
 	bool need_full_reset =
 		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
@@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			}
 		}
 
+		if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
+			amdgpu_reset_reg_dumps(tmp_adev);
+
+			dev_info(tmp_adev->dev, "Dumping IP State\n");
+			/* Trigger ip dump before we reset the asic */
+			for (i = 0; i < tmp_adev->num_ip_blocks; i++)
+				if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
+					tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
+							(void *)tmp_adev);
+			dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
+		}
+
 		if (need_full_reset)
 			r = amdgpu_device_ip_suspend(adev);
 		if (need_full_reset)
@@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
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
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset, skip_hw_reset, vram_lost = false;
 	int r = 0;
-	uint32_t i;
 
 	/* Try reset handler method first */
 	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
 				    reset_list);
 
-	if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
-		amdgpu_reset_reg_dumps(tmp_adev);
-
-		dev_info(tmp_adev->dev, "Dumping IP State\n");
-		/* Trigger ip dump before we reset the asic */
-		for (i = 0; i < tmp_adev->num_ip_blocks; i++)
-			if (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
-				tmp_adev->ip_blocks[i].version->funcs
-				->dump_ip_state((void *)tmp_adev);
-		dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
-	}
-
 	reset_context->reset_device_list = device_list_handle;
 	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
 	/* If reset handler not implemented, continue; otherwise return */
-- 
2.34.1

