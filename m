Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883F1D3E2BB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3825B10E534;
	Mon, 28 Oct 2024 19:29:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Axg8iba5";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A47B410E534
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:29:25 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-71e617c3e9bso247875b3a.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143765; x=1730748565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjujEu9BN9vPVOOW5Zr8oKmcUYv4KB5WtW7D6fO3JhM=;
 b=Axg8iba58L5lfd9ALx9PLcfkxNF2DoHYYhtsMPbvFkKg2BMRA70/Ui9IkXcBRe2kHs
 e7DzuY4VlN0PmsaEejuYLnuOFshTHlErfaZ5/K4QgeALoV0r1+9ahVjA95mWZ3eHza+8
 c4nORK5LNY1VnyKZ0ld0DUtOmL+WmhUVxOkaEKq4V8MAUHcvfT/H+iW10H1AI84I1c53
 bUCME6t8ckMgCdUCPbsHwRSSRXdiA0M8jG/cZUJuTOQykT4L/pkIwFcQQ33XU+/wxlqa
 r9/synurApk3sYOjPvXQ6/XnK9hEdaIIPSjvvZl5NUQGL4f2gMY7RgHB9RUB9/Xwa+fw
 /YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143765; x=1730748565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QjujEu9BN9vPVOOW5Zr8oKmcUYv4KB5WtW7D6fO3JhM=;
 b=T1wj81y020iiUl2kjlV0NVCCFZ/pIJDrbGAHnOQfAIUdky6lSQIOIgVHooKKzn/OjI
 NomF+XvUPCmj6X+AHIpU21WdVW8Ba/hdERkhQ6B7LJylkFUkIsNSh66rIDru0H50dZaA
 Hz+/wBI0sjzL3ahkjXtzjdSa27QfCprFzCHYM/R8yGXIcN9OJfFj+QhjH7wrzOk+JmLX
 ZwB3c6YZRtcXehvYXiqotx5GmxR0IsmgYZRBrLPtCETmOxHaEsbc1WL0Sxc3icpYPJgW
 Knbqy8sluBhjkFaJQ4bXxp8t2et/pThYmKZcrgGIDm+yTkFA2WWhI4/+IrhBi7WR/zcu
 wrnA==
X-Gm-Message-State: AOJu0YyVfa6BApIFgXs/IKCOHT52rvGMpvKdZ+isGJewGMzyEPq+ofiA
 LN7G/6jPeVOm4PUddafforWRP3pGfFJzM1z0arBBQ0fbX924dOegFL6qQGDjiVIyQpDltS9rtqo
 5uE8cY7ErGvwHnG3vQYbVD+J3iSd2ICSm
X-Google-Smtp-Source: AGHT+IF2iun4e68LpKbR3u/6VYIa6ghGRXV34LIdIN9zFfQm3Tj55zxtEjfS85btVVdTQn1m2COKxQOBqO20szMMKPo=
X-Received: by 2002:a05:6a00:2da4:b0:71e:6895:fe9e with SMTP id
 d2e1a72fcca58-72063059e84mr5526414b3a.6.1730143765038; Mon, 28 Oct 2024
 12:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-18-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-18-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:29:13 -0400
Message-ID: <CADnq5_M9H=GtAd4iB40RPDryLx4MbFJGfVxhQ05EnchXvpY2LA@mail.gmail.com>
Subject: Re: [PATCH 17/29] drm/amdgpu: power vcn 5_0_0 by instance
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

