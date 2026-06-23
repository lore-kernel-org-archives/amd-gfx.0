Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99937CD98F2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 14:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3307710EB78;
	Tue, 23 Jun 2026 14:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XNZKFH0E";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C6CD10EB78
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2026 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5I0iLxCYSNOuz8wH4Lff6uIvGwt3Ur/7PuHu3qp7oL0=; b=XNZKFH0Epllc32x5XPfGzMqQbl
 MwTYyMutsMkWGavV8nsrt38H1+H9AJoQfdai2rFsv0JPe+ETMOkv835nO4UaKaNZpS9doiOW7DzcV
 wWJgfeSpteEGAHJ9LrB6WQNJREe2xaMNH/N3Slen1tPUk7DSfx5kO0cyx2d5254NF0D2tOyO6DFvh
 4VcfF9tp53zQNH9sbwkWO047Nzv9iPG2zJ4oFnQK03+iambJ6WEop+SMBDztdZdhS5opkO1mpqbgq
 yqG9gOjaSjbHeHV+qTPRlUPMnqsVdq2xrXk5VQDzHgwnKKhuLx9KSe8NKB4LDPlv+tlVrKwkxCyoo
 gkpv7FUA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc1sa-004DCW-4n; Tue, 23 Jun 2026 16:13:32 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, David Francis <David.Francis@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC v2 4/4] drm/amdgpu: Add driver managed buffer copy
Date: Tue, 23 Jun 2026 15:12:57 +0100
Message-ID: <20260623141257.66086-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
References: <20260623141257.66086-1-tvrtko.ursulin@igalia.com>
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

Saving and restoring buffer object content poses a challenge for the
checkpoint and restore process for at least two reasons.

For example not all objects can be exported as dma-buf to enable copying
from a separate client context, neither can any objects be easily copied
from the same context since the injected CRIU code is unaware of the GPU
virtual memory free and allocated ranges.

Lets bypass both problems by simply exposing access to the alrady present
fast kernel copy via a new DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER ioctl.

By giving the kernel simply the source and destination handles it is able
to copy them without the need for objects to be mapped, or shared with a
separate client.

For now this is implemented fully synchronous but can easily be extended
for more parallelsim.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 104 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  14 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   7 ++
 include/uapi/drm/amdgpu_drm.h           |  16 ++++
 6 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f61f0ddd3ccf..993f38d70086 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3077,6 +3077,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_CONTEXTS, amdgpu_gem_list_contexts_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_COPY_BUFFER, amdgpu_gem_copy_buffer_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e75026aba874..ccc0ecfe6603 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -32,6 +32,7 @@
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-unwrap.h>
+#include <linux/sync_file.h>
 #include <linux/uaccess.h>
 
 #include <drm/amdgpu_drm.h>
@@ -1234,6 +1235,109 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 	return ret;
 }
 
+/**
+ * amdgpu_gem_copy_buffer_ioctl - copy buffer object content
+ *
+ * @dev: drm device pointer
+ * @data: drm_amdgpu_gem_copy_buffer
+ * @filp: drm file pointer
+ *
+ * Returns:
+ * 0 for success, -errno for errors.
+ */
+int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *filp)
+{
+	struct amdgpu_copy_mem src_mem = {}, dst_mem = {};
+	union drm_amdgpu_gem_copy_buffer *args = data;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct drm_gem_object *src_gobj, *dst_gobj;
+	struct amdgpu_bo *src_bo, *dst_bo;
+	struct dma_fence *fence = NULL;
+	struct sync_file *sync_file;
+	struct drm_exec exec;
+	unsigned int e;
+	int r;
+
+	src_gobj = drm_gem_object_lookup(filp, args->in.src_handle);
+	if (!src_gobj)
+		return -ENOENT;
+
+	dst_gobj = drm_gem_object_lookup(filp, args->in.dst_handle);
+	if (!dst_gobj) {
+		r = -ENOENT;
+		goto err_dst;
+	}
+
+	src_bo = gem_to_amdgpu_bo(src_gobj);
+	dst_bo = gem_to_amdgpu_bo(dst_gobj);
+
+	if (amdgpu_bo_size(src_bo) < amdgpu_bo_size(dst_bo)) {
+		r = -E2BIG;
+		goto err_sizes;
+	}
+
+	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_obj(&exec, &src_bo->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto err_unlock;
+
+		r = drm_exec_prepare_obj(&exec, &dst_bo->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (r)
+			goto err_unlock;
+	}
+
+	src_mem.bo = &src_bo->tbo;
+	src_mem.mem = src_bo->tbo.resource;
+	dst_mem.bo = &dst_bo->tbo;
+	dst_mem.mem = dst_bo->tbo.resource;
+	e = atomic_inc_return(&adev->mman.next_move_entity) %
+			      adev->mman.num_move_entities;
+	r = amdgpu_ttm_copy_mem_to_mem(adev, &adev->mman.move_entities[e],
+				       &src_mem, &dst_mem,
+				       amdgpu_bo_size(src_bo),
+				       amdgpu_bo_encrypted(src_bo),
+				       dst_bo->tbo.base.resv, &fence);
+	if (r) {
+		goto err_unlock;
+	} else if (!fence) {
+		r = -ENXIO;
+		goto err_unlock;
+	}
+
+	dma_resv_add_fence(src_bo->tbo.base.resv, fence, DMA_RESV_USAGE_READ);
+	dma_resv_add_fence(dst_bo->tbo.base.resv, fence, DMA_RESV_USAGE_WRITE);
+
+	r = get_unused_fd_flags(O_CLOEXEC);
+	if (r < 0)
+		goto err_put_fence;
+
+	sync_file = sync_file_create(fence);
+	if (!sync_file) {
+		put_unused_fd(r);
+		r = -ENOMEM;
+		goto err_put_fence;
+	}
+
+	fd_install(r, sync_file->file);
+	args->out.fence_fd = r;
+	r = 0;
+
+err_put_fence:
+	dma_fence_put(fence);
+err_unlock:
+	drm_exec_fini(&exec);
+err_sizes:
+	drm_gem_object_put(dst_gobj);
+err_dst:
+	drm_gem_object_put(src_gobj);
+	return r;
+}
+
 static unsigned int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
 					   unsigned int width,
 					   unsigned int cpp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
index 0e17d9fc665f..64529680fdad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
@@ -71,6 +71,8 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *filp);
 int amdgpu_gem_list_contexts_ioctl(struct drm_device *dev, void *data,
 				   struct drm_file *filp);
