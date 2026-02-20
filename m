Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D62C55162
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 08:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3460710E799;
	Fri, 20 Feb 2026 08:28:51 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E56DC10E79A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 08:28:49 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 61K8SiLK2192376; Fri, 20 Feb 2026 13:58:44 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 61K8SiPl2192375;
 Fri, 20 Feb 2026 13:58:44 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: add upper bound check on user inputs in
 signal/wait ioctl
Date: Fri, 20 Feb 2026 13:58:40 +0530
Message-Id: <20260220082840.2192325-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220082840.2192325-1-sunil.khatri@amd.com>
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
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

There are various input arguments set by user in the signal/wait
ioctl which could be a huge value eventually leading to a OOM
condition and system crash and could be exploited.

So check these input value against AMDGPU_USERQ_MAX_HANDLES
which is big enough value and also to avoid out of memory
condition.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index a6eb703b62c4..b9810313c5ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -35,6 +35,8 @@
 static const struct dma_fence_ops amdgpu_userq_fence_ops;
 static struct kmem_cache *amdgpu_userq_fence_slab;
 
+#define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
+
 int amdgpu_userq_fence_slab_init(void)
 {
 	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
@@ -480,6 +482,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	num_syncobj_handles = args->num_syncobj_handles;
+	if (num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES)
+		return -EINVAL;
+
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
 					    num_syncobj_handles, sizeof(u32));
 	if (IS_ERR(syncobj_handles))
@@ -501,6 +506,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	num_read_bo_handles = args->num_bo_read_handles;
+	if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
+		r = -EINVAL;
+		goto free_syncobj;
+	}
+
 	bo_handles_read = memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
 					    num_read_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_read)) {
@@ -524,6 +534,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	}
 
 	num_write_bo_handles = args->num_bo_write_handles;
+	if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
+		r = -EINVAL;
+		goto put_gobj_read;
+	}
+
 	bo_handles_write = memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
 					     num_write_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_write)) {
@@ -666,12 +681,20 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 
 	num_read_bo_handles = wait_info->num_bo_read_handles;
+	if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES)
+		return -EINVAL;
+
 	bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
 					    num_read_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_read))
 		return PTR_ERR(bo_handles_read);
 
 	num_write_bo_handles = wait_info->num_bo_write_handles;
+	if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
+		r = -EINVAL;
+		goto free_bo_handles_read;
+	}
+
 	bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
 					     num_write_bo_handles, sizeof(u32));
 	if (IS_ERR(bo_handles_write)) {
@@ -680,6 +703,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	num_syncobj = wait_info->num_syncobj_handles;
+	if (num_syncobj > AMDGPU_USERQ_MAX_HANDLES) {
+		r = -EINVAL;
+		goto free_bo_handles_write;
+	}
+
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
 					    num_syncobj, sizeof(u32));
 	if (IS_ERR(syncobj_handles)) {
@@ -688,6 +716,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	}
 
 	num_points = wait_info->num_syncobj_timeline_handles;
+	if (num_points > AMDGPU_USERQ_MAX_HANDLES) {
+		r = -EINVAL;
+		goto free_syncobj_handles;
+	}
 	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
 					     num_points, sizeof(u32));
 	if (IS_ERR(timeline_handles)) {
@@ -750,6 +782,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 	}
 
+	if (wait_info->num_fences > AMDGPU_USERQ_MAX_HANDLES) {
+		r = -EINVAL;
+		goto exec_fini;
+	}
+
 	if (!wait_info->num_fences) {
 		if (num_points) {
 			struct dma_fence_unwrap iter;
-- 
2.34.1

