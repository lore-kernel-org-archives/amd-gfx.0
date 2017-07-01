From: =?UTF-8?Q?Nils_Wallm=C3=A9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 08/12] drm/amdgpu: add amdgpu_gart_map function
Date: Sat, 1 Jul 2017 13:37:13 +0200
Message-ID: <CA+nq7DsTisC63Qn3oCeNHeY=BswKEe_X_Qs7TUbB3--k6WmmOw@mail.gmail.com>
References: <1498821733-1545-1-git-send-email-deathsimple@vodafone.de>
 <1498821733-1545-8-git-send-email-deathsimple@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1121557794=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498821733-1545-8-git-send-email-deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1121557794==
Content-Type: multipart/alternative; boundary="94eb2c19842c865cf105533ff4a7"

--94eb2c19842c865cf105533ff4a7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian, two comments below

Den 30 juni 2017 1:22 em skrev "Christian K=C3=B6nig" <deathsimple@vodafone=
.de>:

From: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

This allows us to write the mapped PTEs into
an IB instead of the table directly.

Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 64
++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 810796a..4a2b33d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -572,6 +572,9 @@ int amdgpu_gart_init(struct amdgpu_device *adev);
 void amdgpu_gart_fini(struct amdgpu_device *adev);
 int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
                        int pages);
+int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
+                   int pages, dma_addr_t *dma_addr, uint64_t flags,
+                   void *dst);
 int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
                     int pages, struct page **pagelist,
                     dma_addr_t *dma_addr, uint64_t flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 8877015..d99b2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -280,6 +280,43 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev,
uint64_t offset,
 }

 /**
+ * amdgpu_gart_map - map dma_addresses into GART entries
+ *
+ * @adev: amdgpu_device pointer
+ * @offset: offset into the GPU's gart aperture
+ * @pages: number of pages to bind
+ * @dma_addr: DMA addresses of pages
+ *
+ * Map the dma_addresses into GART entries (all asics).
+ * Returns 0 for success, -EINVAL for failure.
+ */
+int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
+                   int pages, dma_addr_t *dma_addr, uint64_t flags,
+                   void *dst)
+{
+       uint64_t page_base;
+       unsigned t, p;
+       int i, j;
+
+       if (!adev->gart.ready) {
+               WARN(1, "trying to bind memory to uninitialized GART !\n");
+               return -EINVAL;
+       }
+
+       t =3D offset / AMDGPU_GPU_PAGE_SIZE;
+       p =3D t / (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE);
+
+       for (i =3D 0; i < pages; i++, p++) {
+               page_base =3D dma_addr[i];
+               for (j =3D 0; j < (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE); j++,
t++) {
+                       amdgpu_gart_set_pte_pde(adev, dst, t, page_base,
flags);
+                       page_base +=3D AMDGPU_GPU_PAGE_SIZE;
+               }
+       }
+       return 0;
+}


The p variable seems set but not used in the above function.

