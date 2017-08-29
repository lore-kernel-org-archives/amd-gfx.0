From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay/hwmgr: Remove null check before kfree
Date: Tue, 29 Aug 2017 14:54:28 +0000
Message-ID: <CY4PR12MB1687CD95DD12AFA8708D06EBFB9F0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1504012347-14702-1-git-send-email-himanshujha199640@gmail.com>,
 <337d5257-2d0a-8482-f8d8-4a44234347d4@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0758316326=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <337d5257-2d0a-8482-f8d8-4a44234347d4-5C7GfCeVMHo@public.gmane.org>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, Himanshu Jha <himanshujha199640-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0758316326==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687CD95DD12AFA8708D06EBFB9F0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687CD95DD12AFA8708D06EBFB9F0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Reviewed-by:  Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>


Best Regards

Rex

________________________________
From: Wentland, Harry
Sent: Tuesday, August 29, 2017 9:34:01 PM
To: Himanshu Jha; airlied-cv59FeDIM0c@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; amd-gfx@=
lists.freedesktop.org; Deucher, Alexander; Zhu, Rex; Koenig, Christian
Subject: Re: [PATCH] drm/amd/powerplay/hwmgr: Remove null check before kfre=
e

On 2017-08-29 09:12 AM, Himanshu Jha wrote:
> kfree on NULL pointer is a no-op and therefore checking is redundant.
>
> Signed-off-by: Himanshu Jha <himanshujha199640-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

Harry

> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |  6 +-
>  .../gpu/drm/amd/powerplay/hwmgr/processpptables.c  | 96 ++++++++--------=
------
>  drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c     | 52 ++++--------
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   | 12 +--
>  4 files changed, 56 insertions(+), 110 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index bc839ff..9f2c037 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -1225,10 +1225,8 @@ static int cz_hwmgr_backend_fini(struct pp_hwmgr *=
hwmgr)
>                phm_destroy_table(hwmgr, &(hwmgr->power_down_asic));
>                phm_destroy_table(hwmgr, &(hwmgr->setup_asic));
>
> -             if (NULL !=3D hwmgr->dyn_state.vddc_dep_on_dal_pwrl) {
> -                     kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> -                     hwmgr->dyn_state.vddc_dep_on_dal_pwrl =3D NULL;
> -             }
> +             kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> +             hwmgr->dyn_state.vddc_dep_on_dal_pwrl =3D NULL;
>
>                kfree(hwmgr->backend);
>                hwmgr->backend =3D NULL;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/driv=
ers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> index 2716721..a6dbc55 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c
> @@ -1615,85 +1615,53 @@ static int pp_tables_uninitialize(struct pp_hwmgr=
 *hwmgr)
