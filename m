From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Shared semaphores for amdgpu
Date: Thu, 9 Mar 2017 15:00:22 +0800
Message-ID: <58C0FD86.8040808@amd.com>
References: <544E607D03B20249AA404517E498FC469A558B@exchange01.valvesoftware.com>
 <BN4PR12MB0787AE3A185BE4D6916CE42AEE600@BN4PR12MB0787.namprd12.prod.outlook.com>
 <a25fdfeb-be5d-2d23-d7b1-ef14891ba6d5@gmail.com>
 <CAPM=9txG2KEw7AH553uFtuvoGYFK1=kmkPRJEHuA=8fq_JcY=w@mail.gmail.com>
 <58B4D68E.5080606@amd.com>
 <CAPM=9tw3nbGe+gaOpoBZeXfmS5+C3R4eK=uT8AL3krL0PMR0LA@mail.gmail.com>
 <CAPM=9twMvVoKCCmQUVsB6uD18j1e9cNq9eNqviVFy6F8v7OdOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040601090507040301020506"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9twMvVoKCCmQUVsB6uD18j1e9cNq9eNqviVFy6F8v7OdOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>, Andres Rodriguez <andresr-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>, Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Airlie <airlied-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Cui,
 Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Pierre-Loup Griffais <pgriffais-38hxoXRICFZx67MzidHQgQC/G2K4zDHf@public.gmane.org>

--------------040601090507040301020506
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dave,

We have already completed implementation as the attached for both kernel 
and libdrm. We discuss it on top of this.


Thanks,
David Zhou

On 2017年03月09日 12:24, Dave Airlie wrote:
> I've attached two patches for RFC at the moment, I haven't finished
> the userspace for these yet, but just wanted to get some
> ideas/feedback.
>
> Dave.
>
> On 9 March 2017 at 13:52, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On 28 February 2017 at 11:46, zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org> wrote:
>>> Hi Dave,
>>>
>>> The attached is our semaphore implementation, amdgpu_cs.c is drm file, the
>>> others are kernel file.
>>> Any suggestion?
>> Thanks,
>>
>> I've built a tree with all these in it, and started looking into the interface.
>>
>> I do wonder if we need the separate sem signal/wait interface, I think
>> we should just add
>> semaphore chunks to the CS interface.
>>
>> I'm just playing around with this now.
>>
>> Dave.


--------------040601090507040301020506
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-add-new-semaphore-object-in-kernel-side-V.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-drm-amdgpu-add-new-semaphore-object-in-kernel-side-V.pa";
	filename*1="tch"

>From 030ab323340d5557cd0ccf07d41f932b762745ac Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 23 Sep 2016 10:22:22 +0800
Subject: [PATCH] drm/amdgpu: add new semaphore object in kernel side V3

So that semaphore can be shared across porcess across devices.

V2: add import/export
V3: some bug fixes

Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org> (v1, v3)
Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org> (v2)
Reviewed-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org> (v1)
Acked-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org> (v2)
Reviewed-by: David Mao <David.Mao-5C7GfCeVMHo@public.gmane.org> (v3)

Change-Id: I88e2168328d005a42b41eb7b0c60530a92126829
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c | 444 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h |  50 ++++
 include/uapi/drm/amdgpu_drm.h           |  32 +++
 8 files changed, 555 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8870e2e..0075287 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -30,7 +30,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
 	amdgpu_prime.o amdgpu_vm.o amdgpu_ib.o amdgpu_pll.o \
 	amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
-	amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o
+	amdgpu_gtt_mgr.o amdgpu_vram_mgr.o amdgpu_virt.o amdgpu_sem.o
 
 # add asic specific block
 amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o kv_smc.o kv_dpm.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4435b36..d3b1593 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -56,6 +56,7 @@
 #include "amdgpu_sync.h"
 #include "amdgpu_ring.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_sem.h"
 #include "amd_powerplay.h"
 #include "amdgpu_dpm.h"
 #include "amdgpu_acp.h"
@@ -665,6 +666,8 @@ struct amdgpu_ctx_ring {
 	uint64_t		sequence;
 	struct fence		**fences;
 	struct amd_sched_entity	entity;
+	struct list_head	sem_list;
+	struct mutex            sem_lock;
 };
 
 struct amdgpu_ctx {
@@ -708,6 +711,8 @@ struct amdgpu_fpriv {
 	struct mutex		bo_list_lock;
 	struct idr		bo_list_handles;
 	struct amdgpu_ctx_mgr	ctx_mgr;
+	spinlock_t		sem_handles_lock;
+	struct idr		sem_handles;
 };
 
 /*
@@ -1243,6 +1248,14 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
 int amdgpu_freesync_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp);
 
+int amdgpu_sem_ioctl(struct drm_device *dev, void *data,
+		     struct drm_file *filp);
+
+int amdgpu_sem_add_cs(struct amdgpu_ctx *ctx, struct amdgpu_ring *ring,
+		      struct amdgpu_sync *sync);
+
+void amdgpu_sem_destroy(struct amdgpu_fpriv *fpriv, u32 handle);
+
 /* VRAM scratch page for HDP bug, default vram page */
 struct amdgpu_vram_scratch {
 	struct amdgpu_bo		*robj;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index aafe11e..92b1423 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1024,7 +1024,7 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 		}
 	}
 
-	return 0;
+	return amdgpu_sem_add_cs(p->ctx, p->job->ring, &p->job->sync);
 }
 
 static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 6d86eae..66cf23c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -42,6 +42,8 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev, struct amdgpu_ctx *ctx)
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 		ctx->rings[i].sequence = 1;
 		ctx->rings[i].fences = &ctx->fences[amdgpu_sched_jobs * i];
