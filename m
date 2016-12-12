From: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU
Date: Mon, 12 Dec 2016 07:54:54 +0000
Message-ID: <BN6PR12MB13484DA35697DBD0CA815CFFE8980@BN6PR12MB1348.namprd12.prod.outlook.com>
References: <55d5e664-25f7-70e0-f2f5-9c9daf3efdf6@amd.com>,
 <20161212072243.ah6sy3q57z4gimka@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2077406931=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161212072243.ah6sy3q57z4gimka-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
Content-Language: en-CA
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "Cheng, Tony" <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2077406931==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB13484DA35697DBD0CA815CFFE8980BN6PR12MB1348namp_"

--_000_BN6PR12MB13484DA35697DBD0CA815CFFE8980BN6PR12MB1348namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yep, good point. We have tended to stay a bit behind bleeding edge because =
our primary tasks so far have been:


1. Support enterprise distros (with old kernels) via the hybrid driver (AMD=
GPU-PRO), where the closer to upstream we get the more of a gap we have to =
paper over with KCL code


2. Push architecturally simple code (new GPU support) upstream, where being=
 closer to upstream makes the up-streaming task simpler but not by that muc=
h


So 4.7 isn't as bad a compromise as it might seem.


That said, in the case of DAL/DC it's a different story as you say... archi=
tecturally complex code needing to be woven into a fast-moving subsystem of=
 the kernel. So for DAL/DC anything other than upstream is going to be a bi=
g pain.


OK, need to think that through.


Thanks !

________________________________
From: dri-devel <dri-devel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Dani=
el Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Sent: December 12, 2016 2:22 AM
To: Wentland, Harry
Cc: Grodzovsky, Andrey; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org; Deucher, Alexander; Cheng, Tony
Subject: Re: [RFC] Using DC in amdgpu for upcoming GPU

On Wed, Dec 07, 2016 at 09:02:13PM -0500, Harry Wentland wrote:
> Current version of DC:
>
>  * https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/dis=
play?h=3Damd-staging-4.7
>
> Once Alex pulls in the latest patches:
>
>  * https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/dis=
play?h=3Damd-staging-4.7

One more: That 4.7 here is going to be unbelievable amounts of pain for
you. Yes it's a totally sensible idea to just freeze your baseline kernel
because then linux looks a lot more like Windows where the driver abi is
frozen. But it makes following upstream entirely impossible, because
rebasing is always a pain and hence postponed. Which means you can't just
use the latest stuff in upstream drm, which means collaboration with
others and sharing bugfixes in core is a lot more pain, which then means
you do more than necessary in your own code and results in HALs like DAL,
perpetuating the entire mess.

So I think you don't just need to demidlayer DAL/DC, you also need to
demidlayer your development process. In our experience here at Intel that
needs continuous integration testing (in drm-tip), because even 1 month of
not resyncing with drm-next is sometimes way too long. See e.g. the
controlD regression we just had. And DAL is stuck on a 1 year old kernel,
so pretty much only of historical significance and otherwise dead code.

And then for any stuff which isn't upstream yet (like your internal
enabling, or DAL here, or our own internal enabling) you need continuous
rebasing&re-validation. When we started doing this years ago it was still
manually, but we still rebased like every few days to keep the pain down
and adjust continuously to upstream evolution. But then going to a
continous rebase bot that sends you mail when something goes wrong was
again a massive improvement.

I guess in the end Conway's law that your software architecture
necessarily reflects how you organize your teams applies again. Fix your
process and it'll become glaringly obvious to everyone involved that
DC-the-design as-is is entirely unworkeable and how it needs to be fixed.

>From my own experience over the past few years: Doing that is a fun
journey ;-)

Cheers, Daniel
--
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
dri-devel mailing list
dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/dri-devel

--_000_BN6PR12MB13484DA35697DBD0CA815CFFE8980BN6PR12MB1348namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Yep, good point. We have tended to stay a bit behind bleeding edge becau=
se our primary tasks so far have been:</p>
<p><br>
</p>
<p>1. Support enterprise distros (with old kernels) via the hybrid&nbsp;<sp=
an>driver</span> (AMDGPU-PRO), where the closer to upstream we get the more=
 of a gap we have to paper over with KCL code</p>
