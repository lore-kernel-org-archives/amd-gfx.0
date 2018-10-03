From: Mike Lothian <mike@fireburn.co.uk>
Subject: Re: [PATCH v2 0/3] A DRM API for adaptive sync and variable refresh
 rate support
Date: Wed, 3 Oct 2018 09:25:42 +0100
Message-ID: <CAHbf0-HhjG2xc1sAjHBR=Ep11LzumO6tdyzBcKSZ8h82H28Zbg@mail.gmail.com>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20181001071525.GJ11082@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1982043773=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181001071525.GJ11082@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: nicolai.haehnle@amd.com, michel@daenzer.net, Marek.Olsak@amd.com, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, manasi.d.navare@intel.com, dri-devel@lists.freedesktop.org, Alexander.Deucher@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1982043773==
Content-Type: multipart/alternative; boundary="00000000000067fe7405774ec918"

--00000000000067fe7405774ec918
Content-Type: text/plain; charset="UTF-8"

Hi

I'm curious to know whether this will/could work over PRIME

If the discrete card is rendering slower than the display's frequency could
the frequency be dropped on integrated display? I think there are laptops
that have freesync now

Cheers

Mike

On Mon, 1 Oct 2018 at 08:15 Daniel Vetter <daniel@ffwll.ch> wrote:

