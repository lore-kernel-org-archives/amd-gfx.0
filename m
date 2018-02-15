From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-ati 2/2] Simplify depth 30 "kernel too old"
 error message
Date: Thu, 15 Feb 2018 17:07:36 +0000
Message-ID: <BN6PR12MB1652F2D95D479102FBBAF70AF7F40@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180215165024.9736-1-michel@daenzer.net>,
 <20180215165024.9736-2-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1565213858=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180215165024.9736-2-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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

--===============1565213858==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652F2D95D479102FBBAF70AF7F40BN6PR12MB1652namp_"

--_000_BN6PR12MB1652F2D95D479102FBBAF70AF7F40BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Thursday, February 15, 2018 11:50:24 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH xf86-video-ati 2/2] Simplify depth 30 "kernel too old" erro=
r message

From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

We know it's depth 30, need to have xf86DrvMsg fill it in.

Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
---
 src/radeon_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/radeon_kms.c b/src/radeon_kms.c
index b268f7ea7..85390e306 100644
--- a/src/radeon_kms.c
+++ b/src/radeon_kms.c
@@ -1778,8 +1778,7 @@ Bool RADEONPreInit_KMS(ScrnInfoPtr pScrn, int flags)
     /* Depth 30 only supported since Linux 3.16 / kms driver minor version=
 39 */
     if (pScrn->depth =3D=3D 30 && info->dri2.pKernelDRMVersion->version_mi=
nor < 39) {
         xf86DrvMsg(pScrn->scrnIndex, X_ERROR,
-                  "Given depth (%d) is not supported. Kernel too old. Need=
s Linux 3.16+\n",
-                  pScrn->depth);
+                  "Depth 30 is not supported. Kernel too old. Needs Linux =
3.16+\n");
         return FALSE;
     }

--
2.16.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652F2D95D479102FBBAF70AF7F40BN6PR12MB1652namp_
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
<b>Sent:</b> Thursday, February 15, 2018 11:50:24 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH xf86-video-ati 2/2] Simplify depth 30 &quot;kernel t=
oo old&quot; error message</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<br>
We know it's depth 30, need to have xf86DrvMsg fill it in.<br>
<br>
Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;src/radeon_kms.c | 3 &#43;--<br>
&nbsp;1 file changed, 1 insertion(&#43;), 2 deletions(-)<br>
<br>
diff --git a/src/radeon_kms.c b/src/radeon_kms.c<br>
index b268f7ea7..85390e306 100644<br>
--- a/src/radeon_kms.c<br>
&#43;&#43;&#43; b/src/radeon_kms.c<br>
@@ -1778,8 &#43;1778,7 @@ Bool RADEONPreInit_KMS(ScrnInfoPtr pScrn, int fla=
gs)<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Depth 30 only supported since Linux 3.16 / kms =
driver minor version 39 */<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (pScrn-&gt;depth =3D=3D 30 &amp;&amp; info-&gt;=
dri2.pKernelDRMVersion-&gt;version_minor &lt; 39) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xf86DrvMsg(pScrn-&gt;scrnI=
ndex, X_ERROR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Given depth (%d) is not supported. Kerne=
l too old. Needs Linux 3.16&#43;\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; pScrn-&gt;depth);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Depth 30 is not supported. Kernel to=
o old. Needs Linux 3.16&#43;\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return FALSE;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
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

--_000_BN6PR12MB1652F2D95D479102FBBAF70AF7F40BN6PR12MB1652namp_--

--===============1565213858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1565213858==--
