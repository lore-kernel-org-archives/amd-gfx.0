From: "Ma, Le" <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost
 warning message
Date: Wed, 27 Nov 2019 09:54:56 +0000
Message-ID: <MN2PR12MB42858C745C5D0D125236BD51F6440@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-9-git-send-email-le.ma@amd.com>
 <BYAPR12MB280648A1C59519AA77B3FCA9F1440@BYAPR12MB2806.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1626797980=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB280648A1C59519AA77B3FCA9F1440-ZGDeBxoHBPk0CuAkIMgl3QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou1,
 Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1626797980==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_"

--_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable





-----Original Message-----
From: Chen, Guchun <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 27, 2019 5:50 PM
To: Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>;=
 Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@amd.=
com>; Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost wa=
rning message



[AMD Official Use Only - Internal Distribution Only]









-----Original Message-----

From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org<mailto:le.ma-5C7GfCeVMHo@public.gmane.org>>

Sent: Wednesday, November 27, 2019 5:15 PM

To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Cc: Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org<mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>>; C=
hen, Guchun <Guchun.Chen-5C7GfCeVMHo@public.gmane.org<mailto:Guchun.Chen-5C7GfCeVMHo@public.gmane.org>>; Zhou1, Tao <=
Tao.Zhou1-5C7GfCeVMHo@public.gmane.org<mailto:Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>>; Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org=
<mailto:Dennis.Li-5C7GfCeVMHo@public.gmane.org>>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<=
mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>; Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org<mailto:Le.Ma@amd.=
com>>

Subject: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost warnin=
g message



Move the print out of uvd instance loop in amdgpu_uvd_suspend



Change-Id: Ifad997debd84763e1b55d668e144b729598f115e

Signed-off-by: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org<mailto:le.ma-5C7GfCeVMHo@public.gmane.org>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 5 ++++-

1 file changed, 4 insertions(+), 1 deletion(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_uvd.c

index e324bfe..ac7c7795 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c

@@ -377,12 +377,15 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)

                        /* re-write 0 since err_event_athub will corrupt VC=
PU buffer */

                       if (amdgpu_ras_intr_triggered()) {

-                                   DRM_WARN("UVD VCPU state may lost due t=
o RAS ERREVENT_ATHUB_INTERRUPT\n");

                                   memset(adev->uvd.inst[j].saved_bo, 0, si=
ze);

                       } else {

                                   memcpy_fromio(adev->uvd.inst[j].saved_bo=
, ptr, size);

                       }

           }

+

+          if (amdgpu_ras_intr_triggered()) {

+                      DRM_WARN("UVD VCPU state may lost due to RAS ERREVEN=
T_ATHUB_INTERRUPT\n");

+

[Guchun]the "{" after the if condition needs to be removed?

[Le] Yes, sent it too quickly and made a mistake here.

           return 0;

}

--

2.7.4

--_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Chen, Guchun &lt;Guchun.Chen-5C7GfCeVMHo@public.gmane.org&gt; <br>
Sent: Wednesday, November 27, 2019 5:50 PM<br>
To: Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao &lt;Tao.Zhou1@=
amd.com&gt;; Li, Dennis &lt;Dennis.Li-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &lt;A=
lexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: RE: [PATCH 10/10] drm/amdgpu: reduce redundant uvd context lost wa=
rning message</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[AMD Official Use Only - Internal Distribution On=
ly]<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Le Ma &lt;<a href=3D"mailto:le.ma-5C7GfCeVMHo@public.gmane.org">=
<span style=3D"color:windowtext;text-decoration:none">le.ma-5C7GfCeVMHo@public.gmane.org</span><=
/a>&gt;
<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: Wednesday, November 27, 2019 5:15 PM<o:p></=
o:p></p>
<p class=3D"MsoPlainText">To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg"><span style=3D"color:windowtext;text-decoration:none">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</span></a><o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.=
Zhang-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;text-decoration:none">Hawkin=
g.Zhang-5C7GfCeVMHo@public.gmane.org</span></a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.C=
hen-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;text-decoration:none">Guchun.C=
hen-5C7GfCeVMHo@public.gmane.org</span></a>&gt;;
 Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:w=
indowtext;text-decoration:none">Tao.Zhou1-5C7GfCeVMHo@public.gmane.org</span></a>&gt;; Li, Denni=
s &lt;<a href=3D"mailto:Dennis.Li-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;=
text-decoration:none">Dennis.Li-5C7GfCeVMHo@public.gmane.org</span></a>&gt;;
 Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"><span =
style=3D"color:windowtext;text-decoration:none">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</=
span></a>&gt;; Ma, Le &lt;<a href=3D"mailto:Le.Ma-5C7GfCeVMHo@public.gmane.org"><span style=3D"c=
olor:windowtext;text-decoration:none">Le.Ma-5C7GfCeVMHo@public.gmane.org</span></a>&gt;<o:p></o:=
p></p>
<p class=3D"MsoPlainText">Subject: [PATCH 10/10] drm/amdgpu: reduce redunda=
nt uvd context lost warning message<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Move the print out of uvd instance loop in amdgpu=
_uvd_suspend<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Change-Id: Ifad997debd84763e1b55d668e144b729598f1=
15e<o:p></o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Le Ma &lt;<a href=3D"mailto:le.ma@=
amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma-urvtwAKJhsc@public.gmane.org=
m</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 5 &#43;=
&#43;&#43;&#43;-<o:p></o:p></p>
<p class=3D"MsoPlainText">1 file changed, 4 insertions(&#43;), 1 deletion(-=
)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uv=
d.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index e324bfe..ac7c7795 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c<o:p=
></o:p></p>
<p class=3D"MsoPlainText">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_uvd.c<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -377,12 &#43;377,15 @@ int amdgpu_uvd_suspend(=
struct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* re-write 0 since err_event_athub will corrupt VCPU buffer=
 */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (amdgpu_ras_intr_triggered()) {<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; DRM_WARN(&quot;UVD VCPU state may lost due to RAS ERREVENT_ATHUB_INT=
ERRUPT\n&quot;);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; memset(adev-&gt;uvd.inst[j].saved_bo, 0, size);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 memcpy_fromio(adev-&gt;uvd.inst[j].saved_bo, ptr, size);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (amdgpu_ras_intr_triggered()) {<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; DRM_WARN(&quot;UVD VCPU state may lost due to RAS ERREVENT_ATHUB_IN=
TERRUPT\n&quot;);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">[Guchun]the &quot;{&quot; after the if condition =
needs to be removed?<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#203864;mso-style-textfill-f=
ill-color:#203864;mso-style-textfill-fill-alpha:100.0%">[Le] Yes, sent it t=
oo quickly and made a mistake here.<o:p></o:p></span></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">-- <o:p></o:p></p>
<p class=3D"MsoPlainText">2.7.4<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB42858C745C5D0D125236BD51F6440MN2PR12MB4285namp_--

--===============1626797980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1626797980==--
