Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166FDD3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B744510E535;
	Mon, 28 Oct 2024 19:28:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rx+YOeqS";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568AC10E535
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:28:32 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-7c3d8105646so536337a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143712; x=1730748512; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KvBIjJlzPxvB63leTGO0DUt5/kTNQlxT9NJgDPQfbs=;
 b=Rx+YOeqSfvoVXh7HfyovP2afW+x0zShEQyOyCCxFKR7SJeLz/XFM/WpcPhlgJqxaaS
 HXk68xFpghJ06xbK8quXNvSrTp1EE2h5xyzfQiVVFrxQQ/UQJk3ezxtH5e3oF3ttVVYF
 KDiJawb7TIwCgaYGIYBlTJANOi63kSPTVOQ3uEK8xF+//9BFdjvmqWO6JpkhD3HwKtcG
 yYlhZ5yyGMmrudWL9sMk8FxmU6tsgnMOgYvMx1uci/M53//Qll6zP227S43lb2oB0cH5
 NqF+AqhE/VXymryTYpA0YClrjaQ1w+OlrLRsvTzazK+tx4DuHXIbQdtsf6JwItKjROGh
 UnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143712; x=1730748512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KvBIjJlzPxvB63leTGO0DUt5/kTNQlxT9NJgDPQfbs=;
 b=jnnTgZE0xKzCGehvDu6RlO70G7ZPOi1gXwDdMD96d6CXhFPMSsvluf96xHsnjXjl0R
 udGpioXnXismylvKLQPEGUs6j46HKps3DFGCw6OK0ZzzzEKG3zcSSGUqezirEn76Q773
 aGYJ0MIn/6+xZ/S/VtZey8HLmlmhzAC9pT8bQS5/K1uKPKDMX3OWvfOIembLl5WjdNlr
 WCva88zMqP6dMjES7lyIDkWc5OEMdA/gUuXKr6OYr4ivxcIsSL75fZgwbn/esnQ05xwg
 2EmN4VVaUXgn/VZ0HvuEL51tc0VipsFB7dOr2YxNPZjdP+tcAcy2rrX9sMFGGwwNBWEB
 EE7Q==
X-Gm-Message-State: AOJu0YwOMoVFv+JssWgQhUdNi5XbOmqMHzS0x0su09i8imiLFJ49mfkQ
 QQXXfCDJyxJP3KLDhqRKHYoxUVcTAfKapxIMZNIvq+TMOBxKZqg5wXjbdChXDNaGWovFkzGRXDF
 o069PfheoxLW9ubOjTf24zSjiqEbeim73
X-Google-Smtp-Source: AGHT+IEllKfWlndwA7oWRNPTHrfil36wBShoP/Wqvb/Oyb/NrX3AccoUtk6pZIkbeQv1gsjI4y4qJl0gvVOKeJJ38uk=
X-Received: by 2002:a05:6a20:4310:b0:1cf:4212:4bd6 with SMTP id
 adf61e73a8af0-1d9a8512bb7mr6723273637.7.1730143711650; Mon, 28 Oct 2024
 12:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-16-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-16-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:28:20 -0400
