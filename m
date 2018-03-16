From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: no job timeout setting on compute queues
Date: Fri, 16 Mar 2018 17:17:14 +0000
Message-ID: <CY4PR12MB16535036642155291C39F030F7D70@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1521175952-21758-1-git-send-email-evan.quan@amd.com>
 <CY4PR12MB1653E72F547ABAECAC0A91A3F7D70@CY4PR12MB1653.namprd12.prod.outlook.com>,
 <bc7b30b9-7230-fdfe-4fd1-0f4dcd26a38d@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1618828545=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bc7b30b9-7230-fdfe-4fd1-0f4dcd26a38d-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1618828545==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16535036642155291C39F030F7D70CY4PR12MB1653namp_"

--_000_CY4PR12MB16535036642155291C39F030F7D70CY4PR12MB1653namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

How about something like this:

/* Disable timeout when GPU reset is disabled to avoid confusing timeout me=
ssages in the kernel log */

If (amdgpu_gpu_recovery =3D=3D 0 || amdgpu_gpu_recovery =3D=3D -1)

    amdgpu_lockup_timeout =3D MAX_SCHEDULE_TIMEOUT;


Alex

________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Friday, March 16, 2018 12:25:03 PM
To: Deucher, Alexander; Quan, Evan
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: no job timeout setting on compute queues

On 2018-03-16 05:14 PM, Deucher, Alexander wrote:
> Since GPU reset is not enabled yet anyway, a timeout will just print a
> message, can we just change amdgpu_lockup_timeout to
> MAX_SCHEDULE_TIMEOUT until we enable GPU reset?

Wouldn't that be rather surprising for somebody who sets
amdgpu.gpu_recovery=3D1 ?


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--_000_CY4PR12MB16535036642155291C39F030F7D70CY4PR12MB1653namp_
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
<p style=3D"margin-top:0;margin-bottom:0">How about something like this:</p=
>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><font face=3D"Ca=
libri,Helvetica,sans-serif">/* Disable timeout when GPU reset is disabled t=
o avoid confusing timeout messages in the kernel log */</font></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><font face=3D"Ca=
libri,Helvetica,sans-serif">If (<span>amdgpu_gpu_recovery =3D=3D 0 ||
<span>amdgpu_gpu_recovery =3D=3D -1</span>)</span> </font></font></p>
<p style=3D"margin-top:0;margin-bottom:0">&nbsp;&nbsp;&nbsp; <font size=3D"=
3" face=3D"Calibri,Helvetica,sans-serif" color=3D"black">
<span style=3D"font-size:12pt;" id=3D"divtagdefaultwrapper"><font size=3D"2=
"><span style=3D"font-size:11pt;">amdgpu_lockup_timeout</span></font></span=
></font> =3D
<font size=3D"3" face=3D"Calibri,Helvetica,sans-serif" color=3D"black"><spa=
n style=3D"font-size:12pt;" id=3D"divtagdefaultwrapper"><font size=3D"2"><s=
pan style=3D"font-size:11pt;">MAX_SCHEDULE_TIMEOUT;</span></font></span></f=
ont></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"3" face=3D"Calibri,=
Helvetica,sans-serif" color=3D"black"><span style=3D"font-size:12pt;" id=3D=
"divtagdefaultwrapper"><font size=3D"2"><span style=3D"font-size:11pt;"><br=
>
</span></font></span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"3" face=3D"Calibri,=
Helvetica,sans-serif" color=3D"black"><span style=3D"font-size:12pt;" id=3D=
"divtagdefaultwrapper"><font size=3D"2"><span style=3D"font-size:11pt;">Ale=
x</span></font></span></font><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, March 16, 2018 12:25:03 PM<br>
<b>To:</b> Deucher, Alexander; Quan, Evan<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: no job timeout setting on compute q=
ueues</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-03-16 05:14 PM, Deucher, Alexander wrote:<=
br>
&gt; Since GPU reset is not enabled yet anyway, a timeout will just print a=
<br>
&gt; message, can we just change amdgpu_lockup_timeout to<br>
&gt; MAX_SCHEDULE_TIMEOUT until we enable GPU reset?<br>
<br>
Wouldn't that be rather surprising for somebody who sets<br>
amdgpu.gpu_recovery=3D1 ?<br>
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
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB16535036642155291C39F030F7D70CY4PR12MB1653namp_--

--===============1618828545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1618828545==--
