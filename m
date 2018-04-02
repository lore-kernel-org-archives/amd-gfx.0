From: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu/sdma4:fix sdma engine hang
Date: Mon, 2 Apr 2018 09:53:29 +0000
Message-ID: <CY4PR12MB11252C502EB9D72E1814F4418FA60@CY4PR12MB1125.namprd12.prod.outlook.com>
References: <1522398248-9518-1-git-send-email-Emily.Deng@amd.com>
 <BN6PR12MB1809BFA58237B2C3C27FE1E3F7A10@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0789049366=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809BFA58237B2C3C27FE1E3F7A10-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0789049366==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB11252C502EB9D72E1814F4418FA60CY4PR12MB1125namp_"

--_000_CY4PR12MB11252C502EB9D72E1814F4418FA60CY4PR12MB1125namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,
When set hdp bit, the poll reg mem command will do follow sequence:
Write reference value to reg0,
Poll reg1,
Compare the reference with the  reg1 value&mask(The detail behavior informa=
tion is from sdma team),
but in our use case the reference value is not equal to mask, also may not =
equal to the reg1 value, so the compare won't pass, so causes the sdma hang=
.
   Also verified the detail behavior with follow test:
   Use the original method to do invalidate request and poll ack, but repla=
ce the mask with ref, then the sdma also will hang:
void amdgpu_ring_emit_reg_write_reg_wait_helper(struct amdgpu_ring *ring,
                                                                           =
                     uint32_t reg0, uint32_t reg1,
                                                                           =
                     uint32_t ref, uint32_t mask)
{
                amdgpu_ring_emit_wreg(ring, reg0, ref);
//amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
                amdgpu_ring_emit_reg_wait(ring, reg1, ref, mask);
}

Best Wishes,
Emily Deng


From: Deucher, Alexander
Sent: Friday, March 30, 2018 8:55 PM
To: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu/sdma4:fix sdma engine hang


The spec claims it does and we use it for HDP flush...

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deucher@=
amd.com>>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org<mailto=
:Emily.Deng-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, March 30, 2018 4:24:08 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deng, Emily
Subject: [PATCH] drm/amdgpu/sdma4:fix sdma engine hang

The sdma doesn't support register write and wait in one command.
Use this will make sdma engine hang.

Signed-off-by: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org<mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 9ac28b2..84d148d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1178,13 +1178,6 @@ static void sdma_v4_0_ring_emit_reg_wait(struct amdg=
pu_ring *ring, uint32_t reg,
         sdma_v4_0_wait_reg_mem(ring, 0, 0, reg, 0, val, mask, 10);
 }

-static void sdma_v4_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *rin=
g,
-                                                  uint32_t reg0, uint32_t =
reg1,
-                                                  uint32_t ref, uint32_t m=
ask)
-{
-       sdma_v4_0_wait_reg_mem(ring, 0, 1, reg0, reg1, ref, mask, 10);
-}
-
 static int sdma_v4_0_early_init(void *handle)
 {
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
@@ -1626,7 +1619,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_ring_=
funcs =3D {
         .pad_ib =3D sdma_v4_0_ring_pad_ib,
         .emit_wreg =3D sdma_v4_0_ring_emit_wreg,
         .emit_reg_wait =3D sdma_v4_0_ring_emit_reg_wait,
-       .emit_reg_write_reg_wait =3D sdma_v4_0_ring_emit_reg_write_reg_wait=
,
+       .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_he=
lper,
 };

 static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev)
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB11252C502EB9D72E1814F4418FA60CY4PR12MB1125namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:m=3D"http://schema=
s.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html=
40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
	{font-family:\4EFF\5B8B;
	panose-1:2 1 6 9 6 1 1 1 1 1;}
@font-face
	{font-family:"\@\4EFF\5B8B";
	panose-1:2 1 6 9 6 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
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
	font-family:"Times New Roman",serif;}
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">Hi Alex,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.0pt"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">When set =
hdp bit, the poll reg mem command will do follow sequence:<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.0pt"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Write ref=
erence value to reg0,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.0pt"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Poll reg1=
,
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:9.0pt"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D">Compare
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:#00B050">the reference with the &nbsp;reg1 value&amp;mask(The =
detail behavior information is from sdma team),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">but in our use case the reference val=
ue is not equal to mask, also may not equal to the reg1 value, so the compa=
re won&#8217;t pass, so causes the sdma hang.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">&nbsp;&nbsp; Also verified the detail=
 behavior with follow test:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">&nbsp;&nbsp; Use the original method =
