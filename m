From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown before init
Date: Thu, 28 Jul 2016 12:19:52 +0000
Message-ID: <DM5PR12MB113233C023366C58A6C3744CF7000@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160726153832.15191-1-tom.stdenis@amd.com>
 <20160726153832.15191-5-tom.stdenis@amd.com>
 <CADnq5_P5C_Rix2wkUuzABQKtcxOYyQeL7FNBA4GJLy3Fg+o4UQ@mail.gmail.com>,
 <BLUPR12MB0659D45202A93FB726C50D84FB000@BLUPR12MB0659.namprd12.prod.outlook.com>,
 <DM5PR12MB1132DA66C4E0B70497D5D121F7000@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_004_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132DA66C4E0B70497D5D121F7000-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--_004_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_"

--_000_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Nevermind I moved the locking into amdgpu_pm.c and that did the trick.


Attached is a patch that contains all the changes.  If you guys want to giv=
e it a quick once-through I can then start splitting it up per Alex's comme=
nts.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of StDenis,=
 Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, July 28, 2016 07:10
To: Zhu, Rex; Alex Deucher
Cc: amd-gfx list
Subject: Re: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown before in=
it


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

--_000_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_
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
<p>Nevermind I moved the locking into amdgpu_pm.c and that did the trick. &=
nbsp;</p>
<p><br>
</p>
<p>Attached is a patch that contains all the changes. &nbsp;If you guys wan=
t to give it a quick once-through I can then start splitting it up per Alex=
's comments.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of StDenis, Tom &lt;Tom.StDenis@=
amd.com&gt;<br>
<b>Sent:</b> Thursday, July 28, 2016 07:10<br>
<b>To:</b> Zhu, Rex; Alex Deucher<br>
<b>Cc:</b> amd-gfx list<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amd/powerplay: Prevent UVD powerdown be=
fore init</font>
<div>&nbsp;</div>
</div>
<div>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
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
<div style=3D"color:rgb(0,0,0)">
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
<font size=3D"2"><span style=3D"font-size:10pt">
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
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_--

--_004_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_
Content-Type: text/x-patch; name="uvd_vce_pg.patch"
Content-Description: uvd_vce_pg.patch
Content-Disposition: attachment; filename="uvd_vce_pg.patch"; size=12488;
	creation-date="Thu, 28 Jul 2016 12:19:46 GMT";
	modification-date="Thu, 28 Jul 2016 12:19:46 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCBlYWI5MzFh