>        if (hwmgr->chip_id =3D=3D CHIP_RAVEN)
>                return 0;
>
> -     if (NULL !=3D hwmgr->dyn_state.vddc_dependency_on_sclk) {
> -             kfree(hwmgr->dyn_state.vddc_dependency_on_sclk);
> -             hwmgr->dyn_state.vddc_dependency_on_sclk =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.vddc_dependency_on_sclk);
> +     hwmgr->dyn_state.vddc_dependency_on_sclk =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.vddci_dependency_on_mclk) {
> -             kfree(hwmgr->dyn_state.vddci_dependency_on_mclk);
> -             hwmgr->dyn_state.vddci_dependency_on_mclk =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.vddci_dependency_on_mclk);
> +     hwmgr->dyn_state.vddci_dependency_on_mclk =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.vddc_dependency_on_mclk) {
> -             kfree(hwmgr->dyn_state.vddc_dependency_on_mclk);
> -             hwmgr->dyn_state.vddc_dependency_on_mclk =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.vddc_dependency_on_mclk);
> +     hwmgr->dyn_state.vddc_dependency_on_mclk =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.mvdd_dependency_on_mclk) {
> -             kfree(hwmgr->dyn_state.mvdd_dependency_on_mclk);
> -             hwmgr->dyn_state.mvdd_dependency_on_mclk =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.mvdd_dependency_on_mclk);
> +     hwmgr->dyn_state.mvdd_dependency_on_mclk =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.valid_mclk_values) {
> -             kfree(hwmgr->dyn_state.valid_mclk_values);
> -             hwmgr->dyn_state.valid_mclk_values =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.valid_mclk_values);
> +     hwmgr->dyn_state.valid_mclk_values =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.valid_sclk_values) {
> -             kfree(hwmgr->dyn_state.valid_sclk_values);
> -             hwmgr->dyn_state.valid_sclk_values =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.valid_sclk_values);
> +     hwmgr->dyn_state.valid_sclk_values =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.cac_leakage_table) {
> -             kfree(hwmgr->dyn_state.cac_leakage_table);
> -             hwmgr->dyn_state.cac_leakage_table =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.cac_leakage_table);
> +     hwmgr->dyn_state.cac_leakage_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.vddc_phase_shed_limits_table) {
> -             kfree(hwmgr->dyn_state.vddc_phase_shed_limits_table);
> -             hwmgr->dyn_state.vddc_phase_shed_limits_table =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.vddc_phase_shed_limits_table);
> +     hwmgr->dyn_state.vddc_phase_shed_limits_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.vce_clock_voltage_dependency_table) =
{
> -             kfree(hwmgr->dyn_state.vce_clock_voltage_dependency_table);
> -             hwmgr->dyn_state.vce_clock_voltage_dependency_table =3D NUL=
L;
> -     }
> +     kfree(hwmgr->dyn_state.vce_clock_voltage_dependency_table);
> +     hwmgr->dyn_state.vce_clock_voltage_dependency_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.uvd_clock_voltage_dependency_table) =
{
> -             kfree(hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
> -             hwmgr->dyn_state.uvd_clock_voltage_dependency_table =3D NUL=
L;
> -     }
> +     kfree(hwmgr->dyn_state.uvd_clock_voltage_dependency_table);
> +     hwmgr->dyn_state.uvd_clock_voltage_dependency_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.samu_clock_voltage_dependency_table)=
 {
> -             kfree(hwmgr->dyn_state.samu_clock_voltage_dependency_table)=
;
> -             hwmgr->dyn_state.samu_clock_voltage_dependency_table =3D NU=
LL;
> -     }
> +     kfree(hwmgr->dyn_state.samu_clock_voltage_dependency_table);
> +     hwmgr->dyn_state.samu_clock_voltage_dependency_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.acp_clock_voltage_dependency_table) =
{
> -             kfree(hwmgr->dyn_state.acp_clock_voltage_dependency_table);
> -             hwmgr->dyn_state.acp_clock_voltage_dependency_table =3D NUL=
L;
> -     }
> +     kfree(hwmgr->dyn_state.acp_clock_voltage_dependency_table);
> +     hwmgr->dyn_state.acp_clock_voltage_dependency_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.cac_dtp_table) {
> -             kfree(hwmgr->dyn_state.cac_dtp_table);
> -             hwmgr->dyn_state.cac_dtp_table =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.cac_dtp_table);
> +     hwmgr->dyn_state.cac_dtp_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.ppm_parameter_table) {
> -             kfree(hwmgr->dyn_state.ppm_parameter_table);
> -             hwmgr->dyn_state.ppm_parameter_table =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.ppm_parameter_table);
> +     hwmgr->dyn_state.ppm_parameter_table =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.vdd_gfx_dependency_on_sclk) {
> -             kfree(hwmgr->dyn_state.vdd_gfx_dependency_on_sclk);
> -             hwmgr->dyn_state.vdd_gfx_dependency_on_sclk =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.vdd_gfx_dependency_on_sclk);
> +     hwmgr->dyn_state.vdd_gfx_dependency_on_sclk =3D NULL;
>
> -     if (NULL !=3D hwmgr->dyn_state.vq_budgeting_table) {
> -             kfree(hwmgr->dyn_state.vq_budgeting_table);
> -             hwmgr->dyn_state.vq_budgeting_table =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.vq_budgeting_table);
> +     hwmgr->dyn_state.vq_budgeting_table =3D NULL;
>
>        return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> index 2c3e6ba..5547ed3 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c
> @@ -640,40 +640,24 @@ static int rv_hwmgr_backend_fini(struct pp_hwmgr *h=
wmgr)
>        phm_destroy_table(hwmgr, &(hwmgr->power_down_asic));
>        phm_destroy_table(hwmgr, &(hwmgr->setup_asic));
>
> -     if (pinfo->vdd_dep_on_dcefclk) {
> -             kfree(pinfo->vdd_dep_on_dcefclk);
> -             pinfo->vdd_dep_on_dcefclk =3D NULL;
> -     }
> -     if (pinfo->vdd_dep_on_socclk) {
> -             kfree(pinfo->vdd_dep_on_socclk);
> -             pinfo->vdd_dep_on_socclk =3D NULL;
> -     }
> -     if (pinfo->vdd_dep_on_fclk) {
> -             kfree(pinfo->vdd_dep_on_fclk);
> -             pinfo->vdd_dep_on_fclk =3D NULL;
> -     }
> -     if (pinfo->vdd_dep_on_dispclk) {
> -             kfree(pinfo->vdd_dep_on_dispclk);
> -             pinfo->vdd_dep_on_dispclk =3D NULL;
> -     }
> -     if (pinfo->vdd_dep_on_dppclk) {
> -             kfree(pinfo->vdd_dep_on_dppclk);
> -             pinfo->vdd_dep_on_dppclk =3D NULL;
> -     }
> -     if (pinfo->vdd_dep_on_phyclk) {
> -             kfree(pinfo->vdd_dep_on_phyclk);
> -             pinfo->vdd_dep_on_phyclk =3D NULL;
> -     }
> -
> -     if (NULL !=3D hwmgr->dyn_state.vddc_dep_on_dal_pwrl) {
> -             kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> -             hwmgr->dyn_state.vddc_dep_on_dal_pwrl =3D NULL;
> -     }
> -
> -     if (NULL !=3D hwmgr->dyn_state.vq_budgeting_table) {
> -             kfree(hwmgr->dyn_state.vq_budgeting_table);
> -             hwmgr->dyn_state.vq_budgeting_table =3D NULL;
> -     }
> +     kfree(pinfo->vdd_dep_on_dcefclk);
> +     pinfo->vdd_dep_on_dcefclk =3D NULL;
> +     kfree(pinfo->vdd_dep_on_socclk);
> +     pinfo->vdd_dep_on_socclk =3D NULL;
> +     kfree(pinfo->vdd_dep_on_fclk);
> +     pinfo->vdd_dep_on_fclk =3D NULL;
> +     kfree(pinfo->vdd_dep_on_dispclk);
> +     pinfo->vdd_dep_on_dispclk =3D NULL;
> +     kfree(pinfo->vdd_dep_on_dppclk);
> +     pinfo->vdd_dep_on_dppclk =3D NULL;
> +     kfree(pinfo->vdd_dep_on_phyclk);
> +     pinfo->vdd_dep_on_phyclk =3D NULL;
> +
> +     kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> +     hwmgr->dyn_state.vddc_dep_on_dal_pwrl =3D NULL;
> +
> +     kfree(hwmgr->dyn_state.vq_budgeting_table);
> +     hwmgr->dyn_state.vq_budgeting_table =3D NULL;
>
>        kfree(hwmgr->backend);
>        hwmgr->backend =3D NULL;
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index c274323..eb8a3ff 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2282,15 +2282,11 @@ static int smu7_set_private_data_based_on_pptable=
_v0(struct pp_hwmgr *hwmgr)
>
>  static int smu7_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
>  {
> -     if (NULL !=3D hwmgr->dyn_state.vddc_dep_on_dal_pwrl) {
> -             kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> -             hwmgr->dyn_state.vddc_dep_on_dal_pwrl =3D NULL;
> -     }
> +     kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> +     hwmgr->dyn_state.vddc_dep_on_dal_pwrl =3D NULL;
>        pp_smu7_thermal_fini(hwmgr);
> -     if (NULL !=3D hwmgr->backend) {
> -             kfree(hwmgr->backend);
> -             hwmgr->backend =3D NULL;
> -     }
> +     kfree(hwmgr->backend);
> +     hwmgr->backend =3D NULL;
>
>        return 0;
>  }
>

