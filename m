From: "Lin, Wayne" <Wayne.Lin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/drm_connector: add additional aspect ratio values
Date: Thu, 5 Sep 2019 14:59:53 +0000
Message-ID: <MN2PR12MB2941AFD5BE06C7B10E01B3C1FCA00@MN2PR12MB2941.namprd12.prod.outlook.com>
References: <20190822215002.17836-1-waynelin@amd.com>,
 <20190823184141.GW5942@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1015931045=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190823184141.GW5942-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

--===============1015931045==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2941AFD5BE06C7B10E01B3C1FCA00MN2PR12MB2941namp_"

--_000_MN2PR12MB2941AFD5BE06C7B10E01B3C1FCA00MN2PR12MB2941namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Ville Syrj=E4l=E4 <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sent: Saturday, August 24, 2019 02:41
To: Lin, Wayne <Wayne.Lin-5C7GfCeVMHo@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; amd-=
gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Li, Sun peng (Le=
o) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>; Kazlauskas, Nicholas <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/drm_connector: add additional aspect ratio values

On Thu, Aug 22, 2019 at 05:50:02PM -0400, Wayne Lin wrote:
> For HDMI2.0 CTS item - HF1-35, it verifies if the source generates
> video timing "64:27" video format correctly.
>
> eg: (vic-76) 1920x1080p@60Hz,24bpp
>
> This patch add on "64:27" and "256:135" to drm_aspect_ratio_enum_list.
> Thereafter, one can specify the aspect ratio to "64:27" or "256:135"
> after creating aspect ratio property.
>
> Change-Id: Ifc9df54e8e8f78e70960fcd737a3a57e49c81152
> Signed-off-by: Wayne Lin <waynelin-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/drm_connector.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 3a0cacb71235..c0629a01d08e 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -772,6 +772,8 @@ static const struct drm_prop_enum_list drm_aspect_rat=
io_enum_list[] =3D {
>        { DRM_MODE_PICTURE_ASPECT_NONE, "Automatic" },
>        { DRM_MODE_PICTURE_ASPECT_4_3, "4:3" },
>        { DRM_MODE_PICTURE_ASPECT_16_9, "16:9" },
> +     { DRM_MODE_PICTURE_ASPECT_64_27, "64:27" },
> +     { DRM_MODE_PICTURE_ASPECT_256_135, "256:135" },

> Not 100% sure we want to expose these via the property because the
> infoframe can't convey these independently from the VIC.

Agree with that it can't be independent from the VIC.
When building up hdmi avi infoframe by using "drm_hdmi_avi_infoframe_from_d=
isplay_mode" in drm_edid,
it will refer to the VIC to set up the aspect ratio if the aspect ratio is =
not specified in mode.
However, if the aspect ratio is specified to a value other than none, curre=
nt logic of code will use the specified value.

The main reason of this patch is for capable indicating the exact VIC wante=
d.
There are some modes defined in CTA-861 with same timing but different aspe=
ct ratio.
eg: VIC 103 & VIC 93
Without these new definitions, we cannot distinguish these different modes =
and might set a wrong VIC in AVI infoframe.

>  };
>
>  static const struct drm_prop_enum_list drm_content_type_enum_list[] =3D =
{
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--
Ville Syrj=E4l=E4
Intel

--_000_MN2PR12MB2941AFD5BE06C7B10E01B3C1FCA00MN2PR12MB2941namp_
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
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
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
<b>Sent:</b> Saturday, August 24, 2019 02:41<br>
<b>To:</b> Lin, Wayne &lt;Wayne.Lin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt=
;; Li, Sun peng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; Kazlauskas, Nicholas &lt;=
Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/drm_connector: add additional aspect ratio =
values</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">On Thu, Aug 22, 2019 at 05:50:02PM -0400, Wayne Li=
n wrote:<br>
&gt; For HDMI2.0 CTS item - HF1-35, it verifies if the source generates<br>
&gt; video timing &quot;64:27&quot; video format correctly.<br>
&gt; <br>
&gt; eg: (vic-76) 1920x1080p@60Hz,24bpp<br>
&gt; <br>
&gt; This patch add on &quot;64:27&quot; and &quot;256:135&quot; to drm_asp=
ect_ratio_enum_list.<br>
&gt; Thereafter, one can specify the aspect ratio to &quot;64:27&quot; or &=
quot;256:135&quot;<br>
&gt; after creating aspect ratio property.<br>
&gt; <br>
&gt; Change-Id: Ifc9df54e8e8f78e70960fcd737a3a57e49c81152<br>
&gt; Signed-off-by: Wayne Lin &lt;waynelin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/drm_connector.c | 2 &#43;&#43;<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_con=
nector.c<br>
&gt; index 3a0cacb71235..c0629a01d08e 100644<br>
&gt; --- a/drivers/gpu/drm/drm_connector.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/drm_connector.c<br>
&gt; @@ -772,6 &#43;772,8 @@ static const struct drm_prop_enum_list drm_asp=
ect_ratio_enum_list[] =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE_PICTURE_ASPECT_NO=
NE, &quot;Automatic&quot; },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE_PICTURE_ASPECT_4_=
3, &quot;4:3&quot; },<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE_PICTURE_ASPECT_16=
_9, &quot;16:9&quot; },<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE_PICTURE_ASPECT_64_27, &quot;6=
4:27&quot; },<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; { DRM_MODE_PICTURE_ASPECT_256_135, &quot=
;256:135&quot; },<br>
<br>
&gt; Not 100% sure we want to expose these via the property because the<br>
&gt; infoframe can't convey these independently from the VIC.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Agree with that it can't be independent from the V=
IC.&nbsp;</div>
<div class=3D"PlainText">When building up hdmi avi infoframe by using &quot=
;drm_hdmi_avi_infoframe_from_display_mode&quot; in drm_edid,&nbsp;</div>
<div class=3D"PlainText">it will refer to the VIC to set up the aspect rati=
o if the aspect ratio is not specified in mode.</div>
<div class=3D"PlainText">However, if the aspect ratio is specified to a val=
ue other than none, current logic of code will use the specified value.&nbs=
p;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">The main reason of this patch is for capable indic=
ating the exact VIC wanted.&nbsp;</div>
<div class=3D"PlainText">There are some modes defined in CTA-861 with same =
timing but different aspect ratio.</div>
<div class=3D"PlainText">eg: VIC 103 &amp; VIC 93</div>
<div class=3D"PlainText">Without these new definitions, we cannot distingui=
sh these different modes and might set a wrong VIC in AVI infoframe.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt;&nbsp; static const struct drm_prop_enum_list drm_content_type_enum_lis=
t[] =3D {<br>
&gt; -- <br>
&gt; 2.17.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; dri-devel mailing list<br>
&gt; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/dri-devel">h=
ttps://lists.freedesktop.org/mailman/listinfo/dri-devel</a><br>
<br>
-- <br>
Ville Syrj=E4l=E4<br>
Intel<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB2941AFD5BE06C7B10E01B3C1FCA00MN2PR12MB2941namp_--

--===============1015931045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1015931045==--