<p><br>
</p>
<p>2. Push architecturally simple code (new GPU support) upstream, where be=
ing closer to upstream makes the up-streaming task simpler but not by that =
much</p>
<p><br>
</p>
<p>So 4.7 isn't as bad a compromise as it might seem.<br>
</p>
<p><br>
</p>
<p>That said, in the case of DAL/DC it's a different story as you say... ar=
chitecturally complex code needing to be woven into a fast-moving subsystem=
 of the kernel. So for DAL/DC anything other than upstream is going to be a=
 big pain.
<br>
</p>
<p><br>
</p>
<p>OK, need to think that through.&nbsp;</p>
<p><br>
</p>
<p>Thanks !<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" colo=
r=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> dri-devel &lt;dri-d=
evel-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Daniel Vetter &lt;danie=
l@ffwll.ch&gt;<br>
<b>Sent:</b> December 12, 2016 2:22 AM<br>
<b>To:</b> Wentland, Harry<br>
<b>Cc:</b> Grodzovsky, Andrey; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel@lis=
ts.freedesktop.org; Deucher, Alexander; Cheng, Tony<br>
<b>Subject:</b> Re: [RFC] Using DC in amdgpu for upcoming GPU</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Wed, Dec 07, 2016 at 09:02:13PM -0500, Harry We=
ntland wrote:<br>
&gt; Current version of DC:<br>
&gt; <br>
&gt;&nbsp; * <a href=3D"https://cgit.freedesktop.org/~agd5f/linux/tree/driv=
ers/gpu/drm/amd/display?h=3Damd-staging-4.7">
https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/display?=
h=3Damd-staging-4.7</a><br>
&gt; <br>
&gt; Once Alex pulls in the latest patches:<br>
&gt; <br>
&gt;&nbsp; * <a href=3D"https://cgit.freedesktop.org/~agd5f/linux/tree/driv=
ers/gpu/drm/amd/display?h=3Damd-staging-4.7">
https://cgit.freedesktop.org/~agd5f/linux/tree/drivers/gpu/drm/amd/display?=
h=3Damd-staging-4.7</a><br>
<br>
One more: That 4.7 here is going to be unbelievable amounts of pain for<br>
you. Yes it's a totally sensible idea to just freeze your baseline kernel<b=
r>
because then linux looks a lot more like Windows where the driver abi is<br=
>
frozen. But it makes following upstream entirely impossible, because<br>
rebasing is always a pain and hence postponed. Which means you can't just<b=
r>
use the latest stuff in upstream drm, which means collaboration with<br>
others and sharing bugfixes in core is a lot more pain, which then means<br=
>
you do more than necessary in your own code and results in HALs like DAL,<b=
r>
perpetuating the entire mess.<br>
<br>
So I think you don't just need to demidlayer DAL/DC, you also need to<br>
demidlayer your development process. In our experience here at Intel that<b=
r>
needs continuous integration testing (in drm-tip), because even 1 month of<=
br>
not resyncing with drm-next is sometimes way too long. See e.g. the<br>
controlD regression we just had. And DAL is stuck on a 1 year old kernel,<b=
r>
so pretty much only of historical significance and otherwise dead code.<br>
<br>
And then for any stuff which isn't upstream yet (like your internal<br>
enabling, or DAL here, or our own internal enabling) you need continuous<br=
>
rebasing&amp;re-validation. When we started doing this years ago it was sti=
ll<br>
manually, but we still rebased like every few days to keep the pain down<br=
>
and adjust continuously to upstream evolution. But then going to a<br>
continous rebase bot that sends you mail when something goes wrong was<br>
again a massive improvement.<br>
<br>
I guess in the end Conway's law that your software architecture<br>
necessarily reflects how you organize your teams applies again. Fix your<br=
>
process and it'll become glaringly obvious to everyone involved that<br>
DC-the-design as-is is entirely unworkeable and how it needs to be fixed.<b=
r>
<br>
>From my own experience over the past few years: Doing that is a fun<br>
journey ;-)<br>
<br>
Cheers, Daniel<br>
-- <br>
Daniel Vetter<br>
Software Engineer, Intel Corporation<br>
<a href=3D"http://blog.ffwll.ch">http://blog.ffwll.ch</a><br>
_______________________________________________<br>
dri-devel mailing list<br>
dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel">https:=
//lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB13484DA35697DBD0CA815CFFE8980BN6PR12MB1348namp_--

--===============2077406931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2077406931==--
