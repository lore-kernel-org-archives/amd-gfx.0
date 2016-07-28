From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown before init
Date: Thu, 28 Jul 2016 11:10:40 +0000
Message-ID: <DM5PR12MB1132DA66C4E0B70497D5D121F7000@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160726153832.15191-1-tom.stdenis@amd.com>
 <20160726153832.15191-5-tom.stdenis@amd.com>
 <CADnq5_P5C_Rix2wkUuzABQKtcxOYyQeL7FNBA4GJLy3Fg+o4UQ@mail.gmail.com>,
 <BLUPR12MB0659D45202A93FB726C50D84FB000@BLUPR12MB0659.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0463024020=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0659D45202A93FB726C50D84FB000-7LeqcoF/hwopKKKeNxqxVAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0463024020==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132DA66C4E0B70497D5D121F7000DM5PR12MB1132namp_"

--_000_DM5PR12MB1132DA66C4E0B70497D5D121F7000DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Quick question, how am I meant to get access to pm.mutex from powerplay?


I need a lock I can see around the SMU calls and in the amdgpu side (for us=
erspace locking).


Tom


________________________________
From: Zhu, Rex
Sent: Thursday, July 28, 2016 03:43
To: Alex Deucher; Tom St Denis
Cc: StDenis, Tom; amd-gfx list
Subject: RE: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown before in=
it


From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf Of A=
lex Deucher
Sent: Thursday, July 28, 2016 1:46 PM
To: Tom St Denis
Cc: StDenis, Tom; amd-gfx list
Subject: Re: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown before in=
it

On Tue, Jul 26, 2016 at 11:38 AM, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:
> Because of the ip_blocks init order powerplay would power down the UVD
> block before UVD start is called.  This results in a VCPU hang.
>
> This patch prevents power down before UVD is initialized.
>
> Also correct the power up order so clocking is set after power is
> ungated.
>
> With this applied comparable clock/power behaviour to powerplay=3D0 with
> DPM is observed.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This patch needs to be split into several patches and reworked a bit.
Also, don't include amdgpu.h in powerplay.  We have cgs for access to regis=
ters and data from adev, etc.  The idea is to minimize the dependencies bet=
ween components.  We shouldn't be accessing adev directly in powerplay.  A =
couple more comments inline.


