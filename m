From: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] RFC: drm/amd/display: enable ABGR and XBGR formats (v2)
Date: Tue, 17 Jul 2018 20:38:43 +0200
Message-ID: <CAEQFVGbAQ+1BbdhC+4sGiFukH-JVSui9Y+ZhxPswCVHw+rcbFw@mail.gmail.com>
References: <20180716020330.21525-1-user@ANDROIDDEV>
 <CADnq5_P0_pLHZ+9ccQ6hro9NBBuqL-G8UjYp3NTr-Oka+0KYAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0618259371=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_P0_pLHZ+9ccQ6hro9NBBuqL-G8UjYp3NTr-Oka+0KYAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============0618259371==
Content-Type: multipart/alternative; boundary="00000000000048dc90057136426c"

--00000000000048dc90057136426c
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Il giorno mar 17 lug 2018 alle ore 15:43 Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
ha scritto:

> On Sun, Jul 15, 2018 at 10:03 PM, Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > From: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > (v1) {A,X}BGR8888 code paths are added in amdgpu_dm, by using an
> fb_format
> >      already listed in dc/dc_hw_types.h
> (SURFACE_PIXEL_FORMAT_GRPH_ABGR8888),
> >      and in dce 8.0, 10.0 and 11.0, i.e. Bonaire and later.
> >      GRPH_FORMAT_ARGB8888 is used due to lack of specific
> GRPH_FORMAT_ABGR8888
> >
> > (v2) support for {A,X}BGR8888 in atombios_crtc (now in dce4 path, to be
> refined)
> >      to initialize frame buffer device and avoid following dmesg error:
> >      "[drm] Cannot find any crtc or sizes"
> >
> > Tested with oreo-x86 (hwcomposer.drm + gralloc.gbm + mesa-dev/radv)
> > SurfaceFlinger can now select RGBA_8888 format for HWC_FRAMEBUFFER_TARGET
> > No major regression or crash observed so far, but some android 2D overlay
> > may be affected by color artifacts. Kind feedback requested.
> >
> > Signed-off-by: Mauro Rossi <issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Please split the patch in three (one for radeon and one for amdgpu dc
> and one for amdgpu non-dc).  Also the GRPH_SWAP_CONTROL register has a
> crossbar where you can change the channel routing.  You may need that
> for the channel routing to work correctly.
>
> Alex
>

Thanks for your suggestion and guidance! :-)

I may need some time to assimilate the suggestions and some confirmations,
as I am an amateur in AMD GPU coding, to be honest, I should have mentioned
that before.

Regarding the radeon scope of changes,
do you recommend to keep the enablement of {A,X}BGR8888  for dce4 and later,
or to extend the enablement of  {A,X}BGR8888 to older families of radeon
gpus/chipsets?

What is the lower radeon family where {A,X}BGR8888  can be natively
supported by HW,
by means of  swap control registers for channel routing configuration?

Based on the scope of  {A,X}BGR8888 support in final patches,
I may need to add handling in other dce code and maybe other modules,
could you please provide information in terms of necessary changes/high
level steps to follow?

Do you have some pointer to documentation on  swap control registers for
the families
that may be considered as 'safe to be kept in scope' for  {A,X}BGR8888
support?

Last but not least I would like to ask you about how to test no-regression,
even if this will come later,
when patches will be in good shape for further evaluation, do you have
tools and samples for conformance/no-regression testing?
I am asking because I don't have samples for all families.

Kind regards

Mauro




