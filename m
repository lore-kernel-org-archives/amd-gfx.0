From: Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: insist on 32-bit DMA for Cedar on
 PPC64/PPC64LE
Date: Thu, 22 Feb 2018 20:39:51 -0500
Message-ID: <CALk+eRd++sLpZw6Re6qa79H6kTp=xtF-EMVUu_5sW4wpT_kM_g@mail.gmail.com>
References: <20180221234154.6877-1-bcrocker@redhat.com>
 <20180222215713.4052-1-bcrocker@redhat.com>
 <92431e86-a247-b7d3-6a45-10d23acb2ae7@daenzer.net>
 <CALk+eRew=1nHZXRtXR430eFStOiQFUDgrp8VfsBAfcp8W9qAOA@mail.gmail.com>
 <1bcf5b27-aa25-deb6-85e9-161dd038276b@daenzer.net>
 <CALk+eRc+EOry_G6Ovy0Z-pvE7jQWy5gSx+1kpHA4q3A0oEZs1w@mail.gmail.com>
 <CALk+eReghDHuv23-62pD0PbdBt6p+g_XeE+_c2gRdkoaOQh+CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1686605141=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CALk+eReghDHuv23-62pD0PbdBt6p+g_XeE+_c2gRdkoaOQh+CQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--===============1686605141==
Content-Type: multipart/alternative; boundary="001a114b32b6f9a5800565d73ecc"

--001a114b32b6f9a5800565d73ecc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's what IBM is most interested in at this juncture:
FirePro 2270
Embedded Radeon E6465

The E6465 already worked without this patch.


On Thu, Feb 22, 2018 at 6:39 PM, Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Alex asked what other GPUs I've tested on, and the answer is: E6465
> (Caicos GPU).
>
> -- Ben
>
>
> On Thu, Feb 22, 2018 at 1:33 PM, Ben Crocker <bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
>> I think that last version I sent a few minutes ago is final form, now.
>> Thanks for all your help!
>>
>> If there's anything you could do to expedite posting this patch to the
>> main repo, that would be GREATLY appreciated!
>>
>> -- Thanks,
>>   Ben
>>
>>
>> On Thu, Feb 22, 2018 at 12:56 PM, Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org=
>
>> wrote:
>>
>>> On 2018-02-22 06:37 PM, Ben Crocker wrote:
>>> > One of my colleagues did discover a "Radeon HG 5450 PCI" from Februar=
y
>>> > 2010 which did, apparently, have a Cedar GPU and very definitely had =
a
>>> > (plain old) PCI connector.
>>>
>>> There must be a PCIe-to-PCI bridge on that board. The GPU itself is
>>> always PCIe, and treated accordingly by the driver.
>>>
>>>
>>> --
>>> Earthling Michel D=C3=A4nzer               |               http://www.a=
md.com
>>> Libre software enthusiast             |             Mesa and X develope=
r
>>>
>>
>>
>

--001a114b32b6f9a5800565d73ecc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>That&#39;s what IBM is most interested in a=
t this juncture:<br></div>FirePro 2270<br></div>Embedded Radeon E6465<br></=
div><div><br></div><div>The E6465 already worked without this patch.</div><=
div><br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On Thu, Feb 22, 2018 at 6:39 PM, Ben Crocker <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>=
Alex asked what other GPUs I&#39;ve tested on, and the answer is: E6465 (Ca=
icos GPU).<span class=3D"HOEnZb"><font color=3D"#888888"><br><br></font></s=
pan></div><span class=3D"HOEnZb"><font color=3D"#888888">-- Ben<br><br></fo=
nt></span></div><div class=3D"HOEnZb"><div class=3D"h5"><div class=3D"gmail=
_extra"><br><div class=3D"gmail_quote">On Thu, Feb 22, 2018 at 1:33 PM, Ben=
 Crocker <span dir=3D"ltr">&lt;<a href=3D"mailto:bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" targe=
t=3D"_blank">bcrocker-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr"><div><div><div>I think that last version I s=
ent a few minutes ago is final form, now.=C2=A0 Thanks for all your help!<b=
r><br></div>If there&#39;s anything you could do to expedite posting this p=
atch to the main repo, that would be GREATLY appreciated!<br><br></div>-- T=
hanks,<br></div>=C2=A0 Ben<br><br></div><div class=3D"m_810405677014088652H=
OEnZb"><div class=3D"m_810405677014088652h5"><div class=3D"gmail_extra"><br=
><div class=3D"gmail_quote">On Thu, Feb 22, 2018 at 12:56 PM, Michel D=C3=
=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org" target=
=3D"_blank">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span>On 2018-02-22 06:37 PM, Ben Crocker wrote:<br>
&gt; One of my colleagues did discover a &quot;Radeon HG 5450 PCI&quot; fro=
m February<br>
&gt; 2010 which did, apparently, have a Cedar GPU and very definitely had a=
<br>
&gt; (plain old) PCI connector.<br>
<br>
</span>There must be a PCIe-to-PCI bridge on that board. The GPU itself is<=
br>
always PCIe, and treated accordingly by the driver.<br>
<div class=3D"m_810405677014088652m_3885243703296060686HOEnZb"><div class=
=3D"m_810405677014088652m_3885243703296060686h5"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--001a114b32b6f9a5800565d73ecc--

--===============1686605141==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1686605141==--
