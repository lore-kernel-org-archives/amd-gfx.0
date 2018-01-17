From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amd/pp: Add stable Pstate clk display when
 print_clock_levels
Date: Wed, 17 Jan 2018 14:00:44 +0000
Message-ID: <BN6PR12MB1652A5ECA54B47B0E59C03FEF7E90@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1516103973-26870-1-git-send-email-Rex.Zhu@amd.com>
 <1516103973-26870-2-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_MxAeNVKa=O1Y705OZxiXq5qTzh8Y4fRqzm0Mxoz19Adw@mail.gmail.com>,
 <CY4PR12MB16873EFA7B7C85284AE4E302FBE90@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0347032255=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16873EFA7B7C85284AE4E302FBE90-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, 'Alex Deucher' <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0347032255==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652A5ECA54B47B0E59C03FEF7E90BN6PR12MB1652namp_"

--_000_BN6PR12MB1652A5ECA54B47B0E59C03FEF7E90BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Looks good.

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Please also send a patch to bump the kernel driver version so the UMDs know=
 when the query is available.


Thanks!


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, January 17, 2018 12:48:48 AM
To: 'Alex Deucher'
Cc: amd-gfx list
Subject: RE: [PATCH 2/3] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels

Ok, I will drop this patch. and please review the new attached patch expose=
 stable pstate clock by ioctl.

Best Regards
Rex

-----Original Message-----
From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
Sent: Wednesday, January 17, 2018 12:03 AM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 2/3] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels

On Tue, Jan 16, 2018 at 6:59 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> The additional output are at the end of sclk/mclk info as cat
> pp_dpm_mclk
> 0: 300Mhz *
> 1: 1650Mhz
> P: 300Mhz
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

I'm not crazy about this patch.  I think it conflates things and breaks old=
er versions of the rocm smi tool.  I'd prefer to add a new file for the pst=
ate clocks or add a query to the amdgpu INFO ioctl to fetch them.

Alex


