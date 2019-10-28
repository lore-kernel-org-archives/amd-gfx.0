From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9
Date: Mon, 28 Oct 2019 15:38:44 +0000
Message-ID: <DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191028151407.15357-1-christian.koenig@amd.com>,
 <20191028151407.15357-2-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1054867076=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191028151407.15357-2-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1054867076==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_"

--_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, October 28, 2019 11:14 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9

Instead of relying on the DRM functions just implement our own import
functions. This prepares support for taking care of unpinned DMA-buf.

v2: enable for all exporters, not just amdgpu, fix invalidation
    handling, lock reservation object while setting callback
v3: change to new dma_buf attach interface
v4: split out from unpinned DMA-buf work
v5: rebased and cleanup on new DMA-buf interface
v6: squash with invalidation callback change,
    stop using _(map|unmap)_locked
v7: drop invalidations when the BO is already in system domain
v8: rebase on new DMA-buf patch and drop move notification
v9: cleanup comments

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  4 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 32 ++++++++++++---
 4 files changed, 52 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c
index f14b52cc7205..d5bcdfefbad6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -370,31 +370,28 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_ge=
m_object *gobj,
 }

 /**
- * amdgpu_gem_prime_import_sg_table - &drm_driver.gem_prime_import_sg_tabl=
e
- * implementation
+ * amdgpu_dma_buf_create_obj - create BO for DMA-buf import
+ *
  * @dev: DRM device
- * @attach: DMA-buf attachment
- * @sg: Scatter/gather table
+ * @dma_buf: DMA-buf
  *
- * Imports shared DMA buffer memory exported by another device.
+ * Creates an empty SG BO for DMA-buf import.
  *
  * Returns:
  * A new GEM BO of the given DRM device, representing the memory
  * described by the given DMA-buf attachment and scatter/gather table.
  */
-struct drm_gem_object *
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
-                                struct dma_buf_attachment *attach,
-                                struct sg_table *sg)
+static struct drm_gem_object *
+amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 {
-       struct dma_resv *resv =3D attach->dmabuf->resv;
+       struct dma_resv *resv =3D dma_buf->resv;
         struct amdgpu_device *adev =3D dev->dev_private;
         struct amdgpu_bo *bo;
         struct amdgpu_bo_param bp;
         int ret;

         memset(&bp, 0, sizeof(bp));
-       bp.size =3D attach->dmabuf->size;
+       bp.size =3D dma_buf->size;
         bp.byte_align =3D PAGE_SIZE;
         bp.domain =3D AMDGPU_GEM_DOMAIN_CPU;
         bp.flags =3D 0;
@@ -405,11 +402,9 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *de=
v,
         if (ret)
                 goto error;

-       bo->tbo.sg =3D sg;
-       bo->tbo.ttm->sg =3D sg;
         bo->allowed_domains =3D AMDGPU_GEM_DOMAIN_GTT;
         bo->preferred_domains =3D AMDGPU_GEM_DOMAIN_GTT;
-       if (attach->dmabuf->ops !=3D &amdgpu_dmabuf_ops)
+       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops)
                 bo->prime_shared_count =3D 1;

         dma_resv_unlock(resv);
@@ -425,15 +420,15 @@ amdgpu_gem_prime_import_sg_table(struct drm_device *d=
ev,
  * @dev: DRM device
  * @dma_buf: Shared DMA buffer
  *
- * The main work is done by the &drm_gem_prime_import helper, which in tur=
n
- * uses &amdgpu_gem_prime_import_sg_table.
+ * Import a dma_buf into a the driver and potentially create a new GEM obj=
ect.
  *
  * Returns:
  * GEM BO representing the shared DMA buffer for the given device.
  */
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
-                                           struct dma_buf *dma_buf)
+                                              struct dma_buf *dma_buf)
 {
+       struct dma_buf_attachment *attach;
         struct drm_gem_object *obj;

         if (dma_buf->ops =3D=3D &amdgpu_dmabuf_ops) {
@@ -448,5 +443,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct =
drm_device *dev,
                 }
         }

-       return drm_gem_prime_import(dev, dma_buf);
+       obj =3D amdgpu_dma_buf_create_obj(dev, dma_buf);
+       if (IS_ERR(obj))
+               return obj;
+
+       attach =3D dma_buf_dynamic_attach(dma_buf, dev->dev, true);
+       if (IS_ERR(attach)) {
+               drm_gem_object_put(obj);
+               return ERR_CAST(attach);
+       }
+
+       get_dma_buf(dma_buf);
+       obj->import_attach =3D attach;
+       return obj;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.h
index ce1b3f017451..ec447a7b6b28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
@@ -25,10 +25,6 @@

 #include <drm/drm_gem.h>

