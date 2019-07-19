From: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/powerplay: custom peak clock freq for navi10
Date: Fri, 19 Jul 2019 06:01:23 +0000
Message-ID: <MN2PR12MB3598B7FA125EB5DC2C640D7E8ECB0@MN2PR12MB3598.namprd12.prod.outlook.com>
References: <20190719034517.25780-1-kevin1.wang@amd.com>,
 <MN2PR12MB3344FA52A933E4922488E720E4CB0@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB329645069BD87A5E337E5CD0A2CB0@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0636882689=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB329645069BD87A5E337E5CD0A2CB0-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xu, Feifei" <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "Gui,
 Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--===============0636882689==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3598B7FA125EB5DC2C640D7E8ECB0MN2PR12MB3598namp_"

--_000_MN2PR12MB3598B7FA125EB5DC2C640D7E8ECB0MN2PR12MB3598namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Parameter 0xff for message PPSMC_MSG_GetDpmFreqByIndex will get the dpm num=
bers, so it's ok.

Reviewed-by: Kenneth Feng <kenneth.feng-5C7GfCeVMHo@public.gmane.org<mailto:kenneth.feng-5C7GfCeVMHo@public.gmane.org=
>>


From: Wang, Kevin(Yang)
Sent: Friday, July 19, 2019 1:36 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; X=
u, Feifei <Feifei.Xu-5C7GfCeVMHo@public.gmane.org>; Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: custom peak clock freq for navi10


Comment inline

________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Friday, July 19, 2019 1:03 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>; Huan=
g, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Xu, Feifei <Feifei.Xu=
@amd.com<mailto:Feifei.Xu-5C7GfCeVMHo@public.gmane.org>>; Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org<mailto:Jac=
k.Gui-5C7GfCeVMHo@public.gmane.org>>
Subject: RE: [PATCH] drm/amd/powerplay: custom peak clock freq for navi10

Comment inline