Rex:  I also think so.
1. We can move
+                       WREG32(mmUVD_POWER_STATUS,
+                               UVD_POWER_STATUS__UVD_PG_EN_MASK |
+                               UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+               else
+                       WREG32(mmUVD_POWER_STATUS,
+                               UVD_POWER_STATUS__UVD_PG_EN_MASK);
to uvd_v6_0_start.  no need to visit adev in powerplay and dpm.  And uvd te=
st also can pass.

2.  for the lock, we can just use pm.mutex.

3.  please also delete enable_clock_power_gatings_tasks in resume_action_ch=
ain in a separate patch for powerplay.

4.  do we need to add cg_state, pg_state?



Best Regards
Rex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  6 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |  5 -----
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |  8 ++++---
>  drivers/gpu/drm/amd/amdgpu/vi.c                    | 12 ++++-------
>  .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c  | 25 ++++++++++++++++=
++----
>  drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c     |  7 ++++++
>  6 files changed, 43 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index d0460ea2f85b..5616b16e6c0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1692,6 +1692,7 @@ struct amdgpu_uvd {
>         uint32_t                srbm_soft_reset;
>         int                     cg_state, pg_state;
>         struct mutex            pg_lock;
> +       bool                    is_init;
>  };
>
>  /*
> @@ -2518,5 +2519,10 @@ int amdgpu_dm_display_resume(struct
> amdgpu_device *adev );  static inline int
> amdgpu_dm_display_resume(struct amdgpu_device *adev) { return 0; }
> #endif
>
> +struct amdgpu_cgs_device {
> +       struct cgs_device base;
> +       struct amdgpu_device *adev;
> +};
> +
>  #include "amdgpu_object.h"
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> index ee95e950a19b..d553e399a835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> @@ -33,11 +33,6 @@
>  #include "atom.h"
>  #include "amdgpu_ucode.h"
>
> -struct amdgpu_cgs_device {
> -       struct cgs_device base;
> -       struct amdgpu_device *adev;
> -};
> -
>  #define CGS_FUNC_ADEV                                                  \
>         struct amdgpu_device *adev =3D                                   =
 \
>                 ((struct amdgpu_cgs_device *)cgs_device)->adev diff
> --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 422d5300b92e..3b93327c5e25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -389,9 +389,9 @@ static int uvd_v6_0_start(struct amdgpu_device *adev)
>         uint32_t mp_swap_cntl;
>         int i, j, r;
>
> -       /* is power gated? then we can't start (TODO: re-enable power) */
> -       if (adev->uvd.pg_state)
> -               return -EINVAL;
> +       /* is power gated? then we can't start but don't return an error =
*/
> +       if (adev->uvd.is_init && adev->uvd.pg_state)
> +               return 0;
>
>         /* set CG state to -1 for unset */
>         adev->uvd.cg_state =3D -1;
> @@ -662,6 +662,8 @@ static int uvd_v6_0_ring_test_ring(struct amdgpu_ring=
 *ring)
>                           ring->idx, tmp);
>                 r =3D -EINVAL;
>         }
> +       if (!r)
> +               adev->uvd.is_init =3D true;
>         return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> b/drivers/gpu/drm/amd/amdgpu/vi.c index 78fea940d120..f4fdde0641b0
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> @@ -1583,10 +1583,8 @@ static int vi_common_early_init(void *handle)
>                 if (adev->rev_id !=3D 0x00) {
>                         adev->pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |
>                                 AMD_PG_SUPPORT_GFX_SMG |
> -                               AMD_PG_SUPPORT_GFX_PIPELINE;
> -                       /* powerplay UVD PG doesn't work yet */
> -                       if (!amdgpu_powerplay)
> -                               adev->pg_flags |=3D AMD_PG_SUPPORT_UVD;
> +                               AMD_PG_SUPPORT_GFX_PIPELINE |
> +                               AMD_PG_SUPPORT_UVD;

This should be a separate patch.

>                 }
>                 adev->external_rev_id =3D adev->rev_id + 0x1;
>                 break;
> @@ -1608,10 +1606,8 @@ static int vi_common_early_init(void *handle)
>                         AMD_CG_SUPPORT_SDMA_LS;
>                 adev->pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |
>                         AMD_PG_SUPPORT_GFX_SMG |
> -                       AMD_PG_SUPPORT_GFX_PIPELINE;
> -               /* powerplay UVD PG doesn't work yet */
> -               if (!amdgpu_powerplay)
> -                       adev->pg_flags |=3D AMD_PG_SUPPORT_UVD;
> +                       AMD_PG_SUPPORT_GFX_PIPELINE |
> +                       AMD_PG_SUPPORT_UVD;

Same with this.