> On Mon, Sep 24, 2018 at 02:15:34PM -0400, Nicholas Kazlauskas wrote:
> > These patches are part of a proposed new interface for supporting
> variable refresh rate via DRM properties.
> >
> > === Changes from v1 ===
> >
> > For drm:
> >
> > * The variable_refresh_capable property is now flagged as
> DRM_MODE_PROP_IMMUTABLE
> >
> > For drm/gpu/amd/display:
> >
> > * Patches no longer pull in IOCTL/FreeSync refactoring code
> > * FreeSync enable/disable behavior has been modified to reflect changes
> in userspace behavior from xf86-video-amdgpu and mesa
> >
> > === Adaptive sync and variable refresh rate ===
> >
> > Adaptive sync is part of the DisplayPort spec and allows for graphics
> adapters to drive displays with varying frame timings.
> >
> > Variable refresh rate (VRR) is essentially the same, but defined for
> HDMI.
> >
> > === Use cases for variable refresh rate ===
> >
> > Variable frame (flip) timings don't align well with fixed refresh rate
> displays. This results in stuttering, tearing and/or input lag. By
> adjusting the display refresh rate dynamically these issues can be reduced
> or eliminated.
> >
> > However, not all content is suitable for dynamic refresh adaptation.
> Content that is flipped infrequently or at random intervals tends to fair
> poorly. Multiple clients trying to flip under the same screen can similarly
> interfere with prediction.
> >
> > Userland needs a way to let the driver know when the content on the
> screen is suitable for variable refresh rate and if the user wishes to have
> the feature enabled.
> >
> > === DRM API to support variable refresh rates ===
> >
> > This patch introduces a new API via atomic properties on the DRM
> connector and CRTC.
> >
> > The connector has two new optional properties:
> >
> > * bool variable_refresh_capable - set by the driver if the hardware is
> capable of supporting variable refresh tech
> >
> > * bool variable_refresh_enabled - set by the user to enable variable
> refresh adjustment over the connector
> >
> > The CRTC has one additional default property:
> >
> > * bool variable_refresh - a content hint to the driver specifying that
> the CRTC contents are suitable for variable refresh adjustment
> >
> > == Overview for DRM driver developers ===
> >
> > Driver developers can attach the optional connector properties via
> drm_connector_attach_variable_refresh_properties on connectors that support
> variable refresh (typically DP or HDMI).
> >
> > The variable_refresh_capable property should be managed as the output on
> the connector changes. The property is read only from userspace.
> >
> > The variable_refresh_enabled property is intended to be a property
> controlled by userland as a global on/off switch for variable refresh
> technology. It should be checked before enabling variable refresh rate.
> >
> > === Overview for Userland developers ==
> >
> > The variable_refresh property on the CRTC should be set to true when the
> CRTCs are suitable for variable refresh rate. In practice this is probably
> an application like a game - a single window that covers the whole CRTC
> surface and is the only client issuing flips.
> >
> > To demonstrate the suitability of the API for variable refresh and
> dynamic adaptation there are additional patches using this API that
> implement adaptive variable refresh across kernel and userland projects:
> >
> > * DRM (dri-devel)
> > * amdgpu DRM kernel driver (amd-gfx)
> > * xf86-video-amdgpu (amd-gfx)
> > * mesa (mesa-dev)
> >
> > These patches enable adaptive variable refresh on X for AMD hardware
> provided that the user sets the variable_refresh_enabled property to true
> on supported connectors (ie. using xrandr --set-prop).
> >
> > The patches have been tested as working on upstream userland with the
> GNOME desktop environment under a single monitor setup. They also work on
> KDE in single monitor setup if the compositor is disabled.
> >
> > The patches require that the application window can issue screen flips
> via the Present extension to xf86-video-amdgpu. Due to Present extension
> limitations some desktop environments and multi-monitor setups are
> currently not compatible.
> >
> > Full implementation details for these changes can be reviewed in their
> respective mailing lists.
> >
> > === Previous discussions ===
> >
> > These patches are based upon feedback from patches and feedback from two
> previous threads on the subject which are linked below for reference:
> >
> > https://lists.freedesktop.org/archives/amd-gfx/2018-April/021047.html
> >
> https://lists.freedesktop.org/archives/dri-devel/2017-October/155207.html
> >
> https://lists.freedesktop.org/archives/dri-devel/2018-September/189404.html
> >
> > Nicholas Kazlauskas
> >
> > Nicholas Kazlauskas (3):
> >   drm: Add variable refresh rate properties to connector
> >   drm: Add variable refresh property to DRM CRTC
> >   drm/amd/display: Set FreeSync state using DRM VRR properties
>
> Please include Manasi manasi.d.navare@intel.com when resending, she's
> working on this from our side.
>
> Also some overview kernel-docs that document the uapi aspect of how the
> prorties are driven should be included. Probably best if you add a new
> "Variable Refresh Rate" section under
>
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#kms-properties
>
> with links to functions drivers should call to set up and everything. Best
> practice is to stuff all that into a DOC: comment.
>
> An igt testcase would be neat too.
>
> Cheers, Daniel
>
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 232 +++++++++---------
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +-
> >  drivers/gpu/drm/drm_atomic_helper.c           |   1 +
> >  drivers/gpu/drm/drm_atomic_uapi.c             |  12 +
> >  drivers/gpu/drm/drm_connector.c               |  35 +++
> >  drivers/gpu/drm/drm_crtc.c                    |   2 +
> >  drivers/gpu/drm/drm_mode_config.c             |   6 +
> >  include/drm/drm_connector.h                   |  27 ++
> >  include/drm/drm_crtc.h                        |  13 +
> >  include/drm/drm_mode_config.h                 |   8 +
> >  10 files changed, 225 insertions(+), 117 deletions(-)
> >
> > --
> > 2.19.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

--00000000000067fe7405774ec918
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>I&#39;m curious to know whether this=
 will/could work over PRIME<br><br>If the discrete card is rendering slower=
 than the display&#39;s frequency could the frequency be dropped on integra=
ted display? I think there are laptops that have freesync now</div><div><br=
></div><div>Cheers</div><div><br></div><div>Mike</div><div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr">On Mon, 1 Oct 2018 at 08:15 Daniel Vetter=
 &lt;<a href=3D"mailto:daniel@ffwll.ch">daniel@ffwll.ch</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">On Mon, Sep 24, 2018 at 02:15:34PM -040=
