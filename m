Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DD6C02183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA19510E343;
	Mon, 13 Jan 2025 01:42:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EFJJiQTm";
	dkim-atps=neutral
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3842E10E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732545; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=IRbdPbdLkBB3QRRy+TekxMk+oiH2AdzJNTvqZ56c54I=;
 b=EFJJiQTmBYQHwdop6q6Qej1t7pmCmuFu/rsvienGyDSxpFHuN7gKIJXkU8CbmBegQByRnC+QTfmykmgRwAvBXzyVonaE0kJ0DhqNiQu7Kgpzq9lcbjh+ku6wbYJtJTMTsxVPCqEOABpo9rsEkjUgpBRFo6xCRGCSqNkZlUlEstw=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NEg_1736732544 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:24 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 03/15] drm/amdgpu: free all resources on error recovery path
 of amdgpu_ras_init()
Date: Mon, 13 Jan 2025 09:42:08 +0800
Message-ID: <fe7c662f67cb5f079cef7688d033bf93539db277.1736732062.git.gerry@linux.alibaba.com>
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

Free all allocated resources on error recovery path in function
amdgpu_ras_init().

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c10ea3fd3e16..6b508a9b1abe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3864,6 +3864,7 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
 int amdgpu_ras_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct amdgpu_ras_block_list *ras_node, *tmp;
 	int r;
 
 	if (con)
@@ -3953,20 +3954,20 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
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
@@ -3982,7 +3983,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 
 	if (amdgpu_ras_fs_init(adev)) {
 		r = -EINVAL;
-		goto release_con;
+		goto free_blocks;
 	}
 
 	if (amdgpu_ras_aca_is_supported(adev)) {
@@ -3991,7 +3992,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 		else
 			r = amdgpu_mca_init(adev);
 		if (r)
-			goto release_con;
+			goto clear_ras_fs;
 	}
 
 	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
@@ -3999,6 +4000,14 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
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

