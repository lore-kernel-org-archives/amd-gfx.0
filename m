Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECD6E7719E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 01:42:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E770110E332;
	Mon, 13 Jan 2025 01:42:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L4ZZ304r";
	dkim-atps=neutral
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 711A110E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2025 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736732546; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=aIrEUfpBiU0k9cFExRRE1a+HqHkEhi6SBbiYKybyGlY=;
 b=L4ZZ304rYVb6m3T6UMoywZ1vfgsL9LhBSsUjo7muwXdQXbUQfOVCcfaUBAxLEn8oJ8LugQQ2ju0jU3FlZTkLSbu0EvTQXvZDmuGi4b0ZYBu3S6b1XQkgoZWjB5zXmNPU+VZIHE+KQQhbpdHgPdktaFUFgmG6lEIpcPP5uT19Eak=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNS0NEs_1736732545 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 13 Jan 2025 09:42:25 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC v2 04/15] drm/amdgpu: introduce a flag to track refcount held
 for features
Date: Mon, 13 Jan 2025 09:42:09 +0800
Message-ID: <d8db52c680a7c549865dff8143320ebb2df28d64.1736732062.git.gerry@linux.alibaba.com>
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

Currently we track the refcount on ras block object for features by
checking `if (obj && amdgpu_ras_is_feature_enabled(adev, head))`,
which is a little unreliable. So introduce a dedicated flag to track
the reference count.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 09b63a622728..24ef39b706e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -380,6 +380,7 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
 enum amdgpu_marker {
 	// Markers for ras blocks.
 	AMDGPU_MARKER_RAS_DEBUGFS,
+	AMDGPU_MARKER_RAS_FEATURE,
 	// Markers for IRQs, used for both ip blocks and ras blocks.
 	AMDGPU_MARKER_IRQ0 = 32,
 	AMDGPU_MARKER_IRQ1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 6b508a9b1abe..f0cd14ff78a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -775,15 +775,20 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
 			obj = amdgpu_ras_create_obj(adev, head);
 			if (!obj)
 				return -EINVAL;
-		} else {
+			amdgpu_ras_set_marker(adev, head, AMDGPU_MARKER_RAS_FEATURE);
+		} else if (!amdgpu_ras_test_marker(adev, head,
+						   AMDGPU_MARKER_RAS_FEATURE)) {
 			/* In case we create obj somewhere else */
 			get_obj(obj);
+			amdgpu_ras_set_marker(adev, head, AMDGPU_MARKER_RAS_FEATURE);
 		}
 		con->features |= BIT(head->block);
 	} else {
 		if (obj && amdgpu_ras_is_feature_enabled(adev, head)) {
 			con->features &= ~BIT(head->block);
-			put_obj(obj);
+			if (amdgpu_ras_test_and_clear_marker(adev, head,
+							     AMDGPU_MARKER_RAS_FEATURE))
+				put_obj(obj);
 		}
 	}
 
-- 
2.43.5

