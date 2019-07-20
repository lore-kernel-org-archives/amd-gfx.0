From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: change smu_read_sensor sequence in smu
Date: Sat, 20 Jul 2019 02:58:01 +0000
Message-ID: <MN2PR12MB3296D05AA1EB26B988AB75EFA2CA0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190719112232.28485-1-kevin1.wang@amd.com>
 <CADnq5_P2UVmm4P1myih0UOQ2nvLDB01zdaFN9v7p423QeLASKg@mail.gmail.com>
 <MN2PR12MB329684D6E227BE0132F67A8EA2CB0@MN2PR12MB3296.namprd12.prod.outlook.com>
 <CADnq5_PDRyxDNn3TK40L0w2KGDUcahrZge7+q_Z06DX3q-xFWw@mail.gmail.com>
 <A2EC6125-E08F-4FD2-A56C-E9D48CD3F95F@amd.com>,
 <CADnq5_ODiK_pyMZsUmw0T2ivG=_-j5h3ky9vouE-ACEJV+fddQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1134797384=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_ODiK_pyMZsUmw0T2ivG=_-j5h3ky9vouE-ACEJV+fddQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1134797384==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3296D05AA1EB26B988AB75EFA2CA0MN2PR12MB3296namp_"

--_000_MN2PR12MB3296D05AA1EB26B988AB75EFA2CA0MN2PR12MB3296namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Saturday, July 20, 2019 1:53 AM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Huang, R=
ay <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: change smu_read_sensor sequence in =
smu

On Fri, Jul 19, 2019 at 1:03 PM Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org> wro=
te:
>
> The read sensor function is not same as other one, this function should b=
e handle many different sensor type,  I don=92t want to handle all sensor t=
ype in asic file, because some sensor is very simple, only should be send a=
 message to smc, and  some sensor should be parse Table with firmware.
>
> Eg: get gfx clk,
> Only need send message to get value.
> Because the message already mapped on each asic, so this sensor should be=
 handled in smu_v11.c.
>
> Eg: get gpu load,
> this sensor should be get value from firmware table, so should must be ha=
ndled in xxx_ppt.c
>
> Eg: get pstate clock,
> It is full software sensor, so it is handled in amdgpu_smu.c
>
> In this patch, the smu only want to public one api of smu_read_sensor, an=
d the other sensor macro is helper in smu internally.
>
> I want to reduce duplicate code in smu, it will be let bring up new asic =
easy.

I think it's still pretty straight forward.  E.g., in the asic
specific read_sensor() callback you do something like this:

switch (sensor) {
case SENSOR1:
case SENSOR2:
case SENSOR3:
      ret =3D smu_v11_read_sensor_helper(smu, sensor, value);
      breakl
case SENSOR4:
     ret =3D vega20_get_sensor4(smu, value);
     break;
default:
    ...
}

That way there is less confusion about following callbacks.

Alex

[kevin]:
I will improve the logic of this part of code according to your suggestion.=
 thanks.

>
> Thanks
>
> > On Jul 20, 2019, at 12:14 AM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> >
> >> On Fri, Jul 19, 2019 at 12:01 PM Wang, Kevin(Yang) <Kevin1.Wang-urvtwAKJhsc@public.gmane.org=
m> wrote:
> >>
> >>
> >> ________________________________
> >> From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Sent: Friday, July 19, 2019 11:17 PM
> >> To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
> >> Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Hua=
ng, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
> >> Subject: Re: [PATCH] drm/amd/powerplay: change smu_read_sensor sequenc=
e in smu
> >>
> >>> On Fri, Jul 19, 2019 at 7:23 AM Wang, Kevin(Yang) <Kevin1.Wang-urvtwAKJhsc@public.gmane.org=
m> wrote:
> >>>
> >>> each asic maybe has different read sensor method.
> >>> so change read sensor sequence in smu.
> >>>
> >>> read sensor sequence:
> >>> asic sensor --> smc sensor (smu 11...) --> default_sensor (common)
> >>
> >> I think this makes sense.  That said, the current swSMU callback
> >> structures are really confusing.  I think we should switch to a single
> >> set of per asic callbacks and then add common helpers.  Then for asics
> >> where it makes sense we can just use the helper as the callback for
> >> all relevant asics.  If they need something asic specific, use the
> >> asic specific function.  That should avoid the current mix of
> >> callbacks and make it clearer what code gets used when.
> >>
> >> Alex
> >>
> >> [kevin]:
> >>
> >> thanks review, in current code, the read sensor related function is no=
t very clear, so i want to refine them.
> >> but I'm not sure which way to write good code logic.
> >>
> >> way 1:
> >>
> >> provide a puiblic function named smu_read_sensor as public smu api for=
 other kenel module, like this patch.