On Fri, Oct 25, 2024 at 2:23=E2=80=AFAM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> For vcn 5_0_0, add ip_block for each vcn instance during discovery stage.
>
> And only powering on/off one of the vcn instance using the
> instance value stored in ip_block, instead of powering on/off all
> vcn instances. Modify the existing functions to use the instance value
> in ip_block, and remove the original for loop for all vcn instances.
>
> v2: rename "i"/"j" to "inst" for instance value.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       | 432 +++++++++---------
>  2 files changed, 213 insertions(+), 222 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 48160fa4d8ef..3c85a692a34e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2363,7 +2363,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
>                         amdgpu_device_ip_block_add(adev, &jpeg_v4_0_5_ip_=
block);
>                         break;
>                 case IP_VERSION(5, 0, 0):
> -                       amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_b=
lock);
> +                       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> +                               amdgpu_device_ip_block_add(adev, &vcn_v5_=
0_0_ip_block);
>                         amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_=
block);
>                         break;
>                 default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 4ecf0aea156f..15620e111d04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -116,7 +116,7 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>  {
>         struct amdgpu_ring *ring;
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, r;
> +       int inst =3D ip_block->instance, r;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_5_0);
>         uint32_t *ptr;
>
> @@ -130,46 +130,44 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         if (r)
>                 return r;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               volatile struct amdgpu_vcn5_fw_shared *fw_shared;
> -
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>
> -               atomic_set(&adev->vcn.inst[i].sched_score, 0);
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               goto done;
>
> -               /* VCN UNIFIED TRAP */
> -               r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> -                               VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, =
&adev->vcn.inst[i].irq);
> -               if (r)
> -                       return r;
> +       atomic_set(&adev->vcn.inst[inst].sched_score, 0);
>
> -               /* VCN POISON TRAP */
> -               r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> -                               VCN_4_0__SRCID_UVD_POISON, &adev->vcn.ins=
t[i].irq);
> -               if (r)
> -                       return r;
> +       /* VCN UNIFIED TRAP */
> +       r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +                       VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->v=
cn.inst[inst].irq);
> +       if (r)
> +               return r;
>
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> -               ring->use_doorbell =3D true;
> -               ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ri=
ng0_1 << 1) + 2 + 8 * i;
> +       /* VCN POISON TRAP */
> +       r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +                       VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].=
irq);
> +       if (r)
> +               return r;
>
> -               ring->vm_hub =3D AMDGPU_MMHUB0(0);
> -               sprintf(ring->name, "vcn_unified_%d", i);
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +       ring->use_doorbell =3D true;
> +       ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ring0_1 <<=
 1) + 2 + 8 * inst;
