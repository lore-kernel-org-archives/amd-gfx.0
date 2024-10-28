Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058D2D3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9418D10E51F;
	Mon, 28 Oct 2024 19:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6ZnGpX/";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2554C10E534
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:22:29 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-7ede26dc527so366722a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143349; x=1730748149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDLrobgWCY8Sc1n9ZOCObCTCQ1um7bKQJlNoBO1HIO0=;
 b=V6ZnGpX/Sypcjob4X7ZK3YmRZKf+Oe0ximBQdCw1VtLCaw01upZyNJAaGOJuxHWfUj
 hqBMXhulgIGi636Cn5ChR2YWHDH9GSZnRf0L9Sr31PRMhdDzmL2a8M11bUCLpAAGNSay
 pRUif9yJF8AaKS2eoLv1z3x9yLo1heUDsS30wsT/wPwKecAcL7tIHlBFFwtzUR0NxphA
 DWYpY/DW+JzZyghlGmbzhysPihW/jCzAP2wPdH5YPuqhS1EkaBjoW2YXiTsRxa9ClGyT
 Y0fFl8+A2rEZgyBLQ1M9sq/GhHoF04yqzIP4D+HLKPxu95osYRf+qj+7+KailLNJhhmZ
 s7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143349; x=1730748149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDLrobgWCY8Sc1n9ZOCObCTCQ1um7bKQJlNoBO1HIO0=;
 b=VYBSSHUvCluiTgfiYqHeUTZFhuZTrDImU7yHxH+GEqAabpKYhCWpCnIvadX+zLYEL5
 ZZJqfxLo19SyFOVy5cD7F/Ak9SPIs7IxjZCXMx8DzJgnaXQ1RY/5M7F86edPVCtd6ftl
 4A6K/8BTWCbNQ8RYqU+YvLJFlLmF/3oH1cd8aGe5gNc7u8tPXivpFTRceUZB8gmeDfbm
 428fnE7k994WxbxArVhEwSwa29QByKcvici3rzm4uVGY+prcn2aPMmvScuepucfgI3a2
 2ZIXCRT4uzli00ttnlu+ZVIu3PiblPtVWqvAfDEIau4h61rFZPljbCG5e79TDOV8U7eQ
 HSQQ==
X-Gm-Message-State: AOJu0YzNo/nX0+BeQsm8Q/GDAZQCdKC8mdLmFh7Y0dDwtRjgEqriz3CW
 bm/a6AXOZ/Nc4qARpxZy3amE+w9Sx+9lSu9mq9CkFWvtEfrGnPfOW1EtKT3Ttt8GC9c2Wp8OAA3
 PtrdPy04m+FtR/x8uaUxU1bB3UtRHqbQo
X-Google-Smtp-Source: AGHT+IHVUk1rB7b6cMV3uJCRdGcwut46L3+4jtzlj5akLbZWNxcrf5YjeLh5C4XVSowrvzRx6pDAqcirHQjWx61hvo0=
X-Received: by 2002:a05:6a20:7492:b0:1cf:4903:7f66 with SMTP id
 adf61e73a8af0-1d9a83af7e3mr6144654637.2.1730143348475; Mon, 28 Oct 2024
 12:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-12-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-12-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:22:17 -0400
Message-ID: <CADnq5_N8T3SBsCftd4Pnqkj0xEwfWLaL56FwYDCTYcFGNnwKSA@mail.gmail.com>
Subject: Re: [PATCH 11/29] drm/amdgpu/vcn: separate gating state by instance
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

