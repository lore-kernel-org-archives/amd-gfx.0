From: Ben Crocker <bcrocker@redhat.com>
Subject: Re: [PATCH] drm/radeon: insist on 32-bit DMA for Cedar on
 PPC64/PPC64LE
Date: Thu, 22 Feb 2018 12:37:45 -0500
Message-ID: <CALk+eRew=1nHZXRtXR430eFStOiQFUDgrp8VfsBAfcp8W9qAOA@mail.gmail.com>
References: <20180221234154.6877-1-bcrocker@redhat.com>
 <20180222215713.4052-1-bcrocker@redhat.com>
 <92431e86-a247-b7d3-6a45-10d23acb2ae7@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2023382374=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <92431e86-a247-b7d3-6a45-10d23acb2ae7@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============2023382374==
Content-Type: multipart/alternative; boundary="f403045f14e8d2c5b60565d0827f"

--f403045f14e8d2c5b60565d0827f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One of my colleagues did discover a "Radeon HG 5450 PCI" from February
2010 which did, apparently, have a Cedar GPU and very definitely had a
(plain old) PCI connector.

But I take your point, and will just drop the PCI/PCIE check.


On Thu, Feb 22, 2018 at 12:04 PM, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:

> On 2018-02-22 10:57 PM, Ben Crocker wrote:
> > In radeon_device_init, set the need_dma32 flag for Cedar chips
> > (e.g. FirePro 2270).  This fixes, or at least works around, a bug
> > on PowerPC exposed by last year's commits
> >
> > 8e3f1b1d8255105f31556aacf8aeb6071b00d469 (Russell Currey)
> >
> > and
> >
> > 253fd51e2f533552ae35a0c661705da6c4842c1b (Alistair Popple)
> >
> > which enabled the 64-bit DMA iommu bypass.
> >
> > This caused the device to freeze, in some cases unrecoverably, and is
> > the subject of several bug reports internal to Red Hat.
> >
> > Signed-off-by: Ben Crocker <bcrocker@redhat.com>
> > ---
> >  drivers/gpu/drm/radeon/radeon_device.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c
> b/drivers/gpu/drm/radeon/radeon_device.c
> > index ffc10cadcf34..ba7435bcd208 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -1397,6 +1397,11 @@ int radeon_device_init(struct radeon_device *rde=
v,
> >       if ((rdev->flags & RADEON_IS_PCI) &&
> >           (rdev->family <=3D CHIP_RS740))
> >               rdev->need_dma32 =3D true;
> > +#ifdef CONFIG_PPC64
> > +     if ((rdev->flags & (RADEON_IS_PCI | RADEON_IS_PCIE)) &&
>
> Cedar is (like all Radeons from the last decade) always PCIe, so this
> flags check is redundant FWIW.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--f403045f14e8d2c5b60565d0827f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">One of my colleagues did discover a &quot;Radeon HG 5450 P=
CI&quot; from February<br>2010 which did, apparently, have a Cedar GPU and =
very definitely had a<br>(plain old) PCI connector.<br><br>But I take your =
point, and will just drop the PCI/PCIE check.<br><br></div><div class=3D"gm=
ail_extra"><br><div class=3D"gmail_quote">On Thu, Feb 22, 2018 at 12:04 PM,=
 Michel D=C3=A4nzer <span dir=3D"ltr">&lt;<a href=3D"mailto:michel@daenzer.=
net" target=3D"_blank">michel@daenzer.net</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span class=3D"">On 2018-02-22 10:57 PM, Ben Crocker=
 wrote:<br>
&gt; In radeon_device_init, set the need_dma32 flag for Cedar chips<br>
&gt; (e.g. FirePro 2270).=C2=A0 This fixes, or at least works around, a bug=
<br>
&gt; on PowerPC exposed by last year&#39;s commits<br>
&gt;<br>
&gt; 8e3f1b1d8255105f31556aacf8aeb6<wbr>071b00d469 (Russell Currey)<br>
&gt;<br>
&gt; and<br>
&gt;<br>
&gt; 253fd51e2f533552ae35a0c661705d<wbr>a6c4842c1b (Alistair Popple)<br>
&gt;<br>
&gt; which enabled the 64-bit DMA iommu bypass.<br>
&gt;<br>
&gt; This caused the device to freeze, in some cases unrecoverably, and is<=
br>
&gt; the subject of several bug reports internal to Red Hat.<br>
&gt;<br>
&gt; Signed-off-by: Ben Crocker &lt;<a href=3D"mailto:bcrocker@redhat.com">=
bcrocker@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/radeon/radeon_<wbr>device.c | 5 +++++<br>
&gt;=C2=A0 1 file changed, 5 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/radeon/<wbr>radeon_device.c b/drivers/gpu=
/drm/radeon/<wbr>radeon_device.c<br>
&gt; index ffc10cadcf34..ba7435bcd208 100644<br>
&gt; --- a/drivers/gpu/drm/radeon/<wbr>radeon_device.c<br>
&gt; +++ b/drivers/gpu/drm/radeon/<wbr>radeon_device.c<br>
&gt; @@ -1397,6 +1397,11 @@ int radeon_device_init(struct radeon_device *rd=
ev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((rdev-&gt;flags &amp; RADEON_IS_PCI) &am=
p;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;family &lt;=3D CHIP_=
RS740))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdev-&gt;need_dm=
a32 =3D true;<br>
&gt; +#ifdef CONFIG_PPC64<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if ((rdev-&gt;flags &amp; (RADEON_IS_PCI | RADEON=
_IS_PCIE)) &amp;&amp;<br>
<br>
</span>Cedar is (like all Radeons from the last decade) always PCIe, so thi=
s<br>
flags check is redundant FWIW.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5">_____________________=
_________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</div></div></blockquote></div><br></div>

--f403045f14e8d2c5b60565d0827f--

--===============2023382374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============2023382374==--