+int amdgpu_gem_copy_buffer_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *filp);
 
 int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *filp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7ce9e0e194c3..fb1e4d7a87ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -294,13 +294,13 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
  *
  */
 __attribute__((nonnull))
-static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
-				      struct amdgpu_ttm_buffer_entity *entity,
-				      const struct amdgpu_copy_mem *src,
-				      const struct amdgpu_copy_mem *dst,
-				      uint64_t size, bool tmz,
-				      struct dma_resv *resv,
-				      struct dma_fence **f)
+int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
+			       struct amdgpu_ttm_buffer_entity *entity,
+			       const struct amdgpu_copy_mem *src,
+			       const struct amdgpu_copy_mem *dst,
+			       uint64_t size, bool tmz,
+			       struct dma_resv *resv,
+			       struct dma_fence **f)
 {
 	struct amdgpu_res_cursor src_mm, dst_mm;
 	struct dma_fence *fence = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index e1b3495b902f..0c3aefaca085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -284,4 +284,11 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
 				    enum dma_data_direction dir,
 				    struct sg_table *sgt);
 
+int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
+			       struct amdgpu_ttm_buffer_entity *entity,
+			       const struct amdgpu_copy_mem *src,
+			       const struct amdgpu_copy_mem *dst,
+			       uint64_t size, bool tmz,
+			       struct dma_resv *resv,
+			       struct dma_fence **f);
 #endif
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 7f5c4de7f9a5..b79c3d4c2ec2 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -59,6 +59,7 @@ extern "C" {
 #define DRM_AMDGPU_USERQ_WAIT		0x18
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_GEM_LIST_CONTEXTS	0x20
+#define DRM_AMDGPU_GEM_COPY_BUFFER	0x21
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -81,6 +82,7 @@ extern "C" {
 #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
 #define DRM_IOCTL_AMDGPU_GEM_LIST_CONTEXTS DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_CONTEXTS, struct drm_amdgpu_gem_list_contexts)
+#define DRM_IOCTL_AMDGPU_GEM_COPY_BUFFER DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_COPY_BUFFER, union drm_amdgpu_gem_copy_buffer)
 
 /**
  * DOC: memory domains
@@ -206,6 +208,20 @@ union drm_amdgpu_gem_create {
 	struct drm_amdgpu_gem_create_out	out;
 };
 
+struct drm_amdgpu_gem_copy_buffer_in {
+	__u32	src_handle;
+	__u32	dst_handle;
+};
+
+struct drm_amdgpu_gem_copy_buffer_out {
+	__u32	fence_fd;
+};
+
+union drm_amdgpu_gem_copy_buffer {
+	struct drm_amdgpu_gem_copy_buffer_in	in;
+	struct drm_amdgpu_gem_copy_buffer_out	out;
+};
+
 /** Opcode to create new residency list.  */
 #define AMDGPU_BO_LIST_OP_CREATE	0
 /** Opcode to destroy previously created residency list */
-- 
2.54.0