> -----Original Message-----
> From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
> Sent: Friday, July 19, 2019 11:46 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>; Qu=
an, Evan
> <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>; Huang, Ray <Ray.Huang@amd.=
com<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Xu, Feifei
> <Feifei.Xu-5C7GfCeVMHo@public.gmane.org<mailto:Feifei.Xu-5C7GfCeVMHo@public.gmane.org>>; Gui, Jack <Jack.Gui-urvtwAKJhsc@public.gmane.org=
m<mailto:Jack.Gui-5C7GfCeVMHo@public.gmane.org>>; Wang, Kevin(Yang)
> <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
> Subject: [PATCH] drm/amd/powerplay: custom peak clock freq for navi10
>
> 1.NAVI10_PEAK_SCLK_XTX    1830 Mhz
> 2.NAVI10_PEAK_SCLK_XT     1755 Mhz
> 3.NAVI10_PEAK_SCLK_XL     1625 Mhz
>
> Change-Id: I48863a9d0e261b9e7778a6c0e4a8762d7c978da6
> Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org<mailto:kevin1.wang-5C7GfCeVMHo@public.gmane.org=
>>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 65 ++++++++++--------
> -
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  4 ++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 55 ++++++++++++++++
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.h    |  4 ++
>  4 files changed, 97 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 7f51bbd2ac90..ab389dde9562 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1360,37 +1360,40 @@ int smu_adjust_power_state_dynamic(struct
> smu_context *smu,
>        }
>
>        if (smu_dpm_ctx->dpm_level !=3D level) {
> -             switch (level) {
> -             case AMD_DPM_FORCED_LEVEL_HIGH:
> -                     ret =3D smu_force_dpm_limit_value(smu, true);
> -                     break;
> -             case AMD_DPM_FORCED_LEVEL_LOW:
> -                     ret =3D smu_force_dpm_limit_value(smu, false);
> -                     break;
> -
> -             case AMD_DPM_FORCED_LEVEL_AUTO:
> -             case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> -                     ret =3D smu_unforce_dpm_levels(smu);
> -                     break;
> -
> -             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> -             case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> -             case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> -                     ret =3D smu_get_profiling_clk_mask(smu, level,
> -                                                      &sclk_mask,
> -                                                      &mclk_mask,
> -                                                      &soc_mask);
> -                     if (ret)
> -                             return ret;
> -                     smu_force_clk_levels(smu, SMU_SCLK, 1 <<
> sclk_mask);
> -                     smu_force_clk_levels(smu, SMU_MCLK, 1 <<
> mclk_mask);
> -                     smu_force_clk_levels(smu, SMU_SOCCLK, 1 <<
> soc_mask);
> -                     break;
> -
> -             case AMD_DPM_FORCED_LEVEL_MANUAL:
> -             case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> -             default:
> -                     break;
> +             ret =3D smu_set_performance_level(smu, level);
> +             if (ret) {
[Quan, Evan] Since this actually handles AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =
only. Please move this under "case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:".
And please give it a more meaningful name e.g. smu_set_asic_peak_profile().

[kevin]: in the future, for specifc asic, it may be custom other performanc=
e level, so we should have this capacity to support other asic with any per=
formance level. and i think it is not a good way to handle performance leve=
l use case by case method for each asic.

> +                     switch (level) {
> +                     case AMD_DPM_FORCED_LEVEL_HIGH:
> +                             ret =3D smu_force_dpm_limit_value(smu, true=
);
> +                             break;
> +                     case AMD_DPM_FORCED_LEVEL_LOW:
> +                             ret =3D smu_force_dpm_limit_value(smu,
> false);
> +                             break;
> +
> +                     case AMD_DPM_FORCED_LEVEL_AUTO:
> +                     case
> AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> +                             ret =3D smu_unforce_dpm_levels(smu);
> +                             break;
> +
> +                     case
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> +                     case
> AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> +                     case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +                             ret =3D smu_get_profiling_clk_mask(smu, lev=
el,
> +                                                              &sclk_mask=
,
> +                                                              &mclk_mask=
,
> +                                                              &soc_mask)=
;
> +                             if (ret)
> +                                     return ret;
> +                             smu_force_clk_levels(smu, SMU_SCLK, 1 <<
> sclk_mask);
> +                             smu_force_clk_levels(smu, SMU_MCLK, 1 <<
> mclk_mask);
> +                             smu_force_clk_levels(smu, SMU_SOCCLK, 1
> << soc_mask);
> +                             break;
> +
> +                     case AMD_DPM_FORCED_LEVEL_MANUAL:
> +                     case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
> +                     default:
> +                             break;
> +                     }
>                }
>
>                if (!ret)
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 514d31518853..ba5ddafcbdba 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -631,6 +631,7 @@ struct pptable_funcs {
>        int (*get_thermal_temperature_range)(struct smu_context *smu,
> struct smu_temperature_range *range);
>        int (*get_uclk_dpm_states)(struct smu_context *smu, uint32_t
> *clocks_in_khz, uint32_t *num_states);
>        int (*set_default_od_settings)(struct smu_context *smu, bool
> initialize);
> +     int (*set_performance_level)(struct smu_context *smu, int32_t
> level);
>  };
>
>  struct smu_funcs
> @@ -928,6 +929,9 @@ struct smu_funcs
>        ((smu)->funcs->baco_get_state? (smu)->funcs-
> >baco_get_state((smu), (state)) : 0)
>  #define smu_baco_reset(smu) \
>        ((smu)->funcs->baco_reset? (smu)->funcs->baco_reset((smu)) : 0)
> +#define smu_set_performance_level(smu, level) \
> +     ((smu)->ppt_funcs->set_performance_level? (smu)->ppt_funcs-
> >set_performance_level((smu), (level)) : -EINVAL);
> +
>
>  extern int smu_get_atom_data_table(struct smu_context *smu, uint32_t
> table,
>                                   uint16_t *size, uint8_t *frev, uint8_t =
*crev,
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index e44041a25e64..9024d91477f0 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1590,6 +1590,60 @@ static int navi10_set_ppfeature_status(struct
> smu_context *smu,
>        return 0;
>  }
>
> +static int navi10_set_peak_clock_by_device(struct smu_context *smu)
> +{
> +     struct amdgpu_device *adev =3D smu->adev;
> +     int ret =3D 0;
> +     uint32_t sclk_freq =3D 0, uclk_freq =3D 0;
> +     uint32_t uclk_level =3D 0;
> +
> +     switch (adev->rev_id) {
> +     case 0xf0: /* XTX */
> +     case 0xC0:
> +             sclk_freq =3D NAVI10_PEAK_SCLK_XTX;
> +             break;
> +     case 0xf1: /* XT */
> +     case 0xC1:
> +             sclk_freq =3D NAVI10_PEAK_SCLK_XT;
> +             break;
> +     default: /* XL */
> +             sclk_freq =3D NAVI10_PEAK_SCLK_XL;
> +             break;
> +     }
> +
> +     ret =3D smu_get_dpm_level_count(smu, SMU_UCLK, &uclk_level);
> +     if (ret)
> +             return ret;
> +     ret =3D smu_get_dpm_freq_by_index(smu, SMU_UCLK, uclk_level - 1,
> &uclk_freq);
> +     if (ret)
> +             return ret;
[Quan, Evan] I think with dpm level (3rd argument) set as 0xff directly,  y=
ou can  get the clock frequency for the max level.
[kevin]: not right, 0xff will return dpm clock level count, see function sm=
u_get_dpm_level_count
> +
> +     ret =3D smu_set_soft_freq_range(smu, SMU_SCLK, sclk_freq,
> sclk_freq);
> +     if (ret)
> +             return ret;
> +     ret =3D smu_set_soft_freq_range(smu, SMU_UCLK, uclk_freq,
> uclk_freq);
> +     if (ret)
> +             return ret;
> +
> +     return ret;
> +}
> +
> +static int navi10_set_performance_level(struct smu_context *smu, int32_t
> level)
> +{
> +     int ret =3D 0;
> +
> +     switch (level) {
> +     case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> +             ret =3D navi10_set_peak_clock_by_device(smu);
> +             break;
> +     default:
> +             ret =3D -EINVAL;
> +             break;
> +     }
> +
> +     return ret;
> +}
> +
>  static const struct pptable_funcs navi10_ppt_funcs =3D {
>        .tables_init =3D navi10_tables_init,
>        .alloc_dpm_context =3D navi10_allocate_dpm_context,
> @@ -1625,6 +1679,7 @@ static const struct pptable_funcs navi10_ppt_funcs
> =3D {
>        .get_uclk_dpm_states =3D navi10_get_uclk_dpm_states,
>        .get_ppfeature_status =3D navi10_get_ppfeature_status,
>        .set_ppfeature_status =3D navi10_set_ppfeature_status,
> +     .set_performance_level =3D navi10_set_performance_level,
>  };
>
>  void navi10_set_ppt_funcs(struct smu_context *smu)
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> index 957288e22f47..620ff17c2fef 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h
> @@ -23,6 +23,10 @@
>  #ifndef __NAVI10_PPT_H__
>  #define __NAVI10_PPT_H__
>
> +#define NAVI10_PEAK_SCLK_XTX         (1830)
> +#define NAVI10_PEAK_SCLK_XT           (1755)
> +#define NAVI10_PEAK_SCLK_XL           (1625)
> +
>  extern void navi10_set_ppt_funcs(struct smu_context *smu);
>
>  #endif
> --
> 2.22.0

--_000_MN2PR12MB3598B7FA125EB5DC2C640D7E8ECB0MN2PR12MB3598namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p
	{mso-style-priority:99;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#1F497D;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Parameter 0xff for message PPSMC_MSG_Ge=
tDpmFreqByIndex will get the dpm numbers, so it&#8217;s ok.<o:p></o:p></spa=
n></p>
<p class=3D"MsoPlainText">Reviewed-by: Kenneth Feng &lt;<a href=3D"mailto:k=
enneth.feng-5C7GfCeVMHo@public.gmane.org">kenneth.feng-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Wang, Kevin(Yang)
<br>
<b>Sent:</b> Friday, July 19, 2019 1:36 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org<br>
<b>Cc:</b> Feng, Kenneth &lt;Kenneth.Feng-5C7GfCeVMHo@public.gmane.org&gt;; Huang, Ray &lt;Ray.H=
uang-5C7GfCeVMHo@public.gmane.org&gt;; Xu, Feifei &lt;Feifei.Xu-5C7GfCeVMHo@public.gmane.org&gt;; Gui, Jack &lt;Jack.=
Gui-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: custom peak clock freq for n=
avi10<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-ser=
if;color:black">Comment inline</span><span style=3D"font-family:&quot;Calib=
ri&quot;,sans-serif;color:black"><o:p></o:p></span></p>
<div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-family:&quot;Calibri&quot;,sans-serif;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Quan, =
Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Friday, July 19, 2019 1:03 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kennet=
h.Feng-5C7GfCeVMHo@public.gmane.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org"=
>Ray.Huang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Xu, Feifei &lt;<a href=3D"mailto:Feifei.Xu@amd.=
com">Feifei.Xu-5C7GfCeVMHo@public.gmane.org</a>&gt;; Gui, Jack &lt;<a href=3D"mailto:Jack.Gui@am=
d.com">Jack.Gui-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/powerplay: custom peak clock freq for n=
avi10</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;color=
:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Calibri&quot;,sans-=
serif;color:black">&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">Comment inline<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; Sent: Friday, July 19, 2019 11:46 AM<br>
&gt; To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</a><br>
&gt; Cc: Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kenneth.=
Feng-5C7GfCeVMHo@public.gmane.org</a>&gt;; Quan, Evan<br>
&gt; &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org">Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;; Hu=
ang, Ray &lt;<a href=3D"mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org">Ray.Huang-5C7GfCeVMHo@public.gmane.org</a>&gt;=
; Xu, Feifei<br>
&gt; &lt;<a href=3D"mailto:Feifei.Xu-5C7GfCeVMHo@public.gmane.org">Feifei.Xu-5C7GfCeVMHo@public.gmane.org</a>&gt;; Gu=
i, Jack &lt;<a href=3D"mailto:Jack.Gui-5C7GfCeVMHo@public.gmane.org">Jack.Gui-5C7GfCeVMHo@public.gmane.org</a>&gt;; W=
ang, Kevin(Yang)<br>
&gt; &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;=
<br>
&gt; Subject: [PATCH] drm/amd/powerplay: custom peak clock freq for navi10<=
br>
&gt; <br>
&gt; 1.NAVI10_PEAK_SCLK_XTX&nbsp;&nbsp;&nbsp; 1830 Mhz<br>
&gt; 2.NAVI10_PEAK_SCLK_XT&nbsp;&nbsp;&nbsp;&nbsp; 1755 Mhz<br>
&gt; 3.NAVI10_PEAK_SCLK_XL&nbsp;&nbsp;&nbsp;&nbsp; 1625 Mhz<br>
&gt; <br>
&gt; Change-Id: I48863a9d0e261b9e7778a6c0e4a8762d7c978da6<br>
&gt; Signed-off-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang-5C7GfCeVMHo@public.gmane.org">k=
evin1.wang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; | 6=
5 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------<br>
&gt; -<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; | 5=
5 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/navi10_ppt.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 4 &#43;&#43;<br>
&gt;&nbsp; 4 files changed, 97 insertions(&#43;), 31 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; index 7f51bbd2ac90..ab389dde9562 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&gt; @@ -1360,37 &#43;1360,40 @@ int smu_adjust_power_state_dynamic(struct<=
br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_dpm_ctx-&gt;dpm_leve=
l !=3D level) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; switch (level) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_HIGH:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_dpm_l=
imit_value(smu, true);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_LOW:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_dpm_l=
imit_value(smu, false);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_AUTO:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_unforce_dpm=
_levels(smu);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_profili=
ng_clk_mask(smu, level,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;sclk_mask,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;mclk_mask,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; &amp;soc_mask);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_force_clk_levels(sm=
u, SMU_SCLK, 1 &lt;&lt;<br>
&gt; sclk_mask);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_force_clk_levels(sm=
u, SMU_MCLK, 1 &lt;&lt;<br>
&gt; mclk_mask);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_force_clk_levels(sm=
u, SMU_SOCCLK, 1 &lt;&lt;<br>
&gt; soc_mask);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_MANUAL:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; default:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D smu_set_performance_level(smu, level);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ret) {<br>
[Quan, Evan] Since this actually handles AMD_DPM_FORCED_LEVEL_PROFILE_PEAK =
only. Please move this under &quot;case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:&=
quot;.<br>
And please give it a more meaningful name e.g. smu_set_asic_peak_profile().=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black">[kevin]: in the future, for specifc asi=
c, it may be&nbsp;custom other performance level, so&nbsp;we should have th=
is&nbsp;capacity to&nbsp;support other asic with any performance level.&nbs=
p;and
 i think it is not a good way to handle performance level use&nbsp;case by =
case method for each asic.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:black"><br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED=
_LEVEL_HIGH:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_dpm_limit_value(smu, true);<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED=
_LEVEL_LOW:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_force_dpm_limit_value(smu,<br>
&gt; false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED=
_LEVEL_AUTO:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_unforce_dpm_levels(smu);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case<br>
&gt; AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED=
_LEVEL_PROFILE_PEAK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_profiling_clk_mask(smu, level,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &amp;sclk_mask,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &amp;mclk_mask,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &amp;soc_mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_force_clk_levels(smu, SMU_SCLK, 1 &lt;&lt;=
<br>
&gt; sclk_mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_force_clk_levels(smu, SMU_MCLK, 1 &lt;&lt;=
<br>
&gt; mclk_mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_force_clk_levels(smu, SMU_SOCCLK, 1<br>
&gt; &lt;&lt; soc_mask);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED=
_LEVEL_MANUAL:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED=
_LEVEL_PROFILE_EXIT:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; index 514d31518853..ba5ddafcbdba 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&gt; @@ -631,6 &#43;631,7 @@ struct pptable_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_thermal_temperatur=
e_range)(struct smu_context *smu,<br>
&gt; struct smu_temperature_range *range);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_uclk_dpm_states)(s=
truct smu_context *smu, uint32_t<br>
&gt; *clocks_in_khz, uint32_t *num_states);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_default_od_setting=
s)(struct smu_context *smu, bool<br>
&gt; initialize);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_performance_level)(struct smu_=
context *smu, int32_t<br>
&gt; level);<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; struct smu_funcs<br>
&gt; @@ -928,6 &#43;929,9 @@ struct smu_funcs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_ge=
t_state? (smu)-&gt;funcs-<br>
&gt; &gt;baco_get_state((smu), (state)) : 0)<br>
&gt;&nbsp; #define smu_baco_reset(smu) \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;baco_re=
set? (smu)-&gt;funcs-&gt;baco_reset((smu)) : 0)<br>
&gt; &#43;#define smu_set_performance_level(smu, level) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_performance=
_level? (smu)-&gt;ppt_funcs-<br>
&gt; &gt;set_performance_level((smu), (level)) : -EINVAL);<br>
&gt; &#43;<br>
&gt; <br>
&gt;&nbsp; extern int smu_get_atom_data_table(struct smu_context *smu, uint=
32_t<br>
&gt; table,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint16_t *size, =
uint8_t *frev, uint8_t *crev,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; index e44041a25e64..9024d91477f0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&gt; @@ -1590,6 &#43;1590,60 @@ static int navi10_set_ppfeature_status(stru=
ct<br>
&gt; smu_context *smu,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; &#43;static int navi10_set_peak_clock_by_device(struct smu_context *sm=
u)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;a=
dev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sclk_freq =3D 0, uclk_freq =3D =
0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uclk_level =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;rev_id) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 0xf0: /* XTX */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 0xC0:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sclk_freq =3D NAVI10_PEAK_SCLK_XTX;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 0xf1: /* XT */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case 0xC1:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sclk_freq =3D NAVI10_PEAK_SCLK_XT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default: /* XL */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; sclk_freq =3D NAVI10_PEAK_SCLK_XL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_level_count(smu, SMU=
_UCLK, &amp;uclk_level);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_get_dpm_freq_by_index(smu, S=
MU_UCLK, uclk_level - 1,<br>
&gt; &amp;uclk_freq);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
[Quan, Evan] I think with dpm level (3rd argument) set as 0xff directly,&nb=
sp; you can&nbsp; get the clock frequency for the max level.<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">[kevin]:=
 not right, 0xff will return dpm clock level count, see function smu_get_dp=
m_level_count&nbsp;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_soft_freq_range(smu, SMU=
_SCLK, sclk_freq,<br>
&gt; sclk_freq);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_set_soft_freq_range(smu, SMU=
_UCLK, uclk_freq,<br>
&gt; uclk_freq);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return ret;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int navi10_set_performance_level(struct smu_context *smu, =
int32_t<br>
&gt; level)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; switch (level) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D navi10_set_peak_clock_by_device(smu);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static const struct pptable_funcs navi10_ppt_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .tables_init =3D navi10_tabl=
es_init,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .alloc_dpm_context =3D navi1=
0_allocate_dpm_context,<br>
&gt; @@ -1625,6 &#43;1679,7 @@ static const struct pptable_funcs navi10_ppt=
_funcs<br>
&gt; =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_uclk_dpm_states =3D nav=
i10_get_uclk_dpm_states,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D na=
vi10_get_ppfeature_status,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D na=
vi10_set_ppfeature_status,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .set_performance_level =3D navi10_set_pe=
rformance_level,<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; void navi10_set_ppt_funcs(struct smu_context *smu)<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h<br>
&gt; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h<br>
&gt; index 957288e22f47..620ff17c2fef 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.h<br>
&gt; @@ -23,6 &#43;23,10 @@<br>
&gt;&nbsp; #ifndef __NAVI10_PPT_H__<br>
&gt;&nbsp; #define __NAVI10_PPT_H__<br>
&gt; <br>
&gt; &#43;#define NAVI10_PEAK_SCLK_XTX&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (1830)<br>
&gt; &#43;#define NAVI10_PEAK_SCLK_XT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (1755)<br>
&gt; &#43;#define NAVI10_PEAK_SCLK_XL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; (1625)<br>
&gt; &#43;<br>
&gt;&nbsp; extern void navi10_set_ppt_funcs(struct smu_context *smu);<br>
&gt; <br>
&gt;&nbsp; #endif<br>
&gt; --<br>
&gt; 2.22.0<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3598B7FA125EB5DC2C640D7E8ECB0MN2PR12MB3598namp_--

--===============0636882689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0636882689==--