Message-ID: <CADnq5_Mjj9TrBn_fN13_XyAV4KYH1b+OZSCNE1_SBy6s_vraiQ@mail.gmail.com>
Subject: Re: [PATCH 15/29] drm/amdgpu: power vcn 4_0_3 by instance
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
> For vcn 4_0_3, add ip_block for each vcn instance during discovery stage.
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       | 462 +++++++++---------
>  2 files changed, 228 insertions(+), 237 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index aaa759765dba..ee10a9218df7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2352,7 +2352,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
>                         amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_bl=
ock);
>                         break;
>                 case IP_VERSION(4, 0, 3):
> -                       amdgpu_device_ip_block_add(adev, &vcn_v4_0_3_ip_b=
lock);
> +                       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> +                               amdgpu_device_ip_block_add(adev, &vcn_v4_=
0_3_ip_block);
>                         amdgpu_device_ip_block_add(adev, &jpeg_v4_0_3_ip_=
block);
>                         break;
>                 case IP_VERSION(4, 0, 5):
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 8e7d7318cf58..db6f8d424777 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -127,7 +127,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block =
*ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
>         struct amdgpu_ring *ring;
> -       int i, r, vcn_inst;
> +       int inst =3D ip_block->instance, r, vcn_inst;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0_3);
>         uint32_t *ptr;
>
> @@ -147,38 +147,36 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         if (r)
>                 return r;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +       volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>
> -               vcn_inst =3D GET_INST(VCN, i);
> +       vcn_inst =3D GET_INST(VCN, inst);
>
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> -               ring->use_doorbell =3D true;
> -
> -               if (!amdgpu_sriov_vf(adev))
> -                       ring->doorbell_index =3D
> -                               (adev->doorbell_index.vcn.vcn_ring0_1 << =
1) +
> -                               9 * vcn_inst;
> -               else
> -                       ring->doorbell_index =3D
> -                               (adev->doorbell_index.vcn.vcn_ring0_1 << =
1) +
> -                               32 * vcn_inst;
> -
> -               ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
> -               sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].a=
id_id);
> -               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->=
irq, 0,
> -                                    AMDGPU_RING_PRIO_DEFAULT,
> -                                    &adev->vcn.inst[i].sched_score);
> -               if (r)
> -                       return r;
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +       ring->use_doorbell =3D true;
>
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -               fw_shared->present_flag_0 =3D cpu_to_le32(AMDGPU_FW_SHARE=
D_FLAG_0_UNIFIED_QUEUE);
> -               fw_shared->sq.is_enabled =3D true;
> +       if (!amdgpu_sriov_vf(adev))
> +               ring->doorbell_index =3D
> +                       (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                       9 * vcn_inst;
> +       else
> +               ring->doorbell_index =3D
> +                       (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                       32 * vcn_inst;
> +
> +       ring->vm_hub =3D AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
> +       sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id=
);
> +       r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> +                                AMDGPU_RING_PRIO_DEFAULT,
> +                                &adev->vcn.inst[inst].sched_score);
> +       if (r)
> +               return r;
>
> -               if (amdgpu_vcnfw_log)
> -                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> -       }
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +       fw_shared->present_flag_0 =3D cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0=
_UNIFIED_QUEUE);
> +       fw_shared->sq.is_enabled =3D true;
> +
> +       if (amdgpu_vcnfw_log)
> +               amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
>
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D amdgpu_virt_alloc_mm_table(adev);
> @@ -1085,174 +1083,170 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu=
_device *adev)
>   *
>   * Start VCN block
>   */
> -static int vcn_v4_0_3_start(struct amdgpu_device *adev)
> +static int vcn_v4_0_3_start(struct amdgpu_device *adev, unsigned int ins=
t)
>  {
>         volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>         struct amdgpu_ring *ring;
> -       int i, j, k, r, vcn_inst;
> +       int j, k, r, vcn_inst;
>         uint32_t tmp;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, true, i);
> +       if (adev->pm.dpm_enabled)
> +               amdgpu_dpm_enable_vcn(adev, true, inst);
> +
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +               r =3D vcn_v4_0_3_start_dpg_mode(adev, inst, adev->vcn.ind=
irect_sram);
> +               return r;
>         }
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       r =3D vcn_v4_0_3_start_dpg_mode(adev, i, adev->vc=
n.indirect_sram);
> -                       continue;
> -               }
> +       vcn_inst =3D GET_INST(VCN, inst);
> +       /* set VCN status busy */
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
> +                 UVD_STATUS__UVD_BUSY;
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
>
> -               vcn_inst =3D GET_INST(VCN, i);
> -               /* set VCN status busy */
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS) |
> -                     UVD_STATUS__UVD_BUSY;
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
> -
> -               /*SW clock gating */
> -               vcn_v4_0_3_disable_clock_gating(adev, i);
> -
> -               /* enable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL=
),
> -                        UVD_VCPU_CNTL__CLK_EN_MASK,
> -                        ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -               /* disable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_E=
N), 0,
> -                        ~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -               /* enable LMI MC and UMC channels */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2=
), 0,
> -                        ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> -
> -               /* setup regUVD_LMI_CTRL */
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
> -                            tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MAS=
K |
> -                                    UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -                                    UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK=
 |