-struct drm_gem_object *
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,
-                                struct dma_buf_attachment *attach,
-                                struct sg_table *sg);
 struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
                                         int flags);
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 8805776c8c52..25adf2b847e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1445,7 +1445,6 @@ static struct drm_driver kms_driver =3D {
         .prime_fd_to_handle =3D drm_gem_prime_fd_to_handle,
         .gem_prime_export =3D amdgpu_gem_prime_export,
         .gem_prime_import =3D amdgpu_gem_prime_import,
-       .gem_prime_import_sg_table =3D amdgpu_gem_prime_import_sg_table,
         .gem_prime_vmap =3D amdgpu_gem_prime_vmap,
         .gem_prime_vunmap =3D amdgpu_gem_prime_vunmap,
         .gem_prime_mmap =3D amdgpu_gem_prime_mmap,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 8e867b8b432f..c19100ced040 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -39,6 +39,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/swiotlb.h>
+#include <linux/dma-buf.h>

 #include <drm/ttm/ttm_bo_api.h>
 #include <drm/ttm/ttm_bo_driver.h>
@@ -763,6 +764,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_b=
uffer_object *bo,
  */
 struct amdgpu_ttm_tt {
         struct ttm_dma_tt       ttm;
+       struct drm_gem_object   *gobj;
         u64                     offset;
         uint64_t                userptr;
         struct task_struct      *usertask;
@@ -1227,6 +1229,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm=
_buffer_object *bo,
                 return NULL;
         }
         gtt->ttm.ttm.func =3D &amdgpu_backend_func;
+       gtt->gobj =3D &bo->base;

         /* allocate space for the uninitialized page entries */
         if (ttm_sg_tt_init(&gtt->ttm, bo, page_flags)) {
@@ -1247,7 +1250,6 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm,
 {
         struct amdgpu_device *adev =3D amdgpu_ttm_adev(ttm->bdev);
         struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
-       bool slave =3D !!(ttm->page_flags & TTM_PAGE_FLAG_SG);

         /* user pages are bound by amdgpu_ttm_tt_pin_userptr() */
         if (gtt && gtt->userptr) {
@@ -1260,7 +1262,19 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm=
,
                 return 0;
         }

-       if (slave && ttm->sg) {
+       if (ttm->page_flags & TTM_PAGE_FLAG_SG) {
+               if (!ttm->sg) {
+                       struct dma_buf_attachment *attach;
+                       struct sg_table *sgt;
+
+                       attach =3D gtt->gobj->import_attach;
+                       sgt =3D dma_buf_map_attachment(attach, DMA_BIDIRECT=
IONAL);
+                       if (IS_ERR(sgt))
+                               return PTR_ERR(sgt);
+
+                       ttm->sg =3D sgt;
+               }
+
                 drm_prime_sg_to_page_addr_arrays(ttm->sg, ttm->pages,
                                                  gtt->ttm.dma_address,
                                                  ttm->num_pages);
@@ -1287,9 +1301,8 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *ttm,
  */
 static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)
 {
-       struct amdgpu_device *adev;
         struct amdgpu_ttm_tt *gtt =3D (void *)ttm;
-       bool slave =3D !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
+       struct amdgpu_device *adev;

         if (gtt && gtt->userptr) {
                 amdgpu_ttm_tt_set_user_pages(ttm, NULL);
@@ -1298,7 +1311,16 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *=
ttm)
                 return;
         }

-       if (slave)
+       if (ttm->sg && gtt->gobj->import_attach) {
+               struct dma_buf_attachment *attach;
+
+               attach =3D gtt->gobj->import_attach;
+               dma_buf_unmap_attachment(attach, ttm->sg, DMA_BIDIRECTIONAL=
);
+               ttm->sg =3D NULL;
+               return;
+       }
+
+       if (ttm->page_flags & TTM_PAGE_FLAG_SG)
                 return;

         adev =3D amdgpu_ttm_adev(ttm->bdev);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, October 28, 2019 11:14 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add independent DMA-buf import v9</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Instead of relying on the DRM functions just imple=
ment our own import<br>
functions. This prepares support for taking care of unpinned DMA-buf.<br>
<br>
v2: enable for all exporters, not just amdgpu, fix invalidation<br>
&nbsp;&nbsp;&nbsp; handling, lock reservation object while setting callback=
<br>
v3: change to new dma_buf attach interface<br>
v4: split out from unpinned DMA-buf work<br>
v5: rebased and cleanup on new DMA-buf interface<br>
v6: squash with invalidation callback change,<br>
&nbsp;&nbsp;&nbsp; stop using _(map|unmap)_locked<br>
v7: drop invalidations when the BO is already in system domain<br>
v8: rebase on new DMA-buf patch and drop move notification<br>
v9: cleanup comments<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 &#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |&nbsp; 4 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp;&nbsp; |&nbs=
p; 1 -<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp; | 32 =
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&nbsp;4 files changed, 52 insertions(&#43;), 28 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.c<br>
index f14b52cc7205..d5bcdfefbad6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c<br>
@@ -370,31 &#43;370,28 @@ struct dma_buf *amdgpu_gem_prime_export(struct dr=
m_gem_object *gobj,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_gem_prime_import_sg_table - &amp;drm_driver.gem_prime_import_sg_=
table<br>
- * implementation<br>
&#43; * amdgpu_dma_buf_create_obj - create BO for DMA-buf import<br>
&#43; *<br>
&nbsp; * @dev: DRM device<br>
- * @attach: DMA-buf attachment<br>
- * @sg: Scatter/gather table<br>
&#43; * @dma_buf: DMA-buf<br>
&nbsp; *<br>
- * Imports shared DMA buffer memory exported by another device.<br>
&#43; * Creates an empty SG BO for DMA-buf import.<br>
&nbsp; *<br>
&nbsp; * Returns:<br>
&nbsp; * A new GEM BO of the given DRM device, representing the memory<br>
&nbsp; * described by the given DMA-buf attachment and scatter/gather table=
.<br>
&nbsp; */<br>
-struct drm_gem_object *<br>
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_table *sg)<br>
&#43;static struct drm_gem_object *<br>
&#43;amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_=
buf)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv =3D attach-&gt;=
dmabuf-&gt;resv;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_resv *resv =3D dma_buf=
-&gt;resv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D dev-&gt;dev_private;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bp, 0, sizeof(=
bp));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D attach-&gt;dmabuf-&gt;siz=
e;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D dma_buf-&gt;size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byte_align =3D PAGE_SIZ=
E;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_D=
OMAIN_CPU;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D 0;<br>
@@ -405,11 &#43;402,9 @@ amdgpu_gem_prime_import_sg_table(struct drm_device=
 *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.sg =3D sg;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;tbo.ttm-&gt;sg =3D sg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;allowed_domains =3D=
 AMDGPU_GEM_DOMAIN_GTT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;preferred_domains =
=3D AMDGPU_GEM_DOMAIN_GTT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attach-&gt;dmabuf-&gt;ops !=3D &a=
mp;amdgpu_dmabuf_ops)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops !=3D &amp;amd=
gpu_dmabuf_ops)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo-&gt;prime_shared_count =3D 1;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_resv_unlock(resv);<br>
@@ -425,15 &#43;420,15 @@ amdgpu_gem_prime_import_sg_table(struct drm_devic=
e *dev,<br>
&nbsp; * @dev: DRM device<br>
&nbsp; * @dma_buf: Shared DMA buffer<br>
&nbsp; *<br>
- * The main work is done by the &amp;drm_gem_prime_import helper, which in=
 turn<br>
