Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0823EE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8338610E8B0;
	Wed,  8 Jan 2025 14:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xGe4s/cI";
	dkim-atps=neutral
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F27210E8A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344812; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=heKzskz1Ds8ReUo+/tta+jLMNtX7BSE1yAGFRnme11Q=;
 b=xGe4s/cISphq3QEZY0W88Uy2RjD6uFY5wcv770kiPDyJMUiy8ooaeXxgylYCNb/iPLT3HGTcTD8BZtLhVyqSqlF4oi7DgB9q56DkqvdwJI+zVPZ4re/lIvxz2TjfiXV47j0YTrc7JL9hisHTFhSyyeUoMIOdf7fVmQSWGa1wfkg=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXDd_1736344811 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:11 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 03/13] drm/amdgpu: add a flag to track ras debugfs
 creation status
Date: Wed,  8 Jan 2025 21:59:55 +0800
Message-ID: <014a704e91787b123203d568256861000a7fe558.1736344725.git.gerry@linux.alibaba.com>
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

Add a flag to track ras debugfs creation status, to avoid possible
incorrect reference count management for ras block object  in function
amdgpu_ras_aca_is_supported().

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 32941f29507c..2ef7d3102be3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -378,7 +378,7 @@ enum amdgpu_marker {
 	AMDGPU_MARKER_IRQ6		= 6,
 	AMDGPU_MARKER_IRQ7		= 7,
 	AMDGPU_MARKER_IRQ_MAX		= 47,
-	AMDGPU_MARKER_DEBUGFS		= 63,
+	AMDGPU_MARKER_RAS_DEBUGFS	= 63,
 };
 
 #define AMDGPU_MARKER_INDEX_IRQ(idx)		(AMDGPU_MARKER_INDEX_IRQ0 + (idx))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6d52e22691f7..efd72b07a185 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1996,7 +1996,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 {
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head->head);
 
-	if (!obj || !dir)
+	if (!obj || !dir ||
+	    amdgpu_ras_test_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS))
 		return;
 
 	get_obj(obj);
@@ -2007,6 +2008,8 @@ static void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
 
 	debugfs_create_file(obj->fs_data.debugfs_name, S_IWUGO | S_IRUGO, dir,
 			    obj, &amdgpu_ras_debugfs_ops);
+
+	amdgpu_ras_set_marker(adev, &head->head, AMDGPU_MARKER_RAS_DEBUGFS);
 }
 
 static bool amdgpu_ras_aca_is_supported(struct amdgpu_device *adev)
@@ -2134,7 +2137,9 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
 	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
 		list_for_each_entry_safe(con_obj, tmp, &con->head, node) {
 			ip_obj = amdgpu_ras_find_obj(adev, &con_obj->head);
-			if (ip_obj)
+			if (ip_obj &&
+			    amdgpu_ras_test_and_clear_marker(adev, &ip_obj->head,
+			    				     AMDGPU_MARKER_RAS_DEBUGFS))
 				put_obj(ip_obj);
 		}
 	}
-- 
2.43.5

