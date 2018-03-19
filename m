From: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Mon, 19 Mar 2018 19:58:52 +0000
Message-ID: <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
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
 <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1113975179=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18099E7295CB0301EF536924F7D40-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, =?iso-8859-2?Q?Marek_Ol=B9=E1k?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?iso-8859-2?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1113975179==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY1PR12MB05042F8034B375BAB507EB03F5D40BY1PR12MB0504namp_"

--_000_BY1PR12MB05042F8034B375BAB507EB03F5D40BY1PR12MB0504namp_
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Alex,

I assume you are talking the three scenarios here, 1)VRAM, 2)GTT, 3)VRAM/GT=
T.
But kernel will need the decision too(amdgpufb). I think it shall be better=
 to do it in kernel, instead of different clients(mesa, ddx, kernel ...)

Regards,
Samuel Li

From: Deucher, Alexander
Sent: Monday, March 19, 2018 3:54 PM
To: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig@amd=
.com>; Marek Ol=B9=E1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Michel D=E4nzer <michel@daenzer.n=
et>; amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support


My personal preference is still to plumb this through to mesa rather than f=
orcing it in the kernel.



Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org<mailto:=
Samuel.Li-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, March 19, 2018 3:50:34 PM
To: Koenig, Christian; Marek Ol=B9=E1k
Cc: Alex Deucher; Michel D=E4nzer; amd-gfx list
Subject: RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support


Christian,



You misunderstood Alex's comments,



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
To: Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org<mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>>; Marek Ol=B9=
=E1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; Koenig, Christian <Christ=
ian.Koenig-5C7GfCeVMHo@public.gmane.org<mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org>>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; Mic=
hel D=E4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org<mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>>; amd-gfx list =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
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
Christian, Alex's concern is about ping-pong, not about the preferred domai=
n.


Regards,

Samuel Li



