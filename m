From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 8/9] drm/amdgpu:wptr poll address of gfx8 is needed
Date: Wed, 28 Sep 2016 15:27:34 +0000
Message-ID: <MWHPR12MB169469DF6CB1A70E185D0563F7CF0@MWHPR12MB1694.namprd12.prod.outlook.com>
References: <1475051780-21634-1-git-send-email-Monk.Liu@amd.com>,
 <1475051780-21634-8-git-send-email-Monk.Liu@amd.com>
 <CY4PR12MB17686C79F11C47CC29E00E2EF7CF0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0760195326=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB17686C79F11C47CC29E00E2EF7CF0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Min, Frank" <Frank.Min-5C7GfCeVMHo@public.gmane.org>

--===============0760195326==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR12MB169469DF6CB1A70E185D0563F7CF0MWHPR12MB1694namp_"

--_000_MWHPR12MB169469DF6CB1A70E185D0563F7CF0MWHPR12MB1694namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Worth a shot, but I doubt it.  Wptr polling is only enabled if explicitly r=
equested.  I'm not sure if CP PG will work without doorbells since the door=
bells are handled by the BIF and forwarded to the CP which should wake it i=
f it's gated.  Wptr polling may require CP PG be disabled or prevent it fro=
m kicking in.  Probably want to ask the CP team.

Alex

From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Wednesday, September 28, 2016 9:41 AM
To: Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Min, Frank
Subject: Re: [PATCH 8/9] drm/amdgpu:wptr poll address of gfx8 is needed


Hmm, I wonder if this fix CP power gating issues ... on Carrizo/Stoney...

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Mon=
k.Liu-5C7GfCeVMHo@public.gmane.org>>
Sent: Wednesday, September 28, 2016 04:36
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Min, Frank
Subject: [PATCH 8/9] drm/amdgpu:wptr poll address of gfx8 is needed

From: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org<mailto:Frank.Min-5C7GfCeVMHo@public.gmane.org>>

for GFX8, gfx ring's wptr_addr is needed by SRIOV & CP for polling.

Change-Id: I14477577ef50d1ac90ccc32d41819276811732b7
Signed-off-by: Frank Min <Frank.Min-5C7GfCeVMHo@public.gmane.org<mailto:Frank.Min-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 097108a..98ef1fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4338,7 +4338,7 @@ static int gfx_v8_0_cp_gfx_resume(struct amdgpu_devic=
e *adev)
         struct amdgpu_ring *ring;
         u32 tmp;
         u32 rb_bufsz;
-       u64 rb_addr, rptr_addr;
+       u64 rb_addr, rptr_addr, wptr_gpu_addr;
         int r;

         /* Set the write pointer delay */
@@ -4369,6 +4369,9 @@ static int gfx_v8_0_cp_gfx_resume(struct amdgpu_devic=
e *adev)
         WREG32(mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
         WREG32(mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);

+       wptr_gpu_addr =3D adev->wb.gpu_addr + (ring->wptr_offs * 4);
+       WREG32(mmCP_RB_WPTR_POLL_ADDR_LO, lower_32_bits(wptr_gpu_addr));
+       WREG32(mmCP_RB_WPTR_POLL_ADDR_HI, upper_32_bits(wptr_gpu_addr));
         mdelay(1);
         WREG32(mmCP_RB0_CNTL, tmp);

--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...



--_000_MWHPR12MB169469DF6CB1A70E185D0563F7CF0MWHPR12MB1694namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Worth a shot, but I doubt=
 it.&nbsp; Wptr polling is only enabled if explicitly requested.&nbsp; I'm =
not sure if CP PG will work without doorbells since the doorbells
 are handled by the BIF and forwarded to the CP which should wake it if it'=
s gated.&nbsp; Wptr polling may require CP PG be disabled or prevent it fro=
m kicking in.&nbsp; Probably want to ask the CP team.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D">Alex<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span><=
/p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Wednesday, September 28, 2016 9:41 AM<br>
<b>To:</b> Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Min, Frank<br>
<b>Subject:</b> Re: [PATCH 8/9] drm/amdgpu:wptr poll address of gfx8 is nee=
ded<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;co=
lor:black">Hmm, I wonder if this fix CP power gating issues ... on Carrizo/=
Stoney...<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-f=
amily:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:black"><o:p>&nbsp;</=
o:p></span></p>
<div>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:blac=
k">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,&quot;sans-serif&quot;;color:black">From:</span></b><span st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Monk Liu &lt;<a href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">Monk.Liu@amd=
.com</a>&gt;<br>
<b>Sent:</b> Wednesday, September 28, 2016 04:36<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Min, Frank<br>
<b>Subject:</b> [PATCH 8/9] drm/amdgpu:wptr poll address of gfx8 is needed<=
/span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;=
;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,&quot=
;sans-serif&quot;;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:black">From: Frank Min &lt;<a href=
=3D"mailto:Frank.Min-5C7GfCeVMHo@public.gmane.org">Frank.Min-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
for GFX8, gfx ring's wptr_addr is needed by SRIOV &amp; CP for polling.<br>
<br>
Change-Id: I14477577ef50d1ac90ccc32d41819276811732b7<br>
Signed-off-by: Frank Min &lt;<a href=3D"mailto:Frank.Min-5C7GfCeVMHo@public.gmane.org">Frank.Min=
@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 5 &#43;&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 4 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 097108a..98ef1fe 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -4338,7 &#43;4338,7 @@ static int gfx_v8_0_cp_gfx_resume(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 rb_bufsz;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 rb_addr, rptr_addr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 rb_addr, rptr_addr, wptr_gpu_=
addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set the write pointer d=
elay */<br>
@@ -4369,6 &#43;4369,9 @@ static int gfx_v8_0_cp_gfx_resume(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_RB0_RPTR_ADDR,=
 lower_32_bits(rptr_addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_RB0_RPTR_ADDR_=
HI, upper_32_bits(rptr_addr) &amp; 0xFF);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr_gpu_addr =3D adev-&gt;wb.gpu=
_addr &#43; (ring-&gt;wptr_offs * 4);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_RB_WPTR_POLL_ADDR_LO,=
 lower_32_bits(wptr_gpu_addr));<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_RB_WPTR_POLL_ADDR_HI,=
 upper_32_bits(wptr_gpu_addr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mdelay(1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmCP_RB0_CNTL, tmp)=
;<br>
&nbsp;<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk21963">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<o:p></o:p></span></p>
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1475070=
0535950.9733653182953386">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div id=3D"LPTitle_14750700535940.16791780469974915">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;mso-line-height-alt:15.75=
pt"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot;,=
&quot;sans-serif&quot;;color:#3B5777"><a href=3D"https://lists.freedesktop.=
org/mailman/listinfo/amd-gfx" target=3D"_blank"><span style=3D"text-decorat=
ion:none">amd-gfx
 Info Page - lists.freedesktop.org</span></a><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_14750=
700535950.5392573984284703">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666">lists.freedesktop.org<o:p></o:p></span></p>
</div>
<div id=3D"LPDescription_14750700535950.36316319059213775">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,&quot;sans-seri=
f&quot;;color:#666666">To see the collection of prior postings to the list,=
 visit the amd-gfx Archives. Using amd-gfx: To post a message
 to all the list members, send email ...<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:bla=
ck"><o:p>&nbsp;</o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MWHPR12MB169469DF6CB1A70E185D0563F7CF0MWHPR12MB1694namp_--

--===============0760195326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0760195326==--
