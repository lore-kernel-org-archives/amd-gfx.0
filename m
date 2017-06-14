From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: upsteam find bo api
Date: Wed, 14 Jun 2017 18:16:24 +0800
Message-ID: <59410CF8.9080409@amd.com>
References: <20170613201205.21138-1-nhaehnle@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040809040004090605030009"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170613201205.21138-1-nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------040809040004090605030009
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Since patches are one feature, and contain kernel and libdrm, I attached 
them not by send-mail. Hope not inconvenience.

0001-drm-amdgpu-return-bo-itself-if-userptr-is-cpu-addr-o.patch is 
kernel patch.
Other three is libdrm patches including unit test.

please review.

Regards,
David Zhou

--------------040809040004090605030009
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-return-bo-itself-if-userptr-is-cpu-addr-o.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename*0="0001-drm-amdgpu-return-bo-itself-if-userptr-is-cpu-addr-o.pa";
	filename*1="tch"

>From a388eeb1b1f59db55743407989d539bc3d546b82 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 25 Nov 2015 18:09:10 +0800
Subject: [PATCH] drm/amdgpu: return bo itself if userptr is cpu addr of bo V2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

V2: get original gem handle from gobj

Change-Id: I705eadfe03cd85c75bff252563d69f3c8a536868
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 59 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +-
 include/uapi/drm/amdgpu_drm.h           | 12 +++++++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 063fc73..c393c99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1389,6 +1389,8 @@ int amdgpu_gem_info_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp);
 int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *filp);
+int amdgpu_gem_find_bo_by_cpu_mapping_ioctl(struct drm_device *dev, void *data,
+					    struct drm_file *filp);
 int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *filp);
 int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 621f739..85152f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -284,6 +284,65 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	return 0;
 }
 
+static int amdgpu_gem_get_handle_from_object(struct drm_file *filp,
+					     struct drm_gem_object *obj)
+{
+	int i;
+	struct drm_gem_object *tmp;
+	spin_lock(&filp->table_lock);
+	idr_for_each_entry(&filp->object_idr, tmp, i) {
+		if (obj == tmp) {
+			drm_gem_object_reference(obj);
+			spin_unlock(&filp->table_lock);
+			return i;
+		}
+	}
+	spin_unlock(&filp->table_lock);
+	return 0;
+}
+
+
+int amdgpu_gem_find_bo_by_cpu_mapping_ioctl(struct drm_device *dev, void *data,
+					    struct drm_file *filp)
+{
+	struct drm_amdgpu_gem_find_bo *args = data;
+	struct drm_gem_object *gobj;
+	struct amdgpu_bo *bo;
+	struct ttm_buffer_object *tbo;
+	struct vm_area_struct *vma;
+	uint32_t handle;
+	int r;
+
+	if (offset_in_page(args->addr | args->size))
+		return -EINVAL;
+
+	down_read(&current->mm->mmap_sem);
+	vma = find_vma(current->mm, args->addr);
+	if (!vma || vma->vm_file != filp->filp ||
+	    (args->size > (vma->vm_end - args->addr))) {
+		args->handle = 0;
+		up_read(&current->mm->mmap_sem);
+		return -EINVAL;
+	}
+	tbo = vma->vm_private_data;
+	bo = container_of(tbo, struct amdgpu_bo, tbo);
+	amdgpu_bo_ref(bo);
+	gobj = &bo->gem_base;
+	handle = amdgpu_gem_get_handle_from_object(filp, gobj);
+	if (handle == 0) {
+		r = drm_gem_handle_create(filp, gobj, &handle);
+		if (r) {
+			DRM_ERROR("create gem handle failed\n");
+			up_read(&current->mm->mmap_sem);
+			return r;
+		}
+	}
+	args->handle = handle;
+	args->offset = args->addr - vma->vm_start;
+	up_read(&current->mm->mmap_sem);
+	return 0;
+}
+
 int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *filp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f68ced6..37c60a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1069,7 +1069,8 @@ int amdgpu_get_vblank_timestamp_kms(struct drm_device *dev, unsigned int pipe,
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_freesync_ioctl, DRM_MASTER)
+	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_freesync_ioctl, DRM_MASTER),
+	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_FIND_BO, amdgpu_gem_find_bo_by_cpu_mapping_ioctl, DRM_AUTH|DRM_RENDER_ALLOW)
 };
 const int amdgpu_max_kms_ioctl = ARRAY_SIZE(amdgpu_ioctls_kms);
 
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 4f34394..0cdfe7d8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -53,6 +53,7 @@
 #define DRM_AMDGPU_WAIT_FENCES		0x12
 #define DRM_AMDGPU_VM			0x13
 #define DRM_AMDGPU_FREESYNC	        0x14
+#define DRM_AMDGPU_GEM_FIND_BO		0x15
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -69,6 +70,7 @@
 #define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
 #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
 #define DRM_IOCTL_AMDGPU_FREESYNC	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FREESYNC, struct drm_amdgpu_freesync)
