From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 0/7] Enabling Color Management - Round 3
Date: Thu, 7 Jun 2018 08:22:30 +0100
Message-ID: <CAHbf0-GW9MDmTBDepJjG-WXdqNPhsHWwQMvHo1Sma+JCDy-1dQ@mail.gmail.com>
References: <1527869017-9209-1-git-send-email-sunpeng.li@amd.com>
 <e0a71df1-265b-cb62-1c1f-567b26808b71@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0413110047=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e0a71df1-265b-cb62-1c1f-567b26808b71-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: sunpeng.li-5C7GfCeVMHo@public.gmane.org, harry.wentland-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0413110047==
Content-Type: multipart/alternative; boundary="00000000000018486c056e08260d"

--00000000000018486c056e08260d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

Is there a way to set depth using a xorg.conf.d snippet rather than
creating an xorg.conf?

Cheers

Mike

On Wed, 6 Jun 2018 at 17:01 Michel D=C3=A4nzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org> wrote:

>
> Hi Leo,
>
>
> On 2018-06-01 06:03 PM, sunpeng.li-5C7GfCeVMHo@public.gmane.org wrote:
> > From: "Leo (Sunpeng) Li" <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> >
> > This ended up being different enough from v2 to warrant a new patchset.
> Per
> > Michel's suggestions, there have been various optimizations and cleanup=
s.
> > Here's what's changed:
> >
> > * Cache DRM color management property IDs at pre-init,
> >     * instead of querying DRM each time we need to modify color
> properties.
> >
> > * Remove drmmode_update_cm_props().
> >     * Update color properties in drmmode_output_get_property() instead.
> >     * This also makes old calls to update_cm_props redundant.
> >
> > * Get rid of fake CRTCs.
> >     * Previously, we were allocating a fake CRTC to configure color
> props on
> >       outputs that don't have a CRTC.
> >     * Instead, rr_configure_and_change_cm_property() can be easily
> modified to
> >       accept NULL CRTCs.
> >
> > * Drop patches to persist color properties across DPMS events.
> >     * Kernel driver should be patched instead:
> >
> https://lists.freedesktop.org/archives/amd-gfx/2018-May/022744.html
> >     * Color props including legacy gamma now persist across crtc dpms.
> >     * Non-legacy props now persist across output dpms and hotplug, as
> long
> >       as the same CRTC remains attached to that output.
> >
> > And some smaller improvements:
> >
> > * Change CTM to be 32-bit format instead of 16-bit.
> >     * This requires clients to ensure that each 32-bit element is padde=
d
> to be
> >       long-sized, since libXrandr parses 32-bit format as long-typed.
> >
> > * Optimized color management init during CRTC init.
> >     * Query DRM once for the list of properties, instead of twice.
>
> Sounds good. I'll be going through the patches in detail from now on,
> but I don't know yet when I'll be able to finish the review.
>
>
> Meanwhile, heads up on two issues I discovered while smoke-testing the
> series (which are sort of related, but occur even without this series):
>
>
> Running Xorg in depth 30[0] results in completely wrong colours
> (everything has a red tint) with current kernels. I think this is
> because DC now preserves the gamma LUT values, but xf86-video-amdgpu
> never sets them at depth 30, so the hardware is still using values for
> 24-bit RGB.
>
> Can you look into making xf86-video-amdgpu set the LUT values at depth
> 30 as well? Ideally in a way which doesn't require all patches in this
> series, so that it could be backported for a 18.0.2 point release if
> necessary. (Similarly for skipping drmmode_cursor_gamma when the kernel
> supports the new colour management properties, to fix
> https://bugs.freedesktop.org/106578)
>
>
> Trying to run Xorg in depth 16 or 8[0] results in failure to set any mode=
:
>
> [    56.138] (EE) AMDGPU(0): failed to set mode: Invalid argument
> [    56.138] (WW) AMDGPU(0): Failed to set mode on CRTC 0
> [    56.172] (EE) AMDGPU(0): Failed to enable any CRTC
>
> Works fine with amdgpu.dc=3D0. This has been broken at least since the
> 4.16 development cycle.
>
>
> [0] You can change Xorg's colour depth either via -depth on its command
> line, or via the xorg.conf screen section:
>
> Section "Screen"
>         Identifier "Screen0"
>         DefaultDepth 30 # or 16 or 8
> EndSection
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000018486c056e08260d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>Is there a way to set depth using a =
xorg.conf.d snippet rather than creating an xorg.conf?</div><div><br></div>=
<div>Cheers</div><div><br></div><div>Mike<br><br><div class=3D"gmail_quote"=
><div dir=3D"ltr">On Wed, 6 Jun 2018 at 17:01 Michel D=C3=A4nzer &lt;<a hre=
f=3D"mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
Hi Leo,<br>
<br>
<br>
On 2018-06-01 06:03 PM, <a href=3D"mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank">sunpeng.li-5C7GfCeVMHo@public.gmane.org</a> wrote:<br>
&gt; From: &quot;Leo (Sunpeng) Li&quot; &lt;<a href=3D"mailto:sunpeng.li@am=
d.com" target=3D"_blank">sunpeng.li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; <br>
&gt; This ended up being different enough from v2 to warrant a new patchset=
. Per<br>
&gt; Michel&#39;s suggestions, there have been various optimizations and cl=
eanups.<br>
&gt; Here&#39;s what&#39;s changed:<br>
&gt; <br>
&gt; * Cache DRM color management property IDs at pre-init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0* instead of querying DRM each time we need to modi=
fy color properties.<br>
&gt; <br>
&gt; * Remove drmmode_update_cm_props().<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Update color properties in drmmode_output_get_pro=
perty() instead.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* This also makes old calls to update_cm_props redu=
ndant.<br>
&gt; <br>
&gt; * Get rid of fake CRTCs.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Previously, we were allocating a fake CRTC to con=
figure color props on<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0outputs that don&#39;t have a CRTC.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Instead, rr_configure_and_change_cm_property() ca=
n be easily modified to<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0accept NULL CRTCs.<br>
&gt; <br>
&gt; * Drop patches to persist color properties across DPMS events.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Kernel driver should be patched instead:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https://lists.freedesktop.org/arc=
hives/amd-gfx/2018-May/022744.html" rel=3D"noreferrer" target=3D"_blank">ht=
tps://lists.freedesktop.org/archives/amd-gfx/2018-May/022744.html</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0* Color props including legacy gamma now persist ac=
ross crtc dpms.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Non-legacy props now persist across output dpms a=
nd hotplug, as long<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0as the same CRTC remains attached to that ou=
tput.<br>
&gt; <br>
&gt; And some smaller improvements:<br>
&gt; <br>
&gt; * Change CTM to be 32-bit format instead of 16-bit.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* This requires clients to ensure that each 32-bit =
element is padded to be<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0long-sized, since libXrandr parses 32-bit fo=
rmat as long-typed.<br>
&gt; <br>
&gt; * Optimized color management init during CRTC init.<br>
&gt;=C2=A0 =C2=A0 =C2=A0* Query DRM once for the list of properties, instea=
d of twice.<br>
<br>
Sounds good. I&#39;ll be going through the patches in detail from now on,<b=
r>
but I don&#39;t know yet when I&#39;ll be able to finish the review.<br>
<br>
<br>
Meanwhile, heads up on two issues I discovered while smoke-testing the<br>
series (which are sort of related, but occur even without this series):<br>
<br>
<br>
Running Xorg in depth 30[0] results in completely wrong colours<br>
(everything has a red tint) with current kernels. I think this is<br>
because DC now preserves the gamma LUT values, but xf86-video-amdgpu<br>
never sets them at depth 30, so the hardware is still using values for<br>
24-bit RGB.<br>
<br>
Can you look into making xf86-video-amdgpu set the LUT values at depth<br>
30 as well? Ideally in a way which doesn&#39;t require all patches in this<=
br>
series, so that it could be backported for a 18.0.2 point release if<br>
necessary. (Similarly for skipping drmmode_cursor_gamma when the kernel<br>
supports the new colour management properties, to fix<br>
<a href=3D"https://bugs.freedesktop.org/106578" rel=3D"noreferrer" target=
=3D"_blank">https://bugs.freedesktop.org/106578</a>)<br>
<br>
<br>
Trying to run Xorg in depth 16 or 8[0] results in failure to set any mode:<=
br>
<br>
[=C2=A0 =C2=A0 56.138] (EE) AMDGPU(0): failed to set mode: Invalid argument=
<br>
[=C2=A0 =C2=A0 56.138] (WW) AMDGPU(0): Failed to set mode on CRTC 0<br>
[=C2=A0 =C2=A0 56.172] (EE) AMDGPU(0): Failed to enable any CRTC<br>
<br>
Works fine with amdgpu.dc=3D0. This has been broken at least since the<br>
4.16 development cycle.<br>
<br>
<br>
[0] You can change Xorg&#39;s colour depth either via -depth on its command=
<br>
line, or via the xorg.conf screen section:<br>
<br>
Section &quot;Screen&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Identifier &quot;Screen0&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 DefaultDepth 30 # or 16 or 8<br>
EndSection<br>
<br>
<br>
-- <br>
Earthling Michel D=C3=A4nzer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=
=3D"http://www.amd.com" rel=3D"noreferrer" target=3D"_blank">http://www.amd=
.com</a><br>
Libre software enthusiast=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Mesa and X developer<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div></div></div>

--00000000000018486c056e08260d--

--===============0413110047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0413110047==--
