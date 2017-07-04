From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 12/12] drm/amdgpu: enable foreign DMA-buf objects
Date: Tue, 4 Jul 2017 11:56:16 -0400
Message-ID: <21d55b2f-d713-a67a-cbf6-e9590cee308a@amd.com>
References: <1499116294-12817-1-git-send-email-Felix.Kuehling@amd.com>
 <1499116294-12817-13-git-send-email-Felix.Kuehling@amd.com>
 <aa517253-299d-7394-6135-6f688ca64f17@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------A19A06A358E5CB7EF430F9CD"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <aa517253-299d-7394-6135-6f688ca64f17-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Language: en-CA
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--------------A19A06A358E5CB7EF430F9CD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


On 17-07-04 03:32 AM, Christian König wrote:
> Am 03.07.2017 um 23:11 schrieb Felix Kuehling:
>> +
>> +    list_add(&gobj->list, &bo->gem_objects);
>> +    gobj->bo = amdgpu_bo_ref(bo);
>> +    bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>
> It's a bit more tricker than that. IIRC my original patch limited the
> BO to GTT space as well.

I dug out your original patch for reference (attached), which was
originally applied on a 4.1-based KFD staging branch. Your original
patch series also included a change for VRAM VM mappings with the system
bit (also attached). So your original intention was clearly to also
allow VRAM P2P access. The VM patch didn't apply after some VM changes
(probably related to the vram manager) and was later replaced by Amber's
patch.

>
> VRAM peer to peer access doesn't work with most PCIe chipsets.
>
> At bare minimum we need to put this behind a config option or add a
> white list for the chipset or only enable it if
> "pci=pcie_bus_peer2peer" is set or something like this.

Well we're using it without any special pci= flags.
pci=pcie_bus_peer2peer can reduce performance, so we should not require
it if it's not needed on all systems.

There are other issues that can prevent P2P access between some pairs of
devices. For example on Intel dual-socket boards the QPI link between
the sockets doesn't work for P2P traffic. So P2P only works between
devices connected to the same socket.

I think it's impractical to check all those chipset-specific limitations
at this level. Importing and mapping a foreign BO should be no problem
either way. If remote access is limited, that's something the
application can figure out on its own. In case of KFD, this is done
based on IO-link topology information.

Regards,
  Felix


>
> BTW: If you modify a patch as severely as that please add your
> Signed-of-by line as well.
>
> Regards,
> Christian.
>
>> +
>> +    ww_mutex_unlock(&bo->tbo.resv->lock);
>> +
>> +    return &gobj->base;
>> +}
>> +
>> +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
>> +                           struct dma_buf *dma_buf)
>> +{
>> +    struct amdgpu_device *adev = dev->dev_private;
>> +
>> +    if (dma_buf->ops == &drm_gem_prime_dmabuf_ops) {
>> +        struct drm_gem_object *obj = dma_buf->priv;
>> +
>> +        if (obj->dev != dev && obj->dev->driver == dev->driver) {
>> +            /* It's a amdgpu_bo from a different driver instance */
>> +            struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>> +
>> +            return amdgpu_gem_prime_foreign_bo(adev, bo);
>> +        }
>> +    }
>> +
>> +    return drm_gem_prime_import(dev, dma_buf);
>> +}
>
>


--------------A19A06A358E5CB7EF430F9CD
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-enable-foreign-DMA-buf-objects.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="0001-drm-amdgpu-enable-foreign-DMA-buf-objects.patch"

>From 9c9b304eaf22730f934d4e60c9eb02fbd0c52613 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 2 Dec 2015 15:40:55 +0100
Subject: [PATCH] drm/amdgpu: enable foreign DMA-buf objects
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We should be able to handle BOs from other instances as well.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 59 +++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6d5c8980..816179d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -639,6 +639,8 @@ struct drm_gem_object *amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
 struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
 					struct drm_gem_object *gobj,
 					int flags);
+struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
+					       struct dma_buf *dma_buf);
 int amdgpu_gem_prime_pin(struct drm_gem_object *obj);
 void amdgpu_gem_prime_unpin(struct drm_gem_object *obj);
 struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 360631d..1a185d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -514,7 +514,7 @@ long amdgpu_drm_ioctl(struct file *filp,
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_export = amdgpu_gem_prime_export,
-	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_import = amdgpu_gem_prime_import,
 	.gem_prime_pin = amdgpu_gem_prime_pin,
 	.gem_prime_unpin = amdgpu_gem_prime_unpin,
 	.gem_prime_res_obj = amdgpu_gem_prime_res_obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
index 649364f..d7c0f9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -143,3 +143,62 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
 
 	return drm_gem_prime_export(dev, gobj, flags);
 }