to do invalidate request and poll ack, but replace the mask with ref, then =
the sdma also will hang:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">void amdgpu_ring_emit_reg_write_reg_w=
ait_helper(struct amdgpu_ring *ring,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t reg0, uint32_t reg1,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t ref, uint32_t mask)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">{<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_wreg=
(ring, reg0, ref);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:.5in;line-height:150%"><span st=
yle=3D"font-size:11.0pt;line-height:150%;font-family:&quot;Calibri&quot;,sa=
ns-serif;color:#1F497D">//amdgpu_ring_emit_reg_wait(ring, reg1,
</span><span style=3D"font-size:11.0pt;line-height:150%;font-family:&quot;C=
alibri&quot;,sans-serif;color:red">mask</span><span style=3D"font-size:11.0=
pt;line-height:150%;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497=
D">, mask);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"line-height:150%"><span style=3D"font-size:=
11.0pt;line-height:150%;font-family:&quot;Calibri&quot;,sans-serif;color:#1=
F497D">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_reg_wait(ring, reg1,
</span><span style=3D"font-size:11.0pt;line-height:150%;font-family:&quot;C=
alibri&quot;,sans-serif;color:red">ref</span><span style=3D"font-size:11.0p=
t;line-height:150%;font-family:&quot;Calibri&quot;,sans-serif;color:#1F497D=
">, mask);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:9.0pt;color:#1F497D">Bes=
t Wishes,<o:p></o:p></span></b></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:9.0pt;color:#1F497D">Emi=
ly Deng</span></b><b><i><span style=3D"font-family:\4EFF\5B8B;color:#1F497D=
"><o:p></o:p></span></i></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander
<br>
<b>Sent:</b> Friday, March 30, 2018 8:55 PM<br>
<b>To:</b> Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9w@public.gmane.org=
p.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/sdma4:fix sdma engine hang<o:p></o:p=
></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">T=
he spec claims it does and we use it for HDP flush...<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">A=
cked-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alex=
ander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Emily Deng &lt;<a href=3D"mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">Emily.De=
ng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, March 30, 2018 4:24:08 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Deng, Emily<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sdma4:fix sdma engine hang</span> <o:p><=
/o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">The sdma doesn't su=
pport register write and wait in one command.<br>
Use this will make sdma engine hang.<br>
<br>
Signed-off-by: Emily Deng &lt;<a href=3D"mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">Emily.D=
eng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 9 &#43;--------<br>
&nbsp;1 file changed, 1 insertion(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 9ac28b2..84d148d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -1178,13 &#43;1178,6 @@ static void sdma_v4_0_ring_emit_reg_wait(struct =
amdgpu_ring *ring, uint32_t reg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v4_0_wait_reg_mem(rin=
g, 0, 0, reg, 0, val, mask, 10);<br>
&nbsp;}<br>
&nbsp;<br>
-static void sdma_v4_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *rin=
g,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t reg0, uint32_t reg1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t ref, uint32_t mask)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v4_0_wait_reg_mem(ring, 0, 1, re=
g0, reg1, ref, mask, 10);<br>
-}<br>
-<br>
&nbsp;static int sdma_v4_0_early_init(void *handle)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
@@ -1626,7 &#43;1619,7 @@ static const struct amdgpu_ring_funcs sdma_v4_0_r=
ing_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D sdma_v4_0_ring=
_pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D sdma_v4_0_r=
ing_emit_wreg,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_wait =3D sdma_v4=
_0_ring_emit_reg_wait,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =3D sdma_v4_=
0_ring_emit_reg_write_reg_wait,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_reg_write_reg_wait =3D amdg=
pu_ring_emit_reg_write_reg_wait_helper,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static void sdma_v4_0_set_ring_funcs(struct amdgpu_device *adev)<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB11252C502EB9D72E1814F4418FA60CY4PR12MB1125namp_--

--===============0789049366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0789049366==--
