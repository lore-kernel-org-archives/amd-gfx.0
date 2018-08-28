From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [Vega10] [bisected] Performance regression with Dawn Of War III
 and RADV
Date: Tue, 28 Aug 2018 14:19:30 +0000
Message-ID: <BN6PR12MB18096C36DFCD6FEBC39A200AF70A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <90c1a4f4-0745-19af-a254-0942804cca3e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2031420742=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <90c1a4f4-0745-19af-a254-0942804cca3e-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Samuel Pitoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2031420742==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18096C36DFCD6FEBC39A200AF70A0BN6PR12MB1809namp_"

--_000_BN6PR12MB18096C36DFCD6FEBC39A200AF70A0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

IIRC, this was a dpm bug fix, such that prior to the patch, the mclk would =
never drop below 500Mhz or something like that and after the fix, it goes d=
own to the lowest frequency.  The dpm heuristics are not a perfect match fo=
r some games.


Alex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Samuel P=
itoiset <samuel.pitoiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, August 28, 2018 8:12:12 AM
To: Quan, Evan
Cc: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [Vega10] [bisected] Performance regression with Dawn Of War III an=
d RADV

Hi there,

I found a performance regression that affects my Vega10 with Dawn Of War
III and RADV (ie. 74FPS -> 71FPS). I bisected to:

commit ea7f492b6ac6eced0d09ccb2b0a2909a0025e22e
Author: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
Date:   Mon Jul 16 17:23:19 2018 +0800

     drm/amd/powerplay: correct the argument for PPSMC_MSG_SetUclkFastSwitc=
h

     The argument was set wrongly. Fast/slow switch was asked when there is
     actually a slow/fast switch needed.

     Change-Id: Ibcfdf741dea1700cc3796f84291606231e732f4b
     Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
     Reviewed-by: Rex Zhu<rex.zhu-5C7GfCeVMHo@public.gmane.org>

Any ideas?

Thanks,
Samuel.
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18096C36DFCD6FEBC39A200AF70A0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">IIRC, this was a dpm bug fix, suc=
h that prior to the patch, the mclk would never drop below 500Mhz or someth=
ing like that and after the fix, it goes down to the lowest frequency.&nbsp=
; The dpm heuristics are not a perfect
 match for some games.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Samuel Pitoiset &lt;samuel.pi=
toiset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, August 28, 2018 8:12:12 AM<br>
<b>To:</b> Quan, Evan<br>
<b>Cc:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [Vega10] [bisected] Performance regression with Dawn Of War=
 III and RADV</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi there,<br>
<br>
I found a performance regression that affects my Vega10 with Dawn Of War <b=
r>
III and RADV (ie. 74FPS -&gt; 71FPS). I bisected to:<br>
<br>
commit ea7f492b6ac6eced0d09ccb2b0a2909a0025e22e<br>
Author: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Mon Jul 16 17:23:19 2018 &#43;0800<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; drm/amd/powerplay: correct the argument for PPSMC_=
MSG_SetUclkFastSwitch<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; The argument was set wrongly. Fast/slow switch was=
 asked when there is<br>
&nbsp;&nbsp;&nbsp;&nbsp; actually a slow/fast switch needed.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Change-Id: Ibcfdf741dea1700cc3796f84291606231e732f=
4b<br>
&nbsp;&nbsp;&nbsp;&nbsp; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp; Reviewed-by: Rex Zhu&lt;rex.zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Any ideas?<br>
<br>
Thanks,<br>
Samuel.<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18096C36DFCD6FEBC39A200AF70A0BN6PR12MB1809namp_--

--===============2031420742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2031420742==--