> >> this function will try to get value from asic or smu ip level or commo=
n, call them in turn according to the rules.
> >>
> >> way 2:
> >>
> >> define a maco named smu_read_sensor as public api, implement it in xxx=
_ppt.c file,
> >> if can't handle sensor type in xxx_ppt.c, then call helper in smu_v11_=
0.c,  then call amdgpu_smu.c helper.
> >>
> >> in this way, it means we must implement this callback function in xxx_=
ppt.c.
> >> if need to support new asic, we should add some dulicated code in xxx_=
ppt.c, if not the smu_read_sensor api is not work well.
> >> in smu module, use many macros as module public api, it is impossible =
to tell at what level these macros implement specific code logic.
> >> so i want to refine them.
> >>
> >> do you think which way is good for this case?
> >
> > I personally prefer way 2.  With way 1, the common functions would
> > just be a wrapper around the asic specific callbacks.  The older
> > powerplay code worked that way.  If there is something common that
> > needs to be done for all asics, I think that would make sense, but I
> > don't know that we have any cases like that.  If we do end up needing
> > something like that, we can always revisit this.
> >
> > I was thinking something like the following:
> >
> > struct smu_asic_funcs {
> >    int (*get_current_clock_freq)();
> >    int (*get_fan_speed_rpm)();
> >    ...
> > }
> >
> > Then for cases where two asics use the same SMU interface, you can
> > create a common function.  So for vega20, it might look like:
> >
> > static const struct smu_asic_funcs vega20_smu_asic_funcs =3D
> > {
> >    .get_current_clock_freq =3D smu_v11_0_get_current_clock_freq,
> >    .get_fan_speed_rpm =3D vega20_get_fan_speed_rpm,
> >    ...
> > };
> >
> > and navi10 would look like:
> >
> > static const struct smu_asic_funcs navi10_smu_asic_funcs =3D
> > {
> >    .get_current_clock_freq =3D smu_v11_0_get_current_clock_freq,
> >    .get_fan_speed_rpm =3D navi10_get_fan_speed_rpm,
> >    ...
> > };
> >
> > Alex
> >
> >
> >> thanks.
> >>
> >>>
> >>> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>
> >>> ---
> >>> drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 26 +++++++++++++++++-=
-
> >>> .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  9 ++++---
> >>> drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  3 +++
> >>> drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 10 +++----
> >>> drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  3 +++
> >>> 5 files changed, 40 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu=
/drm/amd/powerplay/amdgpu_smu.c
> >>> index 05b91bc5054c..85269f86cae2 100644
> >>> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> >>> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> >>> @@ -284,11 +284,14 @@ int smu_get_power_num_states(struct smu_context=
 *smu,
> >>>        return 0;
> >>> }
> >>>
> >>> -int smu_common_read_sensor(struct smu_context *smu, enum amd_pp_sens=
ors sensor,
> >>> -                          void *data, uint32_t *size)
> >>> +int smu_default_read_sensor(struct smu_context *smu, enum amd_pp_sen=
sors sensor,
> >>> +                           void *data, uint32_t *size)
> >>> {
> >>>        int ret =3D 0;
> >>>
> >>> +       if (!data || !size)
> >>> +               return -EINVAL;
> >>> +
> >>>        switch (sensor) {
> >>>        case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
> >>>                *((uint32_t *)data) =3D smu->pstate_sclk;
> >>> @@ -321,6 +324,25 @@ int smu_common_read_sensor(struct smu_context *s=
mu, enum amd_pp_sensors sensor,
> >>>        return ret;
> >>> }
> >>>
> >>> +int smu_read_sensor(struct smu_context *smu, enum amd_pp_sensors sen=
sor,
> >>> +                   void *data, uint32_t *size)
> >>> +{
> >>> +       int ret =3D 0;
> >>> +
> >>> +       if (!data || !size)
> >>> +               return -EINVAL;
> >>> +
> >>> +       /* handle sensor sequence: asic --> ip level -->  default */
> >>> +       ret =3D smu_asic_read_sensor(smu, sensor, data, size);
> >>> +       if (ret) {
> >>> +               ret =3D smu_smc_read_sensor(smu, sensor, data, size);
> >>> +               if (ret)
> >>> +                       ret =3D smu_default_read_sensor(smu, sensor, =
data, size);
> >>> +       }
> >>> +
> >>> +       return ret;
> >>> +}
> >>> +
> >>> int smu_update_table(struct smu_context *smu, enum smu_table_id table=
_index, int argument,
> >>>                     void *table_data, bool drv2smu)
> >>> {
> >>> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers=
/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> >>> index 34093ddca105..462bae8d62aa 100644
> >>> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> >>> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> >>> @@ -820,10 +820,10 @@ struct smu_funcs
> >>>        ((smu)->ppt_funcs->set_thermal_fan_table ? (smu)->ppt_funcs->s=
et_thermal_fan_table((smu)) : 0)
> >>> #define smu_start_thermal_control(smu) \
> >>>        ((smu)->funcs->start_thermal_control? (smu)->funcs->start_ther=
mal_control((smu)) : 0)
> >>> -#define smu_read_sensor(smu, sensor, data, size) \
> >>> -       ((smu)->funcs->read_sensor? (smu)->funcs->read_sensor((smu), =
(sensor), (data), (size)) : 0)
> >>> +#define smu_smc_read_sensor(smu, sensor, data, size) \
> >>> +       ((smu)->funcs->read_sensor? (smu)->funcs->read_sensor((smu), =
(sensor), (data), (size)) : -EINVAL)
> >>> #define smu_asic_read_sensor(smu, sensor, data, size) \
> >>> -       ((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor=
((smu), (sensor), (data), (size)) : 0)
> >>> +       ((smu)->ppt_funcs->read_sensor? (smu)->ppt_funcs->read_sensor=
((smu), (sensor), (data), (size)) : -EINVAL)
> >>> #define smu_get_power_profile_mode(smu, buf) \
> >>>        ((smu)->ppt_funcs->get_power_profile_mode ? (smu)->ppt_funcs->=
get_power_profile_mode((smu), buf) : 0)
> >>> #define smu_set_power_profile_mode(smu, param, param_size) \
> >>> @@ -989,5 +989,6 @@ enum amd_dpm_forced_level smu_get_performance_lev=
el(struct smu_context *smu);
> >>> int smu_force_performance_level(struct smu_context *smu, enum amd_dpm=
_forced_level level);
> >>> int smu_set_display_count(struct smu_context *smu, uint32_t count);
> >>> bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum smu_clk_typ=
e clk_type);
> >>> -
> >>> +int smu_read_sensor(struct smu_context *smu, enum amd_pp_sensors sen=
sor,
> >>> +                   void *data, uint32_t *size);
> >>> #endif
> >>> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu=
/drm/amd/powerplay/navi10_ppt.c
> >>> index 46e2913e4af4..0a53695785b6 100644
> >>> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> >>> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> >>> @@ -1365,6 +1365,9 @@ static int navi10_read_sensor(struct smu_contex=
t *smu,
> >>>        struct smu_table_context *table_context =3D &smu->smu_table;
> >>>        PPTable_t *pptable =3D table_context->driver_pptable;
> >>>
> >>> +       if (!data || !size)
> >>> +               return -EINVAL;
> >>> +
> >>>        switch (sensor) {
> >>>        case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
> >>>                *(uint32_t *)data =3D pptable->FanMaximumRpm;
> >>> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/=
drm/amd/powerplay/smu_v11_0.c
> >>> index 76bc157525d0..2679b6ff6ca3 100644
> >>> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> >>> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> >>> @@ -1267,6 +1267,10 @@ static int smu_v11_0_read_sensor(struct smu_co=
ntext *smu,
> >>>                                 void *data, uint32_t *size)
> >>> {
> >>>        int ret =3D 0;
> >>> +
> >>> +       if (!data || !size)
> >>> +               return -EINVAL;
> >>> +
> >>>        switch (sensor) {
> >>>        case AMDGPU_PP_SENSOR_GFX_MCLK:
> >>>                ret =3D smu_get_current_clk_freq(smu, SMU_UCLK, (uint3=
2_t *)data);
> >>> @@ -1285,14 +1289,10 @@ static int smu_v11_0_read_sensor(struct smu_c=
ontext *smu,
> >>>                *size =3D 4;
> >>>                break;
> >>>        default:
> >>> -               ret =3D smu_common_read_sensor(smu, sensor, data, siz=
e);
> >>> +               ret =3D -EINVAL;
> >>>                break;
> >>>        }
> >>>
> >>> -       /* try get sensor data by asic */
> >>> -       if (ret)
> >>> -               ret =3D smu_asic_read_sensor(smu, sensor, data, size)=
;
> >>> -
> >>>        if (ret)
> >>>                *size =3D 0;
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu=
/drm/amd/powerplay/vega20_ppt.c
> >>> index bcd0efaf7bbd..b44ec7c670c5 100644
> >>> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> >>> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> >>> @@ -3146,6 +3146,9 @@ static int vega20_read_sensor(struct smu_contex=
t *smu,
> >>>        struct smu_table_context *table_context =3D &smu->smu_table;
> >>>        PPTable_t *pptable =3D table_context->driver_pptable;
> >>>
> >>> +       if (!data || !size)
> >>> +               return -EINVAL;
> >>> +
> >>>        switch (sensor) {
> >>>        case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
> >>>                *(uint32_t *)data =3D pptable->FanMaximumRpm;
> >>> --
> >>> 2.22.0
> >>>
> >>> _______________________________________________
> >>> amd-gfx mailing list
> >>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB3296D05AA1EB26B988AB75EFA2CA0MN2PR12MB3296namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, &quot;Apple Co=
lor Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI=
 Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, July 20, 2019 1:53 AM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.Feng@a=
md.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: change smu_read_sensor seque=
nce in smu</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Jul 19, 2019 at 1:03 PM Wang, Kevin(Yang) =
&lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; The read sensor function is not same as other one, this function shoul=
d be handle many different sensor type,&nbsp; I don=92t want to handle all =
sensor type in asic file, because some sensor is very simple, only should b=
e send a message to smc, and&nbsp; some sensor
 should be parse Table with firmware.<br>
&gt;<br>
&gt; Eg: get gfx clk,<br>
&gt; Only need send message to get value.<br>
&gt; Because the message already mapped on each asic, so this sensor should=
 be handled in smu_v11.c.<br>
&gt;<br>
&gt; Eg: get gpu load,<br>
&gt; this sensor should be get value from firmware table, so should must be=
 handled in xxx_ppt.c<br>
&gt;<br>
&gt; Eg: get pstate clock,<br>
&gt; It is full software sensor, so it is handled in amdgpu_smu.c<br>
&gt;<br>
&gt; In this patch, the smu only want to public one api of smu_read_sensor,=
 and the other sensor macro is helper in smu internally.<br>
&gt;<br>
&gt; I want to reduce duplicate code in smu, it will be let bring up new as=
ic easy.<br>
<br>
I think it's still pretty straight forward.&nbsp; E.g., in the asic<br>
specific read_sensor() callback you do something like this:<br>
<br>
switch (sensor) {<br>
case SENSOR1:<br>
case SENSOR2:<br>
case SENSOR3:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_v11_read_sensor_helper(smu, sens=
or, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; breakl<br>
case SENSOR4:<br>
&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_sensor4(smu, value);<br>
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
default:<br>
&nbsp;&nbsp;&nbsp; ...<br>
}<br>
<br>
That way there is less confusion about following callbacks.<br>
<br>
Alex</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[kevin]:</div>
<div class=3D"PlainText">
<div>I will improve the logic of this part of code according to your sugges=
tion. thanks.</div>
<br>
&gt;<br>
&gt; Thanks<br>
&gt;<br>
&gt; &gt; On Jul 20, 2019, at 12:14 AM, Alex Deucher &lt;alexdeucher@gmail.=
com&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt; On Fri, Jul 19, 2019 at 12:01 PM Wang, Kevin(Yang) &lt;Kevin1=
.Wang-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; ________________________________<br>
&gt; &gt;&gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; &gt;&gt; Sent: Friday, July 19, 2019 11:17 PM<br>
&gt; &gt;&gt; To: Wang, Kevin(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;&gt; Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org&gt;; Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth=
.Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] drm/amd/powerplay: change smu_read_senso=
r sequence in smu<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; On Fri, Jul 19, 2019 at 7:23 AM Wang, Kevin(Yang) &lt;Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; each asic maybe has different read sensor method.<br>
&gt; &gt;&gt;&gt; so change read sensor sequence in smu.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; read sensor sequence:<br>
&gt; &gt;&gt;&gt; asic sensor --&gt; smc sensor (smu 11...) --&gt; default_=
sensor (common)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I think this makes sense.&nbsp; That said, the current swSMU =
callback<br>
&gt; &gt;&gt; structures are really confusing.&nbsp; I think we should swit=
ch to a single<br>
&gt; &gt;&gt; set of per asic callbacks and then add common helpers.&nbsp; =
Then for asics<br>
&gt; &gt;&gt; where it makes sense we can just use the helper as the callba=
ck for<br>
&gt; &gt;&gt; all relevant asics.&nbsp; If they need something asic specifi=
c, use the<br>
&gt; &gt;&gt; asic specific function.&nbsp; That should avoid the current m=
ix of<br>
&gt; &gt;&gt; callbacks and make it clearer what code gets used when.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Alex<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [kevin]:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; thanks review, in current code, the read sensor related funct=
ion is not very clear, so i want to refine them.<br>
&gt; &gt;&gt; but I'm not sure which way to write good code logic.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; way 1:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; provide a puiblic function named smu_read_sensor as public sm=
u api for other kenel module, like this patch.<br>
&gt; &gt;&gt; this function will try to get value from asic or smu ip level=
 or common, call them in turn according to the rules.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; way 2:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; define a maco named smu_read_sensor as public api, implement =
it in xxx_ppt.c file,<br>
&gt; &gt;&gt; if can't handle sensor type in xxx_ppt.c, then call helper in=
 smu_v11_0.c,&nbsp; then call amdgpu_smu.c helper.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; in this way, it means we must implement this callback functio=
n in xxx_ppt.c.<br>
&gt; &gt;&gt; if need to support new asic, we should add some dulicated cod=
e in xxx_ppt.c, if not the smu_read_sensor api is not work well.<br>
&gt; &gt;&gt; in smu module, use many macros as module public api, it is im=
possible to tell at what level these macros implement specific code logic.<=
br>
&gt; &gt;&gt; so i want to refine them.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; do you think which way is good for this case?<br>
&gt; &gt;<br>
&gt; &gt; I personally prefer way 2.&nbsp; With way 1, the common functions=
 would<br>
&gt; &gt; just be a wrapper around the asic specific callbacks.&nbsp; The o=
lder<br>
&gt; &gt; powerplay code worked that way.&nbsp; If there is something commo=
n that<br>
&gt; &gt; needs to be done for all asics, I think that would make sense, bu=
t I<br>
&gt; &gt; don't know that we have any cases like that.&nbsp; If we do end u=
p needing<br>
&gt; &gt; something like that, we can always revisit this.<br>
&gt; &gt;<br>
&gt; &gt; I was thinking something like the following:<br>
&gt; &gt;<br>
&gt; &gt; struct smu_asic_funcs {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; int (*get_current_clock_freq)();<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; int (*get_fan_speed_rpm)();<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; ...<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt; Then for cases where two asics use the same SMU interface, you ca=
n<br>
&gt; &gt; create a common function.&nbsp; So for vega20, it might look like=
:<br>
&gt; &gt;<br>
&gt; &gt; static const struct smu_asic_funcs vega20_smu_asic_funcs =3D<br>
&gt; &gt; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; .get_current_clock_freq =3D smu_v11_0_get_curre=
nt_clock_freq,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm =3D vega20_get_fan_speed_rpm=
,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; ...<br>
&gt; &gt; };<br>
&gt; &gt;<br>
&gt; &gt; and navi10 would look like:<br>
&gt; &gt;<br>
&gt; &gt; static const struct smu_asic_funcs navi10_smu_asic_funcs =3D<br>
&gt; &gt; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; .get_current_clock_freq =3D smu_v11_0_get_curre=
nt_clock_freq,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; .get_fan_speed_rpm =3D navi10_get_fan_speed_rpm=
,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; ...<br>
&gt; &gt; };<br>
&gt; &gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; thanks.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Signed-off-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nb=
sp; | 26 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;--<br>
&gt; &gt;&gt;&gt; .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nb=
sp; |&nbsp; 9 &#43;&#43;&#43;&#43;---<br>
&gt; &gt;&gt;&gt; drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nb=
sp; |&nbsp; 3 &#43;&#43;&#43;<br>
&gt; &gt;&gt;&gt; drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 10 &#43;&#43;=
&#43;----<br>
&gt; &gt;&gt;&gt; drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nb=
sp; |&nbsp; 3 &#43;&#43;&#43;<br>
&gt; &gt;&gt;&gt; 5 files changed, 40 insertions(&#43;), 11 deletions(-)<br=
>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b=
/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &gt;&gt;&gt; index 05b91bc5054c..85269f86cae2 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_sm=
u.c<br>
&gt; &gt;&gt;&gt; @@ -284,11 &#43;284,14 @@ int smu_get_power_num_states(st=
ruct smu_context *smu,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -int smu_common_read_sensor(struct smu_context *smu, enum=
 amd_pp_sensors sensor,<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; void *data, uint32_t *size)<br>
&gt; &gt;&gt;&gt; &#43;int smu_default_read_sensor(struct smu_context *smu,=
 enum amd_pp_sensors sensor,<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, uint32_t *size)<br>
&gt; &gt;&gt;&gt; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<=
br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data || !s=
ize)<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor)=
 {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_=
SENSOR_STABLE_PSTATE_SCLK:<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *((uint32_t *)data) =3D smu-&gt;pstate_scl=
k;<br>
&gt; &gt;&gt;&gt; @@ -321,6 &#43;324,25 @@ int smu_common_read_sensor(struc=
t smu_context *smu, enum amd_pp_sensors sensor,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &#43;int smu_read_sensor(struct smu_context *smu, enum am=
d_pp_sensors sensor,<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, uint32=
_t *size)<br>
&gt; &gt;&gt;&gt; &#43;{<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<=
br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data || !s=
ize)<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* handle senso=
r sequence: asic --&gt; ip level --&gt;&nbsp; default */<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_asi=
c_read_sensor(smu, sensor, data, size);<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_smc_read_sensor(smu, sensor, d=
ata, size);<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; ret =3D smu_default_read_sensor(smu, sensor, data, size);<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&gt;&gt; &#43;}<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; int smu_update_table(struct smu_context *smu, enum smu_ta=
ble_id table_index, int argument,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *table_=
data, bool drv2smu)<br>
&gt; &gt;&gt;&gt; {<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu=
.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; &gt;&gt;&gt; index 34093ddca105..462bae8d62aa 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; &gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgp=
u_smu.h<br>
&gt; &gt;&gt;&gt; @@ -820,10 &#43;820,10 @@ struct smu_funcs<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_=
funcs-&gt;set_thermal_fan_table ? (smu)-&gt;ppt_funcs-&gt;set_thermal_fan_t=
able((smu)) : 0)<br>
&gt; &gt;&gt;&gt; #define smu_start_thermal_control(smu) \<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;func=
s-&gt;start_thermal_control? (smu)-&gt;funcs-&gt;start_thermal_control((smu=
)) : 0)<br>
&gt; &gt;&gt;&gt; -#define smu_read_sensor(smu, sensor, data, size) \<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&g=
t;read_sensor? (smu)-&gt;funcs-&gt;read_sensor((smu), (sensor), (data), (si=
ze)) : 0)<br>
&gt; &gt;&gt;&gt; &#43;#define smu_smc_read_sensor(smu, sensor, data, size)=
 \<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;func=
s-&gt;read_sensor? (smu)-&gt;funcs-&gt;read_sensor((smu), (sensor), (data),=
 (size)) : -EINVAL)<br>
&gt; &gt;&gt;&gt; #define smu_asic_read_sensor(smu, sensor, data, size) \<b=
r>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_func=
s-&gt;read_sensor? (smu)-&gt;ppt_funcs-&gt;read_sensor((smu), (sensor), (da=
ta), (size)) : 0)<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_=
funcs-&gt;read_sensor? (smu)-&gt;ppt_funcs-&gt;read_sensor((smu), (sensor),=
 (data), (size)) : -EINVAL)<br>