From: Marek Ol=B9=E1k [mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
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



--_000_BY1PR12MB05042F8034B375BAB507EB03F5D40BY1PR12MB0504namp_
Content-Type: text/html; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
2">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	color:black;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;
	color:black;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Times New Roman",serif;}
span.xhtmlpreformattedchar
	{mso-style-name:x_htmlpreformattedchar;
	font-family:Consolas;
	color:black;}
span.xemailstyle19
	{mso-style-name:x_emailstyle19;
	font-family:"Calibri",sans-serif;
	color:#2F5496;}
span.xemailstyle20
	{mso-style-name:x_emailstyle20;
	font-family:"Calibri",sans-serif;
	color:#2F5496;}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#2F5496;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496">Alex,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496">I assume you are talking the three sc=
enarios here,
</span><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans=
-serif;color:#2F5496">1)VRAM, 2)GTT, 3)VRAM/GTT.</span><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496">But kernel will need the decision too=
(amdgpufb). I think it shall be better to do it in kernel, instead of diffe=
rent clients(mesa, ddx, kernel &#8230;)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496">Samuel Li<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#2F5496"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Deucher, Alexander
<br>
<b>Sent:</b> Monday, March 19, 2018 3:54 PM<br>
<b>To:</b> Li, Samuel &lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Chri=
stian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Marek Ol=B9=E1k &lt;maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Cc:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Michel D=E4nzer &lt;=
michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;; amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<=
br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">M=
y personal preference is still to plumb this through to mesa rather than fo=
rcing it in the kernel.<o:p></o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black"><=
o:p>&nbsp;</o:p></span></p>
<p><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">A=
lex<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> amd-gf=
x &lt;<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-boun=
ces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
 on behalf of Li, Samuel &lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org">Samuel.Li=
@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, March 19, 2018 3:50:34 PM<br>
<b>To:</b> Koenig, Christian; Marek Ol=B9=E1k<br>
<b>Cc:</b> Alex Deucher; Michel D=E4nzer; amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Christian=
,</span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">&nbsp;</s=
pan><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">You misun=
derstood Alex&#8217;s comments,</span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">&nbsp;</s=
pan><o:p></o:p></p>
<pre style=3D"background:white">&gt;Regardless of which scenarios we need t=
o support, I think we also need<o:p></o:p></pre>
<pre style=3D"background:white">&gt;to really plumb this through to mesa ho=
wever since user space is who<o:p></o:p></pre>
<pre style=3D"background:white">&gt;ultimately requests the location.&nbsp;=
 Overriding it in the kernel gets<o:p></o:p></pre>
<pre style=3D"background:white">&gt;tricky and can lead to ping-ponging as =
others have noted.&nbsp; Better to<o:p></o:p></pre>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">&nbsp;</s=
pan><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Here Alex=
 mentioned the scenarios is 1)VRAM, 2)GTT, 3)VRAM/GTT.</span><o:p></o:p></p=
>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">His conce=
rn is this might cause ping-pong, not about preferred domain. Since preferr=
ed domain can solve the ping-pong issue, it shall
 address his concern here.</span><o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">&nbsp;</s=
pan><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Regards,<=
/span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Samuel Li=
</span><o:p></o:p></p>
</div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">&nbsp;</s=
pan><o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:windowtext">Fro=
m:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot=
;,sans-serif;color:windowtext"> Christian K=F6nig [<a href=3D"mailto:ckoeni=
g.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
<b>Sent:</b> Monday, March 19, 2018 3:45 PM<br>
<b>To:</b> Li, Samuel &lt;<a href=3D"mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org">Samuel.Li@am=
d.com</a>&gt;; Marek Ol=B9=E1k &lt;<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mara=
eo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;; Koenig, Christian &lt;<a href=3D"mailto:Christian.Koe=
nig-5C7GfCeVMHo@public.gmane.org">Christian.Koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexde=
ucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;; Michel D=E4nzer &lt;<a href=3D"mailto:michel@daenz=
er.net">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;; amd-gfx list &lt;<a href=3D"mailto:amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display s=
upport</span><o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt;background:white">Quo=
ting Alex:<o:p></o:p></p>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<pre style=3D"background:white">Regardless of which scenarios we need to su=
pport, I think we also need<o:p></o:p></pre>
<pre style=3D"background:white">to really plumb this through to mesa howeve=
r since user space is who<o:p></o:p></pre>
<pre style=3D"background:white">ultimately requests the location.&nbsp; Ove=
rriding it in the kernel gets<o:p></o:p></pre>
<pre style=3D"background:white">tricky and can lead to ping-ponging as othe=
rs have noted.&nbsp; Better to<o:p></o:p></pre>
<pre style=3D"background:white">have user space know what chips support it =
or not and request display<o:p></o:p></pre>
<pre style=3D"background:white">buffers in GTT or VRAM from the start.<o:p>=
</o:p></pre>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">And I completely agree w=
ith Alex here. So overriding the domain in the kernel is a serious NAK from=
 my side as well.<br>
<br>
Please implement the necessary bits in Mesa, shouldn't be more than a few l=
ines of code anyway.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 19.03.2018 um 20:42 schrieb Li, Samuel:<o:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Agreed.</=
span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">&nbsp;</s=
pan><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt;background:white">&gt=
;I think that the consensus with Alex and me is that we should avoid exactl=
y that.<br>
Christian, Alex&#8217;s concern is about ping-pong, not about the preferred=
 domain. <br>
<br>
<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Regards,<=
/span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Samuel Li=
</span><o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"font-size=
:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">&nbsp;</s=
pan><o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal" style=3D"background:white"><b><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><spa=
n style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif"> Ma=
rek Ol=B9=E1k [<a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<=
/a>]
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
upport</span><o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
<div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">On Mon, Mar 19, 2018 at =
3:27 PM, Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org" =
target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">I think that the consens=
us with Alex and me is that we should avoid exactly that.<br>
<br>
Overriding the preferred domain in the kernel is a no-go for that patch set=
, so please implement the discussed changes in Mesa.<o:p></o:p></p>
</blockquote>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">I don't see how Mesa can=
 make a smarter decision than the kernel. If you overwrite the preferred do=
main of the buffer in the kernel, there will be no ping-ponging between dom=
ains. Mesa never changes the initial
 preferred domain.<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">Marek<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white"><br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><br>
<br>
Am 19.03.2018 um 20:22 schrieb Li, Samuel:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt;background:white">I a=
gree with Marek/Michel: since kernel sets the domain before scanning out, i=
t shall update the preferred domain here too.<br>
<br>
Regards,<br>
Samuel Li<br>
<br>
<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">-----Original Message---=
--<br>
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
Am 08.03.2018 um 09:35 schrieb Michel D=E4nzer:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">On 2018-03-07 10:47 AM, =
Christian K=F6nig wrote:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">Am 07.03.2018 um 09:42 s=
chrieb Michel D=E4nzer:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt;background:white">On =
2018-03-06 07:23 PM, Christian K=F6nig wrote:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">E.g. the last time I tes=
ted it placing things into GTT still<br>
resulted in quite a performance penalty for rendering.<o:p></o:p></p>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">FWIW, I think the penalt=
y is most likely IOMMU related. Last time I<br>
tested, I couldn't measure a big difference with IOMMU disabled.<o:p></o:p>=
</p>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">No, the penalty I'm talk=
ing about came from the ping/pong we did with<br>
the scanout buffers.<br>
<br>
See when I tested this the DDX and Mesa where unmodified, so both<br>
still assumed VRAM as placement for scanout BOs, but the kernel<br>
forced scanout BOs into GTT for testing.<br>
<br>
So what happened was that on scanout we moved the VRAM BO to GTT<o:p></o:p>=
</p>
</blockquote>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">and<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<p class=3D"xmsonormal" style=3D"background:white">after unpinning it on th=
e first command submission which used the BO<br>
we moved it back to VRAM again.<o:p></o:p></p>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">In the meantime, I've ha=
d the same idea as Marek: Can't the kernel<br>
driver simply change the BO's preferred domain to GTT when scanning<br>
out from it? Then it won't move back to VRAM.<o:p></o:p></p>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">Yes, I've considered thi=
s as well.<br>
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
Christian.<o:p></o:p></p>
</blockquote>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white"><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p>=
</o:p></p>
</div>
</div>
</blockquote>
</div>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt;background:white"><br=
>
<br>
<o:p></o:p></p>
<pre style=3D"background:white">___________________________________________=
____<o:p></o:p></pre>
<pre style=3D"background:white">amd-gfx mailing list<o:p></o:p></pre>
<pre style=3D"background:white"><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><o:p></o:p></pre>
<pre style=3D"background:white"><a href=3D"https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx</a><o:p></o:p></pre>
</blockquote>
<p class=3D"xmsonormal" style=3D"background:white">&nbsp;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BY1PR12MB05042F8034B375BAB507EB03F5D40BY1PR12MB0504namp_--

--===============1113975179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1113975179==--
