From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: added vega20 overdrive support
Date: Thu, 30 Aug 2018 03:54:57 +0000
Message-ID: <SN6PR12MB265640239F8818353345E431E4080@SN6PR12MB2656.namprd12.prod.outlook.com>
References: <20180829091234.2470-1-evan.quan@amd.com>,
 <CADnq5_M_KoHywdBzPPx6S1JWBXod0gCaST9A4tdmvdhzq15wuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0149335392=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_M_KoHywdBzPPx6S1JWBXod0gCaST9A4tdmvdhzq15wuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0149335392==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB265640239F8818353345E431E4080SN6PR12MB2656namp_"

--_000_SN6PR12MB265640239F8818353345E431E4080SN6PR12MB2656namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


>What about the min/max sclk? Do the curve values take that into
>account?  What about max mclk?

Voltage curve does not take these into consideration. And the max sclk and =
mclk can be set through existing sysfs interface pp_sclk_od and pp_mclk_od.=
 For min sclk, as i know there is no interface to get it set.


> Are negative offsets supported?
Sure.


Regards,

Evan


________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, August 30, 2018 12:25:35 AM
To: Quan, Evan
Cc: amd-gfx list; Deucher, Alexander; Zhu, Rex
Subject: Re: [PATCH] drm/amd/powerplay: added vega20 overdrive support

On Wed, Aug 29, 2018 at 5:13 AM Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Vega20 supports only sclk voltage overdrive. And user can
> only tell three groups of <frequency, voltage_offset>. SMU
> firmware will recalculate the frequency/voltage curve. Other
> intermediate levles will be stretched/shrunk accordingly.
>

What about the min/max sclk? Do the curve values take that into
account?  What about max mclk?

