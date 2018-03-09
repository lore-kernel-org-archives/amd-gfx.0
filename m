From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/8] drm/amd/pp: Refine code for smu7 in powerplay
Date: Fri, 9 Mar 2018 10:55:58 +0000
Message-ID: <CY4PR12MB168736E41ADC884B48DF5171FBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1520419570-28831-1-git-send-email-Rex.Zhu@amd.com>,
 <CADnq5_OeOQwxo6pMsrDEdCgwYK06cEq3bU7ztF+nvAFHmVQ-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_OeOQwxo6pMsrDEdCgwYK06cEq3bU7ztF+nvAFHmVQ-yw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--_004_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_"

--_000_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


The avfs btc state is only used in driver and not interact with HW.

and we only need to know whether this feature is supported or not by HW.

so delete the complex define of avfs btc state and simplify related code.

Please review the attached patch.


Best Regards

Rex

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, March 8, 2018 1:12 AM
To: Zhu, Rex
Cc: amd-gfx list
Subject: Re: [PATCH 1/8] drm/amd/pp: Refine code for smu7 in powerplay

On Wed, Mar 7, 2018 at 5:46 AM, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> 1. Add avfs_support in hwmgr to avoid to visit smu backend struct in
>    hwmgr.so do not need to include smu7_smumgr.h under hwmgr folder.
> 2. simplify the list of enum AVFS_BTC_STATUS
>
> Change-Id: I04c769972deff797229339f3ccb1c442b35768a2
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c        | 14 ++---------=
---
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h               |  2 +-
>  drivers/gpu/drm/amd/powerplay/inc/smumgr.h              | 10 +---------
>  drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c      |  4 +++-
>  drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c |  4 +++-
>  5 files changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> index d4d1d2e..da25e7f 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> @@ -40,7 +40,6 @@
>
>  #include "hwmgr.h"
>  #include "smu7_hwmgr.h"
> -#include "smu7_smumgr.h"
>  #include "smu_ucode_xfer_vi.h"
>  #include "smu7_powertune.h"
>  #include "smu7_dyn_defaults.h"
> @@ -1353,12 +1352,7 @@ static int smu7_enable_dpm_tasks(struct pp_hwmgr *=
hwmgr)
>
>  static int smu7_avfs_control(struct pp_hwmgr *hwmgr, bool enable)
>  {
> -       struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->sm=
u_backend);
> -
> -       if (smu_data =3D=3D NULL)
> -               return -EINVAL;
> -
> -       if (smu_data->avfs.avfs_btc_status =3D=3D AVFS_BTC_NOTSUPPORTED)
> +       if (!hwmgr->avfs_supported)
>                 return 0;
>
>         if (enable) {
> @@ -1382,13 +1376,9 @@ static int smu7_avfs_control(struct pp_hwmgr *hwmg=
r, bool enable)
>
>  static int smu7_update_avfs(struct pp_hwmgr *hwmgr)
>  {
> -       struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->sm=
u_backend);
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
>
> -       if (smu_data =3D=3D NULL)
> -               return -EINVAL;
> -
> -       if (smu_data->avfs.avfs_btc_status =3D=3D AVFS_BTC_NOTSUPPORTED)
> +       if (!hwmgr->avfs_supported)
>                 return 0;
>
>         if (data->need_update_smu7_dpm_table & DPMTABLE_OD_UPDATE_VDDC) {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/=
amd/powerplay/inc/hwmgr.h
> index b151ad85..312fbc3 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -748,7 +748,7 @@ struct pp_hwmgr {
>         struct pp_power_state    *uvd_ps;
>         struct amd_pp_display_configuration display_config;
>         uint32_t feature_mask;
> -
> +       bool avfs_supported;
>         /* UMD Pstate */
>         bool en_umd_pstate;
>         uint32_t power_profile_mode;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/drm=
/amd/powerplay/inc/smumgr.h
> index 9bba0a0..f0ef02a 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h
> @@ -28,23 +28,15 @@
>
>  enum AVFS_BTC_STATUS {
>         AVFS_BTC_BOOT =3D 0,
> -       AVFS_BTC_BOOT_STARTEDSMU,
>         AVFS_LOAD_VIRUS,
>         AVFS_BTC_VIRUS_LOADED,
>         AVFS_BTC_VIRUS_FAIL,
>         AVFS_BTC_COMPLETED_PREVIOUSLY,
>         AVFS_BTC_ENABLEAVFS,
> -       AVFS_BTC_STARTED,
>         AVFS_BTC_FAILED,
> -       AVFS_BTC_RESTOREVFT_FAILED,
> -       AVFS_BTC_SAVEVFT_FAILED,
>         AVFS_BTC_DPMTABLESETUP_FAILED,
> -       AVFS_BTC_COMPLETED_UNSAVED,
> -       AVFS_BTC_COMPLETED_SAVED,
> -       AVFS_BTC_COMPLETED_RESTORED,
>         AVFS_BTC_DISABLED,
> -       AVFS_BTC_NOTSUPPORTED,
> -       AVFS_BTC_SMUMSG_ERROR
> +       AVFS_BTC_NOTSUPPORTED
>  };

This isn't used to interact with the hw anywhere is it?  If so, this
will break that.  It should probably be split out as a separate patch
since it's not really directly related to the rest of this patch.
With those addresses this patch is:
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

>
>  enum SMU_TABLE {
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> index 0b2b5d1..573c9be 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
> @@ -360,8 +360,10 @@ static bool fiji_is_hw_avfs_present(struct pp_hwmgr =
*hwmgr)
>
>         if (!atomctrl_read_efuse(hwmgr->device, AVFS_EN_LSB, AVFS_EN_MSB,
>                         mask, &efuse)) {
> -               if (efuse)
> +               if (efuse) {
> +                       hwmgr->avfs_supported =3D true;
>                         return true;
> +               }
>         }
>         return false;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/dr=
ivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> index 632d1ca..1075ec1 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
> @@ -357,8 +357,10 @@ static bool polaris10_is_hw_avfs_present(struct pp_h=
wmgr *hwmgr)
>
>         efuse =3D cgs_read_ind_register(hwmgr->device, CGS_IND_REG__SMC, =
ixSMU_EFUSE_0 + (49*4));
>         efuse &=3D 0x00000001;
> -       if (efuse)
> +       if (efuse) {
> +               hwmgr->avfs_supported =3D true;
>                 return true;
> +       }
>
>         return false;
>  }
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...



--_000_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">The avfs btc state is only used i=
n driver
<font size=3D"2"><span style=3D"font-size:11pt;">and not interact with HW.<=
/span></font></p>
<p style=3D"margin-top:0;margin-bottom:0"><font size=3D"2"><span style=3D"f=
ont-size:11pt;"></span></font>and we only need to know whether this feature=
 is supported or not by HW.</p>
<p style=3D"margin-top:0;margin-bottom:0">so delete the complex define of a=
vfs btc state and simplify related code.</p>
<p style=3D"margin-top:0;margin-bottom:0">Please review the attached patch.=
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block;width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Alex Deucher &lt;ale=
xdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, March 8, 2018 1:12 AM<br>
<b>To:</b> Zhu, Rex<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 1/8] drm/amd/pp: Refine code for smu7 in powerpl=
ay</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Mar 7, 2018 at 5:46 AM, Rex Zhu &lt;Rex.Zh=
u@amd.com&gt; wrote:<br>
&gt; 1. Add avfs_support in hwmgr to avoid to visit smu backend struct in<b=
r>
&gt;&nbsp;&nbsp;&nbsp; hwmgr.so do not need to include smu7_smumgr.h under =
hwmgr folder.<br>
&gt; 2. simplify the list of enum AVFS_BTC_STATUS<br>
&gt;<br>
&gt; Change-Id: I04c769972deff797229339f3ccb1c442b35768a2<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 14 &#43;&#43;------------<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/smumgr.h&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 10 &#43;--------=
-<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 4 &#43;&#43;&#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c |&nbsp; =
4 &#43;&#43;&#43;-<br>
&gt;&nbsp; 5 files changed, 10 insertions(&#43;), 24 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; index d4d1d2e..da25e7f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
&gt; @@ -40,7 &#43;40,6 @@<br>
&gt;<br>
&gt;&nbsp; #include &quot;hwmgr.h&quot;<br>
&gt;&nbsp; #include &quot;smu7_hwmgr.h&quot;<br>
&gt; -#include &quot;smu7_smumgr.h&quot;<br>
&gt;&nbsp; #include &quot;smu_ucode_xfer_vi.h&quot;<br>
&gt;&nbsp; #include &quot;smu7_powertune.h&quot;<br>
&gt;&nbsp; #include &quot;smu7_dyn_defaults.h&quot;<br>
&gt; @@ -1353,12 &#43;1352,7 @@ static int smu7_enable_dpm_tasks(struct pp_=
hwmgr *hwmgr)<br>
&gt;<br>
&gt;&nbsp; static int smu7_avfs_control(struct pp_hwmgr *hwmgr, bool enable=
)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_data =3D=
 (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_data =3D=3D NULL)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_data-&gt;avfs.avfs_btc_s=
tatus =3D=3D AVFS_BTC_NOTSUPPORTED)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;avfs_supporte=
d)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&gt; @@ -1382,13 &#43;1376,9 @@ static int smu7_avfs_control(struct pp_hwmg=
r *hwmgr, bool enable)<br>
&gt;<br>
&gt;&nbsp; static int smu7_update_avfs(struct pp_hwmgr *hwmgr)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_smumgr *smu_data =3D=
 (struct smu7_smumgr *)(hwmgr-&gt;smu_backend);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu7_hwmgr *dat=