>
> Change-Id: Idf8eeedb5d399d9ffb7de7a2fb2976c7fa7c01a8
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     | 2 ++
>  drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     | 2 ++
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 2 ++
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 ++
>  4 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index f68dd08..03dfba0 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -1601,6 +1601,7 @@ static int cz_print_clock_levels(struct pp_hwmgr *h=
wmgr,
>                         size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>                                         i, sclk_table->entries[i].clk / 1=
00,
>                                         (i =3D=3D now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_sclk/100);
>                 break;
>         case PP_MCLK:
>                 now =3D
> PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
> @@ -1613,6 +1614,7 @@ static int cz_print_clock_levels(struct pp_hwmgr *h=
wmgr,
>                         size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>                                         CZ_NUM_NBPMEMORYCLOCK-i, data->sy=
s_info.nbp_memory_clock[i-1] / 100,
>                                         (CZ_NUM_NBPMEMORYCLOCK-i =3D=3D
> now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_mclk/100);
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> index 409a56b..88c6ad8 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> @@ -756,6 +756,7 @@ static int rv_print_clock_levels(struct pp_hwmgr *hwm=
gr,
>                                 data->gfx_max_freq_limit / 100,
>                                 ((data->gfx_max_freq_limit / 100)
>                                  =3D=3D now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_sclk/100);
>                 break;
>         case PP_MCLK:
>                 PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
> @@ -773,6 +774,7 @@ static int rv_print_clock_levels(struct pp_hwmgr *hwm=
gr,
>                                         mclk_table->entries[i].clk / 100,
>                                         ((mclk_table->entries[i].clk / 10=
0)
>                                          =3D=3D now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_mclk/100);
>                 break;
>         default:
>                 break;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index 11a900b..6f053fa 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -4301,6 +4301,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr =
*hwmgr,
>                         size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>                                         i, sclk_table->dpm_levels[i].valu=
e / 100,
>                                         (i =3D=3D now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_sclk/100);
>                 break;
>         case PP_MCLK:
>                 smum_send_msg_to_smc(hwmgr,
> PPSMC_MSG_API_GetMclkFrequency); @@ -4317,6 +4318,7 @@ static int smu7_pr=
int_clock_levels(struct pp_hwmgr *hwmgr,
>                         size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>                                         i, mclk_table->dpm_levels[i].valu=
e / 100,
>                                         (i =3D=3D now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_mclk/100);
>                 break;
>         case PP_PCIE:
>                 pcie_speed =3D smu7_get_current_pcie_speed(hwmgr);
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index adfbbc1..d646b27b 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4571,6 +4571,7 @@ static int vega10_print_clock_levels(struct pp_hwmg=
r *hwmgr,
>                         size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>                                         i, sclk_table->dpm_levels[i].valu=
e / 100,
>                                         (i =3D=3D now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_sclk/100);
>                 break;
>         case PP_MCLK:
>                 if (data->registry_data.mclk_dpm_key_disabled)
> @@ -4589,6 +4590,7 @@ static int vega10_print_clock_levels(struct pp_hwmg=
r *hwmgr,
>                         size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
>                                         i, mclk_table->dpm_levels[i].valu=
e / 100,
>                                         (i =3D=3D now) ? "*" : "");
> +               size +=3D sprintf(buf + size, "P: %uMhz\n",
> + hwmgr->pstate_mclk/100);
>                 break;
>         case PP_PCIE:
>                 PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1652A5ECA54B47B0E59C03FEF7E90BN6PR12MB1652namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Looks good.</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</p>
<p style=3D"margin-top:0;margin-bottom:0">Please also send a patch to bump =
the kernel driver version so the UMDs know when the query is available.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks!</p>
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
<b>Sent:</b> Wednesday, January 17, 2018 12:48:48 AM<br>
<b>To:</b> 'Alex Deucher'<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amd/pp: Add stable Pstate clk display w=
hen print_clock_levels</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Ok, I will drop this patch. and please review the =
new attached patch expose stable pstate clock by ioctl.<br>
<br>
Best Regards<br>
Rex<br>
<br>
-----Original Message-----<br>
From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:alexdeu=
cher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
<br>
Sent: Wednesday, January 17, 2018 12:03 AM<br>
To: Zhu, Rex<br>
Cc: amd-gfx list<br>
Subject: Re: [PATCH 2/3] drm/amd/pp: Add stable Pstate clk display when pri=
nt_clock_levels<br>
<br>
On Tue, Jan 16, 2018 at 6:59 AM, Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; The additional output are at the end of sclk/mclk info as cat <br>
&gt; pp_dpm_mclk<br>
&gt; 0: 300Mhz *<br>
&gt; 1: 1650Mhz<br>
&gt; P: 300Mhz<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
I'm not crazy about this patch.&nbsp; I think it conflates things and break=
s older versions of the rocm smi tool.&nbsp; I'd prefer to add a new file f=
or the pstate clocks or add a query to the amdgpu INFO ioctl to fetch them.=
<br>
<br>
Alex<br>
<br>
<br>
&gt;<br>
&gt; Change-Id: Idf8eeedb5d399d9ffb7de7a2fb2976c7fa7c01a8<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 2 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 2 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; | 2=
 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 &#43;&#43=
;<br>
&gt;&nbsp; 4 files changed, 8 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c <br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index f68dd08..03dfba0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -1601,6 &#43;1601,7 @@ static int cz_print_clock_levels(struct pp_h=
wmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
ize &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i, sclk_table-&gt;entries[i].clk / 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; now =3D <br>
&gt; PHM_GET_FIELD(cgs_read_ind_register(hwmgr-&gt;device,<br>
&gt; @@ -1613,6 &#43;1614,7 @@ static int cz_print_clock_levels(struct pp_h=
wmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
ize &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; CZ_NUM_NBPMEMORYCLOCK-i, data-&gt;sys_info.nbp_memory_c=
lock[i-1] / 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (CZ_NUM_NBPMEMORYCLOCK-i =3D=3D <br>
&gt; now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c <br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; index 409a56b..88c6ad8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; @@ -756,6 &#43;756,7 @@ static int rv_print_clock_levels(struct pp_hwm=
gr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;gfx_max_freq_limit =
/ 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((data-&gt;gfx_max_freq_limi=
t / 100)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D now) ? &quot;*&=
quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,<=
br>
&gt; @@ -773,6 &#43;774,7 @@ static int rv_print_clock_levels(struct pp_hwm=
gr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mclk_table-&gt;entries[i].clk / 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((mclk_table-&gt;entries[i].clk / 100)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c <br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index 11a900b..6f053fa 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -4301,6 &#43;4301,7 @@ static int smu7_print_clock_levels(struct pp=
_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
ize &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i, sclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; smum_send_msg_to_smc(hwmgr, <br>
&gt; PPSMC_MSG_API_GetMclkFrequency); @@ -4317,6 &#43;4318,7 @@ static int =
smu7_print_clock_levels(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
ize &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i, mclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; pcie_speed =3D smu7_get_current_pcie_speed(hwmgr)=
;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c <br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index adfbbc1..d646b27b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4571,6 &#43;4571,7 @@ static int vega10_print_clock_levels(struct =
pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
ize &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i, sclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_sclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_MCLK:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;registry_data.mclk_dpm_key_disabled)=
<br>
&gt; @@ -4589,6 &#43;4590,7 @@ static int vega10_print_clock_levels(struct =
pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
ize &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; i, mclk_table-&gt;dpm_levels[i].value / 100,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (i =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;P: %uMhz\n&=
quot;, <br>
&gt; &#43; hwmgr-&gt;pstate_mclk/100);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!smum_send_msg_to_smc(hwmgr,<=
br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1652A5ECA54B47B0E59C03FEF7E90BN6PR12MB1652namp_--

--===============0347032255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0347032255==--
