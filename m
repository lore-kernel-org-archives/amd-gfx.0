Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DCEC53200
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 08:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CF410E79A;
	Fri, 20 Feb 2026 08:28:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E563810E799
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 08:28:49 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 61K8Sipf2192365; Fri, 20 Feb 2026 13:58:44 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 61K8Si0P2192364;
 Fri, 20 Feb 2026 13:58:44 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu: update memdup_user with memdup_array_user
Date: Fri, 20 Feb 2026 13:58:39 +0530
Message-Id: <20260220082840.2192325-1-sunil.khatri@amd.com>
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

memdup_user could return invalid memory allocation if
there is an integer overflow. Using memdup_array_user
make sure we validate the size requirements upfront
and return with an error.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 212056d4ddf0..a6eb703b62c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -480,8 +480,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	num_syncobj_handles = args->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(args->syncobj_handles),
-				      size_mul(sizeof(u32), num_syncobj_handles));
+	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
+					    num_syncobj_handles, sizeof(u32));
 	if (IS_ERR(syncobj_handles))
 		return PTR_ERR(syncobj_handles);
 
@@ -501,8 +501,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	num_read_bo_handles = args->num_bo_read_handles;
-	bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_read_handles),
-				      sizeof(u32) * num_read_bo_handles);
+	bo_handles_read = memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
+					    num_read_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_read)) {
 		r = PTR_ERR(bo_handles_read);
 		goto free_syncobj;
@@ -524,8 +524,8 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	num_write_bo_handles = args->num_bo_write_handles;
-	bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_write_handles),
-				       sizeof(u32) * num_write_bo_handles);
+	bo_handles_write = memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
+					     num_write_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_write)) {
 		r = PTR_ERR(bo_handles_write);
 		goto put_gobj_read;
@@ -666,37 +666,37 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	num_read_bo_handles = wait_info->num_bo_read_handles;
-	bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_read_handles),
-				      size_mul(sizeof(u32), num_read_bo_handles));
+	bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
+					    num_read_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_read))
 		return PTR_ERR(bo_handles_read);
 
 	num_write_bo_handles = wait_info->num_bo_write_handles;
-	bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_write_handles),
-				       size_mul(sizeof(u32), num_write_bo_handles));
+	bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
+					     num_write_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_write)) {
 		r = PTR_ERR(bo_handles_write);
 		goto free_bo_handles_read;
 	}
 
 	num_syncobj = wait_info->num_syncobj_handles;
-	syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
-				      size_mul(sizeof(u32), num_syncobj));
+	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
+					    num_syncobj, sizeof(u32));
 	if (IS_ERR(syncobj_handles)) {
 		r = PTR_ERR(syncobj_handles);
 		goto free_bo_handles_write;
 	}
 
 	num_points = wait_info->num_syncobj_timeline_handles;
-	timeline_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
-				       sizeof(u32) * num_points);
+	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
+					     num_points, sizeof(u32));
 	if (IS_ERR(timeline_handles)) {
 		r = PTR_ERR(timeline_handles);
 		goto free_syncobj_handles;
 	}
 
-	timeline_points = memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
-				      sizeof(u32) * num_points);
+	timeline_points = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
+					    num_points, sizeof(u32));
 	if (IS_ERR(timeline_points)) {
 		r = PTR_ERR(timeline_points);
 		goto free_timeline_handles;
-- 
2.34.1

