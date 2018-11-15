From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same
 hive v2
Date: Thu, 15 Nov 2018 17:41:12 +0000
Message-ID: <BN6PR12MB1809901A7E7C5F066602CC8BF7DC0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1542300861-16861-1-git-send-email-kent.russell@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1196086002=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1542300861-16861-1-git-send-email-kent.russell-5C7GfCeVMHo@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

--===============1196086002==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809901A7E7C5F066602CC8BF7DC0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809901A7E7C5F066602CC8BF7DC0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex  Deucher <alexander.duecher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Russell,=
 Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, November 15, 2018 11:54:27 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Russell, Kent; Liu, Shaoyun
Subject: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same hiv=
e v2

From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

VM mapping will only fall back to P2P if XGMI mapping is not available

V2: Rebase onto 4.20

Change-Id: I7a854ab3d5c9958bd45d4fe439ea7e370a092e7a
Signed-off-by: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index dad0e23..576d168 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2011,6 +2011,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
         struct drm_mm_node *nodes;
         struct dma_fence *exclusive, **last_update;
         uint64_t flags;
+       uint64_t vram_base_offset =3D adev->vm_manager.vram_base_offset;
+       struct amdgpu_device *bo_adev;
         int r;

         if (clear || !bo) {
@@ -2029,9 +2031,19 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev,
                 exclusive =3D reservation_object_get_excl(bo->tbo.resv);
         }

-       if (bo)
+       if (bo) {
                 flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
-       else
+               bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
+               if (mem && mem->mem_type =3D=3D TTM_PL_VRAM && adev !=3D bo=
_adev) {
+                       if (adev->gmc.xgmi.hive_id &&
+                           adev->gmc.xgmi.hive_id =3D=3D bo_adev->gmc.xgmi=
.hive_id) {
+                               vram_base_offset =3D bo_adev->vm_manager.vr=
am_base_offset;
+                       } else {
+                               flags |=3D AMDGPU_PTE_SYSTEM;
+                               vram_base_offset =3D bo_adev->gmc.aper_base=
;
+                       }
+               }
+       } else
                 flags =3D 0x0;

         if (clear || (bo && bo->tbo.resv =3D=3D vm->root.base.bo->tbo.resv=
))
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809901A7E7C5F066602CC8BF7DC0BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex&nbsp; Deucher &=
lt;alexander.duecher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Russell, Kent &lt;Kent.Russel=
l@amd.com&gt;<br>
<b>Sent:</b> Thursday, November 15, 2018 11:54:27 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Russell, Kent; Liu, Shaoyun<br>
<b>Subject:</b> [PATCH] drm/amdgpu : Use XGMI mapping when devices on the s=
ame hive v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Shaoyun Liu &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
VM mapping will only fall back to P2P if XGMI mapping is not available<br>
<br>
V2: Rebase onto 4.20<br>
<br>
Change-Id: I7a854ab3d5c9958bd45d4fe439ea7e370a092e7a<br>
Signed-off-by: Shaoyun Liu &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Kent Russell &lt;kent.russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 16 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;1 file changed, 14 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index dad0e23..576d168 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -2011,6 &#43;2011,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ade=
v,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_mm_node *nodes;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *exclusiv=
e, **last_update;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t flags;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t vram_base_offset =3D ade=
v-&gt;vm_manager.vram_base_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *bo_adev;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clear || !bo) {<br>
@@ -2029,9 &#43;2031,19 @@ int amdgpu_vm_bo_update(struct amdgpu_device *ad=
ev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; exclusive =3D reservation_object_get_excl(bo-&gt;tbo.=
resv);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags =3D amdgpu_ttm_tt_pte_flags(adev, bo-&gt;tbo.tt=
m, mem);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; bo_adev =3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (mem &amp;&amp; mem-&gt;mem_type =3D=3D TTM_PL_VRAM &amp;=
&amp; adev !=3D bo_adev) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt=
;gmc.xgmi.hive_id &amp;&amp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; adev-&gt;gmc.xgmi.hive_id =3D=3D bo_adev-&gt;gmc.xgmi.hive_id) =
{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base_offset =3D bo_adev-&gt;vm_man=
ager.vram_base_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags |=3D AMDGPU_PTE_SYSTEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_base_offset =3D bo_adev-&gt;gmc.ap=
er_base;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags =3D 0x0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (clear || (bo &amp;&amp=
; bo-&gt;tbo.resv =3D=3D vm-&gt;root.base.bo-&gt;tbo.resv))<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809901A7E7C5F066602CC8BF7DC0BN6PR12MB1809namp_--

--===============1196086002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1196086002==--
