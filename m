From: Samuel Li <samuel.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 6/6] drm/amdgpu: Add gem_prime_mmap support
Date: Thu, 7 Sep 2017 18:17:28 -0400
Message-ID: <d454ab74-2254-49c2-7dab-063e4f6cc770@amd.com>
References: <1504735644-31225-1-git-send-email-Samuel.Li@amd.com>
 <30852e0e-85fe-f3ee-26fb-c86ac0038f43@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0643737090=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <30852e0e-85fe-f3ee-26fb-c86ac0038f43-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0643737090==
Content-Type: multipart/alternative;
 boundary="------------8C2484701906E01B0FCA0D3D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8C2484701906E01B0FCA0D3D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

>>+    if (write)
>>+        amdgpu_asic_invalidate_hdp(adev);
> You can drop the HDP invalidation here. amdgpu_gem_prime_pin() will pin the BO into system memory.

My understanding here is between CPU and GPU access, the invalidate/flush is still needed, since amdgpu_gem_prime_pin() does not do that.
For this one, I might need to move the invalidate() before pin(). Thoughts?

> BTW: You mixed up flush and invalidate. If we need to implement CPU access to VRAM you need to flush when the cpu access starts and invalidate when it ends.
As per the doc I forwarded to you (HDP coherency check), I think the code here is correct.

Regards,
Sam




