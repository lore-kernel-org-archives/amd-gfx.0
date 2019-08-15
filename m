From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: add firmware header printing for psp fw
 loading
Date: Thu, 15 Aug 2019 13:40:46 +0000
Message-ID: <BN6PR12MB180964CBF7F0391D91F69D51F7AC0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190815094815.20819-1-xiaojie.yuan@amd.com>,
 <20190815094815.20819-2-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0231450004=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190815094815.20819-2-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0231450004==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180964CBF7F0391D91F69D51F7AC0BN6PR12MB1809namp_"

--_000_BN6PR12MB180964CBF7F0391D91F69D51F7AC0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yuan, Xi=
aojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 15, 2019 5:48 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Yuan, X=
iaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amdgpu: add firmware header printing for psp fw lo=
ading

firmware header information is printed for direct fw loading but not
added for psp fw loading yet

Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 54 +++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 4b2d2fd72dc6..7715c0da5229 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -944,6 +944,58 @@ static int psp_get_fw_type(struct amdgpu_firmware_info=
 *ucode,
         return 0;
 }

+static void psp_print_fw_hdr(struct psp_context *psp,
+                            struct amdgpu_firmware_info *ucode)
+{
+       struct amdgpu_device *adev =3D psp->adev;
+       const struct sdma_firmware_header_v1_0 *sdma_hdr =3D
+               (const struct sdma_firmware_header_v1_0 *)
+               adev->sdma.instance[ucode->ucode_id - AMDGPU_UCODE_ID_SDMA0=
].fw->data;
+       const struct gfx_firmware_header_v1_0 *ce_hdr =3D
+               (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->d=
ata;
+       const struct gfx_firmware_header_v1_0 *pfp_hdr =3D
+               (const struct gfx_firmware_header_v1_0 *)adev->gfx.pfp_fw->=
data;
+       const struct gfx_firmware_header_v1_0 *me_hdr =3D
+               (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->d=
ata;
+       const struct gfx_firmware_header_v1_0 *mec_hdr =3D
+               (const struct gfx_firmware_header_v1_0 *)adev->gfx.mec_fw->=
data;
+       const struct rlc_firmware_header_v2_0 *rlc_hdr =3D
+               (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->=
data;
+       const struct smc_firmware_header_v1_0 *smc_hdr =3D
+               (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
+
+       switch (ucode->ucode_id) {
+       case AMDGPU_UCODE_ID_SDMA0:
+       case AMDGPU_UCODE_ID_SDMA1:
+       case AMDGPU_UCODE_ID_SDMA2:
+       case AMDGPU_UCODE_ID_SDMA3:
+       case AMDGPU_UCODE_ID_SDMA4:
+       case AMDGPU_UCODE_ID_SDMA5:
+       case AMDGPU_UCODE_ID_SDMA6:
+       case AMDGPU_UCODE_ID_SDMA7:
+               amdgpu_ucode_print_sdma_hdr(&sdma_hdr->header);
+               break;
+       case AMDGPU_UCODE_ID_CP_CE:
+               amdgpu_ucode_print_gfx_hdr(&ce_hdr->header);
+               break;
+       case AMDGPU_UCODE_ID_CP_PFP:
+               amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
+               break;
+       case AMDGPU_UCODE_ID_CP_ME:
+               amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+               break;
+       case AMDGPU_UCODE_ID_CP_MEC1:
+               amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+               break;
+       case AMDGPU_UCODE_ID_RLC_G:
+               amdgpu_ucode_print_rlc_hdr(&rlc_hdr->header);
+               break;
+       case AMDGPU_UCODE_ID_SMC:
+               amdgpu_ucode_print_smc_hdr(&smc_hdr->header);
+               break;
+       }
+}
+
 static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
                                        struct psp_gfx_cmd_resp *cmd)
 {
@@ -1028,6 +1080,8 @@ static int psp_np_fw_load(struct psp_context *psp)
                     ucode->ucode_id =3D=3D AMDGPU_UCODE_ID_CP_MEC2_JT)
                         continue;

+               psp_print_fw_hdr(psp, ucode);
+
                 ret =3D psp_execute_np_fw_load(psp, ucode);
                 if (ret)
                         return ret;
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180964CBF7F0391D91F69D51F7AC0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yuan, Xiaojie &lt;Xiaojie.Yua=
n@amd.com&gt;<br>
<b>Sent:</b> Thursday, August 15, 2019 5:48 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.Huang@a=
md.com&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;=
Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: add firmware header printing for ps=
p fw loading</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">firmware header information is printed for direct =
fw loading but not<br>
added for psp fw loading yet<br>
<br>
Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 54 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 54 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 4b2d2fd72dc6..7715c0da5229 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -944,6 &#43;944,58 @@ static int psp_get_fw_type(struct amdgpu_firmware_=
info *ucode,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void psp_print_fw_hdr(struct psp_context *psp,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; struct amdgpu_firmware_info *ucode)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ps=
p-&gt;adev;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct sdma_firmware_header=
_v1_0 *sdma_hdr =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (const struct sdma_firmware_header_v1_0 *)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;sdma.instance[ucode-&gt;ucode_id - AMDGPU_UCODE_ID_=
SDMA0].fw-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_=
v1_0 *ce_hdr =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.ce_fw-=
&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_=
v1_0 *pfp_hdr =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.pfp_fw=
-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_=
v1_0 *me_hdr =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.me_fw-=
&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct gfx_firmware_header_=
v1_0 *mec_hdr =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (const struct gfx_firmware_header_v1_0 *)adev-&gt;gfx.mec_fw=
-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct rlc_firmware_header_=
v2_0 *rlc_hdr =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (const struct rlc_firmware_header_v2_0 *)adev-&gt;gfx.rlc_fw=
-&gt;data;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct smc_firmware_header_=
v1_0 *smc_hdr =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (const struct smc_firmware_header_v1_0 *)adev-&gt;pm.fw-&gt;=
data;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ucode-&gt;ucode_id) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA0:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA1:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA2:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA3:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA4:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA5:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA6:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SDMA7:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_sdma_hdr(&amp;sdma_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_CE:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;ce_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_PFP:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;pfp_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_ME:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;me_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_CP_MEC1:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_gfx_hdr(&amp;mec_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_RLC_G:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_rlc_hdr(&amp;rlc_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_UCODE_ID_SMC:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_print_smc_hdr(&amp;smc_hdr-&gt;header);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *u=
code,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct psp_gfx_cmd_resp *cmd)<br>
&nbsp;{<br>
@@ -1028,6 &#43;1080,8 @@ static int psp_np_fw_load(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ucode-&gt;ucode_id =3D=3D AMD=
GPU_UCODE_ID_CP_MEC2_JT)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; psp_print_fw_hdr(psp, ucode);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_execute_np_fw_load(psp, ucode);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180964CBF7F0391D91F69D51F7AC0BN6PR12MB1809namp_--

--===============0231450004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0231450004==--
