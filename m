From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: fix a signedness bugs
Date: Tue, 23 May 2017 05:36:48 +0000
Message-ID: <CY4PR12MB1687B73D93B5416B22518676FBF90@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20170516144253.vvu3i6mbx3rv5uki@mwanda>,
 <ef4ba551-a52b-d2e0-5ba4-7271ee6f4e85@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1477717354=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ef4ba551-a52b-d2e0-5ba4-7271ee6f4e85-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, JinHuiEric" <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wang,
 Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1477717354==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687B73D93B5416B22518676FBF90CY4PR12MB1687namp_"

--_000_CY4PR12MB1687B73D93B5416B22518676FBF90CY4PR12MB1687namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Patches has been applied.


Thanks.


Best Regards

Rex

________________________________
From: Huang, JinHuiEric
Sent: Friday, May 19, 2017 12:28:09 AM
To: Dan Carpenter; Deucher, Alexander; Zhu, Rex
Cc: Koenig, Christian; David Airlie; Wang, Ken; Huang, Ray; amd-gfx@lists.f=
reedesktop.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; kernel-janitors-u79uwXL29TZNg+MwTxZMZA@public.gmane.org=
l.org
Subject: Re: [PATCH] drm/amd/powerplay: fix a signedness bugs

Reviewed-by: Eric Huang <JinHuiEric.Huang-5C7GfCeVMHo@public.gmane.org>


On 2017-05-16 10:42 AM, Dan Carpenter wrote:
> Smatch complains about a signedness bug here:
>
>        vega10_hwmgr.c:4202 vega10_force_clock_level()
>        warn: always true condition '(i >=3D 0) =3D> (0-u32max >=3D 0)'
>
> Fixes: 7b52db39a4c2 ("drm/amd/powerplay: fix bug sclk/mclk level can't be=
 set on vega10.")
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index ad30f5d3a10d..2614af2f553f 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4186,7 +4186,7 @@ static int vega10_force_clock_level(struct pp_hwmgr=
 *hwmgr,
>                enum pp_clock_type type, uint32_t mask)
>   {
>        struct vega10_hwmgr *data =3D (struct vega10_hwmgr *)(hwmgr->backe=
nd);
> -     uint32_t i;
> +     int i;
>
>        if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL)
>                return -EINVAL;


--_000_CY4PR12MB1687B73D93B5416B22518676FBF90CY4PR12MB1687namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Patches has been applied.</p>
<p><br>
</p>
<p>Thanks.</p>
<p><br>
</p>
<p>Best Regards</p>
<p>Rex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang, JinHuiEric<b=
r>
<b>Sent:</b> Friday, May 19, 2017 12:28:09 AM<br>
<b>To:</b> Dan Carpenter; Deucher, Alexander; Zhu, Rex<br>
<b>Cc:</b> Koenig, Christian; David Airlie; Wang, Ken; Huang, Ray; amd-gfx@=
lists.freedesktop.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; kernel-janitors@vge=
r.kernel.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: fix a signedness bugs</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Reviewed-by: Eric Huang &lt;JinHuiEric.Huang@amd.c=
om&gt;<br>
<br>
<br>
On 2017-05-16 10:42 AM, Dan Carpenter wrote:<br>
&gt; Smatch complains about a signedness bug here:<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vega10_hwmgr.c:4202 vega10_f=
orce_clock_level()<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; warn: always true condition =
'(i &gt;=3D 0) =3D&gt; (0-u32max &gt;=3D 0)'<br>
&gt;<br>
&gt; Fixes: 7b52db39a4c2 (&quot;drm/amd/powerplay: fix bug sclk/mclk level =
can't be set on vega10.&quot;)<br>
&gt; Signed-off-by: Dan Carpenter &lt;dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index ad30f5d3a10d..2614af2f553f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4186,7 &#43;4186,7 @@ static int vega10_force_clock_level(struct p=
p_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, uint32_t mask)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_hwmgr *data =
=3D (struct vega10_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=3D=
 AMD_DPM_FORCED_LEVEL_MANUAL)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB1687B73D93B5416B22518676FBF90CY4PR12MB1687namp_--

--===============1477717354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1477717354==--