&gt; &gt;&gt;&gt; #define smu_get_power_profile_mode(smu, buf) \<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_=
funcs-&gt;get_power_profile_mode ? (smu)-&gt;ppt_funcs-&gt;get_power_profil=
e_mode((smu), buf) : 0)<br>
&gt; &gt;&gt;&gt; #define smu_set_power_profile_mode(smu, param, param_size=
) \<br>
&gt; &gt;&gt;&gt; @@ -989,5 &#43;989,6 @@ enum amd_dpm_forced_level smu_get=
_performance_level(struct smu_context *smu);<br>
&gt; &gt;&gt;&gt; int smu_force_performance_level(struct smu_context *smu, =
enum amd_dpm_forced_level level);<br>
&gt; &gt;&gt;&gt; int smu_set_display_count(struct smu_context *smu, uint32=
_t count);<br>
&gt; &gt;&gt;&gt; bool smu_clk_dpm_is_enabled(struct smu_context *smu, enum=
 smu_clk_type clk_type);<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt; &#43;int smu_read_sensor(struct smu_context *smu, enum am=
d_pp_sensors sensor,<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, uint32=
_t *size);<br>
&gt; &gt;&gt;&gt; #endif<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b=
/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &gt;&gt;&gt; index 46e2913e4af4..0a53695785b6 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_pp=
t.c<br>
&gt; &gt;&gt;&gt; @@ -1365,6 &#43;1365,9 @@ static int navi10_read_sensor(s=
truct smu_context *smu,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_tabl=
e_context *table_context =3D &amp;smu-&gt;smu_table;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *ppta=
ble =3D table_context-&gt;driver_pptable;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data || !s=
ize)<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor)=
 {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_=
SENSOR_MAX_FAN_RPM:<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint32_t *)data =3D pptable-&gt;FanMaxim=
umRpm;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/=
drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &gt;&gt;&gt; index 76bc157525d0..2679b6ff6ca3 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c<br>
&gt; &gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smu_v11_0=
.c<br>
&gt; &gt;&gt;&gt; @@ -1267,6 &#43;1267,10 @@ static int smu_v11_0_read_sens=
or(struct smu_context *smu,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *data, uin=
t32_t *size)<br>
&gt; &gt;&gt;&gt; {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<=
br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data || !s=
ize)<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor)=
 {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_=
SENSOR_GFX_MCLK:<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_current_clk_freq(smu, SMU_=
UCLK, (uint32_t *)data);<br>
&gt; &gt;&gt;&gt; @@ -1285,14 &#43;1289,10 @@ static int smu_v11_0_read_sen=
sor(struct smu_context *smu,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size =3D 4;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_common_read_sensor(smu, sensor, da=
ta, size);<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* try get sensor d=
ata by asic */<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_asic_read_sensor(smu, sensor, data=
, size);<br>
&gt; &gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *size =3D 0;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b=
/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; &gt;&gt;&gt; index bcd0efaf7bbd..b44ec7c670c5 100644<br>
&gt; &gt;&gt;&gt; --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&gt; &gt;&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_pp=
t.c<br>
&gt; &gt;&gt;&gt; @@ -3146,6 &#43;3146,9 @@ static int vega20_read_sensor(s=
truct smu_context *smu,<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_tabl=
e_context *table_context =3D &amp;smu-&gt;smu_table;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PPTable_t *ppta=
ble =3D table_context-&gt;driver_pptable;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!data || !s=
ize)<br>
&gt; &gt;&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;&gt;&gt; &#43;<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (sensor)=
 {<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_PP_=
SENSOR_MAX_FAN_RPM:<br>
&gt; &gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *(uint32_t *)data =3D pptable-&gt;FanMaxim=
umRpm;<br>
&gt; &gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt; 2.22.0<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; _______________________________________________<br>
&gt; &gt;&gt;&gt; amd-gfx mailing list<br>
&gt; &gt;&gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" id=3D"LPlnk641870" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3296D05AA1EB26B988AB75EFA2CA0MN2PR12MB3296namp_--

--===============1134797384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1134797384==--
