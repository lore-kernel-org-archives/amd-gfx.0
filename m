From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be atomic
Date: Mon, 3 Jul 2017 09:44:35 +0000
Message-ID: <BLUPR12MB04498F84A6D9E542753D234C84D60@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1498770496-28032-1-git-send-email-Shaoyun.Liu@amd.com>
 <14d97048-a0ba-69cd-1eac-e82c4462c51f@daenzer.net>
 <d9834700-f977-e5d5-2c79-7c2332ba44e9@vodafone.de>,
 <DM5PR12MB11795DAAD88232D2874CEF17F4D30@DM5PR12MB1179.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1559554272=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB11795DAAD88232D2874CEF17F4D30-2J9CzHegvk8p/eksZXEfgQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Shaoyun" <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1559554272==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB04498F84A6D9E542753D234C84D60BLUPR12MB0449namp_"

--_000_BLUPR12MB04498F84A6D9E542753D234C84D60BLUPR12MB0449namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Shaoyun


looks you want to make KIQ reg access be atomic & UN-interruptible,

I think most user of KIQ reg access is not in atomic context, so your patch=
 only benefit for the place using KIQ from IRQ.

why not implement another KIQ reg access function ? e.g. :

amdgpu_virt_kiq_rreg_atomic(...);
amdgpu_virt_kiq_wreg_atomic(...);


that way you can satisfy your requirement and not introduce unknown issue f=
or other places that calling original virt_kiq_r/weg() function.


because busy polling have chance to hang cpu in SR-IOV (imagine 16 VF, and =
many VF doing FLR one by one,   your busy polling may let guest kernel cpu =
stuck in ATOMIC_CONTEXT for more than 5 seconds )


BR Monk

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Liu, Sha=
oyun <Shaoyun.Liu-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, June 30, 2017 10:55:39 PM
To: Christian K=F6nig; Michel D=E4nzer
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH] drm/amdgpu: Make KIQ read/write register routine be at=
omic

Hi , Christian
The new code actually will not use the fence function , it just need a memo=
ry that expose both CPU and  GPU address .  Do you  really want to add the =
wrap functions that just expose the CPU and  GPU address in this case  ?

Regards
Shaoyun.liu


-----Original Message-----
From: Christian K=F6nig [mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org]
Sent: Friday, June 30, 2017 3:57 AM
To: Michel D=E4nzer; Liu, Shaoyun
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be at=
omic

Am 30.06.2017 um 03:21 schrieb Michel D=E4nzer:
> On 30/06/17 06:08 AM, Shaoyun Liu wrote:
>> 1. Use spin lock instead of mutex in KIQ 2. Directly write to KIQ
>> fence address instead of using fence_emit() 3. Disable the interrupt
>> for KIQ read/write and use CPU polling
> This list indicates that this patch should be split up in at least
> three patches. :)
Yeah, apart from that is is not a good idea to mess with the fence internal=
s directly in the KIQ code, please add a helper in the fence code for this.

Regards,
Christian.
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BLUPR12MB04498F84A6D9E542753D234C84D60BLUPR12MB0449namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>Hi Shaoyun <br>
</p>
<p><br>
</p>
<p>looks you want to make KIQ reg access be atomic &amp; UN-interruptible,<=
/p>
<p>I think most user of KIQ reg access is not in atomic context, so your pa=
tch only benefit for the place using KIQ from IRQ.</p>
<p>why not implement another KIQ reg access function ? e.g. :<br>
</p>
<div style=3D"color:#d4d4d4; background-color:#1e1e1e; font-family:'Droid S=
ans Mono','Courier New',monospace,'Droid Sans Fallback'; font-weight:normal=
; font-size:14px; line-height:19px; white-space:pre">
<div><span style=3D"color:#dcdcaa">amdgpu_virt_kiq_rreg_atomic(...);<br>
<span style=3D"color:#dcdcaa">amdgpu_virt_kiq_wreg_atomic(...)</span>;</spa=
n><br>
</div>
</div>
<p></p>
<p><br>
</p>
<p>that way you can satisfy your requirement and not introduce unknown issu=
e for other places that calling original virt_kiq_r/weg() function.</p>
<p><br>
</p>
<p>because busy polling have chance to hang cpu in SR-IOV (imagine 16 VF, a=
nd many VF doing FLR one by one, &nbsp; your busy polling may let guest ker=
nel cpu stuck in ATOMIC_CONTEXT for more than 5 seconds )<br>
</p>
<p><br>
</p>
<p>BR Monk<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Liu, Shaoyun &lt;Shaoyun.Li=
u@amd.com&gt;<br>
<b>Sent:</b> Friday, June 30, 2017 10:55:39 PM<br>
<b>To:</b> Christian K=F6nig; Michel D=E4nzer<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Make KIQ read/write register routin=
e be atomic</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Hi , Christian<br>
The new code actually will not use the fence function , it just need a memo=
ry that expose both CPU and&nbsp; GPU address .&nbsp; Do you&nbsp; really w=
ant to add the wrap functions that just expose the CPU and&nbsp; GPU addres=
s in this case&nbsp; ?<br>
<br>
Regards<br>
Shaoyun.liu<br>
<br>
&nbsp;<br>
-----Original Message-----<br>
From: Christian K=F6nig [<a href=3D"mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">mailto:=
deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>]
<br>
Sent: Friday, June 30, 2017 3:57 AM<br>
To: Michel D=E4nzer; Liu, Shaoyun<br>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Subject: Re: [PATCH] drm/amdgpu: Make KIQ read/write register routine be at=
omic<br>
<br>
Am 30.06.2017 um 03:21 schrieb Michel D=E4nzer:<br>
&gt; On 30/06/17 06:08 AM, Shaoyun Liu wrote:<br>
&gt;&gt; 1. Use spin lock instead of mutex in KIQ 2. Directly write to KIQ =
<br>
&gt;&gt; fence address instead of using fence_emit() 3. Disable the interru=
pt <br>
&gt;&gt; for KIQ read/write and use CPU polling<br>
&gt; This list indicates that this patch should be split up in at least <br=
>
&gt; three patches. :)<br>
Yeah, apart from that is is not a good idea to mess with the fence internal=
s directly in the KIQ code, please add a helper in the fence code for this.=
<br>
<br>
Regards,<br>
Christian.<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_BLUPR12MB04498F84A6D9E542753D234C84D60BLUPR12MB0449namp_--

--===============1559554272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1559554272==--
