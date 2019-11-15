From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/soc15: move struct definition around to align
 with other soc15 asics
Date: Fri, 15 Nov 2019 16:43:00 +0000
Message-ID: <DM6PR12MB277836449EE0C8E5F07D02AFF0700@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191111222102.876704-1-alexander.deucher@amd.com>,
 <CADnq5_PRwkMfe3iN_6wD_HMZ1qFSb-vru0gYhYyK+6cjNNHQsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2063422928=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PRwkMfe3iN_6wD_HMZ1qFSb-vru0gYhYyK+6cjNNHQsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============2063422928==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_"

--_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, November 15, 2019 11:13 AM
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/soc15: move struct definition around to ali=
gn with other soc15 asics

Ping?

On Mon, Nov 11, 2019 at 5:21 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Move reset_method next to reset callback to match the struct layout and
> the other definition in this file.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 8e1640bc07af..305ad3eec987 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1007,6 +1007,7 @@ static const struct amdgpu_asic_funcs vega20_asic_f=
uncs =3D
>         .read_bios_from_rom =3D &soc15_read_bios_from_rom,
>         .read_register =3D &soc15_read_register,
>         .reset =3D &soc15_asic_reset,
> +       .reset_method =3D &soc15_asic_reset_method,
>         .set_vga_state =3D &soc15_vga_set_state,
>         .get_xclk =3D &soc15_get_xclk,
>         .set_uvd_clocks =3D &soc15_set_uvd_clocks,
> @@ -1019,7 +1020,6 @@ static const struct amdgpu_asic_funcs vega20_asic_f=
uncs =3D
>         .get_pcie_usage =3D &vega20_get_pcie_usage,
>         .need_reset_on_init =3D &soc15_need_reset_on_init,
>         .get_pcie_replay_count =3D &soc15_get_pcie_replay_count,
> -       .reset_method =3D &soc15_asic_reset_method
>  };
>
>  static int soc15_common_early_init(void *handle)
> --
> 2.23.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_
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
<span style=3D"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-syste=
m, BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font=
-size: 14.6667px; background-color: rgb(255, 255, 255); display: inline !im=
portant">Reviewed-by:
 Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeucher@=
gmail.com&gt;<br>
<b>Sent:</b> Friday, November 15, 2019 11:13 AM<br>
<b>To:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/soc15: move struct definition around=
 to align with other soc15 asics</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ping?<br>
<br>
On Mon, Nov 11, 2019 at 5:21 PM Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; =
wrote:<br>
&gt;<br>
&gt; Move reset_method next to reset callback to match the struct layout an=
d<br>
&gt; the other definition in this file.<br>
&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 2 &#43;-<br>
&gt;&nbsp; 1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/=
amdgpu/soc15.c<br>
&gt; index 8e1640bc07af..305ad3eec987 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -1007,6 &#43;1007,7 @@ static const struct amdgpu_asic_funcs vega20=
_asic_funcs =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_bios_from_rom =
=3D &amp;soc15_read_bios_from_rom,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_register =3D &am=
p;soc15_read_register,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D &amp;soc15_=
asic_reset,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_method =3D &amp;soc15=
_asic_reset_method,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_vga_state =3D &am=
p;soc15_vga_set_state,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_xclk =3D &amp;soc=
15_get_xclk,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_uvd_clocks =3D &a=
mp;soc15_set_uvd_clocks,<br>
&gt; @@ -1019,7 &#43;1020,6 @@ static const struct amdgpu_asic_funcs vega20=
_asic_funcs =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_usage =3D &a=
mp;vega20_get_pcie_usage,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .need_reset_on_init =
=3D &amp;soc15_need_reset_on_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_pcie_replay_count=
 =3D &amp;soc15_get_pcie_replay_count,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset_method =3D &amp;soc15_asi=
c_reset_method<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; static int soc15_common_early_init(void *handle)<br>
&gt; --<br>
&gt; 2.23.0<br>
&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB277836449EE0C8E5F07D02AFF0700DM6PR12MB2778namp_--

--===============2063422928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2063422928==--
