From: "Abramov, Slava" <Slava.Abramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 1/2] Remove #if 0'd code
Date: Thu, 28 Jun 2018 15:38:16 +0000
Message-ID: <CY4PR12MB13042A723690746E0A043209FE4F0@CY4PR12MB1304.namprd12.prod.outlook.com>
References: <20180627163941.18737-1-michel@daenzer.net>
 <CY4PR12MB13040D289B98AF5798E9C4EEFE480@CY4PR12MB1304.namprd12.prod.outlook.com>,
 <f08efa46-1598-1402-2ba2-757d8bd9b841@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0747887315=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f08efa46-1598-1402-2ba2-757d8bd9b841-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0747887315==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB13042A723690746E0A043209FE4F0CY4PR12MB1304namp_"

--_000_CY4PR12MB13042A723690746E0A043209FE4F0CY4PR12MB1304namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Michel,

My review is only for the first patch.


Slava
________________________________
From: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Thursday, June 28, 2018 4:26:28 AM
To: Abramov, Slava
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH xf86-video-amdgpu 1/2] Remove #if 0'd code

On 2018-06-27 08:29 PM, Abramov, Slava wrote:
> I wonder how '#if 0' made its way upstream, but besides this

It was inherited from xf86-video-ati, where it's been in
drmmode_display.c since that file was first added (in 2009).


> Reviewed-by: Slava Abramov <slava.abramov-5C7GfCeVMHo@public.gmane.org>

Thanks Slava (and Alex)! Is that only for this patch, or also for patch
2 of the series?


--
Earthling Michel D=E4nzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer

--_000_CY4PR12MB13042A723690746E0A043209FE4F0CY4PR12MB1304namp_
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
Michel,
<div><br>
</div>
<div>My review is only for the first patch.&nbsp;&nbsp;</div>
<div><br>
</div>
<div><br>
</div>
<div>Slava</div>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 28, 2018 4:26:28 AM<br>
<b>To:</b> Abramov, Slava<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH xf86-video-amdgpu 1/2] Remove #if 0'd code</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-06-27 08:29 PM, Abramov, Slava wrote:<br>
&gt; I wonder how '#if 0' made its way upstream, but besides this<br>
<br>
It was inherited from xf86-video-ati, where it's been in<br>
drmmode_display.c since that file was first added (in 2009).<br>
<br>
<br>
&gt; Reviewed-by: Slava Abramov &lt;slava.abramov-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Thanks Slava (and Alex)! Is that only for this patch, or also for patch<br>
2 of the series?<br>
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

--_000_CY4PR12MB13042A723690746E0A043209FE4F0CY4PR12MB1304namp_--

--===============0747887315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0747887315==--