On 2017-09-07 03:02 AM, Christian König wrote:
Am 07.09.2017 um 00:07 schrieb Samuel Li:
> Signed-off-by: Samuel Li <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 95 ++++++++++++++++++++++++++++++-
>   3 files changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6f262ce..3c43acf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -395,11 +395,14 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
>   struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>                       struct drm_gem_object *gobj,
>                       int flags);
> +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
> +                        struct dma_buf *dma_buf);
>   int amdgpu_gem_prime_pin(struct drm_gem_object *obj);
>   void amdgpu_gem_prime_unpin(struct drm_gem_object *obj);
>   struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *);
>   void *amdgpu_gem_prime_vmap(struct drm_gem_object *obj);
>   void amdgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
> +int amdgpu_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
>   int amdgpu_gem_debugfs_init(struct amdgpu_device *adev);
>     /* sub-allocation manager, it has to be protected by another lock.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2cdf844..9b63ac5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -835,7 +835,7 @@ static struct drm_driver kms_driver = {
>       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>       .gem_prime_export = amdgpu_gem_prime_export,
> -    .gem_prime_import = drm_gem_prime_import,
> +    .gem_prime_import = amdgpu_gem_prime_import,
>       .gem_prime_pin = amdgpu_gem_prime_pin,
>       .gem_prime_unpin = amdgpu_gem_prime_unpin,
>       .gem_prime_res_obj = amdgpu_gem_prime_res_obj,
> @@ -843,6 +843,7 @@ static struct drm_driver kms_driver = {
>       .gem_prime_import_sg_table = amdgpu_gem_prime_import_sg_table,
>       .gem_prime_vmap = amdgpu_gem_prime_vmap,
>       .gem_prime_vunmap = amdgpu_gem_prime_vunmap,
> +    .gem_prime_mmap = amdgpu_gem_prime_mmap,
>         .name = DRIVER_NAME,
>       .desc = DRIVER_DESC,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> index 5b3f928..629a654 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> @@ -57,6 +57,42 @@ void amdgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
>       ttm_bo_kunmap(&bo->dma_buf_vmap);
>   }
>   +int amdgpu_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
> +{
> +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +    unsigned asize = amdgpu_bo_size(bo);
> +    int ret;
> +
> +    if (!obj->filp || !vma->vm_file)
> +        return -ENODEV;
> +
> +    if (adev == NULL)
> +        return -ENODEV;
> +
> +    /* Check for valid size. */
> +    if (asize < vma->vm_end - vma->vm_start)
> +        return -EINVAL;
> +
> +    if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) ||
> +        (bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
> +        return -EPERM;
> +    }
> +    vma->vm_pgoff = amdgpu_bo_mmap_offset(bo) >> PAGE_SHIFT;
> +
> +    /* prime mmap does not need to check access, so allow here */
> +    ret = drm_vma_node_allow(&obj->vma_node, vma->vm_file->private_data);
> +    if (ret)
> +        return ret;
> +
> +    ret = ttm_bo_mmap(vma->vm_file, vma, &adev->mman.bdev);
> +    drm_vma_node_revoke(&obj->vma_node, vma->vm_file->private_data);
> +    if (ret)
> +        return ret;
> +
> +    return 0;
> +}
> +
>   struct drm_gem_object *
>   amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
>                    struct dma_buf_attachment *attach,
> @@ -130,14 +166,71 @@ struct reservation_object *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)
>       return bo->tbo.resv;
>   }
>   +static int amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf, enum dma_data_direction direction)
> +{
> +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(dma_buf->priv);
> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +    bool write = (direction == DMA_BIDIRECTIONAL || direction == DMA_TO_DEVICE);
> +    int ret;
> +
> +    ret = amdgpu_gem_prime_pin(dma_buf->priv);
> +    if (ret)
> +        return ret;
> +    /* invalidate the HDP read cache */
> +    if (write)
> +        amdgpu_asic_invalidate_hdp(adev);

You can drop the HDP invalidation here. amdgpu_gem_prime_pin() will pin the BO into system memory.

> +
> +    return ret;
> +}
> +
> +static int amdgpu_gem_end_cpu_access(struct dma_buf *dma_buf, enum dma_data_direction direction)
> +{
> +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(dma_buf->priv);
> +    struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +
> +    /* flush hdp write queue */
> +    amdgpu_asic_flush_hdp(adev);

Dito, HDP flush is completely unnecessary here.

BTW: You mixed up flush and invalidate. If we need to implement CPU access to VRAM you need to flush when the cpu access starts and invalidate when it ends.

Regards,
Christian.

> +    amdgpu_gem_prime_unpin(dma_buf->priv);
> +    return 0;
> +}
> +
> +static struct dma_buf_ops amdgpu_dmabuf_ops;
> +
>   struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
>                       struct drm_gem_object *gobj,
>                       int flags)
>   {
>       struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
> +    struct dma_buf *dma_buf;
>         if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>           return ERR_PTR(-EPERM);
>   -    return drm_gem_prime_export(dev, gobj, flags);
> +    dma_buf = drm_gem_prime_export(dev, gobj, flags);
> +    amdgpu_dmabuf_ops = *(dma_buf->ops);
> +    amdgpu_dmabuf_ops.begin_cpu_access = amdgpu_gem_begin_cpu_access;
> +    amdgpu_dmabuf_ops.end_cpu_access = amdgpu_gem_end_cpu_access;
> +    dma_buf->ops = &amdgpu_dmabuf_ops;
> +
> +    return dma_buf;
> +}
> +
> +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
> +                        struct dma_buf *dma_buf)
> +{
> +    struct drm_gem_object *obj;
> +
> +    if (dma_buf->ops == &amdgpu_dmabuf_ops) {
> +        obj = dma_buf->priv;
> +        if (obj->dev == dev) {
> +            /*
> +             * Importing dmabuf exported from out own gem increases
> +             * refcount on gem itself instead of f_count of dmabuf.
> +             */
> +            drm_gem_object_get(obj);
> +            return obj;
> +        }
> +    }
> +
> +    return drm_gem_prime_import(dev, dma_buf);
>   }