--_000_CY4PR12MB1687CD95DD12AFA8708D06EBFB9F0CY4PR12MB1687namp_
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
<p><br>
</p>
<meta content=3D"text/html; charset=3DUTF-8">
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; co=
lor: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, EmojiFont, =
'Apple Color Emoji', 'Segoe UI Emoji', NotoColorEmoji, 'Segoe UI Symbol', '=
Android Emoji', EmojiSymbols;">
<p><font size=3D"2" style=3D"color: rgb(33, 33, 33); font-family: 'Times Ne=
w Roman', serif, serif, EmojiFont;"><span style=3D"font-size: 10pt;"><span =
style=3D"font-family: Calibri, Helvetica, sans-serif, EmojiFont, 'Apple Col=
or Emoji', 'Segoe UI Emoji', NotoColorEmoji, 'Segoe UI Symbol', 'Android Em=
oji', EmojiSymbols; font-size: 13.3333px;">Reviewed-by:
</span>&nbsp;Rex Zhu &lt;</span></font><a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" t=
arget=3D"_blank" rel=3D"noopener noreferrer" style=3D"font-family: 'Times N=
ew Roman', serif, serif, EmojiFont; font-size: 16px;"><font size=3D"2"><spa=
n style=3D"font-size: 10pt;">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</span></font></a><font size=3D=
"2" style=3D"color: rgb(33, 33, 33); font-family: 'Times New Roman', serif,=
 serif, EmojiFont;"><span style=3D"font-size: 10pt;">&gt;</span></font><br>