+
+static struct drm_gem_object *
+amdgpu_gem_prime_foreign_bo(struct amdgpu_device *adev, struct amdgpu_bo *bo)
+{
+	struct amdgpu_gem_object *gobj;
+	int r;
+
+	ww_mutex_lock(&bo->tbo.resv->lock, NULL);
+
+	list_for_each_entry(gobj, &bo->gem_objects, list) {
+		if (gobj->base.dev != adev->ddev)
+			continue;
+
+		ww_mutex_unlock(&bo->tbo.resv->lock);
+		drm_gem_object_reference(&gobj->base);
+		return &gobj->base;
+	}
+
+
+	gobj = kzalloc(sizeof(struct amdgpu_gem_object), GFP_KERNEL);
+	if (unlikely(!gobj)) {
+		ww_mutex_unlock(&bo->tbo.resv->lock);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	r = drm_gem_object_init(adev->ddev, &gobj->base, amdgpu_bo_size(bo));
+	if (unlikely(r)) {
+		kfree(gobj);
+		ww_mutex_unlock(&bo->tbo.resv->lock);
+		return ERR_PTR(r);
+	}
+
+	list_add(&gobj->list, &bo->gem_objects);
+	gobj->bo = amdgpu_bo_ref(bo);
+	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+
+	ww_mutex_unlock(&bo->tbo.resv->lock);
+
+	return &gobj->base;
+}
+
+struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
+					       struct dma_buf *dma_buf)
+{
+	struct amdgpu_device *adev = dev->dev_private;
+
+	if (dma_buf->ops == &drm_gem_prime_dmabuf_ops) {
+		struct drm_gem_object *obj = dma_buf->priv;
+
+		if (obj->dev != dev && obj->dev->driver == dev->driver) {
+			/* It's a amdgpu_bo from a different driver instance */
+			struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+
+			return amdgpu_gem_prime_foreign_bo(adev, bo);
+		}
+	}
+
+	return drm_gem_prime_import(dev, dma_buf);
+}
-- 
1.9.1


--------------A19A06A358E5CB7EF430F9CD
Content-Type: text/x-patch;
 name="0001-drm-amdgpu-handle-foreign-BOs-in-the-VM-mapping-code.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-drm-amdgpu-handle-foreign-BOs-in-the-VM-mapping-code.pa";
 filename*1="tch"

>From fc703df5a630852a70656dbd4842bcacb0b4cf69 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Mon, 30 Nov 2015 14:30:08 +0100
Subject: [PATCH] drm/amdgpu: handle foreign BOs in the VM mapping code v2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

That should allow us using foreign BOs in VRAM.

v2: use the correct device for the PTE creation.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 47e9f41..a02889c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -843,12 +843,15 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct ttm_mem_reg *mem)
 {
 	struct amdgpu_vm *vm = bo_va->vm;
+	struct amdgpu_bo *bo = bo_va->bo;
 	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_gart *gtt = NULL;
 	uint32_t flags;
 	uint64_t addr;
 	int r;
 
+	flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
+
 	if (mem) {
 		addr = (u64)mem->start << PAGE_SHIFT;
 		switch (mem->mem_type) {
@@ -857,7 +860,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			break;
 
 		case TTM_PL_VRAM:
-			addr += adev->vm_manager.vram_base_offset;
+			if (bo->adev != adev) {
+				addr += bo->adev->mc.aper_base;
+				flags |= AMDGPU_PTE_SYSTEM;
+			} else
+				addr += adev->vm_manager.vram_base_offset;
 			break;
 
 		default:
@@ -867,8 +874,6 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 		addr = 0;
 	}
 
-	flags = amdgpu_ttm_tt_pte_flags(adev, bo_va->bo->tbo.ttm, mem);
-
 	spin_lock(&vm->status_lock);
 	if (!list_empty(&bo_va->vm_status))
 		list_splice_init(&bo_va->valids, &bo_va->invalids);
-- 
1.9.1


--------------A19A06A358E5CB7EF430F9CD
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------A19A06A358E5CB7EF430F9CD--
