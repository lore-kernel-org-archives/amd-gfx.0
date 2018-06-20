From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/5] drm/amd/pp: Fix wrong clock-unit exported to Display
Date: Wed, 20 Jun 2018 14:51:24 +0000
Message-ID: <CY4PR12MB1687C87330C2D926DD39BC94FB770@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180619211732.10012-1-harry.wentland@amd.com>
 <20180619211732.10012-3-harry.wentland@amd.com>,
 <CADnq5_MubdXkZHwP982PvHLfrwCQo4KvFzk8egTdK4RGuCkY4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2120474081=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_MubdXkZHwP982PvHLfrwCQo4KvFzk8egTdK4RGuCkY4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Laktyushkin, Dmytro" <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, "Lipski,
 Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>, "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2120474081==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687C87330C2D926DD39BC94FB770CY4PR12MB1687namp_"

--_000_CY4PR12MB1687C87330C2D926DD39BC94FB770CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


Mikita's patch was still not in drm-next.

I reviewed the interfaces between powerplay and display.

Most of them were still not implemented. so the services powerplay exported=
 to dc will not be called.

I tried to implement them.

and then we can  try to test  the strutter mode on raven in linux.


Best Regards

Rex


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, June 20, 2018 11:47 AM
To: Wentland, Harry
Cc: amd-gfx list; Wu, Hersen; Lipski, Mikita; Laktyushkin, Dmytro; Zhu, Rex
Subject: Re: [PATCH 2/5] drm/amd/pp: Fix wrong clock-unit exported to Displ=
ay

