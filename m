From: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/gfx: spread queues across pipes again for
 1 MEC parts
Date: Fri, 9 Jun 2017 12:53:41 +0000
Message-ID: <BN6PR12MB1826F82B67A04D9A8C0743DBF2CE0@BN6PR12MB1826.namprd12.prod.outlook.com>
References: <1497012570-24173-1-git-send-email-alexander.deucher@amd.com>,
 <1497012570-24173-2-git-send-email-alexander.deucher@amd.com>
 <BN6PR12MB18266449B47EF151EF8A6C6AF2CE0@BN6PR12MB1826.namprd12.prod.outlook.com>,
 <CY4PR12MB1653373171BC28933F881561F7CE0@CY4PR12MB1653.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0586431764=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1653373171BC28933F881561F7CE0-rpdhrqHFk06apTa93KjAaQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex
 Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0586431764==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1826F82B67A04D9A8C0743DBF2CE0BN6PR12MB1826namp_"

--_000_BN6PR12MB1826F82B67A04D9A8C0743DBF2CE0BN6PR12MB1826namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

OK.

Regards,
Shirish S
________________________________
From: Deucher, Alexander
Sent: Friday, June 9, 2017 6:23:12 PM
To: S, Shirish; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Alex Deucher
Subject: RE: [PATCH 2/2] drm/amdgpu/gfx: spread queues across pipes again f=
or 1 MEC parts

Please include patch 1 of this series as well.

From: S, Shirish
Sent: Friday, June 09, 2017 8:53 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Alex Deucher
Cc: Deucher, Alexander
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx: spread queues across pipes again f=
or 1 MEC parts

Sure Alex.
I shall update the result on stoney soon.
Regards,
Shirish S
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Friday, June 9, 2017 6:19:30 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander; S, Shirish
Subject: [PATCH 2/2] drm/amdgpu/gfx: spread queues across pipes again for 1=
 MEC parts

Now that interrupts are properly enabled for all pipes, this
should be function properly.

Cc: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org<mailto:shirish.s-5C7GfCeVMHo@public.gmane.org>>
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deu=
cher-5C7GfCeVMHo@public.gmane.org>>
---

Shirish,

Can you test this change on your Stoney setup?

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index dfbf027..03c23e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -125,15 +125,9 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_de=
vice *adev)
                 if (mec >=3D adev->gfx.mec.num_mec)
                         break;

-               if (adev->gfx.mec.num_mec > 1) {
-                       /* policy: amdgpu owns the first two queues of the =
first MEC */
-                       if (mec =3D=3D 0 && queue < 2)
-                               set_bit(i, adev->gfx.mec.queue_bitmap);
-               } else {
-                       /* policy: amdgpu owns all queues in the first pipe=
 */
-                       if (mec =3D=3D 0 && pipe =3D=3D 0)
-                               set_bit(i, adev->gfx.mec.queue_bitmap);
-               }
+               /* policy: amdgpu owns the first two queues of the first ME=
C */
+               if (mec =3D=3D 0 && queue < 2)
+                       set_bit(i, adev->gfx.mec.queue_bitmap);
         }

         /* update the number of active compute rings */
--
2.5.5

--_000_BN6PR12MB1826F82B67A04D9A8C0743DBF2CE0BN6PR12MB1826namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style>
<!--
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Tahoma}
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman","serif"}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif"}
p.emailquote, li.emailquote, div.emailquote
	{margin-right:0in;
	margin-left:1.0pt;
	border:none;
	padding:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif"}
span.EmailStyle18
	{font-family:"Calibri","sans-serif";
	color:#1F497D}
span.BalloonTextChar
	{font-family:"Tahoma","sans-serif"}
.MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.WordSection1
	{}
-->
</style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black; background-color:white">
OK.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black; background-color:white">
Regards,<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black; background-color:white">
Shirish S<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<br=
>
<b>Sent:</b> Friday, June 9, 2017 6:23:12 PM<br>
<b>To:</b> S, Shirish; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Alex Deucher<br>
<b>Subject:</b> RE: [PATCH 2/2] drm/amdgpu/gfx: spread queues across pipes =
again for 1 MEC parts</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">Please include patch 1 =
of this series as well.</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot;C=
alibri&quot;,&quot;sans-serif&quot;; color:#1F497D">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #B5C4DF 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt; font-family:&quo=
t;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-=
size:10.0pt; font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> S, Shi=
rish
<br>
<b>Sent:</b> Friday, June 09, 2017 8:53 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Alex Deucher<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/gfx: spread queues across pipes =
again for 1 MEC parts</span></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
11.0pt; font-family:&quot;Arial&quot;,&quot;sans-serif&quot;; color:black">=
Sure Alex.</span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
11.0pt; font-family:&quot;Arial&quot;,&quot;sans-serif&quot;; color:black">=
I shall update the result on stoney soon.</span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
11.0pt; font-family:&quot;Arial&quot;,&quot;sans-serif&quot;; color:black">=
Regards,</span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
11.0pt; font-family:&quot;Arial&quot;,&quot;sans-serif&quot;; color:black">=
Shirish S</span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&quo=
t;Calibri&quot;,&quot;sans-serif&quot;; color:black">From:</span></b><span =
style=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,&quot;sans-serif=
&quot;; color:black"> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.=
com">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, June 9, 2017 6:19:30 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Deucher, Alexander; S, Shirish<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu/gfx: spread queues across pipes agai=
n for 1 MEC parts</span></p>
<div>
<p class=3D"MsoNormal">&nbsp;</p>
</div>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:10.0pt">Now that interrupts are properly enabled for all pipes, this<br=
>
should be function properly.<br>
<br>
Cc: Shirish S &lt;<a href=3D"mailto:shirish.s-5C7GfCeVMHo@public.gmane.org">shirish.s-5C7GfCeVMHo@public.gmane.org</a=
>&gt;<br>
Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org=
">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
<br>
Shirish,<br>
<br>
Can you test this change on your Stoney setup?<br>
<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 12 &#43;&#43;&#43;---------<br>
&nbsp;1 file changed, 3 insertions(&#43;), 9 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index dfbf027..03c23e3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -125,15 &#43;125,9 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgp=
u_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (mec &gt;=3D adev-&gt;gfx.mec.num_mec)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;gfx.mec.num_mec &gt; 1) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* policy: amdgp=
u owns the first two queues of the first MEC */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mec =3D=3D 0=
 &amp;&amp; queue &lt; 2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(i, adev-&gt;gfx.mec.queue_bitmap);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* policy: amdgp=
u owns all queues in the first pipe */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mec =3D=3D 0=
 &amp;&amp; pipe =3D=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(i, adev-&gt;gfx.mec.queue_bitmap);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* policy: amdgpu owns the first two queues of the first MEC=
 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (mec =3D=3D 0 &amp;&amp; queue &lt; 2)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(i, a=
dev-&gt;gfx.mec.queue_bitmap);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* update the number of ac=
tive compute rings */<br>
-- <br>
2.5.5</span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1826F82B67A04D9A8C0743DBF2CE0BN6PR12MB1826namp_--

--===============0586431764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0586431764==--
