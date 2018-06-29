From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: initialize uvd/vce powergate status v3
Date: Fri, 29 Jun 2018 00:32:39 +0000
Message-ID: <CY4PR12MB16877816B6AAB49ABE9176CEFB4E0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1529476835-11315-1-git-send-email-evan.quan@amd.com>,
 <CADnq5_PM77A24XoD-XQpPD_QZ7iHrkNgXjDsDEaGZybHOa=fQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1005619561=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PM77A24XoD-XQpPD_QZ7iHrkNgXjDsDEaGZybHOa=fQg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1005619561==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16877816B6AAB49ABE9176CEFB4E0CY4PR12MB1687namp_"

--_000_CY4PR12MB16877816B6AAB49ABE9176CEFB4E0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Do we need to maintain the uvd/vce pg state in pp?

uvd/vce have maintained the pg state by themselves.

pp only provide an interface for uvd/vce/gfx/mmhub to power up/down the ip =
through smu if smu supported, concurrently enable/disable uvd/vce/mmhub dpm=
 feature.


Best Regards

Rex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, June 28, 2018 11:31 PM
To: Quan, Evan
Cc: amd-gfx list
Subject: Re: [PATCH] drm/amd/powerplay: initialize uvd/vce powergate status=
 v3

On Wed, Jun 20, 2018 at 2:40 AM, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org> wrote:
> On UVD/VCE dpm enabled/disabled, the powergate status will be
> set as false/true. So that we will not try to ungate/gate them(
> enable/disable their dpm) again.
>
> v2: added check for uvd/vce powergate status before gating
> v3: fix typo in description
>
> Change-Id: I569a5aa216b5e7d64a2b504f2ff98cc83ca802d5
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>


Does vega10 need a similar fix?

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 23 ++++++++++++++++=
++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index 45c8f2d..28b172e 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -777,6 +777,21 @@ static int vega12_set_allowed_featuresmask(struct pp=
_hwmgr *hwmgr)
>         return 0;
>  }
>
> +static void vega12_init_powergate_state(struct pp_hwmgr *hwmgr)
> +{
> +       struct vega12_hwmgr *data =3D
> +                       (struct vega12_hwmgr *)(hwmgr->backend);
> +
> +       data->uvd_power_gated =3D true;
> +       data->vce_power_gated =3D true;
> +
> +       if (data->smu_features[GNLD_DPM_UVD].enabled)
> +               data->uvd_power_gated =3D false;
> +
> +       if (data->smu_features[GNLD_DPM_VCE].enabled)
> +               data->vce_power_gated =3D false;
> +}
> +
>  static int vega12_enable_all_smu_features(struct pp_hwmgr *hwmgr)
>  {
>         struct vega12_hwmgr *data =3D
> @@ -801,6 +816,8 @@ static int vega12_enable_all_smu_features(struct pp_h=
wmgr *hwmgr)
>                 }
>         }
>
> +       vega12_init_powergate_state(hwmgr);
> +
>         return 0;
>  }
>
> @@ -1985,6 +2002,9 @@ static void vega12_power_gate_vce(struct pp_hwmgr *=
hwmgr, bool bgate)
>  {
>         struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->back=
end);
>
> +       if (data->vce_power_gated =3D=3D bgate)
> +               return 0;
> +
>         data->vce_power_gated =3D bgate;
>         vega12_enable_disable_vce_dpm(hwmgr, !bgate);
>  }
> @@ -1993,6 +2013,9 @@ static void vega12_power_gate_uvd(struct pp_hwmgr *=
hwmgr, bool bgate)
>  {
>         struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->back=
end);
>
> +       if (data->uvd_power_gated =3D=3D bgate)
> +               return 0;
> +
>         data->uvd_power_gated =3D bgate;
>         vega12_enable_disable_uvd_dpm(hwmgr, !bgate);
>  }
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.



_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB16877816B6AAB49ABE9176CEFB4E0CY4PR12MB1687namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Do we need to maintain the uvd/vc=
e pg state in pp?</p>
<p style=3D"margin-top:0;margin-bottom:0">uvd/vce have maintained the pg st=
ate by themselves.</p>
<p style=3D"margin-top:0;margin-bottom:0">pp only provide an interface for =
uvd/vce/gfx/mmhub&nbsp;to power up/down the ip through smu if smu&nbsp;supp=
orted, concurrently enable/disable uvd/vce/mmhub&nbsp;dpm feature.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex&nbsp;</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Thursday, June 28, 2018 11:31 PM<br>
<b>To:</b> Quan, Evan<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: initialize uvd/vce powergate=
 status v3</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Jun 20, 2018 at 2:40 AM, Evan Quan &lt;eva=
n.quan-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; On UVD/VCE dpm enabled/disabled, the powergate status will be<br>
&gt; set as false/true. So that we will not try to ungate/gate them(<br>
&gt; enable/disable their dpm) again.<br>
&gt;<br>
&gt; v2: added check for uvd/vce powergate status before gating<br>
&gt; v3: fix typo in description<br>
&gt;<br>
&gt; Change-Id: I569a5aa216b5e7d64a2b504f2ff98cc83ca802d5<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
<br>
Does vega10 need a similar fix?<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 23 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 1 file changed, 23 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; index 45c8f2d..28b172e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<b=
r>
&gt; @@ -777,6 &#43;777,21 @@ static int vega12_set_allowed_featuresmask(st=
ruct pp_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static void vega12_init_powergate_state(struct pp_hwmgr *hwmgr)<b=
r>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =
=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct=
 vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;uvd_power_gated =3D=
 true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;vce_power_gated =3D=
 true;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GN=
LD_DPM_UVD].enabled)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;uvd_power_gated =3D false;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;smu_features[GN=
LD_DPM_VCE].enabled)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; data-&gt;vce_power_gated =3D false;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static int vega12_enable_all_smu_features(struct pp_hwmgr *hwmgr=
)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *d=
ata =3D<br>
&gt; @@ -801,6 &#43;816,8 @@ static int vega12_enable_all_smu_features(stru=
ct pp_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_init_powergate_state(=
hwmgr);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; @@ -1985,6 &#43;2002,9 @@ static void vega12_power_gate_vce(struct pp_=
hwmgr *hwmgr, bool bgate)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *d=
ata =3D (struct vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;vce_power_gated=
 =3D=3D bgate)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;vce_power_gat=
ed =3D bgate;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_enable_disable_=
vce_dpm(hwmgr, !bgate);<br>
&gt;&nbsp; }<br>
&gt; @@ -1993,6 &#43;2013,9 @@ static void vega12_power_gate_uvd(struct pp_=
hwmgr *hwmgr, bool bgate)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *d=
ata =3D (struct vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;uvd_power_gated=
 =3D=3D bgate)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;uvd_power_gat=
ed =3D bgate;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega12_enable_disable_=
uvd_dpm(hwmgr, !bgate);<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk297351" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15302317866560.7402201292218797" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15302317866530.6923541125707908" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15302317866540.96951563183552" colspan=3D"2" style=3D"ve=
rtical-align: top; position: relative; padding: 0px; display: table-cell;">
<div id=3D"LPRemovePreviewContainer_15302317866540.27701115588335345"></div=
>
<div id=3D"LPTitle_15302317866540.3920123678910694" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15302317866550.14476511036207396" href=3D"https://list=
s.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text=
-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15302317866550.7183196487901087" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15302317866550.9720882814258935" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_seg=
oe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sa=
ns-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: =
hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of Conduct.</d=
iv>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk741007" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16877816B6AAB49ABE9176CEFB4E0CY4PR12MB1687namp_--

--===============1005619561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1005619561==--
