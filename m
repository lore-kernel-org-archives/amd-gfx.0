From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Mon, 19 Mar 2018 19:54:25 +0000
Message-ID: <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
 <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
 <6febc0d1-0171-3cc1-ff22-69aa4ef36036@daenzer.net>
 <12178e4c-6b48-2c3b-9970-2ca30624a5bb@gmail.com>
 <29dba5ab-f4f3-551b-ec94-2d6433e8aa21@daenzer.net>
 <1141c511-597e-c81b-6ffd-800ff846f2c1@gmail.com>
 <1b643a78-d86a-b3bf-5f92-089a43201dd5@daenzer.net>
 <06e9160c-b4d4-6c3a-ff9f-04b40b94c7a0@amd.com>
 <BY1PR12MB0504A300C476CC31C59BFE97F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <2c995c37-0d0b-8fde-0118-57d7a62630ef@amd.com>
 <CAAxE2A5kq2oZtJRm2df1fjtb_p1m2_nvCmzv9y8mbO-GS8cGrw@mail.gmail.com>
 <BY1PR12MB0504183ED35A54559D22E041F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <f25ebe1d-0b19-e972-5eba-84570e625456@gmail.com>,
 <BY1PR12MB05044A2A50F2580904C8AFB5F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1061247716=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY1PR12MB05044A2A50F2580904C8AFB5F5D40-PicGAnIBOoZIlHzfMOeg3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, =?Windows-1252?Q?Marek_Ol=9A=E1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?Windows-1252?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1061247716==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18099E7295CB0301EF536924F7D40BN6PR12MB1809namp_"

--_000_BN6PR12MB18099E7295CB0301EF536924F7D40BN6PR12MB1809namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

My personal preference is still to plumb this through to mesa rather than f=
orcing it in the kernel.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Li, Samu=
el <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, March 19, 2018 3:50:34 PM
To: Koenig, Christian; Marek Ol=9A=E1k
Cc: Alex Deucher; Michel D=E4nzer; amd-gfx list
Subject: RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support


Christian,



You misunderstood Alex=92s comments,



>Regardless of which scenarios we need to support, I think we also need

>to really plumb this through to mesa however since user space is who

>ultimately requests the location.  Overriding it in the kernel gets

>tricky and can lead to ping-ponging as others have noted.  Better to



Here Alex mentioned the scenarios is 1)VRAM, 2)GTT, 3)VRAM/GTT.

His concern is this might cause ping-pong, not about preferred domain. Sinc=
e preferred domain can solve the ping-pong issue, it shall address his conc=
ern here.



Regards,

Samuel Li



