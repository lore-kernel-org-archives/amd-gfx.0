From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable IP discovery by default on navi
Date: Mon, 8 Jul 2019 15:38:29 +0000
Message-ID: <BN6PR12MB180928A19CDDBF2845F07BA7F7F60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190703151341.5916-1-alexander.deucher@amd.com>,
 <20190703151341.5916-2-alexander.deucher@amd.com>,
 <BN8PR12MB36027C3FF20B1FAD06119E2D89F60@BN8PR12MB3602.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0800446377=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN8PR12MB36027C3FF20B1FAD06119E2D89F60-h6+T2+wrnx1lGJ5xs4l7kQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0800446377==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180928A19CDDBF2845F07BA7F7F60BN6PR12MB1809namp_"

--_000_BN6PR12MB180928A19CDDBF2845F07BA7F7F60BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

auto just means do the right thing for each asic.  For example, if there is=
 a new asic program and the discovery tables are not available yet, for tha=
t program, auto means don't use the discovery table.  For other programs wh=
ere the table is available (e.g., navi10 and 14), then auto means use the t=
able.

Alex
________________________________
From: Yuan, Xiaojie
Sent: Monday, July 8, 2019 11:31 AM
To: Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: Re: [PATCH 2/2] drm/amdgpu: enable IP discovery by default on navi

Hi Alex,

I see there are many 'auto' module params for amdgpu, could you please expl=
ain about the historical intention of using value '-1'?
and shall we check 'amdgpu_discovery' against '-1' for all the code paths i=
n amdgpu_device.c and navi10_reg_init.c?

BR,
Xiaojie

________________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, July 3, 2019 11:13 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH 2/2] drm/amdgpu: enable IP discovery by default on navi

Use the IP discovery table rather than hardcoding the
settings in the driver.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 7941a5368fb5..6f7772eeeb78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -140,7 +140,7 @@ uint amdgpu_smu_memory_pool_size =3D 0;
 uint amdgpu_dc_feature_mask =3D 0;
 int amdgpu_async_gfx_ring =3D 1;
 int amdgpu_mcbp =3D 0;
-int amdgpu_discovery =3D 0;
+int amdgpu_discovery =3D -1;
 int amdgpu_mes =3D 0;

 struct amdgpu_mgpu_info mgpu_info =3D {
@@ -592,6 +592,7 @@ module_param_named(mcbp, amdgpu_mcbp, int, 0444);
 /**
  * DOC: discovery (int)
  * Allow driver to discover hardware IP information from IP Discovery tabl=
e at the top of VRAM.
+ * (-1 =3D auto (default), 0 =3D disabled, 1 =3D enabled)
  */
 MODULE_PARM_DESC(discovery,
        "Allow driver to discover hardware IPs from IP Discovery table at t=
he top of VRAM");
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180928A19CDDBF2845F07BA7F7F60BN6PR12MB1809namp_
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
auto just means do the right thing for each asic.&nbsp; For example, if the=
re is a new asic program and the discovery tables are not available yet, fo=
r that program, auto means don't use the discovery table.&nbsp; For other p=
rograms where the table is available (e.g.,
 navi10 and 14), then auto means use the table.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yuan, Xiaojie<br>
<b>Sent:</b> Monday, July 8, 2019 11:31 AM<br>
<b>To:</b> Alex Deucher; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: enable IP discovery by default =
on navi</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Alex,<br>
<br>
I see there are many 'auto' module params for amdgpu, could you please expl=
ain about the historical intention of using value '-1'?<br>
and shall we check 'amdgpu_discovery' against '-1' for all the code paths i=
n amdgpu_device.c and navi10_reg_init.c?<br>
<br>
BR,<br>
Xiaojie<br>
<br>
________________________________________<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Al=
ex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
Sent: Wednesday, July 3, 2019 11:13 PM<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Deucher, Alexander<br>
Subject: [PATCH 2/2] drm/amdgpu: enable IP discovery by default on navi<br>
<br>
Use the IP discovery table rather than hardcoding the<br>
settings in the driver.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c<br>
index 7941a5368fb5..6f7772eeeb78 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
@@ -140,7 &#43;140,7 @@ uint amdgpu_smu_memory_pool_size =3D 0;<br>
&nbsp;uint amdgpu_dc_feature_mask =3D 0;<br>
&nbsp;int amdgpu_async_gfx_ring =3D 1;<br>
&nbsp;int amdgpu_mcbp =3D 0;<br>
-int amdgpu_discovery =3D 0;<br>
&#43;int amdgpu_discovery =3D -1;<br>
&nbsp;int amdgpu_mes =3D 0;<br>
<br>
&nbsp;struct amdgpu_mgpu_info mgpu_info =3D {<br>
@@ -592,6 &#43;592,7 @@ module_param_named(mcbp, amdgpu_mcbp, int, 0444);<b=
r>
&nbsp;/**<br>
&nbsp; * DOC: discovery (int)<br>
&nbsp; * Allow driver to discover hardware IP information from IP Discovery=
 table at the top of VRAM.<br>
&#43; * (-1 =3D auto (default), 0 =3D disabled, 1 =3D enabled)<br>
&nbsp; */<br>
&nbsp;MODULE_PARM_DESC(discovery,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Allow driver to discover h=
ardware IPs from IP Discovery table at the top of VRAM&quot;);<br>
--<br>
2.20.1<br>
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

--_000_BN6PR12MB180928A19CDDBF2845F07BA7F7F60BN6PR12MB1809namp_--

--===============0800446377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0800446377==--
