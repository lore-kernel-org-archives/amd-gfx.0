From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ
Date: Fri, 20 Jul 2018 15:08:18 +0000
Message-ID: <BN6PR12MB18093AB1E8BDFDAE856E6C34F7510@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1531990018-29711-1-git-send-email-rex.zhu@amd.com>
 <1531990018-29711-2-git-send-email-rex.zhu@amd.com>
 <CADnq5_OiAsxsCN3KiqOggwj_vgFXDb_J7a7_GVm8GXEsWNv7RA@mail.gmail.com>
 <CY4PR12MB1687C48AD2DAAB101BC823B6FB520@CY4PR12MB1687.namprd12.prod.outlook.com>,
 <CADnq5_P=MunRPuEyqN91c0nj6DdRo7cXKw9u+TTweZKG7zJ1iw@mail.gmail.com>,
 <CY4PR12MB16876BF550336DE2751FC7CFFB510@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1520536617=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16876BF550336DE2751FC7CFFB510-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1520536617==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18093AB1E8BDFDAE856E6C34F7510BN6PR12MB1809namp_"

--_000_BN6PR12MB18093AB1E8BDFDAE856E6C34F7510BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We just check that as a way see whether we are using AZ audio (and gpu driv=
er should control ACP power) or i2s audio (and acp driver controls power). =
 In the former case, there is no structure allocated.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, July 20, 2018 6:31:50 AM
To: Alex Deucher
Cc: amd-gfx list
Subject: Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ


Hi Alex,


I am Ok with the patch in v2.

just one question,


+    if (!adev->acp.acp_cell)
+        amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, tru=
e);


Do we need to check adev->acp.acp_cell before poweron/off ACP?




Best Regards

Rex

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, July 20, 2018 12:53:37 AM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ


On Thu, Jul 19, 2018 at 11:14 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu@=
amd.com>> wrote:

>We also need to power it back up in hw_fini and suspend and then power
>it back down in resume.

Yes, this logic will be added in acp block.
In this patch, we only power down acp when it was not used and have no inpa=
ct wen s3.

But I think when the asic comes out of S3/S4, the ACP block will be powered=
 up again so it will have to be powered down again to avoid using power aft=
er resume.  So if the platform uses AZ rather than ACP, we need to handle t=
hat case and to power ACP back up on hw_fini() in case the driver gets relo=
aded.  S4 works similarly.  Something like the attached patch.

Alex



Best Regards
Rex

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
Sent: Thursday, July 19, 2018 9:56 PM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ

On Thu, Jul 19, 2018 at 4:46 AM, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org<mailto:rex.zhu@am=
d.com>> wrote:
> if board uses AZ rather than ACP, we power down acp
> through smu to save power.
>

We also need to power it back up in hw_fini and suspend and then power
it back down in resume.

Alex

> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>
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
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org<http://lists.freedesktop.org>
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org<http://freedesktop.org> lists is subject to=
 our Code of Conduct.





--_000_BN6PR12MB18093AB1E8BDFDAE856E6C34F7510BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">We just check that as a way see w=
hether we are using AZ audio (and gpu driver should control ACP power) or i=
2s audio (and acp driver controls power).&nbsp; In the former case, there i=
s no structure allocated.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&=
gt;<br>
<b>Sent:</b> Friday, July 20, 2018 6:31:50 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ=
</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Dus-ascii">
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p style=3D"margin-top:0; margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">I am Ok with the patch in v2.</p=
>
<p style=3D"margin-top:0; margin-bottom:0">just one question,</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"></p>
<div>&#43;&nbsp;&nbsp; &nbsp;if (!adev-&gt;acp.acp_cell)<br>
&#43;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;amdgpu_dpm_set_powergating_by_sm=
u(adev, AMD_IP_BLOCK_TYPE_ACP, true);</div>
<p></p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Do we need to check <span>adev-&=
gt;acp.acp_cell</span> before poweron/off ACP?</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0; margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0; margin-bottom:0">Rex<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, July 20, 2018 12:53:37 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ=
</font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Dutf-8">
<div>
<div dir=3D"ltr"><br>
<div class=3D"x_x_gmail_extra">
<div class=3D"x_x_gmail_quote">On Thu, Jul 19, 2018 at 11:14 AM, Zhu, Rex <=
span dir=3D"ltr">
&lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a=
>&gt;</span> wrote:<br>
<blockquote class=3D"x_x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-le=
ft:1px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"x_x_m_-5529052118359428029divtagdefaultwrapper" dir=3D"ltr" styl=
e=3D"font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-seri=
f">
<span class=3D"">
<p style=3D"margin-top:0; margin-bottom:0"><span style=3D"font-family:Calib=
ri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Segoe=
 UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Em=