>                 adev->external_rev_id =3D adev->rev_id + 0x1;
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
> index 2da548f6337e..baa7366fad53 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c
> @@ -21,9 +21,13 @@
>   *
>   */
>
> +#include "amdgpu.h"
>  #include "hwmgr.h"
>  #include "cz_clockpowergating.h"
>  #include "cz_ppsmc.h"
> +#include "cgs_linux.h"
> +#include "uvd/uvd_6_0_d.h"
> +#include "uvd/uvd_6_0_sh_mask.h"
>
>  /* PhyID -> Status Mapping in DDI_PHY_GEN_STATUS
>      0    GFX0L (3:0),                  (27:24),
> @@ -160,12 +164,24 @@ int cz_enable_disable_vce_dpm(struct pp_hwmgr
> *hwmgr, bool enable)  int cz_dpm_powergate_uvd(struct pp_hwmgr *hwmgr,
> bool bgate)  {
>         struct cz_hwmgr *cz_hwmgr =3D (struct cz_hwmgr
> *)(hwmgr->backend);
> +       struct amdgpu_cgs_device *cgs_dev =3D hwmgr->device;
> +       struct amdgpu_device *adev =3D cgs_dev->adev;
>
> -       if (cz_hwmgr->uvd_power_gated =3D=3D bgate)
> +       if (!adev->uvd.is_init)
>                 return 0;
>
> +       mutex_lock(&adev->uvd.pg_lock);
> +
> +       if (cz_hwmgr->uvd_power_gated =3D=3D bgate) {
> +               mutex_unlock(&adev->uvd.pg_lock);
> +               return 0;
> +       }
> +
> +       adev->uvd.pg_state =3D bgate;
>         cz_hwmgr->uvd_power_gated =3D bgate;
>
> +       WREG32(mmUVD_POWER_STATUS, UVD_POWER_STATUS__UVD_PG_EN_MASK);
> +

Could this be moved to the uvd 6 module?




>         if (bgate) {
>                 cgs_set_clockgating_state(hwmgr->device,
>                                                 AMD_IP_BLOCK_TYPE_UVD,
> @@ -177,14 +193,15 @@ int cz_dpm_powergate_uvd(struct pp_hwmgr *hwmgr, bo=
ol bgate)
>                 cz_dpm_powerdown_uvd(hwmgr);
>         } else {
>                 cz_dpm_powerup_uvd(hwmgr);
> -               cgs_set_clockgating_state(hwmgr->device,
> -                                               AMD_IP_BLOCK_TYPE_UVD,
> -                                               AMD_PG_STATE_GATE);
>                 cgs_set_powergating_state(hwmgr->device,
>                                                 AMD_IP_BLOCK_TYPE_UVD,
>                                                 AMD_CG_STATE_UNGATE);
> +               cgs_set_clockgating_state(hwmgr->device,
> +                                               AMD_IP_BLOCK_TYPE_UVD,
> +                                               AMD_PG_STATE_GATE);

I think this is a standalone fix and should be split into a separate patch.

>                 cz_dpm_update_uvd_dpm(hwmgr, false);
>         }
> +       mutex_unlock(&adev->uvd.pg_lock);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> index 9bf622e123b6..bed0013674a1 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c
> @@ -39,6 +39,7 @@
>  #include "power_state.h"
>  #include "cz_clockpowergating.h"
>  #include "pp_debug.h"
> +#include "amdgpu.h"
>
>  #define ixSMUSVI_NB_CURRENTVID 0xD8230044  #define
> CURRENT_NB_VID_MASK 0xff000000 @@ -1356,6 +1357,12 @@ static int
> cz_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>
>  int cz_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)  {
> +       struct amdgpu_cgs_device *cgs_dev =3D hwmgr->device;
> +       struct amdgpu_device *adev =3D cgs_dev->adev;
> +
> +       if (!adev->uvd.is_init)
> +               return 0;
> +
>         if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
>                                          PHM_PlatformCaps_UVDPowerGating)=
)
>                 return smum_send_msg_to_smc(hwmgr->smumgr,
> --
> 2.9.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB1132DA66C4E0B70497D5D121F7000DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Quick question, how am I meant to get access to pm.mutex from powerplay?=
</p>
<p><br>
</p>
<p>I need a lock I can see around the SMU calls and in the amdgpu side (for=
 userspace locking).</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhu, Rex<br>
<b>Sent:</b> Thursday, July 28, 2016 03:43<br>
<b>To:</b> Alex Deucher; Tom St Denis<br>
<b>Cc:</b> StDenis, Tom; amd-gfx list<br>
<b>Subject:</b> RE: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown be=
fore init</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText"><br>
From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mai=
lto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf Of Alex Deucher<br=
>
Sent: Thursday, July 28, 2016 1:46 PM<br>
To: Tom St Denis<br>
Cc: StDenis, Tom; amd-gfx list<br>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown before in=
it<br>
<br>
On Tue, Jul 26, 2016 at 11:38 AM, Tom St Denis &lt;tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;=
 wrote:<br>
&gt; Because of the ip_blocks init order powerplay would power down the UVD=
 <br>
&gt; block before UVD start is called.&nbsp; This results in a VCPU hang.<b=
r>
&gt;<br>
&gt; This patch prevents power down before UVD is initialized.<br>
&gt;<br>
&gt; Also correct the power up order so clocking is set after power is <br>
&gt; ungated.<br>
&gt;<br>
&gt; With this applied comparable clock/power behaviour to powerplay=3D0 wi=
th <br>
&gt; DPM is observed.<br>
&gt;<br>
&gt; Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
This patch needs to be split into several patches and reworked a bit.<br>
Also, don't include amdgpu.h in powerplay.&nbsp; We have cgs for access to =
registers and data from adev, etc.&nbsp; The idea is to minimize the depend=
encies between components.&nbsp; We shouldn't be accessing adev directly in=
 powerplay.&nbsp; A couple more comments inline.<br>
<br>
<br>
Rex:&nbsp; I also think so. <br>
1. We can move <br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD=
_POWER_STATUS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_PG_EN_MASK |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_PG_MODE_MASK);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD=
_POWER_STATUS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UVD_POWER_STATUS__UVD_PG_EN_MASK);<br>
to uvd_v6_0_start.&nbsp; no need to visit adev in powerplay and dpm.&nbsp; =
And uvd test also can pass.<br>
<br>
2.&nbsp; for the lock, we can just use pm.mutex.<br>
<br>
3.&nbsp; please also delete enable_clock_power_gatings_tasks in resume_acti=
on_chain in a separate patch for powerplay.<br>
&nbsp;&nbsp;&nbsp; <br>
4.&nbsp; do we need to add cg_state, pg_state? <br>
<br>
<br>
<br>
Best Regards<br>
Rex<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 &#4=
3;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 -----<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 8 &#43;&#43;&#4=
3;&#43;---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 12 &#43;&#43;&#43;&#43;-------<br>
&gt;&nbsp; .../drm/amd/powerplay/hwmgr/cz_clockpowergating.c&nbsp; | 25 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;----<br>
&gt;&nbsp; drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 7 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 6 files changed, 43 insertions(&#43;), 20 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; index d0460ea2f85b..5616b16e6c0a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1692,6 &#43;1692,7 @@ struct amdgpu_uvd {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; srbm_soft_reset;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; cg_state, pg_state;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pg_lock;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; is_init;<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt;&nbsp; /*<br>
&gt; @@ -2518,5 &#43;2519,10 @@ int amdgpu_dm_display_resume(struct <br>
&gt; amdgpu_device *adev );&nbsp; static inline int <br>
&gt; amdgpu_dm_display_resume(struct amdgpu_device *adev) { return 0; }&nbs=
p; <br>
&gt; #endif<br>
&gt;<br>
&gt; &#43;struct amdgpu_cgs_device {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cgs_device base;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<=
br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; #include &quot;amdgpu_object.h&quot;<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c<br>
&gt; index ee95e950a19b..d553e399a835 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c<br>
&gt; @@ -33,11 &#43;33,6 @@<br>
&gt;&nbsp; #include &quot;atom.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_ucode.h&quot;<br>
&gt;<br>
&gt; -struct amdgpu_cgs_device {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cgs_device base;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev;<br>
&gt; -};<br>
&gt; -<br>
&gt;&nbsp; #define CGS_FUNC_ADEV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *=
adev =3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; ((struct amdgpu_cgs_device *)cgs_device)-&gt;adev=
 diff <br>
&gt; --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; index 422d5300b92e..3b93327c5e25 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; @@ -389,9 &#43;389,9 @@ static int uvd_v6_0_start(struct amdgpu_device=
 *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mp_swap_cntl;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, j, r;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* is power gated? then we can't=
 start (TODO: re-enable power) */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;uvd.pg_state)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* is power gated? then we c=
