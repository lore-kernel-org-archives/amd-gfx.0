From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: cleanup creating BOs at fixed location
Date: Fri, 13 Sep 2019 15:55:00 +0000
Message-ID: <BN6PR12MB1809A8BAA0B3ADE8A84383BCF7B30@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190913120800.96299-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0173233289=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190913120800.96299-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0173233289==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A8BAA0B3ADE8A84383BCF7B30BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A8BAA0B3ADE8A84383BCF7B30BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, September 13, 2019 8:08 AM
To: Grodzovsky, Andrey <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>; Zhou1, Tao <Tao.Zhou1@a=
md.com>; Chen, Guchun <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH] drm/amdgpu: cleanup creating BOs at fixed location

The placement is something TTM/BO internal and the RAS code should
avoid touching that directly.

Add a helper to create a BO at a fixed location and use that instead.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 61 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 82 ++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 82 ++++------------------
 4 files changed, 81 insertions(+), 147 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c
index 510d04fd6e5f..70d45d48907a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -342,6 +342,67 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev=
,
         return 0;
 }

+/**
+ * amdgpu_bo_create_kernel - create BO for kernel use at specific location
+ *
+ * @adev: amdgpu device object
+ * @offset: offset of the BO
+ * @size: size of the BO
+ * @domain: where to place it
+ * @bo_ptr:  used to initialize BOs in structures
+ * @cpu_addr: optional CPU address mapping
+ *
+ * Creates a kernel BO at a specific offset in the address space of the do=
main.
+ *
+ * Returns:
+ * 0 on success, negative error code otherwise.
+ */
+int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
+                              uint64_t offset, uint64_t size, uint32_t dom=
ain,
+                              struct amdgpu_bo **bo_ptr, void **cpu_addr)
+{
+       struct ttm_operation_ctx ctx =3D { false, false };
+       unsigned int i;
+       int r;
+
+       offset &=3D PAGE_MASK;
+       size =3D ALIGN(offset, PAGE_SIZE);
+
+       r =3D amdgpu_bo_create_reserved(adev, size, PAGE_SIZE, domain, bo_p=
tr,
+                                     NULL, NULL);
+       if (r)
+               return r;
+
+       /*
+        * Remove the original mem node and create a new one at the request
+        * position.
+        */
+       for (i =3D 0; i < (*bo_ptr)->placement.num_placement; ++i) {
+               (*bo_ptr)->placements[i].fpfn =3D offset >> PAGE_SHIFT;
+               (*bo_ptr)->placements[i].lpfn =3D (offset + size) >> PAGE_S=
HIFT;
+       }
+
+       ttm_bo_mem_put(&(*bo_ptr)->tbo, &(*bo_ptr)->tbo.mem);
+       r =3D ttm_bo_mem_space(&(*bo_ptr)->tbo, &(*bo_ptr)->placement,
+                            &(*bo_ptr)->tbo.mem, &ctx);
+       if (r)
+               goto error;
+
+       if (cpu_addr) {
+               r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);
+               if (r)
+                       goto error;
+       }
+
+       amdgpu_bo_unreserve(*bo_ptr);
+       return 0;
+
+error:
+       amdgpu_bo_unreserve(*bo_ptr);
+       amdgpu_bo_unref(bo_ptr);
+       return r;
+}
+
 /**
  * amdgpu_bo_free_kernel - free BO for kernel use
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h
index e6ddd048a984..f9b550f19ea9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -239,6 +239,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
                             unsigned long size, int align,
                             u32 domain, struct amdgpu_bo **bo_ptr,
                             u64 *gpu_addr, void **cpu_addr);
+int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
+                              uint64_t offset, uint64_t size, uint32_t dom=
ain,
+                              struct amdgpu_bo **bo_ptr, void **cpu_addr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
                            void **cpu_addr);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5f06f1e645c7..cfda72650773 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -69,12 +69,6 @@ const char *ras_block_string[] =3D {

 atomic_t amdgpu_ras_in_intr =3D ATOMIC_INIT(0);

-static int amdgpu_ras_reserve_vram(struct amdgpu_device *adev,
-               uint64_t offset, uint64_t size,
-               struct amdgpu_bo **bo_ptr);
-static int amdgpu_ras_release_vram(struct amdgpu_device *adev,
-               struct amdgpu_bo **bo_ptr);
-
 static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *buf,
                                         size_t size, loff_t *pos)
 {
@@ -1260,75 +1254,6 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
         atomic_set(&ras->in_recovery, 0);
 }

-static int amdgpu_ras_release_vram(struct amdgpu_device *adev,
-               struct amdgpu_bo **bo_ptr)
-{
-       /* no need to free it actually. */
-       amdgpu_bo_free_kernel(bo_ptr, NULL, NULL);
-       return 0;
-}
-
-/* reserve vram with size@offset */
-static int amdgpu_ras_reserve_vram(struct amdgpu_device *adev,
-               uint64_t offset, uint64_t size,
-               struct amdgpu_bo **bo_ptr)
-{
-       struct ttm_operation_ctx ctx =3D { false, false };
-       struct amdgpu_bo_param bp;
-       int r =3D 0;
-       int i;
-       struct amdgpu_bo *bo;
-
-       if (bo_ptr)
-               *bo_ptr =3D NULL;
-       memset(&bp, 0, sizeof(bp));
-       bp.size =3D size;
-       bp.byte_align =3D PAGE_SIZE;
-       bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
-       bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
-               AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
-       bp.type =3D ttm_bo_type_kernel;
-       bp.resv =3D NULL;
-
-       r =3D amdgpu_bo_create(adev, &bp, &bo);
-       if (r)
-               return -EINVAL;
-
-       r =3D amdgpu_bo_reserve(bo, false);
-       if (r)
-               goto error_reserve;
-
-       offset =3D ALIGN(offset, PAGE_SIZE);
-       for (i =3D 0; i < bo->placement.num_placement; ++i) {
-               bo->placements[i].fpfn =3D offset >> PAGE_SHIFT;
-               bo->placements[i].lpfn =3D (offset + size) >> PAGE_SHIFT;
-       }
-
-       ttm_bo_mem_put(&bo->tbo, &bo->tbo.mem);
-       r =3D ttm_bo_mem_space(&bo->tbo, &bo->placement, &bo->tbo.mem, &ctx=
);
-       if (r)
-               goto error_pin;
-
-       r =3D amdgpu_bo_pin_restricted(bo,
-                       AMDGPU_GEM_DOMAIN_VRAM,
-                       offset,
-                       offset + size);
-       if (r)
-               goto error_pin;
-
-       if (bo_ptr)
-               *bo_ptr =3D bo;
-
-       amdgpu_bo_unreserve(bo);
-       return r;
-
-error_pin:
-       amdgpu_bo_unreserve(bo);
-error_reserve:
-       amdgpu_bo_unref(&bo);
-       return r;
-}
-
 /* alloc/realloc bps array */
 static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
                 struct ras_err_handler_data *data, int pages)