</p>
<p><font size=3D"2" style=3D"color: rgb(33, 33, 33); font-family: 'Times Ne=
w Roman', serif, serif, EmojiFont;"><span style=3D"font-size: 10pt;"><br>
</span></font></p>
<p><font size=3D"2" style=3D"color: rgb(33, 33, 33); font-family: 'Times Ne=
w Roman', serif, serif, EmojiFont;"><span style=3D"font-size: 10pt;">Best R=
egards</span></font></p>
<p><font size=3D"2" style=3D"color: rgb(33, 33, 33); font-family: 'Times Ne=
w Roman', serif, serif, EmojiFont;"><span style=3D"font-size: 10pt;">Rex</s=
pan></font></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Wentland, Harry<br>
<b>Sent:</b> Tuesday, August 29, 2017 9:34:01 PM<br>
<b>To:</b> Himanshu Jha; airlied-cv59FeDIM0c@public.gmane.org<br>
<b>Cc:</b> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; a=
md-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Zhu, Rex; Koenig, Christi=
an<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay/hwmgr: Remove null check befo=
re kfree</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 2017-08-29 09:12 AM, Himanshu Jha wrote:<br>
&gt; kfree on NULL pointer is a no-op and therefore checking is redundant.<=
br>
&gt; <br>
&gt; Signed-off-by: Himanshu Jha &lt;himanshujha199640-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<br>
Reviewed-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Harry<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 6 &#43;-<br>
&gt;&nbsp; .../gpu/drm/amd/powerplay/hwmgr/processpptables.c&nbsp; | 96 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--------------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; | 52 &#43;&#43;&#43;&#43;--------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp; | 1=
2 &#43;--<br>
&gt;&nbsp; 4 files changed, 56 insertions(&#43;), 110 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index bc839ff..9f2c037 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -1225,10 &#43;1225,8 @@ static int cz_hwmgr_backend_fini(struct pp_=
hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; phm_destroy_table(hwmgr, &amp;(hwmgr-&gt;power_down_asi=
c));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; phm_destroy_table(hwmgr, &amp;(hwmgr-&gt;setup_asic));<=
br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (NULL !=3D hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_sta=
te.vddc_dep_on_dal_pwrl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vdd=
c_dep_on_dal_pwrl =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; kfree(hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl =3D NULL;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;backend);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hwmgr-&gt;backend =3D NULL;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c b/d=
rivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c<br>
&gt; index 2716721..a6dbc55 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/processpptables.=
c<br>
&gt; @@ -1615,85 &#43;1615,53 @@ static int pp_tables_uninitialize(struct p=
p_hwmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id =3D=3D=
 CHIP_RAVEN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vddc_depen=
dency_on_sclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vddc_dependency_on_sclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vddc_dependency_on_sclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vddc_dependenc=
y_on_sclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddc_dependency_on_s=
clk =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vddci_depe=
ndency_on_mclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vddci_dependency_on_mclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vddci_dependency_on_mclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vddci_dependen=
cy_on_mclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddci_dependency_on_=
mclk =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vddc_depen=
dency_on_mclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vddc_dependency_on_mclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vddc_dependency_on_mclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vddc_dependenc=
y_on_mclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddc_dependency_on_m=
clk =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.mvdd_depen=
dency_on_mclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.mvdd_dependency_on_mclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.mvdd_dependency_on_mclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.mvdd_dependenc=
y_on_mclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.mvdd_dependency_on_m=
clk =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.valid_mclk=
_values) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.valid_mclk_values);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.valid_mclk_values =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.valid_mclk_val=
ues);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.valid_mclk_values =
=3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.valid_sclk=
_values) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.valid_sclk_values);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.valid_sclk_values =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.valid_sclk_val=
ues);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.valid_sclk_values =
=3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.cac_leakag=
e_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.cac_leakage_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.cac_leakage_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.cac_leakage_ta=
ble);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.cac_leakage_table =
=3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vddc_phase=
_shed_limits_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vddc_phase_shed_limits_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vddc_phase_shed_limits_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vddc_phase_she=
d_limits_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddc_phase_shed_limi=
ts_table =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vce_clock_=
voltage_dependency_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vce_clock_voltage_dependency_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vce_clock_voltage_dependency_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vce_clock_volt=
age_dependency_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vce_clock_voltage_de=
pendency_table =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.uvd_clock_=
voltage_dependency_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.uvd_clock_voltage_dependency_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.uvd_clock_voltage_dependency_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.uvd_clock_volt=
age_dependency_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.uvd_clock_voltage_de=
pendency_table =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.samu_clock=
_voltage_dependency_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.samu_clock_voltage_dependency_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.samu_clock_voltage_dependency_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.samu_clock_vol=
tage_dependency_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.samu_clock_voltage_d=
ependency_table =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.acp_clock_=
voltage_dependency_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.acp_clock_voltage_dependency_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.acp_clock_voltage_dependency_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.acp_clock_volt=
age_dependency_table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.acp_clock_voltage_de=
pendency_table =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.cac_dtp_ta=
ble) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.cac_dtp_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.cac_dtp_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.cac_dtp_table)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.cac_dtp_table =3D NU=
LL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.ppm_parame=
ter_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.ppm_parameter_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.ppm_parameter_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.ppm_parameter_=
table);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.ppm_parameter_table =
=3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vdd_gfx_de=
pendency_on_sclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vdd_gfx_dependency_on_sclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vdd_gfx_dependency_on_sclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vdd_gfx_depend=
ency_on_sclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vdd_gfx_dependency_o=
n_sclk =3D NULL;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vq_budgeti=
ng_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vq_budgeting_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vq_budgeting_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vq_budgeting_t=
able);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vq_budgeting_table =
=3D NULL;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; index 2c3e6ba..5547ed3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/rv_hwmgr.c<br>
&gt; @@ -640,40 &#43;640,24 @@ static int rv_hwmgr_backend_fini(struct pp_h=
wmgr *hwmgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_destroy_table(hwmgr, &am=
p;(hwmgr-&gt;power_down_asic));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_destroy_table(hwmgr, &am=
p;(hwmgr-&gt;setup_asic));<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pinfo-&gt;vdd_dep_on_dcefclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(pinfo-&gt;vdd_dep_on_dcefclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pinfo-&gt;vdd_dep_on_dcefclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pinfo-&gt;vdd_dep_on_socclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(pinfo-&gt;vdd_dep_on_socclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pinfo-&gt;vdd_dep_on_socclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pinfo-&gt;vdd_dep_on_fclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(pinfo-&gt;vdd_dep_on_fclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pinfo-&gt;vdd_dep_on_fclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pinfo-&gt;vdd_dep_on_dispclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(pinfo-&gt;vdd_dep_on_dispclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pinfo-&gt;vdd_dep_on_dispclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pinfo-&gt;vdd_dep_on_dppclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(pinfo-&gt;vdd_dep_on_dppclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pinfo-&gt;vdd_dep_on_dppclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (pinfo-&gt;vdd_dep_on_phyclk) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(pinfo-&gt;vdd_dep_on_phyclk);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pinfo-&gt;vdd_dep_on_phyclk =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vddc_dep_o=
n_dal_pwrl) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vq_budgeti=
ng_table) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vq_budgeting_table);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vq_budgeting_table =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pinfo-&gt;vdd_dep_on_dcefclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pinfo-&gt;vdd_dep_on_dcefclk =3D NULL;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pinfo-&gt;vdd_dep_on_socclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pinfo-&gt;vdd_dep_on_socclk =3D NULL;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pinfo-&gt;vdd_dep_on_fclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pinfo-&gt;vdd_dep_on_fclk =3D NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pinfo-&gt;vdd_dep_on_dispclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pinfo-&gt;vdd_dep_on_dispclk =3D NULL;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pinfo-&gt;vdd_dep_on_dppclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pinfo-&gt;vdd_dep_on_dppclk =3D NULL;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(pinfo-&gt;vdd_dep_on_phyclk);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pinfo-&gt;vdd_dep_on_phyclk =3D NULL;<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vddc_dep_on_da=
l_pwrl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl=
 =3D NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vq_budgeting_t=
able);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vq_budgeting_table =
=3D NULL;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;backend);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;backend =3D NULL;<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index c274323..eb8a3ff 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -2282,15 &#43;2282,11 @@ static int smu7_set_private_data_based_on_=
pptable_v0(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp; <br>
&gt;&nbsp; static int smu7_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;dyn_state.vddc_dep_o=
n_dal_pwrl) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;dyn_state.vddc_dep_on_da=
l_pwrl);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;dyn_state.vddc_dep_on_dal_pwrl=
 =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pp_smu7_thermal_fini(hwmgr);=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (NULL !=3D hwmgr-&gt;backend) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; kfree(hwmgr-&gt;backend);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; hwmgr-&gt;backend =3D NULL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;backend);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;backend =3D NULL;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_CY4PR12MB1687CD95DD12AFA8708D06EBFB9F0CY4PR12MB1687namp_--

--===============0758316326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0758316326==--