From: Christian K=F6nig [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Monday, March 19, 2018 3:45 PM
To: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Marek Ol=9A=E1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Koe=
nig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Michel D=E4nzer <michel@daenzer.n=
et>; amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support



Quoting Alex:


Regardless of which scenarios we need to support, I think we also need

to really plumb this through to mesa however since user space is who

ultimately requests the location.  Overriding it in the kernel gets

tricky and can lead to ping-ponging as others have noted.  Better to

have user space know what chips support it or not and request display

buffers in GTT or VRAM from the start.

And I completely agree with Alex here. So overriding the domain in the kern=
el is a serious NAK from my side as well.

Please implement the necessary bits in Mesa, shouldn't be more than a few l=
ines of code anyway.

Regards,
Christian.

Am 19.03.2018 um 20:42 schrieb Li, Samuel:

Agreed.



>I think that the consensus with Alex and me is that we should avoid exactl=
y that.
Christian, Alex=92s concern is about ping-pong, not about the preferred dom=
ain.



Regards,

Samuel Li



From: Marek Ol=9A=E1k [mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Monday, March 19, 2018 3:39 PM
To: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org><mailto:Christian.Koenig@am=
d.com>
Cc: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org><mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Michel D=E4nz=
er <michel-otUistvHUpPR7s880joybQ@public.gmane.org><mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Alex Deucher <alexdeuch=
er-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org><mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx list <amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org><mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support



On Mon, Mar 19, 2018 at 3:27 PM, Christian K=F6nig <christian.koenig-urvtwAKJhsc@public.gmane.org=
m<mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>> wrote:

I think that the consensus with Alex and me is that we should avoid exactly=
 that.

Overriding the preferred domain in the kernel is a no-go for that patch set=
, so please implement the discussed changes in Mesa.



I don't see how Mesa can make a smarter decision than the kernel. If you ov=
erwrite the preferred domain of the buffer in the kernel, there will be no =
ping-ponging between domains. Mesa never changes the initial preferred doma=
in.



Marek





Regards,
Christian.


Am 19.03.2018 um 20:22 schrieb Li, Samuel:

I agree with Marek/Michel: since kernel sets the domain before scanning out=
, it shall update the preferred domain here too.

Regards,
Samuel Li



-----Original Message-----
From: Koenig, Christian
Sent: Thursday, March 08, 2018 4:07 AM
To: Michel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org<mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>>; Li, Sa=
muel
<Samuel.Li-5C7GfCeVMHo@public.gmane.org<mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>>; Alex Deucher <alexdeucher@gm=
ail.com<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org>>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support

Am 08.03.2018 um 09:35 schrieb Michel D=E4nzer:

On 2018-03-07 10:47 AM, Christian K=F6nig wrote:

Am 07.03.2018 um 09:42 schrieb Michel D=E4nzer:

On 2018-03-06 07:23 PM, Christian K=F6nig wrote:

E.g. the last time I tested it placing things into GTT still
resulted in quite a performance penalty for rendering.

FWIW, I think the penalty is most likely IOMMU related. Last time I
tested, I couldn't measure a big difference with IOMMU disabled.

No, the penalty I'm talking about came from the ping/pong we did with
the scanout buffers.

See when I tested this the DDX and Mesa where unmodified, so both
still assumed VRAM as placement for scanout BOs, but the kernel
forced scanout BOs into GTT for testing.

So what happened was that on scanout we moved the VRAM BO to GTT

and

after unpinning it on the first command submission which used the BO
we moved it back to VRAM again.

In the meantime, I've had the same idea as Marek: Can't the kernel
driver simply change the BO's preferred domain to GTT when scanning
out from it? Then it won't move back to VRAM.

Yes, I've considered this as well.

But I think making the decision in Mesa is the cleaner approach.

E.g. so far we only override the placement decision of userspace for two
reasons:
1. We where running out of memory in VRAM.
2. We have a hardware restriction which makes VRAM usage mandatory.

And even then we never adjust the placement permanently, we just
temporary moved the buffer where it was needed and moved it back after
the operation completed.

Additional to that Mesa might want to set even more flags and/or changes
it's behavior. E.g. use a tilling mode which both importer and export in an
A+A laptop understands etc...

Regards,
Christian.

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx






_______________________________________________

amd-gfx mailing list

amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--_000_BN6PR12MB18099E7295CB0301EF536924F7D40BN6PR12MB1809namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">My personal preference is still t=
o plumb this through to mesa rather than forcing it in the kernel.<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Li, Samuel &lt;Samuel.Li@amd.=
com&gt;<br>
<b>Sent:</b> Monday, March 19, 2018 3:50:34 PM<br>
<b>To:</b> Koenig, Christian; Marek Ol=9A=E1k<br>
<b>Cc:</b> Alex Deucher; Michel D=E4nzer; amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</font>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:SimSun}
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:Calibri}
@font-face
	{font-family:Consolas}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black}
a:x_link, span.x_MsoHyperlink
	{color:blue;
	text-decoration:underline}
a:x_visited, span.x_MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline}
pre
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black}
span.x_HTMLPreformattedChar
	{font-family:Consolas;
	color:black}
