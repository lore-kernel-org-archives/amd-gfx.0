From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Use pixel encoding 444 for dongle usb-c
 to hdmi
Date: Tue, 8 Oct 2019 17:28:44 +0000
Message-ID: <DM5PR12MB1820556F9855FDC376F4B6DDF79A0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <20191001222123.2392-1-jisorce@oblong.com>,
 <CAHWPjbWcdhnewEN8OEUgDu5aBpYBW5tUggA_KJ_BUR8JLvCsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0510463134=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHWPjbWcdhnewEN8OEUgDu5aBpYBW5tUggA_KJ_BUR8JLvCsQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>

--===============0510463134==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820556F9855FDC376F4B6DDF79A0DM5PR12MB1820namp_"

--_000_DM5PR12MB1820556F9855FDC376F4B6DDF79A0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

+ some display folks.
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Julien I=
sorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, October 8, 2019 12:06 PM
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Use pixel encoding 444 for dongle usb=
-c to hdmi

Hi,

Gentle ping ?

Thx
Julien

On Tue, Oct 1, 2019 at 3:21 PM Julien Isorce <julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailt=
o:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
Fix pinkish color issue around grey areas. This also happens
when not using any dongle so directly with a usb-c to Display
Port cable. Meaning there is something wrong when using pixel
encoding RGB with amd driver in the general case. In the meantime
just use the same pixel encoding as when using HDMI without dongle.
This way users will see the same thing on 2 identical screens when
one is connected with hdmi-to-hdmi and the other is connected with
usb-c-to-hdmi.

Signed-off-by: Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org<mailto:jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>=
>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d3f404f097eb..8139dcc0bfba 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3313,6 +3313,7 @@ static void fill_stream_properties_from_drm_display_m=
ode(
 {
        struct dc_crtc_timing *timing_out =3D &stream->timing;
        const struct drm_display_info *info =3D &connector->display_info;
+       const struct dc_link *link =3D stream->sink->link;

        memset(timing_out, 0, sizeof(struct dc_crtc_timing));

@@ -3327,6 +3328,10 @@ static void fill_stream_properties_from_drm_display_=
mode(
        else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_=
YCRCB444)
                        && stream->signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)
                timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
+       else if ((connector->display_info.color_formats & DRM_COLOR_FORMAT_=
YCRCB444)
+                       && stream->sink->sink_signal =3D=3D SIGNAL_TYPE_DIS=
PLAY_PORT
+                       && link->dpcd_caps.dongle_type =3D=3D DISPLAY_DONGL=
E_DP_HDMI_CONVERTER)
+               timing_out->pixel_encoding =3D PIXEL_ENCODING_YCBCR444;
        else
                timing_out->pixel_encoding =3D PIXEL_ENCODING_RGB;

--
2.17.1


--_000_DM5PR12MB1820556F9855FDC376F4B6DDF79A0DM5PR12MB1820namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
&#43; some display folks.<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Julien Isorce &lt;julien.isor=
ce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 8, 2019 12:06 PM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Use pixel encoding 444 for don=
gle usb-c to hdmi</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">
<div>Hi,</div>
<div><br>
</div>
<div>Gentle ping ?</div>
<div><br>
</div>
<div>Thx</div>
<div>Julien</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Tue, Oct 1, 2019 at 3:21 PM Juli=
en Isorce &lt;<a href=3D"mailto:julien.isorce-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">julien.isorce@gmai=
l.com</a>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
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
&nbsp;drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 &#43;&#43;&#43;=
&#43;&#43;<br>
&nbsp;1 file changed, 5 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
index d3f404f097eb..8139dcc0bfba 100644<br>
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
@@ -3313,6 &#43;3313,7 @@ static void fill_stream_properties_from_drm_displ=
ay_mode(<br>
&nbsp;{<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct dc_crtc_timing *timing_out =3D &amp;stre=
am-&gt;timing;<br>
&nbsp; &nbsp; &nbsp; &nbsp; const struct drm_display_info *info =3D &amp;co=
nnector-&gt;display_info;<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp;const struct dc_link *link =3D stream-&gt;s=
ink-&gt;link;<br>
<br>
&nbsp; &nbsp; &nbsp; &nbsp; memset(timing_out, 0, sizeof(struct dc_crtc_tim=
ing));<br>
<br>
@@ -3327,6 &#43;3328,10 @@ static void fill_stream_properties_from_drm_disp=
lay_mode(<br>
&nbsp; &nbsp; &nbsp; &nbsp; else if ((connector-&gt;display_info.color_form=
ats &amp; DRM_COLOR_FORMAT_YCRCB444)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &amp;&amp; stream-&gt;signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; timing_out-&gt;pixe=
l_encoding =3D PIXEL_ENCODING_YCBCR444;<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp;else if ((connector-&gt;display_info.color_=
formats &amp; DRM_COLOR_FORMAT_YCRCB444)<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;&amp;&amp; stream-&gt;sink-&gt;sink_signal =3D=3D SIGNAL_TYPE_=
DISPLAY_PORT<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;&amp;&amp; link-&gt;dpcd_caps.dongle_type =3D=3D DISPLAY_DONGL=
E_DP_HDMI_CONVERTER)<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;timing_out-&gt;=
pixel_encoding =3D PIXEL_ENCODING_YCBCR444;<br>
&nbsp; &nbsp; &nbsp; &nbsp; else<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; timing_out-&gt;pixe=
l_encoding =3D PIXEL_ENCODING_RGB;<br>
<br>
-- <br>
2.17.1<br>
<br>
</blockquote>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1820556F9855FDC376F4B6DDF79A0DM5PR12MB1820namp_--

--===============0510463134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0510463134==--