+#define DRM_IOCTL_AMDGPU_GEM_FIND_BO	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_FIND_BO, struct drm_amdgpu_gem_find_bo)
 
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -233,6 +235,16 @@ struct drm_amdgpu_gem_userptr {
 	__u32		handle;
 };
 
+struct drm_amdgpu_gem_find_bo {
+	uint64_t		addr;
+	uint64_t		size;
+	uint32_t		flags;
+	/* Resulting GEM handle */
+	uint32_t		handle;
+	/* offset in bo */
+	uint64_t		offset;
+};
+
 /* SI-CI-VI: */
 /* same meaning as the GB_TILE_MODE and GL_MACRO_TILE_MODE fields */
 #define AMDGPU_TILING_ARRAY_MODE_SHIFT			0
-- 
1.9.1


--------------040809040004090605030009
Content-Type: text/x-patch;
	name="0001-amdgpu-add-amdgpu_find_bo_by_cpu_mapping-interface.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename*0="0001-amdgpu-add-amdgpu_find_bo_by_cpu_mapping-interface.patc";
	filename*1="h"

>From 108cdd7f8685521481a01db91433a5dcc938687d Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 26 Nov 2015 17:01:07 +0800
Subject: [PATCH] amdgpu: add amdgpu_find_bo_by_cpu_mapping interface
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

userspace needs to know if the user memory is from BO or malloc.

Change-Id: Ie2dbc13f1c02bc0a996f64f9db83a21da63c1d70
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 amdgpu/amdgpu.h          | 24 ++++++++++++++++++++++++
 amdgpu/amdgpu_bo.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/drm/amdgpu_drm.h | 12 ++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index d4edb3e..8482032 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -672,6 +672,30 @@ int amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,
 				    amdgpu_bo_handle *buf_handle);
 
 /**
+ * Validate if the user memory comes from BO
+ *
+ * \param dev - [in] Device handle. See #amdgpu_device_initialize()
+ * \param cpu - [in] CPU address of user allocated memory which we
+ * want to map to GPU address space (make GPU accessible)
+ * (This address must be correctly aligned).
+ * \param size - [in] Size of allocation (must be correctly aligned)
+ * \param buf_handle - [out] Buffer handle for the userptr memory
+ * if the user memory is not from BO, the buf_handle will be NULL.
+ * \param offset_in_bo - [out] offset in this BO for this user memory
+ *
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_find_bo_by_cpu_mapping(amdgpu_device_handle dev,
+				  void *cpu,
+				  uint64_t size,
+				  amdgpu_bo_handle *buf_handle,
+				  uint64_t *offset_in_bo);
+
+
+/**
  * Free previosuly allocated memory
  *
  * \param   dev	       - \c [in] Device handle. See #amdgpu_device_initialize()
diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
index d30fd1e..ff78039 100644
--- a/amdgpu/amdgpu_bo.c
+++ b/amdgpu/amdgpu_bo.c
@@ -529,6 +529,43 @@ int amdgpu_bo_wait_for_idle(amdgpu_bo_handle bo,
 	}
 }
 
+int amdgpu_find_bo_by_cpu_mapping(amdgpu_device_handle dev,
+				  void *cpu,
+				  uint64_t size,
+				  amdgpu_bo_handle *buf_handle,
+				  uint64_t *offset_in_bo)
+{
+	int r;
+	struct amdgpu_bo *bo;
+	struct drm_amdgpu_gem_find_bo args;
+
+	args.addr = (uintptr_t)cpu;
+	args.size = size;
+	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_GEM_FIND_BO,
+				&args, sizeof(args));
+	if (r)
+		return r;
+	if (args.handle == 0)
+		return -EINVAL;
+	bo = util_hash_table_get(dev->bo_handles,
+				 (void*)(uintptr_t)args.handle);
+	if (!bo) {
+		bo = calloc(1, sizeof(struct amdgpu_bo));
+		if (!bo)
+			return -ENOMEM;
+		atomic_set(&bo->refcount, 1);
+		bo->dev = dev;
+		bo->alloc_size = size;
+		bo->handle = args.handle;
+	} else
+		atomic_inc(&bo->refcount);
+
+	*buf_handle = bo;
+	*offset_in_bo = args.offset;
+	return r;
+}
+
+
 int amdgpu_create_bo_from_user_mem(amdgpu_device_handle dev,
 				    void *cpu,
 				    uint64_t size,
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
index 050e7fe..e07904c 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -47,6 +47,7 @@
 #define DRM_AMDGPU_GEM_OP		0x10
 #define DRM_AMDGPU_GEM_USERPTR		0x11
 #define DRM_AMDGPU_WAIT_FENCES		0x12
+#define DRM_AMDGPU_GEM_FIND_BO          0x15
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -61,6 +62,7 @@
 #define DRM_IOCTL_AMDGPU_GEM_OP		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_OP, struct drm_amdgpu_gem_op)
 #define DRM_IOCTL_AMDGPU_GEM_USERPTR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_USERPTR, struct drm_amdgpu_gem_userptr)
 #define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
+#define DRM_IOCTL_AMDGPU_GEM_FIND_BO      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_FIND_BO, struct drm_amdgpu_gem_find_bo)
 
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -201,6 +203,16 @@ struct drm_amdgpu_gem_userptr {
 	uint32_t		handle;
 };
 
+struct drm_amdgpu_gem_find_bo {
+       uint64_t                addr;
+       uint64_t                size;
+       uint32_t                flags;
+       /* Resulting GEM handle */
+       uint32_t                handle;
+       /* offset in bo */
+       uint64_t                offset;
+};
+
 /* same meaning as the GB_TILE_MODE and GL_MACRO_TILE_MODE fields */
 #define AMDGPU_TILING_ARRAY_MODE_SHIFT			0
 #define AMDGPU_TILING_ARRAY_MODE_MASK			0xf