On Thu, Oct 24, 2024 at 11:08=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> vcn gating state should now be based on instance. For example, instance 0
> can be gated while instance 1 is ungated, or vice versa.
>
> Therefore, change the cur_state to be an array, so that it can track the
> gating status for each vcn instance now.
>
> v2: remove redundant codes in v1.
>
> v3: move cur_state from amdgpu_vcn to amdgou_vcn_inst since it's a per
> instance variable.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  7 ++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  9 ++++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 28 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 25 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 31 ++++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 10 +++++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 24 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 24 +++++++++---------
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 ++-
>  10 files changed, 84 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.h
> index ba58b4f07643..2b8c9b8d4494 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -298,6 +298,7 @@ struct amdgpu_vcn_inst {
>         struct amdgpu_vcn_fw_shared fw_shared;
>         uint8_t                 aid_id;
>         const struct firmware   *fw; /* VCN firmware */
> +       enum amd_powergating_state cur_state;
>         uint8_t                 vcn_config;
>         uint32_t                vcn_codec_disable_mask;
>  };
> @@ -310,7 +311,6 @@ struct amdgpu_vcn {
>         unsigned                fw_version;
>         struct delayed_work     idle_work;
>         unsigned                num_enc_rings;
> -       enum amd_powergating_state cur_state;
>         bool                    indirect_sram;
>
>         uint8_t num_vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 5ea96c983517..c2eb187b0a27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -               (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
> +               (adev->vcn.inst[0].cur_state !=3D AMD_PG_STATE_GATE &&
>                  RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>                 vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GAT=
E);
>         }
> @@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>         int ret;
>         struct amdgpu_device *adev =3D ip_block->adev;
>
> -       if (state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[0].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1822,7 +1822,8 @@ static int vcn_v1_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                 ret =3D vcn_v1_0_start(adev);
>
>         if (!ret)
> -               adev->vcn.cur_state =3D state;
> +               adev->vcn.inst[0].cur_state =3D state;
> +
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_0.c
> index e42cfc731ad8..04edbb368903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -316,7 +316,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *i=
p_block)
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
>         if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -           (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
> +           (adev->vcn.inst[0].cur_state !=3D AMD_PG_STATE_GATE &&
>               RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>                 vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GAT=
E);
>
> @@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>         struct amdgpu_device *adev =3D ip_block->adev;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               adev->vcn.cur_state =3D AMD_PG_STATE_UNGATE;
> +               adev->vcn.inst[0].cur_state =3D AMD_PG_STATE_UNGATE;
>                 return 0;
>         }
>
> -       if (state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[0].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                 ret =3D vcn_v2_0_start(adev);
>
>         if (!ret)
> -               adev->vcn.cur_state =3D state;
> +               adev->vcn.inst[0].cur_state =3D state;
> +
>         return ret;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v2_5.c
> index b518202955ca..a14b634c433c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -388,23 +388,22 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block =
*ip_block)
>  static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i;
> +       int inst =3D ip_block->instance;
>
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -
> -               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -                   (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE &&
> -                    RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> -                       vcn_v2_5_set_powergating_state(ip_block, AMD_PG_S=
TATE_GATE);
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> -                       amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poiso=
n_irq, 0);
> +       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +           (adev->vcn.inst[inst].cur_state !=3D AMD_PG_STATE_GATE &&
> +            RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
> +               vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GAT=
E);
>         }
>
> +       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> +               amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq=
, 0);
> +
>         return 0;
>  }
>
> @@ -1830,12 +1829,13 @@ static int vcn_v2_5_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>                                           enum amd_powergating_state stat=
e)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int ret;
>
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       if(state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[inst].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1843,8 +1843,8 @@ static int vcn_v2_5_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>         else
>                 ret =3D vcn_v2_5_start(adev);
>
> -       if(!ret)
> -               adev->vcn.cur_state =3D state;
> +       if (!ret)
> +               adev->vcn.inst[inst].cur_state =3D state;
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 63ddd4cca910..3b38b67f6da2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -420,20 +420,18 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>  static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i;
> +       int inst =3D ip_block->instance;
>
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
>
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -                               (adev->vcn.cur_state !=3D AMD_PG_STATE_GA=
TE &&
> -                                RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> -                               vcn_v3_0_set_powergating_state(ip_block, =
AMD_PG_STATE_GATE);
> -                       }
> +       if (!amdgpu_sriov_vf(adev)) {
> +               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +                   (adev->vcn.inst[inst].cur_state !=3D AMD_PG_STATE_GAT=
E &&
> +                    RREG32_SOC15(VCN, inst, mmUVD_STATUS))) {
> +                       vcn_v3_0_set_powergating_state(ip_block, AMD_PG_S=
TATE_GATE);
>                 }
>         }
>
> @@ -2163,6 +2161,7 @@ static int vcn_v3_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                                           enum amd_powergating_state stat=
e)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int ret;
>
>         /* for SRIOV, guest should not control VCN Power-gating
> @@ -2170,11 +2169,11 @@ static int vcn_v3_0_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>          * guest should avoid touching CGC and PG
>          */
>         if (amdgpu_sriov_vf(adev)) {
> -               adev->vcn.cur_state =3D AMD_PG_STATE_UNGATE;
> +               adev->vcn.inst[inst].cur_state =3D AMD_PG_STATE_UNGATE;
>                 return 0;
>         }
>
> -       if (state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[inst].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -2183,7 +2182,7 @@ static int vcn_v3_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                 ret =3D vcn_v3_0_start(adev);
>
>         if (!ret)
> -               adev->vcn.cur_state =3D state;
> +               adev->vcn.inst[inst].cur_state =3D state;
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 1a6257d324c9..87c8f1c084a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -348,24 +348,24 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block =
*ip_block)
>  static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i;
> +       int inst =3D ip_block->instance;
>
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -                               (adev->vcn.cur_state !=3D AMD_PG_STATE_GA=
TE &&
> -                                RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -                               vcn_v4_0_set_powergating_state(ip_block, =
AMD_PG_STATE_GATE);
> -                       }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
> +
> +       if (!amdgpu_sriov_vf(adev)) {
> +               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +                   (adev->vcn.inst[inst].cur_state !=3D AMD_PG_STATE_GAT=
E &&
> +                    RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
> +                       vcn_v4_0_set_powergating_state(ip_block, AMD_PG_S=
TATE_GATE);
>                 }
> -               if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> -                       amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poiso=
n_irq, 0);
>         }
>
> +       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> +               amdgpu_irq_put(adev, &adev->vcn.inst[inst].ras_poison_irq=
, 0);
> +
>         return 0;
>  }
>
> @@ -2042,6 +2042,7 @@ static int vcn_v4_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                                           enum amd_powergating_state stat=
e)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int ret;
>
>         /* for SRIOV, guest should not control VCN Power-gating
> @@ -2049,11 +2050,11 @@ static int vcn_v4_0_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>          * guest should avoid touching CGC and PG
>          */
>         if (amdgpu_sriov_vf(adev)) {
> -               adev->vcn.cur_state =3D AMD_PG_STATE_UNGATE;
> +               adev->vcn.inst[inst].cur_state =3D AMD_PG_STATE_UNGATE;
>                 return 0;
>         }
>
> -       if (state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[inst].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -2062,7 +2063,7 @@ static int vcn_v4_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                 ret =3D vcn_v4_0_start(adev);
>
>         if (!ret)
> -               adev->vcn.cur_state =3D state;
> +               adev->vcn.inst[inst].cur_state =3D state;
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 23a2a80129bb..8e7d7318cf58 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -315,10 +315,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> -       if (adev->vcn.cur_state !=3D AMD_PG_STATE_GATE)
> +       if (adev->vcn.inst[inst].cur_state !=3D AMD_PG_STATE_GATE)
>                 vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_G=
ATE);
>
>         return 0;
> @@ -1627,6 +1628,7 @@ static int vcn_v4_0_3_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>                                           enum amd_powergating_state stat=
e)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int ret;
>
>         /* for SRIOV, guest should not control VCN Power-gating
> @@ -1634,11 +1636,11 @@ static int vcn_v4_0_3_set_powergating_state(struc=
t amdgpu_ip_block *ip_block,
>          * guest should avoid touching CGC and PG
>          */
>         if (amdgpu_sriov_vf(adev)) {
> -               adev->vcn.cur_state =3D AMD_PG_STATE_UNGATE;
> +               adev->vcn.inst[inst].cur_state =3D AMD_PG_STATE_UNGATE;
>                 return 0;
>         }
>
> -       if (state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[inst].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1647,7 +1649,7 @@ static int vcn_v4_0_3_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>                 ret =3D vcn_v4_0_3_start(adev);
>
>         if (!ret)
> -               adev->vcn.cur_state =3D state;
> +               adev->vcn.inst[inst].cur_state =3D state;
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index e49ba5bc7fa0..9c5257f370f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -298,19 +298,18 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i;
> +       int inst =3D ip_block->instance;
>
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -                               (adev->vcn.cur_state !=3D AMD_PG_STATE_GA=
TE &&
> -                               RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -                               vcn_v4_0_5_set_powergating_state(ip_block=
, AMD_PG_STATE_GATE);
> -                       }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
> +
> +       if (!amdgpu_sriov_vf(adev)) {
> +               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +                   (adev->vcn.inst[inst].cur_state !=3D AMD_PG_STATE_GAT=
E &&
> +                    RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
> +                       vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG=
_STATE_GATE);
>                 }
>         }
>
> @@ -1536,9 +1535,10 @@ static int vcn_v4_0_5_set_powergating_state(struct=
 amdgpu_ip_block *ip_block,
>                 enum amd_powergating_state state)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int ret;
>
> -       if (state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[inst].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1547,7 +1547,7 @@ static int vcn_v4_0_5_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>                 ret =3D vcn_v4_0_5_start(adev);
>
>         if (!ret)
> -               adev->vcn.cur_state =3D state;
> +               adev->vcn.inst[inst].cur_state =3D state;
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 900ca8ababc1..4ecf0aea156f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -262,19 +262,18 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_bloc=
k *ip_block)
>  static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i;
> +       int inst =3D ip_block->instance;
>
>         cancel_delayed_work_sync(&adev->vcn.idle_work);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -                               (adev->vcn.cur_state !=3D AMD_PG_STATE_GA=
TE &&
> -                               RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -                               vcn_v5_0_0_set_powergating_state(ip_block=
, AMD_PG_STATE_GATE);
> -                       }
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
> +
> +       if (!amdgpu_sriov_vf(adev)) {
> +               if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> +                   (adev->vcn.inst[inst].cur_state !=3D AMD_PG_STATE_GAT=
E &&
> +                    RREG32_SOC15(VCN, inst, regUVD_STATUS))) {
> +                       vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG=
_STATE_GATE);
>                 }
>         }
>
> @@ -1263,9 +1262,10 @@ static int vcn_v5_0_0_set_powergating_state(struct=
 amdgpu_ip_block *ip_block,
>                 enum amd_powergating_state state)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> +       int inst =3D ip_block->instance;
>         int ret;
>
> -       if (state =3D=3D adev->vcn.cur_state)
> +       if (state =3D=3D adev->vcn.inst[inst].cur_state)
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> @@ -1274,7 +1274,7 @@ static int vcn_v5_0_0_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>                 ret =3D vcn_v5_0_0_start(adev);
>
>         if (!ret)
> -               adev->vcn.cur_state =3D state;
> +               adev->vcn.inst[inst].cur_state =3D state;
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 6f2b8ef07a41..0dd9bcc54e95 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2048,7 +2048,8 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_b=
lock)
>         smu_dpm_set_vpe_enable(smu, false);
>         smu_dpm_set_umsch_mm_enable(smu, false);
>
> -       adev->vcn.cur_state =3D AMD_PG_STATE_GATE;
> +       for (int i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> +               adev->vcn.inst[i].cur_state =3D AMD_PG_STATE_GATE;
>         adev->jpeg.cur_state =3D AMD_PG_STATE_GATE;
>
>         if (!smu->pm_enabled)
> --
> 2.34.1
>
