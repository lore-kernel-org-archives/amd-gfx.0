From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix sdma doorbell range setting
Date: Tue, 21 Aug 2018 13:55:03 +0000
Message-ID: <DM5PR12MB182014B0014A1A46B5A72517F7310@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20180821082102.19653-1-evan.quan@amd.com>,
 <BYAPR12MB2632C7F09461AA87E7170F5DFC310@BYAPR12MB2632.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1542693373=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2632C7F09461AA87E7170F5DFC310-ZGDeBxoHBPk+ukJnzp2+RQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1542693373==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB182014B0014A1A46B5A72517F7310DM5PR12MB1820namp_"

--_000_DM5PR12MB182014B0014A1A46B5A72517F7310DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Alternatively, we could cherry-pick the change to the doorbell ranges from =
Shaoyun.  Might also be useful to leave a comment here about the doorbell r=
ange for vega20 sdma.


Alex

________________________________
From: Zhang, Hawking
Sent: Tuesday, August 21, 2018 5:02:24 AM
To: Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Quan, Evan
Subject: RE: [PATCH] drm/amdgpu: fix sdma doorbell range setting

Reviewed-by: Hawking Zhang <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Evan Qua=
n
Sent: 2018=1B$BG/=1B(B8=1B$B7n=1B(B21=1B$BF|=1B(B 16:21
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Quan, Evan <Evan.Quan@a=
md.com>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu: fix sdma doorbell range setting

Use the old doorbell range setting until the driver is able to support more=
 sdma queues.

Change-Id: I80fc067fc64878d3c7dc3d38bbe1c6c94bec397f
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 89ea92075b6b..2e65447637c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -76,7 +76,7 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdgpu_d=
evice *adev, int instan

         if (use_doorbell) {
                 doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0=
_DOORBELL_RANGE, OFFSET, doorbell_index);
-               doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_=
DOORBELL_RANGE, SIZE, 8);
+               doorbell_range =3D REG_SET_FIELD(doorbell_range,
+BIF_SDMA0_DOORBELL_RANGE, SIZE, 2);
         } else
                 doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0=
_DOORBELL_RANGE, SIZE, 0);

--
2.18.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB182014B0014A1A46B5A72517F7310DM5PR12MB1820namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Alternatively, we could cherry-pi=
ck the change to the doorbell ranges from Shaoyun.&nbsp; Might also be usef=
ul to leave a comment here about the doorbell range for vega20 sdma.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking<br>
<b>Sent:</b> Tuesday, August 21, 2018 5:02:24 AM<br>
<b>To:</b> Quan, Evan; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Quan, Evan<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix sdma doorbell range setting</fo=
nt>
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
From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf Of Ev=
an Quan<br>
Sent: 2018=1B$BG/=1B(B8=1B$B7n=1B(B21=1B$BF|=1B(B 16:21<br>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Quan, Evan &lt;Ev=
an.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: [PATCH] drm/amdgpu: fix sdma doorbell range setting<br>
<br>
Use the old doorbell range setting until the driver is able to support more=
 sdma queues.<br>
<br>
Change-Id: I80fc067fc64878d3c7dc3d38bbe1c6c94bec397f<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index 89ea92075b6b..2e65447637c6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -76,7 &#43;76,7 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdg=
pu_device *adev, int instan<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (use_doorbell) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_=
SDMA0_DOORBELL_RANGE, OFFSET, doorbell_index);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_SDMA0_DOORB=
ELL_RANGE, SIZE, 8);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, <br>
&#43;BIF_SDMA0_DOORBELL_RANGE, SIZE, 2);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; doorbell_range =3D REG_SET_FIELD(doorbell_range, BIF_=
SDMA0_DOORBELL_RANGE, SIZE, 0);<br>
&nbsp;<br>
--<br>
2.18.0<br>
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

--_000_DM5PR12MB182014B0014A1A46B5A72517F7310DM5PR12MB1820namp_--

--===============1542693373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1542693373==--
