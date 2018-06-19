From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust rules on
 power state change
Date: Tue, 19 Jun 2018 15:43:14 +0000
Message-ID: <CY4PR12MB1687A705AE09BB6492A5C156FB700@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1529393945-16629-1-git-send-email-evan.quan@amd.com>
 <1529393945-16629-10-git-send-email-evan.quan@amd.com>,
 <CADnq5_PqQ0aRcA=8iUq9qLow+W6rwpXhsj2GKRskn3xjwEbicw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0037898251=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_PqQ0aRcA=8iUq9qLow+W6rwpXhsj2GKRskn3xjwEbicw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0037898251==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687A705AE09BB6492A5C156FB700CY4PR12MB1687namp_"

--_000_CY4PR12MB1687A705AE09BB6492A5C156FB700CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Evan,

did we need to check the following flags on vega12?will driver set those fl=
ags when user select the umd_pstate?

PHM_PlatformCaps_UMDPState/PHM_PlatformCaps_PState.

Best Regards
Rex


?? Outlook for Android<https://aka.ms/ghei36>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, June 19, 2018 11:16:44 PM
To: Quan, Evan
Cc: amd-gfx list
Subject: Re: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust rules on =
power state change

On Tue, Jun 19, 2018 at 3:39 AM, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org> wrote:
> The clocks hard/soft min/max clock levels will be adjusted
> correspondingly.


Also note that this add the apply_clocks_adjust_rules callback which
is used to validate the clock settings on a power state change.  One
other comment below.

>
> Change-Id: I2c4b6cd6756d40a28933f0c26b9e1a3d5078bab8
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 162 +++++++++++++++=
++++++
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |   2 +
>  2 files changed, 164 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index a227ace..26bdfff 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -1950,6 +1950,166 @@ static int vega12_print_clock_levels(struct pp_hw=
mgr *hwmgr,
>         return size;
>  }
>
> +static int vega12_apply_clocks_adjust_rules(struct pp_hwmgr *hwmgr)
> +{
> +       struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->back=
end);
> +       struct vega12_single_dpm_table *dpm_table;
> +       bool vblank_too_short =3D false;
> +       bool disable_mclk_switching;
> +       uint32_t i, latency;
> +
> +       disable_mclk_switching =3D ((1 < hwmgr->display_config->num_displ=
ay) &&
> +                                 !hwmgr->display_config->multi_monitor_i=
n_sync) ||
> +                                 vblank_too_short;
> +       latency =3D hwmgr->display_config->dce_tolerable_mclk_in_active_l=
atency;
> +
> +       /* gfxclk */
> +       dpm_table =3D &(data->dpm_table.gfx_table);
> +       dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.soft_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +       dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.hard_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +
> +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> +               if (VEGA12_UMD_PSTATE_GFXCLK_LEVEL < dpm_table->count) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_SCLK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[0].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[0].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
PEAK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +               }
> +       }
> +
> +       /* memclk */
> +       dpm_table =3D &(data->dpm_table.mem_table);
> +       dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.soft_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +       dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.hard_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +
> +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> +               if (VEGA12_UMD_PSTATE_MCLK_LEVEL < dpm_table->count) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
MIN_MCLK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[0].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[0].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
PEAK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +               }
> +       }
> +
> +       /* honour DAL's UCLK Hardmin */
> +       if (dpm_table->dpm_state.hard_min_level < (hwmgr->display_config-=
>min_mem_set_clock / 100))
> +               dpm_table->dpm_state.hard_min_level =3D hwmgr->display_co=
nfig->min_mem_set_clock / 100;
> +

Didn't you just remove the uclk hard min setting in a previous patch?



