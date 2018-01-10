From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gfx9: fix ngg enablement to clear gds reserved
 memory
Date: Wed, 10 Jan 2018 08:21:15 +0000
Message-ID: <CY1PR12MB04744E78F973008AF37194F98C110@CY1PR12MB0474.namprd12.prod.outlook.com>
References: <1515572310-31508-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1145352344=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1515572310-31508-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1145352344==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB04744E78F973008AF37194F98C110CY1PR12MB0474namp_"

--_000_CY1PR12MB04744E78F973008AF37194F98C110CY1PR12MB0474namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Ken Wang<ken.wang-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, January 10, 2018 4:18:30 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wang, Ken; Zhang, Jerry
Subject: [PATCH] drm/amdgpu/gfx9: fix ngg enablement to clear gds reserved =
memory

Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index ae976e3..5f2ae77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1069,7 +1069,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device *ad=
ev)
         adev->gds.mem.total_size -=3D adev->gfx.ngg.gds_reserve_size;
         adev->gds.mem.gfx_partition_size -=3D adev->gfx.ngg.gds_reserve_si=
ze;
         adev->gfx.ngg.gds_reserve_addr =3D SOC15_REG_OFFSET(GC, 0, mmGDS_V=
MID0_BASE);
-       adev->gfx.ngg.gds_reserve_addr +=3D adev->gds.mem.gfx_partition_siz=
e;
+       adev->gfx.ngg.gds_reserve_addr +=3D SOC15_REG_OFFSET(GC, 0, mmGDS_V=
MID0_SIZE);

         /* Primitive Buffer */
         r =3D gfx_v9_0_ngg_create_buf(adev, &adev->gfx.ngg.buf[NGG_PRIM],
@@ -1181,13 +1181,15 @@ static int gfx_v9_0_ngg_en(struct amdgpu_device *ad=
ev)

         amdgpu_ring_write(ring, PACKET3(PACKET3_DMA_DATA, 5));
         amdgpu_ring_write(ring, (PACKET3_DMA_DATA_CP_SYNC |
+                               PACKET3_DMA_DATA_DST_SEL(0) |
                                 PACKET3_DMA_DATA_SRC_SEL(2)));
         amdgpu_ring_write(ring, 0);
         amdgpu_ring_write(ring, 0);
         amdgpu_ring_write(ring, adev->gfx.ngg.gds_reserve_addr);
         amdgpu_ring_write(ring, 0);
-       amdgpu_ring_write(ring, adev->gfx.ngg.gds_reserve_size);
-
+       amdgpu_ring_write(ring, PACKET3_DMA_DATA_CMD_DAS |
+                               PACKET3_DMA_DATA_CMD_RAW_WAIT |
+                               adev->gfx.ngg.gds_reserve_size);

         gfx_v9_0_write_data_to_reg(ring, 0, false,
                                    SOC15_REG_OFFSET(GC, 0, mmGDS_VMID0_SIZ=
E), 0);
--
1.9.1


--_000_CY1PR12MB04744E78F973008AF37194F98C110CY1PR12MB0474namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Ken Wang&lt;ken.wang=
@amd.com&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Junwei Zhang &lt;Jerr=
y.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 10, 2018 4:18:30 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wang, Ken; Zhang, Jerry<br>
<b>Subject:</b> [PATCH] drm/amdgpu/gfx9: fix ngg enablement to clear gds re=
served memory</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Junwei Zhang &lt;Jerry.Zhang-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 &#43;&#43;&#43;&#43;&#43;--=
-<br>
&nbsp;1 file changed, 5 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index ae976e3..5f2ae77 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -1069,7 &#43;1069,7 @@ static int gfx_v9_0_ngg_init(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.total_siz=
e -=3D adev-&gt;gfx.ngg.gds_reserve_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gds.mem.gfx_parti=
tion_size -=3D adev-&gt;gfx.ngg.gds_reserve_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ngg.gds_reser=
ve_addr =3D SOC15_REG_OFFSET(GC, 0, mmGDS_VMID0_BASE);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ngg.gds_reserve_addr &#4=
3;=3D adev-&gt;gds.mem.gfx_partition_size;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ngg.gds_reserve_addr=
 &#43;=3D SOC15_REG_OFFSET(GC, 0, mmGDS_VMID0_SIZE);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Primitive Buffer */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D gfx_v9_0_ngg_create_=
buf(adev, &amp;adev-&gt;gfx.ngg.buf[NGG_PRIM],<br>
@@ -1181,13 &#43;1181,15 @@ static int gfx_v9_0_ngg_en(struct amdgpu_device=
 *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET3(PACKET3_DMA_DATA, 5));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, (P=
ACKET3_DMA_DATA_CP_SYNC |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_DMA_DATA_DST_SEL(0) |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_DMA_DATA_SRC_SEL(2)));<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ad=
ev-&gt;gfx.ngg.gds_reserve_addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0)=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, adev-&gt;gfx.=
ngg.gds_reserve_size);<br>
-<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3_D=
MA_DATA_CMD_DAS |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PACKET3_DMA_DATA_CMD_RAW_WAIT |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.ngg.gds_reserve_size);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_write_data_to_reg=
(ring, 0, false,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_REG_OFFS=
ET(GC, 0, mmGDS_VMID0_SIZE), 0);<br>
-- <br>
1.9.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY1PR12MB04744E78F973008AF37194F98C110CY1PR12MB0474namp_--

--===============1145352344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1145352344==--