0, Nicholas Kazlauskas wrote:<br>
&gt; These patches are part of a proposed new interface for supporting vari=
able refresh rate via DRM properties.<br>
&gt; <br>
&gt; =3D=3D=3D Changes from v1 =3D=3D=3D<br>
&gt; <br>
&gt; For drm:<br>
&gt; <br>
&gt; * The variable_refresh_capable property is now flagged as DRM_MODE_PRO=
P_IMMUTABLE<br>
&gt; <br>
&gt; For drm/gpu/amd/display:<br>
&gt; <br>
&gt; * Patches no longer pull in IOCTL/FreeSync refactoring code<br>
&gt; * FreeSync enable/disable behavior has been modified to reflect change=
s in userspace behavior from xf86-video-amdgpu and mesa<br>
&gt; <br>
&gt; =3D=3D=3D Adaptive sync and variable refresh rate =3D=3D=3D<br>
&gt; <br>
&gt; Adaptive sync is part of the DisplayPort spec and allows for graphics =
adapters to drive displays with varying frame timings.<br>
&gt; <br>
&gt; Variable refresh rate (VRR) is essentially the same, but defined for H=
DMI.<br>
&gt; <br>
&gt; =3D=3D=3D Use cases for variable refresh rate =3D=3D=3D<br>
&gt; <br>
&gt; Variable frame (flip) timings don&#39;t align well with fixed refresh =
rate displays. This results in stuttering, tearing and/or input lag. By adj=
usting the display refresh rate dynamically these issues can be reduced or =
eliminated.<br>
&gt; <br>
&gt; However, not all content is suitable for dynamic refresh adaptation. C=
ontent that is flipped infrequently or at random intervals tends to fair po=
orly. Multiple clients trying to flip under the same screen can similarly i=
nterfere with prediction.<br>
&gt; <br>
&gt; Userland needs a way to let the driver know when the content on the sc=
reen is suitable for variable refresh rate and if the user wishes to have t=
he feature enabled.<br>
&gt; <br>
&gt; =3D=3D=3D DRM API to support variable refresh rates =3D=3D=3D<br>
&gt; <br>
&gt; This patch introduces a new API via atomic properties on the DRM conne=
ctor and CRTC.<br>
&gt; <br>
&gt; The connector has two new optional properties:<br>
&gt; <br>
&gt; * bool variable_refresh_capable - set by the driver if the hardware is=
 capable of supporting variable refresh tech<br>
&gt; <br>
&gt; * bool variable_refresh_enabled - set by the user to enable variable r=
efresh adjustment over the connector<br>
&gt; <br>
&gt; The CRTC has one additional default property:<br>
&gt; <br>
&gt; * bool variable_refresh - a content hint to the driver specifying that=
 the CRTC contents are suitable for variable refresh adjustment<br>
&gt; <br>
&gt; =3D=3D Overview for DRM driver developers =3D=3D=3D<br>
&gt; <br>
&gt; Driver developers can attach the optional connector properties via drm=
_connector_attach_variable_refresh_properties on connectors that support va=
riable refresh (typically DP or HDMI).<br>
&gt; <br>
&gt; The variable_refresh_capable property should be managed as the output =
on the connector changes. The property is read only from userspace.<br>
&gt; <br>
&gt; The variable_refresh_enabled property is intended to be a property con=
trolled by userland as a global on/off switch for variable refresh technolo=
gy. It should be checked before enabling variable refresh rate.<br>
&gt; <br>
&gt; =3D=3D=3D Overview for Userland developers =3D=3D<br>
&gt; <br>
&gt; The variable_refresh property on the CRTC should be set to true when t=
he CRTCs are suitable for variable refresh rate. In practice this is probab=
ly an application like a game - a single window that covers the whole CRTC =
surface and is the only client issuing flips.<br>
&gt; <br>
&gt; To demonstrate the suitability of the API for variable refresh and dyn=
amic adaptation there are additional patches using this API that implement =
adaptive variable refresh across kernel and userland projects:<br>
&gt; <br>
&gt; * DRM (dri-devel)<br>
&gt; * amdgpu DRM kernel driver (amd-gfx)<br>
&gt; * xf86-video-amdgpu (amd-gfx)<br>
&gt; * mesa (mesa-dev)<br>
&gt; <br>
&gt; These patches enable adaptive variable refresh on X for AMD hardware p=
rovided that the user sets the variable_refresh_enabled property to true on=
 supported connectors (ie. using xrandr --set-prop).<br>
