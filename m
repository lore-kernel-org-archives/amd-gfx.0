From: "Lin, Wayne" <Wayne.Lin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/drm_edid: correct VIC and HDMI_VIC under HDMI 2.0
Date: Fri, 4 Oct 2019 10:41:20 +0000
Message-ID: <DM6PR12MB413716E6DDB63FFF06C8F193FC9E0@DM6PR12MB4137.namprd12.prod.outlook.com>
References: <20190924052621.6851-1-Wayne.Lin@amd.com>
 <20191002115807.GT1208@intel.com>
 <DM6PR12MB41378F46947DCC2C46494AC8FC9F0@DM6PR12MB4137.namprd12.prod.outlook.com>,
 <20191003132951.GE1208@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1791011724=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191003132951.GE1208-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>

--===============1791011724==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB413716E6DDB63FFF06C8F193FC9E0DM6PR12MB4137namp_"

--_000_DM6PR12MB413716E6DDB63FFF06C8F193FC9E0DM6PR12MB4137namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Ville Syrj=E4l=E4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sent: Thursday, October 3, 2019 21:29
To: Lin, Wayne <Wayne.Lin-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Li, Sun peng (Le=
o) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>; Kazlauskas, Nicholas <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/drm_edid: correct VIC and HDMI_VIC under HDMI 2.0