> Change-Id: I403cb38a95863db664cf06d030ac42a19bff6b33
> Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  26 +++
>  .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c    | 165 +++++++++++++++++-
>  .../drm/amd/powerplay/hwmgr/vega20_hwmgr.h    |   2 +
>  3 files changed, 192 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_pm.c
> index e2577518b9c6..6e0c8f583521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -474,6 +474,8 @@ static ssize_t amdgpu_set_pp_table(struct device *dev=
,
>   * in each power level within a power state.  The pp_od_clk_voltage is u=
sed for
>   * this.
>   *
> + * < For Vega10 and previous ASICs >
> + *
>   * Reading the file will display:
>   *
>   * - a list of engine clock levels and voltages labeled OD_SCLK
> @@ -491,6 +493,30 @@ static ssize_t amdgpu_set_pp_table(struct device *de=
v,
>   * "c" (commit) to the file to commit your changes.  If you want to rese=
t to the
>   * default power levels, write "r" (reset) to the file to reset them.
>   *
> + *
> + * < For Vega20 >
> + *
> + * Reading the file will display:
> + *
> + * - three groups of engine clock and voltage offset labeled OD_SCLK
> + *
> + * - a list of valid ranges for above three groups of sclk and voltage o=
ffset
> + *   labeled OD_RANGE
> + *
> + * To manually adjust these settings:
> + *
> + * - First select manual using power_dpm_force_performance_level
> + *
> + * - Enter a new value for each group by writing a string that contains
> + *   "s group_index clock voltage_offset" to the file.  E.g., "s 0 500 2=
0"
> + *   will update group1 sclk to be 500 MHz with voltage increased 20mV
> + *

Are negative offsets supported?

Alex

> + * - When you have edited all of the states as needed, write "c" (commit=
)
> + *   to the file to commit your changes
> + *
> + * - If you want to reset to the default power levels, write "r" (reset)
> + *   to the file to reset them
> + *
>   */
>
>  static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> index ececa2f7fe5f..9f6e070a76e0 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> @@ -1096,6 +1096,13 @@ static int vega20_od8_initialize_default_settings(
>                 }
>         }
>
> +       ret =3D vega20_copy_table_from_smc(hwmgr,
> +                       (uint8_t *)(&data->od_table),
> +                       TABLE_OVERDRIVE);
> +       PP_ASSERT_WITH_CODE(!ret,
> +                       "Failed to export over drive table!",
> +                       return ret);
> +
>         return 0;
>  }
>
> @@ -2506,11 +2513,112 @@ static int vega20_set_watermarks_for_clocks_rang=
es(struct pp_hwmgr *hwmgr,
>         return 0;
>  }
>
> +static int vega20_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
> +                                       enum PP_OD_DPM_TABLE_COMMAND type=
,
> +                                       long *input, uint32_t size)
> +{
> +       struct vega20_hwmgr *data =3D
> +                       (struct vega20_hwmgr *)(hwmgr->backend);
> +       struct vega20_od8_single_setting *od8_settings =3D
> +                       data->od8_settings.od8_settings_array;
> +       OverDriveTable_t od_table;
> +       int32_t input_index, input_clk, input_vol, i;
> +       int ret =3D 0;
> +
> +       PP_ASSERT_WITH_CODE(input, "NULL user input for clock and voltage=
",
> +                               return -EINVAL);
> +
> +       switch (type) {
> +       case PP_OD_EDIT_SCLK_VDDC_TABLE:
> +               if (!(od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id &=
&
> +                   od8_settings[OD8_SETTING_GFXCLK_FREQ2].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_FREQ3].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id =
&&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id =
&&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id)=
) {
> +                       pr_info("Sclk voltage overdrive not supported\n")=
;
> +                       return 0;
> +               }
> +
> +               for (i =3D 0; i < size; i +=3D 3) {
> +                       if (i + 3 > size) {
> +                               pr_info("invalid clock voltage input\n");
> +                               return 0;
> +                       }
> +
> +                       input_index =3D input[i];
> +                       input_clk =3D input[i + 1];
> +                       input_vol =3D input[i + 2];
> +                       if (input_index > 2 ||
> +                           input_clk < od8_settings[OD8_SETTING_GFXCLK_F=
REQ1 + input_index * 2].min_value ||
> +                           input_clk > od8_settings[OD8_SETTING_GFXCLK_F=
REQ1 + input_index * 2].max_value ||
> +                           input_vol < od8_settings[OD8_SETTING_GFXCLK_V=
OLTAGE1 + input_index * 2].min_value ||
> +                           input_vol > od8_settings[OD8_SETTING_GFXCLK_V=
OLTAGE1 + input_index * 2].max_value) {
> +                               pr_info("input argument is not within all=
owed range\n");
> +                               return -EINVAL;
> +                       }
> +
> +                       switch (input_index) {
> +                       case 0:
> +                               data->od_table.GfxclkFreq1 =3D input_clk;
> +                               data->od_table.GfxclkOffsetVolt1 =3D inpu=
t_vol;
> +                               break;
> +                       case 1:
> +                               data->od_table.GfxclkFreq2 =3D input_clk;
> +                               data->od_table.GfxclkOffsetVolt2 =3D inpu=
t_vol;
> +                               break;
> +                       case 2:
> +                               data->od_table.GfxclkFreq3 =3D input_clk;
> +                               data->od_table.GfxclkOffsetVolt3 =3D inpu=
t_vol;
> +                               break;
> +                       }
> +               }
> +               break;
> +
> +       case PP_OD_EDIT_MCLK_VDDC_TABLE:
> +               pr_info("Mclk voltage overdrive not supported!\n");
> +               break;
> +
> +       case PP_OD_RESTORE_DEFAULT_TABLE:
> +               ret =3D vega20_copy_table_from_smc(hwmgr,
> +                               (uint8_t *)(&od_table),
> +                               TABLE_OVERDRIVE);
> +               PP_ASSERT_WITH_CODE(!ret,
> +                               "Failed to export over drive table!",
> +                               return ret);
> +
> +               memcpy(&data->od_table, &od_table, sizeof(od_table));
> +               break;
> +
> +       case PP_OD_COMMIT_DPM_TABLE:
> +               memcpy(&od_table, &data->od_table, sizeof(od_table));
> +
> +               ret =3D vega20_copy_table_to_smc(hwmgr,
> +                               (uint8_t *)(&od_table),
> +                               TABLE_OVERDRIVE);
> +               PP_ASSERT_WITH_CODE(!ret,
> +                               "Failed to import over drive table!",
> +                               return ret);
> +
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>                 enum pp_clock_type type, char *buf)
>  {
> -       int i, now, size =3D 0;
> +       struct vega20_hwmgr *data =3D
> +                       (struct vega20_hwmgr *)(hwmgr->backend);
> +       struct vega20_od8_single_setting *od8_settings =3D
> +                       data->od8_settings.od8_settings_array;
> +       OverDriveTable_t *od_table =3D &data->od_table;
>         struct pp_clock_levels_with_latency clocks;
> +       int i, now, size =3D 0;
>         int ret =3D 0;
>
>         switch (type) {
> @@ -2551,6 +2659,59 @@ static int vega20_print_clock_levels(struct pp_hwm=
gr *hwmgr,
>         case PP_PCIE:
>                 break;
>
> +       case OD_SCLK:
> +               if (od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_FREQ2].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_FREQ3].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id =
&&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id =
&&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id)=
 {
> +
> +                       size =3D sprintf(buf, "%s:\n", "OD_SCLK");
> +                       size +=3D sprintf(buf + size, "0: %10uMhz %10dmV\=
n",
> +                               od_table->GfxclkFreq1,
> +                               od_table->GfxclkOffsetVolt1);
> +                       size +=3D sprintf(buf + size, "1: %10uMhz %10dmV\=
n",
> +                               od_table->GfxclkFreq2,
> +                               od_table->GfxclkOffsetVolt2);
> +                       size +=3D sprintf(buf + size, "2: %10uMhz %10dmV\=
n",
> +                               od_table->GfxclkFreq3,
> +                               od_table->GfxclkOffsetVolt3);
> +               }
> +               break;
> +
> +       case OD_MCLK:
> +               break;
> +
> +       case OD_RANGE:
> +               if (od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_FREQ2].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_FREQ3].feature_id &&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id =
&&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id =
&&
> +                   od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id)=
 {
> +
> +                       size =3D sprintf(buf, "%s:\n", "OD_RANGE");
> +                       size +=3D sprintf(buf + size, "SCLK[0]: %7uMhz %1=
0uMhz\n",
> +                               od8_settings[OD8_SETTING_GFXCLK_FREQ1].mi=
n_value,
> +                               od8_settings[OD8_SETTING_GFXCLK_FREQ1].ma=
x_value);
> +                       size +=3D sprintf(buf + size, "VDDC[0]: %7dmV %11=
dmV\n",
> +                               od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1]=
.min_value,
> +                               od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1]=
.max_value);
> +                       size +=3D sprintf(buf + size, "SCLK[1]: %7uMhz %1=
0uMhz\n",
> +                               od8_settings[OD8_SETTING_GFXCLK_FREQ2].mi=
n_value,
> +                               od8_settings[OD8_SETTING_GFXCLK_FREQ2].ma=
x_value);
> +                       size +=3D sprintf(buf + size, "VDDC[1]: %7dmV %11=
dmV\n",
> +                               od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2]=
.min_value,
> +                               od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2]=
.max_value);
> +                       size +=3D sprintf(buf + size, "SCLK[2]: %7uMhz %1=
0uMhz\n",
> +                               od8_settings[OD8_SETTING_GFXCLK_FREQ3].mi=
n_value,
> +                               od8_settings[OD8_SETTING_GFXCLK_FREQ3].ma=
x_value);
> +                       size +=3D sprintf(buf + size, "VDDC[2]: %7dmV %11=
dmV\n",
> +                               od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3]=
.min_value,
> +                               od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3]=
.max_value);
> +               }
> +               break;
>         default:
>                 break;
>         }
> @@ -3162,6 +3323,8 @@ static const struct pp_hwmgr_func vega20_hwmgr_func=
s =3D {
>                 vega20_get_mclk_od,
>         .set_mclk_od =3D
>                 vega20_set_mclk_od,
> +       .odn_edit_dpm_table =3D
> +               vega20_odn_edit_dpm_table,
>         /* for sysfs to retrive/set gfxclk/memclk */
>         .force_clock_level =3D
>                 vega20_force_clock_level,
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h b/drivers=
/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
> index 72e4f2a55641..8bb90e22efb6 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h
> @@ -513,6 +513,8 @@ struct vega20_hwmgr {
>         /* ---- Gfxoff ---- */
>         bool                           gfxoff_allowed;
>         uint32_t                       counter_gfxoff;
> +
> +       OverDriveTable_t               od_table;
>  };
>
>  #define VEGA20_DPM2_NEAR_TDP_DEC                      10
> --
> 2.18.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_SN6PR12MB265640239F8818353345E431E4080SN6PR12MB2656namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>Hi Alex,</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>&gt;What about the min/max sclk? Do the curve values take
 that into</span><br style=3D"color: rgb(33, 33, 33); font-family: wf_segoe=
-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans=
-serif, serif, EmojiFont; font-size: 14.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">&gt;account?&nbsp; What about max mclk?</=
span><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>Voltage curve does not take these into consideration. And
 the max sclk and mclk can be set through existing sysfs interface&nbsp;<sp=
an>pp_sclk_od and&nbsp;<span>pp_mclk_od. For min sclk, as i know there is n=
o interface to get it set.</span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><span><span><br>
</span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><span><span><span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-u=
i_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-s=
erif, serif, EmojiFont; font-size: 14.6667px;">&gt;&nbsp;Are
 negative offsets supported?</span><br style=3D"color: rgb(33, 33, 33); fon=
t-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, T=
ahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;">
Sure.</span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><span><span><br>
</span></span></span></p>
<p style=3D"margin-top:0;margin-bottom:0"><font color=3D"#212121" face=3D"w=
f_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, Em=
ojiFont"><span style=3D"font-size: 14.6667px;">Regards,</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font color=3D"#212121" face=3D"w=
f_segoe-ui_normal, Segoe UI, Segoe WP, Tahoma, Arial, sans-serif, serif, Em=
ojiFont"><span style=3D"font-size: 14.6667px;">Evan</span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
><span><span><br>
</span></span></span></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 30, 2018 12:25:35 AM<br>
<b>To:</b> Quan, Evan<br>
<b>Cc:</b> amd-gfx list; Deucher, Alexander; Zhu, Rex<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: added vega20 overdrive suppo=
rt</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Aug 29, 2018 at 5:13 AM Evan Quan &lt;evan=
.quan-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; Vega20 supports only sclk voltage overdrive. And user can<br>
&gt; only tell three groups of &lt;frequency, voltage_offset&gt;. SMU<br>
&gt; firmware will recalculate the frequency/voltage curve. Other<br>
&gt; intermediate levles will be stretched/shrunk accordingly.<br>
&gt;<br>
<br>
What about the min/max sclk? Do the curve values take that into<br>
account?&nbsp; What about max mclk?<br>
<br>
&gt; Change-Id: I403cb38a95863db664cf06d030ac42a19bff6b33<br>
&gt; Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 26 &#43;&#43;&#43;<br>
&gt;&nbsp; .../drm/amd/powerplay/hwmgr/vega20_hwmgr.c&nbsp;&nbsp;&nbsp; | 1=
65 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;-<br>
&gt;&nbsp; .../drm/amd/powerplay/hwmgr/vega20_hwmgr.h&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 2 &#43;<br>
&gt;&nbsp; 3 files changed, 192 insertions(&#43;), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_pm.c<br>
&gt; index e2577518b9c6..6e0c8f583521 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&gt; @@ -474,6 &#43;474,8 @@ static ssize_t amdgpu_set_pp_table(struct devi=
ce *dev,<br>
&gt;&nbsp;&nbsp; * in each power level within a power state.&nbsp; The pp_o=
d_clk_voltage is used for<br>
&gt;&nbsp;&nbsp; * this.<br>
&gt;&nbsp;&nbsp; *<br>
&gt; &#43; * &lt; For Vega10 and previous ASICs &gt;<br>
&gt; &#43; *<br>
&gt;&nbsp;&nbsp; * Reading the file will display:<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * - a list of engine clock levels and voltages labeled OD_=
SCLK<br>
&gt; @@ -491,6 &#43;493,30 @@ static ssize_t amdgpu_set_pp_table(struct dev=
ice *dev,<br>
&gt;&nbsp;&nbsp; * &quot;c&quot; (commit) to the file to commit your change=
s.&nbsp; If you want to reset to the<br>
&gt;&nbsp;&nbsp; * default power levels, write &quot;r&quot; (reset) to the=
 file to reset them.<br>
&gt;&nbsp;&nbsp; *<br>
&gt; &#43; *<br>
&gt; &#43; * &lt; For Vega20 &gt;<br>
&gt; &#43; *<br>
&gt; &#43; * Reading the file will display:<br>
&gt; &#43; *<br>
&gt; &#43; * - three groups of engine clock and voltage offset labeled OD_S=
CLK<br>
&gt; &#43; *<br>
&gt; &#43; * - a list of valid ranges for above three groups of sclk and vo=
ltage offset<br>
&gt; &#43; *&nbsp;&nbsp; labeled OD_RANGE<br>
&gt; &#43; *<br>
&gt; &#43; * To manually adjust these settings:<br>
&gt; &#43; *<br>
&gt; &#43; * - First select manual using power_dpm_force_performance_level<=
br>
&gt; &#43; *<br>
&gt; &#43; * - Enter a new value for each group by writing a string that co=
ntains<br>
&gt; &#43; *&nbsp;&nbsp; &quot;s group_index clock voltage_offset&quot; to =
the file.&nbsp; E.g., &quot;s 0 500 20&quot;<br>
&gt; &#43; *&nbsp;&nbsp; will update group1 sclk to be 500 MHz with voltage=
 increased 20mV<br>
&gt; &#43; *<br>
<br>
Are negative offsets supported?<br>
<br>
Alex<br>
<br>
&gt; &#43; * - When you have edited all of the states as needed, write &quo=
t;c&quot; (commit)<br>
&gt; &#43; *&nbsp;&nbsp; to the file to commit your changes<br>
&gt; &#43; *<br>
&gt; &#43; * - If you want to reset to the default power levels, write &quo=
t;r&quot; (reset)<br>
&gt; &#43; *&nbsp;&nbsp; to the file to reset them<br>
&gt; &#43; *<br>
&gt;&nbsp;&nbsp; */<br>
&gt;<br>
&gt;&nbsp; static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; index ececa2f7fe5f..9f6e070a76e0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c<b=
r>
&gt; @@ -1096,6 &#43;1096,13 @@ static int vega20_od8_initialize_default_se=
ttings(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_copy_table_fr=
om_smc(hwmgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_=
t *)(&amp;data-&gt;od_table),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TABLE_O=
VERDRIVE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;F=
ailed to export over drive table!&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; @@ -2506,11 &#43;2513,112 @@ static int vega20_set_watermarks_for_cloc=
ks_ranges(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;static int vega20_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; enum PP_OD_DPM_TABLE_COMMAND type,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; long *input, uint32_t size)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =
=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct=
 vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_single_set=
ting *od8_settings =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&g=
t;od8_settings.od8_settings_array;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t od_table;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t input_index, input_c=
lk, input_vol, i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(input, &=
quot;NULL user input for clock and voltage&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_EDIT_SCLK_VDDC_TA=
BLE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!(od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id=
 &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_FREQ2].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_FREQ3].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE1].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE2].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE3].feature_id)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info=
