From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix ras parameter descriptions
Date: Thu, 7 Mar 2019 13:34:29 +0000
Message-ID: <BN6PR12MB1809E0F41B96733548E9D437F74C0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190307070030.8559-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1067766403=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190307070030.8559-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1067766403==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809E0F41B96733548E9D437F74C0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809E0F41B96733548E9D437F74C0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, March 7, 2019 2:00 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Pan, Xinhui; Quan, Evan; Zhang, Hawking
Subject: [PATCH] drm/amdgpu: fix ras parameter descriptions

The descriptions of modinfo wrongly show two parameters
for each feature(see below). This patch can fix this
incorrect outputs.

parm:           amdgpu_ras_enable:Enable RAS features on the GPU (0 =3D dis=
able, 1 =3D enable, -1 =3D auto (default))
parm:           ras_enable:int
parm:           amdgpu_ras_mask:Mask of RAS features to enable (default 0xf=
fffffff), only valid when ras_enable =3D=3D 1
parm:           ras_mask:uint

Change-Id: I04f7e505cecca991f196802befd2006dc49b3dcf
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 38dbf6115c15..e0a7712d5d7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -512,18 +512,18 @@ MODULE_PARM_DESC(emu_mode, "Emulation mode, (1 =3D en=
able, 0 =3D disable)");
 module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);

 /*
- * DOC: amdgpu_ras_enable (int)
+ * DOC: ras_enable (int)
  * Enable RAS features on the GPU (0 =3D disable, 1 =3D enable, -1 =3D aut=
o (default))
  */
-MODULE_PARM_DESC(amdgpu_ras_enable, "Enable RAS features on the GPU (0 =3D=
 disable, 1 =3D enable, -1 =3D auto (default))");
+MODULE_PARM_DESC(ras_enable, "Enable RAS features on the GPU (0 =3D disabl=
e, 1 =3D enable, -1 =3D auto (default))");
 module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);

 /**
- * DOC: amdgpu_ras_mask (uint)
+ * DOC: ras_mask (uint)
  * Mask of RAS features to enable (default 0xffffffff), only valid when ra=
s_enable =3D=3D 1
  * See the flags in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
  */
-MODULE_PARM_DESC(amdgpu_ras_mask, "Mask of RAS features to enable (default=
 0xffffffff), only valid when ras_enable =3D=3D 1");
+MODULE_PARM_DESC(ras_mask, "Mask of RAS features to enable (default 0xffff=
ffff), only valid when ras_enable =3D=3D 1");
 module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);


--
2.21.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809E0F41B96733548E9D437F74C0BN6PR12MB1809namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Thursday, March 7, 2019 2:00 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Pan, Xinhui; Quan, Evan; Zhang, Hawking<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix ras parameter descriptions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The descriptions of modinfo wrongly show two param=
eters<br>
for each feature(see below). This patch can fix this<br>
incorrect outputs.<br>
<br>
parm:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ra=
s_enable:Enable RAS features on the GPU (0 =3D disable, 1 =3D enable, -1 =
=3D auto (default))<br>
parm:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_enabl=
e:int<br>
parm:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ra=
s_mask:Mask of RAS features to enable (default 0xffffffff), only valid when=
 ras_enable =3D=3D 1<br>
parm:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_mask:=
uint<br>
<br>
Change-Id: I04f7e505cecca991f196802befd2006dc49b3dcf<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 &#43;&#43;&#43;&#43;----<=
br>
&nbsp;1 file changed, 4 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 38dbf6115c15..e0a7712d5d7b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -512,18 &#43;512,18 @@ MODULE_PARM_DESC(emu_mode, &quot;Emulation mode, =
(1 =3D enable, 0 =3D disable)&quot;);<br>
&nbsp;module_param_named(emu_mode, amdgpu_emu_mode, int, 0444);<br>
&nbsp;<br>
&nbsp;/*<br>
- * DOC: amdgpu_ras_enable (int)<br>
&#43; * DOC: ras_enable (int)<br>
&nbsp; * Enable RAS features on the GPU (0 =3D disable, 1 =3D enable, -1 =
=3D auto (default))<br>
&nbsp; */<br>
-MODULE_PARM_DESC(amdgpu_ras_enable, &quot;Enable RAS features on the GPU (=
0 =3D disable, 1 =3D enable, -1 =3D auto (default))&quot;);<br>
&#43;MODULE_PARM_DESC(ras_enable, &quot;Enable RAS features on the GPU (0 =
=3D disable, 1 =3D enable, -1 =3D auto (default))&quot;);<br>
&nbsp;module_param_named(ras_enable, amdgpu_ras_enable, int, 0444);<br>
&nbsp;<br>
&nbsp;/**<br>
- * DOC: amdgpu_ras_mask (uint)<br>
&#43; * DOC: ras_mask (uint)<br>
&nbsp; * Mask of RAS features to enable (default 0xffffffff), only valid wh=
en ras_enable =3D=3D 1<br>
&nbsp; * See the flags in drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&nbsp; */<br>
-MODULE_PARM_DESC(amdgpu_ras_mask, &quot;Mask of RAS features to enable (de=
fault 0xffffffff), only valid when ras_enable =3D=3D 1&quot;);<br>
&#43;MODULE_PARM_DESC(ras_mask, &quot;Mask of RAS features to enable (defau=
lt 0xffffffff), only valid when ras_enable =3D=3D 1&quot;);<br>
&nbsp;module_param_named(ras_mask, amdgpu_ras_mask, uint, 0444);<br>
&nbsp;<br>
&nbsp;<br>
-- <br>
2.21.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809E0F41B96733548E9D437F74C0BN6PR12MB1809namp_--

--===============1067766403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1067766403==--