+		INIT_LIST_HEAD(&ctx->rings[i].sem_list);
+		mutex_init(&ctx->rings[i].sem_lock);
 	}
 
 	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
@@ -78,8 +80,10 @@ static void amdgpu_ctx_fini(struct amdgpu_ctx *ctx)
 		return;
 
 	for (i = 0; i < AMDGPU_MAX_RINGS; ++i)
-		for (j = 0; j < amdgpu_sched_jobs; ++j)
+		for (j = 0; j < amdgpu_sched_jobs; ++j) {
 			fence_put(ctx->rings[i].fences[j]);
+			mutex_destroy(&ctx->rings[i].sem_lock);
+		}
 	kfree(ctx->fences);
 	ctx->fences = NULL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ee3720e..b973225 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -749,6 +749,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init(&fpriv->bo_list_handles);
+	spin_lock_init(&fpriv->sem_handles_lock);
+	idr_init(&fpriv->sem_handles);
 
 	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
 
@@ -775,6 +777,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	struct amdgpu_device *adev = dev->dev_private;
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
 	struct amdgpu_bo_list *list;
+	struct amdgpu_sem *sem;
 	int handle;
 
 	if (!fpriv)
@@ -803,6 +806,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	idr_destroy(&fpriv->bo_list_handles);
 	mutex_destroy(&fpriv->bo_list_lock);
 
+	idr_for_each_entry(&fpriv->sem_handles, sem, handle)
+		amdgpu_sem_destroy(fpriv, handle);
+	idr_destroy(&fpriv->sem_handles);
+
 	kfree(fpriv);
 	file_priv->driver_priv = NULL;
 
@@ -984,7 +991,8 @@ int amdgpu_get_vblank_timestamp_kms(struct drm_device *dev, unsigned int pipe,
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
-	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_freesync_ioctl, DRM_MASTER)
+	DRM_IOCTL_DEF_DRV(AMDGPU_FREESYNC, amdgpu_freesync_ioctl, DRM_MASTER),
+	DRM_IOCTL_DEF_DRV(AMDGPU_SEM, amdgpu_sem_ioctl, DRM_AUTH|DRM_UNLOCKED|DRM_RENDER_ALLOW),
 };
 const int amdgpu_max_kms_ioctl = ARRAY_SIZE(amdgpu_ioctls_kms);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c
