From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on
 Stoney
Date: Fri, 26 Aug 2016 16:50:24 +0000
Message-ID: <DM5PR12MB1132D8264821843420BD7640F7EC0@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160826164627.6734-1-tom.stdenis@amd.com>,
 <20160826164627.6734-4-tom.stdenis@amd.com>
 <DM5PR12MB1132C685592A9CB895B951A5F7EC0@DM5PR12MB1132.namprd12.prod.outlook.com>,
 <MWHPR12MB16943D4174366F50B3FF6E8BF7EC0@MWHPR12MB1694.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1333304751=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB16943D4174366F50B3FF6E8BF7EC0-Gy0DoCVfaSW4WA4dJ5YXGAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============1333304751==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132D8264821843420BD7640F7EC0DM5PR12MB1132namp_"

--_000_DM5PR12MB1132D8264821843420BD7640F7EC0DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Patch #3 is correct but missing the SDMA0 duplicate which I amended locally=
.  I only noticed it after I hit send.


________________________________
From: Deucher, Alexander
Sent: Friday, August 26, 2016 12:49
To: StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on =
Stoney


Wrong patch? ;)



From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of S=
tDenis, Tom
Sent: Friday, August 26, 2016 12:48 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on =
Stoney



I swear this isn't intentional but I just realized that SDMA0 was loaded tw=
ice too only after hitting send-email.  I've amended my patch locally to av=
oid loading SDMA0 twice too..



Tom



________________________________

From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, August 26, 2016 12:46
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: StDenis, Tom
Subject: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once on Ston=
ey



Only load the MEC1 firmware once in the Carrizo SMU manager
driver.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org=
>>
---
 drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/cz_smumgr.c
index f51bd8de2f69..1529516089bc 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c
@@ -574,10 +574,7 @@ static int cz_smu_construct_toc_for_bootup(struct pp_s=
mumgr *smumgr)
                                 CZ_SCRATCH_ENTRY_UCODE_ID_CP_ME, false);
         cz_smu_populate_single_ucode_load_task(smumgr,
                                 CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, fals=
e);
-       if (smumgr->chip_id =3D=3D CHIP_STONEY)
-               cz_smu_populate_single_ucode_load_task(smumgr,
-                               CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false=
);
-       else
+       if (smumgr->chip_id !=3D CHIP_STONEY)
                 cz_smu_populate_single_ucode_load_task(smumgr,
                                 CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT2, fals=
e);
         cz_smu_populate_single_ucode_load_task(smumgr,
--
2.9.3

--_000_DM5PR12MB1132D8264821843420BD7640F7EC0DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Patch #3 is correct but missing the SDMA0 duplicate which I amended loca=
lly. &nbsp;I only noticed it after I hit send.</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<br=
>
<b>Sent:</b> Friday, August 26, 2016 12:49<br>
<b>To:</b> StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware o=
nce on Stoney</font>
<div>&nbsp;</div>
</div>
<div>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">Wrong patch? ;)</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:#1F497D">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
<b><span style=3D"font-size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sa=
ns-serif&quot;">From:</span></b><span style=3D"font-size:10.0pt; font-famil=
y:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx [mailto:amd-gfx-bounc=
es-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org]
<b>On Behalf Of </b>StDenis, Tom<br>
<b>Sent:</b> Friday, August 26, 2016 12:48 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware o=
nce on Stoney</span></p>
</div>
</div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif;">
&nbsp;</p>
<div id=3D"divtagdefaultwrapper">
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">I swear this isn't intentional&nbsp;=
but I just realized that SDMA0 was loaded twice too only after hitting send=
-email. &nbsp;I've amended my patch locally to avoid loading SDMA0
 twice too..</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">&nbsp;</span></p>
<p style=3D"background:white"><span style=3D"font-family:&quot;Calibri&quot=
;,&quot;sans-serif&quot;; color:black">Tom</span></p>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif; background: white;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
<div>
<div>
<div align=3D"center" style=3D"text-align: center; margin: 0in 0in 0.0001pt=
; font-size: 12pt; font-family: &quot;Times New Roman&quot;, serif; backgro=
und: white;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"x_divRplyFwdMsg">
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif; background: white;">
<b><span style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;; color:black">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; color:black"> T=
om St Denis &lt;<a href=3D"mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" style=3D"color: blu=
e; text-decoration: underline;">tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, August 26, 2016 12:46<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" style=3D"color:=
 blue; text-decoration: underline;">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH 3/3] drm/amd/powerplay: Only load MEC firmware once =
on Stoney</span><span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-s=
erif&quot;; color:black">
</span></p>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif; background: white;">
<span style=3D"font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;; colo=
r:black">&nbsp;</span></p>
</div>
</div>
</div>
<div>
<p style=3D"margin: 0in 0in 0.0001pt; font-size: 12pt; font-family: &quot;T=
imes New Roman&quot;, serif; background: white;">
<span style=3D"font-size:10.0pt; font-family:&quot;Calibri&quot;,&quot;sans=
-serif&quot;; color:black">Only load the MEC1 firmware once in the Carrizo =
SMU manager<br>
driver.<br>
<br>
Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org" styl=
e=3D"color: blue; text-decoration: underline;">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<=
br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c | 5 &#43;----<br>
&nbsp;1 file changed, 1 insertion(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
index f51bd8de2f69..1529516089bc 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/cz_smumgr.c<br>
@@ -574,10 &#43;574,7 @@ static int cz_smu_construct_toc_for_bootup(struct =
pp_smumgr *smumgr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_ME,=
 false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_smu_populate_single_uco=
de_load_task(smumgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC=
_JT1, false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smumgr-&gt;chip_id =3D=3D CHIP_ST=
ONEY)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; cz_smu_populate_single_ucode_load_task(smumgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC_JT1, false=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smumgr-&gt;chip_id !=3D CHIP_=
STONEY)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; cz_smu_populate_single_ucode_load_task(smumgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CZ_SCRATCH_ENTRY_UCODE_ID_CP_MEC=
_JT2, false);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_smu_populate_single_uco=
de_load_task(smumgr,<br>
-- <br>
2.9.3</span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1132D8264821843420BD7640F7EC0DM5PR12MB1132namp_--

--===============1333304751==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1333304751==--
