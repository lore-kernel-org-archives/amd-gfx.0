Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74ABCD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 10:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62F2110E30E;
	Fri,  8 May 2026 10:39:18 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3817B10E30E
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 10:39:16 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 648AdCBu2442210; Fri, 8 May 2026 16:09:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 648AdB7Z2442209;
 Fri, 8 May 2026 16:09:11 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/userq: use drm_exec in
 amdgpu_userq_fence_read_wptr
Date: Fri,  8 May 2026 16:09:09 +0530
Message-Id: <20260508103910.2442183-1-sunil.khatri@amd.com>
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

To access the bo from vm mapping first lock the root bo and
then the object bo of the mapping to make sure both locks
are taken safely.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 55 +++++++++----------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 369914cab555..008330a0d852 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -370,51 +370,48 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_bo *bo;
+	struct drm_exec exec;
 	u64 addr, *ptr;
-	int r;
-
-	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
-	if (r)
-		return r;
+	int ret;
 
 	addr = queue->userq_prop->wptr_gpu_addr;
 	addr &= AMDGPU_GMC_HOLE_MASK;
 
-	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
-	if (!mapping) {
-		amdgpu_bo_unreserve(queue->vm->root.bo);
-		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
-		return -EINVAL;
-	}
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(queue->vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto lock_error;
 
-	bo = amdgpu_bo_ref(mapping->bo_va->base.bo);
-	amdgpu_bo_unreserve(queue->vm->root.bo);
-	r = amdgpu_bo_reserve(bo, true);
-	if (r) {
-		amdgpu_bo_unref(&bo);
-		DRM_ERROR("Failed to reserve userqueue wptr bo");
-		return r;
+		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
+		if (!mapping) {
+			ret = -EINVAL;
+			goto lock_error;
+		}
+
+		ret = drm_exec_lock_obj(&exec, &mapping->bo_va->base.bo->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto lock_error;
 	}
 
-	r = amdgpu_bo_kmap(bo, (void **)&ptr);
-	if (r) {
+	bo = mapping->bo_va->base.bo;
+	ret = amdgpu_bo_kmap(bo, (void **)&ptr);
+	if (ret) {
 		DRM_ERROR("Failed mapping the userqueue wptr bo");
-		goto map_error;
+		goto lock_error;
 	}
 
 	*wptr = le64_to_cpu(*ptr);
 
 	amdgpu_bo_kunmap(bo);
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
-
+	drm_exec_fini(&exec);
 	return 0;
 
-map_error:
-	amdgpu_bo_unreserve(bo);
-	amdgpu_bo_unref(&bo);
-
-	return r;
+lock_error:
+	drm_exec_fini(&exec);
+	return ret;
 }
 
 static void
-- 
2.34.1