new file mode 100644
index 0000000..6681162
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.c
@@ -0,0 +1,444 @@
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
+ */
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
+#include <linux/poll.h>
+#include <linux/seq_file.h>
+#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/anon_inodes.h>
+#include "amdgpu_sem.h"
+#include "amdgpu.h"
+#include <drm/drmP.h>
+
+static int amdgpu_sem_cring_add(struct amdgpu_fpriv *fpriv,
+				struct drm_amdgpu_sem_in *in,
+				struct amdgpu_sem *sem);
+
+static void amdgpu_sem_core_free(struct kref *kref)
+{
+	struct amdgpu_sem_core *core = container_of(
+		kref, struct amdgpu_sem_core, kref);
+
+	fence_put(core->fence);
+	mutex_destroy(&core->lock);
+	kfree(core);
+}
+
+static void amdgpu_sem_free(struct kref *kref)
+{
+	struct amdgpu_sem *sem = container_of(
+		kref, struct amdgpu_sem, kref);
+
+	list_del(&sem->list);
+	kref_put(&sem->base->kref, amdgpu_sem_core_free);
+	kfree(sem);
+}
+
+static inline void amdgpu_sem_get(struct amdgpu_sem *sem)
+{
+	if (sem)
+		kref_get(&sem->kref);
+}
+
+static inline void amdgpu_sem_put(struct amdgpu_sem *sem)
+{
+	if (sem)
+		kref_put(&sem->kref, amdgpu_sem_free);
+}
+
+static int amdgpu_sem_release(struct inode *inode, struct file *file)
+{
+	struct amdgpu_sem_core *core = file->private_data;
+
+	kref_put(&core->kref, amdgpu_sem_core_free);
+	return 0;
+}
+
+static unsigned int amdgpu_sem_poll(struct file *file, poll_table *wait)
+{
+	return 0;
+}
+
+static long amdgpu_sem_file_ioctl(struct file *file, unsigned int cmd,
+				   unsigned long arg)
+{
+	return 0;
+}
+
+static const struct file_operations amdgpu_sem_fops = {
+	.release = amdgpu_sem_release,
+	.poll = amdgpu_sem_poll,
+	.unlocked_ioctl = amdgpu_sem_file_ioctl,
+	.compat_ioctl = amdgpu_sem_file_ioctl,
+};
+
+
+static inline struct amdgpu_sem *amdgpu_sem_lookup(struct amdgpu_fpriv *fpriv, u32 handle)
+{
+	struct amdgpu_sem *sem;
+
+	spin_lock(&fpriv->sem_handles_lock);
+
+	/* Check if we currently have a reference on the object */
+	sem = idr_find(&fpriv->sem_handles, handle);
+	amdgpu_sem_get(sem);
+
+	spin_unlock(&fpriv->sem_handles_lock);
+
+	return sem;
+}
+
+static struct amdgpu_sem_core *amdgpu_sem_core_alloc(void)
+{
+	struct amdgpu_sem_core *core;
+
+	core = kzalloc(sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return NULL;
+
+	kref_init(&core->kref);
+	mutex_init(&core->lock);
+	return core;
+}
+
+static struct amdgpu_sem *amdgpu_sem_alloc(void)
+{
+	struct amdgpu_sem *sem;
+
+	sem = kzalloc(sizeof(*sem), GFP_KERNEL);
+	if (!sem)
+		return NULL;
+
+	kref_init(&sem->kref);
+	INIT_LIST_HEAD(&sem->list);
+
+	return sem;
+}
+
+static int amdgpu_sem_create(struct amdgpu_fpriv *fpriv, u32 *handle)
+{
+	struct amdgpu_sem *sem;
+	struct amdgpu_sem_core *core;
+	int ret;
+
+	sem = amdgpu_sem_alloc();
+	core = amdgpu_sem_core_alloc();
+	if (!sem || !core) {
+		kfree(sem);
+		kfree(core);
+		return -ENOMEM;
+	}
+
+	sem->base = core;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fpriv->sem_handles_lock);
+
+	ret = idr_alloc(&fpriv->sem_handles, sem, 1, 0, GFP_NOWAIT);
+
+	spin_unlock(&fpriv->sem_handles_lock);
+	idr_preload_end();
+
+	if (ret < 0)
+		return ret;
+
+	*handle = ret;
+	return 0;
+}
+
+static int amdgpu_sem_signal(struct amdgpu_fpriv *fpriv,
+				u32 handle, struct fence *fence)
+{
+	struct amdgpu_sem *sem;
+	struct amdgpu_sem_core *core;
+
+	sem = amdgpu_sem_lookup(fpriv, handle);
+	if (!sem)
+		return -EINVAL;
+
+	core = sem->base;
+	mutex_lock(&core->lock);
+	fence_put(core->fence);
+	core->fence = fence_get(fence);
+	mutex_unlock(&core->lock);
+
+	amdgpu_sem_put(sem);
+	return 0;
+}
+
+static int amdgpu_sem_wait(struct amdgpu_fpriv *fpriv,
+			  struct drm_amdgpu_sem_in *in)
+{
+	struct amdgpu_sem *sem;
+	int ret;
+
+	sem = amdgpu_sem_lookup(fpriv, in->handle);
+	if (!sem)
+		return -EINVAL;
+
+	ret = amdgpu_sem_cring_add(fpriv, in, sem);
+	amdgpu_sem_put(sem);
+
+	return ret;
+}
+
+static int amdgpu_sem_import(struct amdgpu_fpriv *fpriv,
+				       int fd, u32 *handle)
+{
+	struct file *file = fget(fd);
+	struct amdgpu_sem *sem;
+	struct amdgpu_sem_core *core;
+	int ret;
+
+	if (!file)
+		return -EINVAL;
+
+	core = file->private_data;
+	if (!core) {
+		fput(file);
+		return -EINVAL;
+	}
+
+	kref_get(&core->kref);
+	sem = amdgpu_sem_alloc();
+	if (!sem) {
+		ret = -ENOMEM;
+		goto err_sem;
+	}
+
+	sem->base = core;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fpriv->sem_handles_lock);
+
+	ret = idr_alloc(&fpriv->sem_handles, sem, 1, 0, GFP_NOWAIT);
+
+	spin_unlock(&fpriv->sem_handles_lock);
+	idr_preload_end();
+
+	if (ret < 0)
+		goto err_out;
+
+	*handle = ret;
+	fput(file);
+	return 0;
+err_sem:
+	kref_put(&core->kref, amdgpu_sem_core_free);
+err_out:
+	amdgpu_sem_put(sem);
+	fput(file);
+	return ret;
+
+}
+
+static int amdgpu_sem_export(struct amdgpu_fpriv *fpriv,
+				       u32 handle, int *fd)
+{
+	struct amdgpu_sem *sem;
+	struct amdgpu_sem_core *core;
+	int ret;
+
+	sem = amdgpu_sem_lookup(fpriv, handle);
+	if (!sem)
+		return -EINVAL;
+
+	core = sem->base;
+	kref_get(&core->kref);
+	mutex_lock(&core->lock);
+	if (!core->file) {
+		core->file = anon_inode_getfile("sem_file",
+					       &amdgpu_sem_fops,
+					       core, 0);
+		if (IS_ERR(core->file)) {
+			mutex_unlock(&core->lock);
+			ret = -ENOMEM;
+			goto err_put_sem;
+		}
+	} else {
+		get_file(core->file);
+	}
+	mutex_unlock(&core->lock);
+
+	ret = get_unused_fd_flags(O_CLOEXEC);
+	if (ret < 0)
+		goto err_put_file;
+
+	fd_install(ret, core->file);
+
+	*fd = ret;
+	amdgpu_sem_put(sem);
+	return 0;
+
+err_put_file:
+	fput(core->file);
+err_put_sem:
+	kref_put(&core->kref, amdgpu_sem_core_free);
+	amdgpu_sem_put(sem);
+	return ret;
+}
+
+void amdgpu_sem_destroy(struct amdgpu_fpriv *fpriv, u32 handle)
+{
+	struct amdgpu_sem *sem = amdgpu_sem_lookup(fpriv, handle);
+	if (!sem)
+		return;
+
+	spin_lock(&fpriv->sem_handles_lock);
+	idr_remove(&fpriv->sem_handles, handle);
+	spin_unlock(&fpriv->sem_handles_lock);
+
+	kref_sub(&sem->kref, 2, amdgpu_sem_free);
+}
+
+static struct fence *amdgpu_sem_get_fence(struct amdgpu_fpriv *fpriv,
+					 struct drm_amdgpu_sem_in *in)
+{
+	struct amdgpu_ring *out_ring;
+	struct amdgpu_ctx *ctx;
+	struct fence *fence;
+	uint32_t ctx_id, ip_type, ip_instance, ring;
+	int r;
+
+	ctx_id = in->ctx_id;
+	ip_type = in->ip_type;
+	ip_instance = in->ip_instance;
+	ring = in->ring;
+	ctx = amdgpu_ctx_get(fpriv, ctx_id);
+	if (!ctx)
+		return NULL;
+	r = amdgpu_cs_get_ring(ctx->adev, ip_type, ip_instance, ring,
+			       &out_ring);
+	if (r) {
+		amdgpu_ctx_put(ctx);
+		return NULL;
+	}
+	/* get the last fence of this entity */
+	fence = amdgpu_ctx_get_fence(ctx, out_ring,
+				     in->seq ? in->seq :
+				     ctx->rings[out_ring->idx].sequence - 1);
+	amdgpu_ctx_put(ctx);
+
+	return fence;
+}
+
+static int amdgpu_sem_cring_add(struct amdgpu_fpriv *fpriv,
+				struct drm_amdgpu_sem_in *in,
+				struct amdgpu_sem *sem)
+{
+	struct amdgpu_ring *out_ring;
+	struct amdgpu_ctx *ctx;
+	uint32_t ctx_id, ip_type, ip_instance, ring;
+	int r;
+
+	ctx_id = in->ctx_id;
+	ip_type = in->ip_type;
+	ip_instance = in->ip_instance;
+	ring = in->ring;
+	ctx = amdgpu_ctx_get(fpriv, ctx_id);
+	if (!ctx)
+		return -EINVAL;
+	r = amdgpu_cs_get_ring(ctx->adev, ip_type, ip_instance, ring,
+			       &out_ring);
+	if (r)
+		goto err;
+	mutex_lock(&ctx->rings[out_ring->idx].sem_lock);
+	list_add(&sem->list, &ctx->rings[out_ring->idx].sem_list);
+	mutex_unlock(&ctx->rings[out_ring->idx].sem_lock);
+
+err:
+	amdgpu_ctx_put(ctx);
+	return r;
+}
+
+int amdgpu_sem_add_cs(struct amdgpu_ctx *ctx, struct amdgpu_ring *ring,
+		     struct amdgpu_sync *sync)
+{
+	struct amdgpu_sem *sem, *tmp;
+	int r = 0;
+
+	if (list_empty(&ctx->rings[ring->idx].sem_list))
+		return 0;
+
+	mutex_lock(&ctx->rings[ring->idx].sem_lock);
+	list_for_each_entry_safe(sem, tmp, &ctx->rings[ring->idx].sem_list,
+				 list) {
+		r = amdgpu_sync_fence(ctx->adev, sync, sem->base->fence);
+		if (r)
+			goto err;
+		mutex_lock(&sem->base->lock);
+		fence_put(sem->base->fence);
+		sem->base->fence = NULL;
+		mutex_unlock(&sem->base->lock);
+		list_del_init(&sem->list);
+	}
+err:
+	mutex_unlock(&ctx->rings[ring->idx].sem_lock);
+	return r;
+}
+
+int amdgpu_sem_ioctl(struct drm_device *dev, void *data,
+		     struct drm_file *filp)
+{
+	union drm_amdgpu_sem *args = data;
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct fence *fence;
+	int r = 0;
+
+	switch (args->in.op) {
+	case AMDGPU_SEM_OP_CREATE_SEM:
+		r = amdgpu_sem_create(fpriv, &args->out.handle);
+		break;
+	case AMDGPU_SEM_OP_WAIT_SEM:
+		r = amdgpu_sem_wait(fpriv, &args->in);
+		break;
+	case AMDGPU_SEM_OP_SIGNAL_SEM:
+		fence = amdgpu_sem_get_fence(fpriv, &args->in);
+		if (IS_ERR(fence)) {
+			r = PTR_ERR(fence);
+			return r;
+		}
+		r = amdgpu_sem_signal(fpriv, args->in.handle, fence);
+		fence_put(fence);
+		break;
+	case AMDGPU_SEM_OP_IMPORT_SEM:
+		r = amdgpu_sem_import(fpriv, args->in.handle, &args->out.handle);
+		break;
+	case AMDGPU_SEM_OP_EXPORT_SEM:
+		r = amdgpu_sem_export(fpriv, args->in.handle, &args->out.fd);
+		break;
+	case AMDGPU_SEM_OP_DESTROY_SEM:
+		amdgpu_sem_destroy(fpriv, args->in.handle);
+		break;
+	default:
+		r = -EINVAL;
+		break;
+	}
+
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h
new file mode 100644
index 0000000..04296ca
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sem.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
+ *
+ */
+
+
+#ifndef _LINUX_AMDGPU_SEM_H
+#define _LINUX_AMDGPU_SEM_H
+
+#include <linux/types.h>
+#include <linux/kref.h>
+#include <linux/ktime.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/fence.h>
+
+struct amdgpu_sem_core {
+	struct file		*file;
+	struct kref		kref;
+	struct fence            *fence;
+	struct mutex	lock;
+};
+
+struct amdgpu_sem {
+	struct amdgpu_sem_core	*base;
+	struct kref		kref;
+	struct list_head        list;
+};
+
+#endif /* _LINUX_AMDGPU_SEM_H */
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 49358e7..d17f431 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -53,6 +53,8 @@
 #define DRM_AMDGPU_WAIT_FENCES		0x12
 #define DRM_AMDGPU_FREESYNC	        0x14
 
+#define DRM_AMDGPU_SEM			0x5b
+
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
 #define DRM_IOCTL_AMDGPU_CTX		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_CTX, union drm_amdgpu_ctx)
@@ -67,6 +69,7 @@
 #define DRM_IOCTL_AMDGPU_GEM_USERPTR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_USERPTR, struct drm_amdgpu_gem_userptr)
 #define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
 #define DRM_IOCTL_AMDGPU_FREESYNC	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FREESYNC, struct drm_amdgpu_freesync)
+#define DRM_IOCTL_AMDGPU_SEM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SEM, union drm_amdgpu_sem)
 
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -192,6 +195,35 @@ struct drm_amdgpu_ctx_in {
 	union drm_amdgpu_ctx_out out;
 };
 
+/* sem related */
+#define AMDGPU_SEM_OP_CREATE_SEM        1
+#define AMDGPU_SEM_OP_WAIT_SEM	        2
+#define AMDGPU_SEM_OP_SIGNAL_SEM        3
+#define AMDGPU_SEM_OP_DESTROY_SEM       4
+#define AMDGPU_SEM_OP_IMPORT_SEM	5
+#define AMDGPU_SEM_OP_EXPORT_SEM	6
+
+struct drm_amdgpu_sem_in {
+	/** AMDGPU_SEM_OP_* */
+	uint32_t	op;
+	uint32_t        handle;
+	uint32_t	ctx_id;
+	uint32_t        ip_type;
+	uint32_t        ip_instance;
+	uint32_t        ring;
+	uint64_t        seq;
+};
+
+union drm_amdgpu_sem_out {
+	int32_t         fd;
+	uint32_t	handle;
+};
+
+union drm_amdgpu_sem {
+	struct drm_amdgpu_sem_in in;
+	union drm_amdgpu_sem_out out;
+};
+
 /*
  * This is not a reliable API and you should expect it to fail for any
  * number of reasons and have fallback path that do not use userptr to
-- 
1.9.1


--------------040601090507040301020506
Content-Type: text/x-patch;
	name="0001-amdgpu-add-new-semaphore-support-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-amdgpu-add-new-semaphore-support-v2.patch"

>From ec6e6f599fe61537ed42b9953126691f904626d4 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 22 Sep 2016 14:50:16 +0800
Subject: [PATCH 1/2] amdgpu: add new semaphore support v2

v2: add import/export functions.

Change-Id: I74b61611e975d6f2de051e3f3c7ba63177308bdb
Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org> (v1)
Reviewed-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org> (v1)
Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org> (v2)
Acked-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org> (v2)
---
 amdgpu/amdgpu.h          |  82 ++++++++++++++++++++++++++++-
 amdgpu/amdgpu_cs.c       | 133 +++++++++++++++++++++++++++++++++++++++++++++++
 include/drm/amdgpu_drm.h |  34 ++++++++++++
 3 files changed, 248 insertions(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu.h b/amdgpu/amdgpu.h
index 941406e..eb75283 100644
--- a/amdgpu/amdgpu.h
+++ b/amdgpu/amdgpu.h
@@ -151,6 +151,12 @@ typedef struct amdgpu_ib *amdgpu_ib_handle;
  */
 typedef struct amdgpu_va *amdgpu_va_handle;
 
+/**
+ * Define handle for sem file
+ */
+typedef uint32_t amdgpu_sem_handle;
+
+
 /*--------------------------------------------------------------------------*/
 /* -------------------------- Structures ---------------------------------- */
 /*--------------------------------------------------------------------------*/
@@ -1336,6 +1342,80 @@ int amdgpu_va_range_alloc(enum amdgpu_gpu_va_range va_range_type,
 */
 int amdgpu_va_range_free(amdgpu_va_handle va_range_handle);
 
-#endif /* #ifdef _amdgpu_h_ */
+/**
+ *  create sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_cs_create_sem(amdgpu_device_handle dev,
+			 amdgpu_sem_handle *sem);
+
+/**
+ *  signal sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   context        - \c [in] GPU Context
+ * \param   ip_type        - \c [in] Hardware IP block type = AMDGPU_HW_IP_*
+ * \param   ip_instance    - \c [in] Index of the IP block of the same type
+ * \param   ring           - \c [in] Specify ring index of the IP
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+ */
+int amdgpu_cs_signal_sem(amdgpu_device_handle dev,
+			 amdgpu_context_handle ctx,
+			 uint32_t ip_type,
+			 uint32_t ip_instance,
+			 uint32_t ring,
+			 amdgpu_sem_handle sem);
+
+/**
+ *  wait sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   context        - \c [in] GPU Context
+ * \param   ip_type        - \c [in] Hardware IP block type = AMDGPU_HW_IP_*
+ * \param   ip_instance    - \c [in] Index of the IP block of the same type
+ * \param   ring           - \c [in] Specify ring index of the IP
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+*/
+int amdgpu_cs_wait_sem(amdgpu_device_handle dev,
+		       amdgpu_context_handle ctx,
+		       uint32_t ip_type,
+		       uint32_t ip_instance,
+		       uint32_t ring,
+		       amdgpu_sem_handle sem);
+
+int amdgpu_cs_export_sem(amdgpu_device_handle dev,
+			  amdgpu_sem_handle sem,
+			  int *shared_handle);
 
+int amdgpu_cs_import_sem(amdgpu_device_handle dev,
+			  int shared_handle,
+			  amdgpu_sem_handle *sem);
 
+/**
+ *  destroy sem
+ *
+ * \param   dev    - [in] Device handle. See #amdgpu_device_initialize()
+ * \param   sem	   - \c [out] sem handle
+ *
+ * \return   0 on success\n
+ *          <0 - Negative POSIX Error code
+ *
+ */
+int amdgpu_cs_destroy_sem(amdgpu_device_handle dev,
+			  amdgpu_sem_handle sem);
+
+#endif /* #ifdef _amdgpu_h_ */
diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
index c8101b8..c8d8593 100644
--- a/amdgpu/amdgpu_cs.c
+++ b/amdgpu/amdgpu_cs.c
@@ -20,6 +20,9 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
 */
+
+#include <sys/stat.h>
+#include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -913,3 +916,133 @@ int amdgpu_cs_query_fence_status(struct amdgpu_cs_query_fence *fence,
 	return r;
 }
 
+int amdgpu_cs_create_sem(amdgpu_device_handle dev,
+			 amdgpu_sem_handle *sem)
+{
+	union drm_amdgpu_sem args;
+	int r;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_CREATE_SEM;
+	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+	if (r)
+		return r;
+
+	*sem = args.out.handle;
+
+	return 0;
+}
+
+int amdgpu_cs_signal_sem(amdgpu_device_handle dev,
+			 amdgpu_context_handle ctx,
+			 uint32_t ip_type,
+			 uint32_t ip_instance,
+			 uint32_t ring,
+			 amdgpu_sem_handle sem)
+{
+	union drm_amdgpu_sem args;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_SIGNAL_SEM;
+	args.in.ctx_id = ctx->id;
+	args.in.ip_type = ip_type;
+	args.in.ip_instance = ip_instance;
+	args.in.ring = ring;
+	args.in.handle = sem;
+	return drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+}
+
+int amdgpu_cs_wait_sem(amdgpu_device_handle dev,
+		       amdgpu_context_handle ctx,
+		       uint32_t ip_type,
+		       uint32_t ip_instance,
+		       uint32_t ring,
+		       amdgpu_sem_handle sem)
+{
+	union drm_amdgpu_sem args;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_WAIT_SEM;
+	args.in.ctx_id = ctx->id;
+	args.in.ip_type = ip_type;
+	args.in.ip_instance = ip_instance;
+	args.in.ring = ring;
+	args.in.handle = sem;
+	args.in.seq = 0;
+	return drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+}
+
+int amdgpu_cs_export_sem(amdgpu_device_handle dev,
+			  amdgpu_sem_handle sem,
+			  int *shared_handle)
+{
+	union drm_amdgpu_sem args;
+	int r;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_EXPORT_SEM;
+	args.in.handle = sem;
+	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+	if (r)
+		return r;
+	*shared_handle = args.out.fd;
+	return 0;
+}
+
+int amdgpu_cs_import_sem(amdgpu_device_handle dev,
+			  int shared_handle,
+			  amdgpu_sem_handle *sem)
+{
+	union drm_amdgpu_sem args;
+	int r;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_IMPORT_SEM;
+	args.in.handle = shared_handle;
+	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+	if (r)
+		return r;
+	*sem = args.out.handle;
+	return 0;
+}
+
+
+int amdgpu_cs_destroy_sem(amdgpu_device_handle dev,
+			  amdgpu_sem_handle sem)
+{
+	union drm_amdgpu_sem args;
+	int r;
+
+	if (NULL == dev)
+		return -EINVAL;
+
+	/* Create the context */
+	memset(&args, 0, sizeof(args));
+	args.in.op = AMDGPU_SEM_OP_DESTROY_SEM;
+	args.in.handle = sem;
+	r = drmCommandWriteRead(dev->fd, DRM_AMDGPU_SEM, &args, sizeof(args));
+	if (r)
+		return r;
+
+	return 0;
+}
diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
index 89a938a..ccd9033 100644
--- a/include/drm/amdgpu_drm.h
+++ b/include/drm/amdgpu_drm.h
@@ -46,6 +46,9 @@
 #define DRM_AMDGPU_WAIT_CS		0x09
 #define DRM_AMDGPU_GEM_OP		0x10
 #define DRM_AMDGPU_GEM_USERPTR		0x11
+#define DRM_AMDGPU_WAIT_FENCES		0x12
+
+#define DRM_AMDGPU_SEM                  0x5b
 
 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
 #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
@@ -59,6 +62,8 @@
 #define DRM_IOCTL_AMDGPU_WAIT_CS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_CS, union drm_amdgpu_wait_cs)
 #define DRM_IOCTL_AMDGPU_GEM_OP		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_OP, struct drm_amdgpu_gem_op)
 #define DRM_IOCTL_AMDGPU_GEM_USERPTR	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_USERPTR, struct drm_amdgpu_gem_userptr)
+#define DRM_IOCTL_AMDGPU_WAIT_FENCES	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_WAIT_FENCES, union drm_amdgpu_wait_fences)
+#define DRM_IOCTL_AMDGPU_SEM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_SEM, union drm_amdgpu_sem)
 
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -182,6 +187,35 @@ union drm_amdgpu_ctx {
 	union drm_amdgpu_ctx_out out;
 };
 
+/* sync file related */
+#define AMDGPU_SEM_OP_CREATE_SEM       1
+#define AMDGPU_SEM_OP_WAIT_SEM         2
+#define AMDGPU_SEM_OP_SIGNAL_SEM       3
+#define AMDGPU_SEM_OP_DESTROY_SEM      4
+#define AMDGPU_SEM_OP_IMPORT_SEM       5
+#define AMDGPU_SEM_OP_EXPORT_SEM       6
+
+struct drm_amdgpu_sem_in {
+	/** AMDGPU_SEM_OP_* */
+	uint32_t        op;
+	uint32_t        handle;
+	uint32_t        ctx_id;
+	uint32_t        ip_type;
+	uint32_t        ip_instance;
+	uint32_t        ring;
+	uint64_t        seq;
+};
+
+union drm_amdgpu_sem_out {
+	int            fd;
+	uint32_t        handle;
+};
+
+union drm_amdgpu_sem {
+	struct drm_amdgpu_sem_in in;
+	union drm_amdgpu_sem_out out;
+};
+
 /*
  * This is not a reliable API and you should expect it to fail for any
  * number of reasons and have fallback path that do not use userptr to
-- 
1.9.1


--------------040601090507040301020506
Content-Type: text/x-patch;
	name="0002-test-case-for-export-import-sem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0002-test-case-for-export-import-sem.patch"

>From 1d391323c06c03a90b1d349f8a8c79a29af8fc90 Mon Sep 17 00:00:00 2001
From: David Mao <david.mao-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 23 Jan 2017 11:31:58 +0800
Subject: [PATCH 2/2] test case for export/import sem

Test covers basic functionality includes create/destroy/import/export/wait/signal

Change-Id: I8a8d767e5ef1889f8ac214fef98befba83969d8d
Signed-off-by: David Mao <david.mao-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Acked-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 tests/amdgpu/basic_tests.c | 190 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/tests/amdgpu/basic_tests.c b/tests/amdgpu/basic_tests.c
index 0083968..5a95ec9 100644
--- a/tests/amdgpu/basic_tests.c
+++ b/tests/amdgpu/basic_tests.c
@@ -214,6 +214,196 @@ static void amdgpu_command_submission_gfx(void)
 	CU_ASSERT_EQUAL(r, 0);
 }
 
+static void amdgpu_semaphore_test(void)
+{
+	amdgpu_context_handle context_handle[2];
+	amdgpu_semaphore_handle sem;
+	amdgpu_bo_handle ib_result_handle[2];
+	void *ib_result_cpu[2];
+	uint64_t ib_result_mc_address[2];
+	struct amdgpu_cs_request ibs_request[2] = {0};
+	struct amdgpu_cs_ib_info ib_info[2] = {0};
+	struct amdgpu_cs_fence fence_status = {0};
+	uint32_t *ptr;
+	uint32_t expired;
+	amdgpu_bo_list_handle bo_list[2];
+	amdgpu_va_handle va_handle[2];
+	amdgpu_sem_handle sem_handle, sem_handle_import;
+	int fd;
+	int r, i;
+
+	r = amdgpu_cs_create_semaphore(&sem);
+	CU_ASSERT_EQUAL(r, 0);
+	for (i = 0; i < 2; i++) {
+		r = amdgpu_cs_ctx_create(device_handle, &context_handle[i]);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_bo_alloc_and_map(device_handle, 4096, 4096,
+					    AMDGPU_GEM_DOMAIN_GTT, 0,
+					    &ib_result_handle[i], &ib_result_cpu[i],
+					    &ib_result_mc_address[i], &va_handle[i]);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_get_bo_list(device_handle, ib_result_handle[i],
+				       NULL, &bo_list[i]);
+		CU_ASSERT_EQUAL(r, 0);
+	}
+
+	/* 1. same context different engine */
+	ptr = ib_result_cpu[0];
+	ptr[0] = SDMA_NOP;
+	ib_info[0].ib_mc_address = ib_result_mc_address[0];
+	ib_info[0].size = 1;
+
+	ibs_request[0].ip_type = AMDGPU_HW_IP_DMA;
+	ibs_request[0].number_of_ibs = 1;
+	ibs_request[0].ibs = &ib_info[0];
+	ibs_request[0].resources = bo_list[0];
+	ibs_request[0].fence_info.handle = NULL;
+	r = amdgpu_cs_submit(context_handle[0], 0,&ibs_request[0], 1);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_cs_signal_semaphore(context_handle[0], AMDGPU_HW_IP_DMA, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+
+	r = amdgpu_cs_wait_semaphore(context_handle[0], AMDGPU_HW_IP_GFX, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+	ptr = ib_result_cpu[1];
+	ptr[0] = GFX_COMPUTE_NOP;
+	ib_info[1].ib_mc_address = ib_result_mc_address[1];
+	ib_info[1].size = 1;
+
+	ibs_request[1].ip_type = AMDGPU_HW_IP_GFX;
+	ibs_request[1].number_of_ibs = 1;
+	ibs_request[1].ibs = &ib_info[1];
+	ibs_request[1].resources = bo_list[1];
+	ibs_request[1].fence_info.handle = NULL;
+
+	r = amdgpu_cs_submit(context_handle[0], 0,&ibs_request[1], 1);
+	CU_ASSERT_EQUAL(r, 0);
+
+	fence_status.context = context_handle[0];
+	fence_status.ip_type = AMDGPU_HW_IP_GFX;
+	fence_status.ip_instance = 0;
+	fence_status.fence = ibs_request[1].seq_no;
+	r = amdgpu_cs_query_fence_status(&fence_status,
+					 500000000, 0, &expired);
+	CU_ASSERT_EQUAL(r, 0);
+	CU_ASSERT_EQUAL(expired, true);
+
+	/* 2. same engine different context */
+	ptr = ib_result_cpu[0];
+	ptr[0] = GFX_COMPUTE_NOP;
+	ib_info[0].ib_mc_address = ib_result_mc_address[0];
+	ib_info[0].size = 1;
+
+	ibs_request[0].ip_type = AMDGPU_HW_IP_GFX;
+	ibs_request[0].number_of_ibs = 1;
+	ibs_request[0].ibs = &ib_info[0];
+	ibs_request[0].resources = bo_list[0];
+	ibs_request[0].fence_info.handle = NULL;
+	r = amdgpu_cs_submit(context_handle[0], 0,&ibs_request[0], 1);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_cs_signal_semaphore(context_handle[0], AMDGPU_HW_IP_GFX, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+
+	r = amdgpu_cs_wait_semaphore(context_handle[1], AMDGPU_HW_IP_GFX, 0, 0, sem);
+	CU_ASSERT_EQUAL(r, 0);
+	ptr = ib_result_cpu[1];
+	ptr[0] = GFX_COMPUTE_NOP;
+	ib_info[1].ib_mc_address = ib_result_mc_address[1];
+	ib_info[1].size = 1;
+
+	ibs_request[1].ip_type = AMDGPU_HW_IP_GFX;
+	ibs_request[1].number_of_ibs = 1;
+	ibs_request[1].ibs = &ib_info[1];
+	ibs_request[1].resources = bo_list[1];
+	ibs_request[1].fence_info.handle = NULL;
+	r = amdgpu_cs_submit(context_handle[1], 0,&ibs_request[1], 1);
+
+	CU_ASSERT_EQUAL(r, 0);
+
+	fence_status.context = context_handle[1];
+	fence_status.ip_type = AMDGPU_HW_IP_GFX;
+	fence_status.ip_instance = 0;
+	fence_status.fence = ibs_request[1].seq_no;
+	r = amdgpu_cs_query_fence_status(&fence_status,
+					 500000000, 0, &expired);
+	CU_ASSERT_EQUAL(r, 0);
+	CU_ASSERT_EQUAL(expired, true);
+
+	/* 3. export/import sem test */
+	r = amdgpu_cs_create_sem(device_handle, &sem_handle);
+	CU_ASSERT_EQUAL(r, 0);
+
+	ptr = ib_result_cpu[0];
+	ptr[0] = SDMA_NOP;
+	ib_info[0].ib_mc_address = ib_result_mc_address[0];
+	ib_info[0].size = 1;
+
+	ibs_request[0].ip_type = AMDGPU_HW_IP_DMA;
+	ibs_request[0].number_of_ibs = 1;
+	ibs_request[0].ibs = &ib_info[0];
+	ibs_request[0].resources = bo_list[0];
+	ibs_request[0].fence_info.handle = NULL;
+	r = amdgpu_cs_submit(context_handle[0], 0,&ibs_request[0], 1);
+	CU_ASSERT_EQUAL(r, 0);
+	r = amdgpu_cs_signal_sem(device_handle, context_handle[0], AMDGPU_HW_IP_DMA, 0, 0, sem_handle);
+	CU_ASSERT_EQUAL(r, 0);
+
+	// export the semaphore and import in different context to wait.
+	r = amdgpu_cs_export_sem(device_handle, sem_handle, &fd);
+	CU_ASSERT_EQUAL(r, 0);
+
+	r = amdgpu_cs_import_sem(device_handle, fd, &sem_handle_import);
+	CU_ASSERT_EQUAL(r, 0);
+	close(fd);
+	r = amdgpu_cs_destroy_sem(device_handle, sem_handle);
+	CU_ASSERT_EQUAL(r, 0);
+
+	r = amdgpu_cs_wait_sem(device_handle, context_handle[1], AMDGPU_HW_IP_GFX, 0, 0, sem_handle_import);
+	CU_ASSERT_EQUAL(r, 0);
+	ptr = ib_result_cpu[1];
+	ptr[0] = GFX_COMPUTE_NOP;
+	ib_info[1].ib_mc_address = ib_result_mc_address[1];
+	ib_info[1].size = 1;
+
+	ibs_request[1].ip_type = AMDGPU_HW_IP_GFX;
+	ibs_request[1].number_of_ibs = 1;
+	ibs_request[1].ibs = &ib_info[1];
+	ibs_request[1].resources = bo_list[1];
+	ibs_request[1].fence_info.handle = NULL;
+
+	r = amdgpu_cs_submit(context_handle[1], 0,&ibs_request[1], 1);
+	CU_ASSERT_EQUAL(r, 0);
+
+	fence_status.context = context_handle[1];
+	fence_status.ip_type = AMDGPU_HW_IP_GFX;
+	fence_status.ip_instance = 0;
+	fence_status.fence = ibs_request[1].seq_no;
+	r = amdgpu_cs_query_fence_status(&fence_status,
+					 500000000, 0, &expired);
+	CU_ASSERT_EQUAL(r, 0);
+	CU_ASSERT_EQUAL(expired, true);
+
+	r = amdgpu_cs_destroy_sem(device_handle, sem_handle_import);
+	CU_ASSERT_EQUAL(r, 0);
+
+	for (i = 0; i < 2; i++) {
+		r = amdgpu_bo_unmap_and_free(ib_result_handle[i], va_handle[i],
+					     ib_result_mc_address[i], 4096);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_bo_list_destroy(bo_list[i]);
+		CU_ASSERT_EQUAL(r, 0);
+
+		r = amdgpu_cs_ctx_free(context_handle[i]);
+		CU_ASSERT_EQUAL(r, 0);
+	}
+
+	r = amdgpu_cs_destroy_semaphore(sem);
+	CU_ASSERT_EQUAL(r, 0);
+}
+
 static void amdgpu_command_submission_compute(void)
 {
 	amdgpu_context_handle context_handle;
-- 
1.9.1


--------------040601090507040301020506
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------040601090507040301020506--