@@ -1478,8 +1403,9 @@ int amdgpu_ras_reserve_bad_pages(struct amdgpu_device=
 *adev)
         for (i =3D data->last_reserved; i < data->count; i++) {
                 bp =3D data->bps[i].retired_page;

-               if (amdgpu_ras_reserve_vram(adev, bp << PAGE_SHIFT,
-                                       PAGE_SIZE, &bo))
+               if (amdgpu_bo_create_kernel_at(adev, bp << PAGE_SIZE, PAGE_=
SIZE,
+                                              AMDGPU_GEM_DOMAIN_VRAM,
+                                              &bo, NULL))
                         DRM_ERROR("RAS ERROR: reserve vram %llx fail\n", b=
p);

                 data->bps_bo[i] =3D bo;
@@ -1512,7 +1438,7 @@ static int amdgpu_ras_release_bad_pages(struct amdgpu=
_device *adev)
         for (i =3D data->last_reserved - 1; i >=3D 0; i--) {
                 bo =3D data->bps_bo[i];

-               amdgpu_ras_release_vram(adev, &bo);
+               amdgpu_bo_free_kernel(&bo, NULL, NULL);

                 data->bps_bo[i] =3D bo;
                 data->last_reserved =3D i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index c05638cf3f3d..00f8f38d7993 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1645,81 +1645,25 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct =
amdgpu_device *adev)
  */
 static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 {
-       struct ttm_operation_ctx ctx =3D { false, false };
-       struct amdgpu_bo_param bp;
-       int r =3D 0;
-       int i;
-       u64 vram_size =3D adev->gmc.visible_vram_size;
-       u64 offset =3D adev->fw_vram_usage.start_offset;
-       u64 size =3D adev->fw_vram_usage.size;
-       struct amdgpu_bo *bo;
-
-       memset(&bp, 0, sizeof(bp));
-       bp.size =3D adev->fw_vram_usage.size;
-       bp.byte_align =3D PAGE_SIZE;
-       bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
-       bp.flags =3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
-               AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-       bp.type =3D ttm_bo_type_kernel;
-       bp.resv =3D NULL;
+       uint64_t vram_size =3D adev->gmc.visible_vram_size;
+       int r;
+
         adev->fw_vram_usage.va =3D NULL;
         adev->fw_vram_usage.reserved_bo =3D NULL;

-       if (adev->fw_vram_usage.size > 0 &&
-               adev->fw_vram_usage.size <=3D vram_size) {
-
-               r =3D amdgpu_bo_create(adev, &bp,
-                                    &adev->fw_vram_usage.reserved_bo);
-               if (r)
-                       goto error_create;
-
-               r =3D amdgpu_bo_reserve(adev->fw_vram_usage.reserved_bo, fa=
lse);
-               if (r)
-                       goto error_reserve;
-
-               /* remove the original mem node and create a new one at the
-                * request position
-                */
-               bo =3D adev->fw_vram_usage.reserved_bo;
-               offset =3D ALIGN(offset, PAGE_SIZE);
-               for (i =3D 0; i < bo->placement.num_placement; ++i) {
-                       bo->placements[i].fpfn =3D offset >> PAGE_SHIFT;
-                       bo->placements[i].lpfn =3D (offset + size) >> PAGE_=
SHIFT;
-               }
-
-               ttm_bo_mem_put(&bo->tbo, &bo->tbo.mem);
-               r =3D ttm_bo_mem_space(&bo->tbo, &bo->placement,
-                                    &bo->tbo.mem, &ctx);
-               if (r)
-                       goto error_pin;
-
-               r =3D amdgpu_bo_pin_restricted(adev->fw_vram_usage.reserved=
_bo,
-                       AMDGPU_GEM_DOMAIN_VRAM,
-                       adev->fw_vram_usage.start_offset,
-                       (adev->fw_vram_usage.start_offset +
-                       adev->fw_vram_usage.size));
-               if (r)
-                       goto error_pin;
-               r =3D amdgpu_bo_kmap(adev->fw_vram_usage.reserved_bo,
-                       &adev->fw_vram_usage.va);
-               if (r)
-                       goto error_kmap;
-
-               amdgpu_bo_unreserve(adev->fw_vram_usage.reserved_bo);
-       }
-       return r;
+       if (adev->fw_vram_usage.size =3D=3D 0 ||
+           adev->fw_vram_usage.size > vram_size)
+               return 0;

-error_kmap:
-       amdgpu_bo_unpin(adev->fw_vram_usage.reserved_bo);
-error_pin:
-       amdgpu_bo_unreserve(adev->fw_vram_usage.reserved_bo);
-error_reserve:
-       amdgpu_bo_unref(&adev->fw_vram_usage.reserved_bo);
-error_create:
-       adev->fw_vram_usage.va =3D NULL;
-       adev->fw_vram_usage.reserved_bo =3D NULL;
+       return amdgpu_bo_create_kernel_at(adev,
+                                         adev->fw_vram_usage.start_offset,
+                                         adev->fw_vram_usage.size,
+                                         AMDGPU_GEM_DOMAIN_VRAM,
+                                         &adev->fw_vram_usage.reserved_bo,
+                                         &adev->fw_vram_usage.va);
         return r;
 }
+
 /**
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809A8BAA0B3ADE8A84383BCF7B30BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, September 13, 2019 8:08 AM<br>
<b>To:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao=
 &lt;Tao.Zhou1-5C7GfCeVMHo@public.gmane.org&gt;; Chen, Guchun &lt;Guchun.Chen-5C7GfCeVMHo@public.gmane.org&gt;; amd-g=
fx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: cleanup creating BOs at fixed location<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The placement is something TTM/BO internal and the=
 RAS code should<br>
avoid touching that directly.<br>
<br>
Add a helper to create a BO at a fixed location and use that instead.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 61 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 3 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp; | 82 &#43;&=
#43;--------------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp; | 82 &#43;&=
#43;&#43;&#43;------------------<br>
&nbsp;4 files changed, 81 insertions(&#43;), 147 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.c<br>
index 510d04fd6e5f..70d45d48907a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
@@ -342,6 &#43;342,67 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *=
adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/**<br>
&#43; * amdgpu_bo_create_kernel - create BO for kernel use at specific loca=
tion<br>
&#43; *<br>
&#43; * @adev: amdgpu device object<br>
&#43; * @offset: offset of the BO<br>
&#43; * @size: size of the BO<br>
&#43; * @domain: where to place it<br>
&#43; * @bo_ptr:&nbsp; used to initialize BOs in structures<br>
&#43; * @cpu_addr: optional CPU address mapping<br>
&#43; *<br>
&#43; * Creates a kernel BO at a specific offset in the address space of th=
e domain.<br>
&#43; *<br>
&#43; * Returns:<br>
&#43; * 0 on success, negative error code otherwise.<br>
&#43; */<br>
&#43;int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset, uint64_t size, uint32_t doma=
in,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo **bo_ptr, void **cpu_addr)<b=
r>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx ctx =3D =
{ false, false };<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset &amp;=3D PAGE_MASK;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D ALIGN(offset, PAGE_SIZE)=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_reserved(a=
dev, size, PAGE_SIZE, domain, bo_ptr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NUL=
L, NULL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Remove the original mem n=
ode and create a new one at the request<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * position.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; (*bo_ptr)-&g=
t;placement.num_placement; &#43;&#43;i) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].fpfn =3D offset &gt;&gt; PAGE_SH=
IFT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (*bo_ptr)-&gt;placements[i].lpfn =3D (offset &#43; size) &gt=
;&gt; PAGE_SHIFT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_mem_put(&amp;(*bo_ptr)-&gt=
;tbo, &amp;(*bo_ptr)-&gt;tbo.mem);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_mem_space(&amp;(*bo_=
ptr)-&gt;tbo, &amp;(*bo_ptr)-&gt;placement,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; &amp;(*bo_ptr)-&gt;tbo.mem, &amp;ctx);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto error;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cpu_addr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(*bo_ptr, cpu_addr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(*bo_ptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;error:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(*bo_ptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(bo_ptr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_bo_free_kernel - free BO for kernel use<br>
&nbsp; *<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_object.h<br>
index e6ddd048a984..f9b550f19ea9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
@@ -239,6 &#43;239,9 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *a=
dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; unsigned long size, int align,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; u32 domain, struct amdgpu_bo **bo_ptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; u64 *gpu_addr, void **cpu_addr);<br>
&#43;int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t offset, uint64_t size, uint32_t doma=
in,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo **bo_ptr, void **cpu_addr);<=
br>
&nbsp;void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; void **cpu_addr);<br>
&nbsp;int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 5f06f1e645c7..cfda72650773 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -69,12 &#43;69,6 @@ const char *ras_block_string[] =3D {<br>
&nbsp;<br>
&nbsp;atomic_t amdgpu_ras_in_intr =3D ATOMIC_INIT(0);<br>
&nbsp;<br>
-static int amdgpu_ras_reserve_vram(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t offset, uint64_t size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_bo **bo_ptr);<br>
-static int amdgpu_ras_release_vram(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_bo **bo_ptr);<br>
-<br>
&nbsp;static ssize_t amdgpu_ras_debugfs_read(struct file *f, char __user *b=
uf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; size_t size, loff_t *pos)<br>
&nbsp;{<br>
@@ -1260,75 &#43;1254,6 @@ static void amdgpu_ras_do_recovery(struct work_s=
truct *work)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;ras-&gt;in=
_recovery, 0);<br>
&nbsp;}<br>
&nbsp;<br>
-static int amdgpu_ras_release_vram(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_bo **bo_ptr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* no need to free it actually. */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(bo_ptr, NULL, N=
ULL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-/* reserve vram with size@offset */<br>
-static int amdgpu_ras_reserve_vram(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t offset, uint64_t size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct amdgpu_bo **bo_ptr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx ctx =3D { fa=
lse, false };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_ptr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *bo_ptr =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bp, 0, sizeof(bp));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byte_align =3D PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D AMDGPU_GEM_CREATE_VRAM_C=
ONTIGUOUS |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMDGPU_GEM_CREATE_NO_CPU_ACCESS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.type =3D ttm_bo_type_kernel;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.resv =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create(adev, &amp;bp,=
 &amp;bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(bo, false);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto error_reserve;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset =3D ALIGN(offset, PAGE_SIZE);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; bo-&gt;placement=
.num_placement; &#43;&#43;i) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bo-&gt;placements[i].fpfn =3D offset &gt;&gt; PAGE_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bo-&gt;placements[i].lpfn =3D (offset &#43; size) &gt;&gt; PAGE_=
SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_mem_put(&amp;bo-&gt;tbo, &amp;=
bo-&gt;tbo.mem);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_mem_space(&amp;bo-&gt;tb=
o, &amp;bo-&gt;placement, &amp;bo-&gt;tbo.mem, &amp;ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto error_pin;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_pin_restricted(bo,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAI=
N_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; offset &#43; siz=
e);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto error_pin;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_ptr)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *bo_ptr =3D bo;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-<br>
-error_pin:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<br>
-error_reserve:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
-}<br>
-<br>
&nbsp;/* alloc/realloc bps array */<br>
&nbsp;static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct ras_err_handler_data *data, int pages)<br>
@@ -1478,8 &#43;1403,9 @@ int amdgpu_ras_reserve_bad_pages(struct amdgpu_de=
vice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D data-&gt;last_r=
eserved; i &lt; data-&gt;count; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bp =3D data-&gt;bps[i].retired_page;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ras_reserve_vram(adev, bp &lt;&lt; PAGE_SHIFT,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; PAGE_SIZE, &amp;bo))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (amdgpu_bo_create_kernel_at(adev, bp &lt;&lt; PAGE_SIZE, =
PAGE_SIZE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;bo, NULL))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;RAS ERROR: reserve vram %llx fail\n&quot;, bp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;bps_bo[i] =3D bo;<br>
@@ -1512,7 &#43;1438,7 @@ static int amdgpu_ras_release_bad_pages(struct am=
dgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D data-&gt;last_r=
eserved - 1; i &gt;=3D 0; i--) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo =3D data-&gt;bps_bo[i];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ras_release_vram(adev, &amp;bo);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;bo, NULL, NULL);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;bps_bo[i] =3D bo;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; data-&gt;last_reserved =3D i;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index c05638cf3f3d..00f8f38d7993 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -1645,81 &#43;1645,25 @@ static void amdgpu_ttm_fw_reserve_vram_fini(str=
uct amdgpu_device *adev)<br>
&nbsp; */<br>
&nbsp;static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev=
)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx ctx =3D { fa=
lse, false };<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_param bp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 vram_size =3D adev-&gt;gmc.visibl=
e_vram_size;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 offset =3D adev-&gt;fw_vram_usage=
.start_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size =3D adev-&gt;fw_vram_usage.s=
ize;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;bp, 0, sizeof(bp));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D adev-&gt;fw_vram_usage.si=
ze;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byte_align =3D PAGE_SIZE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D AMDGPU_GEM_CREATE_CPU_AC=
CESS_REQUIRED |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.type =3D ttm_bo_type_kernel;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.resv =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_size =3D adev-&gt;g=
mc.visible_vram_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.va =
=3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.res=
erved_bo =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;fw_vram_usage.size &gt; =
0 &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;fw_vram_usage.size &lt;=3D vram_size) {<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_create(adev, &amp;bp,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt=
;fw_vram_usage.reserved_bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_creat=
e;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;fw_vram_usage.reserved_bo, fals=
e);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_reser=
ve;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* remove the original mem node and create a new one at the<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * request position<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bo =3D adev-&gt;fw_vram_usage.reserved_bo;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset =3D ALIGN(offset, PAGE_SIZE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; bo-&gt;placement.num_placement; &#43;&#43;i=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placement=
s[i].fpfn =3D offset &gt;&gt; PAGE_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placement=
s[i].lpfn =3D (offset &#43; size) &gt;&gt; PAGE_SHIFT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ttm_bo_mem_put(&amp;bo-&gt;tbo, &amp;bo-&gt;tbo.mem);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D ttm_bo_mem_space(&amp;bo-&gt;tbo, &amp;bo-&gt;placement,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;bo-&gt;t=
bo.mem, &amp;ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_pin;<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_pin_restricted(adev-&gt;fw_vram_usage.reserved_b=
o,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAI=
N_VRAM,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram=
_usage.start_offset,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;fw_vra=
m_usage.start_offset &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram=
_usage.size));<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_pin;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D amdgpu_bo_kmap(adev-&gt;fw_vram_usage.reserved_bo,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;fw=
_vram_usage.va);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_kmap;=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_unreserve(adev-&gt;fw_vram_usage.reserved_bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;fw_vram_usage.size =
=3D=3D 0 ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
fw_vram_usage.size &gt; vram_size)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-error_kmap:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;fw_vram_usag=
e.reserved_bo);<br>
-error_pin:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&gt;fw_vram_=
usage.reserved_bo);<br>
-error_reserve:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;adev-&gt;fw_vram=
_usage.reserved_bo);<br>
-error_create:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.va =3D NULL;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.reserved_bo =
=3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_bo_create_kernel_at=
(adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.start_offset,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;fw_vram_usage.size,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_DOMAIN_VRAM,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;fw_vram_usage.reserved_bo,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;fw_vram_usage.va);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_ttm_init - Init the memory management (ttm) as well as vari=
ous<br>
&nbsp; * gtt/vram related fields.<br>
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

--_000_BN6PR12MB1809A8BAA0B3ADE8A84383BCF7B30BN6PR12MB1809namp_--

--===============0173233289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0173233289==--