> +       /* Hardmin is dependent on displayconfig */
> +       if (disable_mclk_switching) {
> +               dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_le=
vels[dpm_table->count - 1].value;
> +               for (i =3D 0; i < data->mclk_latency_table.count - 1; i++=
) {
> +                       if (data->mclk_latency_table.entries[i].latency <=
=3D latency) {
> +                               if (dpm_table->dpm_levels[i].value >=3D (=
hwmgr->display_config->min_mem_set_clock / 100)) {
> +                                       dpm_table->dpm_state.hard_min_lev=
el =3D dpm_table->dpm_levels[i].value;
> +                                       break;
> +                               }
> +                       }
> +               }
> +       }
> +
> +       if (hwmgr->display_config->nb_pstate_switch_disable)
> +               dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_le=
vels[dpm_table->count - 1].value;
> +
> +       /* vclk */
> +       dpm_table =3D &(data->dpm_table.vclk_table);
> +       dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.soft_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +       dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.hard_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +
> +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> +               if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL < dpm_table->count) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
PEAK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +               }
> +       }
> +
> +       /* dclk */
> +       dpm_table =3D &(data->dpm_table.dclk_table);
> +       dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.soft_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +       dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.hard_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +
> +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> +               if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL < dpm_table->count) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
PEAK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +               }
> +       }
> +
> +       /* socclk */
> +       dpm_table =3D &(data->dpm_table.soc_table);
> +       dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.soft_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +       dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.hard_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +
> +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> +               if (VEGA12_UMD_PSTATE_SOCCLK_LEVEL < dpm_table->count) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_SOCCLK_LEVEL].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_SOCCLK_LEVEL].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
PEAK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +               }
> +       }
> +
> +       /* eclk */
> +       dpm_table =3D &(data->dpm_table.eclk_table);
> +       dpm_table->dpm_state.soft_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.soft_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +       dpm_table->dpm_state.hard_min_level =3D dpm_table->dpm_levels[0].=
value;
> +       dpm_table->dpm_state.hard_max_level =3D dpm_table->dpm_levels[dpm=
_table->count - 1].value;
> +
> +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> +               if (VEGA12_UMD_PSTATE_VCEMCLK_LEVEL < dpm_table->count) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_VCEMCLK_LEVEL].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[VEGA12_UMD_PSTATE_VCEMCLK_LEVEL].value;
> +               }
> +
> +               if (hwmgr->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_=
PEAK) {
> +                       dpm_table->dpm_state.soft_min_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +                       dpm_table->dpm_state.soft_max_level =3D dpm_table=
->dpm_levels[dpm_table->count - 1].value;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int vega12_display_configuration_changed_task(struct pp_hwmgr *hw=
mgr)
>  {
>         struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr->back=
end);
> @@ -2196,6 +2356,8 @@ static const struct pp_hwmgr_func vega12_hwmgr_func=
s =3D {
>         .display_clock_voltage_request =3D vega12_display_clock_voltage_r=
equest,
>         .force_clock_level =3D vega12_force_clock_level,
>         .print_clock_levels =3D vega12_print_clock_levels,
> +       .apply_clocks_adjust_rules =3D
> +               vega12_apply_clocks_adjust_rules,
>         .display_config_changed =3D vega12_display_configuration_changed_=
task,
>         .powergate_uvd =3D vega12_power_gate_uvd,
>         .powergate_vce =3D vega12_power_gate_vce,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> index e18c083..e17237c 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> @@ -443,6 +443,8 @@ struct vega12_hwmgr {
>  #define VEGA12_UMD_PSTATE_GFXCLK_LEVEL         0x3
>  #define VEGA12_UMD_PSTATE_SOCCLK_LEVEL         0x3
>  #define VEGA12_UMD_PSTATE_MCLK_LEVEL           0x2
> +#define VEGA12_UMD_PSTATE_UVDCLK_LEVEL         0x3
> +#define VEGA12_UMD_PSTATE_VCEMCLK_LEVEL        0x3
>
>  int vega12_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool enable);
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1687A705AE09BB6492A5C156FB700CY4PR12MB1687namp_
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
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Hi Evan,<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
did we need to check the following flags on vega12&#65311;will driver set t=
hose flags when user select the umd_pstate?<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
PHM_PlatformCaps_UMDPState/PHM_PlatformCaps_PState.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Best Regards<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Rex<br>
<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
&#33719;&#21462; <a href=3D"https://aka.ms/ghei36">Outlook for Android</a><=
/div>
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, June 19, 2018 11:16:44 PM<br>
<b>To:</b> Quan, Evan<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust ru=
les on power state change</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">On Tue, Jun 19, 2018 at 3:39 AM, Evan Quan &lt;eva=
n.quan-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; The clocks hard/soft min/max clock levels will be adjusted<br>
&gt; correspondingly.<br>
<br>
<br>
Also note that this add the apply_clocks_adjust_rules callback which<br>
is used to validate the clock settings on a power state change.&nbsp; One<b=
r>
other comment below.<br>
<br>
&gt;<br>
&gt; Change-Id: I2c4b6cd6756d40a28933f0c26b9e1a3d5078bab8<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 162 &#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |&nbsp;&nbsp;=
 2 &#43;<br>
&gt;&nbsp; 2 files changed, 164 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; index a227ace..26bdfff 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<b=
r>
&gt; @@ -1950,6 &#43;1950,166 @@ static int vega12_print_clock_levels(struc=
t pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static int vega12_apply_clocks_adjust_rules(struct pp_hwmgr *hwmg=
r)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *data =
=3D (struct vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_single_dpm_tab=
le *dpm_table;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vblank_too_short =3D fa=
lse;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_mclk_switching;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, latency;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_switching =3D (=
(1 &lt; hwmgr-&gt;display_config-&gt;num_display) &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hwmgr-&gt;display_con=
fig-&gt;multi_monitor_in_sync) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_too_short;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; latency =3D hwmgr-&gt;displa=
y_config-&gt;dce_tolerable_mclk_in_active_latency;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfxclk */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&gt=
;dpm_table.gfx_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_=
UMDPState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_GFXCLK_LEVEL &lt; dpm_table-&gt;c=
ount) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_GFXCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_GFXCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_MIN_SCLK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_PEAK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* memclk */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&gt=
;dpm_table.mem_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_=
UMDPState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_MCLK_LEVEL &lt; dpm_table-&gt;cou=
nt) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_MCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_MCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_MIN_MCLK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_PEAK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* honour DAL's UCLK Hardmin=
 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;dpm_state.=
hard_min_level &lt; (hwmgr-&gt;display_config-&gt;min_mem_set_clock / 100))=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D hwmgr-&gt;di=
splay_config-&gt;min_mem_set_clock / 100;<br>
&gt; &#43;<br>
<br>
Didn't you just remove the uclk hard min setting in a previous patch?<br>
<br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Hardmin is dependent on d=
isplayconfig */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable_mclk_switching) =
{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D dpm_table-&g=
t;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; data-&gt;mclk_latency_table.count =
- 1; i&#43;&#43;) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dat=
a-&gt;mclk_latency_table.entries[i].latency &lt;=3D latency) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;dpm_levels[i].va=
lue &gt;=3D (hwmgr-&gt;display_config-&gt;min_mem_set_clock / 100)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D dpm_table-&gt;dpm_=
levels[i].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;display_config=
-&gt;nb_pstate_switch_disable)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D dpm_table-&g=
t;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vclk */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&gt=
;dpm_table.vclk_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_=
UMDPState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL &lt; dpm_table-&gt;c=
ount) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_UVDCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_UVDCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_PEAK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dclk */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&gt=
;dpm_table.dclk_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_=
UMDPState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL &lt; dpm_table-&gt;c=
ount) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_UVDCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_UVDCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_PEAK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* socclk */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&gt=
;dpm_table.soc_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_=
UMDPState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_SOCCLK_LEVEL &lt; dpm_table-&gt;c=
ount) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_SOCCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_SOCCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_PEAK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* eclk */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(data-&gt=
;dpm_table.eclk_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.soft=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_min_level =3D dpm_table-&gt;dpm_levels[0].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard=
_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_PlatformCaps_=
UMDPState)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_VCEMCLK_LEVEL &lt; dpm_table-&gt;=
count) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_VCEMCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[VEGA12_UMD_PST=
ATE_VCEMCLK_LEVEL].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_PRO=
FILE_PEAK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_min_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_tab=
le-&gt;dpm_state.soft_max_level =3D dpm_table-&gt;dpm_levels[dpm_table-&gt;=
count - 1].value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static int vega12_display_configuration_changed_task(struct pp_h=
wmgr *hwmgr)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *d=
ata =3D (struct vega12_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; @@ -2196,6 &#43;2356,8 @@ static const struct pp_hwmgr_func vega12_hwm=
gr_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_voltage=
_request =3D vega12_display_clock_voltage_request,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clock_level =3D=
 vega12_force_clock_level,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clock_levels =
=3D vega12_print_clock_levels,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_clocks_adjust_rules =
=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega12_apply_clocks_adjust_rules,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_config_change=
d =3D vega12_display_configuration_changed_task,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_uvd =3D veg=
a12_power_gate_uvd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_vce =3D veg=
a12_power_gate_vce,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
&gt; index e18c083..e17237c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<b=
r>
&gt; @@ -443,6 &#43;443,8 @@ struct vega12_hwmgr {<br>
&gt;&nbsp; #define VEGA12_UMD_PSTATE_GFXCLK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt;&nbsp; #define VEGA12_UMD_PSTATE_SOCCLK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt;&nbsp; #define VEGA12_UMD_PSTATE_MCLK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2<br>
&gt; &#43;#define VEGA12_UMD_PSTATE_UVDCLK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt; &#43;#define VEGA12_UMD_PSTATE_VCEMCLK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 0x3<br>
&gt;<br>
&gt;&nbsp; int vega12_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool e=
nable);<br>
&gt;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB1687A705AE09BB6492A5C156FB700CY4PR12MB1687namp_--

--===============0037898251==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0037898251==--
