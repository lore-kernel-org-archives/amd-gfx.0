From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust rules on
 power state change
Date: Wed, 20 Jun 2018 14:05:24 +0000
Message-ID: <BN6PR12MB1809F6847D299F75EC2FCBC4F7770@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1529393945-16629-1-git-send-email-evan.quan@amd.com>
 <1529393945-16629-10-git-send-email-evan.quan@amd.com>
 <CADnq5_PqQ0aRcA=8iUq9qLow+W6rwpXhsj2GKRskn3xjwEbicw@mail.gmail.com>,
 <SN6PR12MB26567D8241FEECAF286CEBA8E4770@SN6PR12MB2656.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0617564807=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <SN6PR12MB26567D8241FEECAF286CEBA8E4770-kxOKjb6HO/FeL/N0e1LXkAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0617564807==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F6847D299F75EC2FCBC4F7770BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F6847D299F75EC2FCBC4F7770BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

With your proposed changes patch is:

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, June 20, 2018 2:17:57 AM
To: Alex Deucher
Cc: amd-gfx list
Subject: RE: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust rules on =
power state change

Hi Alex,

Comment inline.

> -----Original Message-----
> From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Tuesday, June 19, 2018 11:17 PM
> To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
> Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Subject: Re: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust rules o=
n
> power state change
>
> On Tue, Jun 19, 2018 at 3:39 AM, Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org> wrote:
> > The clocks hard/soft min/max clock levels will be adjusted
> > correspondingly.
>
>
> Also note that this add the apply_clocks_adjust_rules callback which is u=
sed
> to validate the clock settings on a power state change.  One other commen=
t
> below.
Yes, this is for the apply_clocks_adjust_rules callback. I updated the patc=
h description as below

drm/amd/powerplay: apply clocks adjust rules on power state change

