Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938CBD3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB56E10E526;
	Mon, 28 Oct 2024 19:11:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iykUMjnH";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 991A510E525
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:11:30 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36d5so153118b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730142690; x=1730747490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRSDX3wusFJSW76k8h2FyS1gGe+6SyGQmV2D2/zxUSg=;
 b=iykUMjnH/leDxqNQrWy8cKWr9wq1vKbHqu7ugRda4Ifa3WvEr/UVta3cmLvwUZnzA/
 e0rAJX5aCP9YJps99FQAps1i5PZDD2S30qb1gNq895ggXbkUqEdenjjLnTeXo78N4mdo
 lr0tG2ZcamIEgcPX3hJnkRAujU2rTzsK2/EfhXl2PieflKIKnY3DJAr3euh6sVgcZ24v
 9O1gG0Vlmj0xoAMuAOrMvWT394j8VXEPwwWRVJFonBmvBil+OhvTL0NG2k94uo0aXf7K
 NH8BLTk7AwenM8R9Zp4PcM+a6YMLLMrXAmyQXR/Y9xewdgmdkRuDhUObn7OTu5EKVX5r
 Cd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730142690; x=1730747490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRSDX3wusFJSW76k8h2FyS1gGe+6SyGQmV2D2/zxUSg=;
 b=TaUajo+hg7XcyJFs/7K0/wO+96DrFg+87jSA7fj4E0xR0p6RndHJUplaeyV3pfy7yi
 LNmIzA8Gyu/p3Zl2AU6ILIJNICm016LUrMAzDIg9tZitR+ZMqE3hZWWIprh8v4myVZMa
 w5yAoMM2AlUijB/Ki+ByjTYLllwlRWScpzmGmdmEHcBcwpqTk8iWzu+OeCt1lXi9n2ak
 6aOu76wGwRF7GlF5+5W9c42fm/W0iUjlcrgQ3AsNdXlyybKTIZPf+Ieu3NTfbRwAt/Ln
 dLOvT/oqUK2Dvc4rhGH7wsSVKJgs60VywjUzSfwP5hydaEER3fPRR9SKtFg3rzIdYdQP
 6rMw==
X-Gm-Message-State: AOJu0YxmEbJT+B2mnztUJcc+YwaXQMDrvh13HBO2ZkjNXh514joiX5y8
 3ayew54CF+FbXr6ICk4mlSIP3Dx+xr7npmU7CdBPp20GoMW5UOKEj2m61f4kDc463vO/tyEG7C9
 ioUmStJTXEd0d/YmmvZIsNE+kQVxyFw==
X-Google-Smtp-Source: AGHT+IFmN0beKQHODVH2WDBeKoue4f+hkI4X4hkuz11AM+imV8P26PN3mlap3ThPI5LdTPfpqEx0J+aGgAlMJHLTPio=
X-Received: by 2002:a05:6a00:1414:b0:71e:66ed:7bd4 with SMTP id
 d2e1a72fcca58-72062ecdab2mr5722879b3a.1.1730142689953; Mon, 28 Oct 2024
 12:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-6-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-6-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:11:18 -0400
