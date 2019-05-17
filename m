From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: use div64_ul for 32-bit compatibility v1
Date: Fri, 17 May 2019 18:34:48 +0000
Message-ID: <DM5PR12MB14176FD13FDBCDBB309D0301FE0B0@DM5PR12MB1417.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1301912963=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>

--===============1301912963==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB14176FD13FDBCDBB309D0301FE0B0DM5PR12MB1417namp_"

--_000_DM5PR12MB14176FD13FDBCDBB309D0301FE0B0DM5PR12MB1417namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

v1: replace casting to unsigned long with div64_ul

Change-Id: Ia48671ed0756bb73c7b4760a800bcb6f600cbef2
Signed-off-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index da1dc40b9b14..d5719b0fb82c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -764,8 +764,8 @@ static ssize_t amdgpu_ras_sysfs_badpages_read(struct fi=
le *f,
  struct amdgpu_device *adev =3D con->adev;
  const unsigned int element_size =3D
  sizeof("0xabcdabcd : 0x12345678 : R\n") - 1;
- unsigned int start =3D (ppos + element_size - 1) / element_size;
- unsigned int end =3D (ppos + count - 1) / element_size;
+ unsigned int start =3D div64_ul(ppos + element_size - 1, element_size);
+ unsigned int end =3D div64_ul(ppos + count - 1, element_size);
  ssize_t s =3D 0;
  struct ras_badpage *bps =3D NULL;
  unsigned int bps_count =3D 0;
--
2.17.1



--_000_DM5PR12MB14176FD13FDBCDBB309D0301FE0B0DM5PR12MB1417namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>v1: replace casting to unsigned long with div64_ul</div>
<div><br>
</div>
<div>Change-Id: Ia48671ed0756bb73c7b4760a800bcb6f600cbef2</div>
<div>Signed-off-by: Slava Abramov &lt;slava.abramov-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div>---</div>
<div>&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 &#43;&#43;--</div>
<div>&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)</div>
<div><br>
</div>
<div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ras.c</div>
<div>index da1dc40b9b14..d5719b0fb82c 100644</div>
<div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
<div>&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
<div>@@ -764,8 &#43;764,8 @@ static ssize_t amdgpu_ras_sysfs_badpages_read(=
struct file *f,</div>
<div>&nbsp;<span style=3D"white-space:pre"> </span>struct amdgpu_device *ad=
ev =3D con-&gt;adev;</div>
<div>&nbsp;<span style=3D"white-space:pre"> </span>const unsigned int eleme=
nt_size =3D</div>
<div>&nbsp;<span style=3D"white-space:pre"> </span>sizeof(&quot;0xabcdabcd =
: 0x12345678 : R\n&quot;) - 1;</div>
<div>-<span style=3D"white-space:pre"> </span>unsigned int start =3D (ppos =
&#43; element_size - 1) / element_size;</div>
<div>-<span style=3D"white-space:pre"> </span>unsigned int end =3D (ppos &#=
43; count - 1) / element_size;</div>
<div>&#43;<span style=3D"white-space:pre"> </span>unsigned int start =3D di=
v64_ul(ppos &#43; element_size - 1, element_size);</div>
<div>&#43;<span style=3D"white-space:pre"> </span>unsigned int end =3D div6=
4_ul(ppos &#43; count - 1, element_size);</div>
<div>&nbsp;<span style=3D"white-space:pre"> </span>ssize_t s =3D 0;</div>
<div>&nbsp;<span style=3D"white-space:pre"> </span>struct ras_badpage *bps =
=3D NULL;</div>
<div>&nbsp;<span style=3D"white-space:pre"> </span>unsigned int bps_count =
=3D 0;</div>
<div>--&nbsp;</div>
<div>2.17.1</div>
<div><br>
</div>
<br>
<p></p>
</div>
</body>
</html>

--_000_DM5PR12MB14176FD13FDBCDBB309D0301FE0B0DM5PR12MB1417namp_--

--===============1301912963==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1301912963==--
