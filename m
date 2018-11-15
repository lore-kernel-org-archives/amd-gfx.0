From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same
 hive v2
Date: Thu, 15 Nov 2018 18:07:26 +0000
Message-ID: <DM5PR12MB1707F27DFFE12171929BD03692DC0@DM5PR12MB1707.namprd12.prod.outlook.com>
References: <1542300861-16861-1-git-send-email-kent.russell@amd.com>,
 <DM5PR12MB1707C6F03FE35623CE42DE6E92DC0@DM5PR12MB1707.namprd12.prod.outlook.com>
 <BN6PR12MB1618A5A059D3991D0929012985DC0@BN6PR12MB1618.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0868097827=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1618A5A059D3991D0929012985DC0-/b2+HYfkarRqaFUXYJa4HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0868097827==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1707F27DFFE12171929BD03692DC0DM5PR12MB1707namp_"

--_000_DM5PR12MB1707F27DFFE12171929BD03692DC0DM5PR12MB1707namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hmm, we should remove the PCIe portion of this change. We just added some e=
xtra checks there on amd-kfd-staging that should make it closer to upstream=
able. For now, just handle the XGMI case, but return -EINVAL in the else-br=
anch (for other remote VRAM cases).

Regards,
  Felix

From: Russell, Kent
Sent: Thursday, November 15, 2018 1:04 PM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Liu, Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same=
 hive v2

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
To: Russell, Kent; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org>
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
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Russell, Kent
Sent: Thursday, November 15, 2018 11:54 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org<mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org>>; Liu,=
 Shaoyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same hiv=
e v2

From: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>>

VM mapping will only fall back to P2P if XGMI mapping is not available

V2: Rebase onto 4.20

Change-Id: I7a854ab3d5c9958bd45d4fe439ea7e370a092e7a
Signed-off-by: Shaoyun Liu <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>=
>
Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling@a=
md.com>>
Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org<mailto:ray.huang-5C7GfCeVMHo@public.gmane.org>>
Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org<mailto:christian.k=
oenig-5C7GfCeVMHo@public.gmane.org>>
Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org<mailto:kent.russell@amd.c=
om>>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1707F27DFFE12171929BD03692DC0DM5PR12MB1707namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hmm, we should remove the PCIe portion of this chang=
e. We just added some extra checks there on amd-kfd-staging that should mak=
e it closer to upstreamable. For now, just handle the XGMI case, but return=
 -EINVAL in the else-branch (for other
 remote VRAM cases).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; Felix<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Russell, Kent <br>
<b>Sent:</b> Thursday, November 15, 2018 1:04 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org<br>
<b>Cc:</b> Liu, Shaoyun &lt;Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu : Use XGMI mapping when devices on t=
he same hive v2<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It was merged to 4.19 on Sept 21. It got missed on t=
he 4.20 rebase.<br>
<br>
Kent<br>
<br>
KENT RUSSELL<br>
Sr. Software Engineer | Linux Compute Kernel<br>
1 Commerce Valley Drive East<br>
Markham, ON L3T 7X6<br>
O &#43;(1) 289-695-2122 | Ext 72122<o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Kuehling, Felix<br>
<b>Sent:</b> Thursday, November 15, 2018 12:57:44 PM<br>
<b>To:</b> Russell, Kent; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Russell, Kent; Liu, Shaoyun<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu : Use XGMI mapping when devices on t=
he same hive v2</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">This change is not suitable for amd-staging-drm-next=
. PCIe P2P was not enabled on amd-staging-drm-next because it's not reliabl=
e yet. This change enables it even in situations that are not safe (includi=
ng small BAR systems).<br>
<br>
Why are you porting this change to amd-staging-drm-next? Does anyone depend=
 on XGMI support on this branch?<br>
<br>
Regards,<br>
&nbsp; Felix<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">=
amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; On Behalf Of Russell, Kent<br=
>
Sent: Thursday, November 15, 2018 11:54 AM<br>
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Cc: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org">Kent.Russell@=
amd.com</a>&gt;; Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org">Sh=
aoyun.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Subject: [PATCH] drm/amdgpu : Use XGMI mapping when devices on the same hiv=
e v2<br>
<br>
From: Shaoyun Liu &lt;<a href=3D"mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org">Shaoyun.Liu@am=
d.com</a>&gt;<br>
<br>
VM mapping will only fall back to P2P if XGMI mapping is not available<br>
<br>
V2: Rebase onto 4.20<br>
<br>
Change-Id: I7a854ab3d5c9958bd45d4fe439ea7e370a092e7a<br>
Signed-off-by: Shaoyun Liu &lt;<a href=3D"mailto:Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org">Shaoy=
un.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Reviewed-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Reviewed-by: Huang Rui &lt;<a href=3D"mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">ray.huang@a=
md.com</a>&gt;<br>
Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@amd.c=
om">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell-5C7GfCeVMHo@public.gmane.org">ken=
t.russell-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
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
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1707F27DFFE12171929BD03692DC0DM5PR12MB1707namp_--

--===============0868097827==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0868097827==--