&gt; <br>
&gt; The patches have been tested as working on upstream userland with the =
GNOME desktop environment under a single monitor setup. They also work on K=
DE in single monitor setup if the compositor is disabled.<br>
&gt; <br>
&gt; The patches require that the application window can issue screen flips=
 via the Present extension to xf86-video-amdgpu. Due to Present extension l=
imitations some desktop environments and multi-monitor setups are currently=
 not compatible.<br>
&gt; <br>
&gt; Full implementation details for these changes can be reviewed in their=
 respective mailing lists.<br>
&gt; <br>
&gt; =3D=3D=3D Previous discussions =3D=3D=3D<br>
&gt; <br>
&gt; These patches are based upon feedback from patches and feedback from t=
wo previous threads on the subject which are linked below for reference:<br=
>
&gt; <br>
&gt; <a href=3D"https://lists.freedesktop.org/archives/amd-gfx/2018-April/0=
21047.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.=
org/archives/amd-gfx/2018-April/021047.html</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/archives/dri-devel/2017-Octob=
er/155207.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesk=
top.org/archives/dri-devel/2017-October/155207.html</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/archives/dri-devel/2018-Septe=
mber/189404.html" rel=3D"noreferrer" target=3D"_blank">https://lists.freede=
sktop.org/archives/dri-devel/2018-September/189404.html</a><br>
&gt; <br>
&gt; Nicholas Kazlauskas<br>
&gt; <br>
&gt; Nicholas Kazlauskas (3):<br>
&gt;=C2=A0 =C2=A0drm: Add variable refresh rate properties to connector<br>
&gt;=C2=A0 =C2=A0drm: Add variable refresh property to DRM CRTC<br>
&gt;=C2=A0 =C2=A0drm/amd/display: Set FreeSync state using DRM VRR properti=
es<br>
<br>
Please include Manasi <a href=3D"mailto:manasi.d.navare@intel.com" target=
=3D"_blank">manasi.d.navare@intel.com</a> when resending, she&#39;s<br>
working on this from our side.<br>
<br>
Also some overview kernel-docs that document the uapi aspect of how the<br>
prorties are driven should be included. Probably best if you add a new<br>
&quot;Variable Refresh Rate&quot; section under<br>
<br>
<a href=3D"https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#kms-proper=
ties" rel=3D"noreferrer" target=3D"_blank">https://dri.freedesktop.org/docs=
/drm/gpu/drm-kms.html#kms-properties</a><br>
<br>
with links to functions drivers should call to set up and everything. Best<=
br>
practice is to stuff all that into a DOC: comment.<br>
<br>
An igt testcase would be neat too.<br>
<br>
Cheers, Daniel<br>
<br>
&gt; <br>
&gt;=C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 232 +++++++++---=
------<br>
&gt;=C2=A0 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |=C2=A0 =C2=A06 +-=
<br>
&gt;=C2=A0 drivers/gpu/drm/drm_atomic_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/gpu/drm/drm_atomic_uapi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 12 +<br>
&gt;=C2=A0 drivers/gpu/drm/drm_connector.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 35 +++<br>
&gt;=C2=A0 drivers/gpu/drm/drm_crtc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 drivers/gpu/drm/drm_mode_config.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 include/drm/drm_connector.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 27 ++<br>
&gt;=C2=A0 include/drm/drm_crtc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 +<br>
&gt;=C2=A0 include/drm/drm_mode_config.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A08 +<br>
&gt;=C2=A0 10 files changed, 225 insertions(+), 117 deletions(-)<br>
&gt; <br>
&gt; -- <br>
&gt; 2.19.0<br>
&gt; <br>
<br>
-- <br>
Daniel Vetter<br>
Software Engineer, Intel Corporation<br>
<a href=3D"http://blog.ffwll.ch" rel=3D"noreferrer" target=3D"_blank">http:=
//blog.ffwll.ch</a><br>
_______________________________________________<br>
dri-devel mailing list<br>
<a href=3D"mailto:dri-devel@lists.freedesktop.org" target=3D"_blank">dri-de=
vel@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel" rel=3D=
"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listin=
fo/dri-devel</a><br>
</blockquote></div></div></div>

--00000000000067fe7405774ec918--

--===============1982043773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1982043773==--
