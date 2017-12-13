From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: FW: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses
 dma buf.
Date: Wed, 13 Dec 2017 14:17:49 -0500
Message-ID: <e92edd07-27fb-4717-bddd-e97ce5fbc266@amd.com>
References: <1512771734-13581-1-git-send-email-Samuel.Li@amd.com>
 <BLUPR12MB0628724406FBB250987B1B41F5340@BLUPR12MB0628.namprd12.prod.outlook.com>
 <212eeef1-2c32-bef9-82a6-a1884ef002da@amd.com>
 <82599e20-60fa-fe6f-2c91-4882ffcff4ce@amd.com>
 <154804e5-cdbb-a5f8-2ad8-506b0752943b@amd.com>
 <53b66de8-3fe3-c139-9887-7358bf1d95b5@amd.com>
 <141a2180-104a-4a75-7757-6de3b522c578@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------B146ED0E458E4E527575472F"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <141a2180-104a-4a75-7757-6de3b522c578-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------B146ED0E458E4E527575472F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

For the record.


On 2017-12-13 01:26 PM, Christian König wrote:
> Actually we try to avoid that drivers define their own dma_buf_ops in DRM.
> 
> That's why you have all those callbacks in drm_driver which just mirror the dma_buf interface but unpack the GEM object from the dma-buf object.
> 
> There are quite a number of exceptions, but those drivers then implement everything on their own because the DRM marshaling doesn't make sense for them.
> 
> Christian.
> 
> Am 13.12.2017 um 19:01 schrieb Samuel Li:
>> That is an approach. The cost is to add a new call back, which is not necessary though, since driver can always actually define their own dma_buf_ops.
>> The intention here is to allow a driver reuse drm_gem_prime_dmabuf_ops{}. If you would like to go this far, maybe a more straight forward way is to export those ops, e.g. drm_gem_map_attach, so that a driver can use them in its own definitions.
>>
>> Sam
>>
>>
>>
>> On 2017-12-13 05:23 AM, Christian König wrote:
>>> Something like the attached patch. Not even compile tested.
>>>
>>> Christian.
>>>
>>> Am 12.12.2017 um 20:13 schrieb Samuel Li:
>>>> Not sure if I understand your comments correctly. Currently amdgpu prime reuses drm_gem_prime_dmabuf_ops{}, and it is defined as static which is reasonable. I do not see an easier way to introduce amdgpu_gem_begin_cpu_access().
>>>>
>>>> Sam
>>>>
>>>> On 2017-12-12 01:30 PM, Christian König wrote:
>>>>>> +    while (amdgpu_dmabuf_ops.begin_cpu_access != amdgpu_gem_begin_cpu_access)
>>>>> I would rather just add the four liner code to drm to forward the begin_cpu_access callback into a drm_driver callback instead of all this.
>>>>>
>>>>> But apart from that it looks good to me.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 12.12.2017 um 19:14 schrieb Li, Samuel:
>>>>>> A gentle ping on this one, Christian, can you take a look at this?
>>>>>>
>>>>>> Sam
>>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Li, Samuel
>>>>>> Sent: Friday, December 08, 2017 5:22 PM
>>>>>> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>>>> Cc: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
>>>>>> Subject: [PATCH v2 2/2] drm/amdgpu: Move to gtt before cpu accesses dma buf.
>>>>>>
>>>>>> To improve cpu read performance. This is implemented for APUs currently.
>>>>>>
>>>>>> v2: Adapt to change https://lists.freedesktop.org/archives/amd-gfx/2017-October/015174.html
>>>>>>
>>>>>> Change-Id: I7a583e23a9ee706e0edd2a46f4e4186a609368e3
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  2 ++
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  2 +-
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 58 +++++++++++++++++++++++++++++++
>>>>>>     3 files changed, 61 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> index f8657c3..193db70 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>>>> @@ -417,6 +417,8 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *dev,  struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>>>>>>                         struct drm_gem_object *gobj,
>>>>>>                         int flags);
>>>>>> +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
>>>>>> +                        struct dma_buf *dma_buf);
>>>>>>     int amdgpu_gem_prime_pin(struct drm_gem_object *obj);  void amdgpu_gem_prime_unpin(struct drm_gem_object *obj);  struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> index 31383e0..df30b08 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>>>> @@ -868,7 +868,7 @@ static struct drm_driver kms_driver = {
>>>>>>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>>>>>         .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>>>>>>         .gem_prime_export = amdgpu_gem_prime_export,
>>>>>> -    .gem_prime_import = drm_gem_prime_import,
>>>>>> +    .gem_prime_import = amdgpu_gem_prime_import,
>>>>>>         .gem_prime_pin = amdgpu_gem_prime_pin,
>>>>>>         .gem_prime_unpin = amdgpu_gem_prime_unpin,
>>>>>>         .gem_prime_res_obj = amdgpu_gem_prime_res_obj, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>>> index ae9c106..de6f599 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
>>>>>> @@ -26,6 +26,7 @@
>>>>>>     #include <drm/drmP.h>
>>>>>>       #include "amdgpu.h"
>>>>>> +#include "amdgpu_display.h"
>>>>>>     #include <drm/amdgpu_drm.h>
>>>>>>     #include <linux/dma-buf.h>
>>>>>>     @@ -164,6 +165,33 @@ struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)
>>>>>>         return bo->tbo.resv;
>>>>>>     }
>>>>>>     +static int amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf, enum
>>>>>> +dma_data_direction direction) {
>>>>>> +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(dma_buf->priv);
>>>>>> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>>>> +    struct ttm_operation_ctx ctx = { true, false };
>>>>>> +    u32 domain = amdgpu_framebuffer_domains(adev);
>>>>>> +    long ret = 0;
>>>>>> +    bool reads = (direction == DMA_BIDIRECTIONAL || direction ==
>>>>>> +DMA_FROM_DEVICE);
>>>>>> +
>>>>>> +    if (!reads || !(domain | AMDGPU_GEM_DOMAIN_GTT) || bo->pin_count)
>>>>>> +        return 0;
>>>>>> +
>>>>>> +    /* move to gtt */
>>>>>> +    ret = amdgpu_bo_reserve(bo, false);
>>>>>> +    if (unlikely(ret != 0))
>>>>>> +        return ret;
>>>>>> +
>>>>>> +    amdgpu_ttm_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
>>>>>> +    ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>> +
>>>>>> +    amdgpu_bo_unreserve(bo);
>>>>>> +    return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static struct dma_buf_ops amdgpu_dmabuf_ops; static atomic_t aops_lock;
>>>>>> +
>>>>>>     struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>>>>>>                         struct drm_gem_object *gobj,
>>>>>>                         int flags)
>>>>>> @@ -178,5 +206,35 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>>>>>>         buf = drm_gem_prime_export(dev, gobj, flags);
>>>>>>         if (!IS_ERR(buf))
>>>>>>             buf->file->f_mapping = dev->anon_inode->i_mapping;
>>>>>> +
>>>>>> +    while (amdgpu_dmabuf_ops.begin_cpu_access != amdgpu_gem_begin_cpu_access)
>>>>>> +    {
>>>>>> +        if (!atomic_cmpxchg(&aops_lock, 0, 1)) {
>>>>>> +            amdgpu_dmabuf_ops = *(buf->ops);
>>>>>> +            amdgpu_dmabuf_ops.begin_cpu_access = amdgpu_gem_begin_cpu_access;
>>>>>> +        }
>>>>>> +    }
>>>>>> +    buf->ops = &amdgpu_dmabuf_ops;
>>>>>> +
>>>>>>         return buf;
>>>>>>     }
>>>>>> +
>>>>>> +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
>>>>>> +                        struct dma_buf *dma_buf)
>>>>>> +{
>>>>>> +    struct drm_gem_object *obj;
>>>>>> +
>>>>>> +    if (dma_buf->ops == &amdgpu_dmabuf_ops) {
>>>>>> +        obj = dma_buf->priv;
>>>>>> +        if (obj->dev == dev) {
>>>>>> +            /*
>>>>>> +             * Importing dmabuf exported from out own gem increases
>>>>>> +             * refcount on gem itself instead of f_count of dmabuf.
>>>>>> +             */
>>>>>> +            drm_gem_object_get(obj);
>>>>>> +            return obj;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return drm_gem_prime_import(dev, dma_buf); }
>>>>>> -- 
>>>>>> 2.7.4
>>>>>>
> 

--------------B146ED0E458E4E527575472F
Content-Type: text/x-patch;
 name="0001-drm-prime-forward-begin_cpu_access-callback-to-drive.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-drm-prime-forward-begin_cpu_access-callback-to-drive.pa";
 filename*1="tch"

>From 95a211bd0a6bfea56e49670842addd3a02a76063 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 13 Dec 2017 11:22:05 +0100
Subject: [PATCH] drm/prime: forward begin_cpu_access callback to drivers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow drivers to implement their own begin_cpu_access callback.

Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/drm_prime.c | 11 +++++++++++
 include/drm/drm_drv.h       |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 8de93a226c24..3bf497e489f1 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -346,6 +346,16 @@ void drm_gem_dmabuf_release(struct dma_buf *dma_buf)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_release);
 
+static void drm_gem_dmabuf_begin_cpu_access(struct dma_buf *dma_buf,
+					    enum dma_data_direction direction)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_device *dev = obj->dev;
+
+	if (dev->driver->gem_prime_begin_cpu_access);
+		dev->driver->gem_prime_begin_cpu_access(obj, direction);
+}
+
 static void *drm_gem_dmabuf_vmap(struct dma_buf *dma_buf)
 {
 	struct drm_gem_object *obj = dma_buf->priv;
@@ -403,6 +413,7 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 	.map_dma_buf = drm_gem_map_dma_buf,
 	.unmap_dma_buf = drm_gem_unmap_dma_buf,
 	.release = drm_gem_dmabuf_release,
+	.begin_cpu_access = drm_gem_dmabuf_begin_cpu_access,
 	.map = drm_gem_dmabuf_kmap,
 	.map_atomic = drm_gem_dmabuf_kmap_atomic,
 	.unmap = drm_gem_dmabuf_kunmap,
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index d32b688eb346..6fb8b80f4349 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -490,6 +490,8 @@ struct drm_driver {
 				struct drm_device *dev,
 				struct dma_buf_attachment *attach,
 				struct sg_table *sgt);
+	void (*gem_prime_begin_cpu_access)(struct drm_gem_object *obj,
+					   enum dma_data_direction direction);
 	void *(*gem_prime_vmap)(struct drm_gem_object *obj);
 	void (*gem_prime_vunmap)(struct drm_gem_object *obj, void *vaddr);
 	int (*gem_prime_mmap)(struct drm_gem_object *obj,
-- 
2.11.0


--------------B146ED0E458E4E527575472F
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------B146ED0E458E4E527575472F--