Message-ID: <CADnq5_Nro=8wKAP=4HAs2ykaDcJerKan8bGsZZosmDGY8hnTzQ@mail.gmail.com>
Subject: Re: [PATCH 05/29] drm/amd/pm: add inst to dpm_set_powergating_by_smu
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 24, 2024 at 10:36=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Add an instance parameter to amdgpu_dpm_set_powergating_by_smu() function=
,
> and use the instance to call set_powergating_by_smu().
>
> v2: remove duplicated functions.
>
> remove for-loop in amdgpu_dpm_set_powergating_by_smu(), and temporarily
> move it to amdgpu_dpm_enable_vcn(), in order to keep the exact same logic
> as before, until further separation in next patch.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c    | 14 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    |  4 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c      |  6 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c      |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c      |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c      |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c      |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c    |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c    |  4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c    |  4 +-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 51 +++++++++++++++++-----
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  3 +-
>  16 files changed, 73 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_acp.c
> index ec5e0dcf8613..769200cda626 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
> @@ -140,7 +140,7 @@ static int acp_poweroff(struct generic_pm_domain *gen=
pd)
>          * 2. power off the acp tiles
>          * 3. check and enter ulv state
>          */
> -       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, tr=
ue);
> +       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, tr=
ue, 0);
>         return 0;
>  }
>
> @@ -157,7 +157,7 @@ static int acp_poweron(struct generic_pm_domain *genp=
d)
>          * 2. turn on acp clock
>          * 3. power on acp tiles
>          */
> -       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, fa=
lse);
> +       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, fa=
lse, 0);
>         return 0;
>  }
>
> @@ -236,7 +236,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
>                             ip_block->version->major, ip_block->version->=
minor);
>         /* -ENODEV means board uses AZ rather than ACP */
>         if (r =3D=3D -ENODEV) {
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, true);
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, true, 0);
>                 return 0;
>         } else if (r) {
>                 return r;
> @@ -508,7 +508,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_blo=
ck)
>
>         /* return early if no ACP */
>         if (!adev->acp.acp_genpd) {
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, false);
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, false, 0);
>                 return 0;
>         }
>
> @@ -565,7 +565,7 @@ static int acp_suspend(struct amdgpu_ip_block *ip_blo=
ck)
>
>         /* power up on suspend */
>         if (!adev->acp.acp_cell)
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, false);
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, false, 0);
>         return 0;
>  }
>
> @@ -575,7 +575,7 @@ static int acp_resume(struct amdgpu_ip_block *ip_bloc=
k)
>
>         /* power down again on resume */
>         if (!adev->acp.acp_cell)
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, true);
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_ACP, true, 0);
>         return 0;
>  }
>
> @@ -596,7 +596,7 @@ static int acp_set_powergating_state(void *handle,
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>         bool enable =3D (state =3D=3D AMD_PG_STATE_GATE);
>
> -       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, en=
able);
> +       amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_ACP, en=
able, 0);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 6c0ff1c2ae4c..2924fa15b74b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3469,7 +3469,7 @@ static void amdgpu_device_delay_enable_gfx_off(stru=
ct work_struct *work)
>         WARN_ON_ONCE(adev->gfx.gfx_off_state);
>         WARN_ON_ONCE(adev->gfx.gfx_off_req_count);
>
> -       if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GF=
X, true))
> +       if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GF=
X, true, 0))
>                 adev->gfx.gfx_off_state =3D true;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e96984c53e72..0c3249db2f98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -787,7 +787,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, =
bool enable)
>                         /* If going to s2idle, no need to wait */
>                         if (adev->in_s0ix) {
>                                 if (!amdgpu_dpm_set_powergating_by_smu(ad=
ev,
> -                                               AMD_IP_BLOCK_TYPE_GFX, tr=
ue))
> +                                               AMD_IP_BLOCK_TYPE_GFX, tr=
ue, 0))
>                                         adev->gfx.gfx_off_state =3D true;
>                         } else {
>                                 schedule_delayed_work(&adev->gfx.gfx_off_=
delay_work,
> @@ -799,7 +799,7 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, =
bool enable)
>                         cancel_delayed_work_sync(&adev->gfx.gfx_off_delay=
_work);
>
>                         if (adev->gfx.gfx_off_state &&
> -                           !amdgpu_dpm_set_powergating_by_smu(adev, AMD_=
IP_BLOCK_TYPE_GFX, false)) {
> +                           !amdgpu_dpm_set_powergating_by_smu(adev, AMD_=
IP_BLOCK_TYPE_GFX, false, 0)) {
>                                 adev->gfx.gfx_off_state =3D false;
>
>                                 if (adev->gfx.funcs->init_spm_golden) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 480c41ee947e..9f5a5b2e6de6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5314,7 +5314,7 @@ static void gfx_v8_0_enable_gfx_static_mg_power_gat=
ing(struct amdgpu_device *ade
>             (adev->asic_type =3D=3D CHIP_POLARIS12) ||
>             (adev->asic_type =3D=3D CHIP_VEGAM))
>                 /* Send msg to SMU via Powerplay */
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_GFX, enable);
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_GFX, enable, 0);
>
>         WREG32_FIELD(RLC_PG_CNTL, STATIC_PER_CU_PG_ENABLE, enable ? 1 : 0=
);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v1_0.c
> index e9a6f33ca710..243eabda0607 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -356,7 +356,7 @@ static void mmhub_v1_0_update_power_gating(struct amd=
gpu_device *adev,
>         if (adev->pg_flags & AMD_PG_SUPPORT_MMHUB)
>                 amdgpu_dpm_set_powergating_by_smu(adev,
>                                                   AMD_IP_BLOCK_TYPE_GMC,
> -                                                 enable);
> +                                                 enable, 0);
>  }
>
>  static int mmhub_v1_0_gart_enable(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index c1f98f6cf20d..3f5959557727 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1956,7 +1956,7 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block=
 *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         if (adev->flags & AMD_IS_APU)
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_SDMA, false);
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_SDMA, false, 0);
>
>         if (!amdgpu_sriov_vf(adev))
>                 sdma_v4_0_init_golden_registers(adev);
> @@ -1983,7 +1983,7 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block=
 *ip_block)
