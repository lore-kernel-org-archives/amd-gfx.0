From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Move compute vm bug logic to amdgpu_vm.c
Date: Thu, 1 Jun 2017 13:17:40 +0000
Message-ID: <MWHPR1201MB00450087F85C0B784DEE4BA2F2F60@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <1496272081-21584-1-git-send-email-AlexBin.Xie@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0865017748=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1496272081-21584-1-git-send-email-AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0865017748==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB00450087F85C0B784DEE4BA2F2F60MWHPR1201MB0045_"

--_000_MWHPR1201MB00450087F85C0B784DEE4BA2F2F60MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,


Please review this v2 patch. It is slightly faster.


Thanks,

Alex Bin

________________________________
From: Xie, AlexBin
Sent: Wednesday, May 31, 2017 7:08 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xie, AlexBin
Subject: [PATCH] drm/amdgpu: Move compute vm bug logic to amdgpu_vm.c

  In review, Christian would like to keep the logic
  inside amdgpu_vm.c with a cost of slightly slower.
  The loop is still optimized out with this patch.

v2: remove the if statement. Now it is not slower.

Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   | 32 -------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  5 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 38 ++++++++++++++++++++++++++=
++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
 5 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 89bc34a..2f1a4e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2227,6 +2227,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,

         adev->accel_working =3D true;

+       amdgpu_vm_check_compute_bug(adev);
+
         /* Initialize the buffer migration limit. */
         if (amdgpu_moverate >=3D 0)
                 max_MBps =3D amdgpu_moverate;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 7d95435..31aa51d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -153,36 +153,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
 }

 /**
- * amdgpu_ring_check_compute_vm_bug - check whether this ring has compute =
vm bug
- *
- * @adev: amdgpu_device pointer
- * @ring: amdgpu_ring structure holding ring information
- */
-static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device *adev,
-                                       struct amdgpu_ring *ring)
-{
-       const struct amdgpu_ip_block *ip_block;
-
-       ring->has_compute_vm_bug =3D false;
-
-       if (ring->funcs->type !=3D AMDGPU_RING_TYPE_COMPUTE)
-               /* only compute rings */
-               return;
-
-       ip_block =3D amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
-       if (!ip_block)
-               return;
-
-       /* Compute ring has a VM bug for GFX version < 7.
-           And compute ring has a VM bug for GFX 8 MEC firmware version < =
673.*/
-       if (ip_block->version->major <=3D 7) {
-               ring->has_compute_vm_bug =3D true;
-       } else if (ip_block->version->major =3D=3D 8)
-               if (adev->gfx.mec_fw_version < 673)
-                       ring->has_compute_vm_bug =3D true;
-}
-
-/**
  * amdgpu_ring_init - init driver ring struct.
  *
  * @adev: amdgpu_device pointer
@@ -288,8 +258,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct=
 amdgpu_ring *ring,
                 DRM_ERROR("Failed to register debugfs file for rings !\n")=
;
         }

-       amdgpu_ring_check_compute_vm_bug(adev, ring);
-
         return 0;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index 334307e..ad399c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -208,9 +208,4 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu=
_ring *ring)

 }

-static inline bool amdgpu_ring_has_compute_vm_bug(struct amdgpu_ring *ring=
)
-{
-       return ring->has_compute_vm_bug;
-}
-
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index d4d05a8..6e32748 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -656,6 +656,41 @@ static int amdgpu_vm_alloc_reserved_vmid(struct amdgpu=
_device *adev,
         return r;
 }

+/**
+ * amdgpu_vm_check_compute_bug - check whether asic has compute vm bug
+ *
+ * @adev: amdgpu_device pointer
+ */
+void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
+{
+       const struct amdgpu_ip_block *ip_block;
+       bool has_compute_vm_bug;
+       struct amdgpu_ring *ring;
+       int i;
+
+       has_compute_vm_bug =3D false;
+
+       ip_block =3D amdgpu_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
+       if (ip_block) {
+               /* Compute has a VM bug for GFX version < 7.
+                  Compute has a VM bug for GFX 8 MEC firmware version < 67=
3.*/
+               if (ip_block->version->major <=3D 7)
+                       has_compute_vm_bug =3D true;
+               else if (ip_block->version->major =3D=3D 8)
+                       if (adev->gfx.mec_fw_version < 673)
+                               has_compute_vm_bug =3D true;
+       }
+
+       for (i =3D 0; i < adev->num_rings; i++) {
+               ring =3D adev->rings[i];
+               if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE)
+                       /* only compute rings */
+                       ring->has_compute_vm_bug =3D has_compute_vm_bug;
+               else
+                       ring->has_compute_vm_bug =3D false;
+       }
+}
+
 bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job)
 {
@@ -664,8 +699,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *r=
ing,
         struct amdgpu_vm_id_manager *id_mgr =3D &adev->vm_manager.id_mgr[v=
mhub];
         struct amdgpu_vm_id *id;
         bool gds_switch_needed;
-       bool vm_flush_needed =3D job->vm_needs_flush ||
-               amdgpu_ring_has_compute_vm_bug(ring);
+       bool vm_flush_needed =3D job->vm_needs_flush || ring->has_compute_v=
m_bug;

         if (job->vm_id =3D=3D 0)
                 return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.h
index 8309bc7..f5dba9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -245,5 +245,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, =
uint64_t vm_size);
 int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *f=
ilp);
 bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job);
+void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);

 #endif
--
2.7.4


