From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp
Date: Mon, 11 Nov 2019 16:20:46 +0000
Message-ID: <CY4PR12MB1813EC85B44194B5F9390421F7740@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20191111044157.11356-1-Hawking.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0842196043=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191111044157.11356-1-Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Clements John <clements.john-5C7GfCeVMHo@public.gmane.org>, "Ma,
 Le" <Le.Ma-5C7GfCeVMHo@public.gmane.org>

--===============0842196043==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_"

--_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Sunday, November 10, 2019 11:41 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Clements John <clements.john-urvtwAKJhsc@public.gmane.org=
m>; Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Cc: Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp

xgmi, ras, hdcp and dtm ta are actually separated ucode and
need to handled case by case to upload to psp.

We support the case that ta binary have one or multiple of
them built-in. As a result, the driver should check each ta
binariy's availablity before decide to upload them to psp.

In the terminate (unload) case, the driver will check the
context readiness before perform unload activity. It's fine
to keep it as is.

Change-Id: I493116970ffb557f33c06de10f786684fdcef85b
Signed-off-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 456ac04b246c..9621e207a9ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -558,7 +558,9 @@ static int psp_xgmi_initialize(struct psp_context *psp)
         struct ta_xgmi_shared_memory *xgmi_cmd;
         int ret;

-       if (!psp->adev->psp.ta_fw)
+       if (!psp->adev->psp.ta_fw ||
+           !psp->adev->psp.ta_xgmi_ucode_size ||
+           !psp->adev->psp.ta_xgmi_start_addr)
                 return -ENOENT;

         if (!psp->xgmi_context.initialized) {
@@ -768,6 +770,12 @@ static int psp_ras_initialize(struct psp_context *psp)
 {
         int ret;

+       if (!psp->adev->psp.ta_ras_ucode_size ||
+           !psp->adev->psp.ta_ras_start_addr) {
+               dev_warn(psp->adev->dev, "RAS: ras ta ucode is not availabl=
e\n");
+               return 0;
+       }
+
         if (!psp->ras.ras_initialized) {
                 ret =3D psp_ras_init_shared_buf(psp);
                 if (ret)
@@ -857,6 +865,12 @@ static int psp_hdcp_initialize(struct psp_context *psp=
)
 {
         int ret;

+       if (!psp->adev->psp.ta_hdcp_ucode_size ||
+           !psp->adev->psp.ta_hdcp_start_addr) {
+               dev_warn(psp->adev->dev, "HDCP: hdcp ta ucode is not availa=
ble\n");
+               return 0;
+       }
+
         if (!psp->hdcp_context.hdcp_initialized) {
                 ret =3D psp_hdcp_init_shared_buf(psp);
                 if (ret)
@@ -1030,6 +1044,12 @@ static int psp_dtm_initialize(struct psp_context *ps=
p)
 {
         int ret;

+       if (!psp->adev->psp.ta_dtm_ucode_size ||
+           !psp->adev->psp.ta_dtm_start_addr) {
+               dev_warn(psp->adev->dev, "DTM: dtm ta ucode is not availabl=
e\n");
+               return 0;
+       }
+
         if (!psp->dtm_context.dtm_initialized) {
                 ret =3D psp_dtm_init_shared_buf(psp);
                 if (ret)
--
2.17.1


--_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hawking Zhang &lt;Haw=
king.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Sunday, November 10, 2019 11:41 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Clements John &l=
t;clements.john-5C7GfCeVMHo@public.gmane.org&gt;; Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: avoid upload corrupted ta ucode to psp<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">xgmi, ras, hdcp and dtm ta are actually separated =
ucode and<br>
need to handled case by case to upload to psp.<br>
<br>
We support the case that ta binary have one or multiple of<br>
them built-in. As a result, the driver should check each ta<br>
binariy's availablity before decide to upload them to psp.<br>
<br>
In the terminate (unload) case, the driver will check the<br>
context readiness before perform unload activity. It's fine<br>
to keep it as is.<br>
<br>
Change-Id: I493116970ffb557f33c06de10f786684fdcef85b<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 22 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;-<br>
&nbsp;1 file changed, 21 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 456ac04b246c..9621e207a9ca 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -558,7 &#43;558,9 @@ static int psp_xgmi_initialize(struct psp_context *=
psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ta_xgmi_shared_memo=
ry *xgmi_cmd;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_fw)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_fw |=
|<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_xgmi_ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_xgmi_start_addr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOENT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;xgmi_context.=
initialized) {<br>
@@ -768,6 &#43;770,12 @@ static int psp_ras_initialize(struct psp_context *=
psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_ras_=
ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_ras_start_addr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;RAS: ras ta ucode is no=
t available\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;ras.ras_initi=
alized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -857,6 &#43;865,12 @@ static int psp_hdcp_initialize(struct psp_context =
*psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_hdcp=
_ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_hdcp_start_addr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;HDCP: hdcp ta ucode is =
not available\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;hdcp_context.=
hdcp_initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_hdcp_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
@@ -1030,6 &#43;1044,12 @@ static int psp_dtm_initialize(struct psp_context=
 *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_dtm_=
ucode_size ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;=
adev-&gt;psp.ta_dtm_start_addr) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;DTM: dtm ta ucode is no=
t available\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;dtm_context.d=
tm_initialized) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D psp_dtm_init_shared_buf(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1813EC85B44194B5F9390421F7740CY4PR12MB1813namp_--

--===============0842196043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0842196043==--
