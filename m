From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ
Date: Thu, 19 Jul 2018 15:14:43 +0000
Message-ID: <CY4PR12MB1687C48AD2DAAB101BC823B6FB520@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1531990018-29711-1-git-send-email-rex.zhu@amd.com>
 <1531990018-29711-2-git-send-email-rex.zhu@amd.com>,
 <CADnq5_OiAsxsCN3KiqOggwj_vgFXDb_J7a7_GVm8GXEsWNv7RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0603071198=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OiAsxsCN3KiqOggwj_vgFXDb_J7a7_GVm8GXEsWNv7RA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0603071198==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687C48AD2DAAB101BC823B6FB520CY4PR12MB1687namp_"

--_000_CY4PR12MB1687C48AD2DAAB101BC823B6FB520CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>We also need to power it back up in hw_fini and suspend and then power
>it back down in resume.

Yes, this logic will be added in acp block.
In this patch, we only power down acp when it was not used and have no inpa=
ct wen s3.

Best Regards
Rex

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, July 19, 2018 9:56 PM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ

On Thu, Jul 19, 2018 at 4:46 AM, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> if board uses AZ rather than ACP, we power down acp
> through smu to save power.
>

We also need to power it back up in hw_fini and suspend and then power
it back down in resume.

Alex

> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acp.c
> index 71efcf3..4e18a88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -35,6 +35,7 @@
>
>  #include "acp_gfx_if.h"
>
> +
>  #define ACP_TILE_ON_MASK                       0x03
>  #define ACP_TILE_OFF_MASK                      0x02
>  #define ACP_TILE_ON_RETAIN_REG_MASK            0x1f
> @@ -289,11 +290,12 @@ static int acp_hw_init(void *handle)
>         r =3D amd_acp_hw_init(adev->acp.cgs_device,
>                             ip_block->version->major, ip_block->version->=
minor);
>         /* -ENODEV means board uses AZ rather than ACP */
> -       if (r =3D=3D -ENODEV)
> +       if (r =3D=3D -ENODEV) {
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, true);
>                 return 0;
> -       else if (r)
> +       } else if (r) {
>                 return r;
> -
> +       }
>         if (adev->rmmio_size =3D=3D 0 || adev->rmmio_size < 0x5289)
>                 return -EINVAL;
>
> --
> 1.9.1
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




--_000_CY4PR12MB1687C48AD2DAAB101BC823B6FB520CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">&gt;We also need to=
 power
 it back up in hw_fini and suspend and then power</span><br style=3D"font-f=
amily: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&q=
uot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quo=
t;, &quot;Android Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">
<span style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quo=
t;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quo=
t;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols; font-size=
: 14.6667px;">&gt;it back down in resume.</span><br>
</p>
<div><br>
</div>
Yes, this logic will be added in acp block.
<div>In this patch, we only power down acp when it&nbsp;was not used and ha=
ve no inpact wen s3.</div>
<div><br>
</div>
<div>Best Regards</div>
<div>Rex<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, July 19, 2018 9:56 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Jul 19, 2018 at 4:46 AM, Rex Zhu &lt;rex.z=
hu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; if board uses AZ rather than ACP, we power down acp<br>
&gt; through smu to save power.<br>
&gt;<br>
<br>
We also need to power it back up in hw_fini and suspend and then power<br>
it back down in resume.<br>
<br>
Alex<br>
<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 8 &#43;&#43;&#43;&#43;=
&#43;---<br>
&gt;&nbsp; 1 file changed, 5 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acp.c<br>
&gt; index 71efcf3..4e18a88 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c<br>
&gt; @@ -35,6 &#43;35,7 @@<br>
&gt;<br>
&gt;&nbsp; #include &quot;acp_gfx_if.h&quot;<br>
&gt;<br>
&gt; &#43;<br>
&gt;&nbsp; #define ACP_TILE_ON_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x03<br>
&gt;&nbsp; #define ACP_TILE_OFF_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; 0x02<br>
&gt;&nbsp; #define ACP_TILE_ON_RETAIN_REG_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1f<br>
&gt; @@ -289,11 &#43;290,12 @@ static int acp_hw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amd_acp_hw_init(=
adev-&gt;acp.cgs_device,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ip_block-&gt;version-&gt;major, ip_block-&gt;version=
-&gt;minor);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* -ENODEV means board=
 uses AZ rather than ACP */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENODEV)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENODEV) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TY=
PE_ACP, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;rmmio_siz=
e =3D=3D 0 || adev-&gt;rmmio_size &lt; 0x5289)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk998837" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15320131028380.702754859637317" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15320131028280.1025073489385282" role=3D"presentat=
ion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255,=
 255); position: relative; overflow: auto; padding-top: 20px; padding-botto=
m: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); borde=
r-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15320131028320.9917042135546368" colspan=3D"2" style=3D"=
vertical-align: top; position: relative; padding: 0px; display: table-cell;=
">
<div id=3D"LPRemovePreviewContainer_15320131028320.024263722967099"></div>
<div id=3D"LPTitle_15320131028320.9687962596936737" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15320131028340.4538000273988081" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15320131028350.13229109652970839" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: w=
f_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Aria=
l, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15320131028370.6585869579202912" style=3D"display:=
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
</div>
</span></font></div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687C48AD2DAAB101BC823B6FB520CY4PR12MB1687namp_--

--===============0603071198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0603071198==--