--_000_MWHPR1201MB00450087F85C0B784DEE4BA2F2F60MWHPR1201MB0045_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Christian,</p>
<p><br>
</p>
<p>Please review this v2 patch. It is slightly faster.</p>
<br>
<p>Thanks,</p>
<p>Alex Bin<br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Xie, AlexBin<br>
<b>Sent:</b> Wednesday, May 31, 2017 7:08 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Xie, AlexBin<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Move compute vm bug logic to amdgpu_vm.=
c</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&nbsp; In review, Christian would like to keep the=
 logic<br>
&nbsp; inside amdgpu_vm.c with a cost of slightly slower.<br>
&nbsp; The loop is still optimized out with this patch.<br>
<br>
v2: remove the if statement. Now it is not slower.<br>
<br>
Signed-off-by: Alex Xie &lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 2 &#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c&nbsp;&nbsp; | 32 -----------=
--------------<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h&nbsp;&nbsp; |&nbsp; 5 ----<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&nbsp; | 38 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp=
; 1 &#43;<br>
&nbsp;5 files changed, 39 insertions(&#43;), 39 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 89bc34a..2f1a4e9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2227,6 &#43;2227,8 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;accel_working =3D=
 true;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_check_compute_bug(adev)=
;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Initialize the buffer m=
igration limit. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_moverate &gt;=
=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; max_MBps =3D amdgpu_moverate;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c<br>
index 7d95435..31aa51d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
@@ -153,36 &#43;153,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)<br=
>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_ring_check_compute_vm_bug - check whether this ring has compute =
vm bug<br>
- *<br>
- * @adev: amdgpu_device pointer<br>
- * @ring: amdgpu_ring structure holding ring information<br>
- */<br>
-static void amdgpu_ring_check_compute_vm_bug(struct amdgpu_device *adev,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_ring *ring)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_ip_block *ip_bloc=
k;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_compute_vm_bug =3D false=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;type !=3D AMDG=
PU_RING_TYPE_COMPUTE)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* only compute rings */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_block =3D amdgpu_get_ip_block(adev=
, AMD_IP_BLOCK_TYPE_GFX);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ip_block)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Compute ring has a VM bug for GFX =
version &lt; 7.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; And compute r=
ing has a VM bug for GFX 8 MEC firmware version &lt; 673.*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ip_block-&gt;version-&gt;major &l=
t;=3D 7) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;has_compute_vm_bug =3D true;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (ip_block-&gt;version-&gt;m=
ajor =3D=3D 8)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.mec_fw_version &lt; 673)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has_com=
pute_vm_bug =3D true;<br>
-}<br>
-<br>
-/**<br>
&nbsp; * amdgpu_ring_init - init driver ring struct.<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
@@ -288,8 &#43;258,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, st=
ruct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to register debugfs file for r=
ings !\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_check_compute_vm_bug(adev=
, ring);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h<br>
index 334307e..ad399c8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
@@ -208,9 &#43;208,4 @@ static inline void amdgpu_ring_clear_ring(struct am=
dgpu_ring *ring)<br>
&nbsp;<br>
&nbsp;}<br>
&nbsp;<br>
-static inline bool amdgpu_ring_has_compute_vm_bug(struct amdgpu_ring *ring=
)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ring-&gt;has_compute_vm_bug;<b=
r>
-}<br>
-<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index d4d05a8..6e32748 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -656,6 &#43;656,41 @@ static int amdgpu_vm_alloc_reserved_vmid(struct am=
dgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;/**<br>
&#43; * amdgpu_vm_check_compute_bug - check whether asic has compute vm bug=
<br>
&#43; *<br>
&#43; * @adev: amdgpu_device pointer<br>
&#43; */<br>
&#43;void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_ip_block *ip_=
block;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_compute_vm_bug;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_compute_vm_bug =3D false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ip_block =3D amdgpu_get_ip_block(=
adev, AMD_IP_BLOCK_TYPE_GFX);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ip_block) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* Compute has a VM bug for GFX version &lt; 7.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Compute has a VM bug for GFX 8 MEC firmwar=
e version &lt; 673.*/<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ip_block-&gt;version-&gt;major &lt;=3D 7)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_compute_=
vm_bug =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else if (ip_block-&gt;version-&gt;major =3D=3D 8)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt=
;gfx.mec_fw_version &lt; 673)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_compute_vm_bug =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;num=
_rings; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ring =3D adev-&gt;rings[i];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;type =3D=3D AMDGPU_RING_TYPE_COMPUTE)=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only comp=
ute rings */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has=
_compute_vm_bug =3D has_compute_vm_bug;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;has=
_compute_vm_bug =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob)<br>
&nbsp;{<br>
@@ -664,8 &#43;699,7 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_rin=
g *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_id_manage=
r *id_mgr =3D &amp;adev-&gt;vm_manager.id_mgr[vmhub];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_id *id;<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool gds_switch_needed;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_flush_needed =3D job-&gt;vm_n=
eeds_flush ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ring_has_compute_vm_bug(ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vm_flush_needed =3D job-&gt;=
vm_needs_flush || ring-&gt;has_compute_vm_bug;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job-&gt;vm_id =3D=3D 0=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.h<br>
index 8309bc7..f5dba9c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
@@ -245,5 &#43;245,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *ad=
ev, uint64_t vm_size);<br>
&nbsp;int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_fi=
le *filp);<br>
&nbsp;bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob);<br>
&#43;void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB00450087F85C0B784DEE4BA2F2F60MWHPR1201MB0045_--

--===============0865017748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0865017748==--