span.x_EmailStyle19
	{font-family:"Calibri",sans-serif;
	color:#2F5496}
span.x_EmailStyle20
	{font-family:"Calibri",sans-serif;
	color:#2F5496}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"background-colo=
r:white">
<div class=3D"x_WordSection1">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">Christian,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">You misunderstood Alex=92s commen=
ts,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">&nbsp;</span></p>
<pre>&gt;Regardless of which scenarios we need to support, I think we also =
need</pre>
<pre>&gt;to really plumb this through to mesa however since user space is w=
ho</pre>
<pre>&gt;ultimately requests the location.&nbsp; Overriding it in the kerne=
l gets</pre>
<pre>&gt;tricky and can lead to ping-ponging as others have noted.&nbsp; Be=
tter to</pre>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">Here Alex mentioned the scenarios=
 is 1)VRAM, 2)GTT, 3)VRAM/GTT.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">His concern is this might cause p=
ing-pong, not about preferred domain. Since preferred domain can solve the =
ping-pong issue, it shall address his concern
 here.</span></p>
<div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">&nbsp;</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">Regards,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">Samuel Li</span></p>
</div>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif; color:windowtext">From:</span></b><span style=
=3D"font-size:11.0pt; font-family:&quot;Calibri&quot;,sans-serif; color:win=
dowtext"> Christian K=F6nig [mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
<br>
<b>Sent:</b> Monday, March 19, 2018 3:45 PM<br>
<b>To:</b> Li, Samuel &lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;; Marek Ol=9A=E1k &lt;maraeo=
@gmail.com&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Michel D=E4nzer &lt;=
michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;; amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<=
br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p class=3D"x_MsoNormal">Quoting Alex:<br>
<br>
</p>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<pre>Regardless of which scenarios we need to support, I think we also need=
</pre>
<pre>to really plumb this through to mesa however since user space is who</=
pre>
<pre>ultimately requests the location.&nbsp; Overriding it in the kernel ge=
ts</pre>
<pre>tricky and can lead to ping-ponging as others have noted.&nbsp; Better=
 to</pre>
<pre>have user space know what chips support it or not and request display<=
/pre>
<pre>buffers in GTT or VRAM from the start.</pre>
</blockquote>
<p class=3D"x_MsoNormal">And I completely agree with Alex here. So overridi=
ng the domain in the kernel is a serious NAK from my side as well.<br>
<br>
Please implement the necessary bits in Mesa, shouldn't be more than a few l=
ines of code anyway.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 19.03.2018 um 20:42 schrieb Li, Samuel:</p>
</div>
<blockquote style=3D"margin-top:5.0pt; margin-bottom:5.0pt">
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">Agreed.</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">&nbsp;</span></p>
<p class=3D"x_MsoNormal">&gt;I think that the consensus with Alex and me is=
 that we should avoid exactly that.<br>
Christian, Alex=92s concern is about ping-pong, not about the preferred dom=
ain. <br>
<br>
<br>
</p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">Regards,</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">Samuel Li</span></p>
<p class=3D"x_MsoNormal"><span style=3D"font-size:11.0pt; font-family:&quot=
;Calibri&quot;,sans-serif; color:#2F5496">&nbsp;</span></p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b><span style=3D"font-size:11.0pt; font-family:&q=
uot;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0=
pt; font-family:&quot;Calibri&quot;,sans-serif"> Marek Ol=9A=E1k [<a href=
=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
<b>Sent:</b> Monday, March 19, 2018 3:39 PM<br>
<b>To:</b> Koenig, Christian <a href=3D"mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&l=
t;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Cc:</b> Li, Samuel <a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org">&lt;Samuel.Li@am=
d.com&gt;</a>; Michel D=E4nzer
<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">&lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;</a>; Alex =
Deucher <a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; amd-gfx list <a href=3D"mailto:amd-gfx@l=
ists.freedesktop.org">
&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span></p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<div>
<p class=3D"x_MsoNormal">On Mon, Mar 19, 2018 at 3:27 PM, Christian K=F6nig=
 &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christia=
