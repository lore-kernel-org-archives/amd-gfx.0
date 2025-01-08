Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1EEE7719A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C01E10E8B9;
	Wed,  8 Jan 2025 14:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c02CbmL4";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DFC10E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344814; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=hkfP7VWzFpd0HSztIEMx5aDltizagixNkqqXS8kJHF8=;
 b=c02CbmL4HgZwY+jfQo3C5cEEpeLlhNWStSl54ya87HNR3RM4P/ETaceJQ5zrJB5mYCL0++fCMEN5X4jGEfPuJJwlPh2iwO3GbXvHmF3zuAhLH4pGFM1BZ7uLThxoA94akTLHmjHgh25cexsbbjFs5hqMLk7xeNkT9mAnISErWkA=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXES_1736344812 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:13 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 07/13] drm/amdgpu: enhance amdgpu_ras_pre_fini() to better
 support SR
Date: Wed,  8 Jan 2025 21:59:59 +0800
Message-ID: <05f15b025fbced7ac7381ea502036c929479b05b.1736344725.git.gerry@linux.alibaba.com>
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

Enhance amdgpu_ras_pre_fini() to better support suspend/resume by:
1) fix possible resource leakage. amdgpu_release_ras_context() only
   kfree(con) but doesn't release resources associated with the con
   object.
2) call amdgpu_ras_pre_fini() in amdgpu_device_suspend() to undo what
   has been done by amdgpu_ras_late_init(), because amdgpu_device_resume()
   will invoke amdgpu_ras_late_init() on resume.
3) move amdgpu_ras_recovery_fini() from amdgpu_ras_pre_fini() to
   amdgpu_ras_fini()
4) move calling of `obj->ras_fini()` from amdgpu_ras_fini() to
   amdgpu_ras_pre_fini().

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 45 ++++++++++++++--------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 602322bd7cb8..7ee8f9d73c3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4599,6 +4599,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
+	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_fini(adev);
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, true);
 
@@ -4613,8 +4615,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->virt.ops = NULL;
 		r = -EAGAIN;
 	}
-	amdgpu_release_ras_context(adev);
-
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
@@ -4875,6 +4875,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
+	/* disable ras feature must before hw fini */
+	amdgpu_ras_pre_fini(adev);
 	amdgpu_ras_suspend(adev);
 
 	amdgpu_device_ip_suspend_phase1(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 040969d56541..bc90035ee25b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4064,42 +4064,50 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
 int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_block_list *node, *tmp;
+	struct amdgpu_ras_block_object *obj;
 
-	if (!adev->ras_enabled || !con)
-		return 0;
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
+		goto disable;
 
+	list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
+		obj = node->ras_obj;
+		if (!obj) {
+			continue;
+		}
+
+		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
+			continue;
+
+		if (obj->ras_fini) {
+			obj->ras_fini(adev, &obj->ras_comm);
+		} else
+			amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
+	}
 
+disable:
 	/* Need disable ras on all IPs here before ip [hw/sw]fini */
-	if (AMDGPU_RAS_GET_FEATURES(con->features))
+	if (con && AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 0);
-	amdgpu_ras_recovery_fini(adev);
+
 	return 0;
 }
 
 int amdgpu_ras_fini(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras_block_list *ras_node, *tmp;
-	struct amdgpu_ras_block_object *obj = NULL;
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 
 	if (!adev->ras_enabled || !con)
-		return 0;
+		goto out_free_context;
 
 	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
-		if (ras_node->ras_obj) {
-			obj = ras_node->ras_obj;
-			if (amdgpu_ras_is_supported(adev, obj->ras_comm.block) &&
-			    obj->ras_fini)
-				obj->ras_fini(adev, &obj->ras_comm);
-			else
-				amdgpu_ras_block_late_fini_default(adev, &obj->ras_comm);
-		}
-
 		/* Clear ras blocks from ras_list and free ras block list node */
 		list_del(&ras_node->node);
 		kfree(ras_node);
 	}
 
+	amdgpu_ras_recovery_fini(adev);
 	amdgpu_ras_fs_fini(adev);
 	amdgpu_ras_interrupt_remove_all(adev);
 
@@ -4117,8 +4125,11 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
 	cancel_delayed_work_sync(&con->ras_counte_delay_work);
 
-	amdgpu_ras_set_context(adev, NULL);
-	kfree(con);
+out_free_context:
+	if (con) {
+		amdgpu_ras_set_context(adev, NULL);
+		kfree(con);
+	}
 
 	return 0;
 }
-- 
2.43.5

