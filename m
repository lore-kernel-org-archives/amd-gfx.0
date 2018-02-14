From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 4/4] Call RADEONFreeRec from
 RADEONFreeScreen_KMS even if info == NULL
Date: Wed, 14 Feb 2018 18:07:34 +0000
Message-ID: <BN6PR12MB1652D1D5B256896CF404B282F7F50@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180214174930.5086-1-michel@daenzer.net>,
 <20180214174930.5086-4-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0237034317=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180214174930.5086-4-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0237034317==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652D1D5B256896CF404B282F7F50BN6PR12MB1652namp_"

--_000_BN6PR12MB1652D1D5B256896CF404B282F7F50BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Wednesday, February 14, 2018 12:49:30 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati 4/4] Call RADEONFreeRec from RADEONFreeScree=
n_KMS even if info =3D=3D NULL

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

It's safe now.

(Ported from amdgpu commit c9bd1399a13cea2e1331af2c826ca054b88db071)

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/radeon_kms.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index 06f7883e8..6e5bf7814 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -2206,14 +2206,9 @@ static Bool RADEONCloseScreen_KMS(ScreenPtr pScreen)

 void RADEONFreeScreen_KMS(ScrnInfoPtr pScrn)
 {
-    RADEONInfoPtr  info  =3D RADEONPTR(pScrn);
-
     xf86DrvMsgVerb(pScrn->scrnIndex, X_INFO, RADEON_LOGLEVEL_DEBUG,
                    "RADEONFreeScreen\n");

-    /* when server quits at PreInit, we don't need do this anymore*/
-    if (!info) return;
-
     RADEONFreeRec(pScrn);
 }

--
2.16.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652D1D5B256896CF404B282F7F50BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Wednesday, February 14, 2018 12:49:30 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati 4/4] Call RADEONFreeRec from RADEONFr=
eeScreen_KMS even if info =3D=3D NULL</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
It's safe now.<br>
<br>
(Ported from amdgpu commit c9bd1399a13cea2e1331af2c826ca054b88db071)<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/radeon_kms.c | 5 -----<br>
&nbsp;1 file changed, 5 deletions(-)<br>
<br>
diff --git a/src/radeon_kms.c b/src/radeon_kms.c<br>
index 06f7883e8..6e5bf7814 100644<br>
--- a/src/radeon_kms.c<br>
&#43;&#43;&#43; b/src/radeon_kms.c<br>
@@ -2206,14 &#43;2206,9 @@ static Bool RADEONCloseScreen_KMS(ScreenPtr pScr=
een)<br>
&nbsp;<br>
&nbsp;void RADEONFreeScreen_KMS(ScrnInfoPtr pScrn)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp; RADEONInfoPtr&nbsp; info&nbsp; =3D RADEONPTR(pScrn);<br=
>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsgVerb(pScrn-&gt;scrnIndex, X_INFO, RADEON=
_LOGLEVEL_DEBUG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RADEONFreeScreen\n&quot;);<br=
>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp; /* when server quits at PreInit, we don't need do this =
anymore*/<br>
-&nbsp;&nbsp;&nbsp; if (!info) return;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp; RADEONFreeRec(pScrn);<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.16.1<br>
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

--_000_BN6PR12MB1652D1D5B256896CF404B282F7F50BN6PR12MB1652namp_--

--===============0237034317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0237034317==--