>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c            | 9 +++++++++
> >  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c            | 9 +++++++++
> >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c             | 8 ++++++++
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++
> >  drivers/gpu/drm/radeon/atombios_crtc.c            | 8 ++++++++
> >  5 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > index 022f303463fc..d4280d2e7737 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > @@ -2005,6 +2005,15 @@ static int dce_v10_0_crtc_do_set_base(struct
> drm_crtc *crtc,
> >                 /* Greater 8 bpc fb needs to bypass hw-lut to retain
> precision */
> >                 bypass_lut = true;
> >                 break;
> > +       case DRM_FORMAT_XBGR8888:
> > +       case DRM_FORMAT_ABGR8888:
> > +               fb_format = REG_SET_FIELD(0, GRPH_CONTROL, GRPH_DEPTH,
> 2);
> > +               fb_format = REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 0); /* Hack */
> > +#ifdef __BIG_ENDIAN
> > +               fb_swap = REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> > +                                       ENDIAN_8IN32);
> > +#endif
> > +               break;
> >         default:
> >                 DRM_ERROR("Unsupported screen format %s\n",
> >                           drm_get_format_name(target_fb->format->format,
> &format_name));
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > index 800a9f36ab4f..d48ee8f2e192 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > @@ -2044,6 +2044,15 @@ static int dce_v11_0_crtc_do_set_base(struct
> drm_crtc *crtc,
> >                 /* Greater 8 bpc fb needs to bypass hw-lut to retain
> precision */
> >                 bypass_lut = true;
> >                 break;
> > +       case DRM_FORMAT_XBGR8888:
> > +       case DRM_FORMAT_ABGR8888:
> > +               fb_format = REG_SET_FIELD(0, GRPH_CONTROL, GRPH_DEPTH,
> 2);
> > +               fb_format = REG_SET_FIELD(fb_format, GRPH_CONTROL,
> GRPH_FORMAT, 0); /* Hack */
> > +#ifdef __BIG_ENDIAN
> > +               fb_swap = REG_SET_FIELD(fb_swap, GRPH_SWAP_CNTL,
> GRPH_ENDIAN_SWAP,
> > +                                       ENDIAN_8IN32);
> > +#endif
> > +               break;
> >         default:
> >                 DRM_ERROR("Unsupported screen format %s\n",
> >                           drm_get_format_name(target_fb->format->format,
> &format_name));
> > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > index 012e0a9ae0ff..0e2fc1ac475f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > @@ -1929,6 +1929,14 @@ static int dce_v8_0_crtc_do_set_base(struct
> drm_crtc *crtc,
> >                 /* Greater 8 bpc fb needs to bypass hw-lut to retain
> precision */
> >                 bypass_lut = true;
> >                 break;
> > +       case DRM_FORMAT_XBGR8888:
> > +       case DRM_FORMAT_ABGR8888:
> > +               fb_format = ((GRPH_DEPTH_32BPP <<
> GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
> > +                            (GRPH_FORMAT_ARGB8888 <<
> GRPH_CONTROL__GRPH_FORMAT__SHIFT)); /* Hack */
> > +#ifdef __BIG_ENDIAN
> > +               fb_swap = (GRPH_ENDIAN_8IN32 <<
> GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
> > +#endif
> > +               break;
> >         default:
> >                 DRM_ERROR("Unsupported screen format %s\n",
> >                           drm_get_format_name(target_fb->format->format,
> &format_name));
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 63c67346d316..6c10fa291150 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1824,6 +1824,10 @@ static int fill_plane_attributes_from_fb(struct
> amdgpu_device *adev,
> >         case DRM_FORMAT_ABGR2101010:
> >                 plane_state->format =
> SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010;
> >                 break;
> > +       case DRM_FORMAT_XBGR8888:
> > +       case DRM_FORMAT_ABGR8888:
> > +               plane_state->format = SURFACE_PIXEL_FORMAT_GRPH_ABGR8888;
> > +               break;
> >         case DRM_FORMAT_NV21:
> >                 plane_state->format =
> SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr;
> >                 break;
> > @@ -3115,6 +3119,8 @@ static const uint32_t rgb_formats[] = {
> >         DRM_FORMAT_XBGR2101010,
> >         DRM_FORMAT_ARGB2101010,
> >         DRM_FORMAT_ABGR2101010,
> > +       DRM_FORMAT_XBGR8888,
> > +       DRM_FORMAT_ABGR8888,
> >  };
> >
> >  static const uint32_t yuv_formats[] = {
> > diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c
> b/drivers/gpu/drm/radeon/atombios_crtc.c
> > index 02baaaf20e9d..b954b3658a33 100644
> > --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> > +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> > @@ -1259,6 +1259,14 @@ static int dce4_crtc_do_set_base(struct drm_crtc
> *crtc,
> >                 /* Greater 8 bpc fb needs to bypass hw-lut to retain
> precision */
> >                 bypass_lut = true;
> >                 break;
> > +       case DRM_FORMAT_XBGR8888:
> > +       case DRM_FORMAT_ABGR8888:
> > +               fb_format =
> (EVERGREEN_GRPH_DEPTH(EVERGREEN_GRPH_DEPTH_32BPP) |
> > +
> EVERGREEN_GRPH_FORMAT(EVERGREEN_GRPH_FORMAT_ARGB8888));
> > +#ifdef __BIG_ENDIAN
> > +               fb_swap =
> EVERGREEN_GRPH_ENDIAN_SWAP(EVERGREEN_GRPH_ENDIAN_8IN32);
> > +#endif
> > +               break;
> >         default:
> >                 DRM_ERROR("Unsupported screen format %s\n",
> >                           drm_get_format_name(target_fb->format->format,
> &format_name));
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000048dc90057136426c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Alex,<div><br></div><div class=3D"gmail_quote"><div dir=
=3D"ltr">Il giorno mar 17 lug 2018 alle ore 15:43 Alex Deucher &lt;<a href=
=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; ha scritto:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">On Sun, Jul 15, 2018 at 10:03 PM, =
Mauro Rossi &lt;<a href=3D"mailto:issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">=
issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br>
&gt; From: Mauro Rossi &lt;<a href=3D"mailto:issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=
=3D"_blank">issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; (v1) {A,X}BGR8888 code paths are added in amdgpu_dm, by using an fb_fo=
rmat<br>
&gt;=C2=A0 =C2=A0 =C2=A0 already listed in dc/dc_hw_types.h (SURFACE_PIXEL_=
FORMAT_GRPH_ABGR8888),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 and in dce 8.0, 10.0 and 11.0, i.e. Bonaire and la=
ter.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GRPH_FORMAT_ARGB8888 is used due to lack of specif=
ic GRPH_FORMAT_ABGR8888<br>
&gt;<br>
&gt; (v2) support for {A,X}BGR8888 in atombios_crtc (now in dce4 path, to b=
e refined)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 to initialize frame buffer device and avoid follow=
ing dmesg error:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &quot;[drm] Cannot find any crtc or sizes&quot;<br=
>
&gt;<br>
&gt; Tested with oreo-x86 (hwcomposer.drm + gralloc.gbm + mesa-dev/radv)<br=
>
&gt; SurfaceFlinger can now select RGBA_8888 format for HWC_FRAMEBUFFER_TAR=
GET<br>
&gt; No major regression or crash observed so far, but some android 2D over=
lay<br>
&gt; may be affected by color artifacts. Kind feedback requested.<br>
&gt;<br>
&gt; Signed-off-by: Mauro Rossi &lt;<a href=3D"mailto:issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
" target=3D"_blank">issor.oruam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<br>
Please split the patch in three (one for radeon and one for amdgpu dc<br>
and one for amdgpu non-dc).=C2=A0 Also the GRPH_SWAP_CONTROL register has a=
<br>
crossbar where you can change the channel routing.=C2=A0 You may need that<=
br>
for the channel routing to work correctly.<br>
<br>
Alex<br></blockquote><div><br></div><div>Thanks for your suggestion and gui=
dance! :-)=C2=A0</div><div><br></div><div>I may need some time to assimilat=
e the suggestions and some confirmations,=C2=A0</div><div>as I am an amateu=
r in AMD GPU coding, to be honest, I should have mentioned that before.<br>=
</div><div><br></div><div>Regarding the radeon scope of changes,</div><div>=
do you recommend to keep the enablement of=C2=A0<span style=3D"font-size:sm=
all;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial;float:none;display:inline">{</span><span style=3D"fo=
nt-size:small;background-color:rgb(255,255,255);text-decoration-style:initi=
al;text-decoration-color:initial;float:none;display:inline">A,X}BGR</span><=
span style=3D"font-size:small;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial;float:none;display:inline"=
>8888</span>=C2=A0 for dce4 and later,</div><div>or to extend the enablemen=
t of=C2=A0=C2=A0{A,X}BGR8888 to older families of radeon gpus/chipsets?</di=
v><div><br></div><div>What is the lower radeon family where=C2=A0<span styl=
e=3D"font-size:small;background-color:rgb(255,255,255);text-decoration-styl=
e:initial;text-decoration-color:initial;float:none;display:inline">{</span>=
<span style=3D"font-size:small;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
">A,X}BGR</span><span style=3D"font-size:small;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial;float:non=
e;display:inline">8888</span>=C2=A0 can be natively supported by HW,</div><=
div>by means of=C2=A0 swap control registers for=C2=A0<span style=3D"font-s=
ize:small;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial;float:none;display:inline">channel routing con=
figuration?</span></div><div><span style=3D"font-size:small;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial;float:none;display:inline"><br></span></div><div><span style=3D"font-si=
ze:small;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial;float:none;display:inline">Based on the scope o=
f=C2=A0

<span style=3D"text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">{</span><span style=3D"text-decoration-style:ini=
tial;text-decoration-color:initial;float:none;display:inline">A,X}BGR</span=
><span style=3D"text-decoration-style:initial;text-decoration-color:initial=
;float:none;display:inline">8888</span><span style=3D"text-decoration-style=
:initial;text-decoration-color:initial;float:none;display:inline">=C2=A0sup=
port in final patches,=C2=A0</span></span></div><div><span style=3D"font-si=
ze:small;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial;float:none;display:inline"><span style=3D"text-=
decoration-style:initial;text-decoration-color:initial;float:none;display:i=
nline">I may need to add handling in other dce code and maybe other modules=
,</span></span></div><div>could you please provide information in terms of =
necessary changes/high level steps to follow?</div><div><br></div><div>Do y=
ou have some pointer to documentation on=C2=A0 swap control registers for t=
he families</div><div>that may be considered as &#39;safe to be kept in sco=
pe&#39; for=C2=A0

<span style=3D"font-size:small;text-decoration-style:initial;text-decoratio=
n-color:initial;float:none;display:inline">{</span><span style=3D"font-size=
:small;text-decoration-style:initial;text-decoration-color:initial;float:no=
ne;display:inline">A,X}BGR</span><span style=3D"font-size:small;text-decora=
tion-style:initial;text-decoration-color:initial;float:none;display:inline"=
>8888 support?</span></div><div><span style=3D"font-size:small;text-decorat=
ion-style:initial;text-decoration-color:initial;float:none;display:inline">=
<br></span></div><div>Last but not least I would like to ask you about how =
to test no-regression, even if this will come later,</div><div>when patches=
 will be in good shape for further evaluation, do you have tools and sample=
s for conformance/no-regression testing?</div><div>I am asking because I do=
n&#39;t have samples for all families.</div><div><br></div><div>Kind regard=
s</div><div><br></div><div>Mauro</div><div><span style=3D"font-size:small;t=
ext-decoration-style:initial;text-decoration-color:initial;float:none;displ=
ay:inline"><br></span></div><div><span style=3D"font-size:small;text-decora=
tion-style:initial;text-decoration-color:initial;float:none;display:inline"=
><br></span></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 9 +++++++++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 9 +++++++++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| 8 ++++++++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++++<br>
&gt;=C2=A0 drivers/gpu/drm/radeon/atombios_crtc.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 8 ++++++++<br>
&gt;=C2=A0 5 files changed, 40 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/dce_v10_0.c<br>
&gt; index 022f303463fc..d4280d2e7737 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
&gt; @@ -2005,6 +2005,15 @@ static int dce_v10_0_crtc_do_set_base(struct dr=
m_crtc *crtc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Greate=
r 8 bpc fb needs to bypass hw-lut to retain precision */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bypass_lu=
t =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_XBGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_ABGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_format =3D =
REG_SET_FIELD(0, GRPH_CONTROL, GRPH_DEPTH, 2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_format =3D =
REG_SET_FIELD(fb_format, GRPH_CONTROL, GRPH_FORMAT, 0); /* Hack */<br>
&gt; +#ifdef __BIG_ENDIAN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_swap =3D RE=
G_SET_FIELD(fb_swap, GRPH_SWAP_CNTL, GRPH_ENDIAN_SWAP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ENDIA=
N_8IN32);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR=
(&quot;Unsupported screen format %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_get_format_name(target_fb-&gt;format-&gt;for=
mat, &amp;format_name));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/dce_v11_0.c<br>
&gt; index 800a9f36ab4f..d48ee8f2e192 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c<br>
&gt; @@ -2044,6 +2044,15 @@ static int dce_v11_0_crtc_do_set_base(struct dr=
m_crtc *crtc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Greate=
r 8 bpc fb needs to bypass hw-lut to retain precision */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bypass_lu=
t =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_XBGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_ABGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_format =3D =
REG_SET_FIELD(0, GRPH_CONTROL, GRPH_DEPTH, 2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_format =3D =
REG_SET_FIELD(fb_format, GRPH_CONTROL, GRPH_FORMAT, 0); /* Hack */<br>
&gt; +#ifdef __BIG_ENDIAN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_swap =3D RE=
G_SET_FIELD(fb_swap, GRPH_SWAP_CNTL, GRPH_ENDIAN_SWAP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ENDIA=
N_8IN32);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR=
(&quot;Unsupported screen format %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_get_format_name(target_fb-&gt;format-&gt;for=
mat, &amp;format_name));<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v8_0.c<br>
&gt; index 012e0a9ae0ff..0e2fc1ac475f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; @@ -1929,6 +1929,14 @@ static int dce_v8_0_crtc_do_set_base(struct drm=
_crtc *crtc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Greate=
r 8 bpc fb needs to bypass hw-lut to retain precision */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bypass_lu=
t =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_XBGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_ABGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_format =3D =
((GRPH_DEPTH_32BPP &lt;&lt; GRPH_CONTROL__GRPH_DEPTH__SHIFT) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (GRPH_FORMAT_ARGB8888 &lt;&lt; GRPH_CONTROL__G=
RPH_FORMAT__SHIFT)); /* Hack */<br>
&gt; +#ifdef __BIG_ENDIAN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_swap =3D (G=
RPH_ENDIAN_8IN32 &lt;&lt; GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR=
(&quot;Unsupported screen format %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_get_format_name(target_fb-&gt;format-&gt;for=
mat, &amp;format_name));<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 63c67346d316..6c10fa291150 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -1824,6 +1824,10 @@ static int fill_plane_attributes_from_fb(struct=
 amdgpu_device *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_ABGR2101010:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plane_sta=
te-&gt;format =3D SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_XBGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_ABGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plane_state-&g=
t;format =3D SURFACE_PIXEL_FORMAT_GRPH_ABGR8888;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_NV21:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plane_sta=
te-&gt;format =3D SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; @@ -3115,6 +3119,8 @@ static const uint32_t rgb_formats[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_XBGR2101010,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_ARGB2101010,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_ABGR2101010,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_XBGR8888,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_FORMAT_ABGR8888,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static const uint32_t yuv_formats[] =3D {<br>
&gt; diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/=
radeon/atombios_crtc.c<br>
&gt; index 02baaaf20e9d..b954b3658a33 100644<br>
&gt; --- a/drivers/gpu/drm/radeon/atombios_crtc.c<br>
&gt; +++ b/drivers/gpu/drm/radeon/atombios_crtc.c<br>
&gt; @@ -1259,6 +1259,14 @@ static int dce4_crtc_do_set_base(struct drm_crt=
c *crtc,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Greate=
r 8 bpc fb needs to bypass hw-lut to retain precision */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bypass_lu=
t =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_XBGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0case DRM_FORMAT_ABGR8888:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_format =3D =
(EVERGREEN_GRPH_DEPTH(EVERGREEN_GRPH_DEPTH_32BPP) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 EVERGREEN_GRPH_FORMAT(EVERGREEN_GRPH_FORMAT_AR=
GB8888));<br>
&gt; +#ifdef __BIG_ENDIAN<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fb_swap =3D EV=
ERGREEN_GRPH_ENDIAN_SWAP(EVERGREEN_GRPH_ENDIAN_8IN32);<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR=
(&quot;Unsupported screen format %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0drm_get_format_name(target_fb-&gt;format-&gt;for=
mat, &amp;format_name));<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--00000000000048dc90057136426c--

--===============0618259371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0618259371==--
