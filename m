From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: unify Vega20 PSP SOS firmwares for A0 and A1
Date: Fri, 14 Dec 2018 19:29:06 +0000
Message-ID: <5bfb953f-1c84-f258-20ee-3575ba066e6c@amd.com>
References: <20181213061451.29038-1-evan.quan@amd.com>
 <BN6PR12MB180900FC993E80DD7F22127AF7A00@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0610857483=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB180900FC993E80DD7F22127AF7A00-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0610857483==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_5bfb953f1c84f25820ee3575ba066e6camdcom_"

--_000_5bfb953f1c84f25820ee3575ba066e6camdcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

With this change in latest drm-next and related commit in latest FW i get


[  148.887374] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware loading fail=
ed
[  148.887535] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init of I=
P block <psp> failed -22


Had to revert to be able to boot.


Andrey

On 12/13/2018 10:05 AM, Deucher, Alexander wrote:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.deucher=
@amd.com>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org><mailto:=
evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, December 13, 2018 1:14:51 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Quan, Evan
Subject: [PATCH] drm/amdgpu: unify Vega20 PSP SOS firmwares for A0 and A1

The new PSP SOS firmware can support both A0 and A1.

Change-Id: I9bf85eb77b183a4403667c77e291e32689aed0af
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c
index 61cf2f6954e7..f3f5d4dd4631 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -34,14 +34,11 @@
 #include "nbio/nbio_7_4_offset.h"

 MODULE_FIRMWARE("amdgpu/vega20_sos.bin");
-MODULE_FIRMWARE("amdgpu/vega20_sos_old.bin");
 MODULE_FIRMWARE("amdgpu/vega20_ta.bin");

 /* address block */
 #define smnMP1_FIRMWARE_FLAGS           0x3010024

-#define VEGA20_BL_VERSION_VAR_NEW 0xA1
-
 static int
 psp_v11_0_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gfx_fw_=
type *type)
 {
@@ -104,7 +101,6 @@ static int psp_v11_0_init_microcode(struct psp_context =
*psp)
         int err =3D 0;
         const struct psp_firmware_header_v1_0 *sos_hdr;
         const struct ta_firmware_header_v1_0 *ta_hdr;
-       uint32_t bl_version;

         DRM_DEBUG("\n");

@@ -116,13 +112,7 @@ static int psp_v11_0_init_microcode(struct psp_context=
 *psp)
                 BUG();
         }

-       bl_version =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_100);
-       bl_version =3D (bl_version & 0xFF0000) >> 16;
-
-       if (bl_version =3D=3D VEGA20_BL_VERSION_VAR_NEW)
-               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chi=
p_name);
-       else
-               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos_old.bin",=
 chip_name);
+       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
         err =3D request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
         if (err)
                 goto out;
--
2.19.2

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_5bfb953f1c84f25820ee3575ba066e6camdcom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <191AB67061044D4AADA861BD4B303327-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<p>With this change in latest drm-next and related commit in latest FW i ge=
t <br>
</p>
<p><br>
</p>
<p>[&nbsp; 148.887374] [drm:psp_hw_init [amdgpu]] *ERROR* PSP firmware load=
ing failed<br>
[&nbsp; 148.887535] [drm:amdgpu_device_fw_loading [amdgpu]] *ERROR* hw_init=
 of IP block &lt;psp&gt; failed -22<br>
</p>
<p><br>
</p>
<p>Had to revert to be able to boot.</p>
<p><br>
</p>
<p>Andrey<br>
</p>
<br>
<div class=3D"moz-cite-prefix">On 12/13/2018 10:05 AM, Deucher, Alexander w=
rote:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:BN6PR12MB180900FC993E80DD7F22127AF7A0=
0@BN6PR12MB1809.namprd12.prod.outlook.com">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher <a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Evan Quan <a=
 class=3D"moz-txt-link-rfc2396E" href=3D"mailto:evan.quan-5C7GfCeVMHo@public.gmane.org">
&lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Thursday, December 13, 2018 1:14:51 AM<br>
<b>To:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> Quan, Evan<br>
<b>Subject:</b> [PATCH] drm/amdgpu: unify Vega20 PSP SOS firmwares for A0 a=
nd A1</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The new PSP SOS firmware can support both A0 and A=
1.<br>
<br>
Change-Id: I9bf85eb77b183a4403667c77e291e32689aed0af<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 12 &#43;-----------<br>
&nbsp;1 file changed, 1 insertion(&#43;), 11 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v11_0.c<br>
index 61cf2f6954e7..f3f5d4dd4631 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
@@ -34,14 &#43;34,11 @@<br>
&nbsp;#include &quot;nbio/nbio_7_4_offset.h&quot;<br>
&nbsp;<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega20_sos.bin&quot;);<br>
-MODULE_FIRMWARE(&quot;amdgpu/vega20_sos_old.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vega20_ta.bin&quot;);<br>
&nbsp;<br>
&nbsp;/* address block */<br>
&nbsp;#define smnMP1_FIRMWARE_FLAGS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x3010024<br>
&nbsp;<br>
-#define VEGA20_BL_VERSION_VAR_NEW 0xA1<br>
-<br>
&nbsp;static int<br>
&nbsp;psp_v11_0_get_fw_type(struct amdgpu_firmware_info *ucode, enum psp_gf=
x_fw_type *type)<br>
&nbsp;{<br>
@@ -104,7 &#43;101,6 @@ static int psp_v11_0_init_microcode(struct psp_cont=
ext *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int err =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct psp_firmware_=
header_v1_0 *sos_hdr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct ta_firmware_h=
eader_v1_0 *ta_hdr;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t bl_version;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_DEBUG(&quot;\n&quot;);=
<br>
&nbsp;<br>
@@ -116,13 &#43;112,7 @@ static int psp_v11_0_init_microcode(struct psp_con=
text *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; BUG();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bl_version =3D RREG32_SOC15(MP0, 0, m=
mMP0_SMN_C2PMSG_100);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bl_version =3D (bl_version &amp; 0xFF=
0000) &gt;&gt; 16;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bl_version =3D=3D VEGA20_BL_VERSI=
ON_VAR_NEW)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &quot;amdgpu/%s_sos.bin&quot;=
, chip_name);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; snprintf(fw_name, sizeof(fw_name), &quot;amdgpu/%s_sos_old.bin&q=
uot;, chip_name);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name)=
, &quot;amdgpu/%s_sos.bin&quot;, chip_name);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D request_firmware(&=
amp;adev-&gt;psp.sos_fw, fw_name, adev-&gt;dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out;<br>
-- <br>
2.19.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-n=
ot-send=3D"true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>=
<br>
</div>
</span></font></div>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre wrap=3D"">_______________________________________________
amd-gfx mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a>
</pre>
</blockquote>
<br>
</body>
</html>

--_000_5bfb953f1c84f25820ee3575ba066e6camdcom_--

--===============0610857483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0610857483==--