- * uses &amp;amdgpu_gem_prime_import_sg_table.<br>
&#43; * Import a dma_buf into a the driver and potentially create a new GEM=
 object.<br>
&nbsp; *<br>
&nbsp; * Returns:<br>
&nbsp; * GEM BO representing the shared DMA buffer for the given device.<br=
>
&nbsp; */<br>
&nbsp;struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf *dma_buf)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf *dma_buf)=
<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops =3D=3D=
 &amp;amdgpu_dmabuf_ops) {<br>
@@ -448,5 &#43;443,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(str=
uct drm_device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return drm_gem_prime_import(dev, dma_=
buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj =3D amdgpu_dma_buf_create_obj=
(dev, dma_buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(obj))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return obj;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attach =3D dma_buf_dynamic_attach=
(dma_buf, dev-&gt;dev, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(attach)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; drm_gem_object_put(obj);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ERR_CAST(attach);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; get_dma_buf(dma_buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;import_attach =3D attach;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return obj;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_dma_buf.h<br>
index ce1b3f017451..ec447a7b6b28 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h<br>
@@ -25,10 &#43;25,6 @@<br>
&nbsp;<br>
&nbsp;#include &lt;drm/drm_gem.h&gt;<br>
&nbsp;<br>
-struct drm_gem_object *<br>
-amdgpu_gem_prime_import_sg_table(struct drm_device *dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_buf_attachment *attach,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_table *sg);<br>
&nbsp;struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; int flags);<br>
&nbsp;struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev=
,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 8805776c8c52..25adf2b847e8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -1445,7 &#43;1445,6 @@ static struct drm_driver kms_driver =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .prime_fd_to_handle =3D dr=
m_gem_prime_fd_to_handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_export =3D amdg=
pu_gem_prime_export,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_import =3D amdg=
pu_gem_prime_import,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_import_sg_table =3D amdgpu=
_gem_prime_import_sg_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_vmap =3D amdgpu=
_gem_prime_vmap,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_vunmap =3D amdg=
pu_gem_prime_vunmap,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .gem_prime_mmap =3D amdgpu=
_gem_prime_mmap,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 8e867b8b432f..c19100ced040 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -39,6 &#43;39,7 @@<br>
&nbsp;#include &lt;linux/slab.h&gt;<br>
&nbsp;#include &lt;linux/swap.h&gt;<br>
&nbsp;#include &lt;linux/swiotlb.h&gt;<br>
&#43;#include &lt;linux/dma-buf.h&gt;<br>
&nbsp;<br>
&nbsp;#include &lt;drm/ttm/ttm_bo_api.h&gt;<br>
&nbsp;#include &lt;drm/ttm/ttm_bo_driver.h&gt;<br>
@@ -763,6 &#43;764,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct t=
tm_buffer_object *bo,<br>
&nbsp; */<br>
&nbsp;struct amdgpu_ttm_tt {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_dma_tt&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ttm;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object&nbsp;&nbsp;=
 *gobj;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; offset;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; us=
erptr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct task_struct&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; *usertask;<br>
@@ -1227,6 &#43;1229,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct=
 ttm_buffer_object *bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;ttm.ttm.func =3D &=
amp;amdgpu_backend_func;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;gobj =3D &amp;bo-&gt;base=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* allocate space for the =
uninitialized page entries */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm_sg_tt_init(&amp;gt=
t-&gt;ttm, bo, page_flags)) {<br>
@@ -1247,7 &#43;1250,6 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *=
ttm,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D amdgpu_ttm_adev(ttm-&gt;bdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ttm_tt *gtt =
=3D (void *)ttm;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool slave =3D !!(ttm-&gt;page_flags =
&amp; TTM_PAGE_FLAG_SG);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* user pages are bound by=
 amdgpu_ttm_tt_pin_userptr() */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gtt &amp;&amp; gtt-&gt=
;userptr) {<br>
@@ -1260,7 &#43;1262,19 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt =
*ttm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (slave &amp;&amp; ttm-&gt;sg) {<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm-&gt;page_flags &amp; TTM_=
PAGE_FLAG_SG) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (!ttm-&gt;sg) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_b=
uf_attachment *attach;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct sg_ta=
ble *sgt;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; attach =3D g=
tt-&gt;gobj-&gt;import_attach;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sgt =3D dma_=
buf_map_attachment(attach, DMA_BIDIRECTIONAL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(s=
gt))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PTR_ERR(sgt);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm-&gt;sg =
=3D sgt;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; drm_prime_sg_to_page_addr_arrays(ttm-&gt;sg, ttm-&gt;=
pages,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&=
gt;ttm.dma_address,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm-&=
gt;num_pages);<br>
@@ -1287,9 &#43;1301,8 @@ static int amdgpu_ttm_tt_populate(struct ttm_tt *=
ttm,<br>
&nbsp; */<br>
&nbsp;static void amdgpu_ttm_tt_unpopulate(struct ttm_tt *ttm)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ttm_tt *gtt =
=3D (void *)ttm;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool slave =3D !!(ttm-&gt;page_flags =
&amp; TTM_PAGE_FLAG_SG);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (gtt &amp;&amp; gtt-&gt=
;userptr) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_tt_set_user_pages(ttm, NULL);<br>
@@ -1298,7 &#43;1311,16 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_=
tt *ttm)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (slave)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm-&gt;sg &amp;&amp; gtt-&gt=
;gobj-&gt;import_attach) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct dma_buf_attachment *attach;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; attach =3D gtt-&gt;gobj-&gt;import_attach;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dma_buf_unmap_attachment(attach, ttm-&gt;sg, DMA_BIDIRECTION=
AL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ttm-&gt;sg =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ttm-&gt;page_flags &amp; TTM_=
PAGE_FLAG_SG)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev =3D amdgpu_ttm_adev(t=
tm-&gt;bdev);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB1820ECFFCFAFCAD6FB7D8F55F7660DM5PR12MB1820namp_--

--===============1054867076==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1054867076==--
