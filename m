From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9
Date: Mon, 28 Oct 2019 17:05:52 +0100
Message-ID: <7773a20b-2335-8889-f196-2fa195290501@gmail.com>
References: <20191028151407.15357-1-christian.koenig@amd.com>
 <20191028151407.15357-2-christian.koenig@amd.com>
 <DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660@DM5PR12MB1820.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0829435158=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0829435158==
Content-Type: multipart/alternative;
 boundary="------------93691FF0869918CB4D5F6BC6"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------93691FF0869918CB4D5F6BC6
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Thanks, as discussed internally I've just pushed those two to 
drm-misc-next instead of amd-staging-drm-next.

Christian.

Am 28.10.19 um 16:38 schrieb Deucher, Alexander:
> Series is:
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Monday, October 28, 2019 11:14 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9
> Instead of relying on the DRM functions just implement our own import
> functions. This prepares support for taking care of unpinned DMA-buf.
>
> v2: enable for all exporters, not just amdgpu, fix invalidation
>     handling, lock reservation object while setting callback
> v3: change to new dma_buf attach interface
> v4: split out from unpinned DMA-buf work
> v5: rebased and cleanup on new DMA-buf interface
> v6: squash with invalidation callback change,
>     stop using _(map|unmap)_locked
> v7: drop invalidations when the BO is already in system domain
> v8: rebase on new DMA-buf patch and drop move notification
> v9: cleanup comments
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 ++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  4 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 32 ++++++++++++---
>  4 files changed, 52 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index f14b52cc7205..d5bcdfefbad6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -370,31 +370,28 @@ struct dma_buf *amdgpu_gem_prime_export(struct 
> drm_gem_object *gobj,
>  }
>
>  /**
> - * amdgpu_gem_prime_import_sg_table - 
> &drm_driver.gem_prime_import_sg_table
> - * implementation
> + * amdgpu_dma_buf_create_obj - create BO for DMA-buf import
> + *
>   * @dev: DRM device
> - * @attach: DMA-buf attachment
> - * @sg: Scatter/gather table
> + * @dma_buf: DMA-buf
>   *
> - * Imports shared DMA buffer memory exported by another device.
> + * Creates an empty SG BO for DMA-buf import.
>   *
>   * Returns:
>   * A new GEM BO of the given DRM device, representing the memory
>   * described by the given DMA-buf attachment and scatter/gather table.
>   */
> -struct drm_gem_object *
> -amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
> -                                struct dma_buf_attachment *attach,
> -                                struct sg_table *sg)
> +static struct drm_gem_object *
> +amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf 
> *dma_buf)
>  {
> -       struct dma_resv *resv = attach->dmabuf->resv;
> +       struct dma_resv *resv = dma_buf->resv;
>          struct amdgpu_device *adev = dev->dev_private;
>          struct amdgpu_bo *bo;
>          struct amdgpu_bo_param bp;
>          int ret;
>
>          memset(&bp, 0, sizeof(bp));
> -       bp.size = attach->dmabuf->size;
> +       bp.size = dma_buf->size;
>          bp.byte_align = PAGE_SIZE;
>          bp.domain = AMDGPU_GEM_DOMAIN_CPU;
>          bp.flags = 0;
> @@ -405,11 +402,9 @@ amdgpu_gem_prime_import_sg_table(struct 
> drm_device *dev,
>          if (ret)
>                  goto error;
>
> -       bo->tbo.sg = sg;
> -       bo->tbo.ttm->sg = sg;
>          bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
>          bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
> -       if (attach->dmabuf->ops != &amdgpu_dmabuf_ops)
> +       if (dma_buf->ops != &amdgpu_dmabuf_ops)
>                  bo->prime_shared_count = 1;
>
>          dma_resv_unlock(resv);
> @@ -425,15 +420,15 @@ amdgpu_gem_prime_import_sg_table(struct 
> drm_device *dev,
>   * @dev: DRM device
>   * @dma_buf: Shared DMA buffer
>   *
> - * The main work is done by the &drm_gem_prime_import helper, which 
> in turn
> - * uses &amdgpu_gem_prime_import_sg_table.
> + * Import a dma_buf into a the driver and potentially create a new 
> GEM object.
>   *
>   * Returns:
>   * GEM BO representing the shared DMA buffer for the given device.
>   */
>  struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
> -                                           struct dma_buf *dma_buf)
> +                                              struct dma_buf *dma_buf)
>  {
> +       struct dma_buf_attachment *attach;
>          struct drm_gem_object *obj;
>
>          if (dma_buf->ops == &amdgpu_dmabuf_ops) {
> @@ -448,5 +443,17 @@ struct drm_gem_object 
> *amdgpu_gem_prime_import(struct drm_device *dev,
>                  }
>          }
>
> -       return drm_gem_prime_import(dev, dma_buf);
> +       obj = amdgpu_dma_buf_create_obj(dev, dma_buf);
> +       if (IS_ERR(obj))
> +               return obj;
> +
> +       attach = dma_buf_dynamic_attach(dma_buf, dev->dev, true);
> +       if (IS_ERR(attach)) {
> +               drm_gem_object_put(obj);
> +               return ERR_CAST(attach);
> +       }
> +
> +       get_dma_buf(dma_buf);
> +       obj->import_attach = attach;
> +       return obj;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
> index ce1b3f017451..ec447a7b6b28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
> @@ -25,10 +25,6 @@
>
>  #include <drm/drm_gem.h>
>
> -struct drm_gem_object *
> -amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
> -                                struct dma_buf_attachment *attach,
> -                                struct sg_table *sg);
>  struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
>                                          int flags);
>  struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 8805776c8c52..25adf2b847e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1445,7 +1445,6 @@ static struct drm_driver kms_driver = {
>          .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>          .gem_prime_export = amdgpu_gem_prime_export,
>          .gem_prime_import = amdgpu_gem_prime_import,
> -       .gem_prime_import_sg_table = amdgpu_gem_prime_import_sg_table,
>          .gem_prime_vmap = amdgpu_gem_prime_vmap,
>          .gem_prime_vunmap = amdgpu_gem_prime_vunmap,
>          .gem_prime_mmap = amdgpu_gem_prime_mmap,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 8e867b8b432f..c19100ced040 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -39,6 +39,7 @@
>  #include <linux/slab.h>
>  #include <linux/swap.h>
>  #include <linux/swiotlb.h>
> +#include <linux/dma-buf.h>
>
>  #include <drm/ttm/ttm_bo_api.h>
>  #include <drm/ttm/ttm_bo_driver.h>
> @@ -763,6 +764,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct 
> ttm_buffer_object *bo,
>   */
>  struct amdgpu_ttm_tt {
>          struct ttm_dma_tt       ttm;
> +       struct drm_gem_object   *gobj;
>          u64                     offset;
>          uint64_t                userptr;
>          struct task_struct      *usertask;
> @@ -1227,6 +1229,7 @@ static struct ttm_tt 
> *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
>                  return NULL;
>          }
>          gtt->ttm.ttm.func = &amdgpu_backend_func;
> +       gtt->gobj = &bo->base;
>
>          /* allocate space for the uninitialized page entries */
>          if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags)) {
> @@ -1247,7 +1250,6 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt 
> *ttm,
>  {
>          struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
>          struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -       bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
>
>          /* user pages are bound by amdgpu_ttm_tt_pin_userptr() */
>          if (gtt && gtt->userptr) {
> @@ -1260,7 +1262,19 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt 
> *ttm,
>                  return 0;
>          }
>
> -       if (slave && ttm->sg) {
> +       if (ttm->page_flags & TTM_PAGE_FLAG_SG) {
> +               if (!ttm->sg) {
> +                       struct dma_buf_attachment *attach;
> +                       struct sg_table *sgt;
> +
> +                       attach = gtt->gobj->import_attach;
> +                       sgt = dma_buf_map_attachment(attach, 
> DMA_BIDIRECTIONAL);
> +                       if (IS_ERR(sgt))
> +                               return PTR_ERR(sgt);
> +
> +                       ttm->sg = sgt;
> +               }
> +
> drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
> gtt->ttm.dma_address,
> ttm->num_pages);
> @@ -1287,9 +1301,8 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt 
> *ttm,
>   */
>  static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
>  {
> -       struct amdgpu_device *adev;
>          struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -       bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
> +       struct amdgpu_device *adev;
>
>          if (gtt && gtt->userptr) {
>                  amdgpu_ttm_tt_set_user_pages(ttm, NULL);
> @@ -1298,7 +1311,16 @@ static void amdgpu_ttm_tt_unpopulate(struct 
> ttm_tt *ttm)
>                  return;
>          }
>
> -       if (slave)
> +       if (ttm->sg && gtt->gobj->import_attach) {
> +               struct dma_buf_attachment *attach;
> +
> +               attach = gtt->gobj->import_attach;
> +               dma_buf_unmap_attachment(attach, ttm->sg, 
> DMA_BIDIRECTIONAL);
> +               ttm->sg = NULL;
> +               return;
> +       }
> +
> +       if (ttm->page_flags & TTM_PAGE_FLAG_SG)
>                  return;
>
>          adev = amdgpu_ttm_adev(ttm->bdev);
> -- 
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------93691FF0869918CB4D5F6BC6
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Thanks, as discussed internally I've
      just pushed those two to drm-misc-next instead of
      amd-staging-drm-next.<br>
      <br>
      Christian.<br>
      <br>
      Am 28.10.19 um 16:38 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Series is:</div>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Christian König
          <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Monday, October 28, 2019 11:14 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
          <b>Subject:</b> [PATCH 2/2] drm/amdgpu: add independent
          DMA-buf import v9</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Instead of relying on the DRM
              functions just implement our own import<br>
              functions. This prepares support for taking care of
              unpinned DMA-buf.<br>
              <br>
              v2: enable for all exporters, not just amdgpu, fix
              invalidation<br>
                  handling, lock reservation object while setting
              callback<br>
              v3: change to new dma_buf attach interface<br>
              v4: split out from unpinned DMA-buf work<br>
              v5: rebased and cleanup on new DMA-buf interface<br>
              v6: squash with invalidation callback change,<br>
                  stop using _(map|unmap)_locked<br>
              v7: drop invalidations when the BO is already in system
              domain<br>
              v8: rebase on new DMA-buf patch and drop move notification<br>
              v9: cleanup comments<br>
              <br>
              Signed-off-by: Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43
              ++++++++++++---------<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  4 --<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 -<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 32
              ++++++++++++---<br>
               4 files changed, 52 insertions(+), 28 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
              index f14b52cc7205..d5bcdfefbad6 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
              @@ -370,31 +370,28 @@ struct dma_buf
              *amdgpu_gem_prime_export(struct drm_gem_object *gobj,<br>
               }<br>
               <br>
               /**<br>
              - * amdgpu_gem_prime_import_sg_table -
              &amp;drm_driver.gem_prime_import_sg_table<br>
              - * implementation<br>
              + * amdgpu_dma_buf_create_obj - create BO for DMA-buf
              import<br>
              + *<br>
                * @dev: DRM device<br>
              - * @attach: DMA-buf attachment<br>
              - * @sg: Scatter/gather table<br>
              + * @dma_buf: DMA-buf<br>
                *<br>
              - * Imports shared DMA buffer memory exported by another
              device.<br>
              + * Creates an empty SG BO for DMA-buf import.<br>
                *<br>
                * Returns:<br>
                * A new GEM BO of the given DRM device, representing the
              memory<br>
                * described by the given DMA-buf attachment and
              scatter/gather table.<br>
                */<br>
              -struct drm_gem_object *<br>
              -amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
              -                                struct dma_buf_attachment
              *attach,<br>
              -                                struct sg_table *sg)<br>
              +static struct drm_gem_object *<br>
              +amdgpu_dma_buf_create_obj(struct drm_device *dev, struct
              dma_buf *dma_buf)<br>
               {<br>
              -       struct dma_resv *resv =
              attach-&gt;dmabuf-&gt;resv;<br>
              +       struct dma_resv *resv = dma_buf-&gt;resv;<br>
                       struct amdgpu_device *adev = dev-&gt;dev_private;<br>
                       struct amdgpu_bo *bo;<br>
                       struct amdgpu_bo_param bp;<br>
                       int ret;<br>
               <br>
                       memset(&amp;bp, 0, sizeof(bp));<br>
              -       bp.size = attach-&gt;dmabuf-&gt;size;<br>
              +       bp.size = dma_buf-&gt;size;<br>
                       bp.byte_align = PAGE_SIZE;<br>
                       bp.domain = AMDGPU_GEM_DOMAIN_CPU;<br>
                       bp.flags = 0;<br>
              @@ -405,11 +402,9 @@
              amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
                       if (ret)<br>
                               goto error;<br>
               <br>
              -       bo-&gt;tbo.sg = sg;<br>
              -       bo-&gt;tbo.ttm-&gt;sg = sg;<br>
                       bo-&gt;allowed_domains = AMDGPU_GEM_DOMAIN_GTT;<br>
                       bo-&gt;preferred_domains = AMDGPU_GEM_DOMAIN_GTT;<br>
              -       if (attach-&gt;dmabuf-&gt;ops !=
              &amp;amdgpu_dmabuf_ops)<br>
              +       if (dma_buf-&gt;ops != &amp;amdgpu_dmabuf_ops)<br>
                               bo-&gt;prime_shared_count = 1;<br>
               <br>
                       dma_resv_unlock(resv);<br>
              @@ -425,15 +420,15 @@
              amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
                * @dev: DRM device<br>
                * @dma_buf: Shared DMA buffer<br>
                *<br>
              - * The main work is done by the &amp;drm_gem_prime_import
              helper, which in turn<br>
              - * uses &amp;amdgpu_gem_prime_import_sg_table.<br>
              + * Import a dma_buf into a the driver and potentially
              create a new GEM object.<br>
                *<br>
                * Returns:<br>
                * GEM BO representing the shared DMA buffer for the
              given device.<br>
                */<br>
               struct drm_gem_object *amdgpu_gem_prime_import(struct
              drm_device *dev,<br>
              -                                           struct dma_buf
              *dma_buf)<br>
              +                                              struct
              dma_buf *dma_buf)<br>
               {<br>
              +       struct dma_buf_attachment *attach;<br>
                       struct drm_gem_object *obj;<br>
               <br>
                       if (dma_buf-&gt;ops == &amp;amdgpu_dmabuf_ops) {<br>
              @@ -448,5 +443,17 @@ struct drm_gem_object
              *amdgpu_gem_prime_import(struct drm_device *dev,<br>
                               }<br>
                       }<br>
               <br>
              -       return drm_gem_prime_import(dev, dma_buf);<br>
              +       obj = amdgpu_dma_buf_create_obj(dev, dma_buf);<br>
              +       if (IS_ERR(obj))<br>
              +               return obj;<br>
              +<br>
              +       attach = dma_buf_dynamic_attach(dma_buf,
              dev-&gt;dev, true);<br>
              +       if (IS_ERR(attach)) {<br>
              +               drm_gem_object_put(obj);<br>
              +               return ERR_CAST(attach);<br>
              +       }<br>
              +<br>
              +       get_dma_buf(dma_buf);<br>
              +       obj-&gt;import_attach = attach;<br>
              +       return obj;<br>
               }<br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h<br>
              index ce1b3f017451..ec447a7b6b28 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h<br>
              @@ -25,10 +25,6 @@<br>
               <br>
               #include &lt;drm/drm_gem.h&gt;<br>
               <br>
              -struct drm_gem_object *<br>
              -amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
              -                                struct dma_buf_attachment
              *attach,<br>
              -                                struct sg_table *sg);<br>
               struct dma_buf *amdgpu_gem_prime_export(struct
              drm_gem_object *gobj,<br>
                                                       int flags);<br>
               struct drm_gem_object *amdgpu_gem_prime_import(struct
              drm_device *dev,<br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
              index 8805776c8c52..25adf2b847e8 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
              @@ -1445,7 +1445,6 @@ static struct drm_driver kms_driver
              = {<br>
                       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,<br>
                       .gem_prime_export = amdgpu_gem_prime_export,<br>
                       .gem_prime_import = amdgpu_gem_prime_import,<br>
              -       .gem_prime_import_sg_table =
              amdgpu_gem_prime_import_sg_table,<br>
                       .gem_prime_vmap = amdgpu_gem_prime_vmap,<br>
                       .gem_prime_vunmap = amdgpu_gem_prime_vunmap,<br>
                       .gem_prime_mmap = amdgpu_gem_prime_mmap,<br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
              index 8e867b8b432f..c19100ced040 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
              @@ -39,6 +39,7 @@<br>
               #include &lt;linux/slab.h&gt;<br>
               #include &lt;linux/swap.h&gt;<br>
               #include &lt;linux/swiotlb.h&gt;<br>
              +#include &lt;linux/dma-buf.h&gt;<br>
               <br>
               #include &lt;drm/ttm/ttm_bo_api.h&gt;<br>
               #include &lt;drm/ttm/ttm_bo_driver.h&gt;<br>
              @@ -763,6 +764,7 @@ static unsigned long
              amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,<br>
                */<br>
               struct amdgpu_ttm_tt {<br>
                       struct ttm_dma_tt       ttm;<br>
              +       struct drm_gem_object   *gobj;<br>
                       u64                     offset;<br>
                       uint64_t                userptr;<br>
                       struct task_struct      *usertask;<br>
              @@ -1227,6 +1229,7 @@ static struct ttm_tt
              *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,<br>
                               return NULL;<br>
                       }<br>
                       gtt-&gt;ttm.ttm.func = &amp;amdgpu_backend_func;<br>
              +       gtt-&gt;gobj = &amp;bo-&gt;base;<br>
               <br>
                       /* allocate space for the uninitialized page
              entries */<br>
                       if (ttm_sg_tt_init(&amp;gtt-&gt;ttm, bo,
              page_flags)) {<br>
              @@ -1247,7 +1250,6 @@ static int
              amdgpu_ttm_tt_populate(struct ttm_tt *ttm,<br>
               {<br>
                       struct amdgpu_device *adev =
              amdgpu_ttm_adev(ttm-&gt;bdev);<br>
                       struct amdgpu_ttm_tt *gtt = (void *)ttm;<br>
              -       bool slave = !!(ttm-&gt;page_flags &amp;
              TTM_PAGE_FLAG_SG);<br>
               <br>
                       /* user pages are bound by
              amdgpu_ttm_tt_pin_userptr() */<br>
                       if (gtt &amp;&amp; gtt-&gt;userptr) {<br>
              @@ -1260,7 +1262,19 @@ static int
              amdgpu_ttm_tt_populate(struct ttm_tt *ttm,<br>
                               return 0;<br>
                       }<br>
               <br>
              -       if (slave &amp;&amp; ttm-&gt;sg) {<br>
              +       if (ttm-&gt;page_flags &amp; TTM_PAGE_FLAG_SG) {<br>
              +               if (!ttm-&gt;sg) {<br>
              +                       struct dma_buf_attachment *attach;<br>
              +                       struct sg_table *sgt;<br>
              +<br>
              +                       attach =
              gtt-&gt;gobj-&gt;import_attach;<br>
              +                       sgt =
              dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);<br>
              +                       if (IS_ERR(sgt))<br>
              +                               return PTR_ERR(sgt);<br>
              +<br>
              +                       ttm-&gt;sg = sgt;<br>
              +               }<br>
              +<br>
                              
              drm_prime_sg_to_page_addr_arrays(ttm-&gt;sg,
              ttm-&gt;pages,<br>
                                                               
              gtt-&gt;ttm.dma_address,<br>
                                                               
              ttm-&gt;num_pages);<br>
              @@ -1287,9 +1301,8 @@ static int
              amdgpu_ttm_tt_populate(struct ttm_tt *ttm,<br>
                */<br>
               static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)<br>
               {<br>
              -       struct amdgpu_device *adev;<br>
                       struct amdgpu_ttm_tt *gtt = (void *)ttm;<br>
              -       bool slave = !!(ttm-&gt;page_flags &amp;
              TTM_PAGE_FLAG_SG);<br>
              +       struct amdgpu_device *adev;<br>
               <br>
                       if (gtt &amp;&amp; gtt-&gt;userptr) {<br>
                               amdgpu_ttm_tt_set_user_pages(ttm, NULL);<br>
              @@ -1298,7 +1311,16 @@ static void
              amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)<br>
                               return;<br>
                       }<br>
               <br>
              -       if (slave)<br>
              +       if (ttm-&gt;sg &amp;&amp;
              gtt-&gt;gobj-&gt;import_attach) {<br>
              +               struct dma_buf_attachment *attach;<br>
              +<br>
              +               attach = gtt-&gt;gobj-&gt;import_attach;<br>
              +               dma_buf_unmap_attachment(attach,
              ttm-&gt;sg, DMA_BIDIRECTIONAL);<br>
              +               ttm-&gt;sg = NULL;<br>
              +               return;<br>
              +       }<br>
              +<br>
              +       if (ttm-&gt;page_flags &amp; TTM_PAGE_FLAG_SG)<br>
                               return;<br>
               <br>
                       adev = amdgpu_ttm_adev(ttm-&gt;bdev);<br>
              -- <br>
              2.17.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------93691FF0869918CB4D5F6BC6--

--===============0829435158==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0829435158==--
