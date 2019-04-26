From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: support gpu recovery tests on compute rings
Date: Fri, 26 Apr 2019 14:24:21 +0000
Message-ID: <CY4PR12MB18131939EE3B152A461DDE23F73E0@CY4PR12MB1813.namprd12.prod.outlook.com>
References: <20190426072414.21184-1-evan.quan@amd.com>
 <f9efc27c-6e0c-6a6b-e760-cba349adc63a@gmail.com>
 <MN2PR12MB334425F855709F0662BB8952E43E0@MN2PR12MB3344.namprd12.prod.outlook.com>,
 <cd13fa95-1a65-1c0f-01d4-0f8819da5a60@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1243455454=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cd13fa95-1a65-1c0f-01d4-0f8819da5a60-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1243455454==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB18131939EE3B152A461DDE23F73E0CY4PR12MB1813namp_"

--_000_CY4PR12MB18131939EE3B152A461DDE23F73E0CY4PR12MB1813namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

How about an interface to change the timeout on a per engine (gfx, compute,=
 dma, etc.) basis?
amdgpu.lockup_timeout=3D<global>,<gfx>,<compute>,<sdma>,<decode>,<encode>
if only one parameter is given, we change it globably.  If more are given, =
we override the global one.  Could also do a sysfs interface to change it o=
n the fly.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Michel D=
=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Sent: Friday, April 26, 2019 4:35 AM
To: Quan, Evan; Koenig, Christian
Cc: Xu, Feifei; Cui, Flora; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: support gpu recovery tests on compute ring=
s

On 2019-04-26 10:20 a.m., Quan, Evan wrote:
> My concern is there is already one module parameter "lockup_timeout".
> parm:           lockup_timeout:GPU lockup timeout in ms > 0 (default 1000=
0) (int)
>
> Adding one more "timeout" seems redundant.
> And that will makes the description of "lockup_timeout"(seems working for=
 all jobs) does not match its real effect(affect only non-compute jobs).
>
> A better way is to rename "lockup_timeout" to "non-compute lockup_timeout=
". But I do not think we can change existing module parameter. Right?

Right. Also, there are already too many amdgpu module parameters, we
should try to remove some rather than adding new ones for every little
thing that could be tweaked. :)

One possibility might be to optionally allow passing multiple values to
lockup_timeout, e.g.

 amdgpu.lockup_timeout=3D10000,0

The first value would need to have the same meaning as now for backwards
compatibility.


--
Earthling Michel D=E4nzer               |              https://www.amd.com
Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB18131939EE3B152A461DDE23F73E0CY4PR12MB1813namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
How about an interface to change the timeout on a per engine (gfx, compute,=
 dma, etc.) basis?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">amdgpu.lockup_timeout=3D&lt=
;global&gt;,&lt;gfx&gt;,&lt;compute&gt;</span></font>,&lt;sdma&gt;,&lt;deco=
de&gt;,&lt;encode&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
if only one parameter is given, we change it globably.&nbsp; If more are gi=
ven, we override the global one.&nbsp; Could also do a sysfs interface to c=
hange it on the fly.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> Friday, April 26, 2019 4:35 AM<br>
<b>To:</b> Quan, Evan; Koenig, Christian<br>
<b>Cc:</b> Xu, Feifei; Cui, Flora; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: support gpu recovery tests on compu=
te rings</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2019-04-26 10:20 a.m., Quan, Evan wrote:<br>
&gt; My concern is there is already one module parameter &quot;lockup_timeo=
ut&quot;.<br>
&gt; parm:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lock=
up_timeout:GPU lockup timeout in ms &gt; 0 (default 10000) (int)<br>
&gt; <br>
&gt; Adding one more &quot;timeout&quot; seems redundant. <br>
&gt; And that will makes the description of &quot;lockup_timeout&quot;(seem=
s working for all jobs) does not match its real effect(affect only non-comp=
ute jobs).<br>
&gt; <br>
&gt; A better way is to rename &quot;lockup_timeout&quot; to &quot;non-comp=
ute lockup_timeout&quot;. But I do not think we can change existing module =
parameter. Right?<br>
<br>
Right. Also, there are already too many amdgpu module parameters, we<br>
should try to remove some rather than adding new ones for every little<br>
thing that could be tweaked. :)<br>
<br>
One possibility might be to optionally allow passing multiple values to<br>
lockup_timeout, e.g.<br>
<br>
&nbsp;amdgpu.lockup_timeout=3D10000,0<br>
<br>
The first value would need to have the same meaning as now for backwards<br=
>
compatibility.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://www.amd.com">
https://www.amd.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB18131939EE3B152A461DDE23F73E0CY4PR12MB1813namp_--

--===============1243455454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1243455454==--