>
> -               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i=
].irq, 0,
> -                                               AMDGPU_RING_PRIO_0, &adev=
->vcn.inst[i].sched_score);
> -               if (r)
> -                       return r;
> +       ring->vm_hub =3D AMDGPU_MMHUB0(0);
> +       sprintf(ring->name, "vcn_unified_%d", inst);
>
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -               fw_shared->present_flag_0 =3D cpu_to_le32(AMDGPU_FW_SHARE=
D_FLAG_0_UNIFIED_QUEUE);
> -               fw_shared->sq.is_enabled =3D 1;
> +       r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq=
, 0,
> +                                       AMDGPU_RING_PRIO_0, &adev->vcn.in=
st[inst].sched_score);
> +       if (r)
> +               return r;
>
> -               if (amdgpu_vcnfw_log)
> -                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> -       }
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +       fw_shared->present_flag_0 =3D cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0=
_UNIFIED_QUEUE);
> +       fw_shared->sq.is_enabled =3D 1;
>
> +       if (amdgpu_vcnfw_log)
> +               amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
> +done:
>         if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>                 adev->vcn.pause_dpg_mode =3D vcn_v5_0_0_pause_dpg_mode;
>
> @@ -753,151 +751,147 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgp=
u_device *adev, int inst_idx, b
>   *
>   * Start VCN block
>   */
> -static int vcn_v5_0_0_start(struct amdgpu_device *adev)
> +static int vcn_v5_0_0_start(struct amdgpu_device *adev, unsigned int ins=
t)
>  {
>         volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>         struct amdgpu_ring *ring;
>         uint32_t tmp;
> -       int i, j, k, r;
> +       int j, k, r;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       if (adev->pm.dpm_enabled)
> +               amdgpu_dpm_enable_vcn(adev, true, inst);
> +
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               return 0;
> +
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +               r =3D vcn_v5_0_0_start_dpg_mode(adev, inst, adev->vcn.ind=
irect_sram);
> +               return r;
>         }
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       /* disable VCN power gating */
> +       vcn_v5_0_0_disable_static_power_gating(adev, inst);
>
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> +       /* set VCN status busy */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_=
BUSY;
> +       WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       r =3D vcn_v5_0_0_start_dpg_mode(adev, i, adev->vc=
n.indirect_sram);
> -                       continue;
> -               }
> +       /* enable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> +               UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>
> -               /* disable VCN power gating */
> -               vcn_v5_0_0_disable_static_power_gating(adev, i);
> +       /* disable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
> +               ~UVD_MASTINT_EN__VCPU_EN_MASK);
>
> -               /* set VCN status busy */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS_=
_UVD_BUSY;
> -               WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> +       /* enable LMI MC and UMC channels */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
> +               ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>
> -               /* enable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -                       UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_E=
N_MASK);
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
>
> -               /* disable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> -                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +       /* setup regUVD_LMI_CTRL */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
> +       WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
> +               UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +               UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +               UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +               UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>
> -               /* enable LMI MC and UMC channels */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> -                       ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -
> -               /* setup regUVD_LMI_CTRL */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> -               WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> -                       UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -                       UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -                       UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -                       UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -               vcn_v5_0_0_mc_resume(adev, i);
> -
> -               /* VCN global tiling registers */
> -               WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> -                       adev->gfx.config.gb_addr_config);
> -
> -               /* unblock VCPU register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> -                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -               /* release VCPU reset to boot */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -               for (j =3D 0; j < 10; ++j) {
> -                       uint32_t status;
> -
> -                       for (k =3D 0; k < 100; ++k) {
> -                               status =3D RREG32_SOC15(VCN, i, regUVD_ST=
ATUS);
> -                               if (status & 2)
> -                                       break;
> -                               mdelay(10);
> -                               if (amdgpu_emu_mode =3D=3D 1)
> -                                       msleep(1);
> -                       }
> +       vcn_v5_0_0_mc_resume(adev, inst);
> +
> +       /* VCN global tiling registers */
> +       WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
> +               adev->gfx.config.gb_addr_config);
> +
> +       /* unblock VCPU register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
> +               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +       /* release VCPU reset to boot */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> +               ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +       for (j =3D 0; j < 10; ++j) {
> +               uint32_t status;
> +
> +               for (k =3D 0; k < 100; ++k) {
> +                       status =3D RREG32_SOC15(VCN, inst, regUVD_STATUS)=
;
> +                       if (status & 2)
> +                               break;
> +                       mdelay(10);
> +                       if (amdgpu_emu_mode =3D=3D 1)
> +                               msleep(1);
> +               }
>
> -                       if (amdgpu_emu_mode =3D=3D 1) {
> -                               r =3D -1;
> -                               if (status & 2) {
> -                                       r =3D 0;
> -                                       break;
> -                               }
> -                       } else {
> +               if (amdgpu_emu_mode =3D=3D 1) {
> +                       r =3D -1;
> +                       if (status & 2) {
>                                 r =3D 0;
> -                               if (status & 2)
> -                                       break;
> -
> -                               dev_err(adev->dev,
> -                                       "VCN[%d] is not responding, tryin=
g to reset the VCPU!!!\n", i);
> -                               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_=
VCPU_CNTL),
> -                                                       UVD_VCPU_CNTL__BL=
K_RST_MASK,
> -                                                       ~UVD_VCPU_CNTL__B=
LK_RST_MASK);
> -                               mdelay(10);
> -                               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_=
VCPU_CNTL), 0,
> -                                                       ~UVD_VCPU_CNTL__B=
LK_RST_MASK);
> -
> -                               mdelay(10);
> -                               r =3D -1;
> +                               break;
>                         }
> +               } else {
> +                       r =3D 0;
> +                       if (status & 2)
> +                               break;
> +
> +                       dev_err(adev->dev,
> +                               "VCN[%d] is not responding, trying to res=
et the VCPU!!!\n", inst);
> +                       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_=
CNTL),
> +                                               UVD_VCPU_CNTL__BLK_RST_MA=
SK,
> +                                               ~UVD_VCPU_CNTL__BLK_RST_M=
ASK);
> +                       mdelay(10);
> +                       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_=
CNTL), 0,
> +                                               ~UVD_VCPU_CNTL__BLK_RST_M=
ASK);
> +
> +                       mdelay(10);
> +                       r =3D -1;
>                 }
> +       }
>
> -               if (r) {
> -                       dev_err(adev->dev, "VCN[%d] is not responding, gi=
ving up!!!\n", i);
> -                       return r;
> -               }
> +       if (r) {
> +               dev_err(adev->dev, "VCN[%d] is not responding, giving up!=
!!\n", inst);
> +               return r;
> +       }
>
> -               /* enable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> -                               UVD_MASTINT_EN__VCPU_EN_MASK,
> -                               ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +       /* enable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
> +                       UVD_MASTINT_EN__VCPU_EN_MASK,
> +                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
>
> -               /* clear the busy bit of VCN_STATUS */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> -                       ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +       /* clear the busy bit of VCN_STATUS */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
> +               ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> -               WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> -                       ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
> -                       VCN_RB1_DB_CTRL__EN_MASK);
> -
> -               WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> -               WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(rin=
g->gpu_addr));
> -               WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4)=
;
> -
> -               tmp =3D RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -               tmp &=3D ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -               WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -               fw_shared->sq.queue_mode |=3D FW_QUEUE_RING_RESET;
> -               WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> -               WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> -
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> -               WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> -               ring->wptr =3D RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> -
> -               tmp =3D RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -               tmp |=3D VCN_RB_ENABLE__RB1_EN_MASK;
> -               WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -               fw_shared->sq.queue_mode &=3D ~(FW_QUEUE_RING_RESET | FW_=
QUEUE_DPG_HOLD_OFF);
> -       }
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +       WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
> +               ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +               VCN_RB1_DB_CTRL__EN_MASK);
> +
> +       WREG32_SOC15(VCN, inst, regUVD_RB_BASE_LO, ring->gpu_addr);
> +       WREG32_SOC15(VCN, inst, regUVD_RB_BASE_HI, upper_32_bits(ring->gp=
u_addr));
> +       WREG32_SOC15(VCN, inst, regUVD_RB_SIZE, ring->ring_size / 4);
> +
> +       tmp =3D RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> +       tmp &=3D ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +       WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> +       fw_shared->sq.queue_mode |=3D FW_QUEUE_RING_RESET;
> +       WREG32_SOC15(VCN, inst, regUVD_RB_RPTR, 0);
> +       WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, 0);
> +
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_RB_RPTR);
> +       WREG32_SOC15(VCN, inst, regUVD_RB_WPTR, tmp);
> +       ring->wptr =3D RREG32_SOC15(VCN, inst, regUVD_RB_WPTR);
> +
> +       tmp =3D RREG32_SOC15(VCN, inst, regVCN_RB_ENABLE);
> +       tmp |=3D VCN_RB_ENABLE__RB1_EN_MASK;
> +       WREG32_SOC15(VCN, inst, regVCN_RB_ENABLE, tmp);
> +       fw_shared->sq.queue_mode &=3D ~(FW_QUEUE_RING_RESET | FW_QUEUE_DP=
G_HOLD_OFF);
>
>         return 0;
>  }
> @@ -939,80 +933,76 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_=
device *adev, int inst_idx)
>   *
>   * Stop VCN block
>   */
> -static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
> +static int vcn_v5_0_0_stop(struct amdgpu_device *adev, unsigned int inst=
)
>  {
>         volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>         uint32_t tmp;
> -       int i, r =3D 0;
> +       int r =3D 0;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> -
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -               fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               goto done;
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       vcn_v5_0_0_stop_dpg_mode(adev, i);
> -                       continue;
> -               }
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +       fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
>
> -               /* wait for vcn idle */
> -               r =3D SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATU=
S__IDLE, 0x7);
> -               if (r)
> -                       return r;
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +               vcn_v5_0_0_stop_dpg_mode(adev, inst);
> +               goto done;
> +       }
>
> -               tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -                     UVD_LMI_STATUS__READ_CLEAN_MASK |
> -                     UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -                     UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -               r =3D SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, =
tmp);
> -               if (r)
> -                       return r;
> +       /* wait for vcn idle */
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_STATUS, UVD_STATUS__ID=
LE, 0x7);
> +       if (r)
> +               return r;
>
> -               /* disable LMI UMC channel */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> -               tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -               WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> -               tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -                     UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -               r =3D SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, =
tmp);
> -               if (r)
> -                       return r;
> +       tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +                 UVD_LMI_STATUS__READ_CLEAN_MASK |
> +                 UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +                 UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> +       if (r)
> +               return r;
>
> -               /* block VCPU register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> -                       UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -               /* reset VCPU */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -                       UVD_VCPU_CNTL__BLK_RST_MASK,
> -                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -               /* disable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -                       ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> -
> -               /* apply soft reset */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -
> -               /* clear status */
> -               WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
> -
> -               /* enable VCN power gating */
> -               vcn_v5_0_0_enable_static_power_gating(adev, i);
> -       }
> +       /* disable LMI UMC channel */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
> +       tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
> +       tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +                 UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> +       if (r)
> +               return r;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, false, i);
> -       }
> +       /* block VCPU register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
> +               UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +       /* reset VCPU */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> +               UVD_VCPU_CNTL__BLK_RST_MASK,
> +               ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +       /* disable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> +               ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +
> +       /* apply soft reset */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +
> +       /* clear status */
> +       WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
> +
> +       /* enable VCN power gating */
> +       vcn_v5_0_0_enable_static_power_gating(adev, inst);
> +done:
> +       if (adev->pm.dpm_enabled)
> +               amdgpu_dpm_enable_vcn(adev, false, inst);
>
>         return 0;
>  }
> @@ -1269,9 +1259,9 @@ static int vcn_v5_0_0_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> -               ret =3D vcn_v5_0_0_stop(adev);
> +               ret =3D vcn_v5_0_0_stop(adev, inst);
>         else
> -               ret =3D vcn_v5_0_0_start(adev);
> +               ret =3D vcn_v5_0_0_start(adev, inst);
>
>         if (!ret)
>                 adev->vcn.inst[inst].cur_state =3D state;
> --
> 2.34.1
>
