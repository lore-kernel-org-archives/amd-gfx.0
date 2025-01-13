Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6BAC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D3010E338;
	Mon, 13 Jan 2025 01:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GZGv7D3L";
	dkim-atps=neutral
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49BA410E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732547; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=jZcfMtTheWJYGQdckpvxDxUGz4MGECb86Ti8yx6O/nY=;
 b=GZGv7D3L3PWieKYZUTllEa/qLvAMwC7twFrcRlT+YHuL6Ic43Hrz+C1oY8Snn4CdyWp5Bd3my4dBba0A9XpySyQ+NLoycFy1czEBB96EPMTXvhy3QDh85B0IFJybyJG2m6Ycq7VOwU+DnZ+h05C7W7LFTkFzqJ8/j+K9ICHmWAY=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NFP_1736732546 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:26 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 06/15] drm/amdgpu: enhance amdgpu_ras_pre_fini() to better
 support SR
Date: Mon, 13 Jan 2025 09:42:11 +0800
Message-ID: <d07f0c4ed71a8f4b3e6194881f7cc00826240951.1736732062.git.gerry@linux.alibaba.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 44 +++++++++++++---------
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a121aab5c74..2bfe113e17c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4613,6 +4613,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	return 0;
 
 release_ras_con:
+	amdgpu_ras_pre_fini(adev);
+	amdgpu_ras_fini(adev);
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_release_full_gpu(adev, true);
 
@@ -4627,8 +4629,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->virt.ops = NULL;
 		r = -EAGAIN;
 	}
-	amdgpu_release_ras_context(adev);
-
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
@@ -4921,6 +4921,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	cancel_delayed_work_sync(&adev->delayed_init_work);
 
+	/* disable ras feature must before hw fini */
+	amdgpu_ras_pre_fini(adev);
 	amdgpu_ras_suspend(adev);
 
 	amdgpu_device_ip_suspend_phase1(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7bbab7297c97..5ac63f9cffda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4270,42 +4270,49 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
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
+		if (!obj)
+			continue;
+
+		if (!amdgpu_ras_is_supported(adev, obj->ras_comm.block))
+			continue;
+
+		if (obj->ras_fini)
+			obj->ras_fini(adev, &obj->ras_comm);
+		else
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
 
@@ -4323,8 +4330,11 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 
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

