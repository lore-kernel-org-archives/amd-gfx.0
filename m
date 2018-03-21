From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix "mitigate workaround for i915"
Date: Wed, 21 Mar 2018 13:58:04 +0000
Message-ID: <BN6PR12MB18095C145FEF342B0B625E69F7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180321130818.10130-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0702969817=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180321130818.10130-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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

--===============0702969817==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18095C145FEF342B0B625E69F7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB18095C145FEF342B0B625E69F7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, March 21, 2018 9:08:18 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdgpu: fix "mitigate workaround for i915"

Mixed up exporter and importer here. E.g. while mapping the BO we need
to check the importer not the exporter.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_prime.c
index 1c9991738477..4b584cb75bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
@@ -132,6 +132,7 @@ static int amdgpu_gem_map_attach(struct dma_buf *dma_bu=
f,
 {
         struct drm_gem_object *obj =3D dma_buf->priv;
         struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
+       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
         long r;

         r =3D drm_gem_map_attach(dma_buf, target_dev, attach);
@@ -143,7 +144,7 @@ static int amdgpu_gem_map_attach(struct dma_buf *dma_bu=
f,
                 goto error_detach;


-       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops) {
+       if (attach->dev->driver !=3D adev->dev->driver) {
                 /*
                  * Wait for all shared fences to complete before we switch=
 to future
                  * use of exclusive fence on this prime shared bo.
@@ -162,7 +163,7 @@ static int amdgpu_gem_map_attach(struct dma_buf *dma_bu=
f,
         if (r)
                 goto error_unreserve;

-       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops)
+       if (attach->dev->driver !=3D adev->dev->driver)
                 bo->prime_shared_count++;

 error_unreserve:
@@ -179,6 +180,7 @@ static void amdgpu_gem_map_detach(struct dma_buf *dma_b=
uf,
 {
         struct drm_gem_object *obj =3D dma_buf->priv;
         struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
+       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
         int ret =3D 0;

         ret =3D amdgpu_bo_reserve(bo, true);
@@ -186,7 +188,7 @@ static void amdgpu_gem_map_detach(struct dma_buf *dma_b=
uf,
                 goto error;

         amdgpu_bo_unpin(bo);
-       if (dma_buf->ops !=3D &amdgpu_dmabuf_ops && bo->prime_shared_count)
+       if (attach->dev->driver !=3D adev->dev->driver && bo->prime_shared_=
count)
                 bo->prime_shared_count--;
         amdgpu_bo_unreserve(bo);

--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



--_000_BN6PR12MB18095C145FEF342B0B625E69F7AA0BN6PR12MB1809namp_
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
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFo=
nt&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols;">
<p style=3D"margin-top:0; margin-bottom:0">Acked-by: Alex Deucher &lt;alexa=
nder.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoen=
ig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, March 21, 2018 9:08:18 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix &quot;mitigate workaround for i915&=
quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Mixed up exporter and importer here. E.g. while ma=
pping the BO we need<br>
to check the importer not the exporter.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c | 8 &#43;&#43;&#43;&#43;&#4=
3;---<br>
&nbsp;1 file changed, 5 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_prime.c<br>
index 1c9991738477..4b584cb75bf4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
@@ -132,6 &#43;132,7 @@ static int amdgpu_gem_map_attach(struct dma_buf *dm=
a_buf,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj=
 =3D dma_buf-&gt;priv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D g=
em_to_amdgpu_bo(obj);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D am=
dgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D drm_gem_map_attach(d=
ma_buf, target_dev, attach);<br>
@@ -143,7 &#43;144,7 @@ static int amdgpu_gem_map_attach(struct dma_buf *dm=
a_buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_detach;<br>
&nbsp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops !=3D &amp;amdgpu_=
dmabuf_ops) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attach-&gt;dev-&gt;driver !=
=3D adev-&gt;dev-&gt;driver) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * Wait for all shared fences to complete before=
 we switch to future<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; * use of exclusive fence on this prime shared b=
o.<br>
@@ -162,7 &#43;163,7 @@ static int amdgpu_gem_map_attach(struct dma_buf *dm=
a_buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error_unreserve;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops !=3D &amp;amdgpu_=
dmabuf_ops)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attach-&gt;dev-&gt;driver !=
=3D adev-&gt;dev-&gt;driver)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo-&gt;prime_shared_count&#43;&#43;;<br>
&nbsp;<br>
&nbsp;error_unreserve:<br>
@@ -179,6 &#43;180,7 @@ static void amdgpu_gem_map_detach(struct dma_buf *d=
ma_buf,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *obj=
 =3D dma_buf-&gt;priv;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D g=
em_to_amdgpu_bo(obj);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D am=
dgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(=
bo, true);<br>
@@ -186,7 &#43;188,7 @@ static void amdgpu_gem_map_detach(struct dma_buf *d=
ma_buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto error;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dma_buf-&gt;ops !=3D &amp;amdgpu_=
dmabuf_ops &amp;&amp; bo-&gt;prime_shared_count)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (attach-&gt;dev-&gt;driver !=
=3D adev-&gt;dev-&gt;driver &amp;&amp; bo-&gt;prime_shared_count)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bo-&gt;prime_shared_count--;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(bo);<b=
r>
&nbsp;<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk903702" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15216406630550.40395677032215027" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15216406630500.45676600463241457" style=3D"width: =
90%; background-color: rgb(255, 255, 255); position: relative; overflow: au=
to; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: =
1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200)=
;" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15216406630520.5642112536816963" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15216406630520.0327274396367363"></div>
<div id=3D"LPTitle_15216406630520.49192658759780994" style=3D"top: 0px; col=
or: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot=
;wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&=
quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-seri=
f; line-height: 21px;">
<a id=3D"LPUrlAnchor_15216406630530.7865030334449444" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15216406630540.4842775829210819" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15216406630540.08773502954535917" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma,=
 Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; =
overflow: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB18095C145FEF342B0B625E69F7AA0BN6PR12MB1809namp_--

--===============0702969817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0702969817==--