This add the apply_clocks_adjust_rules callback which is used
to validate the clock settings on a power state change.
> >
> > Change-Id: I2c4b6cd6756d40a28933f0c26b9e1a3d5078bab8
> > Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 162
> +++++++++++++++++++++
> >  drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |   2 +
> >  2 files changed, 164 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > index a227ace..26bdfff 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> > @@ -1950,6 +1950,166 @@ static int vega12_print_clock_levels(struct
> pp_hwmgr *hwmgr,
> >         return size;
> >  }
> >
> > +static int vega12_apply_clocks_adjust_rules(struct pp_hwmgr *hwmgr) {
> > +       struct vega12_hwmgr *data =3D (struct vega12_hwmgr *)(hwmgr-
> >backend);
> > +       struct vega12_single_dpm_table *dpm_table;
> > +       bool vblank_too_short =3D false;
> > +       bool disable_mclk_switching;
> > +       uint32_t i, latency;
> > +
> > +       disable_mclk_switching =3D ((1 < hwmgr->display_config->num_dis=
play)
> &&
> > +                                 !hwmgr->display_config->multi_monitor=
_in_sync) ||
> > +                                 vblank_too_short;
> > +       latency =3D
> > + hwmgr->display_config->dce_tolerable_mclk_in_active_latency;
> > +
> > +       /* gfxclk */
> > +       dpm_table =3D &(data->dpm_table.gfx_table);
> > +       dpm_table->dpm_state.soft_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.soft_max_level =3D dpm_table-
> >dpm_levels[dpm_table->count - 1].value;
> > +       dpm_table->dpm_state.hard_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.hard_max_level =3D
> > + dpm_table->dpm_levels[dpm_table->count - 1].value;
> > +
> > +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> > +               if (VEGA12_UMD_PSTATE_GFXCLK_LEVEL < dpm_table->count) =
{
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[0].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[0].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +               }
> > +       }
> > +
> > +       /* memclk */
> > +       dpm_table =3D &(data->dpm_table.mem_table);
> > +       dpm_table->dpm_state.soft_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.soft_max_level =3D dpm_table-
> >dpm_levels[dpm_table->count - 1].value;
> > +       dpm_table->dpm_state.hard_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.hard_max_level =3D
> > + dpm_table->dpm_levels[dpm_table->count - 1].value;
> > +
> > +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> > +               if (VEGA12_UMD_PSTATE_MCLK_LEVEL < dpm_table->count) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[0].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[0].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +               }
> > +       }
> > +
> > +       /* honour DAL's UCLK Hardmin */
> > +       if (dpm_table->dpm_state.hard_min_level < (hwmgr->display_confi=
g-
> >min_mem_set_clock / 100))
> > +               dpm_table->dpm_state.hard_min_level =3D
> > + hwmgr->display_config->min_mem_set_clock / 100;
> > +
>
> Didn't you just remove the uclk hard min setting in a previous patch?
>
Yes, it was moved here together with other clocks' min settings.
>
> > +       /* Hardmin is dependent on displayconfig */
> > +       if (disable_mclk_switching) {
> > +               dpm_table->dpm_state.hard_min_level =3D dpm_table-
> >dpm_levels[dpm_table->count - 1].value;
> > +               for (i =3D 0; i < data->mclk_latency_table.count - 1; i=
++) {
> > +                       if (data->mclk_latency_table.entries[i].latency=
 <=3D latency) {
> > +                               if (dpm_table->dpm_levels[i].value >=3D=
 (hwmgr-
> >display_config->min_mem_set_clock / 100)) {
> > +                                       dpm_table->dpm_state.hard_min_l=
evel =3D dpm_table-
> >dpm_levels[i].value;
> > +                                       break;
> > +                               }
> > +                       }
> > +               }
> > +       }
> > +
> > +       if (hwmgr->display_config->nb_pstate_switch_disable)
> > +               dpm_table->dpm_state.hard_min_level =3D
> > + dpm_table->dpm_levels[dpm_table->count - 1].value;
> > +
> > +       /* vclk */
> > +       dpm_table =3D &(data->dpm_table.vclk_table);
> > +       dpm_table->dpm_state.soft_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.soft_max_level =3D dpm_table-
> >dpm_levels[dpm_table->count - 1].value;
> > +       dpm_table->dpm_state.hard_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.hard_max_level =3D
> > + dpm_table->dpm_levels[dpm_table->count - 1].value;
> > +
> > +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> > +               if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL < dpm_table->count) =
{
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +               }
> > +       }
> > +
> > +       /* dclk */
> > +       dpm_table =3D &(data->dpm_table.dclk_table);
> > +       dpm_table->dpm_state.soft_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.soft_max_level =3D dpm_table-
> >dpm_levels[dpm_table->count - 1].value;
> > +       dpm_table->dpm_state.hard_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.hard_max_level =3D
> > + dpm_table->dpm_levels[dpm_table->count - 1].value;
> > +
> > +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> > +               if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL < dpm_table->count) =
{
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +               }
> > +       }
> > +
> > +       /* socclk */
> > +       dpm_table =3D &(data->dpm_table.soc_table);
> > +       dpm_table->dpm_state.soft_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.soft_max_level =3D dpm_table-
> >dpm_levels[dpm_table->count - 1].value;
> > +       dpm_table->dpm_state.hard_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.hard_max_level =3D
> > + dpm_table->dpm_levels[dpm_table->count - 1].value;
> > +
> > +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> > +               if (VEGA12_UMD_PSTATE_SOCCLK_LEVEL < dpm_table->count) =
{
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_SOCCLK_LEVEL].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_SOCCLK_LEVEL].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +               }
> > +       }
> > +
> > +       /* eclk */
> > +       dpm_table =3D &(data->dpm_table.eclk_table);
> > +       dpm_table->dpm_state.soft_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.soft_max_level =3D dpm_table-
> >dpm_levels[dpm_table->count - 1].value;
> > +       dpm_table->dpm_state.hard_min_level =3D dpm_table-
> >dpm_levels[0].value;
> > +       dpm_table->dpm_state.hard_max_level =3D
> > + dpm_table->dpm_levels[dpm_table->count - 1].value;
> > +
> > +       if (PP_CAP(PHM_PlatformCaps_UMDPState)) {
> > +               if (VEGA12_UMD_PSTATE_VCEMCLK_LEVEL < dpm_table->count)
> {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_VCEMCLK_LEVEL].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[VEGA12_UMD_PSTATE_VCEMCLK_LEVEL].value;
> > +               }
> > +
> > +               if (hwmgr->dpm_level =3D=3D
> AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
> > +                       dpm_table->dpm_state.soft_min_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +                       dpm_table->dpm_state.soft_max_level =3D dpm_tab=
le-
> >dpm_levels[dpm_table->count - 1].value;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int vega12_display_configuration_changed_task(struct pp_hwmgr
> > *hwmgr)  {
> >         struct vega12_hwmgr *data =3D (struct vega12_hwmgr
> > *)(hwmgr->backend); @@ -2196,6 +2356,8 @@ static const struct
> pp_hwmgr_func vega12_hwmgr_funcs =3D {
> >         .display_clock_voltage_request =3D
> vega12_display_clock_voltage_request,
> >         .force_clock_level =3D vega12_force_clock_level,
> >         .print_clock_levels =3D vega12_print_clock_levels,
> > +       .apply_clocks_adjust_rules =3D
> > +               vega12_apply_clocks_adjust_rules,
> >         .display_config_changed =3D
> vega12_display_configuration_changed_task,
> >         .powergate_uvd =3D vega12_power_gate_uvd,
> >         .powergate_vce =3D vega12_power_gate_vce, diff --git
> > a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> > index e18c083..e17237c 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h
> > @@ -443,6 +443,8 @@ struct vega12_hwmgr {
> >  #define VEGA12_UMD_PSTATE_GFXCLK_LEVEL         0x3
> >  #define VEGA12_UMD_PSTATE_SOCCLK_LEVEL         0x3
> >  #define VEGA12_UMD_PSTATE_MCLK_LEVEL           0x2
> > +#define VEGA12_UMD_PSTATE_UVDCLK_LEVEL         0x3
> > +#define VEGA12_UMD_PSTATE_VCEMCLK_LEVEL        0x3
> >
> >  int vega12_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, bool
> > enable);
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809F6847D299F75EC2FCBC4F7770BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">With your proposed changes patch =
is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Wednesday, June 20, 2018 2:17:57 AM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust ru=
les on power state change</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Alex,<br>
<br>
Comment inline.<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher [<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]<br>
&gt; Sent: Tuesday, June 19, 2018 11:17 PM<br>
&gt; To: Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH 10/13] drm/amd/powerplay: apply clocks adjust rule=
s on<br>
&gt; power state change<br>
&gt; <br>
&gt; On Tue, Jun 19, 2018 at 3:39 AM, Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt; w=
rote:<br>
&gt; &gt; The clocks hard/soft min/max clock levels will be adjusted<br>
&gt; &gt; correspondingly.<br>
&gt; <br>
&gt; <br>
&gt; Also note that this add the apply_clocks_adjust_rules callback which i=
s used<br>
&gt; to validate the clock settings on a power state change.&nbsp; One othe=
r comment<br>
&gt; below.<br>
Yes, this is for the apply_clocks_adjust_rules callback. I updated the patc=
h description as below<br>
<br>
drm/amd/powerplay: apply clocks adjust rules on power state change<br>
<br>
This add the apply_clocks_adjust_rules callback which is used<br>
to validate the clock settings on a power state change.<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I2c4b6cd6756d40a28933f0c26b9e1a3d5078bab8<br>
&gt; &gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c | 162<br=
>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h |&nbsp;&=
nbsp; 2 &#43;<br>
&gt; &gt;&nbsp; 2 files changed, 164 insertions(&#43;)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<b=
r>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; &gt; index a227ace..26bdfff 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmg=
r.c<br>
&gt; &gt; @@ -1950,6 &#43;1950,166 @@ static int vega12_print_clock_levels(=
struct<br>
&gt; pp_hwmgr *hwmgr,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;static int vega12_apply_clocks_adjust_rules(struct pp_hwmgr =
*hwmgr) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwmgr *da=
ta =3D (struct vega12_hwmgr *)(hwmgr-<br>
&gt; &gt;backend);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_single_dp=
m_table *dpm_table;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool vblank_too_short =
=3D false;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_mclk_switc=
hing;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i, latency;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; disable_mclk_switching =
=3D ((1 &lt; hwmgr-&gt;display_config-&gt;num_display)<br>
&gt; &amp;&amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !hwmgr-&gt;displa=
y_config-&gt;multi_monitor_in_sync) ||<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vblank_too_short;=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; latency =3D<br>
&gt; &gt; &#43; hwmgr-&gt;display_config-&gt;dce_tolerable_mclk_in_active_l=
atency;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* gfxclk */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(dat=
a-&gt;dpm_table.gfx_table);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_max_level =3D<br>
&gt; &gt; &#43; dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_Platform=
Caps_UMDPState)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_GFXCLK_LEVEL &lt; dpm_table-=
&gt;count) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_GFXCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* memclk */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(dat=
a-&gt;dpm_table.mem_table);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_max_level =3D<br>
&gt; &gt; &#43; dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_Platform=
Caps_UMDPState)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_MCLK_LEVEL &lt; dpm_table-&g=
t;count) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_MCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* honour DAL's UCLK Ha=
rdmin */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;dpm_s=
tate.hard_min_level &lt; (hwmgr-&gt;display_config-<br>
&gt; &gt;min_mem_set_clock / 100))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D<br>
&gt; &gt; &#43; hwmgr-&gt;display_config-&gt;min_mem_set_clock / 100;<br>
&gt; &gt; &#43;<br>
&gt; <br>
&gt; Didn't you just remove the uclk hard min setting in a previous patch?<=
br>
&gt; <br>
Yes, it was moved here together with other clocks' min settings.<br>
&gt; <br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Hardmin is dependent=
 on displayconfig */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (disable_mclk_switch=
ing) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D dpm_tab=
le-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; data-&gt;mclk_latency_table.c=
ount - 1; i&#43;&#43;) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (data-&gt;mclk_latency_table.entries[i].latency &lt;=3D latency) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dpm_table-&gt;dpm_levels[=
i].value &gt;=3D (hwmgr-<br>
&gt; &gt;display_config-&gt;min_mem_set_clock / 100)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D dpm_table-<br=
>
&gt; &gt;dpm_levels[i].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;display_c=
onfig-&gt;nb_pstate_switch_disable)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state.hard_min_level =3D<br>
&gt; &gt; &#43; dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* vclk */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(dat=
a-&gt;dpm_table.vclk_table);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_max_level =3D<br>
&gt; &gt; &#43; dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_Platform=
Caps_UMDPState)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL &lt; dpm_table-=
&gt;count) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* dclk */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(dat=
a-&gt;dpm_table.dclk_table);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_max_level =3D<br>
&gt; &gt; &#43; dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_Platform=
Caps_UMDPState)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_UVDCLK_LEVEL &lt; dpm_table-=
&gt;count) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_UVDCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* socclk */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(dat=
a-&gt;dpm_table.soc_table);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_max_level =3D<br>
&gt; &gt; &#43; dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_Platform=
Caps_UMDPState)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_SOCCLK_LEVEL &lt; dpm_table-=
&gt;count) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_SOCCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_SOCCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* eclk */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table =3D &amp;(dat=
a-&gt;dpm_table.eclk_table);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[0].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dpm_table-&gt;dpm_state=
.hard_max_level =3D<br>
&gt; &gt; &#43; dpm_table-&gt;dpm_levels[dpm_table-&gt;count - 1].value;<br=
>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (PP_CAP(PHM_Platform=
Caps_UMDPState)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (VEGA12_UMD_PSTATE_VCEMCLK_LEVEL &lt; dpm_table=
-&gt;count)<br>
&gt; {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_VCEMCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[VEGA12_UMD_PSTATE_VCEMCLK_LEVEL].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level =3D=3D<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_min_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dp=
m_table-&gt;dpm_state.soft_max_level =3D dpm_table-<br>
&gt; &gt;dpm_levels[dpm_table-&gt;count - 1].value;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static int vega12_display_configuration_changed_task(struct=
 pp_hwmgr<br>
&gt; &gt; *hwmgr)&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega12_hwm=
gr *data =3D (struct vega12_hwmgr<br>
&gt; &gt; *)(hwmgr-&gt;backend); @@ -2196,6 &#43;2356,8 @@ static const str=
uct<br>
&gt; pp_hwmgr_func vega12_hwmgr_funcs =3D {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_clock_vo=
ltage_request =3D<br>
&gt; vega12_display_clock_voltage_request,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clock_leve=
l =3D vega12_force_clock_level,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .print_clock_leve=
ls =3D vega12_print_clock_levels,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .apply_clocks_adjust_ru=
les =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; vega12_apply_clocks_adjust_rules,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .display_config_c=
hanged =3D<br>
&gt; vega12_display_configuration_changed_task,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_uvd =
=3D vega12_power_gate_uvd,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .powergate_vce =
=3D vega12_power_gate_vce, diff --git<br>
&gt; &gt; a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
&gt; &gt; index e18c083..e17237c 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmg=
r.h<br>
&gt; &gt; @@ -443,6 &#43;443,8 @@ struct vega12_hwmgr {<br>
&gt; &gt;&nbsp; #define VEGA12_UMD_PSTATE_GFXCLK_LEVEL&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt; &gt;&nbsp; #define VEGA12_UMD_PSTATE_SOCCLK_LEVEL&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt; &gt;&nbsp; #define VEGA12_UMD_PSTATE_MCLK_LEVEL&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2<br>
&gt; &gt; &#43;#define VEGA12_UMD_PSTATE_UVDCLK_LEVEL&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt; &gt; &#43;#define VEGA12_UMD_PSTATE_VCEMCLK_LEVEL&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0x3<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; int vega12_enable_disable_vce_dpm(struct pp_hwmgr *hwmgr, b=
ool<br>
&gt; &gt; enable);<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 2.7.4<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F6847D299F75EC2FCBC4F7770BN6PR12MB1809namp_--

--===============0617564807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0617564807==--
