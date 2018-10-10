From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/5] drm/amdgpu: Extract the function of fw loading out of
 powerplay
Date: Wed, 10 Oct 2018 14:44:38 +0000
Message-ID: <DM5PR12MB1820530605DC768312107AC8F7E00@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1539089023-2360-1-git-send-email-Rex.Zhu@amd.com>
 <1539089023-2360-3-git-send-email-Rex.Zhu@amd.com>
 <CADnq5_NwMRLpqr12KtYt5j67vQfd-5pKN=b8UAU9=G5Nsc_mbA@mail.gmail.com>,
 <BYAPR12MB277578DE7CB42DA32FBC190CFBE00@BYAPR12MB2775.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1932475785=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB277578DE7CB42DA32FBC190CFBE00-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1932475785==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1820530605DC768312107AC8F7E00DM5PR12MB1820namp_"

--_000_DM5PR12MB1820530605DC768312107AC8F7E00DM5PR12MB1820namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sounds good to me.


Alex


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Zhu, Rex=
 <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, October 9, 2018 9:44 PM
To: Alex Deucher
Cc: amd-gfx list
Subject: RE: [PATCH 3/5] drm/amdgpu: Extract the function of fw loading out=
 of powerplay



> -----Original Message-----
> From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Wednesday, October 10, 2018 3:28 AM
> To: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Subject: Re: [PATCH 3/5] drm/amdgpu: Extract the function of fw loading o=
ut
> of powerplay
>
> On Tue, Oct 9, 2018 at 8:45 AM Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:
> >
> > So there is no dependence between gfx/sdma/smu.
> > and for Vi, after IH hw_init, driver load all the smu/gfx/sdma fw. for
> > AI, fw loading is controlled by PSP, after psp hw init, we call the
> > function to check smu fw version.
> >
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 30
> ++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 11 --------
> >  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |  8 ------
> >  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c        | 20 --------------=
-
> >  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h          |  1 -
> >  drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |  8 ++----
> > drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |  5 ----
> >  7 files changed, 32 insertions(+), 51 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 4787571..a6766b3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1525,6 +1525,24 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)
> >         return 0;
> >  }
> >
> > +static int amdgpu_device_fw_loading(struct amdgpu_device *adev,
> > +uint32_t index) {
> > +       int r =3D 0;
> > +
> > +       if ((adev->asic_type < CHIP_VEGA10
> > +            && (adev->ip_blocks[index].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_IH))
> > +            || (adev->asic_type >=3D CHIP_VEGA10
> > +            && (adev->ip_blocks[index].version->type =3D=3D
> > + AMD_IP_BLOCK_TYPE_PSP))) {
>
> This seems kind of fragile.  If we change the order again at some point, =
it will
> break.  How about we check whether hw_init/resume is done or not on the
> blocks we care about or move the checks into the callers and only call wh=
en
> we need it?

Hi Alex,

How about split hw_init to hw_init_phase1 and hw_init_phase2 as resume?
We loaded fw(call psp_hw_init and start_smu) between phase1 and phase2.


Regards
Rex

> > +               if (adev->powerplay.pp_funcs->load_firmware) {
> > +                       r =3D adev->powerplay.pp_funcs->load_firmware(a=
dev-
> >powerplay.pp_handle);
> > +                       if (r) {
> > +                               pr_err("firmware loading failed\n");
> > +                               return r;
> > +                       }
> > +               }
> > +       }
> > +       return 0;
> > +}
> >  /**
> >   * amdgpu_device_ip_init - run init for hardware IPs
> >   *
> > @@ -1595,6 +1613,9 @@ static int amdgpu_device_ip_init(struct
> amdgpu_device *adev)
> >                         return r;
> >                 }
> >                 adev->ip_blocks[i].status.hw =3D true;
> > +               r =3D amdgpu_device_fw_loading(adev, i);
> > +               if (r)
> > +                       return r;
> >         }
> >
> >         amdgpu_xgmi_add_device(adev);
> > @@ -2030,6 +2051,9 @@ static int
> amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
> >                         DRM_INFO("RE-INIT: %s %s\n", block->version->fu=
ncs->name,
> r?"failed":"succeeded");
> >                         if (r)
> >                                 return r;
> > +                       r =3D amdgpu_device_fw_loading(adev, i);
> > +                       if (r)
> > +                               return r;
> >                 }
> >         }
> >
> > @@ -2098,6 +2122,9 @@ static int
> amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
> >                                           adev->ip_blocks[i].version->f=
uncs->name, r);
> >                                 return r;
> >                         }
> > +                       r =3D amdgpu_device_fw_loading(adev, i);
> > +                       if (r)
> > +                               return r;
> >                 }
> >         }
> >
> > @@ -2134,6 +2161,9 @@ static int
> amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
> >                                   adev->ip_blocks[i].version->funcs->na=
me, r);
> >                         return r;
> >                 }
> > +               r =3D amdgpu_device_fw_loading(adev, i);
> > +               if (r)
> > +                       return r;
> >         }
> >
> >         return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index 8439f9a..3d0f277 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -4175,20 +4175,9 @@ static void gfx_v8_0_rlc_start(struct
> > amdgpu_device *adev)
> >
> >  static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)  {
> > -       int r;
> > -
> >         gfx_v8_0_rlc_stop(adev);
> >         gfx_v8_0_rlc_reset(adev);
> >         gfx_v8_0_init_pg(adev);
> > -
> > -       if (adev->powerplay.pp_funcs->load_firmware) {
> > -               r =3D adev->powerplay.pp_funcs->load_firmware(adev-
> >powerplay.pp_handle);
> > -               if (r) {
> > -                       pr_err("firmware loading failed\n");
> > -                       return r;
> > -               }
> > -       }
> > -
> >         gfx_v8_0_rlc_start(adev);
> >
> >         return 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > index 0bdde7f..6fb3eda 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > @@ -788,14 +788,6 @@ static int sdma_v3_0_start(struct amdgpu_device
> > *adev)  {
> >         int r;
> >
> > -       if (adev->powerplay.pp_funcs->load_firmware) {
> > -               r =3D adev->powerplay.pp_funcs->load_firmware(adev-
> >powerplay.pp_handle);
> > -               if (r) {
> > -                       pr_err("firmware loading failed\n");
> > -                       return r;
> > -               }
> > -       }
> > -
> >         /* disable sdma engine before programing it */
> >         sdma_v3_0_ctx_switch_enable(adev, false);
> >         sdma_v3_0_enable(adev, false); diff --git
> > a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> > b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> > index d552af2..47ac923 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> > @@ -89,7 +89,6 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
> >         hwmgr_init_default_caps(hwmgr);
> >         hwmgr_set_user_specify_caps(hwmgr);
> >         hwmgr->fan_ctrl_is_in_default_mode =3D true;
> > -       hwmgr->reload_fw =3D 1;
> >         hwmgr_init_workload_prority(hwmgr);
> >
> >         switch (hwmgr->chip_family) {
> > @@ -209,17 +208,6 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr)  {
> >         int ret =3D 0;
> >
> > -       if (!hwmgr || !hwmgr->smumgr_funcs)
> > -               return -EINVAL;
> > -
> > -       if (hwmgr->smumgr_funcs->start_smu) {
> > -               ret =3D hwmgr->smumgr_funcs->start_smu(hwmgr);
> > -               if (ret) {
> > -                       pr_err("smc start failed\n");
> > -                       return -EINVAL;
> > -               }
> > -       }
> > -
> >         if (!hwmgr->pm_en)
> >                 return 0;
> >
> > @@ -301,7 +289,6 @@ int hwmgr_suspend(struct pp_hwmgr *hwmgr)
> >         if (!hwmgr || !hwmgr->pm_en)
> >                 return 0;
> >
> > -       hwmgr->reload_fw =3D true;
> >         phm_disable_smc_firmware_ctf(hwmgr);
> >         ret =3D psm_set_boot_states(hwmgr);
> >         if (ret)
> > @@ -321,13 +308,6 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)
> >         if (!hwmgr)
> >                 return -EINVAL;
> >
> > -       if (hwmgr->smumgr_funcs && hwmgr->smumgr_funcs->start_smu) {
> > -               if (hwmgr->smumgr_funcs->start_smu(hwmgr)) {
> > -                       pr_err("smc start failed\n");
> > -                       return -EINVAL;
> > -               }
> > -       }
> > -
> >         if (!hwmgr->pm_en)
> >                 return 0;
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > index 35f2272..e5a60aa 100644
> > --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> > @@ -734,7 +734,6 @@ struct pp_hwmgr {
> >         void *smu_backend;
> >         const struct pp_smumgr_func *smumgr_funcs;
> >         bool is_kicker;
> > -       bool reload_fw;
> >
> >         enum PP_DAL_POWERLEVEL dal_power_level;
> >         struct phm_dynamic_state_info dyn_state; diff --git
> > a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> > index 99b4e4f..3f51d54 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
> > @@ -343,9 +343,6 @@ int smu7_request_smu_load_fw(struct pp_hwmgr
> *hwmgr)
> >         uint32_t fw_to_load;
> >         int r =3D 0;
> >
> > -       if (!hwmgr->reload_fw)
> > -               return 0;
> > -
> >         amdgpu_ucode_init_bo(hwmgr->adev);
> >
> >         if (smu_data->soft_regs_start) @@ -432,10 +429,9 @@ int
> > smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
> >         smu7_send_msg_to_smc_with_parameter(hwmgr,
> > PPSMC_MSG_LoadUcodes, fw_to_load);
> >
> >         r =3D smu7_check_fw_load_finish(hwmgr, fw_to_load);
> > -       if (!r) {
> > -               hwmgr->reload_fw =3D 0;
> > +       if (!r)
> >                 return 0;
> > -       }
> > +
> >         pr_err("SMU load firmware failed\n");
> >
> >  failed:
> > diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> > b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> > index abbf2f2..f836d30 100644
> > --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c
> > @@ -661,9 +661,6 @@ static int smu8_request_smu_load_fw(struct
> pp_hwmgr *hwmgr)
> >         uint32_t fw_to_check =3D 0;
> >         int ret;
> >
> > -       if (!hwmgr->reload_fw)
> > -               return 0;
> > -
> >         amdgpu_ucode_init_bo(hwmgr->adev);
> >
> >         smu8_smu_populate_firmware_entries(hwmgr);
> > @@ -719,8 +716,6 @@ static int smu8_request_smu_load_fw(struct
> pp_hwmgr *hwmgr)
> >                 return ret;
> >         }
> >
> > -       hwmgr->reload_fw =3D 0;
> > -
> >         return 0;
> >  }
> >
> > --
> > 1.9.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1820530605DC768312107AC8F7E00DM5PR12MB1820namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Sounds good to me.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Zhu, Rex &lt;Rex.Zhu-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<b>Sent:</b> Tuesday, October 9, 2018 9:44 PM<br>
<b>To:</b> Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 3/5] drm/amdgpu: Extract the function of fw load=
ing out of powerplay</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; Sent: Wednesday, October 10, 2018 3:28 AM<br>
&gt; To: Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
&gt; Subject: Re: [PATCH 3/5] drm/amdgpu: Extract the function of fw loadin=
g out<br>
&gt; of powerplay<br>
&gt; <br>
&gt; On Tue, Oct 9, 2018 at 8:45 AM Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt; wrote:<=
br>
&gt; &gt;<br>
&gt; &gt; So there is no dependence between gfx/sdma/smu.<br>
&gt; &gt; and for Vi, after IH hw_init, driver load all the smu/gfx/sdma fw=
. for<br>
&gt; &gt; AI, fw loading is controlled by PSP, after psp hw init, we call t=
he<br>
&gt; &gt; function to check smu fw version.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 30<br>
&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 11 --------<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 ------<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; | 20 ---------------<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/inc/hwmgr.h&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 1 -<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c |&nbsp; =
8 &#43;&#43;----<br>
&gt; &gt; drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c |&nbsp; 5 ----=
<br>
&gt; &gt;&nbsp; 7 files changed, 32 insertions(&#43;), 51 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index 4787571..a6766b3 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -1525,6 &#43;1525,24 @@ static int amdgpu_device_ip_early_init=
(struct<br>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;static int amdgpu_device_fw_loading(struct amdgpu_device *ad=
ev,<br>
&gt; &gt; &#43;uint32_t index) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type=
 &lt; CHIP_VEGA10<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;&amp; (adev-&gt;ip_blocks[index].version-&gt;type =3D=3D<br>
&gt; AMD_IP_BLOCK_TYPE_IH))<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; || (adev-&gt;asic_type &gt;=3D CHIP_VEGA10<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &amp;&amp; (adev-&gt;ip_blocks[index].version-&gt;type =3D=3D<br>
&gt; &gt; &#43; AMD_IP_BLOCK_TYPE_PSP))) {<br>
&gt; <br>
&gt; This seems kind of fragile.&nbsp; If we change the order again at some=
 point, it will<br>
&gt; break.&nbsp; How about we check whether hw_init/resume is done or not =
on the<br>
&gt; blocks we care about or move the checks into the callers and only call=
 when<br>
&gt; we need it?<br>
<br>
Hi Alex,<br>
<br>
How about split hw_init to hw_init_phase1 and hw_init_phase2 as resume?<br>
We loaded fw(call psp_hw_init and start_smu) between phase1 and phase2.<br>
<br>
<br>
Regards<br>
Rex<br>
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_funcs-&gt;load_firmware)=
 {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D adev-&gt;powerplay.pp_funcs-&gt;load_firmware(adev-<br>
&gt; &gt;powerplay.pp_handle);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (r) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;firmware loading=
 failed\n&quot;);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; &#43;}<br>
&gt; &gt;&nbsp; /**<br>
&gt; &gt;&nbsp;&nbsp; * amdgpu_device_ip_init - run init for hardware IPs<b=
r>
&gt; &gt;&nbsp;&nbsp; *<br>
&gt; &gt; @@ -1595,6 &#43;1613,9 @@ static int amdgpu_device_ip_init(struct=
<br>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.hw =3D true;<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_fw_loading(adev, i);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn r;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_add_d=
evice(adev);<br>
&gt; &gt; @@ -2030,6 &#43;2051,9 @@ static int<br>
&gt; amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; DRM_INFO(&quot;RE-INIT: %s %s\n&quot;, block-&gt;version-&gt;funcs-&gt;=
name,<br>
&gt; r?&quot;failed&quot;:&quot;succeeded&quot;);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (r)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_device_fw_loading(adev, i);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (r)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; @@ -2098,6 &#43;2122,9 @@ static int<br>
&gt; amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].version-&gt;func=
s-&gt;name, r);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =
=3D amdgpu_device_fw_loading(adev, i);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (r)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; @@ -2134,6 &#43;2161,9 @@ static int<br>
&gt; amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip=
_blocks[i].version-&gt;funcs-&gt;name, r);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return r;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_fw_loading(adev, i);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn r;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &gt; index 8439f9a..3d0f277 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &gt; @@ -4175,20 &#43;4175,9 @@ static void gfx_v8_0_rlc_start(struct<=
br>
&gt; &gt; amdgpu_device *adev)<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; static int gfx_v8_0_rlc_resume(struct amdgpu_device *adev)&=
nbsp; {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_rlc_stop=
(adev);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_rlc_rese=
t(adev);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_init_pg(=
adev);<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_f=
uncs-&gt;load_firmware) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;powerplay.pp_funcs-&gt;load_firmware(ad=
ev-<br>
&gt; &gt;powerplay.pp_handle);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err=
(&quot;firmware loading failed\n&quot;);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 r;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_rlc_star=
t(adev);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; &gt; index 0bdde7f..6fb3eda 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; &gt; @@ -788,14 &#43;788,6 @@ static int sdma_v3_0_start(struct amdgpu=
_device<br>
&gt; &gt; *adev)&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.pp_f=
uncs-&gt;load_firmware) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; r =3D adev-&gt;powerplay.pp_funcs-&gt;load_firmware(ad=
ev-<br>
&gt; &gt;powerplay.pp_handle);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (r) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err=
(&quot;firmware loading failed\n&quot;);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 r;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable sdma e=
ngine before programing it */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v3_0_ctx_swi=
tch_enable(adev, false);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v3_0_enable(=
adev, false); diff --git<br>
&gt; &gt; a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt; &gt; index d552af2..47ac923 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c<br>
&gt; &gt; @@ -89,7 &#43;89,6 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr=
)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_init_defaul=
t_caps(hwmgr);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_set_user_sp=
ecify_caps(hwmgr);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;fan_ctr=
l_is_in_default_mode =3D true;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;reload_fw =3D 1;<=
br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr_init_worklo=
ad_prority(hwmgr);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (hwmgr-&gt=
;chip_family) {<br>
&gt; &gt; @@ -209,17 &#43;208,6 @@ int hwmgr_hw_init(struct pp_hwmgr *hwmgr=
)&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br=
>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hwmgr-&gt;sm=
umgr_funcs)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-=
&gt;start_smu) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; ret =3D hwmgr-&gt;smumgr_funcs-&gt;start_smu(hwmgr);<b=
r>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err=
(&quot;smc start failed\n&quot;);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 -EINVAL;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm=
_en)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;<br>
&gt; &gt; @@ -301,7 &#43;289,6 @@ int hwmgr_suspend(struct pp_hwmgr *hwmgr)=
<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr || !hw=
mgr-&gt;pm_en)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;reload_fw =3D tru=
e;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_disable_smc_f=
irmware_ctf(hwmgr);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psm_set_b=
oot_states(hwmgr);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt; &gt; @@ -321,13 &#43;308,6 @@ int hwmgr_resume(struct pp_hwmgr *hwmgr)=
<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs =
&amp;&amp; hwmgr-&gt;smumgr_funcs-&gt;start_smu) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;smumgr_funcs-&gt;start_smu(hwmgr)) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err=
(&quot;smc start failed\n&quot;);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return=
 -EINVAL;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;pm=
