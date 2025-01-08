Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6508E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D6210E42A;
	Wed,  8 Jan 2025 14:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z7x2ZZr/";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857D110E8AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344812; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=aceUqReeoNuiSBcDswYBDcIMmOSyRj96U2Snm1iXMxU=;
 b=Z7x2ZZr/1GSJHlnxkhc95b4Q82JNfweC6hrf+HqOAGGZ7nzwDLS8kXJkYExSaXD76Jc2igxCrrnJd7P0DMFREBt8Ly3vL598jpsRva1GZhOt0ImNDswBOumhhiRMrvp0cDShnkqcn0HA+zT/kPEVAZpv4TVV6EWdwuM4mEjSDpU=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXDw_1736344811 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:11 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 04/13] drm/amdgpu: free all resources on error recovery
 path of amdgpu_ras_init()
Date: Wed,  8 Jan 2025 21:59:56 +0800
Message-ID: <6695832b6bdb748114b0e7604a3c954c57e0837c.1736344725.git.gerry@linux.alibaba.com>
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

Free all allocated resources on error recovery path in function
amdgpu_ras_init().

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index efd72b07a185..5e8838ffccaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3670,6 +3670,7 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_block_list *ras_node, *tmp;
 	int r;
 
 	if (con)
@@ -3747,20 +3748,20 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	 * to handle fatal error */
 	r = amdgpu_nbio_ras_sw_init(adev);
 	if (r)
-		return r;
+		goto release_con;
 
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->init_ras_controller_interrupt) {
 		r = adev->nbio.ras->init_ras_controller_interrupt(adev);
 		if (r)
-			goto release_con;
+			goto free_blocks;
 	}
 
 	if (adev->nbio.ras &&
 	    adev->nbio.ras->init_ras_err_event_athub_interrupt) {
 		r = adev->nbio.ras->init_ras_err_event_athub_interrupt(adev);
 		if (r)
-			goto release_con;
+			goto free_blocks;
 	}
 
 	/* Packed socket_id to ras feature mask bits[31:29] */
@@ -3776,7 +3777,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
-		goto release_con;
+		goto free_blocks;
 	}
 
 	if (amdgpu_ras_aca_is_supported(adev)) {
@@ -3785,7 +3786,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		else
 			r = amdgpu_mca_init(adev);
 		if (r)
-			goto release_con;
+			goto clear_ras_fs;
 	}
 
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
@@ -3793,6 +3794,14 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		 adev->ras_hw_enabled, adev->ras_enabled);
 
 	return 0;
+
+clear_ras_fs:
+	amdgpu_ras_fs_fini(adev);
+free_blocks:
+	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
+		list_del(&ras_node->node);
+		kfree(ras_node);
+	}
 release_con:
 	amdgpu_ras_set_context(adev, NULL);
 	kfree(con);
-- 
2.43.5