a =3D (struct smu7_hwmgr *)(hwmgr-&gt;backend);<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_data =3D=3D NULL)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_data-&gt;avfs.avfs_btc_s=
tatus =3D=3D AVFS_BTC_NOTSUPPORTED)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;avfs_supporte=
d)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (data-&gt;need_upda=
te_smu7_dpm_table &amp; DPMTABLE_OD_UPDATE_VDDC) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/d=
rm/amd/powerplay/inc/hwmgr.h<br>
&gt; index b151ad85..312fbc3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; @@ -748,7 &#43;748,7 @@ struct pp_hwmgr {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state&=
nbsp;&nbsp;&nbsp; *uvd_ps;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_pp_display_=
configuration display_config;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask;=
<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool avfs_supported;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UMD Pstate */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en_umd_pstate;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t power_profile=
_mode;<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h b/drivers/gpu/=
drm/amd/powerplay/inc/smumgr.h<br>
&gt; index 9bba0a0..f0ef02a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smumgr.h<br>
&gt; @@ -28,23 &#43;28,15 @@<br>
&gt;<br>
&gt;&nbsp; enum AVFS_BTC_STATUS {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_BOOT =3D 0,<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_BOOT_STARTEDSMU,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_LOAD_VIRUS,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_VIRUS_LOADED,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_VIRUS_FAIL,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_COMPLETED_PRE=
VIOUSLY,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_ENABLEAVFS,<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_STARTED,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_FAILED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_RESTOREVFT_FAILED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_SAVEVFT_FAILED,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_DPMTABLESETUP=
_FAILED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_COMPLETED_UNSAVED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_COMPLETED_SAVED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_COMPLETED_RESTORED,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_DISABLED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_NOTSUPPORTED,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_SMUMSG_ERROR<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVFS_BTC_NOTSUPPORTED<br>
&gt;&nbsp; };<br>
<br>
This isn't used to interact with the hw anywhere is it?&nbsp; If so, this<b=
r>
will break that.&nbsp; It should probably be split out as a separate patch<=
br>
since it's not really directly related to the rest of this patch.<br>
With those addresses this patch is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt;<br>
&gt;&nbsp; enum SMU_TABLE {<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/driv=
ers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
&gt; index 0b2b5d1..573c9be 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c<b=
r>
&gt; @@ -360,8 &#43;360,10 @@ static bool fiji_is_hw_avfs_present(struct pp=
_hwmgr *hwmgr)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atomctrl_read_efu=
se(hwmgr-&gt;device, AVFS_EN_LSB, AVFS_EN_MSB,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; m=
ask, &amp;efuse)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (efuse)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (efuse) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&=
gt;avfs_supported =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b=
/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&gt; index 632d1ca..1075ec1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumg=
r.c<br>
&gt; @@ -357,8 &#43;357,10 @@ static bool polaris10_is_hw_avfs_present(stru=
ct pp_hwmgr *hwmgr)<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; efuse =3D cgs_read_ind=
_register(hwmgr-&gt;device, CGS_IND_REG__SMC, ixSMU_EFUSE_0 &#43; (49*4));<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; efuse &amp;=3D 0x00000=
001;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (efuse)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (efuse) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; hwmgr-&gt;avfs_supported =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a previewremoved=3D"true" id=3D"LPlnk605140" href=3D"https://lists.fr=
eedesktop.org/mailman/listinfo/amd-gfx">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div style=3D"margin-bottom: 20px; overflow: auto; width: 100%; text-indent=
: 0px;" id=3D"LPBorder_GT_15205915258620.2686861345053829">
<table role=3D"presentation" style=3D"width: 90%; background-color: rgb(255=
, 255, 255); position: relative; overflow: auto; padding-top: 20px; padding=
-bottom: 20px; margin-top: 20px; border-top: 1px dotted rgb(200, 200, 200);=
 border-bottom: 1px dotted rgb(200, 200, 200);" id=3D"LPContainer_152059152=
58590.9282736731640967" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td colspan=3D"2" style=3D"vertical-align: top; position: relative; padding=
: 0px; display: table-cell;" id=3D"TextCell_15205915258600.9720307957613028=
">
<div id=3D"LPRemovePreviewContainer_15205915258600.5747894184804376"></div>
<div style=3D"top: 0px; color: rgb(0, 120, 215); font-weight: 400; font-siz=
e: 21px; font-family: &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&qu=
ot;,&quot;Segoe WP Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Ta=
homa,Arial,sans-serif; line-height: 21px;" id=3D"LPTitle_15205915258600.642=
0531425137407">
<a target=3D"_blank" href=3D"https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx" style=3D"text-decoration: none;" id=3D"LPUrlAnchor_15205915258610=
.5529589204654419">amd-gfx Info Page - freedesktop.org</a></div>
<div style=3D"margin: 10px 0px 16px; color: rgb(102, 102, 102); font-weight=
: 400; font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&qu=
ot;Segoe WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 14=
px;" id=3D"LPMetadata_15205915258610.39476917506447184">
lists.freedesktop.org</div>
<div style=3D"display: block; color: rgb(102, 102, 102); font-weight: 400; =
font-family: &quot;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Sego=
e WP&quot;,Tahoma,Arial,sans-serif; font-size: 14px; line-height: 20px; max=
-height: 100px; overflow: hidden;" id=3D"LPDescription_15205915258620.74430=
88027813343">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_--