On Tue, Jun 19, 2018 at 5:17 PM, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org> wr=
ote:
> From: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
> Transfer 10KHz (requested by smu) to KHz needed by Display
> component.
>
> This can fix the issue 4k Monitor can't be lit up on Vega/Raven.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Need to make sure we drop Mikita's patch if we apply this one
otherwise the clocks will be wrong again.

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c  |  4 ++--
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 10 +++++-----
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 10 +++++-----
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index d4bc83e81389..c905df42adc5 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -993,7 +993,7 @@ static int smu10_get_clock_by_type_with_latency(struc=
t pp_hwmgr *hwmgr,
>
>         clocks->num_levels =3D 0;
>         for (i =3D 0; i < pclk_vol_table->count; i++) {
> -               clocks->data[i].clocks_in_khz =3D pclk_vol_table->entries=
[i].clk;
> +               clocks->data[i].clocks_in_khz =3D pclk_vol_table->entries=
[i].clk * 10;
>                 clocks->data[i].latency_in_us =3D latency_required ?
>                                                 smu10_get_mem_latency(hwm=
gr,
>                                                 pclk_vol_table->entries[i=
].clk) :
> @@ -1044,7 +1044,7 @@ static int smu10_get_clock_by_type_with_voltage(str=
uct pp_hwmgr *hwmgr,
>
>         clocks->num_levels =3D 0;
>         for (i =3D 0; i < pclk_vol_table->count; i++) {
> -               clocks->data[i].clocks_in_khz =3D pclk_vol_table->entries=
[i].clk;
> +               clocks->data[i].clocks_in_khz =3D pclk_vol_table->entries=
[i].clk  * 10;
>                 clocks->data[i].voltage_in_mv =3D pclk_vol_table->entries=
[i].vol;
>                 clocks->num_levels++;
>         }
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index 3b8d36df52e9..e9a8b527d481 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4067,7 +4067,7 @@ static void vega10_get_sclks(struct pp_hwmgr *hwmgr=
,
>         for (i =3D 0; i < dep_table->count; i++) {
>                 if (dep_table->entries[i].clk) {
>                         clocks->data[clocks->num_levels].clocks_in_khz =
=3D
> -                                       dep_table->entries[i].clk;
> +                                       dep_table->entries[i].clk * 10;
>                         clocks->num_levels++;
>                 }
>         }
> @@ -4104,7 +4104,7 @@ static void vega10_get_memclocks(struct pp_hwmgr *h=
wmgr,
>                         clocks->data[clocks->num_levels].clocks_in_khz =
=3D
>                         data->mclk_latency_table.entries
>                         [data->mclk_latency_table.count].frequency =3D
> -                                       dep_table->entries[i].clk;
> +                                       dep_table->entries[i].clk * 10;
>                         clocks->data[clocks->num_levels].latency_in_us =
=3D
>                         data->mclk_latency_table.entries
>                         [data->mclk_latency_table.count].latency =3D
> @@ -4126,7 +4126,7 @@ static void vega10_get_dcefclocks(struct pp_hwmgr *=
hwmgr,
>         uint32_t i;
>
>         for (i =3D 0; i < dep_table->count; i++) {
> -               clocks->data[i].clocks_in_khz =3D dep_table->entries[i].c=
lk;
> +               clocks->data[i].clocks_in_khz =3D dep_table->entries[i].c=
lk * 10;
>                 clocks->data[i].latency_in_us =3D 0;
>                 clocks->num_levels++;
>         }
> @@ -4142,7 +4142,7 @@ static void vega10_get_socclocks(struct pp_hwmgr *h=
wmgr,
>         uint32_t i;
>
>         for (i =3D 0; i < dep_table->count; i++) {
> -               clocks->data[i].clocks_in_khz =3D dep_table->entries[i].c=
lk;
> +               clocks->data[i].clocks_in_khz =3D dep_table->entries[i].c=
lk * 10;
>                 clocks->data[i].latency_in_us =3D 0;
>                 clocks->num_levels++;
>         }
> @@ -4202,7 +4202,7 @@ static int vega10_get_clock_by_type_with_voltage(st=
ruct pp_hwmgr *hwmgr,
>         }
>
>         for (i =3D 0; i < dep_table->count; i++) {
> -               clocks->data[i].clocks_in_khz =3D dep_table->entries[i].c=
lk;
> +               clocks->data[i].clocks_in_khz =3D dep_table->entries[i].c=
lk  * 10;
>                 clocks->data[i].voltage_in_mv =3D (uint32_t)(table_info->=
vddc_lookup_table->
>                                 entries[dep_table->entries[i].vddInd].us_=
vdd);
>                 clocks->num_levels++;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index 782e2098824d..d685ce7f88cc 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -1576,7 +1576,7 @@ static int vega12_get_sclks(struct pp_hwmgr *hwmgr,
>
>         for (i =3D 0; i < ucount; i++) {
>                 clocks->data[i].clocks_in_khz =3D
> -                       dpm_table->dpm_levels[i].value * 100;
> +                       dpm_table->dpm_levels[i].value * 1000;
>
>                 clocks->data[i].latency_in_us =3D 0;
>         }
> @@ -1608,7 +1608,7 @@ static int vega12_get_memclocks(struct pp_hwmgr *hw=
mgr,
>
>         for (i =3D 0; i < ucount; i++) {
>                 clocks->data[i].clocks_in_khz =3D
> -                       dpm_table->dpm_levels[i].value * 100;
> +                       dpm_table->dpm_levels[i].value * 1000;
>
>                 clocks->data[i].latency_in_us =3D
>                         data->mclk_latency_table.entries[i].latency =3D
> @@ -1638,7 +1638,7 @@ static int vega12_get_dcefclocks(struct pp_hwmgr *h=
wmgr,
>
>         for (i =3D 0; i < ucount; i++) {
>                 clocks->data[i].clocks_in_khz =3D
> -                       dpm_table->dpm_levels[i].value * 100;
> +                       dpm_table->dpm_levels[i].value * 1000;
>
>                 clocks->data[i].latency_in_us =3D 0;
>         }
> @@ -1666,7 +1666,7 @@ static int vega12_get_socclocks(struct pp_hwmgr *hw=
mgr,
>
>         for (i =3D 0; i < ucount; i++) {
>                 clocks->data[i].clocks_in_khz =3D
> -                       dpm_table->dpm_levels[i].value * 100;
> +                       dpm_table->dpm_levels[i].value * 1000;
>
>                 clocks->data[i].latency_in_us =3D 0;
>         }
> @@ -1838,7 +1838,7 @@ static int vega12_print_clock_levels(struct pp_hwmg=
r *hwmgr,
>                                 return -1);
>                 for (i =3D 0; i < clocks.num_levels; i++)
>                         size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
> -                               i, clocks.data[i].clocks_in_khz / 100,
> +                               i, clocks.data[i].clocks_in_khz / 1000,
>                                 (clocks.data[i].clocks_in_khz =3D=3D now)=
 ? "*" : "");
>                 break;
>
> --
> 2.17.1
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




--_000_CY4PR12MB1687C87330C2D926DD39BC94FB770CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Alex,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-family: Calib=
ri, Helvetica, sans-serif, EmojiFont, &quot;Apple Color Emoji&quot;, &quot;=
Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;, &quot;An=
droid Emoji&quot;, EmojiSymbols; font-size: 14.6667px;">Mikita's patch was =
still&nbsp;not
 in&nbsp;</span><span style=3D"font-size: 14.6667px;">drm-next.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">I reviewed the interfaces between powerplay and display.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">Most of them were still not implemented. so the services powerplay exp=
orted to dc&nbsp;will not be called.&nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">I tried to implement them.&nbsp;</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">and then we can &nbsp;try to test &nbsp;the strutter mode on raven in =
linux.</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;"><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">Best Regards</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"font-size: 14.6667=
px;">Rex</span></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, June 20, 2018 11:47 AM<br>
<b>To:</b> Wentland, Harry<br>
<b>Cc:</b> amd-gfx list; Wu, Hersen; Lipski, Mikita; Laktyushkin, Dmytro; Z=
hu, Rex<br>
<b>Subject:</b> Re: [PATCH 2/5] drm/amd/pp: Fix wrong clock-unit exported t=
o Display</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Jun 19, 2018 at 5:17 PM, Harry Wentland &l=
t;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; From: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Transfer 10KHz (requested by smu) to KHz needed by Display<br>
&gt; component.<br>
&gt;<br>
&gt; This can fix the issue 4k Monitor can't be lit up on Vega/Raven.<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Need to make sure we drop Mikita's patch if we apply this one<br>
otherwise the clocks will be wrong again.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c&nbsp; |&nbsp; =
4 &#43;&#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 10 &#43;&#4=
3;&#43;&#43;&#43;-----<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 10 &#43;&#4=
3;&#43;&#43;&#43;-----<br>
&gt;&nbsp; 3 files changed, 12 insertions(&#43;), 12 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&gt; index d4bc83e81389..c905df42adc5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c<br=
>
&gt; @@ -993,7 &#43;993,7 @@ static int smu10_get_clock_by_type_with_latenc=
y(struct pp_hwmgr *hwmgr,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;num_levels =
=3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
clk_vol_table-&gt;count; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D pclk_vol_table-&gt;ent=
ries[i].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D pclk_vol_table-&gt=
;entries[i].clk * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].latency_in_us =3D latency_requ=
ired ?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu10_g=
et_mem_latency(hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pclk_vo=
l_table-&gt;entries[i].clk) :<br>
&gt; @@ -1044,7 &#43;1044,7 @@ static int smu10_get_clock_by_type_with_volt=
age(struct pp_hwmgr *hwmgr,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;num_levels =
=3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
clk_vol_table-&gt;count; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D pclk_vol_table-&gt;ent=
ries[i].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D pclk_vol_table-&gt=
;entries[i].clk&nbsp; * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].voltage_in_mv =3D pclk_vol_tab=
le-&gt;entries[i].vol;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;num_levels&#43;&#43;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; index 3b8d36df52e9..e9a8b527d481 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c<b=
r>
&gt; @@ -4067,7 &#43;4067,7 @@ static void vega10_get_sclks(struct pp_hwmgr=
 *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; d=
ep_table-&gt;count; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (dep_table-&gt;entries[i].clk) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
locks-&gt;data[clocks-&gt;num_levels].clocks_in_khz =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dep_table-&gt;entries[i].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dep_table-&gt;entries[i].clk * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
locks-&gt;num_levels&#43;&#43;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -4104,7 &#43;4104,7 @@ static void vega10_get_memclocks(struct pp_h=
wmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
locks-&gt;data[clocks-&gt;num_levels].clocks_in_khz =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata-&gt;mclk_latency_table.entries<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [=
data-&gt;mclk_latency_table.count].frequency =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; dep_table-&gt;entries[i].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dep_table-&gt;entries[i].clk * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
locks-&gt;data[clocks-&gt;num_levels].latency_in_us =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata-&gt;mclk_latency_table.entries<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [=
data-&gt;mclk_latency_table.count].latency =3D<br>
&gt; @@ -4126,7 &#43;4126,7 @@ static void vega10_get_dcefclocks(struct pp_=
hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; d=
ep_table-&gt;count; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D dep_table-&gt;entries[=
i].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D dep_table-&gt;entr=
ies[i].clk * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].latency_in_us =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;num_levels&#43;&#43;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -4142,7 &#43;4142,7 @@ static void vega10_get_socclocks(struct pp_h=
wmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; d=
ep_table-&gt;count; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D dep_table-&gt;entries[=
i].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D dep_table-&gt;entr=
ies[i].clk * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].latency_in_us =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;num_levels&#43;&#43;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -4202,7 &#43;4202,7 @@ static int vega10_get_clock_by_type_with_vol=
tage(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; d=
ep_table-&gt;count; i&#43;&#43;) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D dep_table-&gt;entries[=
i].clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D dep_table-&gt;entr=
ies[i].clk&nbsp; * 10;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].voltage_in_mv =3D (uint32_t)(t=
able_info-&gt;vddc_lookup_table-&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entries[dep_table-&gt;entrie=
s[i].vddInd].us_vdd);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;num_levels&#43;&#43;;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; index 782e2098824d..d685ce7f88cc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<b=
r>
&gt; @@ -1576,7 &#43;1576,7 @@ static int vega12_get_sclks(struct pp_hwmgr =
*hwmgr,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; u=
count; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&=
gt;dpm_levels[i].value * 100;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_levels[i].value * 1000;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].latency_in_us =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1608,7 &#43;1608,7 @@ static int vega12_get_memclocks(struct pp_hw=
mgr *hwmgr,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; u=
count; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&=
gt;dpm_levels[i].value * 100;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_levels[i].value * 1000;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].latency_in_us =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ata-&gt;mclk_latency_table.entries[i].latency =3D<br>
&gt; @@ -1638,7 &#43;1638,7 @@ static int vega12_get_dcefclocks(struct pp_h=
wmgr *hwmgr,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; u=
count; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&=
gt;dpm_levels[i].value * 100;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_levels[i].value * 1000;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].latency_in_us =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1666,7 &#43;1666,7 @@ static int vega12_get_socclocks(struct pp_hw=
mgr *hwmgr,<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; u=
count; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].clocks_in_khz =3D<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&=
gt;dpm_levels[i].value * 100;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_levels[i].value * 1000;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; clocks-&gt;data[i].latency_in_us =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -1838,7 &#43;1838,7 @@ static int vega12_print_clock_levels(struct =
pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; clocks.num_levels; i&#43;&#4=
3;)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
ize &#43;=3D sprintf(buf &#43; size, &quot;%d: %uMhz %s\n&quot;,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, clocks.data[i].clocks_in_khz / 100,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, clocks.data[i].clocks_in_khz / =
1000,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (clocks.data[i].clocks_in_kh=
z =3D=3D now) ? &quot;*&quot; : &quot;&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk927228" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15295057893820.520890734800856" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15295057893790.06772176907544636" role=3D"presenta=
tion" cellspacing=3D"0" style=3D"width: 90%; background-color: rgb(255, 255=
, 255); position: relative; overflow: auto; padding-top: 20px; padding-bott=
om: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200); bord=
er-bottom: 1px dotted rgb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_15295057893800.693914723348922" colspan=3D"2" style=3D"v=
ertical-align: top; position: relative; padding: 0px; display: table-cell;"=
>
<div id=3D"LPRemovePreviewContainer_15295057893800.503135221404194"></div>
<div id=3D"LPTitle_15295057893800.6195114799967232" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_15295057893810.016334902970096987" href=3D"https://lis=
ts.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"tex=
t-decoration: none;">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15295057893810.8360543762338206" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf=
_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial=
, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15295057893820.1655449087068177" style=3D"display:=
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
</body>
</html>

--_000_CY4PR12MB1687C87330C2D926DD39BC94FB770CY4PR12MB1687namp_--

--===============2120474081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2120474081==--
