From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm V2] amdgpu: Fix a structure initialization issue
Date: Fri, 12 Apr 2019 14:43:46 +0000
Message-ID: <BN6PR12MB18097FB3E7D286517EC261E9F7280@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <SN6PR12MB28003FC8C9FBABC82C9C59AB87280@SN6PR12MB2800.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0647148549=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB28003FC8C9FBABC82C9C59AB87280-kxOKjb6HO/EqkY47FTA1ogdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0647148549==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18097FB3E7D286517EC261E9F7280BN6PR12MB1809namp_"

--_000_BN6PR12MB18097FB3E7D286517EC261E9F7280BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Pan, Xinhui
Sent: Friday, April 12, 2019 1:42 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander
Subject: [PATCH libdrm V2] amdgpu: Fix a structure initialization issue

struct drmPciBusInfo has been aligned to 6 bytes. So memcmp will access
the last byte which is not initialized.

Signed-off-by: xinhui pan <xinhui.pan-5C7GfCeVMHo@public.gmane.org>
---
 tests/amdgpu/ras_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/amdgpu/ras_tests.c b/tests/amdgpu/ras_tests.c
index 612ad1d7..81c34ad6 100644
--- a/tests/amdgpu/ras_tests.c
+++ b/tests/amdgpu/ras_tests.c
@@ -196,6 +196,7 @@ static int amdgpu_ras_lookup_id(drmDevicePtr device)

         for (i =3D 0; i < MAX_CARDS_SUPPORTED; i++) {
                 memset(str, 0, sizeof(str));
+               memset(&info, 0, sizeof(info));
                 sprintf(path, "/sys/kernel/debug/dri/%d/name", i);
                 if (get_file_contents(path, str, sizeof(str)) <=3D 0)
                         continue;
--
2.17.1


--_000_BN6PR12MB18097FB3E7D286517EC261E9F7280BN6PR12MB1809namp_
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Pan, Xinhui<br>
<b>Sent:</b> Friday, April 12, 2019 1:42 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH libdrm V2] amdgpu: Fix a structure initialization is=
sue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">struct drmPciBusInfo has been aligned to 6 bytes. =
So memcmp will access<br>
the last byte which is not initialized.<br>
<br>
Signed-off-by: xinhui pan &lt;xinhui.pan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;tests/amdgpu/ras_tests.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/tests/amdgpu/ras_tests.c b/tests/amdgpu/ras_tests.c<br>
index 612ad1d7..81c34ad6 100644<br>
--- a/tests/amdgpu/ras_tests.c<br>
&#43;&#43;&#43; b/tests/amdgpu/ras_tests.c<br>
@@ -196,6 &#43;196,7 @@ static int amdgpu_ras_lookup_id(drmDevicePtr device=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; MAX_C=
ARDS_SUPPORTED; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; memset(str, 0, sizeof(str));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; memset(&amp;info, 0, sizeof(info));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sprintf(path, &quot;/sys/kernel/debug/dri/%d/name&quo=
t;, i);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (get_file_contents(path, str, sizeof(str)) &lt;=3D=
 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18097FB3E7D286517EC261E9F7280BN6PR12MB1809namp_--

--===============0647148549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0647148549==--