On Thu, Oct 03, 2019 at 06:49:05AM +0000, Lin, Wayne wrote:
>
>
> ________________________________
> From: Ville Syrj=E4l=E4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Sent: Wednesday, October 2, 2019 19:58
> To: Lin, Wayne <Wayne.Lin-5C7GfCeVMHo@public.gmane.org>
> Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Li, Sun peng (=
Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>; Kazlauskas, Nicholas <Nicholas.Kazlauskas-urvtwAKJhsc@public.gmane.org=
m>
> Subject: Re: [PATCH] drm/drm_edid: correct VIC and HDMI_VIC under HDMI 2.=
0
>
> On Tue, Sep 24, 2019 at 01:26:21PM +0800, Wayne Lin wrote:
> > In HDMI 1.4 defines 4k modes without specific aspect ratio.
> > However, in HDMI 2.0, adds aspect ratio attribute to distinguish differ=
ent
> > 4k modes.
> >
> > According to Appendix E of HDMI 2.0 spec, source should use VSIF to
> > indicate VIC mode only when the mode is one defined in HDMI 1.4b 4K mod=
es.
> > Otherwise, use AVI infoframes to convey VIC.
> >
> > eg: VIC_103 should use AVI infoframes and VIC_93 use VSIF
> >
> > When the sink is HDMI 2.0, current code in
> > drm_hdmi_avi_infoframe_from_display_mode will also force mode VIC_103 t=
o
> > have VIC value 0. This violates the spec and needs to be corrected.
>
> > Where is that being done? We only set the AVI VIC to zero if we're goin=
g
> > to use the HDMI VIC instead.
>
> Appreciate for your time and apologize for not explaining it clearly.
> Current code in drm_hdmi_avi_infoframe_from_display_mode() will call
> drm_match_hdmi_mode() to set up vendor_if_vic. By checking
> drm_valid_hdmi_vic(vendor_if_vic) to see if the vic info should be convey=
ed by avi
> or not.
>
> But in drm_match_hdmi_mode(), code doesn't enable match_flags with
> DRM_MODE_MATCH_ASPECT_RATIO. I think it's due to HDMI1.4b doesn't specify
> 4K mode conveyed by HDMI VIC with particular aspect ratio. But in Appendi=
x E of
> HDMI 2.0 spec, it specify only 4k modes with particular aspect ratio shou=
ld use VSIF to convey.
> Hence, when the sink support HDMI 2.0 and set the mode to be VIC_103, cal=
ling
> drm_match_hdmi_mode(mode) will return vendor_if_vic =3D 3 (VIC_93 and VIC=
_103 are having
> the same timing but different aspect ratio). Thereafter will set the  fra=
me->video_code to 0.
> However, VIC_103 should use AVI VIC according to HDMI 2.0 spec (only VIC:=
 93, 94, 95 &
> 98 should use VSIF).
>
> This patch try to revise that, when the sink support HDMI 2.0, drm_match_=
hdmi_mode()
> should also take aspect ratio into consideration.
> But for easy reading, I add another function "drm_match_hdmi_1_4_mode" to=
 do so.

> Seems rather convoluted. I think we should just add the aspect ratios
> to edid_4k_modes[]. Or is there some problem with that approach?

Thanks for your time.

Since HDMI 1.4b doesn't require edid_4k_modes[] with specific aspect ratio,=
 modes as the same
timing in edid_4k_modes[] but with different aspect ratios are also expecte=
d to convey VIC by
VSIF to HDMI 1.4 sink. Might can't guarantee that there wont't be any compa=
tibility side effect with
that approach when the sink is HDMI 1.4b .

>
> > The same situation occurs in drm_hdmi_vendor_infoframe_from_display_mod=
e
> > and should set HDMI_VIC when the mode is one defined in HDMI 1.4b 4K
> > modes.
>
> > Yes, and we do that. "vic =3D drm_match_hdmi_mode(mode);"
>
> > Apart from adding the aspect ratios I don't really understand what
> > you're trying to achieve here.
>
> For HDMI 2.0 sink, drm_match_hdmi_mode() should also take aspect ratio in=
to consideration.
> Once again, very appreciate for your time.
>
> > ---
> >  drivers/gpu/drm/drm_edid.c | 95 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 92 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 649cfd8b4200..0fea9bf4ec67 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -1306,6 +1306,37 @@ static const struct drm_display_mode edid_4k_mod=
es[] =3D {
> >          .vrefresh =3D 24, },
> >  };
> >
> > +/*
> > + * 4k modes of HDMI 1.4 defined in HDMI 2.0. Index using the VIC.
> > + */
> > +static const struct drm_display_mode hdmi_1_4_edid_4k_modes[] =3D {
> > +     /* 0 - dummy, VICs start at 1 */
> > +     { },
> > +     /* 1 - 3840x2160@30Hz */
> > +     { DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 297000,
> > +                3840, 4016, 4104, 4400, 0,
> > +                2160, 2168, 2178, 2250, 0,
> > +                DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > +       .vrefresh =3D 30, .picture_aspect_ratio =3D HDMI_PICTURE_ASPECT=
_16_9, },
> > +     /* 2 - 3840x2160@25Hz */
> > +     { DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 297000,
> > +                3840, 4896, 4984, 5280, 0,
> > +                2160, 2168, 2178, 2250, 0,
> > +                DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > +       .vrefresh =3D 25, .picture_aspect_ratio =3D HDMI_PICTURE_ASPECT=
_16_9, },
> > +     /* 3 - 3840x2160@24Hz */
> > +     { DRM_MODE("3840x2160", DRM_MODE_TYPE_DRIVER, 297000,
> > +                3840, 5116, 5204, 5500, 0,
> > +                2160, 2168, 2178, 2250, 0,
> > +                DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > +       .vrefresh =3D 24, .picture_aspect_ratio =3D HDMI_PICTURE_ASPECT=
_16_9, },
> > +     /* 4 - 4096x2160@24Hz (SMPTE) */
> > +     { DRM_MODE("4096x2160", DRM_MODE_TYPE_DRIVER, 297000,
> > +                4096, 5116, 5204, 5500, 0,
> > +                2160, 2168, 2178, 2250, 0,
> > +                DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
> > +       .vrefresh =3D 24, .picture_aspect_ratio =3D HDMI_PICTURE_ASPECT=
_256_135, },
> > +};
> >  /*** DDC fetch and block validation ***/
> >
> >  static const u8 edid_header[] =3D {
> > @@ -3061,6 +3092,19 @@ hdmi_mode_alternate_clock(const struct drm_displ=
ay_mode *hdmi_mode)
> >        return cea_mode_alternate_clock(hdmi_mode);
> >  }
> >
> > +/*
> > + * Calculate the alternate clock for HDMI modes (those from the HDMI v=
endor
> > + * specific block).
> > + *
> > + * It's almost like hdmi_mode_alternate_clock(), but no exception for =
VIC 4 mode.
> > + * There is an alternate clock (23.98Hz) of VIC 4 mode (4096x2160@24Hz=
) in HDMI 2.0
> > + */
> > +static unsigned int
> > +hdmi_1_4_mode_alternate_clock(const struct drm_display_mode *hdmi_mode=
)
> > +{
> > +     return cea_mode_alternate_clock(hdmi_mode);
> > +}
> > +
> >  static u8 drm_match_hdmi_mode_clock_tolerance(const struct drm_display=
_mode *to_match,
> >                                              unsigned int clock_toleran=
ce)
> >  {
> > @@ -3121,11 +3165,53 @@ static u8 drm_match_hdmi_mode(const struct drm_=
display_mode *to_match)
> >        return 0;
> >  }
> >
> > +/*
> > + * drm_match_hdmi_1_4_mode - look for a HDMI 1.4 mode matching given m=
ode
> > + * @to_match: display mode
> > + *
> > + * An HDMI mode is one defined in the HDMI vendor specific block.
> > + * In HDMI 2.0, only few 4k resolutions with specific aspect ratio sho=
uld
> > + * utilize H14b VSIF.
> > + *
> > + * Returns the HDMI Video ID (VIC) of the mode or 0 if it isn't one.
> > + */
> > +static u8 drm_match_hdmi_1_4_mode(const struct drm_display_mode *to_ma=
tch)
> > +{
> > +     unsigned int match_flags =3D DRM_MODE_MATCH_TIMINGS | DRM_MODE_MA=
TCH_FLAGS;
> > +     u8 vic;
> > +
> > +     if (!to_match->clock)
> > +             return 0;
> > +
> > +     if (to_match->picture_aspect_ratio)
> > +             match_flags |=3D DRM_MODE_MATCH_ASPECT_RATIO;
> > +
> > +     for (vic =3D 1; vic < ARRAY_SIZE(hdmi_1_4_edid_4k_modes); vic++) =
{
> > +             const struct drm_display_mode *hdmi_1_4_mode =3D &hdmi_1_=
4_edid_4k_modes[vic];
> > +             unsigned int clock1, clock2;
> > +
> > +             /* Make sure to also match alternate clocks */
> > +             clock1 =3D hdmi_1_4_mode->clock;
> > +             clock2 =3D hdmi_1_4_mode_alternate_clock(hdmi_1_4_mode);
> > +
> > +             if ((KHZ2PICOS(to_match->clock) =3D=3D KHZ2PICOS(clock1) =
||
> > +                  KHZ2PICOS(to_match->clock) =3D=3D KHZ2PICOS(clock2))=
 &&
> > +                 drm_mode_match(to_match, hdmi_1_4_mode, match_flags))
> > +                     return vic;
> > +     }
> > +     return 0;
> > +}
> > +
> >  static bool drm_valid_hdmi_vic(u8 vic)
> >  {
> >        return vic > 0 && vic < ARRAY_SIZE(edid_4k_modes);
> >  }
> >
> > +static bool drm_valid_hdmi_1_4_vic(u8 vic)
> > +{
> > +     return vic > 0 && vic < ARRAY_SIZE(hdmi_1_4_edid_4k_modes);
> > +}
> > +
> >  static int
> >  add_alternate_cea_modes(struct drm_connector *connector, struct edid *=
edid)
> >  {
> > @@ -4894,10 +4980,12 @@ drm_hdmi_avi_infoframe_from_display_mode(struct=
 hdmi_avi_infoframe *frame,
> >         * HDMI 1.4b 4K modes
> >         */
> >        if (frame->video_code) {
> > -             u8 vendor_if_vic =3D drm_match_hdmi_mode(mode);
> > +             u8 vendor_if_vic =3D is_hdmi2_sink(connector) ?
> > +                     drm_match_hdmi_1_4_mode(mode) : drm_match_hdmi_mo=
de(mode);
> >                bool is_s3d =3D mode->flags & DRM_MODE_FLAG_3D_MASK;
> >
> > -             if (drm_valid_hdmi_vic(vendor_if_vic) && !is_s3d)
> > +             if (!is_s3d && is_hdmi2_sink(connector) ?
> > +                     drm_valid_hdmi_1_4_vic(vendor_if_vic) : drm_valid=
_hdmi_vic(vendor_if_vic))
> >                        frame->video_code =3D 0;
> >        }
> >
> > @@ -5125,7 +5213,8 @@ drm_hdmi_vendor_infoframe_from_display_mode(struc=
t hdmi_vendor_infoframe *frame,
> >        if (!has_hdmi_infoframe)
> >                return -EINVAL;
> >
> > -     vic =3D drm_match_hdmi_mode(mode);
> > +     vic =3D is_hdmi2_sink(connector) ?
> > +                     drm_match_hdmi_1_4_mode(mode) : drm_match_hdmi_mo=
de(mode);
> >        s3d_flags =3D mode->flags & DRM_MODE_FLAG_3D_MASK;
> >
> >        /*
> > --
> > 2.17.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Ville Syrj=E4l=E4
> Intel

> --
> Ville Syrj=E4l=E4
> Intel

--
Best regards,
Wayne Lin

--_000_DM6PR12MB413716E6DDB63FFF06C8F193FC9E0DM6PR12MB4137namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Ville Syrj=E4l=E4 &lt=
;ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 3, 2019 21:29<br>
<b>To:</b> Lin, Wayne &lt;Wayne.Lin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt=
;; Li, Sun peng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; Kazlauskas, Nicholas &lt;=
Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/drm_edid: correct VIC and HDMI_VIC under HD=
MI 2.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Thu, Oct 03, 2019 at 06:49:05AM &#43;0000, Lin,=
 Wayne wrote:<br>
&gt; <br>
&gt; <br>
&gt; ________________________________<br>
&gt; From: Ville Syrj=E4l=E4 &lt;ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org&gt;<br>
&gt; Sent: Wednesday, October 2, 2019 19:58<br>
&gt; To: Lin, Wayne &lt;Wayne.Lin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;;=
 Li, Sun peng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; Kazlauskas, Nicholas &lt;Ni=
cholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH] drm/drm_edid: correct VIC and HDMI_VIC under HDMI=
 2.0<br>
&gt; <br>
&gt; On Tue, Sep 24, 2019 at 01:26:21PM &#43;0800, Wayne Lin wrote:<br>
&gt; &gt; In HDMI 1.4 defines 4k modes without specific aspect ratio.<br>
&gt; &gt; However, in HDMI 2.0, adds aspect ratio attribute to distinguish =
different<br>
&gt; &gt; 4k modes.<br>
&gt; &gt;<br>
&gt; &gt; According to Appendix E of HDMI 2.0 spec, source should use VSIF =
to<br>
&gt; &gt; indicate VIC mode only when the mode is one defined in HDMI 1.4b =
4K modes.<br>
&gt; &gt; Otherwise, use AVI infoframes to convey VIC.<br>
&gt; &gt;<br>
&gt; &gt; eg: VIC_103 should use AVI infoframes and VIC_93 use VSIF<br>
&gt; &gt;<br>
&gt; &gt; When the sink is HDMI 2.0, current code in<br>
&gt; &gt; drm_hdmi_avi_infoframe_from_display_mode will also force mode VIC=
_103 to<br>
&gt; &gt; have VIC value 0. This violates the spec and needs to be correcte=
d.<br>
&gt; <br>
&gt; &gt; Where is that being done? We only set the AVI VIC to zero if we'r=
e going<br>
&gt; &gt; to use the HDMI VIC instead.<br>
&gt; <br>
&gt; Appreciate for your time and apologize for not explaining it clearly.<=
br>
&gt; Current code in drm_hdmi_avi_infoframe_from_display_mode() will call<b=
r>
&gt; drm_match_hdmi_mode() to set up vendor_if_vic. By checking<br>
&gt; drm_valid_hdmi_vic(vendor_if_vic) to see if the vic info should be con=
veyed by avi<br>
&gt; or not.<br>
&gt; <br>
&gt; But in drm_match_hdmi_mode(), code doesn't enable match_flags with<br>
&gt; DRM_MODE_MATCH_ASPECT_RATIO. I think it's due to HDMI1.4b doesn't spec=
ify<br>
&gt; 4K mode conveyed by HDMI VIC with particular aspect ratio. But in Appe=
ndix E of<br>
&gt; HDMI 2.0 spec, it specify only 4k modes with particular aspect ratio s=
hould use VSIF to convey.<br>
&gt; Hence, when the sink support HDMI 2.0 and set the mode to be VIC_103, =
calling<br>
&gt; drm_match_hdmi_mode(mode) will return vendor_if_vic =3D 3 (VIC_93 and =
VIC_103 are having<br>
&gt; the same timing but different aspect ratio). Thereafter will set the&n=
bsp; frame-&gt;video_code to 0.<br>
&gt; However, VIC_103 should use AVI VIC according to HDMI 2.0 spec (only V=
IC: 93, 94, 95 &amp;<br>
&gt; 98 should use VSIF).<br>
&gt; <br>
&gt; This patch try to revise that, when the sink support HDMI 2.0, drm_mat=
ch_hdmi_mode()<br>
&gt; should also take aspect ratio into consideration.<br>
&gt; But for easy reading, I add another function &quot;drm_match_hdmi_1_4_=
mode&quot; to do so.<br>
<br>
&gt; Seems rather convoluted. I think we should just add the aspect ratios<=
br>
&gt; to edid_4k_modes[]. Or is there some problem with that approach?</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Thanks for your time.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Since HDMI 1.4b doesn't require&nbsp;<span style=
=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quo=
t;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 255, 255); d=
isplay: inline !important">edid_4k_modes[]
 with specific aspect ratio, modes as the same</span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; bac=
kground-color: rgb(255, 255, 255); display: inline !important">timing in&nb=
sp;<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (We=
st European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont=
, Roboto, &quot;Helvetica Neue&quot;, sans-serif; background-color: rgb(255=
, 255, 255); display: inline !important">edid_4k_modes[]
 but with different aspect ratios are also expected to convey VIC by</span>=
</span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; bac=
kground-color: rgb(255, 255, 255); display: inline !important"><span style=
=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&q=
uot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quo=
t;Helvetica Neue&quot;, sans-serif; background-color: rgb(255, 255, 255); d=
isplay: inline !important">VSIF
 to HDMI 1.4 sink. Might c</span></span><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif;">an't guarantee&nbsp;</span><span style=3D"font-family: &quot;S=
egoe UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quo=
t;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, =
sans-serif;">that
 there&nbsp;</span><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;=
Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, Bl=
inkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;">wont't b=
e any compatibility side effect
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif;">
with&nbsp;</span></span></div>
<div class=3D"PlainText"><span style=3D"font-family: &quot;Segoe UI&quot;, =
&quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syst=
em, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif;"><s=
pan style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West Eu=
ropean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Rob=
oto, &quot;Helvetica Neue&quot;, sans-serif;">that
 approach&nbsp;</span>when&nbsp;</span>the sink is HDMI 1.4b .</div>
<div class=3D"PlainText"><br>
&gt; <br>
&gt; &gt; The same situation occurs in drm_hdmi_vendor_infoframe_from_displ=
ay_mode<br>
&gt; &gt; and should set HDMI_VIC when the mode is one defined in HDMI 1.4b=
 4K<br>
&gt; &gt; modes.<br>
&gt; <br>
&gt; &gt; Yes, and we do that. &quot;vic =3D drm_match_hdmi_mode(mode);&quo=
t;<br>
&gt; <br>
&gt; &gt; Apart from adding the aspect ratios I don't really understand wha=
t<br>
&gt; &gt; you're trying to achieve here.<br>
&gt; <br>
&gt; For HDMI 2.0 sink, drm_match_hdmi_mode() should also take aspect ratio=
 into consideration.<br>
&gt; Once again, very appreciate for your time.<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/drm_edid.c | 95 &#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;--<br>
&gt; &gt;&nbsp; 1 file changed, 92 insertions(&#43;), 3 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edi=
d.c<br>
&gt; &gt; index 649cfd8b4200..0fea9bf4ec67 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/drm_edid.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/drm_edid.c<br>
&gt; &gt; @@ -1306,6 &#43;1306,37 @@ static const struct drm_display_mode e=
did_4k_modes[] =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vrefresh =
=3D 24, },<br>
&gt; &gt;&nbsp; };<br>
&gt; &gt;<br>
&gt; &gt; &#43;/*<br>
&gt; &gt; &#43; * 4k modes of HDMI 1.4 defined in HDMI 2.0. Index using the=
 VIC.<br>
&gt; &gt; &#43; */<br>
&gt; &gt; &#43;static const struct drm_display_mode hdmi_1_4_edid_4k_modes[=
] =3D {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* 0 - dummy, VICs start at 1 */<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { },<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* 1 - 3840x2160@30Hz */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE(&quot;3840x2160&quot;, D=
RM_MODE_TYPE_DRIVER, 297000,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3840, 4016, 4104, 4400, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2160, 2168, 2178, 2250, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC)=
,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vrefresh =3D 30, .pict=
ure_aspect_ratio =3D HDMI_PICTURE_ASPECT_16_9, },<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* 2 - 3840x2160@25Hz */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE(&quot;3840x2160&quot;, D=
RM_MODE_TYPE_DRIVER, 297000,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3840, 4896, 4984, 5280, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2160, 2168, 2178, 2250, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC)=
,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vrefresh =3D 25, .pict=
ure_aspect_ratio =3D HDMI_PICTURE_ASPECT_16_9, },<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* 3 - 3840x2160@24Hz */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE(&quot;3840x2160&quot;, D=
RM_MODE_TYPE_DRIVER, 297000,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3840, 5116, 5204, 5500, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2160, 2168, 2178, 2250, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC)=
,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vrefresh =3D 24, .pict=
ure_aspect_ratio =3D HDMI_PICTURE_ASPECT_16_9, },<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* 4 - 4096x2160@24Hz (SMPTE) */<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE(&quot;4096x2160&quot;, D=
RM_MODE_TYPE_DRIVER, 297000,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4096, 5116, 5204, 5500, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2160, 2168, 2178, 2250, 0,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC)=
,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .vrefresh =3D 24, .pict=
ure_aspect_ratio =3D HDMI_PICTURE_ASPECT_256_135, },<br>
&gt; &gt; &#43;};<br>
&gt; &gt;&nbsp; /*** DDC fetch and block validation ***/<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; static const u8 edid_header[] =3D {<br>
&gt; &gt; @@ -3061,6 &#43;3092,19 @@ hdmi_mode_alternate_clock(const struct=
 drm_display_mode *hdmi_mode)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cea_mode_alterna=
te_clock(hdmi_mode);<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;/*<br>
&gt; &gt; &#43; * Calculate the alternate clock for HDMI modes (those from =
the HDMI vendor<br>
&gt; &gt; &#43; * specific block).<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * It's almost like hdmi_mode_alternate_clock(), but no exce=
ption for VIC 4 mode.<br>
&gt; &gt; &#43; * There is an alternate clock (23.98Hz) of VIC 4 mode (4096=
x2160@24Hz) in HDMI 2.0<br>
&gt; &gt; &#43; */<br>
&gt; &gt; &#43;static unsigned int<br>
&gt; &gt; &#43;hdmi_1_4_mode_alternate_clock(const struct drm_display_mode =
*hdmi_mode)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return cea_mode_alternate_clock(hdm=
i_mode);<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static u8 drm_match_hdmi_mode_clock_tolerance(const struct =
drm_display_mode *to_match,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int clock_t=
olerance)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt; @@ -3121,11 &#43;3165,53 @@ static u8 drm_match_hdmi_mode(const s=
truct drm_display_mode *to_match)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;/*<br>
&gt; &gt; &#43; * drm_match_hdmi_1_4_mode - look for a HDMI 1.4 mode matchi=
ng given mode<br>
&gt; &gt; &#43; * @to_match: display mode<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * An HDMI mode is one defined in the HDMI vendor specific b=
lock.<br>
&gt; &gt; &#43; * In HDMI 2.0, only few 4k resolutions with specific aspect=
 ratio should<br>
&gt; &gt; &#43; * utilize H14b VSIF.<br>
&gt; &gt; &#43; *<br>
&gt; &gt; &#43; * Returns the HDMI Video ID (VIC) of the mode or 0 if it is=
n't one.<br>
&gt; &gt; &#43; */<br>
&gt; &gt; &#43;static u8 drm_match_hdmi_1_4_mode(const struct drm_display_m=
ode *to_match)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int match_flags =3D DRM_MO=
DE_MATCH_TIMINGS | DRM_MODE_MATCH_FLAGS;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u8 vic;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (!to_match-&gt;clock)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return 0;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (to_match-&gt;picture_aspect_rat=
io)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; match_flags |=3D DRM_MODE_MATCH_ASPECT_RATIO;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (vic =3D 1; vic &lt; ARRAY_SIZE=
(hdmi_1_4_edid_4k_modes); vic&#43;&#43;) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; const struct drm_display_mode *hdmi_1_4_mode =3D &amp;hdmi_1_4=
_edid_4k_modes[vic];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; unsigned int clock1, clock2;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* Make sure to also match alternate clocks */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; clock1 =3D hdmi_1_4_mode-&gt;clock;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; clock2 =3D hdmi_1_4_mode_alternate_clock(hdmi_1_4_mode);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if ((KHZ2PICOS(to_match-&gt;clock) =3D=3D KHZ2PICOS(clock1) ||=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; KHZ2PICOS(to_match-&gt;clock) =
=3D=3D KHZ2PICOS(clock2)) &amp;&amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_mode_match(to_match, hdmi_1_4_mode=
, match_flags))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vic;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static bool drm_valid_hdmi_vic(u8 vic)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return vic &gt; 0 &amp;=
&amp; vic &lt; ARRAY_SIZE(edid_4k_modes);<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;static bool drm_valid_hdmi_1_4_vic(u8 vic)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return vic &gt; 0 &amp;&amp; vic &l=
t; ARRAY_SIZE(hdmi_1_4_edid_4k_modes);<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static int<br>
&gt; &gt;&nbsp; add_alternate_cea_modes(struct drm_connector *connector, st=
ruct edid *edid)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt; @@ -4894,10 &#43;4980,12 @@ drm_hdmi_avi_infoframe_from_display_m=
ode(struct hdmi_avi_infoframe *frame,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * HDMI 1.4b 4K mo=
des<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frame-&gt;video_cod=
e) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; u8 vendor_if_vic =3D drm_match_hdmi_mode(mode);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; u8 vendor_if_vic =3D is_hdmi2_sink(connector) ?<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_match_hdmi=
_1_4_mode(mode) : drm_match_hdmi_mode(mode);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; bool is_s3d =3D mode-&gt;flags &amp; DRM_MODE_FLAG=
_3D_MASK;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (drm_valid_hdmi_vic(vendor_if_vic) &amp;&amp; !is_s3d)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if (!is_s3d &amp;&amp; is_hdmi2_sink(connector) ?<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_valid_hdmi=
_1_4_vic(vendor_if_vic) : drm_valid_hdmi_vic(vendor_if_vic))<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fr=
ame-&gt;video_code =3D 0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; @@ -5125,7 &#43;5213,8 @@ drm_hdmi_vendor_infoframe_from_display_=
mode(struct hdmi_vendor_infoframe *frame,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!has_hdmi_infoframe=
)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; vic =3D drm_match_hdmi_mode(mode);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; vic =3D is_hdmi2_sink(connector) ?<=
br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_match_hdmi=
_1_4_mode(mode) : drm_match_hdmi_mode(mode);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s3d_flags =3D mode-&gt;=
flags &amp; DRM_MODE_FLAG_3D_MASK;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &gt; --<br>
&gt; &gt; 2.17.1<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; dri-devel mailing list<br>
&gt; &gt; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-dev=
el">https://lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
&gt; <br>
&gt; --<br>
&gt; Ville Syrj=E4l=E4<br>
&gt; Intel<br>
<br>
&gt; -- <br>
&gt; Ville Syrj=E4l=E4<br>
&gt; Intel<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">--</div>
<div class=3D"PlainText">Best regards,</div>
<div class=3D"PlainText">Wayne Lin</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB413716E6DDB63FFF06C8F193FC9E0DM6PR12MB4137namp_--

--===============1791011724==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1791011724==--
