From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: remove init of CIK VMIDs 8-16 for amdkfd
Date: Wed, 29 Nov 2017 16:59:45 +0000
Message-ID: <BN6PR12MB1652F328D02A19D631383E07F73B0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1511969038-3094-1-git-send-email-oded.gabbay@gmail.com>,
 <71a95f03-0775-f20a-d6df-2725fe212e80@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1747678687=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <71a95f03-0775-f20a-d6df-2725fe212e80-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org" <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1747678687==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652F328D02A19D631383E07F73B0BN6PR12MB1652namp_"

--_000_BN6PR12MB1652F328D02A19D631383E07F73B0BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I'll add it to my -fixes branch.

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Wednesday, November 29, 2017 11:57:26 AM
To: Oded Gabbay
Cc: Deucher, Alexander; deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org
Subject: Re: [PATCH] drm/radeon: remove init of CIK VMIDs 8-16 for amdkfd

On 2017-11-29 04:23 PM, Oded Gabbay wrote:
> VMIDs 8-16 in Kaveri were reserved for use by the amdkfd driver.
> Because we removed amdkfd support from radeon, those VMIDs are now
> used by radeon and are initialized by radeon.
>
> This patch removes the function that initialized those VMIDs for amdkfd
> use.
> This initialization overridden the radeon initialization and caused GPU
> faults and GUI crashed.
>
> This bug was found by Michel D=E4nzer.
>
> Signed-off-by: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Pushed to our internal amd-staging-drm-next branch, with some
modifications to the tags in the commit log, thanks!


Alex, this needs to go into 4.15.


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652F328D02A19D631383E07F73B0BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">I'll add it to my -fixes branch.<=
br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Wednesday, November 29, 2017 11:57:26 AM<br>
<b>To:</b> Oded Gabbay<br>
<b>Cc:</b> Deucher, Alexander; deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org; amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/radeon: remove init of CIK VMIDs 8-16 for a=
mdkfd</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:10pt;=
">
<div class=3D"PlainText">On 2017-11-29 04:23 PM, Oded Gabbay wrote:<br>
&gt; VMIDs 8-16 in Kaveri were reserved for use by the amdkfd driver.<br>
&gt; Because we removed amdkfd support from radeon, those VMIDs are now<br>
&gt; used by radeon and are initialized by radeon.<br>
&gt; <br>
&gt; This patch removes the function that initialized those VMIDs for amdkf=
d<br>
&gt; use.<br>
&gt; This initialization overridden the radeon initialization and caused GP=
U<br>
&gt; faults and GUI crashed.<br>
&gt; <br>
&gt; This bug was found by Michel D=E4nzer.<br>
&gt; <br>
&gt; Signed-off-by: Oded Gabbay &lt;oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<br>
Pushed to our internal amd-staging-drm-next branch, with some<br>
modifications to the tags in the commit log, thanks!<br>
<br>
<br>
Alex, this needs to go into 4.15.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://www.amd.com=
">
http://www.amd.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1652F328D02A19D631383E07F73B0BN6PR12MB1652namp_--

--===============1747678687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1747678687==--
