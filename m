From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/discovery: fix DCE_HWIP mapping error in
 hw_id_map array
Date: Thu, 11 Jul 2019 08:37:55 +0000
Message-ID: <MN2PR12MB2974F5A73CFA2BC7106E8C9C95F30@MN2PR12MB2974.namprd12.prod.outlook.com>
References: <1562832050-28203-1-git-send-email-tianci.yin@amd.com>,
 <CH2PR12MB3767908A917424D54CDC6CDAFEF30@CH2PR12MB3767.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0507021710=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CH2PR12MB3767908A917424D54CDC6CDAFEF30-rV3HgkLYx2Vb0rI3ZRjBIAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

--===============0507021710==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2974F5A73CFA2BC7106E8C9C95F30MN2PR12MB2974namp_"

--_000_MN2PR12MB2974F5A73CFA2BC7106E8C9C95F30MN2PR12MB2974namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Thanks Feifei and Xiaojie!
________________________________
From: Xu, Feifei
Sent: Thursday, July 11, 2019 16:28
To: Yin, Tianci (Rico); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xiao, Jack; Yuan, Xiaojie; Yin, Tianci (Rico); Zhang, Hawking
Subject: RE: [PATCH] drm/amdgpu/discovery: fix DCE_HWIP mapping error in hw=
_id_map array

Reviewed-by: Feifei Xu <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>

Regards,
Feifei

-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Tianci Y=
in
Sent: 2019=1B$BG/=1B(B7=1B$B7n=1B(B11=1B$BF|=1B(B 16:01
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>; Y=
in, Tianci (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>
Subject: [PATCH] drm/amdgpu/discovery: fix DCE_HWIP mapping error in hw_id_=
map array

From: tiancyin <tianci.yin-5C7GfCeVMHo@public.gmane.org>

ID of DCE_HWIP from vbios is DMU_HWID,
mismatch cause null pointer crash in navi10 modprobe.

Change-Id: I3be363cf5248de904b3bdae2f34d3bbe0bbbc07d
Signed-off-by: tiancyin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index e049ae6..1481899 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -123,7 +123,7 @@ static int hw_id_map[MAX_HWIP] =3D {
         [UVD_HWIP]      =3D UVD_HWID,
         [VCE_HWIP]      =3D VCE_HWID,
         [DF_HWIP]       =3D DF_HWID,
-       [DCE_HWIP]      =3D DCEAZ_HWID,
+       [DCE_HWIP]      =3D DMU_HWID,
         [OSSSYS_HWIP]   =3D OSSSYS_HWID,
         [SMUIO_HWIP]    =3D SMUIO_HWID,
         [PWR_HWIP]      =3D PWR_HWID,
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB2974F5A73CFA2BC7106E8C9C95F30MN2PR12MB2974namp_
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
Thanks Feifei and Xiaojie!<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xu, Feifei<br>
<b>Sent:</b> Thursday, July 11, 2019 16:28<br>
<b>To:</b> Yin, Tianci (Rico); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Xiao, Jack; Yuan, Xiaojie; Yin, Tianci (Rico); Zhang, Hawking<br=
>
<b>Subject:</b> RE: [PATCH] drm/amdgpu/discovery: fix DCE_HWIP mapping erro=
r in hw_id_map array</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reviewed-by: Feifei Xu &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
<br>
Regards,<br>
Feifei<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Ti=
anci Yin<br>
Sent: 2019=1B$BG/=1B(B7=1B$B7n=1B(B11=1B$BF|=1B(B 16:01<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan@am=
d.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &l=
t;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu/discovery: fix DCE_HWIP mapping error in hw_id_=
map array<br>
<br>
From: tiancyin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
ID of DCE_HWIP from vbios is DMU_HWID,<br>
mismatch cause null pointer crash in navi10 modprobe.<br>
<br>
Change-Id: I3be363cf5248de904b3bdae2f34d3bbe0bbbc07d<br>
Signed-off-by: tiancyin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index e049ae6..1481899 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -123,7 &#43;123,7 @@ static int hw_id_map[MAX_HWIP] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [UVD_HWIP]&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D UVD_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [VCE_HWIP]&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D VCE_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DF_HWIP]&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; =3D DF_HWID,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DCE_HWIP]&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D DCEAZ_HWID,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DCE_HWIP]&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; =3D DMU_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [OSSSYS_HWIP]&nbsp;&nbsp; =
=3D OSSSYS_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [SMUIO_HWIP]&nbsp;&nbsp;&n=
bsp; =3D SMUIO_HWID,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [PWR_HWIP]&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; =3D PWR_HWID,<br>
-- <br>
2.7.4<br>
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

--_000_MN2PR12MB2974F5A73CFA2BC7106E8C9C95F30MN2PR12MB2974namp_--

--===============0507021710==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0507021710==--