NThkMDYuLjFmZThlZjYyNjQwNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYwpAQCAtMjMzNSwyMiArMjMzNSwyNiBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVf
ZGVidWdmc19yZWdzX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsCiAJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBmLT5mX2lub2RlLT5pX3ByaXZhdGU7CiAJc3NpemVf
dCByZXN1bHQgPSAwOwogCWludCByOwotCWJvb2wgdXNlX2Jhbms7CisJYm9vbCBwbV9wZ19sb2Nr
LCB1c2VfYmFuazsKIAl1bnNpZ25lZCBpbnN0YW5jZV9iYW5rLCBzaF9iYW5rLCBzZV9iYW5rOwog
CiAJaWYgKHNpemUgJiAweDMgfHwgKnBvcyAmIDB4MykKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwkv
KiBhcmUgd2UgcmVhZGluZyByZWdpc3RlcnMgZm9yIHdoaWNoIGEgUEcgbG9jayBpcyBuZWNlc3Nh
cnk/ICovCisJcG1fcGdfbG9jayA9ICgqcG9zID4+IDIzKSAmIDE7CisKIAlpZiAoKnBvcyAmICgx
VUxMIDw8IDYyKSkgewogCQlzZV9iYW5rID0gKCpwb3MgPj4gMjQpICYgMHgzRkY7CiAJCXNoX2Jh
bmsgPSAoKnBvcyA+PiAzNCkgJiAweDNGRjsKIAkJaW5zdGFuY2VfYmFuayA9ICgqcG9zID4+IDQ0
KSAmIDB4M0ZGOwogCQl1c2VfYmFuayA9IDE7Ci0JCSpwb3MgJj0gMHhGRkZGRkY7CiAJfSBlbHNl
IHsKIAkJdXNlX2JhbmsgPSAwOwogCX0KIAorCSpwb3MgJj0gMHgzRkZGRjsKKwogCWlmICh1c2Vf
YmFuaykgewogCQlpZiAoc2hfYmFuayA+PSBhZGV2LT5nZnguY29uZmlnLm1heF9zaF9wZXJfc2Ug
fHwKIAkJICAgIHNlX2JhbmsgPj0gYWRldi0+Z2Z4LmNvbmZpZy5tYXhfc2hhZGVyX2VuZ2luZXMp
CkBAIC0yMzYwLDYgKzIzNjQsOSBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19yZWdz
X3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsCiAJCQkJCXNoX2JhbmssIGlu
c3RhbmNlX2JhbmspOwogCX0KIAorCWlmIChwbV9wZ19sb2NrKQorCQltdXRleF9sb2NrKCZhZGV2
LT5wbS5tdXRleCk7CisKIAl3aGlsZSAoc2l6ZSkgewogCQl1aW50MzJfdCB2YWx1ZTsKIApAQCAt
MjM4NSw2ICsyMzkyLDkgQEAgZW5kOgogCQltdXRleF91bmxvY2soJmFkZXYtPmdyYm1faWR4X211
dGV4KTsKIAl9CiAKKwlpZiAocG1fcGdfbG9jaykKKwkJbXV0ZXhfdW5sb2NrKCZhZGV2LT5wbS5t
dXRleCk7CisKIAlyZXR1cm4gcmVzdWx0OwogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wbS5jCmluZGV4IDEyYWI1OGVjYTU4MS4uYzRiYjRlZjhmMmM2IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYwpAQCAtMTEwNSw1NCArMTEwNSw0NiBAQCBmb3JjZToK
IAogdm9pZCBhbWRncHVfZHBtX2VuYWJsZV91dmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYs
IGJvb2wgZW5hYmxlKQogewotCWlmIChhZGV2LT5wcF9lbmFibGVkKQorCWlmIChhZGV2LT5wcF9l
bmFibGVkIHx8IGFkZXYtPnBtLmZ1bmNzLT5wb3dlcmdhdGVfdXZkKSB7CisJCS8qIGVuYWJsZS9k
aXNhYmxlIFVWRCAqLworCQltdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7CiAJCWFtZGdwdV9k
cG1fcG93ZXJnYXRlX3V2ZChhZGV2LCAhZW5hYmxlKTsKLQllbHNlIHsKLQkJaWYgKGFkZXYtPnBt
LmZ1bmNzLT5wb3dlcmdhdGVfdXZkKSB7CisJCW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgp
OworCX0gZWxzZSB7CisJCWlmIChlbmFibGUpIHsKIAkJCW11dGV4X2xvY2soJmFkZXYtPnBtLm11
dGV4KTsKLQkJCS8qIGVuYWJsZS9kaXNhYmxlIFVWRCAqLwotCQkJYW1kZ3B1X2RwbV9wb3dlcmdh
dGVfdXZkKGFkZXYsICFlbmFibGUpOworCQkJYWRldi0+cG0uZHBtLnV2ZF9hY3RpdmUgPSB0cnVl
OworCQkJYWRldi0+cG0uZHBtLnN0YXRlID0gUE9XRVJfU1RBVEVfVFlQRV9JTlRFUk5BTF9VVkQ7
CiAJCQltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsKIAkJfSBlbHNlIHsKLQkJCWlmIChl
bmFibGUpIHsKLQkJCQltdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7Ci0JCQkJYWRldi0+cG0u
ZHBtLnV2ZF9hY3RpdmUgPSB0cnVlOwotCQkJCWFkZXYtPnBtLmRwbS5zdGF0ZSA9IFBPV0VSX1NU
QVRFX1RZUEVfSU5URVJOQUxfVVZEOwotCQkJCW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgp
OwotCQkJfSBlbHNlIHsKLQkJCQltdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7Ci0JCQkJYWRl
di0+cG0uZHBtLnV2ZF9hY3RpdmUgPSBmYWxzZTsKLQkJCQltdXRleF91bmxvY2soJmFkZXYtPnBt
Lm11dGV4KTsKLQkJCX0KLQkJCWFtZGdwdV9wbV9jb21wdXRlX2Nsb2NrcyhhZGV2KTsKKwkJCW11
dGV4X2xvY2soJmFkZXYtPnBtLm11dGV4KTsKKwkJCWFkZXYtPnBtLmRwbS51dmRfYWN0aXZlID0g
ZmFsc2U7CisJCQltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsKIAkJfQotCisJCWFtZGdw
dV9wbV9jb21wdXRlX2Nsb2NrcyhhZGV2KTsKIAl9CiB9CiAKIHZvaWQgYW1kZ3B1X2RwbV9lbmFi
bGVfdmNlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBib29sIGVuYWJsZSkKIHsKLQlpZiAo
YWRldi0+cHBfZW5hYmxlZCkKKwlpZiAoYWRldi0+cHBfZW5hYmxlZCB8fCBhZGV2LT5wbS5mdW5j
cy0+cG93ZXJnYXRlX3ZjZSkgeworCQkvKiBlbmFibGUvZGlzYWJsZSBWQ0UgKi8KKwkJbXV0ZXhf
bG9jaygmYWRldi0+cG0ubXV0ZXgpOwogCQlhbWRncHVfZHBtX3Bvd2VyZ2F0ZV92Y2UoYWRldiwg
IWVuYWJsZSk7Ci0JZWxzZSB7Ci0JCWlmIChhZGV2LT5wbS5mdW5jcy0+cG93ZXJnYXRlX3ZjZSkg
eworCQltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsKKwl9IGVsc2UgeworCQlpZiAoZW5h
YmxlKSB7CiAJCQltdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7Ci0JCQlhbWRncHVfZHBtX3Bv
d2VyZ2F0ZV92Y2UoYWRldiwgIWVuYWJsZSk7CisJCQlhZGV2LT5wbS5kcG0udmNlX2FjdGl2ZSA9
IHRydWU7CisJCQkvKiBYWFggc2VsZWN0IHZjZSBsZXZlbCBiYXNlZCBvbiByaW5nL3Rhc2sgKi8K
KwkJCWFkZXYtPnBtLmRwbS52Y2VfbGV2ZWwgPSBBTURHUFVfVkNFX0xFVkVMX0FDX0FMTDsKIAkJ
CW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgpOwogCQl9IGVsc2UgewotCQkJaWYgKGVuYWJs
ZSkgewotCQkJCW11dGV4X2xvY2soJmFkZXYtPnBtLm11dGV4KTsKLQkJCQlhZGV2LT5wbS5kcG0u
dmNlX2FjdGl2ZSA9IHRydWU7Ci0JCQkJLyogWFhYIHNlbGVjdCB2Y2UgbGV2ZWwgYmFzZWQgb24g
cmluZy90YXNrICovCi0JCQkJYWRldi0+cG0uZHBtLnZjZV9sZXZlbCA9IEFNREdQVV9WQ0VfTEVW
RUxfQUNfQUxMOwotCQkJCW11dGV4X3VubG9jaygmYWRldi0+cG0ubXV0ZXgpOwotCQkJfSBlbHNl
IHsKLQkJCQltdXRleF9sb2NrKCZhZGV2LT5wbS5tdXRleCk7Ci0JCQkJYWRldi0+cG0uZHBtLnZj
ZV9hY3RpdmUgPSBmYWxzZTsKLQkJCQltdXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsKLQkJ
CX0KLQkJCWFtZGdwdV9wbV9jb21wdXRlX2Nsb2NrcyhhZGV2KTsKKwkJCW11dGV4X2xvY2soJmFk
ZXYtPnBtLm11dGV4KTsKKwkJCWFkZXYtPnBtLmRwbS52Y2VfYWN0aXZlID0gZmFsc2U7CisJCQlt
dXRleF91bmxvY2soJmFkZXYtPnBtLm11dGV4KTsKIAkJfQorCQlhbWRncHVfcG1fY29tcHV0ZV9j
bG9ja3MoYWRldik7CiAJfQogfQogCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9jel9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2N6X2RwbS5jCmluZGV4
IDhiYTA3ZTc5ZDRjYi4uMzAxZDBiOThlNjA3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9jel9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jel9k
cG0uYwpAQCAtMjEwOCwyOSArMjEwOCw1OCBAQCBzdGF0aWMgdm9pZCBjel9kcG1fcG93ZXJnYXRl
X3V2ZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBnYXRlKQogCQkJLyogZGlzYWJs
ZSBjbG9ja2dhdGluZyBzbyB3ZSBjYW4gcHJvcGVybHkgc2h1dCBkb3duIHRoZSBibG9jayAqLwog
CQkJcmV0ID0gYW1kZ3B1X3NldF9jbG9ja2dhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tf
VFlQRV9VVkQsCiAJCQkJCQkJICAgIEFNRF9DR19TVEFURV9VTkdBVEUpOworCQkJaWYgKHJldCkg
eworCQkJCURSTV9FUlJPUigiVVZEIERQTSBQb3dlciBHYXRpbmcgZmFpbGVkIHRvIHNldCBjbG9j
a2dhdGluZyBzdGF0ZVxuIik7CisJCQkJcmV0dXJuOworCQkJfQorCiAJCQkvKiBzaHV0ZG93biB0
aGUgVVZEIGJsb2NrICovCiAJCQlyZXQgPSBhbWRncHVfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFk
ZXYsIEFNRF9JUF9CTE9DS19UWVBFX1VWRCwKIAkJCQkJCQkgICAgQU1EX1BHX1NUQVRFX0dBVEUp
OwotCQkJLyogWFhYOiBjaGVjayBmb3IgZXJyb3JzICovCisKKwkJCWlmIChyZXQpIHsKKwkJCQlE
Uk1fRVJST1IoIlVWRCBEUE0gUG93ZXIgR2F0aW5nIGZhaWxlZCB0byBzZXQgcG93ZXJnYXRpbmcg
c3RhdGVcbiIpOworCQkJCXJldHVybjsKKwkJCX0KIAkJfQogCQljel91cGRhdGVfdXZkX2RwbShh
ZGV2LCBnYXRlKTsKLQkJaWYgKHBpLT5jYXBzX3V2ZF9wZykKKwkJaWYgKHBpLT5jYXBzX3V2ZF9w
ZykgewogCQkJLyogcG93ZXIgb2ZmIHRoZSBVVkQgYmxvY2sgKi8KLQkJCWN6X3NlbmRfbXNnX3Rv
X3NtYyhhZGV2LCBQUFNNQ19NU0dfVVZEUG93ZXJPRkYpOworCQkJcmV0ID0gY3pfc2VuZF9tc2df
dG9fc21jKGFkZXYsIFBQU01DX01TR19VVkRQb3dlck9GRik7CisJCQlpZiAocmV0KSB7CisJCQkJ
RFJNX0VSUk9SKCJVVkQgRFBNIFBvd2VyIEdhdGluZyBmYWlsZWQgdG8gc2VuZCBTTVUgUG93ZXJP
RkYgbWVzc2FnZVxuIik7CisJCQkJcmV0dXJuOworCQkJfQorCQl9CiAJfSBlbHNlIHsKIAkJaWYg
KHBpLT5jYXBzX3V2ZF9wZykgewogCQkJLyogcG93ZXIgb24gdGhlIFVWRCBibG9jayAqLwogCQkJ
aWYgKHBpLT51dmRfZHluYW1pY19wZykKLQkJCQljel9zZW5kX21zZ190b19zbWNfd2l0aF9wYXJh
bWV0ZXIoYWRldiwgUFBTTUNfTVNHX1VWRFBvd2VyT04sIDEpOworCQkJCXJldCA9IGN6X3NlbmRf
bXNnX3RvX3NtY193aXRoX3BhcmFtZXRlcihhZGV2LCBQUFNNQ19NU0dfVVZEUG93ZXJPTiwgMSk7
CiAJCQllbHNlCi0JCQkJY3pfc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGFkZXYsIFBQ
U01DX01TR19VVkRQb3dlck9OLCAwKTsKKwkJCQlyZXQgPSBjel9zZW5kX21zZ190b19zbWNfd2l0
aF9wYXJhbWV0ZXIoYWRldiwgUFBTTUNfTVNHX1VWRFBvd2VyT04sIDApOworCisJCQlpZiAocmV0
KSB7CisJCQkJRFJNX0VSUk9SKCJVVkQgRFBNIFBvd2VyIEdhdGluZyBGYWlsZWQgdG8gc2VuZCBT
TVUgUG93ZXJPTiBtZXNzYWdlXG4iKTsKKwkJCQlyZXR1cm47CisJCQl9CisKIAkJCS8qIHJlLWlu
aXQgdGhlIFVWRCBibG9jayAqLwogCQkJcmV0ID0gYW1kZ3B1X3NldF9wb3dlcmdhdGluZ19zdGF0
ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9VVkQsCiAJCQkJCQkJICAgIEFNRF9QR19TVEFURV9V
TkdBVEUpOworCisJCQlpZiAocmV0KSB7CisJCQkJRFJNX0VSUk9SKCJVVkQgRFBNIFBvd2VyIEdh
dGluZyBGYWlsZWQgdG8gc2V0IHBvd2VyZ2F0aW5nIHN0YXRlXG4iKTsKKwkJCQlyZXR1cm47CisJ
CQl9CisKIAkJCS8qIGVuYWJsZSBjbG9ja2dhdGluZy4gaHcgd2lsbCBkeW5hbWljYWxseSBnYXRl
L3VuZ2F0ZSBjbG9ja3Mgb24gdGhlIGZseSAqLwogCQkJcmV0ID0gYW1kZ3B1X3NldF9jbG9ja2dh
dGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9VVkQsCiAJCQkJCQkJICAgIEFNRF9D
R19TVEFURV9HQVRFKTsKLQkJCS8qIFhYWDogY2hlY2sgZm9yIGVycm9ycyAqLworCQkJaWYgKHJl
dCkgeworCQkJCURSTV9FUlJPUigiVVZEIERQTSBQb3dlciBHYXRpbmcgRmFpbGVkIHRvIHNldCBj
bG9ja2dhdGluZyBzdGF0ZVxuIik7CisJCQkJcmV0dXJuOworCQkJfQogCQl9CiAJCWN6X3VwZGF0
ZV91dmRfZHBtKGFkZXYsIGdhdGUpOwogCX0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3V2ZF92Nl8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZf
MC5jCmluZGV4IDRmYTUwOTE4ZTg4Ni4uMzkxNDU3ZjFlYWZkIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjZfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3V2ZF92Nl8wLmMKQEAgLTM5NiwxNSArMzk2LDEwIEBAIHN0YXRpYyBpbnQgdXZkX3Y2
XzBfc3RhcnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAKIAl1dmRfdjZfMF9tY19yZXN1
bWUoYWRldik7CiAKLQkvKiBTZXQgZHluYW1pYyBjbG9jayBnYXRpbmcgaW4gUy9XIGNvbnRyb2wg
bW9kZSAqLwotCWlmIChhZGV2LT5jZ19mbGFncyAmIEFNRF9DR19TVVBQT1JUX1VWRF9NR0NHKSB7
Ci0JCXV2ZF92Nl8wX3NldF9zd19jbG9ja19nYXRpbmcoYWRldik7Ci0JfSBlbHNlIHsKLQkJLyog
ZGlzYWJsZSBjbG9jayBnYXRpbmcgKi8KLQkJdWludDMyX3QgZGF0YSA9IFJSRUczMihtbVVWRF9D
R0NfQ1RSTCk7Ci0JCWRhdGEgJj0gflVWRF9DR0NfQ1RSTF9fRFlOX0NMT0NLX01PREVfTUFTSzsK
LQkJV1JFRzMyKG1tVVZEX0NHQ19DVFJMLCBkYXRhKTsKLQl9CisJLyogZGlzYWJsZSBjbG9jayBn
YXRpbmcgKi8KKwl0bXAgPSBSUkVHMzIobW1VVkRfQ0dDX0NUUkwpOworCXRtcCAmPSB+VVZEX0NH
Q19DVFJMX19EWU5fQ0xPQ0tfTU9ERV9NQVNLOworCVdSRUczMihtbVVWRF9DR0NfQ1RSTCwgdG1w
KTsKIAogCS8qIGRpc2FibGUgaW50ZXJ1cHQgKi8KIAlXUkVHMzJfUChtbVVWRF9NQVNUSU5UX0VO
LCAwLCB+VVZEX01BU1RJTlRfRU5fX1ZDUFVfRU5fTUFTSyk7CkBAIC05NjQsMjEgKzk1OSwxNSBA
QCBzdGF0aWMgaW50IHV2ZF92Nl8wX3NldF9jbG9ja2dhdGluZ19zdGF0ZSh2b2lkICpoYW5kbGUs
CiAJCQkJCSAgZW51bSBhbWRfY2xvY2tnYXRpbmdfc3RhdGUgc3RhdGUpCiB7CiAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Ci0JYm9v
bCBlbmFibGUgPSAoc3RhdGUgPT0gQU1EX0NHX1NUQVRFX0dBVEUpID8gdHJ1ZSA6IGZhbHNlOwot
CXN0YXRpYyBpbnQgY3Vyc3RhdGUgPSAtMTsKLQotCWlmIChhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJ
UF9GSUpJIHx8Ci0JCQlhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9QT0xBUklTMTApCi0JCXV2ZF92
Nl9zZXRfYnlwYXNzX21vZGUoYWRldiwgZW5hYmxlKTsKIAogCWlmICghKGFkZXYtPmNnX2ZsYWdz
ICYgQU1EX0NHX1NVUFBPUlRfVVZEX01HQ0cpKQogCQlyZXR1cm4gMDsKIAotCWlmIChjdXJzdGF0
ZSA9PSBzdGF0ZSkKLQkJcmV0dXJuIDA7CisJaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX0ZJ
SkkgfHwKKwkgICAgYWRldi0+YXNpY190eXBlID09IENISVBfUE9MQVJJUzEwKQorCQl1dmRfdjZf
c2V0X2J5cGFzc19tb2RlKGFkZXYsIHN0YXRlID09IEFNRF9DR19TVEFURV9HQVRFID8gdHJ1ZSA6
IGZhbHNlKTsKIAotCWN1cnN0YXRlID0gc3RhdGU7Ci0JaWYgKGVuYWJsZSkgeworCWlmIChzdGF0
ZSA9PSBBTURfQ0dfU1RBVEVfR0FURSkgewogCQkvKiBkaXNhYmxlIEhXIGdhdGluZyBhbmQgZW5h
YmxlIFN3IGdhdGluZyAqLwogCQl1dmRfdjZfMF9zZXRfc3dfY2xvY2tfZ2F0aW5nKGFkZXYpOwog
CX0gZWxzZSB7CkBAIC0xMDA4LDYgKzk5Nyw4IEBAIHN0YXRpYyBpbnQgdXZkX3Y2XzBfc2V0X3Bv
d2VyZ2F0aW5nX3N0YXRlKHZvaWQgKmhhbmRsZSwKIAlpZiAoIShhZGV2LT5wZ19mbGFncyAmIEFN
RF9QR19TVVBQT1JUX1VWRCkpCiAJCXJldHVybiAwOwogCisJV1JFRzMyKG1tVVZEX1BPV0VSX1NU
QVRVUywgVVZEX1BPV0VSX1NUQVRVU19fVVZEX1BHX0VOX01BU0spOworCiAJaWYgKHN0YXRlID09
IEFNRF9QR19TVEFURV9HQVRFKSB7CiAJCXV2ZF92Nl8wX3N0b3AoYWRldik7CiAJCXJldHVybiAw
OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKaW5kZXggZTViMThhZDQyNzIxLi5k
ZDY5NTIwMWRjY2IgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92
M18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNlX3YzXzAuYwpAQCAtMTI2
LDYgKzEyNiw3IEBAIHN0YXRpYyB2b2lkIHZjZV92M18wX3NldF92Y2Vfc3dfY2xvY2tfZ2F0aW5n
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJCQkgICAgIGJvb2wgZ2F0ZWQpCiB7CiAJ
dTMyIHRtcCwgZGF0YTsKKwogCS8qIFNldCBPdmVycmlkZSB0byBkaXNhYmxlIENsb2NrIEdhdGlu
ZyAqLwogCXZjZV92M18wX292ZXJyaWRlX3ZjZV9jbG9ja19nYXRpbmcoYWRldiwgdHJ1ZSk7CiAK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS92aS5jCmluZGV4IDliYTY0OTg5ZjA5Mi4uMzNiYWQ5OTE3NmZlIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92aS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKQEAgLTE1NzgsNyArMTU3OCwxNSBAQCBzdGF0aWMgaW50
IHZpX2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCUFNRF9DR19TVVBQT1JUX0hE
UF9MUyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9TRE1BX01HQ0cgfAogCQkJQU1EX0NHX1NVUFBPUlRf
U0RNQV9MUzsKKwkJLyogcmV2MCBoYXJkd2FyZSByZXF1aXJlcyB3b3JrYXJvdW5kcyB0byBzdXBw
b3J0IFBHICovCiAJCWFkZXYtPnBnX2ZsYWdzID0gMDsKKwkJaWYgKGFkZXYtPnJldl9pZCAhPSAw
eDAwKSB7CisJCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9HRlhfUEcgfAorCQkJ
CUFNRF9QR19TVVBQT1JUX0dGWF9TTUcgfAorCQkJCUFNRF9QR19TVVBQT1JUX0dGWF9QSVBFTElO
RSB8CisJCQkJQU1EX1BHX1NVUFBPUlRfVVZEIHwKKwkJCQlBTURfUEdfU1VQUE9SVF9WQ0U7CisJ
CX0KIAkJYWRldi0+ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0+cmV2X2lkICsgMHgxOwogCQlicmVh
azsKIAljYXNlIENISVBfU1RPTkVZOgpAQCAtMTU5Nyw2ICsxNjA1LDExIEBAIHN0YXRpYyBpbnQg
dmlfY29tbW9uX2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQogCQkJQU1EX0NHX1NVUFBPUlRfSERQ
X0xTIHwKIAkJCUFNRF9DR19TVVBQT1JUX1NETUFfTUdDRyB8CiAJCQlBTURfQ0dfU1VQUE9SVF9T
RE1BX0xTOworCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9SVF9HRlhfUEcgfAorCQkJ
QU1EX1BHX1NVUFBPUlRfR0ZYX1NNRyB8CisJCQlBTURfUEdfU1VQUE9SVF9HRlhfUElQRUxJTkUg
fAorCQkJQU1EX1BHX1NVUFBPUlRfVVZEIHwKKwkJCUFNRF9QR19TVVBQT1JUX1ZDRTsKIAkJYWRl
di0+ZXh0ZXJuYWxfcmV2X2lkID0gYWRldi0+cmV2X2lkICsgMHgxOwogCQlicmVhazsKIAlkZWZh
dWx0OgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvZXZlbnRtZ3Iv
ZXZlbnRhY3Rpb25jaGFpbnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2V2ZW50
bWdyL2V2ZW50YWN0aW9uY2hhaW5zLmMKaW5kZXggZDY2MzVjYzRiMGZjLi42MzVmYzRiNDgxODQg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2V2ZW50bWdyL2V2ZW50
YWN0aW9uY2hhaW5zLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvZXZlbnRt
Z3IvZXZlbnRhY3Rpb25jaGFpbnMuYwpAQCAtMzAsNyArMzAsNiBAQCBzdGF0aWMgY29uc3QgcGVt
X2V2ZW50X2FjdGlvbiAqIGNvbnN0IGluaXRpYWxpemVfZXZlbnRbXSA9IHsKIAlzeXN0ZW1fY29u
ZmlnX3Rhc2tzLAogCXNldHVwX2FzaWNfdGFza3MsCiAJZW5hYmxlX2R5bmFtaWNfc3RhdGVfbWFu
YWdlbWVudF90YXNrcywKLQllbmFibGVfY2xvY2tfcG93ZXJfZ2F0aW5nc190YXNrcywKIAlnZXRf
MmRfcGVyZm9ybWFuY2Vfc3RhdGVfdGFza3MsCiAJc2V0X3BlcmZvcm1hbmNlX3N0YXRlX3Rhc2tz
LAogCWluaXRpYWxpemVfdGhlcm1hbF9jb250cm9sbGVyX3Rhc2tzLApAQCAtMTQwLDcgKzEzOSw2
IEBAIHN0YXRpYyBjb25zdCBwZW1fZXZlbnRfYWN0aW9uICogY29uc3QgcmVzdW1lX2V2ZW50W10g
PSB7CiAJc2V0dXBfYXNpY190YXNrcywKIAllbmFibGVfc3R1dHRlcl9tb2RlX3Rhc2tzLCAvKm11
c3QgZG8gdGhpcyBpbiBib290IHN0YXRlIGFuZCBiZWZvcmUgU01DIGlzIHN0YXJ0ZWQgKi8KIAll
bmFibGVfZHluYW1pY19zdGF0ZV9tYW5hZ2VtZW50X3Rhc2tzLAotCWVuYWJsZV9jbG9ja19wb3dl
cl9nYXRpbmdzX3Rhc2tzLAogCWVuYWJsZV9kaXNhYmxlX2JhcG1fdGFza3MsCiAJaW5pdGlhbGl6
ZV90aGVybWFsX2NvbnRyb2xsZXJfdGFza3MsCiAJZ2V0XzJkX3BlcmZvcm1hbmNlX3N0YXRlX3Rh
c2tzLApkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvY3pf
Y2xvY2twb3dlcmdhdGluZy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Iv
Y3pfY2xvY2twb3dlcmdhdGluZy5jCmluZGV4IDJkYTU0OGY2MzM3ZS4uMGU4MmU1YmYwNjJiIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9jel9jbG9ja3Bv
d2VyZ2F0aW5nLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvY3pf
Y2xvY2twb3dlcmdhdGluZy5jCkBAIC0xNjEsOCArMTYxLDkgQEAgaW50IGN6X2RwbV9wb3dlcmdh
dGVfdXZkKHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIGJvb2wgYmdhdGUpCiB7CiAJc3RydWN0IGN6
X2h3bWdyICpjel9od21nciA9IChzdHJ1Y3QgY3pfaHdtZ3IgKikoaHdtZ3ItPmJhY2tlbmQpOwog
Ci0JaWYgKGN6X2h3bWdyLT51dmRfcG93ZXJfZ2F0ZWQgPT0gYmdhdGUpCisJaWYgKGN6X2h3bWdy
LT51dmRfcG93ZXJfZ2F0ZWQgPT0gYmdhdGUpIHsKIAkJcmV0dXJuIDA7CisJfQogCiAJY3pfaHdt
Z3ItPnV2ZF9wb3dlcl9nYXRlZCA9IGJnYXRlOwogCkBAIC0xNzcsMTIgKzE3OCwxMiBAQCBpbnQg
Y3pfZHBtX3Bvd2VyZ2F0ZV91dmQoc3RydWN0IHBwX2h3bWdyICpod21nciwgYm9vbCBiZ2F0ZSkK
IAkJY3pfZHBtX3Bvd2VyZG93bl91dmQoaHdtZ3IpOwogCX0gZWxzZSB7CiAJCWN6X2RwbV9wb3dl
cnVwX3V2ZChod21ncik7Ci0JCWNnc19zZXRfY2xvY2tnYXRpbmdfc3RhdGUoaHdtZ3ItPmRldmlj
ZSwKLQkJCQkJCUFNRF9JUF9CTE9DS19UWVBFX1VWRCwKLQkJCQkJCUFNRF9QR19TVEFURV9HQVRF
KTsKIAkJY2dzX3NldF9wb3dlcmdhdGluZ19zdGF0ZShod21nci0+ZGV2aWNlLAogCQkJCQkJQU1E
X0lQX0JMT0NLX1RZUEVfVVZELAogCQkJCQkJQU1EX0NHX1NUQVRFX1VOR0FURSk7CisJCWNnc19z
ZXRfY2xvY2tnYXRpbmdfc3RhdGUoaHdtZ3ItPmRldmljZSwKKwkJCQkJCUFNRF9JUF9CTE9DS19U
WVBFX1VWRCwKKwkJCQkJCUFNRF9QR19TVEFURV9HQVRFKTsKIAkJY3pfZHBtX3VwZGF0ZV91dmRf
ZHBtKGh3bWdyLCBmYWxzZSk7CiAJfQogCkBAIC0yMTEsMTQgKzIxMiwxNCBAQCBpbnQgY3pfZHBt
X3Bvd2VyZ2F0ZV92Y2Uoc3RydWN0IHBwX2h3bWdyICpod21nciwgYm9vbCBiZ2F0ZSkKIAkJCX0g
ZWxzZSB7CiAJCQkJY3pfZHBtX3Bvd2VydXBfdmNlKGh3bWdyKTsKIAkJCQljel9od21nci0+dmNl
X3Bvd2VyX2dhdGVkID0gZmFsc2U7Ci0JCQkJY2dzX3NldF9jbG9ja2dhdGluZ19zdGF0ZSgKLQkJ
CQkJCQlod21nci0+ZGV2aWNlLAotCQkJCQkJCUFNRF9JUF9CTE9DS19UWVBFX1ZDRSwKLQkJCQkJ
CQlBTURfUEdfU1RBVEVfR0FURSk7CiAJCQkJY2dzX3NldF9wb3dlcmdhdGluZ19zdGF0ZSgKIAkJ
CQkJCQlod21nci0+ZGV2aWNlLAogCQkJCQkJCUFNRF9JUF9CTE9DS19UWVBFX1ZDRSwKIAkJCQkJ
CQlBTURfQ0dfU1RBVEVfVU5HQVRFKTsKKwkJCQljZ3Nfc2V0X2Nsb2NrZ2F0aW5nX3N0YXRlKAor
CQkJCQkJCWh3bWdyLT5kZXZpY2UsCisJCQkJCQkJQU1EX0lQX0JMT0NLX1RZUEVfVkNFLAorCQkJ
CQkJCUFNRF9QR19TVEFURV9HQVRFKTsKIAkJCQljel9kcG1fdXBkYXRlX3ZjZV9kcG0oaHdtZ3Ip
OwogCQkJCWN6X2VuYWJsZV9kaXNhYmxlX3ZjZV9kcG0oaHdtZ3IsIHRydWUpOwogCQkJCXJldHVy
biAwOwo=

--_004_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--_004_DM5PR12MB113233C023366C58A6C3744CF7000DM5PR12MB1132namp_--
