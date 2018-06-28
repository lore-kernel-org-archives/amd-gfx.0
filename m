From: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: update documentation for amdgpu_drv.c
Date: Thu, 28 Jun 2018 18:02:35 +0000
Message-ID: <CY4PR12MB15119F358F68B52729D44B3CFD4F0@CY4PR12MB1511.namprd12.prod.outlook.com>
References: <1530123285-28043-1-git-send-email-sonny.jiang@amd.com>,
 <6a028ca5-f799-8cc8-fb74-7a036a428d80@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0440606951=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6a028ca5-f799-8cc8-fb74-7a036a428d80-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0440606951==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB15119F358F68B52729D44B3CFD4F0CY4PR12MB1511namp_"

--_000_CY4PR12MB15119F358F68B52729D44B3CFD4F0CY4PR12MB1511namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


What's your opinion about Michel's suggestion?


Thanks,

Sonny

________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Thursday, June 28, 2018 4:39:57 AM
To: Jiang, Sonny
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: update documentation for amdgpu_drv.c


Hi Sonny,


would it be possible to put the documentation of each parameter directly
next to its definition / declaration? Otherwise, I'm afraid the
documentation will quickly fall out of date WRT the code.


> +/**
> + * DOC: module_parameters

Otherwise, this needs to be referenced in Documentation/gpu/amdgpu.rst,
or the contents of this comment don't show up in the generated
documentation.


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--_000_CY4PR12MB15119F358F68B52729D44B3CFD4F0CY4PR12MB1511namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">What's your opinion about Michel'=
s suggestion?
<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks,</p>
<p style=3D"margin-top:0;margin-bottom:0">Sonny<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 28, 2018 4:39:57 AM<br>
<b>To:</b> Jiang, Sonny<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: update documentation for amdgpu_drv=
.c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
Hi Sonny,<br>
<br>
<br>
would it be possible to put the documentation of each parameter directly<br=
>
next to its definition / declaration? Otherwise, I'm afraid the<br>
documentation will quickly fall out of date WRT the code.<br>
<br>
<br>
&gt; &#43;/**<br>
&gt; &#43; * DOC: module_parameters<br>
<br>
Otherwise, this needs to be referenced in Documentation/gpu/amdgpu.rst,<br>
or the contents of this comment don't show up in the generated<br>
documentation.<br>
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

--_000_CY4PR12MB15119F358F68B52729D44B3CFD4F0CY4PR12MB1511namp_--

--===============0440606951==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0440606951==--