an't start but don't return an error */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;uvd.is_init &am=
p;&amp; adev-&gt;uvd.pg_state)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set CG state to -1 =
for unset */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;uvd.cg_state =
=3D -1;<br>
&gt; @@ -662,6 &#43;662,8 @@ static int uvd_v6_0_ring_test_ring(struct amdg=
pu_ring *ring)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ring-&gt;idx, tmp);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;uvd.is_init =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vi.c index 78fea940d120..f4fdde0641b0 <br=
>
&gt; 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&gt; @@ -1583,10 &#43;1583,8 @@ static int vi_common_early_init(void *handl=
e)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;rev_id !=3D 0x00) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; a=
dev-&gt;pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_SMG |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_PIPELINE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* powerpla=
y UVD PG doesn't work yet */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu=
_powerplay)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags |=3D AMD_PG_SUPPORT_=
UVD;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_GFX_PIPELINE |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPPORT_UVD;<br>
<br>
This should be a separate patch.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id &#43=
; 0x1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; @@ -1608,10 &#43;1606,8 @@ static int vi_common_early_init(void *handl=
e)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MD_CG_SUPPORT_SDMA_LS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg_flags |=3D AMD_PG_SUPPORT_GFX_PG |<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MD_PG_SUPPORT_GFX_SMG |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_SUPP=
ORT_GFX_PIPELINE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; /* powerplay UVD PG doesn't work yet */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; if (!amdgpu_powerplay)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;pg=
_flags |=3D AMD_PG_SUPPORT_UVD;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_=
SUPPORT_GFX_PIPELINE |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_=
SUPPORT_UVD;<br>
<br>
Same with this.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;external_rev_id =3D adev-&gt;rev_id &#43=
; 0x1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c=
 <br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c<br>
