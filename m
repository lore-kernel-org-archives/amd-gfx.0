From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/display: fix array lenth error.
Date: Mon, 6 Feb 2017 15:36:54 +0000
Message-ID: <CY4PR12MB168712DD6B6D2BA7E7861CB7FB400@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1486357719-7102-1-git-send-email-Rex.Zhu@amd.com>,
 <d7898cb1-cf89-6672-dd92-9ae74b168edf@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0960274201=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d7898cb1-cf89-6672-dd92-9ae74b168edf-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0960274201==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168712DD6B6D2BA7E7861CB7FB400CY4PR12MB1687namp_"

--_000_CY4PR12MB168712DD6B6D2BA7E7861CB7FB400CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

seems reasonable.


but i think need to check num_levels  can't be 0. in some case, there is on=
ly one level of mclk, and higher than the max validation clocks.. and will =
lead kernel panic.


Best Regards

Rex

________________________________
From: Wentland, Harry
Sent: Monday, February 6, 2017 10:54:24 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amd/display: fix array lenth error.

On 2017-02-06 12:08 AM, Rex Zhu wrote:
> Change-Id: I09011c5e6d5493db7e3d9a7ff7ab8c871a8db862
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b=
/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> index 5af27aa..50576c6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
> @@ -358,7 +358,7 @@ bool dm_pp_get_clock_levels_by_type(
>                                 * non-boosted one. */
>                                DRM_INFO("DM_PPLIB: reducing engine clock =
level from %d to %d\n",
>                                                dc_clks->num_levels, i + 1=
);
> -                             dc_clks->num_levels =3D i;
> +                             dc_clks->num_levels =3D i + 1;

It seems to me the DRM_INFO print is wrong here, not the actual
assignment. We're setting num_levels to the current index if the clocks
for that index are higher than the max validation clocks, hence this
index now should become num_levels.

>                                break;
>                        }
>                }
> @@ -367,7 +367,7 @@ bool dm_pp_get_clock_levels_by_type(
>                        if (dc_clks->clocks_in_khz[i] > validation_clks.me=
mory_max_clock) {
>                                DRM_INFO("DM_PPLIB: reducing memory clock =
level from %d to %d\n",
>                                                dc_clks->num_levels, i + 1=
);
> -                             dc_clks->num_levels =3D i;
> +                             dc_clks->num_levels =3D i + 1;
>                                break;
>                        }
>                }
>

Same comment as above.

Harry

--_000_CY4PR12MB168712DD6B6D2BA7E7861CB7FB400CY4PR12MB1687namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
<p>seems reasonable.</p>
<p><br>
</p>
<p>but i think need to check&nbsp;<span style=3D"color:rgb(33,33,33); font-=
size:13.3333px">num_levels &nbsp;can't be 0. in some case, there is only on=
e level of mclk, and
<span style=3D"color:rgb(33,33,33); font-size:13.3333px">higher than the ma=
x validation clocks.. and will lead kernel panic.</span></span></p>
<p><span style=3D"color:rgb(33,33,33); font-size:13.3333px"><span style=3D"=
color:rgb(33,33,33); font-size:13.3333px"><br>
</span></span></p>
<p><span style=3D"color:rgb(33,33,33); font-size:13.3333px"><span style=3D"=
color:rgb(33,33,33); font-size:13.3333px">Best Regards</span></span></p>
<p><span style=3D"color:rgb(33,33,33); font-size:13.3333px"><span style=3D"=
color:rgb(33,33,33); font-size:13.3333px">Rex</span></span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Monday, February 6, 2017 10:54:24 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/display: fix array lenth error.</fo=
nt>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 2017-02-06 12:08 AM, Rex Zhu wrote:<br>
&gt; Change-Id: I09011c5e6d5493db7e3d9a7ff7ab8c871a8db862<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c | 4 &=
#43;&#43;--<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.=
c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
&gt; index 5af27aa..50576c6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_serv=
ices.c<br>
&gt; @@ -358,7 &#43;358,7 @@ bool dm_pp_get_clock_levels_by_type(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * non-boosted one. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;DM_PPLIB: reducing =
engine clock level from %d to %d\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_clks-&gt;n=
um_levels, i &#43; 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dc_clks-&gt;num_levels =3D i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_clks-&gt;num_levels =3D i &#43; 1;<br>
<br>
It seems to me the DRM_INFO print is wrong here, not the actual<br>
assignment. We're setting num_levels to the current index if the clocks<br>
for that index are higher than the max validation clocks, hence this<br>
index now should become num_levels.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -367,7 &#43;367,7 @@ bool dm_pp_get_clock_levels_by_type(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dc_=
clks-&gt;clocks_in_khz[i] &gt; validation_clks.memory_max_clock) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;DM_PPLIB: reducing =
memory clock level from %d to %d\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_clks-&gt;n=
um_levels, i &#43; 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dc_clks-&gt;num_levels =3D i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_clks-&gt;num_levels =3D i &#43; 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
<br>
Same comment as above.<br>
<br>
Harry<br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB168712DD6B6D2BA7E7861CB7FB400CY4PR12MB1687namp_--

--===============0960274201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0960274201==--
