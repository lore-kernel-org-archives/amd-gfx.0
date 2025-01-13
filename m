Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B59E77188
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE9810E337;
	Mon, 13 Jan 2025 01:42:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m9v6RIlQ";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF82B10E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732548; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Nqhmzv1tbgyX4V0mKLzn5YGqHPs2t1+HgUDj7Hcl4Rg=;
 b=m9v6RIlQXaWBtKxQ+KmP0uLwx4yyOOOL5NANbBO8vEVJSEKQs3N7bWxJtQS4EDaoXaW6hxGTAYWwThkEiNgjoLG8WHRM4VOiEUnlg3XVKJv/dYg8QmJGFwdxA8Ln/T4+x+PLyFc1oLPLC2k1hgfkEy9C4gbkiWt7G5fy5/6+EtE=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NFe_1736732546 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:27 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 07/15] drm/admgpu: rename amdgpu_ras_pre_fini() to
 amdgpu_ras_early_fini()
Date: Mon, 13 Jan 2025 09:42:12 +0800
Message-ID: <0e66fc11d40fc0f9c8ea4e2bd3ac70b7b8933ee5.1736732062.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736732062.git.gerry@linux.alibaba.com>
References: <cover.1736732062.git.gerry@linux.alibaba.com>
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  2 +-
 14 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2bfe113e17c7..6cbd19ad0fa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4613,7 +4613,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
-	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_early_fini(adev);
 	amdgpu_ras_fini(adev);
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, true);
@@ -4705,7 +4705,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	amdgpu_xcp_cfg_sysfs_fini(adev);
 
 	/* disable ras feature must before hw fini */
-	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_early_fini(adev);
 
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 
@@ -4922,7 +4922,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
 	/* disable ras feature must before hw fini */
-	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_early_fini(adev);
 	amdgpu_ras_suspend(adev);
 
 	amdgpu_device_ip_suspend_phase1(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 6d5d81f0dc4e..2e7c09530ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -918,7 +918,7 @@ int amdgpu_gfx_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 
 	return 0;
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index b6d2eb049f54..80248930082c 100644
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
index 5ac63f9cffda..b11e3eb2b100 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4124,7 +4124,7 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	return 0;
 
 cleanup:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
@@ -4135,7 +4135,7 @@ static int amdgpu_ras_block_late_init_default(struct amdgpu_device *adev,
 }
 
 /* helper function to remove ras fs node and interrupt handler */
-void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
+void amdgpu_ras_block_early_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block)
 {
 	struct amdgpu_ras_block_object *ras_obj;
@@ -4156,10 +4156,10 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
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
@@ -4267,7 +4267,7 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 }
 
 /* do some fini work before IP fini as dependence */
-int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
+int amdgpu_ras_early_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ras_block_list *node, *tmp;
@@ -4284,10 +4284,10 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
 			continue;
 
-		if (obj->ras_fini)
-			obj->ras_fini(adev, &obj->ras_comm);
+		if (obj->ras_early_fini)
+			obj->ras_early_fini(adev, &obj->ras_comm);
 		else
-			amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
+			amdgpu_ras_block_early_fini_default(adev, &obj->ras_comm);
 	}
 
 disable:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 35881087b17b..3a6f70b75e47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -711,7 +711,7 @@ struct amdgpu_ras_block_object {
 	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
 				enum amdgpu_ras_block block, uint32_t sub_block_index);
 	int (*ras_late_init)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
-	void (*ras_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
+	void (*ras_early_fini)(struct amdgpu_device *adev, struct ras_common_if *ras_block);
 	ras_ih_cb ras_cb;
 	const struct amdgpu_ras_block_hw_ops *hw_ops;
 };
@@ -825,13 +825,13 @@ amdgpu_ras_error_to_ta(enum amdgpu_ras_error_type error) {
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
index 174badca27e7..1a1834e47b50 100644
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
index eafe20d8fe0b..dd787f5f2f23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -336,7 +336,7 @@ int amdgpu_umc_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 83faf6e6788a..3ab80399d2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1248,7 +1248,7 @@ int amdgpu_vcn_ras_late_init(struct amdgpu_device *adev, struct ras_common_if *r
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 74b4349e345a..825c331f48f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -1174,7 +1174,7 @@ static int amdgpu_xgmi_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2ba185875baa..ce70acfbf22c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -5080,7 +5080,7 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 88f9771c1686..28bc2f946e91 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1311,7 +1311,7 @@ static int jpeg_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_comm
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index e646e5cef0a2..467283165a3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -789,7 +789,7 @@ static int mmhub_v1_8_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index ecdc027f8220..063b3bafd134 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1996,7 +1996,7 @@ static int vcn_v4_0_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	return 0;
 
 late_fini:
-	amdgpu_ras_block_late_fini(adev, ras_block);
+	amdgpu_ras_block_early_fini(adev, ras_block);
 
 	return r;
 }
-- 
2.43.5

