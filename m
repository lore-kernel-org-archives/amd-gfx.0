Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998D9E7719D
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41C1210E8B6;
	Wed,  8 Jan 2025 14:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GQ2htwXO";
	dkim-atps=neutral
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC1910E2A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344814; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=yGbDzzW0i1VaTeM0bOC3o6OLRHUq0MZUE+aUNTbB5I8=;
 b=GQ2htwXOa+fDZ6UaRivjArl/K3Ov0B2biSza4jywXNP60Qz2IlC3Cz5PU+QQKNQLcNZVZQ4RR3Jzl42NjFE8lK8+X+0b3DDAqu5VecxGJX9cAwEJLkHZM3Agvm6Qe3Gzd/I28fyBVEb7xqzD4oGlpS6i15EeiJveNU8I1fbPL3k=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXEm_1736344813 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:13 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 08/13] drm/admgpu: rename amdgpu_ras_pre_fini() to
 amdgpu_ras_early_fini()
Date: Wed,  8 Jan 2025 22:00:00 +0800
Message-ID: <0defd1ebef0178cf4b154b405d71488fe955d616.1736344725.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
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

Rename amdgpu_ras_pre_fini() to amdgpu_ras_early_fini(), to keep same
style with other code.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  2 +-
 12 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ee8f9d73c3c..0e69c7c7fe1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4599,7 +4599,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
-	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_early_fini(adev);
 	amdgpu_ras_fini(adev);
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, true);
@@ -4690,7 +4690,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_reg_state_sysfs_fini(adev);
 
 	/* disable ras feature must before hw fini */
-	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_early_fini(adev);
 
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
@@ -4876,7 +4876,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
 	/* disable ras feature must before hw fini */
-	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_early_fini(adev);
 	amdgpu_ras_suspend(adev);
 
 	amdgpu_device_ip_suspend_phase1(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8c9fcfb7f22e..84834892236f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -899,7 +899,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 
 	return 0;
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 0a6397e3b8a7..c6b3777c4792 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -300,7 +300,7 @@ int amdgpu_jpeg_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
index d085687a47ea..c75ce91f94ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
@@ -71,6 +71,6 @@ int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *
 
 	return 0;
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index bc90035ee25b..5335942d3cdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3918,7 +3918,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	return 0;
 
 cleanup:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
@@ -3929,7 +3929,7 @@ static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
 }
 
 /* helper function to remove ras fs node and interrupt handler */
-void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
+void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block)
 {
 	struct amdgpu_ras_block_object *ras_obj;
@@ -3950,10 +3950,10 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
 		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
 }
 
-static void amdgpu_ras_block_late_fini_default(struct amdgpu_device *adev,
+static void amdgpu_ras_block_early_fini_default(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block)
 {
-	return amdgpu_ras_block_late_fini(adev, ras_block);
+	return amdgpu_ras_block_early_fini(adev, ras_block);
 }
 
 /* do some init work after IP late init as dependence.
@@ -4061,7 +4061,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 }
 
 /* do some fini work before IP fini as dependence */
-int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
+int amdgpu_ras_early_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_block_list *node, *tmp;
@@ -4079,10 +4079,10 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
 			continue;
 
-		if (obj->ras_fini) {
-			obj->ras_fini(adev, &obj->ras_comm);
+		if (obj->ras_early_fini) {
+			obj->ras_early_fini(adev, &obj->ras_comm);
 		} else
-			amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
+			amdgpu_ras_block_early_fini_default(adev, &obj->ras_comm);
 	}
 
 disable:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index bc7377eaf819..56665487be2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -709,7 +709,7 @@ struct amdgpu_ras_block_object {
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
 	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-	void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+	void (*ras_early_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 	ras_ih_cb ras_cb;
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
 };
@@ -823,13 +823,13 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
 /* called in ip_init and ip_fini */
 int amdgpu_ras_init(struct amdgpu_device *adev);
 int amdgpu_ras_late_init(struct amdgpu_device *adev);
+int amdgpu_ras_early_fini(struct amdgpu_device *adev);
 int amdgpu_ras_fini(struct amdgpu_device *adev);
-int amdgpu_ras_pre_fini(struct amdgpu_device *adev);
 
 int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 			struct ras_common_if *ras_block);
 
-void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
+void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block);
 
 int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 183a976ba29d..21938e858d55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -116,7 +116,7 @@ int amdgpu_sdma_ras_late_init(struct amdgpu_device *adev,
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index b9fec295b9a6..31a8a12420cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -339,7 +339,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index aecb78e0519f..b2cf68db650c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1239,7 +1239,7 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 8e697273d2ac..99722b5be315 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1122,7 +1122,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 4d5b48dbc005..a0a1af0ffc54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -5062,7 +5062,7 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index b01bb759d0f4..4beec0b980b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -790,7 +790,7 @@ static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
-- 
2.43.5

