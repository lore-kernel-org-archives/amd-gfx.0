Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD772C5AC67
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 08:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68DEC10F1DD;
	Thu, 13 Aug 2026 08:45:13 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D98810F230
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:45:10 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 67D8anJD2541866; Thu, 13 Aug 2026 14:06:49 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 67D8anw12541865;
 Thu, 13 Aug 2026 14:06:49 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 3/3] drm/amdgpu/userq: ignore duplicate BO locks when
 returning wait fence info
Date: Thu, 13 Aug 2026 14:06:47 +0530
Message-Id: <20260813083647.2541828-3-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813083647.2541828-1-sunil.khatri@amd.com>
References: <20260813083647.2541828-1-sunil.khatri@amd.com>
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

amdgpu_userq_wait_return_fence_info() calls drm_exec_init() without
DRM_EXEC_IGNORE_DUPLICATES. When the same GEM object appears more than
once across the read/write BO handle lists submitted by userspace,
drm_exec_lock_obj() returns -EALREADY the second time it locks that
object, which aborts the fence resolution pass instead of treating the
repeat as a no-op.

Add DRM_EXEC_IGNORE_DUPLICATES so duplicate objects are silently
skipped on the second lock attempt.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 433187df04f3..19af1adc2921 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -814,7 +814,7 @@ amdgpu_userq_wait_return_fence_info(struct drm_device *dev, struct drm_file *fil
 	/* Lock all the GEM objects */
 	num_read_bo_handles = wait_info->num_bo_read_handles;
 	num_write_bo_handles = wait_info->num_bo_write_handles;
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT | DRM_EXEC_IGNORE_DUPLICATES,
 		      num_read_bo_handles + num_write_bo_handles);
 
 	drm_exec_until_all_locked(&exec) {
-- 
2.34.1