> -                                    UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN=
_MASK);
> -
> -               /* setup regUVD_MPC_CNTL */
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
> -               tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -               tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
> -
> -               /* setup UVD_MPC_SET_MUXA0 */
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
> -                            ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -                             (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -                             (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -                             (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)))=
;
> -
> -               /* setup UVD_MPC_SET_MUXB0 */
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
> -                            ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -                             (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -                             (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -                             (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)))=
;
> -
> -               /* setup UVD_MPC_SET_MUX */
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
> -                            ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -                             (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -                             (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -               vcn_v4_0_3_mc_resume(adev, i);
> -
> -               /* VCN global tiling registers */
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
> -                            adev->gfx.config.gb_addr_config);
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> -                            adev->gfx.config.gb_addr_config);
> -
> -               /* unblock VCPU register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CT=
RL), 0,
> -                        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -               /* release VCPU reset to boot */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL=
), 0,
> -                        ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +       /*SW clock gating */
> +       vcn_v4_0_3_disable_clock_gating(adev, inst);
> +
> +       /* enable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +                UVD_VCPU_CNTL__CLK_EN_MASK,
> +                ~UVD_VCPU_CNTL__CLK_EN_MASK);
>
> -               for (j =3D 0; j < 10; ++j) {
> -                       uint32_t status;
> +       /* disable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN), 0,
> +                ~UVD_MASTINT_EN__VCPU_EN_MASK);
>
> -                       for (k =3D 0; k < 100; ++k) {
> -                               status =3D RREG32_SOC15(VCN, vcn_inst,
> -                                                     regUVD_STATUS);
> -                               if (status & 2)
> -                                       break;
> -                               mdelay(10);
> -                       }
> -                       r =3D 0;
> -                       if (status & 2)
> -                               break;
> +       /* enable LMI MC and UMC channels */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_LMI_CTRL2), 0,
> +                ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>
> -                       DRM_DEV_ERROR(adev->dev,
> -                               "VCN decode not responding, trying to res=
et the VCPU!!!\n");
> -                       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> -                                                 regUVD_VCPU_CNTL),
> -                                UVD_VCPU_CNTL__BLK_RST_MASK,
> -                                ~UVD_VCPU_CNTL__BLK_RST_MASK);
> -                       mdelay(10);
> -                       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> -                                                 regUVD_VCPU_CNTL),
> -                                0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +
> +       /* setup regUVD_LMI_CTRL */
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL);
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL,
> +                        tmp | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +                                UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +                                UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +                                UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MAS=
K);
> +
> +       /* setup regUVD_MPC_CNTL */
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL);
> +       tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +       tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_CNTL, tmp);
> +
> +       /* setup UVD_MPC_SET_MUXA0 */
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXA0,
> +                        ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +                         (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +                         (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +                         (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +       /* setup UVD_MPC_SET_MUXB0 */
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUXB0,
> +                        ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +                         (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +                         (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +                         (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +       /* setup UVD_MPC_SET_MUX */
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_MPC_SET_MUX,
> +                        ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +                         (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +                         (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +       vcn_v4_0_3_mc_resume(adev, inst);
> +
> +       /* VCN global tiling registers */
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
> +                        adev->gfx.config.gb_addr_config);
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_GFX10_ADDR_CONFIG,
> +                        adev->gfx.config.gb_addr_config);
> +
> +       /* unblock VCPU register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL), 0,
> +                ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +       /* release VCPU reset to boot */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>
> +       for (j =3D 0; j < 10; ++j) {
> +               uint32_t status;
> +
> +               for (k =3D 0; k < 100; ++k) {
> +                       status =3D RREG32_SOC15(VCN, vcn_inst,
> +                                                 regUVD_STATUS);
> +                       if (status & 2)
> +                               break;
>                         mdelay(10);
> -                       r =3D -1;
>                 }
> +               r =3D 0;
> +               if (status & 2)
> +                       break;
>
> -               if (r) {
> -                       DRM_DEV_ERROR(adev->dev, "VCN decode not respondi=
ng, giving up!!!\n");
> -                       return r;
> -               }
> +               DRM_DEV_ERROR(adev->dev,
> +                       "VCN decode not responding, trying to reset the V=
CPU!!!\n");
> +               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> +                                         regUVD_VCPU_CNTL),
> +                        UVD_VCPU_CNTL__BLK_RST_MASK,
> +                        ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +               mdelay(10);
> +               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst,
> +                                         regUVD_VCPU_CNTL),
> +                        0, ~UVD_VCPU_CNTL__BLK_RST_MASK);
>
> -               /* enable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_E=
N),
> -                        UVD_MASTINT_EN__VCPU_EN_MASK,
> -                        ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +               mdelay(10);
> +               r =3D -1;
> +       }
>
> -               /* clear the busy bit of VCN_STATUS */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), =
0,
> -                        ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +       if (r) {
> +               DRM_DEV_ERROR(adev->dev, "VCN decode not responding, givi=
ng up!!!\n");
> +               return r;
> +       }
>
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> +       /* enable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_MASTINT_EN),
> +                UVD_MASTINT_EN__VCPU_EN_MASK,
> +                ~UVD_MASTINT_EN__VCPU_EN_MASK);
>
> -               /* program the RB_BASE for ring buffer */
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
> -                            lower_32_bits(ring->gpu_addr));
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
> -                            upper_32_bits(ring->gpu_addr));
> +       /* clear the busy bit of VCN_STATUS */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_STATUS), 0,
> +                ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
> -                            ring->ring_size / sizeof(uint32_t));
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
>
> -               /* resetting ring, fw should not check RB ring */
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -               tmp &=3D ~(VCN_RB_ENABLE__RB_EN_MASK);
> -               WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +       /* program the RB_BASE for ring buffer */
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_LO,
> +                        lower_32_bits(ring->gpu_addr));
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_BASE_HI,
> +                        upper_32_bits(ring->gpu_addr));
>
> -               /* Initialize the ring buffer's read and write pointers *=
/
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_SIZE,
> +                        ring->ring_size / sizeof(uint32_t));
>
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> -               tmp |=3D VCN_RB_ENABLE__RB_EN_MASK;
> -               WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +       /* resetting ring, fw should not check RB ring */
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +       tmp &=3D ~(VCN_RB_ENABLE__RB_EN_MASK);
> +       WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>
> -               ring->wptr =3D RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR=
);
> -               fw_shared->sq.queue_mode &=3D
> -                       cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_=
HOLD_OFF));
> +       /* Initialize the ring buffer's read and write pointers */
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_RPTR, 0);
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR, 0);
> +
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE);
> +       tmp |=3D VCN_RB_ENABLE__RB_EN_MASK;
> +       WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
> +
> +       ring->wptr =3D RREG32_SOC15(VCN, vcn_inst, regUVD_RB_WPTR);
> +       fw_shared->sq.queue_mode &=3D
> +               cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF=
));
>
> -       }
>         return 0;
>  }
>
> @@ -1295,83 +1289,79 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu=
_device *adev, int inst_idx)
>   *
>   * Stop VCN block
>   */
> -static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
> +static int vcn_v4_0_3_stop(struct amdgpu_device *adev, unsigned int inst=
)
>  {
>         volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -       int i, r =3D 0, vcn_inst;
> +       int r =3D 0, vcn_inst;
>         uint32_t tmp;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               vcn_inst =3D GET_INST(VCN, i);
> +       vcn_inst =3D GET_INST(VCN, inst);
>
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -               fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +       fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       vcn_v4_0_3_stop_dpg_mode(adev, i);
> -                       continue;
> -               }
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +               vcn_v4_0_3_stop_dpg_mode(adev, inst);
> +               goto Done;
> +       }
>
> -               /* wait for vcn idle */
> -               r =3D SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
> -                                      UVD_STATUS__IDLE, 0x7);
> -               if (r)
> -                       goto Done;
> -
> -               tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -                       UVD_LMI_STATUS__READ_CLEAN_MASK |
> -                       UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -                       UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -               r =3D SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS=
, tmp,
> -                                      tmp);
> -               if (r)
> -                       goto Done;
> -
> -               /* stall UMC channel */
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> -               tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> -               tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -                       UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -               r =3D SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS=
, tmp,
> -                                      tmp);
> -               if (r)
> -                       goto Done;
> +       /* wait for vcn idle */
> +       r =3D SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_STATUS,
> +                                  UVD_STATUS__IDLE, 0x7);
> +       if (r)
> +               goto Done;
> +
> +       tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +               UVD_LMI_STATUS__READ_CLEAN_MASK |
> +               UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +               UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> +                                  tmp);
> +       if (r)
> +               goto Done;
> +
> +       /* stall UMC channel */
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2);
> +       tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_LMI_CTRL2, tmp);
> +       tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +               UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, vcn_inst, regUVD_LMI_STATUS, tmp,
> +                                  tmp);
> +       if (r)
> +               goto Done;
>
> -               /* Unblock VCPU Register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CT=
RL),
> -                        UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -                        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +       /* Unblock VCPU Register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_RB_ARB_CTRL),
> +                UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +                ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>
> -               /* release VCPU reset to boot */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL=
),
> -                        UVD_VCPU_CNTL__BLK_RST_MASK,
> -                        ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +       /* release VCPU reset to boot */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> +                UVD_VCPU_CNTL__BLK_RST_MASK,
> +                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>
> -               /* disable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL=
), 0,
> -                        ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +       /* disable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL), 0,
> +                ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>
> -               /* reset LMI UMC/LMI/VCPU */
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +       /* reset LMI UMC/LMI/VCPU */
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
>
> -               tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_SOFT_RESET, tmp);
>
> -               /* clear VCN status */
> -               WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
> +       /* clear VCN status */
> +       WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>
> -               /* apply HW clock gating */
> -               vcn_v4_0_3_enable_clock_gating(adev, i);
> -       }
> +       /* apply HW clock gating */
> +       vcn_v4_0_3_enable_clock_gating(adev, inst);
>  Done:
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, false, i);
> -       }
> +       if (adev->pm.dpm_enabled)
> +               amdgpu_dpm_enable_vcn(adev, false, inst);
>
>         return 0;
>  }
> @@ -1644,9 +1634,9 @@ static int vcn_v4_0_3_set_powergating_state(struct =
amdgpu_ip_block *ip_block,
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> -               ret =3D vcn_v4_0_3_stop(adev);
> +               ret =3D vcn_v4_0_3_stop(adev, inst);
>         else
> -               ret =3D vcn_v4_0_3_start(adev);
> +               ret =3D vcn_v4_0_3_start(adev, inst);
>
>         if (!ret)
>                 adev->vcn.inst[inst].cur_state =3D state;
> --
> 2.34.1
>
