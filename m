From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH AUTOSEL 4.19 29/53] drm/amdkfd: Add picasso pci id
Date: Sat, 27 Apr 2019 13:49:27 +0000
Message-ID: <BN6PR12MB18098B1A85760FCFFFDD3C37F73F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190427014051.7522-1-sashal@kernel.org>,
 <20190427014051.7522-29-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0197953096=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190427014051.7522-29-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
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
To: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0197953096==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18098B1A85760FCFFFDD3C37F73F0BN6PR12MB1809namp_"

--_000_BN6PR12MB18098B1A85760FCFFFDD3C37F73F0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

NACK.  4.19 did not contain support for picasso. Please drop this patch for=
 4.19.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Sasha Le=
vin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sent: Friday, April 26, 2019 9:40 PM
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Deucher, Alexander; Sasha Levin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-dev=
el-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH AUTOSEL 4.19 29/53] drm/amdkfd: Add picasso pci id

From: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

[ Upstream commit e7ad88553aa1d48e950ca9a4934d246c1bee4be4 ]

Picasso is a new raven variant.

Reviewed-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index 5aba50f63ac6..06d19bb89cfc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -275,6 +275,7 @@ static const struct kfd_deviceid supported_devices[] =
=3D {
         { 0x9876, &carrizo_device_info },       /* Carrizo */
         { 0x9877, &carrizo_device_info },       /* Carrizo */
         { 0x15DD, &raven_device_info },         /* Raven */
+       { 0x15D8, &raven_device_info },         /* Raven */
 #endif
         { 0x67A0, &hawaii_device_info },        /* Hawaii */
         { 0x67A1, &hawaii_device_info },        /* Hawaii */
--
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18098B1A85760FCFFFDD3C37F73F0BN6PR12MB1809namp_
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
NACK.&nbsp; 4.19 did not contain support for picasso. Please drop this patc=
h for 4.19.<br>
</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Sasha Levin &lt;sashal@kernel=
.org&gt;<br>
<b>Sent:</b> Friday, April 26, 2019 9:40 PM<br>
<b>To:</b> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Sasha Levin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; =
dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH AUTOSEL 4.19 29/53] drm/amdkfd: Add picasso pci id</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
[ Upstream commit e7ad88553aa1d48e950ca9a4934d246c1bee4be4 ]<br>
<br>
Picasso is a new raven variant.<br>
<br>
Reviewed-by: Kent Russell &lt;kent.russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Sasha Levin &lt;sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index 5aba50f63ac6..06d19bb89cfc 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -275,6 &#43;275,7 @@ static const struct kfd_deviceid supported_devices[=
] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x9876, &amp;carrizo_dev=
ice_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Carrizo */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x9877, &amp;carrizo_dev=
ice_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Carrizo */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x15DD, &amp;raven_devic=
e_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Raven */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x15D8, &amp;raven_device_info =
},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Raven */<br>
&nbsp;#endif<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x67A0, &amp;hawaii_devi=
ce_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Hawaii */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { 0x67A1, &amp;hawaii_devi=
ce_info },&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Hawaii */<br>
-- <br>
2.19.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18098B1A85760FCFFFDD3C37F73F0BN6PR12MB1809namp_--

--===============0197953096==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0197953096==--
