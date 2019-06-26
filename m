From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Set queue_preemption_timeout_ms default value
Date: Wed, 26 Jun 2019 15:26:11 +0000
Message-ID: <BN6PR12MB1809A633887862F6746B0E63F7E20@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1561562565-24858-1-git-send-email-Oak.Zeng@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1270146162=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1561562565-24858-1-git-send-email-Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Li,
 Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>

--===============1270146162==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A633887862F6746B0E63F7E20BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A633887862F6746B0E63F7E20BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Zeng, Oak
Sent: Wednesday, June 26, 2019 11:22 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Kuehling, Felix; Deucher, Alexander; Li, Candice; Zeng, Oak
Subject: [PATCH] drm/amdgpu: Set queue_preemption_timeout_ms default value

Set default value of this kernel parameter to 9000

Change-Id: If91db4d2c2ac08e25d7728d49629cbaec0d6c773
Signed-off-by: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 7cf6ab0..e74a175 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -700,7 +700,7 @@ MODULE_PARM_DESC(hws_gws_support, "MEC FW support gws b=
arriers (false =3D not supp
   * DOC: queue_preemption_timeout_ms (int)
   * queue preemption timeout in ms (1 =3D Minimum, 9000 =3D default)
   */
-int queue_preemption_timeout_ms;
+int queue_preemption_timeout_ms =3D 9000;
 module_param(queue_preemption_timeout_ms, int, 0644);
 MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in=
 ms (1 =3D Minimum, 9000 =3D default)");
 #endif
--
2.7.4


--_000_BN6PR12MB1809A633887862F6746B0E63F7E20BN6PR12MB1809namp_
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
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zeng, Oak<br>
<b>Sent:</b> Wednesday, June 26, 2019 11:22 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Kuehling, Felix; Deucher, Alexander; Li, Candice; Zeng, Oak<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Set queue_preemption_timeout_ms default=
 value</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Set default value of this kernel parameter to 9000=
<br>
<br>
Change-Id: If91db4d2c2ac08e25d7728d49629cbaec0d6c773<br>
Signed-off-by: Oak Zeng &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 7cf6ab0..e74a175 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -700,7 &#43;700,7 @@ MODULE_PARM_DESC(hws_gws_support, &quot;MEC FW supp=
ort gws barriers (false =3D not supp<br>
&nbsp;&nbsp; * DOC: queue_preemption_timeout_ms (int)<br>
&nbsp;&nbsp; * queue preemption timeout in ms (1 =3D Minimum, 9000 =3D defa=
ult)<br>
&nbsp;&nbsp; */<br>
-int queue_preemption_timeout_ms;<br>
&#43;int queue_preemption_timeout_ms =3D 9000;<br>
&nbsp;module_param(queue_preemption_timeout_ms, int, 0644);<br>
&nbsp;MODULE_PARM_DESC(queue_preemption_timeout_ms, &quot;queue preemption =
timeout in ms (1 =3D Minimum, 9000 =3D default)&quot;);<br>
&nbsp;#endif<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809A633887862F6746B0E63F7E20BN6PR12MB1809namp_--

--===============1270146162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1270146162==--
