From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: Fix a structure initialization issue
Date: Thu, 11 Apr 2019 14:16:09 +0000
Message-ID: <BN6PR12MB1809D1208D55E160E66BEE41F72F0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <SN6PR12MB280062745177BDAC40F69C49872F0@SN6PR12MB2800.namprd12.prod.outlook.com>,
 <BYAPR12MB2632F243319B7C06B6937452FC2F0@BYAPR12MB2632.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0693337184=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2632F243319B7C06B6937452FC2F0-ZGDeBxoHBPk+ukJnzp2+RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0693337184==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809D1208D55E160E66BEE41F72F0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809D1208D55E160E66BEE41F72F0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Please use memset rather than {0}.  Apparently some compilers don't like th=
at.

Alex
________________________________
From: Zhang, Hawking
Sent: Thursday, April 11, 2019 9:24 AM
To: Pan, Xinhui; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: RE: [PATCH libdrm] amdgpu: Fix a structure initialization issue

Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Pan, Xin=
hui
Sent: 2019=1B$BG/=1B(B4=1B$B7n=1B(B11=1B$BF|=1B(B 19:42
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH libdrm] amdgpu: Fix a structure initialization issue

struct drmPciBusInfo has been aligned to 6 bytes. So memcmp will access the=
 last byte which is not initialized. That causes the lookup function fails.

Signed-off-by: xinhui pan <xinhui.pan-5C7GfCeVMHo@public.gmane.org>
---
 tests/amdgpu/ras_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/amdgpu/ras_tests.c b/tests/amdgpu/ras_tests.c index 612a=
d1d7..ebe774fc 100644
--- a/tests/amdgpu/ras_tests.c
+++ b/tests/amdgpu/ras_tests.c
@@ -190,7 +190,7 @@ static int amdgpu_ras_lookup_id(drmDevicePtr device)  {
         char path[1024];
         char str[128];
-       drmPciBusInfo info;
+       drmPciBusInfo info =3D {0};
         int i;
         int ret;

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809D1208D55E160E66BEE41F72F0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Please use memset rather than {0}.&nbsp; Apparently some compilers don't li=
ke that.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking<br>
<b>Sent:</b> Thursday, April 11, 2019 9:24 AM<br>
<b>To:</b> Pan, Xinhui; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> RE: [PATCH libdrm] amdgpu: Fix a structure initialization i=
ssue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reviewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.c=
om&gt;<br>
<br>
Regards,<br>
Hawking<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Pa=
n, Xinhui<br>
Sent: 2019=1B$BG/=1B(B4=1B$B7n=1B(B11=1B$BF|=1B(B 19:42<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH libdrm] amdgpu: Fix a structure initialization issue<br>
<br>
struct drmPciBusInfo has been aligned to 6 bytes. So memcmp will access the=
 last byte which is not initialized. That causes the lookup function fails.=
<br>
<br>
Signed-off-by: xinhui pan &lt;xinhui.pan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;tests/amdgpu/ras_tests.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/tests/amdgpu/ras_tests.c b/tests/amdgpu/ras_tests.c index 612a=
d1d7..ebe774fc 100644<br>
--- a/tests/amdgpu/ras_tests.c<br>
&#43;&#43;&#43; b/tests/amdgpu/ras_tests.c<br>
@@ -190,7 &#43;190,7 @@ static int amdgpu_ras_lookup_id(drmDevicePtr device=
)&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char path[1024];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char str[128];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmPciBusInfo info;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drmPciBusInfo info =3D {0};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;<br>
--<br>
2.17.1<br>
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

--_000_BN6PR12MB1809D1208D55E160E66BEE41F72F0BN6PR12MB1809namp_--

--===============0693337184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0693337184==--
