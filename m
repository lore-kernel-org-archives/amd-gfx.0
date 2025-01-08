Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B23E7719C
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BCCD10E8B1;
	Wed,  8 Jan 2025 14:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LpTZSbVK";
	dkim-atps=neutral
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456BB10E2A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344813; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=zqzHl+opxVVCTi7vdPFytgKHgSee0QsHTN/qNfo18Ro=;
 b=LpTZSbVK6nV2PgzmAXikSJdFsyMjZOjnWQfaMzAzHm/uzc9XSk4gMVgkpzjjCuIpyUBEaDqhSgZFoTw31dY6BSq//D2AzkvyHA2kEeGpNSTy+pm6Dj0RO3WUlh+2GB+xQ44l/D32z531Z67NL9rR7YxhqNgS2MkZt9EOpxUjNoE=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXE0_1736344812 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:12 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 05/13] drm/amdgpu: introduce a flag to track refcount held
 for features
Date: Wed,  8 Jan 2025 21:59:57 +0800
Message-ID: <55cb5e533b76a1c0cc11e81f8e7866a2fe28baac.1736344725.git.gerry@linux.alibaba.com>
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

Currently we track the refcount on ras block object for features by
checking `if (obj && amdgpu_ras_is_feature_enabled(adev, head))`,
which is a little unreliable. So introduce a dedicated flag to track
the reference count.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2ef7d3102be3..fa19c5391d8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -378,6 +378,8 @@ enum amdgpu_marker {
 	AMDGPU_MARKER_IRQ6		= 6,
 	AMDGPU_MARKER_IRQ7		= 7,
 	AMDGPU_MARKER_IRQ_MAX		= 47,
+	// used for ras blocks
+	AMDGPU_MARKER_RAS_FEATURE	= 62,
 	AMDGPU_MARKER_RAS_DEBUGFS	= 63,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5e8838ffccaa..41978116b92b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -774,15 +774,20 @@ static int __amdgpu_ras_feature_enable(struct amdgpu_device *adev,
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