(&quot;Sclk voltage overdrive not supported\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; size; i &#43;=3D 3) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i &=
#43; 3 &gt; size) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;invalid clock voltag=
e input\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input_i=
ndex =3D input[i];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input_c=
lk =3D input[i &#43; 1];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; input_v=
ol =3D input[i &#43; 2];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (inp=
ut_index &gt; 2 ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; input_clk &lt; od8_settings[OD8_SETTING_GFXCLK_FREQ1 &#43;=
 input_index * 2].min_value ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; input_clk &gt; od8_settings[OD8_SETTING_GFXCLK_FREQ1 &#43;=
 input_index * 2].max_value ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; input_vol &lt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1 &#=
43; input_index * 2].min_value ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; input_vol &gt; od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1 &#=
43; input_index * 2].max_value) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_info(&quot;input argument is no=
t within allowed range\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch =
(input_index) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;od_table.GfxclkFreq1 =3D =
input_clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;od_table.GfxclkOffsetVolt=
1 =3D input_vol;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;od_table.GfxclkFreq2 =3D =
input_clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;od_table.GfxclkOffsetVolt=
2 =3D input_vol;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;od_table.GfxclkFreq3 =3D =
input_clk;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&gt;od_table.GfxclkOffsetVolt=
3 =3D input_vol;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_EDIT_MCLK_VDDC_TA=
BLE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pr_info(&quot;Mclk voltage overdrive not supported!\n&q=
uot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_RESTORE_DEFAULT_T=
ABLE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D vega20_copy_table_from_smc(hwmgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)(&amp;od_table),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TABLE_OVERDRIVE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to export over drive =
table!&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memcpy(&amp;data-&gt;od_table, &amp;od_table, sizeof(od=
_table));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_OD_COMMIT_DPM_TABLE:=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memcpy(&amp;od_table, &amp;data-&gt;od_table, sizeof(od=
_table));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D vega20_copy_table_to_smc(hwmgr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)(&amp;od_table),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TABLE_OVERDRIVE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;Failed to import over drive =
table!&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; enum pp_clock_type type, char *buf)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, now, size =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_hwmgr *data =
=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (struct=
 vega20_hwmgr *)(hwmgr-&gt;backend);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega20_od8_single_set=
ting *od8_settings =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data-&g=
t;od8_settings.od8_settings_array;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *od_table =
=3D &amp;data-&gt;od_table;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_clock_levels=
_with_latency clocks;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, now, size =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt; @@ -2551,6 &#43;2659,59 @@ static int vega20_print_clock_levels(struct=
 pp_hwmgr *hwmgr,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_PCIE:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OD_SCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id &=
amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_FREQ2].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_FREQ3].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE1].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE2].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE3].feature_id) {<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sprintf(buf, &quot;%s:\n&quot;, &quot;OD_SCLK&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;0: %10uMhz %10dmV\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table-&gt;GfxclkFreq1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table-&gt;GfxclkOffsetVolt1);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;1: %10uMhz %10dmV\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table-&gt;GfxclkFreq2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table-&gt;GfxclkOffsetVolt2);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;2: %10uMhz %10dmV\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table-&gt;GfxclkFreq3,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od_table-&gt;GfxclkOffsetVolt3);<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OD_MCLK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case OD_RANGE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (od8_settings[OD8_SETTING_GFXCLK_FREQ1].feature_id &=
amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_FREQ2].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_FREQ3].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE1].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE2].feature_id &amp;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK=
_VOLTAGE3].feature_id) {<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =
=3D sprintf(buf, &quot;%s:\n&quot;, &quot;OD_RANGE&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;SCLK[0]: %7uMhz %10uMhz\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_FR=
EQ1].min_value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_FR=
EQ1].max_value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;VDDC[0]: %7dmV %11dmV\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_VO=
LTAGE1].min_value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_VO=
LTAGE1].max_value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;SCLK[1]: %7uMhz %10uMhz\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_FR=
EQ2].min_value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_FR=
EQ2].max_value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;VDDC[1]: %7dmV %11dmV\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_VO=
LTAGE2].min_value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_VO=
LTAGE2].max_value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;SCLK[2]: %7uMhz %10uMhz\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_FR=
EQ3].min_value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_FR=
EQ3].max_value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#=
43;=3D sprintf(buf &#43; size, &quot;VDDC[2]: %7dmV %11dmV\n&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_VO=
LTAGE3].min_value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od8_settings[OD8_SETTING_GFXCLK_VO=
LTAGE3].max_value);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -3162,6 &#43;3323,8 @@ static const struct pp_hwmgr_func vega20_hwm=
gr_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; vega20_get_mclk_od,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_mclk_od =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; vega20_set_mclk_od,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .odn_edit_dpm_table =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; vega20_odn_edit_dpm_table,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for sysfs to retriv=
e/set gfxclk/memclk */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_clock_level =3D=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; vega20_force_clock_level,<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h<br>
&gt; index 72e4f2a55641..8bb90e22efb6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.h<b=
r>
&gt; @@ -513,6 &#43;513,8 @@ struct vega20_hwmgr {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ---- Gfxoff ---- */=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfxoff_allo=
wed;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; counter_gfxoff;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; od=
_table;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; #define VEGA20_DPM2_NEAR_TDP_DEC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 10<br>
&gt; --<br>
&gt; 2.18.0<br>
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

--_000_SN6PR12MB265640239F8818353345E431E4080SN6PR12MB2656namp_--

--===============0149335392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0149335392==--