n.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:</p>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal">I think that the consensus with Alex and me is tha=
t we should avoid exactly that.<br>
<br>
Overriding the preferred domain in the kernel is a no-go for that patch set=
, so please implement the discussed changes in Mesa.</p>
</blockquote>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">I don't see how Mesa can make a smarter decision t=
han the kernel. If you overwrite the preferred domain of the buffer in the =
kernel, there will be no ping-ponging between domains. Mesa never changes t=
he initial preferred domain.</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">Marek</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal"><br>
Regards,<br>
Christian.</p>
<div>
<div>
<p class=3D"x_MsoNormal"><br>
<br>
Am 19.03.2018 um 20:22 schrieb Li, Samuel:</p>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">I agree with Marek/=
Michel: since kernel sets the domain before scanning out, it shall update t=
he preferred domain here too.<br>
<br>
Regards,<br>
Samuel Li<br>
<br>
<br>
</p>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal">-----Original Message-----<br>
From: Koenig, Christian<br>
Sent: Thursday, March 08, 2018 4:07 AM<br>
To: Michel D=E4nzer &lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=3D"_bl=
ank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;; Li, Samuel<br>
&lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Samuel.Li-urvtwAKJhsc@public.gmane.org=
m</a>&gt;; Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
Cc: amd-gfx list &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" targe=
t=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support<=
br>
<br>
Am 08.03.2018 um 09:35 schrieb Michel D=E4nzer:</p>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal">On 2018-03-07 10:47 AM, Christian K=F6nig wrote:</=
p>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal">Am 07.03.2018 um 09:42 schrieb Michel D=E4nzer:</p=
>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">On 2018-03-06 07:23=
 PM, Christian K=F6nig wrote:</p>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal">E.g. the last time I tested it placing things into=
 GTT still<br>
resulted in quite a performance penalty for rendering.</p>
</blockquote>
<p class=3D"x_MsoNormal">FWIW, I think the penalty is most likely IOMMU rel=
ated. Last time I<br>
tested, I couldn't measure a big difference with IOMMU disabled.</p>
</blockquote>
<p class=3D"x_MsoNormal">No, the penalty I'm talking about came from the pi=
ng/pong we did with<br>
the scanout buffers.<br>
<br>
See when I tested this the DDX and Mesa where unmodified, so both<br>
still assumed VRAM as placement for scanout BOs, but the kernel<br>
forced scanout BOs into GTT for testing.<br>
<br>
So what happened was that on scanout we moved the VRAM BO to GTT</p>
</blockquote>
</blockquote>
<p class=3D"x_MsoNormal">and</p>
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<blockquote style=3D"border:none; border-left:solid #CCCCCC 1.0pt; padding:=
0in 0in 0in 6.0pt; margin-left:4.8pt; margin-top:5.0pt; margin-right:0in; m=
argin-bottom:5.0pt">
<p class=3D"x_MsoNormal">after unpinning it on the first command submission=
 which used the BO<br>
we moved it back to VRAM again.</p>
</blockquote>
<p class=3D"x_MsoNormal">In the meantime, I've had the same idea as Marek: =
Can't the kernel<br>
driver simply change the BO's preferred domain to GTT when scanning<br>
out from it? Then it won't move back to VRAM.</p>
</blockquote>
<p class=3D"x_MsoNormal">Yes, I've considered this as well.<br>
<br>
But I think making the decision in Mesa is the cleaner approach.<br>
<br>
E.g. so far we only override the placement decision of userspace for two<br=
>
reasons:<br>
1. We where running out of memory in VRAM.<br>
2. We have a hardware restriction which makes VRAM usage mandatory.<br>
<br>
And even then we never adjust the placement permanently, we just<br>
temporary moved the buffer where it was needed and moved it back after<br>
the operation completed.<br>
<br>
Additional to that Mesa might want to set even more flags and/or changes<br=
>
it's behavior. E.g. use a tilling mode which both importer and export in an=
<br>
A&#43;A laptop understands etc...<br>
<br>
Regards,<br>
Christian.</p>
</blockquote>
</blockquote>
<p class=3D"x_MsoNormal"><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></p>
</div>
</div>
</blockquote>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
</div>
<p class=3D"x_MsoNormal"><br>
<br>
<br>
</p>
<pre>_______________________________________________</pre>
<pre>amd-gfx mailing list</pre>
<pre><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org</a></pre>
<pre><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
</blockquote>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18099E7295CB0301EF536924F7D40BN6PR12MB1809namp_--

--===============1061247716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1061247716==--