>         sdma_v4_0_enable(adev, false);
>
>         if (adev->flags & AMD_IS_APU)
> -               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_SDMA, true);
> +               amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_SDMA, true, 0);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 10e99c926fb8..511d76e188f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *i=
p_block)
>         idle_work_unexecuted =3D cancel_delayed_work_sync(&adev->vcn.idle=
_work);
>         if (idle_work_unexecuted) {
>                 if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_uvd(adev, false);
> +                       amdgpu_dpm_enable_vcn(adev, false);
>         }
>
>         r =3D vcn_v1_0_hw_fini(ip_block);
> @@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_=
struct *work)
>         if (fences =3D=3D 0) {
>                 amdgpu_gfx_off_ctrl(adev, true);
>                 if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_uvd(adev, false);
> +                       amdgpu_dpm_enable_vcn(adev, false);
>                 else
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCN,
>                                AMD_PG_STATE_GATE);
> @@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ri=
ng *ring, bool set_clocks)
>         if (set_clocks) {
>                 amdgpu_gfx_off_ctrl(adev, false);
>                 if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_uvd(adev, true);
> +                       amdgpu_dpm_enable_vcn(adev, true);
>                 else
>                         amdgpu_device_ip_set_powergating_state(adev, AMD_=
IP_BLOCK_TYPE_VCN,
>                                AMD_PG_STATE_UNGATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index e0322cbca3ec..697822abf3fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>         int i, j, r;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true);
>
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>                 return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_s=
ram);
> @@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev=
)
>
>  power_off:
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index 6aa08281d094..0afbcf72cd51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -1013,7 +1013,7 @@ static int vcn_v2_5_start(struct amdgpu_device *ade=
v)
>         int i, j, k, r;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true);
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1486,7 +1486,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev=
)
>         }
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 6732ad7f16f5..b28aad37d9ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1142,7 +1142,7 @@ static int vcn_v3_0_start(struct amdgpu_device *ade=
v)
>         int i, j, k, r;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true);
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1633,7 +1633,7 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev=
)
>         }
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 5512259cac79..d87850dec27c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1089,7 +1089,7 @@ static int vcn_v4_0_start(struct amdgpu_device *ade=
v)
>         int i, j, k, r;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true);
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1615,7 +1615,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev=
)
>         }
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 0d5c94bfc0ef..6fc52a1bda31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1092,7 +1092,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *a=
dev)
>         uint32_t tmp;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true);
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> @@ -1366,7 +1366,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *ad=
ev)
>         }
>  Done:
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index 71961fb3f7ff..398191a48446 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1001,7 +1001,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device *a=
dev)
>         int i, j, k, r;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true);
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1278,7 +1278,7 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *ad=
ev)
>         }
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index fe2cc1a80c13..58f0611b8fb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -762,7 +762,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *ade=
v)
>         int i, j, k, r;
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, true);
> +               amdgpu_dpm_enable_vcn(adev, true);
>
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>                 if (adev->vcn.harvest_config & (1 << i))
> @@ -1009,7 +1009,7 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *ad=
ev)
>         }
>
>         if (adev->pm.dpm_enabled)
> -               amdgpu_dpm_enable_uvd(adev, false);
> +               amdgpu_dpm_enable_vcn(adev, false);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index bcedbeec082f..8531e0993b17 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -70,13 +70,18 @@ int amdgpu_dpm_get_mclk(struct amdgpu_device *adev, b=
ool low)
>         return ret;
>  }
>
> -int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32=
_t block_type, bool gate)
> +int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
> +                                      uint32_t block_type,
> +                                      bool gate,
> +                                      int inst)
>  {
>         int ret =3D 0;
>         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
>         enum ip_power_state pwr_state =3D gate ? POWER_STATE_OFF : POWER_=
STATE_ON;
> +       bool is_vcn =3D (block_type =3D=3D AMD_IP_BLOCK_TYPE_UVD || block=
_type =3D=3D AMD_IP_BLOCK_TYPE_VCN);
>
> -       if (atomic_read(&adev->pm.pwr_state[block_type]) =3D=3D pwr_state=
) {
> +       if (atomic_read(&adev->pm.pwr_state[block_type]) =3D=3D pwr_state=
 &&
> +                       (!is_vcn || adev->vcn.num_vcn_inst =3D=3D 1)) {
>                 dev_dbg(adev->dev, "IP block%d already in the target %s s=
tate!",
>                                 block_type, gate ? "gate" : "ungate");
>                 return 0;
> @@ -98,11 +103,9 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_d=
evice *adev, uint32_t block
>                                 (adev)->powerplay.pp_handle, block_type, =
gate, 0));
>                 break;
>         case AMD_IP_BLOCK_TYPE_VCN:
> -               if (pp_funcs && pp_funcs->set_powergating_by_smu) {
> -                       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++=
)
> -                               ret =3D (pp_funcs->set_powergating_by_smu=
(
> -                                       (adev)->powerplay.pp_handle, bloc=
k_type, gate, i));
> -               }
> +               if (pp_funcs && pp_funcs->set_powergating_by_smu)
> +                       ret =3D (pp_funcs->set_powergating_by_smu(
> +                               (adev)->powerplay.pp_handle, block_type, =
gate, inst));
>                 break;
>         default:
>                 break;
> @@ -572,12 +575,38 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *ad=
ev, bool enable)
>                 return;
>         }
>
> -       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_UVD, !enable);
> +       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_UVD, !enable, 0);
>         if (ret)
>                 DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n",
>                           enable ? "enable" : "disable", ret);
>  }
>
> +void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
> +{
> +       int ret =3D 0;
> +
> +       if (adev->family =3D=3D AMDGPU_FAMILY_SI) {
> +               mutex_lock(&adev->pm.mutex);
> +               if (enable) {
> +                       adev->pm.dpm.uvd_active =3D true;
> +                       adev->pm.dpm.state =3D POWER_STATE_TYPE_INTERNAL_=
UVD;
> +               } else {
> +                       adev->pm.dpm.uvd_active =3D false;
> +               }
> +               mutex_unlock(&adev->pm.mutex);
> +
> +               amdgpu_dpm_compute_clocks(adev);
> +               return;
> +       }

The SI logic can be dropped.  There are no SI parts with VCN.

Alex

> +
> +       for (int i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> +               ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BL=
OCK_TYPE_VCN, !enable, i);
> +               if (ret)
> +                       DRM_ERROR("Dpm %s uvd failed, ret =3D %d. \n",
> +                                 enable ? "enable" : "disable", ret);
> +       }
> +}
> +
>  void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
>  {
>         int ret =3D 0;
> @@ -597,7 +626,7 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev=
, bool enable)
>                 return;
>         }
>
> -       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_VCE, !enable);
> +       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_VCE, !enable, 0);
>         if (ret)
>                 DRM_ERROR("Dpm %s vce failed, ret =3D %d. \n",
>                           enable ? "enable" : "disable", ret);
> @@ -607,7 +636,7 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *ade=
v, bool enable)
>  {
>         int ret =3D 0;
>
> -       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_JPEG, !enable);
> +       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_JPEG, !enable, 0);
>         if (ret)
>                 DRM_ERROR("Dpm %s jpeg failed, ret =3D %d. \n",
>                           enable ? "enable" : "disable", ret);
> @@ -617,7 +646,7 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev=
, bool enable)
>  {
>         int ret =3D 0;
>
> -       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_VPE, !enable);
> +       ret =3D amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE=
_VPE, !enable, 0);
>         if (ret)
>                 DRM_ERROR("Dpm %s vpe failed, ret =3D %d.\n",
>                           enable ? "enable" : "disable", ret);
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/am=
d/pm/inc/amdgpu_dpm.h
> index f5bf41f21c41..e7c84d4a431a 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -393,7 +393,7 @@ int amdgpu_dpm_get_apu_thermal_limit(struct amdgpu_de=
vice *adev, uint32_t *limit
>  int amdgpu_dpm_set_apu_thermal_limit(struct amdgpu_device *adev, uint32_=
t limit);
>
>  int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
> -                                     uint32_t block_type, bool gate);
> +                                     uint32_t block_type, bool gate, int=
 inst);
>
>  extern int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low);
>
> @@ -442,6 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_devic=
e *adev);
>
>  void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
>  void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
> +void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
>  void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
>  void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
>  void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
> --
> 2.34.1
>
