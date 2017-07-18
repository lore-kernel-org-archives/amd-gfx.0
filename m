From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Fw: [PATCH] drm/amdgpu:fix gfx fence allocate size
Date: Tue, 18 Jul 2017 05:58:39 +0000
Message-ID: <BLUPR12MB0449B0A57E814A1849676E6084A10@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1500357409-1396-1-git-send-email-Monk.Liu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0920685969=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500357409-1396-1-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0920685969==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB0449B0A57E814A1849676E6084A10BLUPR12MB0449namp_"

--_000_BLUPR12MB0449B0A57E814A1849676E6084A10BLUPR12MB0449namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




________________________________
From: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, July 18, 2017 1:56 PM
To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liu, Monk; Yu, Xiangliang
Subject: [PATCH] drm/amdgpu:fix gfx fence allocate size

1, for sriov, we need 8dw for the gfx fence due to CP
behaviour
2, cleanup wrong logic in wptr/rptr wb alloc and free

Change-Id: Ifbfed17a4621dae57244942ffac7de1743de0294
Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++++++=
++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 26 ++++++++++++++++--------
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index f6345b9..fe96236 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1191,7 +1191,9 @@ struct amdgpu_wb {
 int amdgpu_wb_get(struct amdgpu_device *adev, u32 *wb);
 void amdgpu_wb_free(struct amdgpu_device *adev, u32 wb);
 int amdgpu_wb_get_64bit(struct amdgpu_device *adev, u32 *wb);
+int amdgpu_wb_get_256Bit(struct amdgpu_device *adev, u32 *wb);
 void amdgpu_wb_free_64bit(struct amdgpu_device *adev, u32 wb);
+void amdgpu_wb_free_256bit(struct amdgpu_device *adev, u32 wb);

 void amdgpu_get_pcie_info(struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7e11190..6050804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -603,6 +603,21 @@ int amdgpu_wb_get_64bit(struct amdgpu_device *adev, u3=
2 *wb)
         }
 }

