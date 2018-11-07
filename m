From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add "max_bpc" connector property
Date: Wed, 7 Nov 2018 15:40:23 +0000
Message-ID: <BN6PR12MB1809BB48F7B0BE5064C7B2BEF7C40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181107145655.5944-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1771517617=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181107145655.5944-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1771517617==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BB48F7B0BE5064C7B2BEF7C40BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BB48F7B0BE5064C7B2BEF7C40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

FWIW there is a common property patch:

https://patchwork.kernel.org/patch/10606697/

When should try and be compatible so we can transition.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Nicholas=
 Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 7, 2018 9:56:54 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Kazlauskas, Nicholas
Subject: [PATCH 1/2] drm/amdgpu: Add "max_bpc" connector property

[Why]
Many panels support more than 8bpc but some modes are unavailable while
running at greater than 8bpc due to DP/HDMI bandwidth constraints.

Support for more than 8bpc was added recently in the driver but it's
defaults to the maximum supported bpc - locking out these modes.

This should be a user configurable option such that the user can select
what bpc configuration they would like.

[How]
Introduce the "max_bpc" connector property so the user can limit the
maximum bpc for the panel. It ranges from 8 to 16.

This doesn't directly set the preferred bpc for the panel but this
convetion is already in use for other drivers.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c
index 7d6a36bca9dd..83dadf5b85e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -626,6 +626,11 @@ int amdgpu_display_modeset_create_props(struct amdgpu_=
device *adev)
                                          "dither",
                                          amdgpu_dither_enum_list, sz);

+       adev->mode_info.max_bpc_property =3D
+               drm_property_create_range(adev->ddev, 0, "max_bpc", 8, 16);
+       if (!adev->mode_info.max_bpc_property)
+               return -ENOMEM;
+
         if (amdgpu_device_has_dc_support(adev)) {
                 adev->mode_info.freesync_property =3D
                         drm_property_create_bool(adev->ddev, 0, "freesync"=
);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_mode.h
index 1627dd3413c7..c39af5d79608 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -338,6 +338,8 @@ struct amdgpu_mode_info {
         struct drm_property *audio_property;
         /* FMT dithering */
         struct drm_property *dither_property;
+       /* maximum number of bits per channel for monitor color */
+       struct drm_property *max_bpc_property;
         /* it is used to allow enablement of freesync mode */
         struct drm_property *freesync_property;
         /* it is used to know about display capability of freesync mode */
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809BB48F7B0BE5064C7B2BEF7C40BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">FWIW there is a common property p=
atch:<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><a href=3D"https://patchwork.kern=
el.org/patch/10606697/" class=3D"OWAAutoLink" id=3D"LPlnk586943" previewrem=
oved=3D"true">https://patchwork.kernel.org/patch/10606697/</a></p>
<p style=3D"margin-top:0;margin-bottom:0">When should try and be compatible=
 so we can transition.<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Nicholas Kazlauskas &lt;nicho=
las.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, November 7, 2018 9:56:54 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Kazlauskas, Nicholas<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Add &quot;max_bpc&quot; connector p=
roperty</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[Why]<br>
Many panels support more than 8bpc but some modes are unavailable while<br>
running at greater than 8bpc due to DP/HDMI bandwidth constraints.<br>
<br>
Support for more than 8bpc was added recently in the driver but it's<br>
defaults to the maximum supported bpc - locking out these modes.<br>
<br>
This should be a user configurable option such that the user can select<br>
what bpc configuration they would like.<br>
<br>
[How]<br>
Introduce the &quot;max_bpc&quot; connector property so the user can limit =
the<br>
maximum bpc for the panel. It ranges from 8 to 16.<br>
<br>
This doesn't directly set the preferred bpc for the panel but this<br>
convetion is already in use for other drivers.<br>
<br>
Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 5 &#43;&#43;&#43;&#43;&=
#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h&nbsp;&nbsp;&nbsp; | 2 &#43;&=
#43;<br>
&nbsp;2 files changed, 7 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_display.c<br>
index 7d6a36bca9dd..83dadf5b85e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
@@ -626,6 &#43;626,11 @@ int amdgpu_display_modeset_create_props(struct amd=
gpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; &quot;dither&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_dither_enum_list, sz);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.max_bpc_proper=
ty =3D<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; drm_property_create_range(adev-&gt;ddev, 0, &quot;max_bpc&qu=
ot;, 8, 16);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mode_info.max_bpc_p=
roperty)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ENOMEM;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_has_dc_s=
upport(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;mode_info.freesync_property =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_p=
roperty_create_bool(adev-&gt;ddev, 0, &quot;freesync&quot;);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_mode.h<br>
index 1627dd3413c7..c39af5d79608 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h<br>
@@ -338,6 &#43;338,8 @@ struct amdgpu_mode_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_property *audio=
_property;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* FMT dithering */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_property *dithe=
r_property;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* maximum number of bits per cha=
nnel for monitor color */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_property *max_bpc_prop=
erty;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* it is used to allow ena=
blement of freesync mode */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_property *frees=
ync_property;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* it is used to know abou=
t display capability of freesync mode */<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809BB48F7B0BE5064C7B2BEF7C40BN6PR12MB1809namp_--

--===============1771517617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1771517617==--