_en)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; index 35f2272..e5a60aa 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h<br>
&gt; &gt; @@ -734,7 &#43;734,6 @@ struct pp_hwmgr {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *smu_backend=
;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct pp_s=
mumgr_func *smumgr_funcs;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_kicker;<b=
r>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool reload_fw;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_DAL_POWER=
LEVEL dal_power_level;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct phm_dynami=
c_state_info dyn_state; diff --git<br>
&gt; &gt; a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&gt; &gt; index 99b4e4f..3f51d54 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumg=
r.c<br>
&gt; &gt; @@ -343,9 &#43;343,6 @@ int smu7_request_smu_load_fw(struct pp_hw=
mgr<br>
&gt; *hwmgr)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw_to_lo=
ad;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;reload_fw)<b=
r>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_init=
_bo(hwmgr-&gt;adev);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (smu_data-&gt;=
soft_regs_start) @@ -432,10 &#43;429,9 @@ int<br>
&gt; &gt; smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu7_send_msg_to_=
smc_with_parameter(hwmgr,<br>
&gt; &gt; PPSMC_MSG_LoadUcodes, fw_to_load);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D smu7_check_=
fw_load_finish(hwmgr, fw_to_load);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; hwmgr-&gt;reload_fw =3D 0;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;SMU =
load firmware failed\n&quot;);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; failed:<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<b=
r>
&gt; &gt; b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
&gt; &gt; index abbf2f2..f836d30 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumgr.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/smu8_smumg=
r.c<br>
&gt; &gt; @@ -661,9 &#43;661,6 @@ static int smu8_request_smu_load_fw(struc=
t<br>
&gt; pp_hwmgr *hwmgr)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fw_to_ch=
eck =3D 0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;reload_fw)<b=
r>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_init=
_bo(hwmgr-&gt;adev);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu8_smu_populate=
_firmware_entries(hwmgr);<br>
&gt; &gt; @@ -719,8 &#43;716,6 @@ static int smu8_request_smu_load_fw(struc=
t<br>
&gt; pp_hwmgr *hwmgr)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;reload_fw =3D 0;<=
br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; 1.9.1<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" id=3D"LPlnk554620" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk111319" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.free=
desktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1820530605DC768312107AC8F7E00DM5PR12MB1820namp_--

--===============1932475785==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1932475785==--