oji&quot;,EmojiSymbols; font-size:14.6667px">&gt;We also need to power it b=
ack
 up in hw_fini and suspend and then power</span><br style=3D"font-family:Ca=
libri,Helvetica,sans-serif,EmojiFont,&quot;Apple Color Emoji&quot;,&quot;Se=
goe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android=
 Emoji&quot;,EmojiSymbols; font-size:14.6667px">
<span style=3D"font-family:Calibri,Helvetica,sans-serif,EmojiFont,&quot;App=
le Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoColorEmoji,&quot;Segoe =
UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols; font-size:14.6667px=
">&gt;it back down in resume.</span><br>
</p>
<div><br>
</div>
</span>Yes, this logic will be added in acp block.
<div>In this patch, we only power down acp when it&nbsp;was not used and ha=
ve no inpact wen s3.</div>
</div>
</div>
</blockquote>
<div><br>
</div>
<div>But I think when the asic comes out of S3/S4, the ACP block will be po=
wered up again so it will have to be powered down again to avoid using powe=
r after resume.&nbsp; So if the platform uses AZ rather than ACP, we need t=
o handle that case and to power ACP back
 up on hw_fini() in case the driver gets reloaded.&nbsp; S4 works similarly=
.&nbsp; Something like the attached patch.<br>
</div>
<div><br>
</div>
<div>Alex<br>
</div>
<div><br>
</div>
<div>&nbsp;</div>
<blockquote class=3D"x_x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-le=
ft:1px #ccc solid; padding-left:1ex">
<div dir=3D"ltr">
<div id=3D"x_x_m_-5529052118359428029divtagdefaultwrapper" dir=3D"ltr" styl=
e=3D"font-size:12pt; color:#000000; font-family:Calibri,Helvetica,sans-seri=
f">
<div><br>
</div>
<div>Best Regards</div>
<div>Rex<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block; width:98%">
<div id=3D"x_x_m_-5529052118359428029divRplyFwdMsg" dir=3D"ltr"><font face=
=3D"Calibri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>From=
:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_=
blank">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, July 19, 2018 9:56 PM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: Power down acp if board uses AZ=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_m_-5529052118359428029BodyFragment"><font size=3D"2"><spa=
n style=3D"font-size:11pt">
<div class=3D"x_x_m_-5529052118359428029PlainText">
<div>
<div class=3D"x_x_h5">On Thu, Jul 19, 2018 at 4:46 AM, Rex Zhu &lt;<a href=
=3D"mailto:rex.zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">rex.zhu-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote=
:<br>
&gt; if board uses AZ rather than ACP, we power down acp<br>
&gt; through smu to save power.<br>
&gt;<br>
<br>
We also need to power it back up in hw_fini and suspend and then power<br>
it back down in resume.<br>
<br>
Alex<br>
<br>
&gt; Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c | 8 &#43;&#43;&#43;=
&#43;&#43;---<br>
&gt;&nbsp; 1 file changed, 5 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c b/drivers/gp=
u/drm/amd/amdgpu/<wbr>amdgpu_acp.c<br>
&gt; index 71efcf3..4e18a88 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/<wbr>amdgpu_acp.c<br>
&gt; @@ -35,6 &#43;35,7 @@<br>
&gt;<br>
&gt;&nbsp; #include &quot;acp_gfx_if.h&quot;<br>
&gt;<br>
&gt; &#43;<br>
&gt;&nbsp; #define ACP_TILE_ON_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<wbr>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x03<br>
&gt;&nbsp; #define ACP_TILE_OFF_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<wbr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 0x02<br>
&gt;&nbsp; #define ACP_TILE_ON_RETAIN_REG_MASK&nbsp;&nbsp;&nbsp;<wbr>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1f<br>
&gt; @@ -289,11 &#43;290,12 @@ static int acp_hw_init(void *handle)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amd_acp_hw_init(=
adev-&gt;acp.cgs_<wbr>device,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ip_block-&gt;version-&gt;major, ip_block-&gt;version=
-&gt;minor);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* -ENODEV means board=
 uses AZ rather than ACP */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENODEV)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r =3D=3D -ENODEV) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_dpm_set_powergating_by_<wbr>smu(adev, AMD_IP_BLO=
CK_TYPE_ACP, true);<br>
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
&gt; ______________________________<wbr>_________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"x_x_m_-5529052118359428029LPlnk998837" class=3D"x_x_m_-5529052118359428=
029OWAAutoLink" target=3D"_blank">
https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a> </div>
</div>
<div id=3D"x_x_m_-5529052118359428029LPBorder_GT_15320131028380.70275485963=
7317" style=3D"margin-bottom:20px; overflow:auto; width:100%; text-indent:0=
px">
<table id=3D"x_x_m_-5529052118359428029LPContainer_15320131028280.102507348=
9385282" cellspacing=3D"0" style=3D"width:90%; background-color:rgb(255,255=
,255); overflow:auto; padding-top:20px; padding-bottom:20px; margin-top:20p=
x; border-top:1px dotted rgb(200,200,200); border-bottom:1px dotted rgb(200=
,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"x_x_m_-5529052118359428029TextCell_15320131028320.991704213554636=
8" colspan=3D"2" style=3D"vertical-align:top; padding:0px; display:table-ce=
ll">
<div id=3D"x_x_m_-5529052118359428029LPRemovePreviewContainer_1532013102832=
0.024263722967099">
</div>
<div id=3D"x_x_m_-5529052118359428029LPTitle_15320131028320.968796259693673=
7" style=3D"color:rgb(0,120,215); font-weight:normal; font-size:21px; font-=
family:wf_segoe-ui_light,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&qu=
ot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; line=
-height:21px">
<a id=3D"x_x_m_-5529052118359428029LPUrlAnchor_15320131028340.4538000273988=
081" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=
=3D"_blank" style=3D"text-decoration:none">amd-gfx Info Page - freedesktop.=
org</a></div>
<div id=3D"x_x_m_-5529052118359428029LPMetadata_15320131028350.132291096529=
70839" style=3D"margin:10px 0px 16px; color:rgb(102,102,102); font-weight:n=
ormal; font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&q=
uot;,Tahoma,Arial,sans-serif; font-size:14px; line-height:14px">
<a href=3D"http://lists.freedesktop.org" target=3D"_blank">lists.freedeskto=
p.org</a></div>
<div id=3D"x_x_m_-5529052118359428029LPDescription_15320131028370.658586957=
9202912" style=3D"display:block; color:rgb(102,102,102); font-weight:normal=
; font-family:wf_segoe-ui_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,=
Tahoma,Arial,sans-serif; font-size:14px; line-height:20px; max-height:100px=
; overflow:hidden">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all
<a href=3D"http://freedesktop.org" target=3D"_blank">freedesktop.org</a> li=
sts is subject to our Code of Conduct.</div>
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
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB18093AB1E8BDFDAE856E6C34F7510BN6PR12MB1809namp_--

--===============1520536617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1520536617==--
