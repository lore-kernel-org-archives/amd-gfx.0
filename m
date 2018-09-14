From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: revert "stop using gart_start as offset
 for the GTT domain"
Date: Fri, 14 Sep 2018 13:48:02 +0000
Message-ID: <BN6PR12MB18097687C7B140A7B15561A9F7190@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180914105728.1641-1-christian.koenig@amd.com>,
 <20180914105728.1641-2-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1626373444=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180914105728.1641-2-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

--===============1626373444==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18097687C7B140A7B15561A9F7190BN6PR12MB1809namp_"

--_000_BN6PR12MB18097687C7B140A7B15561A9F7190BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, September 14, 2018 6:57:28 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH 2/2] drm/amdgpu: revert "stop using gart_start as offset fo=
r the GTT domain"

Turned out the commit is incomplete and since we remove using the AGP
mapping from the GTT manager it is also not necessary any more.

This reverts commit 22d8bfafcc12dfa17b91d2e8ae4e1898e782003a.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gtt_mgr.c
index c2539f6821c0..da7b1b92d9cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -143,8 +143,7 @@ static int amdgpu_gtt_mgr_alloc(struct ttm_mem_type_man=
ager *man,
         spin_unlock(&mgr->lock);

         if (!r)
-               mem->start =3D node->node.start +
-                       (adev->gmc.gart_start >> PAGE_SHIFT);
+               mem->start =3D node->node.start;

         return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 8a158ee922f7..f12ae6b525b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -188,7 +188,7 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *b=
dev, uint32_t type,
         case TTM_PL_TT:
                 /* GTT memory  */
                 man->func =3D &amdgpu_gtt_mgr_func;
-               man->gpu_offset =3D 0;
+               man->gpu_offset =3D adev->gmc.gart_start;
                 man->available_caching =3D TTM_PL_MASK_CACHING;
                 man->default_caching =3D TTM_PL_FLAG_CACHED;
                 man->flags =3D TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEMTYPE_FLA=
G_CMA;
@@ -1060,7 +1060,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_tt *ttm=
,
         flags =3D amdgpu_ttm_tt_pte_flags(adev, ttm, bo_mem);

         /* bind pages into GART page tables */
-       gtt->offset =3D ((u64)bo_mem->start << PAGE_SHIFT) - adev->gmc.gart=
_start;
+       gtt->offset =3D (u64)bo_mem->start << PAGE_SHIFT;
         r =3D amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
                 ttm->pages, gtt->ttm.dma_address, flags);

@@ -1112,8 +1112,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *b=
o)
                 flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->ttm, &tmp);

                 /* Bind pages */
-               gtt->offset =3D ((u64)tmp.start << PAGE_SHIFT) -
-                       adev->gmc.gart_start;
+               gtt->offset =3D (u64)tmp.start << PAGE_SHIFT;
                 r =3D amdgpu_ttm_gart_bind(adev, bo, flags);
                 if (unlikely(r)) {
                         ttm_bo_mem_put(bo, &tmp);
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18097687C7B140A7B15561A9F7190BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span>Acked-by: Alex Deucher &lt;=
alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoenig=
.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, September 14, 2018 6:57:28 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: revert &quot;stop using gart_start =
as offset for the GTT domain&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Turned out the commit is incomplete and since we r=
emove using the AGP<br>
mapping from the GTT manager it is also not necessary any more.<br>
<br>
This reverts commit 22d8bfafcc12dfa17b91d2e8ae4e1898e782003a.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 3 &#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&nbsp; | 7 &=
#43;&#43;&#43;----<br>
&nbsp;2 files changed, 4 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gtt_mgr.c<br>
index c2539f6821c0..da7b1b92d9cf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c<br>
@@ -143,8 &#43;143,7 @@ static int amdgpu_gtt_mgr_alloc(struct ttm_mem_type=
_manager *man,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;mgr-&gt;l=
ock);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mem-&gt;start =3D node-&gt;node.start &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt;gmc.ga=
rt_start &gt;&gt; PAGE_SHIFT);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mem-&gt;start =3D node-&gt;node.start;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c<br>
index 8a158ee922f7..f12ae6b525b9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
@@ -188,7 &#43;188,7 @@ static int amdgpu_init_mem_type(struct ttm_bo_devic=
e *bdev, uint32_t type,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TTM_PL_TT:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* GTT memory&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; man-&gt;func =3D &amp;amdgpu_gtt_mgr_func;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; man-&gt;gpu_offset =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; man-&gt;gpu_offset =3D adev-&gt;gmc.gart_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; man-&gt;available_caching =3D TTM_PL_MASK_CACHING;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; man-&gt;default_caching =3D TTM_PL_FLAG_CACHED;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; man-&gt;flags =3D TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEM=
TYPE_FLAG_CMA;<br>
@@ -1060,7 &#43;1060,7 @@ static int amdgpu_ttm_backend_bind(struct ttm_tt =
*ttm,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags =3D amdgpu_ttm_tt_pt=
e_flags(adev, ttm, bo_mem);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bind pages into GART pa=
ge tables */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;offset =3D ((u64)bo_mem-&gt;s=
tart &lt;&lt; PAGE_SHIFT) - adev-&gt;gmc.gart_start;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtt-&gt;offset =3D (u64)bo_mem-&g=
t;start &lt;&lt; PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gart_bind(ade=
v, gtt-&gt;offset, ttm-&gt;num_pages,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ttm-&gt;pages, gtt-&gt;ttm.dma_address, flags);<br>
&nbsp;<br>
@@ -1112,8 &#43;1112,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_objec=
t *bo)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; flags =3D amdgpu_ttm_tt_pte_flags(adev, bo-&gt;ttm, &=
amp;tmp);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Bind pages */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; gtt-&gt;offset =3D ((u64)tmp.start &lt;&lt; PAGE_SHIFT) -<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.gar=
t_start;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gtt-&gt;offset =3D (u64)tmp.start &lt;&lt; PAGE_SHIFT;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ttm_gart_bind(adev, bo, flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (unlikely(r)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_b=
o_mem_put(bo, &amp;tmp);<br>
-- <br>
2.14.1<br>
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

--_000_BN6PR12MB18097687C7B140A7B15561A9F7190BN6PR12MB1809namp_--

--===============1626373444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1626373444==--
