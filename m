Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038F9E7719F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC3AF10E334;
	Mon, 13 Jan 2025 01:42:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q5FN894C";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F9610E32C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732545; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=vwVXDF+Kb25BwEpfwq8w1ctI+68jczR0c+Fbh05TiXc=;
 b=q5FN894CkIrRXGBlZyh+8/d61DblttumFoldA/c8sGt+GkLSAbNM3+gsu2A1ycIWqeFb4eWcYvy/8Syw5Cc9q9iMohDN5yyTRVVV8WW735BTsWXFQgx3QRGuXke+XWi0mUQieSjqufG9kd2wPM2a8+2BXnf9+hU49Kq6awbsNqw=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NER_1736732543 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:24 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 02/15] drm/amdgpu: add a flag to track ras debugfs creation
 status
Date: Mon, 13 Jan 2025 09:42:07 +0800
Message-ID: <f79c15b3eb9c560ba7942c3e7f51dae7d6051fa7.1736732062.git.gerry@linux.alibaba.com>
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

Add a flag to track ras debugfs creation status, to avoid possible
incorrect reference count management for ras block object  in function
amdgpu_ras_aca_is_supported().

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f0f773659faf..09b63a622728 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -378,6 +378,8 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
 #define AMDGPU_MAX_IP_NUM 16
 
 enum amdgpu_marker {
+	// Markers for ras blocks.
+	AMDGPU_MARKER_RAS_DEBUGFS,
 	// Markers for IRQs, used for both ip blocks and ras blocks.
 	AMDGPU_MARKER_IRQ0 = 32,
 	AMDGPU_MARKER_IRQ1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5e19d820ab34..c10ea3fd3e16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1997,7 +1997,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
 
-	if (!obj || !dir)
+	if (!obj || !dir ||
+	    amdgpu_ras_test_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS))
 		return;
 
 	get_obj(obj);
@@ -2008,6 +2009,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 
 	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
 			    obj, &amdgpu_ras_debugfs_ops);
+
+	amdgpu_ras_set_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS);
 }
 
 static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
@@ -2136,7 +2139,9 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
 			ip_obj = amdgpu_ras_find_obj(adev, &con_obj->head);
-			if (ip_obj)
+			if (ip_obj &&
+			    amdgpu_ras_test_and_clear_marker(adev, &ip_obj->head,
+							     AMDGPU_MARKER_RAS_DEBUGFS))
 				put_obj(ip_obj);
 		}
 	}
-- 
2.43.5