+int amdgpu_wb_get_256Bit(struct amdgpu_device *adev, u32 *wb)
+{
+       int i =3D 0;
+       unsigned long offset =3D bitmap_find_next_zero_area_off(adev->wb.us=
ed,
+                               adev->wb.num_wb, 0, 8, 63, 0);
+       if ((offset + 7) < adev->wb.num_wb) {
+               for (i =3D 0; i < 8; i++)
+                       __set_bit(offset + i, adev->wb.used);
+               *wb =3D offset;
+               return 0;
+       } else {
+               return -EINVAL;
+       }
+}
+
 /**
  * amdgpu_wb_free - Free a wb entry
  *
@@ -634,6 +649,23 @@ void amdgpu_wb_free_64bit(struct amdgpu_device *adev, =
u32 wb)
 }

 /**
+ * amdgpu_wb_free_256bit - Free a wb entry
+ *
+ * @adev: amdgpu_device pointer
+ * @wb: wb index
+ *
+ * Free a wb slot allocated for use by the driver (all asics)
+ */
+void amdgpu_wb_free_256bit(struct amdgpu_device *adev, u32 wb)
+{
+       int i =3D 0;
+
+       if ((wb + 7) < adev->wb.num_wb)
+               for (i =3D 0; i < 8; i++)
+                       __clear_bit(wb + i, adev->wb.used);
+}
+
+/**
  * amdgpu_vram_location - try to find VRAM location
  * @adev: amdgpu device structure holding all necessary informations
  * @mc: memory controller structure holding memory informations
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 75165e0..eea17ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -212,10 +212,19 @@ int amdgpu_ring_init(struct amdgpu_device *adev, stru=
ct amdgpu_ring *ring,

         }

-       r =3D amdgpu_wb_get(adev, &ring->fence_offs);
-       if (r) {
-               dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n"=
, r);
-               return r;
+       if (amdgpu_sriov_vf(adev) && ring->funcs->type =3D=3D AMDGPU_RING_T=
YPE_GFX) {
+               r =3D amdgpu_wb_get_256Bit(adev, &ring->fence_offs);
+               if (r) {
+                       dev_err(adev->dev, "(%d) ring fence_offs wb alloc f=
ailed\n", r);
+                       return r;
+               }
+
+       } else {
+               r =3D amdgpu_wb_get(adev, &ring->fence_offs);
+               if (r) {
+                       dev_err(adev->dev, "(%d) ring fence_offs wb alloc f=
ailed\n", r);
+                       return r;
+               }
         }

         r =3D amdgpu_wb_get(adev, &ring->cond_exe_offs);
@@ -278,17 +287,18 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
         ring->ready =3D false;

         if (ring->funcs->support_64bit_ptrs) {
-               amdgpu_wb_free_64bit(ring->adev, ring->cond_exe_offs);
-               amdgpu_wb_free_64bit(ring->adev, ring->fence_offs);
                 amdgpu_wb_free_64bit(ring->adev, ring->rptr_offs);
                 amdgpu_wb_free_64bit(ring->adev, ring->wptr_offs);
         } else {
-               amdgpu_wb_free(ring->adev, ring->cond_exe_offs);
-               amdgpu_wb_free(ring->adev, ring->fence_offs);
                 amdgpu_wb_free(ring->adev, ring->rptr_offs);
                 amdgpu_wb_free(ring->adev, ring->wptr_offs);
         }

+       amdgpu_wb_free(ring->adev, ring->cond_exe_offs);
+       if (amdgpu_sriov_vf(ring->adev) && ring->funcs->type =3D=3D AMDGPU_=
RING_TYPE_GFX)
+               amdgpu_wb_free_256bit(ring->adev, ring->fence_offs);
+       else
+               amdgpu_wb_free(ring->adev, ring->cond_exe_offs);

         amdgpu_bo_free_kernel(&ring->ring_obj,
                               &ring->gpu_addr,
--
2.7.4


--_000_BLUPR12MB0449B0A57E814A1849676E6084A10BLUPR12MB0449namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Monk Liu &lt;Monk.L=
iu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, July 18, 2017 1:56 PM<br>
<b>To:</b> amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Liu, Monk; Yu, Xiangliang<br>
<b>Subject:</b> [PATCH] drm/amdgpu:fix gfx fence allocate size</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">1, for sriov, we need 8dw for the gfx fence due to=
 CP<br>
behaviour<br>
2, cleanup wrong logic in wptr/rptr wb alloc and free<br>
<br>
Change-Id: Ifbfed17a4621dae57244942ffac7de1743de0294<br>
Signed-off-by: Monk Liu &lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Xiangliang Yu &lt;Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; |&nbsp; 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 &#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c&nbsp;&nbsp; | 26 &#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------=
--<br>
&nbsp;3 files changed, 52 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index f6345b9..fe96236 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1191,7 &#43;1191,9 @@ struct amdgpu_wb {<br>
&nbsp;int amdgpu_wb_get(struct amdgpu_device *adev, u32 *wb);<br>
&nbsp;void amdgpu_wb_free(struct amdgpu_device *adev, u32 wb);<br>
&nbsp;int amdgpu_wb_get_64bit(struct amdgpu_device *adev, u32 *wb);<br>
&#43;int amdgpu_wb_get_256Bit(struct amdgpu_device *adev, u32 *wb);<br>
&nbsp;void amdgpu_wb_free_64bit(struct amdgpu_device *adev, u32 wb);<br>
&#43;void amdgpu_wb_free_256bit(struct amdgpu_device *adev, u32 wb);<br>
&nbsp;<br>
&nbsp;void amdgpu_get_pcie_info(struct amdgpu_device *adev);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 7e11190..6050804 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -603,6 &#43;603,21 @@ int amdgpu_wb_get_64bit(struct amdgpu_device *adev=
, u32 *wb)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&#43;int amdgpu_wb_get_256Bit(struct amdgpu_device *adev, u32 *wb)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long offset =3D bitmap_f=
ind_next_zero_area_off(adev-&gt;wb.used,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;wb.num_wb, 0, 8, 63, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((offset &#43; 7) &lt; adev-&g=
t;wb.num_wb) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; 8; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __set_bit(of=
fset &#43; i, adev-&gt;wb.used);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *wb =3D offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * amdgpu_wb_free - Free a wb entry<br>
&nbsp; *<br>
@@ -634,6 &#43;649,23 @@ void amdgpu_wb_free_64bit(struct amdgpu_device *ad=
ev, u32 wb)<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
&#43; * amdgpu_wb_free_256bit - Free a wb entry<br>
&#43; *<br>
&#43; * @adev: amdgpu_device pointer<br>
&#43; * @wb: wb index<br>
&#43; *<br>
&#43; * Free a wb slot allocated for use by the driver (all asics)<br>
&#43; */<br>
&#43;void amdgpu_wb_free_256bit(struct amdgpu_device *adev, u32 wb)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((wb &#43; 7) &lt; adev-&gt;wb=
.num_wb)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (i =3D 0; i &lt; 8; i&#43;&#43;)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __clear_bit(=
wb &#43; i, adev-&gt;wb.used);<br>
&#43;}<br>
&#43;<br>
&#43;/**<br>
&nbsp; * amdgpu_vram_location - try to find VRAM location<br>
&nbsp; * @adev: amdgpu device structure holding all necessary informations<=
br>
&nbsp; * @mc: memory controller structure holding memory informations<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c<br>
index 75165e0..eea17ae 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
@@ -212,10 &#43;212,19 @@ int amdgpu_ring_init(struct amdgpu_device *adev, =
struct amdgpu_ring *ring,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_wb_get(adev, &amp;ring-&=
gt;fence_offs);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;(%d) ring fence_offs wb alloc failed=
\n&quot;, r);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) &amp;&a=
mp; ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_GFX) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_wb_get_256Bit(adev, &amp;ring-&gt;fence_offs);<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev=
-&gt;dev, &quot;(%d) ring fence_offs wb alloc failed\n&quot;, r);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; r =3D amdgpu_wb_get(adev, &amp;ring-&gt;fence_offs);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (r) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev=
-&gt;dev, &quot;(%d) ring fence_offs wb alloc failed\n&quot;, r);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_wb_get(adev, =
&amp;ring-&gt;cond_exe_offs);<br>
@@ -278,17 &#43;287,18 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;ready =3D false;<=
br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;sup=
port_64bit_ptrs) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_wb_free_64bit(ring-&gt;adev, ring-&gt;cond_exe_offs);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_wb_free_64bit(ring-&gt;adev, ring-&gt;fence_offs);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_wb_free_64bit(ring-&gt;adev, ring-&gt;rptr_off=
s);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_wb_free_64bit(ring-&gt;adev, ring-&gt;wptr_off=
s);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_wb_free(ring-&gt;adev, ring-&gt;cond_exe_offs);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_wb_free(ring-&gt;adev, ring-&gt;fence_offs);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_wb_free(ring-&gt;adev, ring-&gt;rptr_offs);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_wb_free(ring-&gt;adev, ring-&gt;wptr_offs);<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_wb_free(ring-&gt;adev, rin=
g-&gt;cond_exe_offs);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(ring-&gt;adev=
) &amp;&amp; ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_GFX)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_wb_free_256bit(ring-&gt;adev, ring-&gt;fence_offs);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_wb_free(ring-&gt;adev, ring-&gt;cond_exe_offs);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;ring-&gt;ring_obj,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ring-&gt;gpu_addr,<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BLUPR12MB0449B0A57E814A1849676E6084A10BLUPR12MB0449namp_--

--===============0920685969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0920685969==--