&gt; index 2da548f6337e..baa7366fad53 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergating.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_clockpowergat=
ing.c<br>
&gt; @@ -21,9 &#43;21,13 @@<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; */<br>
&gt;<br>
&gt; &#43;#include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; #include &quot;hwmgr.h&quot;<br>
&gt;&nbsp; #include &quot;cz_clockpowergating.h&quot;<br>
&gt;&nbsp; #include &quot;cz_ppsmc.h&quot;<br>
&gt; &#43;#include &quot;cgs_linux.h&quot;<br>
&gt; &#43;#include &quot;uvd/uvd_6_0_d.h&quot;<br>
&gt; &#43;#include &quot;uvd/uvd_6_0_sh_mask.h&quot;<br>
&gt;<br>
&gt;&nbsp; /* PhyID -&gt; Status Mapping in DDI_PHY_GEN_STATUS<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; GFX0L (3:0),&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (27:24),<br>
&gt; @@ -160,12 &#43;164,24 @@ int cz_enable_disable_vce_dpm(struct pp_hwmg=
r <br>
&gt; *hwmgr, bool enable)&nbsp; int cz_dpm_powergate_uvd(struct pp_hwmgr *h=
wmgr, <br>
&gt; bool bgate)&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cz_hwmgr *cz_hw=
mgr =3D (struct cz_hwmgr <br>
&gt; *)(hwmgr-&gt;backend);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_cgs_device *cg=
s_dev =3D hwmgr-&gt;device;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D cgs_dev-&gt;adev;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cz_hwmgr-&gt;uvd_power_gated=
 =3D=3D bgate)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;uvd.is_init)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;uvd=
.pg_lock);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cz_hwmgr-&gt;uvd_power_g=
ated =3D=3D bgate) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;uvd.pg_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;uvd.pg_state =3D bg=
ate;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cz_hwmgr-&gt;uvd_power=
_gated =3D bgate;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmUVD_POWER_STATUS, U=
VD_POWER_STATUS__UVD_PG_EN_MASK);<br>
&gt; &#43;<br>
<br>
Could this be moved to the uvd 6 module?<br>
<br>
<br>
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bgate) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; cgs_set_clockgating_state(hwmgr-&gt;device,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_=
BLOCK_TYPE_UVD, <br>
&gt; @@ -177,14 &#43;193,15 @@ int cz_dpm_powergate_uvd(struct pp_hwmgr *hw=
mgr, bool bgate)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; cz_dpm_powerdown_uvd(hwmgr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; cz_dpm_powerup_uvd(hwmgr);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; cgs_set_clockgating_state(hwmgr-&gt;device,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_TYPE=
_UVD,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_GATE=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; cgs_set_powergating_state(hwmgr-&gt;device,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_=
BLOCK_TYPE_UVD,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_=
STATE_UNGATE);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cgs_set_clockgating_state(hwmgr-&gt;device,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_IP_BLOCK_=
TYPE_UVD,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_PG_STATE_=
GATE);<br>
<br>
I think this is a standalone fix and should be split into a separate patch.=
<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; cz_dpm_update_uvd_dpm(hwmgr, false);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;u=
vd.pg_lock);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c <br>
&gt; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; index 9bf622e123b6..bed0013674a1 100644<br>
&gt; --- a/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c<br>
&gt; @@ -39,6 &#43;39,7 @@<br>
&gt;&nbsp; #include &quot;power_state.h&quot;<br>
&gt;&nbsp; #include &quot;cz_clockpowergating.h&quot;<br>
&gt;&nbsp; #include &quot;pp_debug.h&quot;<br>
&gt; &#43;#include &quot;amdgpu.h&quot;<br>
&gt;<br>
&gt;&nbsp; #define ixSMUSVI_NB_CURRENTVID 0xD8230044&nbsp; #define <br>
&gt; CURRENT_NB_VID_MASK 0xff000000 @@ -1356,6 &#43;1357,12 @@ static int <=
br>
&gt; cz_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,<br>
&gt;<br>
&gt;&nbsp; int cz_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)&nbsp; {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_cgs_device *cg=
s_dev =3D hwmgr-&gt;device;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D cgs_dev-&gt;adev;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;uvd.is_init)<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (phm_cap_enabled(hw=
mgr-&gt;platform_descriptor.platformCaps,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; PHM_PlatformCaps_UVDPowerGating))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return smum_send_msg_to_smc(hwmgr-&gt;smumgr,<br>
&gt; --<br>
&gt; 2.9.2<br>
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
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1132DA66C4E0B70497D5D121F7000DM5PR12MB1132namp_--

--===============0463024020==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0463024020==--