--------------8C2484701906E01B0FCA0D3D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body smarttemplateinserted="true" text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">&gt;&gt;+    if (write)
      <br>
      &gt;&gt;+        amdgpu_asic_invalidate_hdp(adev);
      <br>
      &gt; You can drop the HDP invalidation here.
      amdgpu_gem_prime_pin() will pin the BO into system memory.
      <br>
      <br>
      My understanding here is between CPU and GPU access, the
      invalidate/flush is still needed, since amdgpu_gem_prime_pin()
      does not do that.<br>
      For this one, I might need to move the invalidate() before pin().
      Thoughts?<br>
      <br>
      &gt; BTW: You mixed up flush and invalidate. If we need to
      implement CPU access to VRAM you need to flush when the cpu access
      starts and invalidate when it ends. <br>
      As per the doc I forwarded to you (HDP coherency check), I think
      the code here is correct.<br>
      <br>
      Regards,<br>
      Sam<br>
      <br>
      <br>
      <br>
      <br>
      On 2017-09-07 03:02 AM, Christian König wrote:<br>
    </div>
    Am 07.09.2017 um 00:07 schrieb Samuel Li:
    <br>
    <blockquote type="cite">Signed-off-by: Samuel Li
      <a class="moz-txt-link-rfc2396E" href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org">&lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>
      <br>
      ---
      <br>
        drivers/gpu/drm/amd/amdgpu/amdgpu.h       |  3 +
      <br>
        drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   |  3 +-
      <br>
        drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 95
      ++++++++++++++++++++++++++++++-
      <br>
        3 files changed, 99 insertions(+), 2 deletions(-)
      <br>
      <br>
      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
      b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
      <br>
      index 6f262ce..3c43acf 100644
      <br>
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
      <br>
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
      <br>
      @@ -395,11 +395,14 @@ amdgpu_gem_prime_import_sg_table(struct
      drm_device *dev,
      <br>
        struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
      <br>
                            struct drm_gem_object *gobj,
      <br>
                            int flags);
      <br>
      +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device
      *dev,
      <br>
      +                        struct dma_buf *dma_buf);
      <br>
        int amdgpu_gem_prime_pin(struct drm_gem_object *obj);
      <br>
        void amdgpu_gem_prime_unpin(struct drm_gem_object *obj);
      <br>
        struct reservation_object *amdgpu_gem_prime_res_obj(struct
      drm_gem_object *);
      <br>
        void *amdgpu_gem_prime_vmap(struct drm_gem_object *obj);
      <br>
        void amdgpu_gem_prime_vunmap(struct drm_gem_object *obj, void
      *vaddr);
      <br>
      +int amdgpu_gem_prime_mmap(struct drm_gem_object *obj, struct
      vm_area_struct *vma);
      <br>
        int amdgpu_gem_debugfs_init(struct amdgpu_device *adev);
      <br>
          /* sub-allocation manager, it has to be protected by another
      lock.
      <br>
      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
      b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
      <br>
      index 2cdf844..9b63ac5 100644
      <br>
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
      <br>
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
      <br>
      @@ -835,7 +835,7 @@ static struct drm_driver kms_driver = {
      <br>
            .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
      <br>
            .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
      <br>
            .gem_prime_export = amdgpu_gem_prime_export,
      <br>
      -    .gem_prime_import = drm_gem_prime_import,
      <br>
      +    .gem_prime_import = amdgpu_gem_prime_import,
      <br>
            .gem_prime_pin = amdgpu_gem_prime_pin,
      <br>
            .gem_prime_unpin = amdgpu_gem_prime_unpin,
      <br>
            .gem_prime_res_obj = amdgpu_gem_prime_res_obj,
      <br>
      @@ -843,6 +843,7 @@ static struct drm_driver kms_driver = {
      <br>
            .gem_prime_import_sg_table =
      amdgpu_gem_prime_import_sg_table,
      <br>
            .gem_prime_vmap = amdgpu_gem_prime_vmap,
      <br>
            .gem_prime_vunmap = amdgpu_gem_prime_vunmap,
      <br>
      +    .gem_prime_mmap = amdgpu_gem_prime_mmap,
      <br>
              .name = DRIVER_NAME,
      <br>
            .desc = DRIVER_DESC,
      <br>
      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
      b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
      <br>
      index 5b3f928..629a654 100644
      <br>
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
      <br>
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
      <br>
      @@ -57,6 +57,42 @@ void amdgpu_gem_prime_vunmap(struct
      drm_gem_object *obj, void *vaddr)
      <br>
            ttm_bo_kunmap(&amp;bo-&gt;dma_buf_vmap);
      <br>
        }
      <br>
        +int amdgpu_gem_prime_mmap(struct drm_gem_object *obj, struct
      vm_area_struct *vma)
      <br>
      +{
      <br>
      +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
      <br>
      +    struct amdgpu_device *adev =
      amdgpu_ttm_adev(bo-&gt;tbo.bdev);
      <br>
      +    unsigned asize = amdgpu_bo_size(bo);
      <br>
      +    int ret;
      <br>
      +
      <br>
      +    if (!obj-&gt;filp || !vma-&gt;vm_file)
      <br>
      +        return -ENODEV;
      <br>
      +
      <br>
      +    if (adev == NULL)
      <br>
      +        return -ENODEV;
      <br>
      +
      <br>
      +    /* Check for valid size. */
      <br>
      +    if (asize &lt; vma-&gt;vm_end - vma-&gt;vm_start)
      <br>
      +        return -EINVAL;
      <br>
      +
      <br>
      +    if (amdgpu_ttm_tt_get_usermm(bo-&gt;tbo.ttm) ||
      <br>
      +        (bo-&gt;flags &amp; AMDGPU_GEM_CREATE_NO_CPU_ACCESS)) {
      <br>
      +        return -EPERM;
      <br>
      +    }
      <br>
      +    vma-&gt;vm_pgoff = amdgpu_bo_mmap_offset(bo) &gt;&gt;
      PAGE_SHIFT;
      <br>
      +
      <br>
      +    /* prime mmap does not need to check access, so allow here */
      <br>
      +    ret = drm_vma_node_allow(&amp;obj-&gt;vma_node,
      vma-&gt;vm_file-&gt;private_data);
      <br>
      +    if (ret)
      <br>
      +        return ret;
      <br>
      +
      <br>
      +    ret = ttm_bo_mmap(vma-&gt;vm_file, vma,
      &amp;adev-&gt;mman.bdev);
      <br>
      +    drm_vma_node_revoke(&amp;obj-&gt;vma_node,
      vma-&gt;vm_file-&gt;private_data);
      <br>
      +    if (ret)
      <br>
      +        return ret;
      <br>
      +
      <br>
      +    return 0;
      <br>
      +}
      <br>
      +
      <br>
        struct drm_gem_object *
      <br>
        amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
      <br>
                         struct dma_buf_attachment *attach,
      <br>
      @@ -130,14 +166,71 @@ struct reservation_object
      *amdgpu_gem_prime_res_obj(struct drm_gem_object *obj)
      <br>
            return bo-&gt;tbo.resv;
      <br>
        }
      <br>
        +static int amdgpu_gem_begin_cpu_access(struct dma_buf *dma_buf,
      enum dma_data_direction direction)
      <br>
      +{
      <br>
      +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(dma_buf-&gt;priv);
      <br>
      +    struct amdgpu_device *adev =
      amdgpu_ttm_adev(bo-&gt;tbo.bdev);
      <br>
      +    bool write = (direction == DMA_BIDIRECTIONAL || direction ==
      DMA_TO_DEVICE);
      <br>
      +    int ret;
      <br>
      +
      <br>
      +    ret = amdgpu_gem_prime_pin(dma_buf-&gt;priv);
      <br>
      +    if (ret)
      <br>
      +        return ret;
      <br>
      +    /* invalidate the HDP read cache */
      <br>
      +    if (write)
      <br>
      +        amdgpu_asic_invalidate_hdp(adev);
      <br>
    </blockquote>
    <br>
    You can drop the HDP invalidation here. amdgpu_gem_prime_pin() will
    pin the BO into system memory.
    <br>
    <br>
    <blockquote type="cite">+
      <br>
      +    return ret;
      <br>
      +}
      <br>
      +
      <br>
      +static int amdgpu_gem_end_cpu_access(struct dma_buf *dma_buf,
      enum dma_data_direction direction)
      <br>
      +{
      <br>
      +    struct amdgpu_bo *bo = gem_to_amdgpu_bo(dma_buf-&gt;priv);
      <br>
      +    struct amdgpu_device *adev =
      amdgpu_ttm_adev(bo-&gt;tbo.bdev);
      <br>
      +
      <br>
      +    /* flush hdp write queue */
      <br>
      +    amdgpu_asic_flush_hdp(adev);
      <br>
    </blockquote>
    <br>
    Dito, HDP flush is completely unnecessary here.
    <br>
    <br>
    BTW: You mixed up flush and invalidate. If we need to implement CPU
    access to VRAM you need to flush when the cpu access starts and
    invalidate when it ends.
    <br>
    <br>
    Regards,
    <br>
    Christian.
    <br>
    <br>
    <blockquote type="cite">+   
      amdgpu_gem_prime_unpin(dma_buf-&gt;priv);
      <br>
      +    return 0;
      <br>
      +}
      <br>
      +
      <br>
      +static struct dma_buf_ops amdgpu_dmabuf_ops;
      <br>
      +
      <br>
        struct dma_buf *amdgpu_gem_prime_export(struct drm_device *dev,
      <br>
                            struct drm_gem_object *gobj,
      <br>
                            int flags)
      <br>
        {
      <br>
            struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
      <br>
      +    struct dma_buf *dma_buf;
      <br>
              if (amdgpu_ttm_tt_get_usermm(bo-&gt;tbo.ttm))
      <br>
                return ERR_PTR(-EPERM);
      <br>
        -    return drm_gem_prime_export(dev, gobj, flags);
      <br>
      +    dma_buf = drm_gem_prime_export(dev, gobj, flags);
      <br>
      +    amdgpu_dmabuf_ops = *(dma_buf-&gt;ops);
      <br>
      +    amdgpu_dmabuf_ops.begin_cpu_access =
      amdgpu_gem_begin_cpu_access;
      <br>
      +    amdgpu_dmabuf_ops.end_cpu_access = amdgpu_gem_end_cpu_access;
      <br>
      +    dma_buf-&gt;ops = &amp;amdgpu_dmabuf_ops;
      <br>
      +
      <br>
      +    return dma_buf;
      <br>
      +}
      <br>
      +
      <br>
      +struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device
      *dev,
      <br>
      +                        struct dma_buf *dma_buf)
      <br>
      +{
      <br>
      +    struct drm_gem_object *obj;
      <br>
      +
      <br>
      +    if (dma_buf-&gt;ops == &amp;amdgpu_dmabuf_ops) {
      <br>
      +        obj = dma_buf-&gt;priv;
      <br>
      +        if (obj-&gt;dev == dev) {
      <br>
      +            /*
      <br>
      +             * Importing dmabuf exported from out own gem
      increases
      <br>
      +             * refcount on gem itself instead of f_count of
      dmabuf.
      <br>
      +             */
      <br>
      +            drm_gem_object_get(obj);
      <br>
      +            return obj;
      <br>
      +        }
      <br>
      +    }
      <br>
      +
      <br>
      +    return drm_gem_prime_import(dev, dma_buf);
      <br>
        }
      <br>
    </blockquote>
    <br>
    <br>
    <p><br>
    </p>
    <span class="st4cursor"></span>
  </body>
</html>

--------------8C2484701906E01B0FCA0D3D--

--===============0643737090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0643737090==--