-- 
1.9.1


--------------040809040004090605030009
Content-Type: text/x-patch;
	name="0001-amdgpu-add-bo-handle-to-hash-table-when-cpu-mapping.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename*0="0001-amdgpu-add-bo-handle-to-hash-table-when-cpu-mapping.pat";
	filename*1="ch"

>From f953cc6627fa4928d39d3de7c0e0f6a89c1e18ec Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 3 Dec 2015 16:52:33 +0800
Subject: [PATCH] amdgpu: add bo handle to hash table when cpu mapping
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change-Id: Id79d98877c61510a1986d65befec6ce6713edae7
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Jammy Zhou <Jammy.Zhou-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 amdgpu/amdgpu_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu_bo.c b/amdgpu/amdgpu_bo.c
index ff78039..aa0d001 100644
--- a/amdgpu/amdgpu_bo.c
+++ b/amdgpu/amdgpu_bo.c
@@ -463,7 +463,7 @@ int amdgpu_bo_cpu_map(amdgpu_bo_handle bo, void **cpu)
 		pthread_mutex_unlock(&bo->cpu_access_mutex);
 		return -errno;
 	}
-
+	amdgpu_add_handle_to_table(bo);
 	bo->cpu_ptr = ptr;
 	bo->cpu_map_count = 1;
 	pthread_mutex_unlock(&bo->cpu_access_mutex);
-- 
1.9.1


--------------040809040004090605030009
Content-Type: text/x-patch;
	name="0001-amdgpu-add-find-bo-api-unit-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-amdgpu-add-find-bo-api-unit-test.patch"

>From e08a265eeaf810d20c672c3e26f1c127b83debe9 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 14 Jun 2017 18:09:23 +0800
Subject: [PATCH] amdgpu: add find bo api unit test

Change-Id: Icb67469b1c9bf6a132d1d412b551ec413dce48d9
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
---
 tests/amdgpu/basic_tests.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c
index ec1944a..b1ba369 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -49,6 +49,7 @@ static void amdgpu_command_submission_compute(void);
 static void amdgpu_command_submission_sdma(void);
 static void amdgpu_command_submission_multi_fence(void);
 static void amdgpu_userptr_test(void);
+static void amdgpu_find_bo_test(void);
 static void amdgpu_semaphore_test(void);
 static void amdgpu_svm_test(void);
 static void amdgpu_multi_svm_test(void);
@@ -62,6 +63,7 @@ CU_TestInfo basic_tests[] = {
 	{ "Query Info Test",  amdgpu_query_info_test },
 	{ "Memory alloc Test",  amdgpu_memory_alloc },
 	{ "Userptr Test",  amdgpu_userptr_test },
+	{ "Find bo Test",  amdgpu_find_bo_test },
 	{ "Command submission Test (GFX)",  amdgpu_command_submission_gfx },
 	{ "Command submission Test (Compute)", amdgpu_command_submission_compute },
 	{ "Command submission Test (SDMA)", amdgpu_command_submission_sdma },
@@ -1591,6 +1593,28 @@ static void amdgpu_userptr_test(void)
 	CU_ASSERT_EQUAL(r, 0);
 }
 
+static void amdgpu_find_bo_test(void)
+{
+	amdgpu_bo_handle bo_handle, bo_handle1;
+	void *cpu_addr;
+	uint64_t mc_address, offset_in_bo;
+	amdgpu_va_handle va_handle;
+	int r;
+
+	r = amdgpu_bo_alloc_and_map(device_handle, 4096, 4096,
+				    AMDGPU_GEM_DOMAIN_GTT, 0,
+				    &bo_handle, &cpu_addr,
+				    &mc_address, &va_handle);
+	CU_ASSERT_EQUAL(r, 0);
+
+	r = amdgpu_find_bo_by_cpu_mapping(device_handle,
+					  cpu_addr,
+					  4096,
+					  &bo_handle1, &offset_in_bo);
+	CU_ASSERT_EQUAL(r, 0);
+	CU_ASSERT_EQUAL(bo_handle, bo_handle1);
+}
+
 static void amdgpu_svm_test(void)
 {
 	int r;
-- 
1.9.1


--------------040809040004090605030009
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------040809040004090605030009--
