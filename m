From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7_smu_fini
Date: Fri, 5 Jan 2018 06:44:21 +0000
Message-ID: <CY4PR12MB16870CE74AADDD7DED38C276FB1C0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180104160122.22697-1-harry.wentland@amd.com>
 <BN6PR12MB1652FC402BB6484951B4B846F71F0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2001097734=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652FC402BB6484951B4B846F71F0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Tao, Yintian" <Yintian.Tao-5C7GfCeVMHo@public.gmane.org>

--===============2001097734==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16870CE74AADDD7DED38C276FB1C0CY4PR12MB1687namp_"

--_000_CY4PR12MB16870CE74AADDD7DED38C276FB1C0CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

and pushed the patch to drm-next.

Best Regards
Rex

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of D=
eucher, Alexander
Sent: Friday, January 05, 2018 12:09 AM
To: Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Tao, Yintian
Subject: Re: [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7_smu_fi=
ni


Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deucher@=
amd.com>>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Harry Wentland <harry.wentland-urvtwAKJhsc@public.gmane.org=
m<mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, January 4, 2018 11:01 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Ta=
o, Yintian
Cc: Wentland, Harry
Subject: [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7_smu_fini

This fixes these warnings:

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c: In function '=
smu7_smu_fini':
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:653:33: warnin=
g: passing argument 2 of 'smu_free_memory' makes pointer from integer witho=
ut a cast [-Wint-conversion]
  smu_free_memory(hwmgr->device, smu_data->header_buffer.handle);
                                 ^~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 'void *' but argument is of type 'long unsigned int'
 extern int smu_free_memory(void *device, void *handle);
            ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:655:34: warnin=
g: passing argument 2 of 'smu_free_memory' makes pointer from integer witho=
ut a cast [-Wint-conversion]
   smu_free_memory(hwmgr->device, smu_data->smu_buffer.handle);
                                  ^~~~~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 'void *' but argument is of type 'long unsigned int'
 extern int smu_free_memory(void *device, void *handle);
            ^~~~~~~~~~~~~~~

Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org<mailto:harry.wentland=
@amd.com>>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 25dd7781c9f2..311ff3718618 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -650,9 +650,9 @@ int smu7_smu_fini(struct pp_hwmgr *hwmgr)
 {
         struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->smu=
_backend);

-       smu_free_memory(hwmgr->device, smu_data->header_buffer.handle);
+       smu_free_memory(hwmgr->device, (void *) smu_data->header_buffer.han=
dle);
         if (!cgs_is_virtualization_enabled(hwmgr->device))
-               smu_free_memory(hwmgr->device, smu_data->smu_buffer.handle)=
;
+               smu_free_memory(hwmgr->device, (void *) smu_data->smu_buffe=
r.handle);

         kfree(hwmgr->smu_backend);
         hwmgr->smu_backend =3D NULL;
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB16870CE74AADDD7DED38C276FB1C0CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:"Calibri","sans-serif";}
p
	{mso-style-priority:99;
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Times New Roman","serif";}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:SimSun;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-CN" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText"><span lang=3D"EN-US">Reviewed-by: Rex Zhu &lt;Rex=
.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">and pushed=
 the patch to drm-next.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Best Regar=
ds<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D">Rex<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:10.5pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp=
;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:10.0pt;fo=
nt-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span =
lang=3D"EN-US" style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&qu=
ot;sans-serif&quot;"> amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
]
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Friday, January 05, 2018 12:09 AM<br>
<b>To:</b> Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Tao, Yintian<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7=
_smu_fini<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<div id=3D"divtagdefaultwrapper">
<p><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;;color:black">Acked-by: Alex Deucher &lt;<a href=3D"mailto:alex=
ander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span lang=3D"EN-US" =
style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black=
"><o:p>&nbsp;</o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&q=
uot;;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-size:11.0pt;fo=
nt-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</sp=
an></b><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,&quot;sans-serif&quot;;color:black"> amd-gfx &lt;<a href=3D"mail=
to:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org</a>&gt;
 on behalf of Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">=
harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, January 4, 2018 11:01 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a>; Tao, Yintian<br>
<b>Cc:</b> Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Fix no-cast warnings in smu7_smu=
_fini</span><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,&=
quot;sans-serif&quot;;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-family:&quot;Cali=
bri&quot;,&quot;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black">This fixes t=
hese warnings:<br>
<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c: In function &=
#8216;smu7_smu_fini&#8217;:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:653:33: warnin=
g: passing argument 2 of &#8216;smu_free_memory&#8217; makes pointer from i=
nteger without a cast [-Wint-conversion]<br>
&nbsp; smu_free_memory(hwmgr-&gt;device, smu_data-&gt;header_buffer.handle)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~<br>
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 &#8216;void *&#8217; but argument is of type &#8216;long unsigned int&#821=
7;<br>
&nbsp;extern int smu_free_memory(void *device, void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~=
~~~~~~~<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:655:34: warnin=
g: passing argument 2 of &#8216;smu_free_memory&#8217; makes pointer from i=
nteger without a cast [-Wint-conversion]<br>
&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device, smu_data-&gt;smu_buffer.hand=
le);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~<br>
In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_s=
mumgr.c:26:0:<br>
drivers/gpu/drm/amd/amdgpu/../powerplay/inc/smumgr.h:114:12: note: expected=
 &#8216;void *&#8217; but argument is of type &#8216;long unsigned int&#821=
7;<br>
&nbsp;extern int smu_free_memory(void *device, void *handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^~~~~~~~=
~~~~~~~<br>
<br>
Signed-off-by: Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org"=
>harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 4 &#43;&#43;--<b=
r>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/g=
pu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
index 25dd7781c9f2..311ff3718618 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
@@ -650,9 &#43;650,9 @@ int smu7_smu_fini(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_da=
ta =3D (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device, smu=
_data-&gt;header_buffer.handle);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device,=
 (void *) smu_data-&gt;header_buffer.handle);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cgs_is_virtualization=
_enabled(hwmgr-&gt;device))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_free_memory(hwmgr-&gt;device, smu_data-&gt;smu_buffer.handle=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; smu_free_memory(hwmgr-&gt;device, (void *) smu_data-&gt;smu_=
buffer.handle);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;smu_backen=
d);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;smu_backend =3D =
NULL;<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk110459">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p><=
/o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16870CE74AADDD7DED38C276FB1C0CY4PR12MB1687namp_--

--===============2001097734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2001097734==--
