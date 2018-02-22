From: Ben Crocker <bcrocker@redhat.com>
Subject: Re: [PATCH] drm/radeon: insist on 32-bit DMA for Cedar
Date: Thu, 22 Feb 2018 11:45:39 -0500
Message-ID: <CALk+eRd-aJ--2cau1q9M5F7k013hDMeayzLXhkwEEi-Vzwmw+A@mail.gmail.com>
References: <20180221234154.6877-1-bcrocker@redhat.com>
 <CADnq5_M8ZiV2b+LW5oKu0XSQOJvg9idvZ6eBOaHMJRPC2iMj3w@mail.gmail.com>
 <7d6a06dc-9e88-2427-ec6a-4f48b9aa8f6b@gmail.com>
 <CALk+eRcPH+g-eBMKWyO4FrPwuc_VLnp_w89WYKNE51=iV5Y=wg@mail.gmail.com>
 <CADnq5_N8Qp6JCRxGQk6NF5T3CD+jGtwox7K=qO1cLwp3C++jHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1647635447=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CADnq5_N8Qp6JCRxGQk6NF5T3CD+jGtwox7K=qO1cLwp3C++jHg@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Christian Koenig <christian.koenig@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--===============1647635447==
Content-Type: multipart/alternative; boundary="001a114b32b67b0a050565cfc842"

--001a114b32b67b0a050565cfc842
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I considered that, but I'm only equipped to test on a few cards--the ones
IBM is interested in.
So this Cedar-specific change fixes the problem on the FirePro 2270; the
other cards seem
perfectly capable of handling 40+ bit DMA addresses on the Power8 platform.


On Thu, Feb 22, 2018 at 11:07 AM, Alex Deucher <alexdeucher@gmail.com>
wrote:

> On Thu, Feb 22, 2018 at 10:55 AM, Ben Crocker <bcrocker@redhat.com> wrote=
:
> > Alex, Christian, et al.
> >
> > Thanks for your rapid response!
> >
> > I can certainly make the change PPC-only (#ifdef CONFIG_PPC64...) and I
> > think
> > that's the safest way to go right now.  It makes the patch very specifi=
c
> to
> > Cedar
> > on PowerPC64, so it doesn't break anything that may have come to depend
> on
> > Russell's and Alistair's changes, and my timetable for getting a fix in
> is
> > very short.
>
> If you want to go this route, you might just set need_dma32
> unconditionally for PPC64.  The bus interface hw is pretty much the
> same across all asics in this time period.
>
> Alex
>
>
> >
> > -- Ben
> >
> >
> >
> > On Thu, Feb 22, 2018 at 2:25 AM, Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >>
> >> Am 22.02.2018 um 03:05 schrieb Alex Deucher:
> >>>
> >>> On Wed, Feb 21, 2018 at 6:41 PM, Ben Crocker <bcrocker@redhat.com>
> wrote:
> >>>>
> >>>> In radeon_device_init, set the need_dma32 flag for Cedar chips
> >>>> (e.g. FirePro 2270).  This fixes, or at least works around, a bug
> >>>> on PowerPC exposed by last year's commits
> >>>>
> >>>> 8e3f1b1d8255105f31556aacf8aeb6071b00d469 (Russell Currey)
> >>>>
> >>>> and
> >>>>
> >>>> 253fd51e2f533552ae35a0c661705da6c4842c1b (Alistair Popple)
> >>>>
> >>>> which enabled the 64-bit DMA iommu bypass.
> >>>>
> >>>> This caused the device to freeze, in some cases unrecoverably, and i=
s
> >>>> the subject of several bug reports internal to Red Hat.
> >>>
> >>> Can we make this ppc only?  40 bit DMA works fine on x86.
> >>
> >>
> >> Yeah and at least when the dma_coherent allocator path is used it shou=
ld
> >> work fine on PPC as well.
> >>
> >> So that is not really a driver bug, but a platform bug and we should
> think
> >> about reverting or at least disabling those two patches instead.
> >>
> >> Christian.
> >>
> >>>
> >>> Alex
> >>>
> >>>> Signed-off-by: Ben Crocker <bcrocker@redhat.com>
> >>>> ---
> >>>>   drivers/gpu/drm/radeon/radeon_device.c | 5 ++++-
> >>>>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/radeon/radeon_device.c
> >>>> b/drivers/gpu/drm/radeon/radeon_device.c
> >>>> index ffc10cadcf34..02538903830d 100644
> >>>> --- a/drivers/gpu/drm/radeon/radeon_device.c
> >>>> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> >>>> @@ -1395,7 +1395,10 @@ int radeon_device_init(struct radeon_device
> >>>> *rdev,
> >>>>          if (rdev->flags & RADEON_IS_AGP)
> >>>>                  rdev->need_dma32 =3D true;
> >>>>          if ((rdev->flags & RADEON_IS_PCI) &&
> >>>> -           (rdev->family <=3D CHIP_RS740))
> >>>> +           (rdev->family <=3D CHIP_RS740 || rdev->family =3D=3D
> CHIP_CEDAR))
> >>>> +               rdev->need_dma32 =3D true;
> >>>> +       if ((rdev->flags & RADEON_IS_PCIE) &&
> >>>> +           (rdev->family =3D=3D CHIP_CEDAR))
> >>>>                  rdev->need_dma32 =3D true;
> >>>>
> >>>>          dma_bits =3D rdev->need_dma32 ? 32 : 40;
> >>>> --
> >>>> 2.13.6
> >>>>
> >>>> _______________________________________________
> >>>> dri-devel mailing list
> >>>> dri-devel@lists.freedesktop.org
> >>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx@lists.freedesktop.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>
> >>
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--001a114b32b67b0a050565cfc842
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>I considered that, but I&#39;m only equipped to =
test on a few cards--the ones IBM is interested in.<br></div>So this Cedar-=
specific change fixes the problem on the FirePro 2270; the other cards seem=
</div><div>perfectly capable of handling 40+ bit DMA addresses on the Power=
8 platform.</div><div><br></div></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Thu, Feb 22, 2018 at 11:07 AM, Alex Deucher <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:alexdeucher@gmail.com" target=3D"_blank">a=
lexdeucher@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><span class=3D"">On Thu, Feb 22, 2018 at 10:55 AM, Ben Crocker &lt;<a hre=
f=3D"mailto:bcrocker@redhat.com">bcrocker@redhat.com</a>&gt; wrote:<br>
&gt; Alex, Christian, et al.<br>
&gt;<br>
&gt; Thanks for your rapid response!<br>
&gt;<br>
&gt; I can certainly make the change PPC-only (#ifdef CONFIG_PPC64...) and =
I<br>
&gt; think<br>
&gt; that&#39;s the safest way to go right now.=C2=A0 It makes the patch ve=
ry specific to<br>
&gt; Cedar<br>
&gt; on PowerPC64, so it doesn&#39;t break anything that may have come to d=
epend on<br>
&gt; Russell&#39;s and Alistair&#39;s changes, and my timetable for getting=
 a fix in is<br>
&gt; very short.<br>
<br>
</span>If you want to go this route, you might just set need_dma32<br>
unconditionally for PPC64.=C2=A0 The bus interface hw is pretty much the<br=
>
same across all asics in this time period.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Alex<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
&gt;<br>
&gt; -- Ben<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Feb 22, 2018 at 2:25 AM, Christian K=C3=B6nig<br>
&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leicht=
zumerken@gmail.<wbr>com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Am 22.02.2018 um 03:05 schrieb Alex Deucher:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Wed, Feb 21, 2018 at 6:41 PM, Ben Crocker &lt;<a href=3D"ma=
ilto:bcrocker@redhat.com">bcrocker@redhat.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; In radeon_device_init, set the need_dma32 flag for Cedar c=
hips<br>
&gt;&gt;&gt;&gt; (e.g. FirePro 2270).=C2=A0 This fixes, or at least works a=
round, a bug<br>
&gt;&gt;&gt;&gt; on PowerPC exposed by last year&#39;s commits<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 8e3f1b1d8255105f31556aacf8aeb6<wbr>071b00d469 (Russell Cur=
rey)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; and<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; 253fd51e2f533552ae35a0c661705d<wbr>a6c4842c1b (Alistair Po=
pple)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; which enabled the 64-bit DMA iommu bypass.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This caused the device to freeze, in some cases unrecovera=
bly, and is<br>
&gt;&gt;&gt;&gt; the subject of several bug reports internal to Red Hat.<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Can we make this ppc only?=C2=A0 40 bit DMA works fine on x86.=
<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Yeah and at least when the dma_coherent allocator path is used it =
should<br>
&gt;&gt; work fine on PPC as well.<br>
&gt;&gt;<br>
&gt;&gt; So that is not really a driver bug, but a platform bug and we shou=
ld think<br>
&gt;&gt; about reverting or at least disabling those two patches instead.<b=
r>
&gt;&gt;<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Alex<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Ben Crocker &lt;<a href=3D"mailto:bcrocker@=
redhat.com">bcrocker@redhat.com</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0drivers/gpu/drm/radeon/radeon_<wbr>device.c | =
5 ++++-<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A01 file changed, 4 insertions(+), 1 deletion(-)=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/radeon/<wbr>radeon_device.c<b=
r>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/radeon/<wbr>radeon_device.c<br>
&gt;&gt;&gt;&gt; index ffc10cadcf34..02538903830d 100644<br>
&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/radeon/<wbr>radeon_device.c<br>
&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/radeon/<wbr>radeon_device.c<br>
&gt;&gt;&gt;&gt; @@ -1395,7 +1395,10 @@ int radeon_device_init(struct radeo=
n_device<br>
&gt;&gt;&gt;&gt; *rdev,<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rdev-&gt;flags &amp;=
 RADEON_IS_AGP)<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 rdev-&gt;need_dma32 =3D true;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((rdev-&gt;flags &amp=
; RADEON_IS_PCI) &amp;&amp;<br>
&gt;&gt;&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;family=
 &lt;=3D CHIP_RS740))<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;family=
 &lt;=3D CHIP_RS740 || rdev-&gt;family =3D=3D CHIP_CEDAR))<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd=
ev-&gt;need_dma32 =3D true;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((rdev-&gt;flags &amp; RADE=
ON_IS_PCIE) &amp;&amp;<br>
&gt;&gt;&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(rdev-&gt;family=
 =3D=3D CHIP_CEDAR))<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 rdev-&gt;need_dma32 =3D true;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dma_bits =3D rdev-&gt;ne=
ed_dma32 ? 32 : 40;<br>
&gt;&gt;&gt;&gt; --<br>
&gt;&gt;&gt;&gt; 2.13.6<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt;&gt;&gt; dri-devel mailing list<br>
&gt;&gt;&gt;&gt; <a href=3D"mailto:dri-devel@lists.freedesktop.org">dri-dev=
el@lists.freedesktop.<wbr>org</a><br>
&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/=
dri-devel" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.o=
rg/<wbr>mailman/listinfo/dri-devel</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ______________________________<wbr>_________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists=
.freedesktop.org</a><br>
&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-=
gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/<wb=
r>mailman/listinfo/amd-gfx</a><br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</div></div></blockquote></div><br></div>

--001a114b32b67b0a050565cfc842--

--===============1647635447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1647635447==--
