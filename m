From: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Use pixel encoding 444 for dongle usb-c
 to hdmi
Date: Tue, 8 Oct 2019 09:06:40 -0700
Message-ID: <CAHWPjbWcdhnewEN8OEUgDu5aBpYBW5tUggA_KJ_BUR8JLvCsQw@mail.gmail.com>
References: <20191001222123.2392-1-jisorce@oblong.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1622347671=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191001222123.2392-1-jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1622347671==
Content-Type: multipart/alternative; boundary="000000000000503e320594685bfa"

--000000000000503e320594685bfa
Content-Type: text/plain; charset="UTF-8"

Hi,

Gentle ping ?

Thx
Julien

On Tue, Oct 1, 2019 at 3:21 PM Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Fix pinkish color issue around grey areas. This also happens
> when not using any dongle so directly with a usb-c to Display
> Port cable. Meaning there is something wrong when using pixel
> encoding RGB with amd driver in the general case. In the meantime
> just use the same pixel encoding as when using HDMI without dongle.
> This way users will see the same thing on 2 identical screens when
> one is connected with hdmi-to-hdmi and the other is connected with
> usb-c-to-hdmi.
>
> Signed-off-by: Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d3f404f097eb..8139dcc0bfba 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3313,6 +3313,7 @@ static void
> fill_stream_properties_from_drm_display_mode(
>  {
>         struct dc_crtc_timing *timing_out = &stream->timing;
>         const struct drm_display_info *info = &connector->display_info;
> +       const struct dc_link *link = stream->sink->link;
>
>         memset(timing_out, 0, sizeof(struct dc_crtc_timing));
>
> @@ -3327,6 +3328,10 @@ static void
> fill_stream_properties_from_drm_display_mode(
>         else if ((connector->display_info.color_formats &
> DRM_COLOR_FORMAT_YCRCB444)
>                         && stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
>                 timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
> +       else if ((connector->display_info.color_formats &
> DRM_COLOR_FORMAT_YCRCB444)
> +                       && stream->sink->sink_signal ==
> SIGNAL_TYPE_DISPLAY_PORT
> +                       && link->dpcd_caps.dongle_type ==
> DISPLAY_DONGLE_DP_HDMI_CONVERTER)
> +               timing_out->pixel_encoding = PIXEL_ENCODING_YCBCR444;
>         else
>                 timing_out->pixel_encoding = PIXEL_ENCODING_RGB;
>
> --
> 2.17.1
>
>

--000000000000503e320594685bfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Gentle ping ?</div><div>=
<br></div><div>Thx</div><div>Julien</div><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Tue, Oct 1, 2019 at 3:21 PM Julien Is=
orce &lt;<a href=3D"mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Fix pinkish color issue around grey areas. This also happens<br>
when not using any dongle so directly with a usb-c to Display<br>
Port cable. Meaning there is something wrong when using pixel<br>
encoding RGB with amd driver in the general case. In the meantime<br>
just use the same pixel encoding as when using HDMI without dongle.<br>
This way users will see the same thing on 2 identical screens when<br>
one is connected with hdmi-to-hdmi and the other is connected with<br>
usb-c-to-hdmi.<br>
<br>
Signed-off-by: Julien Isorce &lt;<a href=3D"mailto:jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org" targ=
et=3D"_blank">jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index d3f404f097eb..8139dcc0bfba 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -3313,6 +3313,7 @@ static void fill_stream_properties_from_drm_display_m=
ode(<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc_crtc_timing *timing_out =3D &amp;stre=
am-&gt;timing;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct drm_display_info *info =3D &amp;co=
nnector-&gt;display_info;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct dc_link *link =3D stream-&gt;sink-=
&gt;link;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(timing_out, 0, sizeof(struct dc_crtc_tim=
ing));<br>
<br>
@@ -3327,6 +3328,10 @@ static void fill_stream_properties_from_drm_display_=
mode(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if ((connector-&gt;display_info.color_form=
ats &amp; DRM_COLOR_FORMAT_YCRCB444)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;&amp; stream-&gt;signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timing_out-&gt;pixe=
l_encoding =3D PIXEL_ENCODING_YCBCR444;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else if ((connector-&gt;display_info.color_form=
ats &amp; DRM_COLOR_FORMAT_YCRCB444)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; stream-&gt;sink-&gt;sink_signal =3D=3D SIGNAL_TYPE_DIS=
PLAY_PORT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;&amp; link-&gt;dpcd_caps.dongle_type =3D=3D DISPLAY_DONGLE_D=
P_HDMI_CONVERTER)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timing_out-&gt;pixe=
l_encoding =3D PIXEL_ENCODING_YCBCR444;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timing_out-&gt;pixe=
l_encoding =3D PIXEL_ENCODING_RGB;<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote></div></div>

--000000000000503e320594685bfa--

--===============1622347671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1622347671==--
