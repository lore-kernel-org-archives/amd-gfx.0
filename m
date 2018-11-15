From: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same
 hive v2
Date: Thu, 15 Nov 2018 18:03:48 +0000
Message-ID: <BN6PR12MB1618A5A059D3991D0929012985DC0@BN6PR12MB1618.namprd12.prod.outlook.com>
References: <1542300861-16861-1-git-send-email-kent.russell@amd.com>,
 <DM5PR12MB1707C6F03FE35623CE42DE6E92DC0@DM5PR12MB1707.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2114324776=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1707C6F03FE35623CE42DE6E92DC0-2J9CzHegvk9TCtO+SvGBKwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>

--===============2114324776==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1618A5A059D3991D0929012985DC0BN6PR12MB1618namp_"

--_000_BN6PR12MB1618A5A059D3991D0929012985DC0BN6PR12MB1618namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

It was merged to 4.19 on Sept 21. It got missed on the 4.20 rebase.

Kent

KENT RUSSELL
Sr. Software Engineer | Linux Compute Kernel
1 Commerce Valley Drive East
Markham, ON L3T 7X6
O +(1) 289-695-2122 | Ext 72122
________________________________
From: Kuehling, Felix
Sent: Thursday, November 15, 2018 12:57:44 PM
To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Russell, Kent; Liu, Shaoyun
Subject: RE: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same=
 hive v2

This change is not suitable for amd-staging-drm-next. PCIe P2P was not enab=
led on amd-staging-drm-next because it's not reliable yet. This change enab=
les it even in situations that are not safe (including small BAR systems).

Why are you porting this change to amd-staging-drm-next? Does anyone depend=
 on XGMI support on this branch?

Regards,
  Felix

-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Russell,=
 Kent
Sent: Thursday, November 15, 2018 11:54 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org=
>
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

--_000_BN6PR12MB1618A5A059D3991D0929012985DC0BN6PR12MB1618namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body>
It was merged to 4.19 on Sept 21. It got missed on the 4.20 rebase.<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Sr. Software Engineer | Linux Compute Kernel<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
O &#43;(1) 289-695-2122 | Ext 72122<br>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Thursday, November 15, 2018 12:57:44 PM<br>
<b>To:</b> Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Russell, Kent; Liu, Shaoyun<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu : Use XGMI mapping when devices on t=
he same hive v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This change is not suitable for amd-staging-drm-ne=
xt. PCIe P2P was not enabled on amd-staging-drm-next because it's not relia=
ble yet. This change enables it even in situations that are not safe (inclu=
ding small BAR systems).<br>
<br>
Why are you porting this change to amd-staging-drm-next? Does anyone depend=
 on XGMI support on this branch?<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Ru=
ssell, Kent<br>
Sent: Thursday, November 15, 2018 11:54 AM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;; Liu, Shaoyun &lt;Shaoyun.Li=
u@amd.com&gt;<br>
Subject: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same hiv=
e v2<br>
<br>
From: Shaoyun Liu &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
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

--_000_BN6PR12MB1618A5A059D3991D0929012985DC0BN6PR12MB1618namp_--

--===============2114324776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2114324776==--