+
+/**
  * amdgpu_gart_bind - bind pages into the gart page table
  *
  * @adev: amdgpu_device pointer
@@ -296,31 +333,28 @@ int amdgpu_gart_bind(struct amdgpu_device *adev,
uint64_t offset,
                     int pages, struct page **pagelist, dma_addr_t
*dma_addr,
                     uint64_t flags)
 {
-       unsigned t;
-       unsigned p;
-       uint64_t page_base;
-       int i, j;
+#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
+       unsigned i;
+#endif
+       int r;

        if (!adev->gart.ready) {
                WARN(1, "trying to bind memory to uninitialized GART !\n");
                return -EINVAL;
        }

-       t =3D offset / AMDGPU_GPU_PAGE_SIZE;
-       p =3D t / (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE);
-
-       for (i =3D 0; i < pages; i++, p++) {
 #ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
+       for (i =3D 0; i < pages; i++, p++)
                adev->gart.pages[p] =3D pagelist[i];
 #endif


The p variable is not declared in this function so building with
CONFIG_DRM_AMDGPU_GART_DEBUGFS will fail.

Regards,
Nils

-               if (adev->gart.ptr) {
-                       page_base =3D dma_addr[i];
-                       for (j =3D 0; j < (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE=
);
j++, t++) {
-                               amdgpu_gart_set_pte_pde(adev,
adev->gart.ptr, t, page_base, flags);
-                               page_base +=3D AMDGPU_GPU_PAGE_SIZE;
-                       }
-               }
+
+       if (adev->gart.ptr) {
+               r =3D amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
+                           adev->gart.ptr);
+               if (r)
+                       return r;
        }
+
        mb();
        amdgpu_gart_flush_gpu_tlb(adev, 0);
        return 0;
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--94eb2c19842c865cf105533ff4a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi Christian, two comments below<br><div class=3D"gm=
ail_extra"><br><div class=3D"gmail_quote">Den 30 juni 2017 1:22 em skrev &q=
uot;Christian K=C3=B6nig&quot; &lt;<a href=3D"mailto:deathsimple@vodafone.d=
e">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;:<br type=3D"attribution"><blockquote cla=
ss=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">From: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig=
@amd.com">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
This allows us to write the mapped PTEs into<br>
an IB instead of the table directly.<br>
<br>
Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
3 ++<br>
=C2=A0drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_gart.c | 64 ++++++++++++++++++=
++++++------<wbr>--<br>
=C2=A02 files changed, 52 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/<wbr>amdgpu.h<br>
index 810796a..4a2b33d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu.h<br>
@@ -572,6 +572,9 @@ int amdgpu_gart_init(struct amdgpu_device *adev);<br>
=C2=A0void amdgpu_gart_fini(struct amdgpu_device *adev);<br>
=C2=A0int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int pages);<br>
+int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int p=
ages, dma_addr_t *dma_addr, uint64_t flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void =
*dst);<br>
=C2=A0int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int pages, struct page **pagelist,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dma_addr_t *dma_addr, uint64_t flags);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_gart.c b/drivers/gpu/dr=
m/amd/amdgpu/<wbr>amdgpu_gart.c<br>
index 8877015..d99b2b2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_gart.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_gart.c<br>
@@ -280,6 +280,43 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uin=
t64_t offset,<br>
=C2=A0}<br>
<br>
=C2=A0/**<br>
+ * amdgpu_gart_map - map dma_addresses into GART entries<br>
+ *<br>
+ * @adev: amdgpu_device pointer<br>
+ * @offset: offset into the GPU&#39;s gart aperture<br>
+ * @pages: number of pages to bind<br>
+ * @dma_addr: DMA addresses of pages<br>
+ *<br>
+ * Map the dma_addresses into GART entries (all asics).<br>
+ * Returns 0 for success, -EINVAL for failure.<br>
+ */<br>
+int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int p=
ages, dma_addr_t *dma_addr, uint64_t flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void =
*dst)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t page_base;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned t, p;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, j;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!adev-&gt;gart.ready) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN(1, &quot;tryin=
g to bind memory to uninitialized GART !\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0t =3D offset / AMDGPU_GPU_PAGE_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D t / (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE);<b=
r>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; pages; i++, p++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page_base =3D dma_a=
ddr[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (j =3D 0; j &lt=
; (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE); j++, t++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0amdgpu_gart_set_pte_pde(adev, dst, t, page_base, flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0page_base +=3D AMDGPU_GPU_PAGE_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+}<br></blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">The p variable seems set but not used in the above function.</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_extra"><=
div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
+<br>
+/**<br>
=C2=A0 * amdgpu_gart_bind - bind pages into the gart page table<br>
=C2=A0 *<br>
=C2=A0 * @adev: amdgpu_device pointer<br>
@@ -296,31 +333,28 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint=
64_t offset,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int pages, struct page **pagelist, dma_addr_t *dma_addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0uint64_t flags)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned t;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned p;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t page_base;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0int i, j;<br>
+#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned i;<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!adev-&gt;gart.ready) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN(1, &quot;tryin=
g to bind memory to uninitialized GART !\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0t =3D offset / AMDGPU_GPU_PAGE_SIZE;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D t / (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE);<b=
r>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; pages; i++, p++) {<br>
=C2=A0#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; pages; i++, p++)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 adev-&gt;gart.pages=
[p] =3D pagelist[i];<br>
=C2=A0#endif<br></blockquote></div></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">The p variable is not declared in this function so buildi=
ng with=C2=A0</div><div dir=3D"auto"><span style=3D"font-family:sans-serif"=
>CONFIG_DRM_AMDGPU_GART_DEBUGFS will fail.</span><br></div><div dir=3D"auto=
"><span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto"=
><span style=3D"font-family:sans-serif">Regards,</span></div><div dir=3D"au=
to"><span style=3D"font-family:sans-serif">Nils</span></div><div dir=3D"aut=
o"><span style=3D"font-family:sans-serif"><br></span></div><div dir=3D"auto=
"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;gart.p=
tr) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0page_base =3D dma_addr[i];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (j =3D 0; j &lt; (PAGE_SIZE / AMDGPU_GPU_PAGE_SIZE); j++, t++=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gart_set_pte_pde(adev, adev-&g=
t;gart.ptr, t, page_base, flags);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0page_base +=3D AMDGPU_GPU_PAGE_SIZE;<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;gart.ptr) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_gart_m=
ap(adev, offset, pages, dma_addr, flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gart.ptr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return r;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mb();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_gart_flush_gpu_tlb(<wbr>adev, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<font color=3D"#888888">--<br>
2.7.4<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</font></blockquote></div><br></div></div></div>

--94eb2c19842c865cf105533ff4a7--

--===============1121557794==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1121557794==--