--_004_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_
Content-Type: text/x-patch;
	name="0001-drm-amd-pp-Simplified-the-avfs-btc-state-on-smu7.patch"
Content-Description: 0001-drm-amd-pp-Simplified-the-avfs-btc-state-on-smu7.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-pp-Simplified-the-avfs-btc-state-on-smu7.patch";
	size=15296; creation-date="Fri, 09 Mar 2018 10:55:55 GMT";
	modification-date="Fri, 09 Mar 2018 10:55:55 GMT"
Content-Transfer-Encoding: base64

RnJvbSBjODFiZjFjM2FjOWU2MDU0YzUzYTEyNWQ1YmI0OTBhMmNhZWUwZjA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+CkRhdGU6IEZyaSwg
OSBNYXIgMjAxOCAxODowNzo1OSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWQvcHA6IFNp
bXBsaWZpZWQgdGhlIGF2ZnMgYnRjIHN0YXRlIG9uIHNtdTcKCkFWRlMgZmVhdHVyZSBzdXBwb3J0
L25vdCBzdXBwb3J0IGlzIGVub3VnaCB0byBkcml2ZXIuCgpzbyByZW1vdmUgdGhlIGNvbXBsZXgg
ZGVmaW5lIG9mIHRoZSBhdmZzIGJ0YyBzdGF0ZS4KCkNoYW5nZS1JZDogSWMxOWI3YjZiMmE1Yzdj
Zjc4MjE5NjMzZTc4NThkOGQ3M2VhMDJlMjQKU2lnbmVkLW9mZi1ieTogUmV4IFpodSA8UmV4Llpo
dUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdf
aHdtZ3IuYyAgIHwgMTQgKy0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2h3
bWdyLmggICAgICAgICAgfCAgMiArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5j
L3NtdW1nci5oICAgICAgICAgfCAyMSAtLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L3NtdW1nci9maWppX3NtdW1nci5jIHwgNzAgKysrKysrLS0tLS0tLS0tLS0tCiAuLi4vZHJt
L2FtZC9wb3dlcnBsYXkvc211bWdyL3BvbGFyaXMxMF9zbXVtZ3IuYyAgICB8IDgzICsrKysrKyst
LS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9zbXU3
X3NtdW1nci5jIHwgIDQgKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9z
bXU3X3NtdW1nci5oIHwgIDcgKy0KIDcgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwg
MTUwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJw
bGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3
bWdyL3NtdTdfaHdtZ3IuYwppbmRleCBkNGQxZDJlLi5kYTI1ZTdmIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCkBAIC00MCw3ICs0MCw2
IEBACiAKICNpbmNsdWRlICJod21nci5oIgogI2luY2x1ZGUgInNtdTdfaHdtZ3IuaCIKLSNpbmNs
dWRlICJzbXU3X3NtdW1nci5oIgogI2luY2x1ZGUgInNtdV91Y29kZV94ZmVyX3ZpLmgiCiAjaW5j
bHVkZSAic211N19wb3dlcnR1bmUuaCIKICNpbmNsdWRlICJzbXU3X2R5bl9kZWZhdWx0cy5oIgpA
QCAtMTM1MywxMiArMTM1Miw3IEBAIHN0YXRpYyBpbnQgc211N19lbmFibGVfZHBtX3Rhc2tzKHN0
cnVjdCBwcF9od21nciAqaHdtZ3IpCiAKIHN0YXRpYyBpbnQgc211N19hdmZzX2NvbnRyb2woc3Ry
dWN0IHBwX2h3bWdyICpod21nciwgYm9vbCBlbmFibGUpCiB7Ci0Jc3RydWN0IHNtdTdfc211bWdy
ICpzbXVfZGF0YSA9IChzdHJ1Y3Qgc211N19zbXVtZ3IgKikoaHdtZ3ItPnNtdV9iYWNrZW5kKTsK
LQotCWlmIChzbXVfZGF0YSA9PSBOVUxMKQotCQlyZXR1cm4gLUVJTlZBTDsKLQotCWlmIChzbXVf
ZGF0YS0+YXZmcy5hdmZzX2J0Y19zdGF0dXMgPT0gQVZGU19CVENfTk9UU1VQUE9SVEVEKQorCWlm
ICghaHdtZ3ItPmF2ZnNfc3VwcG9ydGVkKQogCQlyZXR1cm4gMDsKIAogCWlmIChlbmFibGUpIHsK
QEAgLTEzODIsMTMgKzEzNzYsOSBAQCBzdGF0aWMgaW50IHNtdTdfYXZmc19jb250cm9sKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IsIGJvb2wgZW5hYmxlKQogCiBzdGF0aWMgaW50IHNtdTdfdXBkYXRl
X2F2ZnMoc3RydWN0IHBwX2h3bWdyICpod21ncikKIHsKLQlzdHJ1Y3Qgc211N19zbXVtZ3IgKnNt
dV9kYXRhID0gKHN0cnVjdCBzbXU3X3NtdW1nciAqKShod21nci0+c211X2JhY2tlbmQpOwogCXN0
cnVjdCBzbXU3X2h3bWdyICpkYXRhID0gKHN0cnVjdCBzbXU3X2h3bWdyICopKGh3bWdyLT5iYWNr
ZW5kKTsKIAotCWlmIChzbXVfZGF0YSA9PSBOVUxMKQotCQlyZXR1cm4gLUVJTlZBTDsKLQotCWlm
IChzbXVfZGF0YS0+YXZmcy5hdmZzX2J0Y19zdGF0dXMgPT0gQVZGU19CVENfTk9UU1VQUE9SVEVE
KQorCWlmICghaHdtZ3ItPmF2ZnNfc3VwcG9ydGVkKQogCQlyZXR1cm4gMDsKIAogCWlmIChkYXRh
LT5uZWVkX3VwZGF0ZV9zbXU3X2RwbV90YWJsZSAmIERQTVRBQkxFX09EX1VQREFURV9WRERDKSB7
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9od21nci5oCmluZGV4IGIxNTFhZDg1
Li4zMTJmYmMzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMv
aHdtZ3IuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvaHdtZ3IuaApA
QCAtNzQ4LDcgKzc0OCw3IEBAIHN0cnVjdCBwcF9od21nciB7CiAJc3RydWN0IHBwX3Bvd2VyX3N0
YXRlICAgICp1dmRfcHM7CiAJc3RydWN0IGFtZF9wcF9kaXNwbGF5X2NvbmZpZ3VyYXRpb24gZGlz
cGxheV9jb25maWc7CiAJdWludDMyX3QgZmVhdHVyZV9tYXNrOwotCisJYm9vbCBhdmZzX3N1cHBv
cnRlZDsKIAkvKiBVTUQgUHN0YXRlICovCiAJYm9vbCBlbl91bWRfcHN0YXRlOwogCXVpbnQzMl90
IHBvd2VyX3Byb2ZpbGVfbW9kZTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L2luYy9zbXVtZ3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9z
bXVtZ3IuaAppbmRleCA5YmJhMGEwLi4xOTA0OGIwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9pbmMvc211bWdyLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
b3dlcnBsYXkvaW5jL3NtdW1nci5oCkBAIC0yNiwyNyArMjYsNiBAQAogI2luY2x1ZGUgImFtZF9w
b3dlcnBsYXkuaCIKICNpbmNsdWRlICJod21nci5oIgogCi1lbnVtIEFWRlNfQlRDX1NUQVRVUyB7
Ci0JQVZGU19CVENfQk9PVCA9IDAsCi0JQVZGU19CVENfQk9PVF9TVEFSVEVEU01VLAotCUFWRlNf
TE9BRF9WSVJVUywKLQlBVkZTX0JUQ19WSVJVU19MT0FERUQsCi0JQVZGU19CVENfVklSVVNfRkFJ
TCwKLQlBVkZTX0JUQ19DT01QTEVURURfUFJFVklPVVNMWSwKLQlBVkZTX0JUQ19FTkFCTEVBVkZT
LAotCUFWRlNfQlRDX1NUQVJURUQsCi0JQVZGU19CVENfRkFJTEVELAotCUFWRlNfQlRDX1JFU1RP
UkVWRlRfRkFJTEVELAotCUFWRlNfQlRDX1NBVkVWRlRfRkFJTEVELAotCUFWRlNfQlRDX0RQTVRB
QkxFU0VUVVBfRkFJTEVELAotCUFWRlNfQlRDX0NPTVBMRVRFRF9VTlNBVkVELAotCUFWRlNfQlRD
X0NPTVBMRVRFRF9TQVZFRCwKLQlBVkZTX0JUQ19DT01QTEVURURfUkVTVE9SRUQsCi0JQVZGU19C
VENfRElTQUJMRUQsCi0JQVZGU19CVENfTk9UU1VQUE9SVEVELAotCUFWRlNfQlRDX1NNVU1TR19F
UlJPUgotfTsKLQogZW51bSBTTVVfVEFCTEUgewogCVNNVV9VVkRfVEFCTEUgPSAwLAogCVNNVV9W
Q0VfVEFCTEUsCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVt
Z3IvZmlqaV9zbXVtZ3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9m
aWppX3NtdW1nci5jCmluZGV4IDBiMmI1ZDEuLmVkMmUyZTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jCkBAIC0yMDUsOSArMjA1
LDkgQEAgc3RhdGljIGludCBmaWppX3N0YXJ0X2F2ZnNfYnRjKHN0cnVjdCBwcF9od21nciAqaHdt
Z3IpCiAJaW50IHJlc3VsdCA9IDA7CiAJc3RydWN0IHNtdTdfc211bWdyICpzbXVfZGF0YSA9IChz
dHJ1Y3Qgc211N19zbXVtZ3IgKikoaHdtZ3ItPnNtdV9iYWNrZW5kKTsKIAotCWlmICgwICE9IHNt
dV9kYXRhLT5hdmZzLmF2ZnNfYnRjX3BhcmFtKSB7CisJaWYgKDAgIT0gc211X2RhdGEtPmF2ZnNf
YnRjX3BhcmFtKSB7CiAJCWlmICgwICE9IHNtdTdfc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1l
dGVyKGh3bWdyLAotCQkJCVBQU01DX01TR19QZXJmb3JtQnRjLCBzbXVfZGF0YS0+YXZmcy5hdmZz
X2J0Y19wYXJhbSkpIHsKKwkJCQlQUFNNQ19NU0dfUGVyZm9ybUJ0Yywgc211X2RhdGEtPmF2ZnNf
YnRjX3BhcmFtKSkgewogCQkJcHJfaW5mbygiW0FWRlNdW0ZpamlfUGVyZm9ybUJ0Y10gUGVyZm9y
bUJUQyBTTVUgbXNnIGZhaWxlZCIpOwogCQkJcmVzdWx0ID0gLUVJTlZBTDsKIAkJfQpAQCAtMjYx
LDQzICsyNjEsMjEgQEAgc3RhdGljIGludCBmaWppX3NldHVwX2dyYXBoaWNzX2xldmVsX3N0cnVj
dHVyZShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCXJldHVybiAwOwogfQogCi1zdGF0aWMgaW50
IGZpamlfYXZmc19ldmVudF9tZ3Ioc3RydWN0IHBwX2h3bWdyICpod21nciwgYm9vbCBzbXVfc3Rh
cnRlZCkKK3N0YXRpYyBpbnQgZmlqaV9hdmZzX2V2ZW50X21ncihzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyKQogewotCXN0cnVjdCBzbXU3X3NtdW1nciAqc211X2RhdGEgPSAoc3RydWN0IHNtdTdfc211
bWdyICopKGh3bWdyLT5zbXVfYmFja2VuZCk7Ci0KLQlzd2l0Y2ggKHNtdV9kYXRhLT5hdmZzLmF2
ZnNfYnRjX3N0YXR1cykgewotCWNhc2UgQVZGU19CVENfQ09NUExFVEVEX1BSRVZJT1VTTFk6Ci0J
CWJyZWFrOworCVBQX0FTU0VSVF9XSVRIX0NPREUoMCA9PSBmaWppX3NldHVwX2dyYXBoaWNzX2xl
dmVsX3N0cnVjdHVyZShod21nciksCisJCQkiW0FWRlNdW2ZpamlfYXZmc19ldmVudF9tZ3JdIENv
dWxkIG5vdCBDb3B5IEdyYXBoaWNzIExldmVsIgorCQkJIiB0YWJsZSBvdmVyIHRvIFNNVSIsCisJ
CQlyZXR1cm4gLUVJTlZBTCk7CisJUFBfQVNTRVJUX1dJVEhfQ09ERSgwID09IHNtdTdfc2V0dXBf
cHdyX3ZpcnVzKGh3bWdyKSwKKwkJCSJbQVZGU11bZmlqaV9hdmZzX2V2ZW50X21ncl0gQ291bGQg
bm90IHNldHVwICIKKwkJCSJQd3IgVmlydXMgZm9yIEFWRlMgIiwKKwkJCXJldHVybiAtRUlOVkFM
KTsKKwlQUF9BU1NFUlRfV0lUSF9DT0RFKDAgPT0gZmlqaV9zdGFydF9hdmZzX2J0Yyhod21nciks
CisJCQkiW0FWRlNdW2ZpamlfYXZmc19ldmVudF9tZ3JdIEZhaWx1cmUgYXQgIgorCQkJImZpamlf
c3RhcnRfYXZmc19idGMuIEFWRlMgRGlzYWJsZWQiLAorCQkJcmV0dXJuIC1FSU5WQUwpOwogCi0J
Y2FzZSBBVkZTX0JUQ19CT09UOiAvKkNvbGQgQm9vdCBTdGF0ZSAtIFBvc3QgU01VIFN0YXJ0Ki8K
LQkJaWYgKCFzbXVfc3RhcnRlZCkKLQkJCWJyZWFrOwotCQlzbXVfZGF0YS0+YXZmcy5hdmZzX2J0
Y19zdGF0dXMgPSBBVkZTX0JUQ19GQUlMRUQ7Ci0JCVBQX0FTU0VSVF9XSVRIX0NPREUoMCA9PSBm
aWppX3NldHVwX2dyYXBoaWNzX2xldmVsX3N0cnVjdHVyZShod21nciksCi0JCQkJIltBVkZTXVtm
aWppX2F2ZnNfZXZlbnRfbWdyXSBDb3VsZCBub3QgQ29weSBHcmFwaGljcyBMZXZlbCIKLQkJCQki
IHRhYmxlIG92ZXIgdG8gU01VIiwKLQkJCQlyZXR1cm4gLUVJTlZBTDspOwotCQlzbXVfZGF0YS0+
YXZmcy5hdmZzX2J0Y19zdGF0dXMgPSBBVkZTX0JUQ19WSVJVU19GQUlMOwotCQlQUF9BU1NFUlRf
V0lUSF9DT0RFKDAgPT0gc211N19zZXR1cF9wd3JfdmlydXMoaHdtZ3IpLAotCQkJCSJbQVZGU11b
ZmlqaV9hdmZzX2V2ZW50X21ncl0gQ291bGQgbm90IHNldHVwICIKLQkJCQkiUHdyIFZpcnVzIGZv
ciBBVkZTICIsCi0JCQkJcmV0dXJuIC1FSU5WQUw7KTsKLQkJc211X2RhdGEtPmF2ZnMuYXZmc19i
dGNfc3RhdHVzID0gQVZGU19CVENfRkFJTEVEOwotCQlQUF9BU1NFUlRfV0lUSF9DT0RFKDAgPT0g
ZmlqaV9zdGFydF9hdmZzX2J0Yyhod21nciksCi0JCQkJIltBVkZTXVtmaWppX2F2ZnNfZXZlbnRf
bWdyXSBGYWlsdXJlIGF0ICIKLQkJCQkiZmlqaV9zdGFydF9hdmZzX2J0Yy4gQVZGUyBEaXNhYmxl
ZCIsCi0JCQkJcmV0dXJuIC1FSU5WQUw7KTsKLQotCQlzbXVfZGF0YS0+YXZmcy5hdmZzX2J0Y19z
dGF0dXMgPSBBVkZTX0JUQ19FTkFCTEVBVkZTOwotCQlicmVhazsKLQljYXNlIEFWRlNfQlRDX0RJ
U0FCTEVEOiAvKiBEbyBub3RoaW5nICovCi0JY2FzZSBBVkZTX0JUQ19OT1RTVVBQT1JURUQ6IC8q
IERvIG5vdGhpbmcgKi8KLQljYXNlIEFWRlNfQlRDX0VOQUJMRUFWRlM6Ci0JCWJyZWFrOwotCWRl
ZmF1bHQ6Ci0JCXByX2VycigiQVZGUyBmYWlsZWQgc3RhdHVzIGlzICV4ICFcbiIsIHNtdV9kYXRh
LT5hdmZzLmF2ZnNfYnRjX3N0YXR1cyk7Ci0JCWJyZWFrOwotCX0KIAlyZXR1cm4gMDsKIH0KIApA
QCAtMzA5LDggKzI4Nyw2IEBAIHN0YXRpYyBpbnQgZmlqaV9zdGFydF9zbXUoc3RydWN0IHBwX2h3
bWdyICpod21ncikKIAkvKiBPbmx5IHN0YXJ0IFNNQyBpZiBTTUMgUkFNIGlzIG5vdCBydW5uaW5n
ICovCiAJaWYgKCEoc211N19pc19zbWNfcmFtX3J1bm5pbmcoaHdtZ3IpCiAJCXx8IGNnc19pc192
aXJ0dWFsaXphdGlvbl9lbmFibGVkKGh3bWdyLT5kZXZpY2UpKSkgewotCQlmaWppX2F2ZnNfZXZl
bnRfbWdyKGh3bWdyLCBmYWxzZSk7Ci0KIAkJLyogQ2hlY2sgaWYgU01VIGlzIHJ1bm5pbmcgaW4g
cHJvdGVjdGVkIG1vZGUgKi8KIAkJaWYgKDAgPT0gUEhNX1JFQURfVkZQRl9JTkRJUkVDVF9GSUVM
RChod21nci0+ZGV2aWNlLAogCQkJCUNHU19JTkRfUkVHX19TTUMsCkBAIC0zMjMsNyArMjk5LDgg
QEAgc3RhdGljIGludCBmaWppX3N0YXJ0X3NtdShzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogCQkJ
aWYgKHJlc3VsdCkKIAkJCQlyZXR1cm4gcmVzdWx0OwogCQl9Ci0JCWZpamlfYXZmc19ldmVudF9t
Z3IoaHdtZ3IsIHRydWUpOworCQlpZiAoZmlqaV9hdmZzX2V2ZW50X21ncihod21ncikpCisJCQlo
d21nci0+YXZmc19zdXBwb3J0ZWQgPSBmYWxzZTsKIAl9CiAKIAkvKiBUbyBpbml0aWFsaXplIGFs
bCBjbG9jayBnYXRpbmcgYmVmb3JlIFJMQyBsb2FkZWQgYW5kIHJ1bm5pbmcuKi8KQEAgLTIzMTUs
MTkgKzIyOTIsMTIgQEAgc3RhdGljIGludCBmaWppX3RoZXJtYWxfc2V0dXBfZmFuX3RhYmxlKHN0
cnVjdCBwcF9od21nciAqaHdtZ3IpCiAKIHN0YXRpYyBpbnQgZmlqaV90aGVybWFsX2F2ZnNfZW5h
YmxlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiB7Ci0JaW50IHJldDsKLQlzdHJ1Y3Qgc211N19z
bXVtZ3IgKnNtdV9kYXRhID0gKHN0cnVjdCBzbXU3X3NtdW1nciAqKShod21nci0+c211X2JhY2tl
bmQpOwotCi0JaWYgKHNtdV9kYXRhLT5hdmZzLmF2ZnNfYnRjX3N0YXR1cyAhPSBBVkZTX0JUQ19F
TkFCTEVBVkZTKQorCWlmICghaHdtZ3ItPmF2ZnNfc3VwcG9ydGVkKQogCQlyZXR1cm4gMDsKIAot
CXJldCA9IHNtdW1fc2VuZF9tc2dfdG9fc21jKGh3bWdyLCBQUFNNQ19NU0dfRW5hYmxlQXZmcyk7
CisJc211bV9zZW5kX21zZ190b19zbWMoaHdtZ3IsIFBQU01DX01TR19FbmFibGVBdmZzKTsKIAot
CWlmICghcmV0KQotCQkvKiBJZiB0aGlzIHBhcmFtIGlzIG5vdCBjaGFuZ2VkLCB0aGlzIGZ1bmN0
aW9uIGNvdWxkIGZpcmUgdW5uZWNlc3NhcmlseSAqLwotCQlzbXVfZGF0YS0+YXZmcy5hdmZzX2J0
Y19zdGF0dXMgPSBBVkZTX0JUQ19DT01QTEVURURfUFJFVklPVVNMWTsKLQotCXJldHVybiByZXQ7
CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgZmlqaV9wcm9ncmFtX21lbV90aW1pbmdfcGFy
YW1ldGVycyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3BvbGFyaXMxMF9zbXVtZ3IuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9wb2xhcmlzMTBfc211bWdyLmMKaW5kZXggNjMyZDFj
YS4uMDYwOWFjZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211
bWdyL3BvbGFyaXMxMF9zbXVtZ3IuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9zbXVtZ3IvcG9sYXJpczEwX3NtdW1nci5jCkBAIC05OSwxMyArOTksMTMgQEAgc3RhdGljIGlu
dCBwb2xhcmlzMTBfcGVyZm9ybV9idGMoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAlpbnQgcmVz
dWx0ID0gMDsKIAlzdHJ1Y3Qgc211N19zbXVtZ3IgKnNtdV9kYXRhID0gKHN0cnVjdCBzbXU3X3Nt
dW1nciAqKShod21nci0+c211X2JhY2tlbmQpOwogCi0JaWYgKDAgIT0gc211X2RhdGEtPmF2ZnMu
YXZmc19idGNfcGFyYW0pIHsKLQkJaWYgKDAgIT0gc211N19zZW5kX21zZ190b19zbWNfd2l0aF9w
YXJhbWV0ZXIoaHdtZ3IsIFBQU01DX01TR19QZXJmb3JtQnRjLCBzbXVfZGF0YS0+YXZmcy5hdmZz
X2J0Y19wYXJhbSkpIHsKKwlpZiAoMCAhPSBzbXVfZGF0YS0+YXZmc19idGNfcGFyYW0pIHsKKwkJ
aWYgKDAgIT0gc211N19zZW5kX21zZ190b19zbWNfd2l0aF9wYXJhbWV0ZXIoaHdtZ3IsIFBQU01D
X01TR19QZXJmb3JtQnRjLCBzbXVfZGF0YS0+YXZmc19idGNfcGFyYW0pKSB7CiAJCQlwcl9pbmZv
KCJbQVZGU11bU211UG9sYXJpczEwX1BlcmZvcm1CdGNdIFBlcmZvcm1CVEMgU01VIG1zZyBmYWls
ZWQiKTsKIAkJCXJlc3VsdCA9IC0xOwogCQl9CiAJfQotCWlmIChzbXVfZGF0YS0+YXZmcy5hdmZz
X2J0Y19wYXJhbSA+IDEpIHsKKwlpZiAoc211X2RhdGEtPmF2ZnNfYnRjX3BhcmFtID4gMSkgewog
CQkvKiBTb2Z0LVJlc2V0IHRvIHJlc2V0IHRoZSBlbmdpbmUgYmVmb3JlIGxvYWRpbmcgdUNvZGUg
Ki8KIAkJLyogaGFsdCAqLwogCQljZ3Nfd3JpdGVfcmVnaXN0ZXIoaHdtZ3ItPmRldmljZSwgbW1D
UF9NRUNfQ05UTCwgMHg1MDAwMDAwMCk7CkBAIC0xNzMsNDYgKzE3MywyNSBAQCBzdGF0aWMgaW50
IHBvbGFyaXMxMF9zZXR1cF9ncmFwaGljc19sZXZlbF9zdHJ1Y3R1cmUoc3RydWN0IHBwX2h3bWdy
ICpod21ncikKIAogCiBzdGF0aWMgaW50Ci1wb2xhcmlzMTBfYXZmc19ldmVudF9tZ3Ioc3RydWN0
IHBwX2h3bWdyICpod21nciwgYm9vbCBTTVVfVkZUX0lOVEFDVCkKK3BvbGFyaXMxMF9hdmZzX2V2
ZW50X21ncihzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogewogCXN0cnVjdCBzbXU3X3NtdW1nciAq
c211X2RhdGEgPSAoc3RydWN0IHNtdTdfc211bWdyICopKGh3bWdyLT5zbXVfYmFja2VuZCk7CiAK
LQlzd2l0Y2ggKHNtdV9kYXRhLT5hdmZzLmF2ZnNfYnRjX3N0YXR1cykgewotCWNhc2UgQVZGU19C
VENfQ09NUExFVEVEX1BSRVZJT1VTTFk6Ci0JCWJyZWFrOwotCi0JY2FzZSBBVkZTX0JUQ19CT09U
OiAvKiBDb2xkIEJvb3QgU3RhdGUgLSBQb3N0IFNNVSBTdGFydCAqLwotCi0JCXNtdV9kYXRhLT5h
dmZzLmF2ZnNfYnRjX3N0YXR1cyA9IEFWRlNfQlRDX0RQTVRBQkxFU0VUVVBfRkFJTEVEOwotCQlQ
UF9BU1NFUlRfV0lUSF9DT0RFKDAgPT0gcG9sYXJpczEwX3NldHVwX2dyYXBoaWNzX2xldmVsX3N0
cnVjdHVyZShod21nciksCi0JCQkiW0FWRlNdW1BvbGFyaXMxMF9BVkZTRXZlbnRNZ3JdIENvdWxk
IG5vdCBDb3B5IEdyYXBoaWNzIExldmVsIHRhYmxlIG92ZXIgdG8gU01VIiwKLQkJCXJldHVybiAt
RUlOVkFMKTsKLQotCQlpZiAoc211X2RhdGEtPmF2ZnMuYXZmc19idGNfcGFyYW0gPiAxKSB7Ci0J
CQlwcl9pbmZvKCJbQVZGU11bUG9sYXJpczEwX0FWRlNFdmVudE1ncl0gQUMgQlRDIGhhcyBub3Qg
YmVlbiBzdWNjZXNzZnVsbHkgdmVyaWZpZWQgb24gRmlqaS4gVGhlcmUgbWF5IGJlIGluIHRoaXMg
c2V0dGluZy4iKTsKLQkJCXNtdV9kYXRhLT5hdmZzLmF2ZnNfYnRjX3N0YXR1cyA9IEFWRlNfQlRD
X1ZJUlVTX0ZBSUw7Ci0JCQlQUF9BU1NFUlRfV0lUSF9DT0RFKDAgPT0gc211N19zZXR1cF9wd3Jf
dmlydXMoaHdtZ3IpLAotCQkJIltBVkZTXVtQb2xhcmlzMTBfQVZGU0V2ZW50TWdyXSBDb3VsZCBu
b3Qgc2V0dXAgUHdyIFZpcnVzIGZvciBBVkZTICIsCi0JCQlyZXR1cm4gLUVJTlZBTCk7Ci0JCX0K
KwlQUF9BU1NFUlRfV0lUSF9DT0RFKDAgPT0gcG9sYXJpczEwX3NldHVwX2dyYXBoaWNzX2xldmVs
X3N0cnVjdHVyZShod21nciksCisJCSJbQVZGU11bUG9sYXJpczEwX0FWRlNFdmVudE1ncl0gQ291
bGQgbm90IENvcHkgR3JhcGhpY3MgTGV2ZWwgdGFibGUgb3ZlciB0byBTTVUiLAorCQlyZXR1cm4g
LUVJTlZBTCk7CiAKLQkJc211X2RhdGEtPmF2ZnMuYXZmc19idGNfc3RhdHVzID0gQVZGU19CVENf
RkFJTEVEOwotCQlQUF9BU1NFUlRfV0lUSF9DT0RFKDAgPT0gcG9sYXJpczEwX3BlcmZvcm1fYnRj
KGh3bWdyKSwKLQkJCQkJIltBVkZTXVtQb2xhcmlzMTBfQVZGU0V2ZW50TWdyXSBGYWlsdXJlIGF0
IFNtdVBvbGFyaXMxMF9QZXJmb3JtQlRDLiBBVkZTIERpc2FibGVkIiwKLQkJCQkgcmV0dXJuIC1F
SU5WQUwpOwotCQlzbXVfZGF0YS0+YXZmcy5hdmZzX2J0Y19zdGF0dXMgPSBBVkZTX0JUQ19FTkFC
TEVBVkZTOwotCQlicmVhazsKLQotCWNhc2UgQVZGU19CVENfRElTQUJMRUQ6Ci0JY2FzZSBBVkZT
X0JUQ19FTkFCTEVBVkZTOgotCWNhc2UgQVZGU19CVENfTk9UU1VQUE9SVEVEOgotCQlicmVhazsK
LQotCWRlZmF1bHQ6Ci0JCXByX2VycigiQVZGUyBmYWlsZWQgc3RhdHVzIGlzICV4IVxuIiwgc211
X2RhdGEtPmF2ZnMuYXZmc19idGNfc3RhdHVzKTsKLQkJYnJlYWs7CisJaWYgKHNtdV9kYXRhLT5h
dmZzX2J0Y19wYXJhbSA+IDEpIHsKKwkJcHJfaW5mbygiW0FWRlNdW1BvbGFyaXMxMF9BVkZTRXZl
bnRNZ3JdIEFDIEJUQyBoYXMgbm90IGJlZW4gc3VjY2Vzc2Z1bGx5IHZlcmlmaWVkIG9uIEZpamku
IFRoZXJlIG1heSBiZSBpbiB0aGlzIHNldHRpbmcuIik7CisJCVBQX0FTU0VSVF9XSVRIX0NPREUo
MCA9PSBzbXU3X3NldHVwX3B3cl92aXJ1cyhod21nciksCisJCSJbQVZGU11bUG9sYXJpczEwX0FW
RlNFdmVudE1ncl0gQ291bGQgbm90IHNldHVwIFB3ciBWaXJ1cyBmb3IgQVZGUyAiLAorCQlyZXR1
cm4gLUVJTlZBTCk7CiAJfQogCisJUFBfQVNTRVJUX1dJVEhfQ09ERSgwID09IHBvbGFyaXMxMF9w
ZXJmb3JtX2J0Yyhod21nciksCisJCQkJIltBVkZTXVtQb2xhcmlzMTBfQVZGU0V2ZW50TWdyXSBG
YWlsdXJlIGF0IFNtdVBvbGFyaXMxMF9QZXJmb3JtQlRDLiBBVkZTIERpc2FibGVkIiwKKwkJCSBy
ZXR1cm4gLUVJTlZBTCk7CisKIAlyZXR1cm4gMDsKIH0KIApAQCAtMzEyLDExICsyOTEsMTAgQEAg
c3RhdGljIGludCBwb2xhcmlzMTBfc3RhcnRfc211KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiB7
CiAJaW50IHJlc3VsdCA9IDA7CiAJc3RydWN0IHBvbGFyaXMxMF9zbXVtZ3IgKnNtdV9kYXRhID0g
KHN0cnVjdCBwb2xhcmlzMTBfc211bWdyICopKGh3bWdyLT5zbXVfYmFja2VuZCk7Ci0JYm9vbCBT
TVVfVkZUX0lOVEFDVDsKIAogCS8qIE9ubHkgc3RhcnQgU01DIGlmIFNNQyBSQU0gaXMgbm90IHJ1
bm5pbmcgKi8KLQlpZiAoIXNtdTdfaXNfc21jX3JhbV9ydW5uaW5nKGh3bWdyKSkgewotCQlTTVVf
VkZUX0lOVEFDVCA9IGZhbHNlOworCWlmICghKHNtdTdfaXNfc21jX3JhbV9ydW5uaW5nKGh3bWdy
KQorCQl8fCBjZ3NfaXNfdmlydHVhbGl6YXRpb25fZW5hYmxlZChod21nci0+ZGV2aWNlKSkpIHsK
IAkJc211X2RhdGEtPnByb3RlY3RlZF9tb2RlID0gKHVpbnQ4X3QpIChQSE1fUkVBRF9WRlBGX0lO
RElSRUNUX0ZJRUxEKGh3bWdyLT5kZXZpY2UsIENHU19JTkRfUkVHX19TTUMsIFNNVV9GSVJNV0FS
RSwgU01VX01PREUpKTsKIAkJc211X2RhdGEtPnNtdTdfZGF0YS5zZWN1cml0eV9oYXJkX2tleSA9
ICh1aW50OF90KSAoUEhNX1JFQURfVkZQRl9JTkRJUkVDVF9GSUVMRChod21nci0+ZGV2aWNlLCBD
R1NfSU5EX1JFR19fU01DLCBTTVVfRklSTVdBUkUsIFNNVV9TRUwpKTsKIApAQCAtMzM3LDExICsz
MTUsOSBAQCBzdGF0aWMgaW50IHBvbGFyaXMxMF9zdGFydF9zbXUoc3RydWN0IHBwX2h3bWdyICpo
d21ncikKIAkJaWYgKHJlc3VsdCAhPSAwKQogCQkJUFBfQVNTRVJUX1dJVEhfQ09ERSgwLCAiRmFp
bGVkIHRvIGxvYWQgU01VIHVjb2RlLiIsIHJldHVybiByZXN1bHQpOwogCi0JCXBvbGFyaXMxMF9h
dmZzX2V2ZW50X21ncihod21nciwgdHJ1ZSk7Ci0JfSBlbHNlCi0JCVNNVV9WRlRfSU5UQUNUID0g
dHJ1ZTsgLypEcml2ZXIgd2VudCBvZmZsaW5lIGJ1dCBTTVUgd2FzIHN0aWxsIGFsaXZlIGFuZCBj
b250YWlucyB0aGUgVkZUIHRhYmxlICovCisJCXBvbGFyaXMxMF9hdmZzX2V2ZW50X21ncihod21n
cik7CisJfQogCi0JcG9sYXJpczEwX2F2ZnNfZXZlbnRfbWdyKGh3bWdyLCBTTVVfVkZUX0lOVEFD
VCk7CiAJLyogU2V0dXAgU29mdFJlZ3NTdGFydCBoZXJlIGZvciByZWdpc3RlciBsb29rdXAgaW4g
Y2FzZSBEdW1teUJhY2tFbmQgaXMgdXNlZCBhbmQgUHJvY2Vzc0Zpcm13YXJlSGVhZGVyIGlzIG5v
dCBleGVjdXRlZCAqLwogCXNtdTdfcmVhZF9zbWNfc3JhbV9kd29yZChod21nciwgU01VN19GSVJN
V0FSRV9IRUFERVJfTE9DQVRJT04gKyBvZmZzZXRvZihTTVU3NF9GaXJtd2FyZV9IZWFkZXIsIFNv
ZnRSZWdpc3RlcnMpLAogCQkJCQkmKHNtdV9kYXRhLT5zbXU3X2RhdGEuc29mdF9yZWdzX3N0YXJ0
KSwgMHg0MDAwMCk7CkBAIC0xNzMyLDggKzE3MDgsOCBAQCBzdGF0aWMgaW50IHBvbGFyaXMxMF9w
b3B1bGF0ZV9hdmZzX3BhcmFtZXRlcnMoc3RydWN0IHBwX2h3bWdyICpod21ncikKIAkJCXRhYmxl
X2luZm8tPnZkZF9kZXBfb25fc2NsazsKIAogCi0JaWYgKCgoc3RydWN0IHNtdTdfc211bWdyICop
c211X2RhdGEpLT5hdmZzLmF2ZnNfYnRjX3N0YXR1cyA9PSBBVkZTX0JUQ19OT1RTVVBQT1JURUQp
Ci0JCXJldHVybiByZXN1bHQ7CisJaWYgKCFod21nci0+YXZmc19zdXBwb3J0ZWQpCisJCXJldHVy
biAwOwogCiAJcmVzdWx0ID0gYXRvbWN0cmxfZ2V0X2F2ZnNfaW5mb3JtYXRpb24oaHdtZ3IsICZh
dmZzX3BhcmFtcyk7CiAKQEAgLTIwNzAsMjQgKzIwNDYsMTcgQEAgc3RhdGljIGludCBwb2xhcmlz
MTBfcHJvZ3JhbV9tZW1fdGltaW5nX3BhcmFtZXRlcnMoc3RydWN0IHBwX2h3bWdyICpod21ncikK
IAogaW50IHBvbGFyaXMxMF90aGVybWFsX2F2ZnNfZW5hYmxlKHN0cnVjdCBwcF9od21nciAqaHdt
Z3IpCiB7Ci0JaW50IHJldDsKLQlzdHJ1Y3Qgc211N19zbXVtZ3IgKnNtdV9kYXRhID0gKHN0cnVj
dCBzbXU3X3NtdW1nciAqKShod21nci0+c211X2JhY2tlbmQpOwogCXN0cnVjdCBzbXU3X2h3bWdy
ICpkYXRhID0gKHN0cnVjdCBzbXU3X2h3bWdyICopKGh3bWdyLT5iYWNrZW5kKTsKIAotCWlmIChz
bXVfZGF0YS0+YXZmcy5hdmZzX2J0Y19zdGF0dXMgPT0gQVZGU19CVENfTk9UU1VQUE9SVEVEKQor
CWlmICghaHdtZ3ItPmF2ZnNfc3VwcG9ydGVkKQogCQlyZXR1cm4gMDsKIAotCXJldCA9IHNtdW1f
c2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLAorCXNtdW1fc2VuZF9tc2dfdG9f
c21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLAogCQkJUFBTTUNfTVNHX1NldEdCRHJvb3BTZXR0aW5n
cywgZGF0YS0+YXZmc192ZHJvb3Bfb3ZlcnJpZGVfc2V0dGluZyk7CiAKLQlyZXQgPSAoc211bV9z
ZW5kX21zZ190b19zbWMoaHdtZ3IsIFBQU01DX01TR19FbmFibGVBdmZzKSA9PSAwKSA/Ci0JCQkw
IDogLTE7CisJc211bV9zZW5kX21zZ190b19zbWMoaHdtZ3IsIFBQU01DX01TR19FbmFibGVBdmZz
KTsKIAotCWlmICghcmV0KQotCQkvKiBJZiB0aGlzIHBhcmFtIGlzIG5vdCBjaGFuZ2VkLCB0aGlz
IGZ1bmN0aW9uIGNvdWxkIGZpcmUgdW5uZWNlc3NhcmlseSAqLwotCQlzbXVfZGF0YS0+YXZmcy5h
dmZzX2J0Y19zdGF0dXMgPSBBVkZTX0JUQ19DT01QTEVURURfUFJFVklPVVNMWTsKLQotCXJldHVy
biByZXQ7CisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgcG9sYXJpczEwX3RoZXJtYWxfc2V0
dXBfZmFuX3RhYmxlKHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Ivc211N19zbXVtZ3IuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9zbXU3X3NtdW1nci5jCmluZGV4IDczOTRiYjQuLmIx
OWZmODEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9z
bXU3X3NtdW1nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9z
bXU3X3NtdW1nci5jCkBAIC02MzEsOSArNjMxLDcgQEAgaW50IHNtdTdfaW5pdChzdHJ1Y3QgcHBf
aHdtZ3IgKmh3bWdyKQogCXNtdV9kYXRhLT5zbXVfYnVmZmVyLm1jX2FkZHIgPSBtY19hZGRyOwog
CiAJaWYgKHNtdW1faXNfaHdfYXZmc19wcmVzZW50KGh3bWdyKSkKLQkJc211X2RhdGEtPmF2ZnMu
YXZmc19idGNfc3RhdHVzID0gQVZGU19CVENfQk9PVDsKLQllbHNlCi0JCXNtdV9kYXRhLT5hdmZz
LmF2ZnNfYnRjX3N0YXR1cyA9IEFWRlNfQlRDX05PVFNVUFBPUlRFRDsKKwkJaHdtZ3ItPmF2ZnNf
c3VwcG9ydGVkID0gdHJ1ZTsKIAogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL3NtdTdfc211bWdyLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Ivc211N19zbXVtZ3IuaAppbmRleCA2NDMzNGE4Li4xMjZk
MzAwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Ivc211
N19zbXVtZ3IuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9zbXVtZ3Ivc211
N19zbXVtZ3IuaApAQCAtMzYsMTEgKzM2LDYgQEAgc3RydWN0IHNtdTdfYnVmZmVyX2VudHJ5IHsK
IAlzdHJ1Y3QgYW1kZ3B1X2JvICpoYW5kbGU7CiB9OwogCi1zdHJ1Y3Qgc211N19hdmZzIHsKLQll
bnVtIEFWRlNfQlRDX1NUQVRVUyBhdmZzX2J0Y19zdGF0dXM7Ci0JdWludDMyX3QgICAgICAgICAg
IGF2ZnNfYnRjX3BhcmFtOwotfTsKLQogc3RydWN0IHNtdTdfc211bWdyIHsKIAl1aW50OF90ICpo
ZWFkZXI7CiAJdWludDhfdCAqbWVjX2ltYWdlOwpAQCAtNTUsNyArNTAsNyBAQCBzdHJ1Y3Qgc211
N19zbXVtZ3IgewogCXVpbnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bHZfc2V0
dGluZ19zdGFydHM7CiAJdWludDhfdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlY3Vy
aXR5X2hhcmRfa2V5OwogCXVpbnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhY3Bp
X29wdGltaXphdGlvbjsKLQlzdHJ1Y3Qgc211N19hdmZzICAgICAgICAgICAgICAgICAgICAgYXZm
czsKKwl1aW50MzJfdCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXZmc19idGNfcGFyYW07
CiB9OwogCiAKLS0gCjEuOS4xCgo=

--_004_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_CY4PR12MB168736E41ADC884B48DF5171FBDE0CY4PR12MB1687namp_--
