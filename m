From: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu: limit reg_write_reg_wait workaround to SRIOV
Date: Wed, 18 Apr 2018 01:59:06 +0000
Message-ID: <CY4PR12MB1125DD21F2A4E63E2ABE43928FB60@CY4PR12MB1125.namprd12.prod.outlook.com>
References: <20180417130135.1895-1-christian.koenig@amd.com>
 <DM5PR12MB1820165CD71A527EAA47C5F4F7B70@DM5PR12MB1820.namprd12.prod.outlook.com>
 <0cf6dae0-afae-c858-73af-ab47673a7d8a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0086865491=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <0cf6dae0-afae-c858-73af-ab47673a7d8a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

--===============0086865491==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1125DD21F2A4E63E2ABE43928FB60CY4PR12MB1125namp_"

--_000_CY4PR12MB1125DD21F2A4E63E2ABE43928FB60CY4PR12MB1125namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,
Does this actually work on SR-IOV? Or does it just seem to but nothing bad =
happens because we get a GPU reset on a world switch?
I honestly don't know. I think that SR-IOV uses a specialized firmware wher=
e this packet has a different meaning.

But the real fix would be to get the RLC firmware fix to not reinitialize t=
hose regs to zero on world switch.
[Emily]Yes, it actually works on SR-IOV, it fixes lots of engine hang issue=
.

Best Wishes,
Emily Deng
From: Christian K=F6nig [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Tuesday, April 17, 2018 11:27 PM
To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org; Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: limit reg_write_reg_wait workaround to SRI=
OV

Does this actually work on SR-IOV? Or does it just seem to but nothing bad =
happens because we get a GPU reset on a world switch?
I honestly don't know. I think that SR-IOV uses a specialized firmware wher=
e this packet has a different meaning.

But the real fix would be to get the RLC firmware fix to not reinitialize t=
hose regs to zero on world switch.

Christian.

Am 17.04.2018 um 16:02 schrieb Deucher, Alexander:

Does this actually work on SR-IOV?  Or does it just seem to but nothing bad=
 happens because we get a GPU reset on a world switch?  The behavior of thi=
s packet should be the same as SDMA and that definitely doesn't work.  I do=
n't see why this would be any different.



Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org><mailto:alexander.deucher=
@amd.com>



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Christian K=F6nig <ckoenig.leichtzume=
rken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, April 17, 2018 9:01:35 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH] drm/amdgpu: limit reg_write_reg_wait workaround to SRIOV

Turned out that this locks up some bare metal Vega10.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christia=
n.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index 583f6f616dd3..5329d7e5fb71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4144,7 +4144,12 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wait(st=
ruct amdgpu_ring *ring,
 {
         int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);

-       gfx_v9_0_wait_reg_mem(ring, usepfp, 0, 1, reg0, reg1, ref, mask, 0x=
20);
+       if (amdgpu_sriov_vf(adev))
+               gfx_v9_0_wait_reg_mem(ring, usepfp, 0, 1, reg0, reg1,
+                                     ref, mask, 0x20);
+       else
+               amdgpu_ring_emit_reg_write_reg_wait_helper(ring, reg0, reg1=
,
+                                                          ref, mask);
 }

 static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *ade=
v,
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_CY4PR12MB1125DD21F2A4E63E2ABE43928FB60CY4PR12MB1125namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:\4EFF\5B8B;
	panose-1:2 1 6 9 6 1 1 1 1 1;}
@font-face
	{font-family:"\@\4EFF\5B8B";
	panose-1:2 1 6 9 6 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
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
	font-family:"Times New Roman",serif;
	color:black;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body bgcolor=3D"white" lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Hi all,<o:p></o:p></span></p>
<p class=3D"MsoNormal">Does this actually work on SR-IOV? Or does it just s=
eem to but nothing bad happens because we get a GPU reset on a world switch=
?<o:p></o:p></p>
<p class=3D"MsoNormal">I honestly don't know. I think that SR-IOV uses a sp=
ecialized firmware where this packet has a different meaning.<br>
<br>
But the real fix would be to get the RLC firmware fix to not reinitialize t=
hose regs to zero on world switch.<br>
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;=
color:#1F497D">[Emily]Yes, it actually works on SR-IOV, it fixes lots of en=
gine hang issue.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:9.0pt;color:#1F497D">Bes=
t Wishes,<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:9.0pt;color:#1F497D">Emi=
ly Deng</span></b><b><i><span style=3D"font-family:\4EFF\5B8B;color:#1F497D=
"><o:p></o:p></span></i></b></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:windowtext">From:</span></b><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtex=
t"> Christian K=F6nig [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
<br>
<b>Sent:</b> Tuesday, April 17, 2018 11:27 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx@li=
sts.freedesktop.org; Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; Liu, Monk &lt;=
Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: limit reg_write_reg_wait workaround=
 to SRIOV<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"MsoNormal">Does this actually work on SR-IOV? Or does it just s=
eem to but nothing bad happens because we get a GPU reset on a world switch=
?<o:p></o:p></p>
</blockquote>
<p class=3D"MsoNormal">I honestly don't know. I think that SR-IOV uses a sp=
ecialized firmware where this packet has a different meaning.<br>
<br>
But the real fix would be to get the RLC firmware fix to not reinitialize t=
hose regs to zero on world switch.<br>
<br>
Christian.<br>
<br>
Am 17.04.2018 um 16:02 schrieb Deucher, Alexander:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Does this act=
ually work on SR-IOV?&nbsp; Or does it just seem to but nothing bad happens=
 because we get a GPU reset on a world switch?&nbsp; The behavior of this p=
acket should be the same as SDMA and that definitely doesn't
 work.&nbsp; I don't see why this would be any different.<o:p></o:p></span>=
</p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif"><o:p>&nbsp;</=
o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Acked-by: Ale=
x Deucher <a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif"><o:p>&nbsp;</=
o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif">Alex<o:p></o:=
p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> amd-gfx
<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounce=
s@lists.freedesktop.org&gt;</a> on behalf of Christian K=F6nig
<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumer=
ken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
<b>Sent:</b> Tuesday, April 17, 2018 9:01:35 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Subject:</b> [PATCH] drm/amdgpu: limit reg_write_reg_wait workaround to =
SRIOV</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Turned out that thi=
s locks up some bare metal Vega10.<br>
<br>
Signed-off-by: Christian K=F6nig <a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org=
">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 &#43;&#43;&#43;&#43;&#43;&#=
43;-<br>
&nbsp;1 file changed, 6 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index 583f6f616dd3..5329d7e5fb71 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -4144,7 &#43;4144,12 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wai=
t(struct amdgpu_ring *ring,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int usepfp =3D (ring-&gt;f=
uncs-&gt;type =3D=3D AMDGPU_RING_TYPE_GFX);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_wait_reg_mem(ring, usepfp, 0=
, 1, reg0, reg1, ref, mask, 0x20);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; gfx_v9_0_wait_reg_mem(ring, usepfp, 0, 1, reg0, reg1,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref=
, mask, 0x20);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ring_emit_reg_write_reg_wait_helper(ring, reg0, reg1,=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ref, mask);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device=
 *adev,<br>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
</div>
</div>
</blockquote>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1125DD21F2A4E63E2ABE43928FB60CY4PR12MB1125namp_--

--===============0086865491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0086865491==--
