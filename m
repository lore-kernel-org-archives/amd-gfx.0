Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C1DE77199
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B2CE10E2A3;
	Wed,  8 Jan 2025 14:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rv4aYWOO";
	dkim-atps=neutral
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2154E10E2A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344813; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=DvwAv3kDpVsLGthceA0sl0Zh1cnFCsR1qkbEggdLsvM=;
 b=rv4aYWOOIebnQWVVziPszbfTIOCgi2wWas1fpaIMUqekWg2GVRIlDd1Y1eTvvNNO8gzD1KC+gCfLH6DfWrM+nhPgDb8myJil5/NYm18ppogbkUHjcJNZRx0sGfet5572WDWAhQ+BcRYYBdrXcaZUs6w1W8qwYgl7k+/5t5CJYqk=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXEE_1736344812 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:12 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 06/13] drm/amdgpu: enhance amdgpu_ras_block_late_fini()
Date: Wed,  8 Jan 2025 21:59:58 +0800
Message-ID: <438f73b4a10d13a72b3c9a4b4fc55e23469d9384.1736344725.git.gerry@linux.alibaba.com>
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

Enhance amdgpu_ras_block_late_fini() to revert what has been done
by amdgpu_ras_block_late_init(), and fix a possible resource leakage
in function amdgpu_ras_block_late_init().

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 41978116b92b..040969d56541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3898,13 +3898,13 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 	     ras_obj->hw_ops->query_ras_error_status)) {
 		r = amdgpu_ras_sysfs_create(adev, ras_block);
 		if (r)
-			goto interrupt;
+			goto cleanup;
 
 		/* Those are the cached values at init.
 		 */
 		query_info = kzalloc(sizeof(*query_info), GFP_KERNEL);
 		if (!query_info)
-			return -ENOMEM;
+			goto cleanup;
 		memcpy(&query_info->head, ras_block, sizeof(struct ras_common_if));
 
 		if (amdgpu_ras_query_error_count(adev, &ce_count, &ue_count, query_info) == 0) {
@@ -3917,11 +3917,8 @@ int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
 
 	return 0;
 
-interrupt:
-	if (ras_obj->ras_cb)
-		amdgpu_ras_interrupt_remove_handler(adev, ras_block);
 cleanup:
-	amdgpu_ras_feature_enable(adev, ras_block, 0);
+	amdgpu_ras_block_late_fini(adev, ras_block);
 	return r;
 }
 
@@ -3936,9 +3933,16 @@ void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
 			  struct ras_common_if *ras_block)
 {
 	struct amdgpu_ras_block_object *ras_obj;
+
 	if (!ras_block)
 		return;
 
+	amdgpu_ras_feature_enable(adev, ras_block, 0);
+
+	/* in resume/reset phase, no need to delete ras fs node */
+	if (adev->in_suspend || amdgpu_in_reset(adev))
+		return;
+
 	amdgpu_ras_sysfs_remove(adev, ras_block);
 
 	ras_obj = container_of(ras_block, struct amdgpu_ras_block_object, ras_comm);
-- 
2.43.5

