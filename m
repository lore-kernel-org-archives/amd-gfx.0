From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd/pp: Set Max clock level to display by default
Date: Wed, 18 Jul 2018 06:07:03 +0000
Message-ID: <CY4PR12MB16873258ED43F698DE1F98CBFB530@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1531831010-7456-1-git-send-email-rex.zhu@amd.com>,
 <d8d0a85b-c6ab-270b-ab4f-d802ab4cad8b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0571337433=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d8d0a85b-c6ab-270b-ab4f-d802ab4cad8b-5C7GfCeVMHo@public.gmane.org>
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

--===============0571337433==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16873258ED43F698DE1F98CBFB530CY4PR12MB1687namp_"

--_000_CY4PR12MB16873258ED43F698DE1F98CBFB530CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

>shouldn't we still assign simple_clocks.level to clocks->max_clocks_state =
if it's non-zero?

Yes, Thanks for your reminding.


Best Regards

Rex



________________________________
From: Wentland, Harry
Sent: Wednesday, July 18, 2018 2:29 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amd/pp: Set Max clock level to display by defa=
ult



On 2018-07-17 08:36 AM, Rex Zhu wrote:
> avoid the error in dmesg:
> [drm:dm_pp_get_static_clocks]
> *ERROR* DM_PPLIB: invalid powerlevel state: 0!
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/=
drm/amd/powerplay/amd_powerplay.c
> index 75c2082..63adcd1 100644
> --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
> @@ -998,7 +998,7 @@ static int pp_get_display_power_level(void *handle,
>  static int pp_get_current_clocks(void *handle,
>                struct amd_pp_clock_info *clocks)
>  {
> -     struct amd_pp_simple_clock_info simple_clocks;
> +     struct amd_pp_simple_clock_info simple_clocks =3D { 0 };
>        struct pp_clock_info hw_clocks;
>        struct pp_hwmgr *hwmgr =3D handle;
>        int ret =3D 0;
> @@ -1034,7 +1034,8 @@ static int pp_get_current_clocks(void *handle,
>        clocks->max_engine_clock_in_sr =3D hw_clocks.max_eng_clk;
>        clocks->min_engine_clock_in_sr =3D hw_clocks.min_eng_clk;
>
> -     clocks->max_clocks_state =3D simple_clocks.level;
> +     if (simple_clocks.level =3D=3D 0)
> +             clocks->max_clocks_state =3D PP_DAL_POWERLEVEL_7;

shouldn't we still assign simple_clocks.level to clocks->max_clocks_state i=
f it's non-zero?

Harry

>
>        if (0 =3D=3D phm_get_current_shallow_sleep_clocks(hwmgr, &hwmgr->c=
urrent_ps->hardware, &hw_clocks)) {
>                clocks->max_engine_clock_in_sr =3D hw_clocks.max_eng_clk;
> @@ -1137,6 +1138,8 @@ static int pp_get_display_mode_validation_clocks(vo=
id *handle,
>        if (!hwmgr || !hwmgr->pm_en ||!clocks)
>                return -EINVAL;
>
> +     clocks->level =3D PP_DAL_POWERLEVEL_7;
> +
>        mutex_lock(&hwmgr->smu_lock);
>
>        if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_P=
latformCaps_DynamicPatchPowerState))
>

--_000_CY4PR12MB16873258ED43F698DE1F98CBFB530CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">&gt;shouldn't we still assign simple_clocks.level to clocks=
-&gt;max_clocks_state if it's non-zero?<br>
<br>
Yes, Thanks for your reminding.</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;"><br>
</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">Best Regards</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;">Rex<br>
</span></font><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Wednesday, July 18, 2018 2:29 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amd/pp: Set Max clock level to display =
by default</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
On 2018-07-17 08:36 AM, Rex Zhu wrote:<br>
&gt; avoid the error in dmesg:<br>
&gt; [drm:dm_pp_get_static_clocks]<br>
&gt; *ERROR* DM_PPLIB: invalid powerlevel state: 0!<br>
&gt; <br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 7 &#43;&#43;&#43=
;&#43;&#43;--<br>
&gt;&nbsp; 1 file changed, 5 insertions(&#43;), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; index 75c2082..63adcd1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c<br>
&gt; @@ -998,7 &#43;998,7 @@ static int pp_get_display_power_level(void *ha=
ndle,<br>
&gt;&nbsp; static int pp_get_current_clocks(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amd_pp_clock_info *clocks)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info simple_clock=
s;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_simple_clock_info simple_c=
locks =3D { 0 };<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_clock_info hw_cloc=
ks;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_hwmgr *hwmgr =3D h=
andle;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; @@ -1034,7 &#43;1034,8 @@ static int pp_get_current_clocks(void *handl=
e,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;max_engine_clock_=
in_sr =3D hw_clocks.max_eng_clk;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;min_engine_clock_=
in_sr =3D hw_clocks.min_eng_clk;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;max_clocks_state =3D simple_clock=
s.level;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (simple_clocks.level =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; clocks-&gt;max_clocks_state =3D PP_DAL_POWERLEVEL_7;<br>
<br>
shouldn't we still assign simple_clocks.level to clocks-&gt;max_clocks_stat=
e if it's non-zero?<br>
<br>
Harry<br>
<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (0 =3D=3D phm_get_current=
_shallow_sleep_clocks(hwmgr, &amp;hwmgr-&gt;current_ps-&gt;hardware, &amp;h=
w_clocks)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clocks-&gt;max_engine_clock_in_sr =3D hw_clocks.max_eng=
_clk;<br>
&gt; @@ -1137,6 &#43;1138,8 @@ static int pp_get_display_mode_validation_cl=
ocks(void *handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;pm_=
en ||!clocks)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;level =3D PP_DAL_POWERLEVEL_7=
;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;hwmgr-&gt;sm=
u_lock);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hwmgr-&g=
t;platform_descriptor.platformCaps, PHM_PlatformCaps_DynamicPatchPowerState=
))<br>
&gt; <br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB16873258ED43F698DE1F98CBFB530CY4PR12MB1687namp_--

--===============0571337433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0571337433==--
