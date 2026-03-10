Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639E8FD2D98
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 13:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AD510E6CB;
	Tue, 10 Mar 2026 13:55:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B00C010E294
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 13:55:43 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62ADtXYp3954713; Tue, 10 Mar 2026 19:25:33 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62ADtW3Q3954712;
 Tue, 10 Mar 2026 19:25:32 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu/userq: Only look up for gem objects when
 count is non zero
Date: Tue, 10 Mar 2026 19:25:30 +0530
Message-Id: <20260310135531.3954691-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

In function amdgpu_userq_wait_ioctl, call function drm_gem_objects_lookup
only if the count is valid i.e non zero.

In case of object count is 0 set the pointer to NULL for proper clean
up.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 ++++++++++++-------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 76f32fd768fb..a4fff90b190a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -665,19 +665,27 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		goto free_timeline_handles;
 	}
 
-	r = drm_gem_objects_lookup(filp,
-				   u64_to_user_ptr(wait_info->bo_read_handles),
-				   num_read_bo_handles,
-				   &gobj_read);
-	if (r)
-		goto free_timeline_points;
+	if (num_read_bo_handles) {
+		r = drm_gem_objects_lookup(filp,
+					   u64_to_user_ptr(wait_info->bo_read_handles),
+					   num_read_bo_handles,
+					   &gobj_read);
+		if (r)
+			goto free_timeline_points;
+	} else {
+		gobj_read = NULL;
+	}
 
-	r = drm_gem_objects_lookup(filp,
-				   u64_to_user_ptr(wait_info->bo_write_handles),
-				   num_write_bo_handles,
-				   &gobj_write);
-	if (r)
-		goto put_gobj_read;
+	if (num_write_bo_handles) {
+		r = drm_gem_objects_lookup(filp,
+					   u64_to_user_ptr(wait_info->bo_write_handles),
+					   num_write_bo_handles,
+					   &gobj_write);
+		if (r)
+			goto put_gobj_read;
+	} else {
+		gobj_write = NULL;
+	}
 
 	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
 		      (num_read_bo_handles + num_write_bo_handles));
-- 
2.34.1

