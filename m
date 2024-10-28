Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C107D3E2BB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84F1510E52E;
	Mon, 28 Oct 2024 19:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PeYY83C1";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC87310E52E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:25:24 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-71e5417f8d4so211467b3a.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143524; x=1730748324; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0kQJewV273xcqPE05zxeN/UZXlNaTG8usAxgVA+LIQ=;
 b=PeYY83C1vr9Ur1lZGY83aFhDNRJnwofvpq9TWpCGKKrJ6/H6QXEOE1BggGynXPUCxO
 okV93YuNRmKw6TkXZmLwrXPWmI57w7FTFCqTncEFCyU9Qql3119t8CVnNq82QUcH0z3B
 8bSm1Vtlnt08qNqYFkSeqbgOdINuz52/ow7GDSkAMghRJgw8DOPuNAc90SDs7hQYGFHt
 kyfbdspVMkxu+bu+0YFVML25sU5WYobmG6aZ2++HnWkvPpBy8iIujtAbp9EcRtABnIvd
 oiYeMJkHxPV1NCBXPnJNXMSqwl2bw9Res19P2iiOgC8i6QMDHZ4UuDgaucHcHWBHoncm
 qH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143524; x=1730748324;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q0kQJewV273xcqPE05zxeN/UZXlNaTG8usAxgVA+LIQ=;
 b=vQRIdLUkQIxz4+SM8eDlTCVy72RuSsU/g2muSeN0O32AlynS7db9qxLRQBEm61hs4M
 4sTUFOwLZt2WO/5fmQLPiRefvfFCWxq+TVcnB6/JXEtBFkbWrtiszGeVXp/LnMtbhOZG
 N7LdHkTixV9zXpgli0vnSw7bUbV45kVIvlNybqKoQhONSezTonmXJBICtBKXxGNWhkhw
 jCFQ8KT9CrL2Wd7rPUyGJSCAAr0KBVScqoofiSk/Qid4sN1RyGnT/8wK2vQ+muyvyMPd
 nAv1uEJGGQqd+uLsRfh89yFPNlmWDsaEKsE1aD5OdKupWEZwrSkIT2YXf3+sdVXYk23H
 DI5g==
X-Gm-Message-State: AOJu0YykJ0SvJQijXYPcShl6YLpS2enMUY9ah8eqEqVkHrawVAH65RuQ
 qQlSMAgfuqhDE9bI3H/oz6Q+GPgUGkV1rpKY90gvR0WnI1q+GcXRFFX7V06tfryYQS5NXC/KeiG
 MPlNfUGaJ0sYuVZY4ZftzMDtborTuCzmp
X-Google-Smtp-Source: AGHT+IFOKnSJtEVX4HTldnI7Po0z0mhWoTWshY0CUsdGxptelDC3CGSCeCxsFl8c4fexc0MTeRYoS/njdkwcI3r7/rA=
X-Received: by 2002:a05:6a00:3a22:b0:71e:5400:1b35 with SMTP id
 d2e1a72fcca58-72063057611mr5673117b3a.5.1730143523539; Mon, 28 Oct 2024
 12:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-14-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-14-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:25:12 -0400
Message-ID: <CADnq5_MGRWy+Gc7WL0QvvRd_11zf=9sMaFKGSoaXqXR1F8+BjQ@mail.gmail.com>
Subject: Re: [PATCH 13/29] drm/amdgpu: power vcn 3_0 by instance
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

On Thu, Oct 24, 2024 at 11:23=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> For vcn 3_0, add ip_block for each vcn instance during discovery stage.
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         | 583 +++++++++---------
>  2 files changed, 289 insertions(+), 297 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 6bdd4055c192..2a606e8c6930 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2336,7 +2336,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
>                 case IP_VERSION(3, 1, 1):
>                 case IP_VERSION(3, 1, 2):
>                 case IP_VERSION(3, 0, 2):
> -                       amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_blo=
ck);
> +                       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> +                               amdgpu_device_ip_block_add(adev, &vcn_v3_=
0_ip_block);
>                         if (!amdgpu_sriov_vf(adev))
>                                 amdgpu_device_ip_block_add(adev, &jpeg_v3=
_0_ip_block);
>                         break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 3b38b67f6da2..690224a5e783 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -160,7 +160,7 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_block=
 *ip_block)
>  static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_ring *ring;
> -       int i, j, r;
> +       int inst =3D ip_block->instance, j, r;
>         int vcn_doorbell_index =3D 0;
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_3_0);
>         uint32_t *ptr;
> @@ -189,93 +189,91 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>                 vcn_doorbell_index =3D vcn_doorbell_index << 1;
>         }
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               volatile struct amdgpu_fw_shared *fw_shared;
> +       volatile struct amdgpu_fw_shared *fw_shared;
>
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               goto done;
> +
> +       adev->vcn.internal.context_id =3D mmUVD_CONTEXT_ID_INTERNAL_OFFSE=
T;
> +       adev->vcn.internal.ib_vmid =3D mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFF=
SET;
> +       adev->vcn.internal.ib_bar_low =3D mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_=
INTERNAL_OFFSET;
> +       adev->vcn.internal.ib_bar_high =3D mmUVD_LMI_RBC_IB_64BIT_BAR_HIG=
H_INTERNAL_OFFSET;
> +       adev->vcn.internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> +       adev->vcn.internal.gp_scratch8 =3D mmUVD_GP_SCRATCH8_INTERNAL_OFF=
SET;
> +
> +       adev->vcn.internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_OFFSET;
> +       adev->vcn.inst[inst].external.scratch9 =3D SOC15_REG_OFFSET(VCN, =
inst, mmUVD_SCRATCH9);
> +       adev->vcn.internal.data0 =3D mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFS=
ET;
> +       adev->vcn.inst[inst].external.data0 =3D SOC15_REG_OFFSET(VCN, ins=
t, mmUVD_GPCOM_VCPU_DATA0);
> +       adev->vcn.internal.data1 =3D mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFS=
ET;
> +       adev->vcn.inst[inst].external.data1 =3D SOC15_REG_OFFSET(VCN, ins=
t, mmUVD_GPCOM_VCPU_DATA1);
> +       adev->vcn.internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> +       adev->vcn.inst[inst].external.cmd =3D SOC15_REG_OFFSET(VCN, inst,=
 mmUVD_GPCOM_VCPU_CMD);
> +       adev->vcn.internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> +       adev->vcn.inst[inst].external.nop =3D SOC15_REG_OFFSET(VCN, inst,=
 mmUVD_NO_OP);
> +
> +       /* VCN DEC TRAP */
> +       r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +                       VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT, &ad=
ev->vcn.inst[inst].irq);
> +       if (r)
> +               return r;
> +
> +       atomic_set(&adev->vcn.inst[inst].sched_score, 0);
>
> -               adev->vcn.internal.context_id =3D mmUVD_CONTEXT_ID_INTERN=
AL_OFFSET;
> -               adev->vcn.internal.ib_vmid =3D mmUVD_LMI_RBC_IB_VMID_INTE=
RNAL_OFFSET;
> -               adev->vcn.internal.ib_bar_low =3D mmUVD_LMI_RBC_IB_64BIT_=
BAR_LOW_INTERNAL_OFFSET;
> -               adev->vcn.internal.ib_bar_high =3D mmUVD_LMI_RBC_IB_64BIT=
_BAR_HIGH_INTERNAL_OFFSET;
> -               adev->vcn.internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL=
_OFFSET;
> -               adev->vcn.internal.gp_scratch8 =3D mmUVD_GP_SCRATCH8_INTE=
RNAL_OFFSET;
> -
> -               adev->vcn.internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_O=
FFSET;
> -               adev->vcn.inst[i].external.scratch9 =3D SOC15_REG_OFFSET(=
VCN, i, mmUVD_SCRATCH9);
> -               adev->vcn.internal.data0 =3D mmUVD_GPCOM_VCPU_DATA0_INTER=
NAL_OFFSET;
> -               adev->vcn.inst[i].external.data0 =3D SOC15_REG_OFFSET(VCN=
, i, mmUVD_GPCOM_VCPU_DATA0);
> -               adev->vcn.internal.data1 =3D mmUVD_GPCOM_VCPU_DATA1_INTER=
NAL_OFFSET;
> -               adev->vcn.inst[i].external.data1 =3D SOC15_REG_OFFSET(VCN=
, i, mmUVD_GPCOM_VCPU_DATA1);
> -               adev->vcn.internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_=
OFFSET;
> -               adev->vcn.inst[i].external.cmd =3D SOC15_REG_OFFSET(VCN, =
i, mmUVD_GPCOM_VCPU_CMD);
> -               adev->vcn.internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> -               adev->vcn.inst[i].external.nop =3D SOC15_REG_OFFSET(VCN, =
i, mmUVD_NO_OP);
> -
> -               /* VCN DEC TRAP */
> -               r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> -                               VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERR=
UPT, &adev->vcn.inst[i].irq);
> +       ring =3D &adev->vcn.inst[inst].ring_dec;
> +       ring->use_doorbell =3D true;
> +       if (amdgpu_sriov_vf(adev)) {
> +               ring->doorbell_index =3D vcn_doorbell_index + inst * (ade=
v->vcn.num_enc_rings + 1);
> +       } else {
> +               ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ri=
ng0_1 << 1) + 8 * inst;
> +       }
> +       ring->vm_hub =3D AMDGPU_MMHUB0(0);
> +       sprintf(ring->name, "vcn_dec_%d", inst);
> +       r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq=
, 0,
> +                                AMDGPU_RING_PRIO_DEFAULT,
> +                                &adev->vcn.inst[inst].sched_score);
> +       if (r)
> +               return r;
> +
> +       for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> +               enum amdgpu_ring_priority_level hw_prio =3D amdgpu_vcn_ge=
t_enc_ring_prio(j);
> +
> +               /* VCN ENC TRAP */
> +               r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[ins=
t],
> +                       j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &ade=
v->vcn.inst[inst].irq);
>                 if (r)
>                         return r;
>
> -               atomic_set(&adev->vcn.inst[i].sched_score, 0);
> -
> -               ring =3D &adev->vcn.inst[i].ring_dec;
> +               ring =3D &adev->vcn.inst[inst].ring_enc[j];
>                 ring->use_doorbell =3D true;
>                 if (amdgpu_sriov_vf(adev)) {
> -                       ring->doorbell_index =3D vcn_doorbell_index + i *=
 (adev->vcn.num_enc_rings + 1);
> +                       ring->doorbell_index =3D vcn_doorbell_index + ins=
t * (adev->vcn.num_enc_rings + 1) + 1 + j;
>                 } else {
> -                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + 8 * i;
> +                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + 2 + j + 8 * inst;
>                 }
>                 ring->vm_hub =3D AMDGPU_MMHUB0(0);
> -               sprintf(ring->name, "vcn_dec_%d", i);
> -               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i=
].irq, 0,
> -                                    AMDGPU_RING_PRIO_DEFAULT,
> -                                    &adev->vcn.inst[i].sched_score);
> +               sprintf(ring->name, "vcn_enc_%d.%d", inst, j);
> +               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i=
nst].irq, 0,
> +                                        hw_prio, &adev->vcn.inst[inst].s=
ched_score);
>                 if (r)
>                         return r;
> -
> -               for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> -                       enum amdgpu_ring_priority_level hw_prio =3D amdgp=
u_vcn_get_enc_ring_prio(j);
> -
> -                       /* VCN ENC TRAP */
> -                       r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_=
vcns[i],
> -                               j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPO=
SE, &adev->vcn.inst[i].irq);
> -                       if (r)
> -                               return r;
> -
> -                       ring =3D &adev->vcn.inst[i].ring_enc[j];
> -                       ring->use_doorbell =3D true;
> -                       if (amdgpu_sriov_vf(adev)) {
> -                               ring->doorbell_index =3D vcn_doorbell_ind=
ex + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
> -                       } else {
> -                               ring->doorbell_index =3D (adev->doorbell_=
index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
> -                       }
> -                       ring->vm_hub =3D AMDGPU_MMHUB0(0);
> -                       sprintf(ring->name, "vcn_enc_%d.%d", i, j);
> -                       r =3D amdgpu_ring_init(adev, ring, 512, &adev->vc=
n.inst[i].irq, 0,
> -                                            hw_prio, &adev->vcn.inst[i].=
sched_score);
> -                       if (r)
> -                               return r;
> -               }
> -
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -               fw_shared->present_flag_0 |=3D cpu_to_le32(AMDGPU_VCN_SW_=
RING_FLAG) |
> -                                            cpu_to_le32(AMDGPU_VCN_MULTI=
_QUEUE_FLAG) |
> -                                            cpu_to_le32(AMDGPU_VCN_FW_SH=
ARED_FLAG_0_RB);
> -               fw_shared->sw_ring.is_enabled =3D cpu_to_le32(DEC_SW_RING=
_ENABLED);
> -               fw_shared->present_flag_0 |=3D AMDGPU_VCN_SMU_VERSION_INF=
O_FLAG;
> -               if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSIO=
N(3, 1, 2))
> -                       fw_shared->smu_interface_info.smu_interface_type =
=3D 2;
> -               else if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> -                        IP_VERSION(3, 1, 1))
> -                       fw_shared->smu_interface_info.smu_interface_type =
=3D 1;
> -
> -               if (amdgpu_vcnfw_log)
> -                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>         }
>
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +       fw_shared->present_flag_0 |=3D cpu_to_le32(AMDGPU_VCN_SW_RING_FLA=
G) |
> +                                        cpu_to_le32(AMDGPU_VCN_MULTI_QUE=
UE_FLAG) |
> +                                        cpu_to_le32(AMDGPU_VCN_FW_SHARED=
_FLAG_0_RB);
> +       fw_shared->sw_ring.is_enabled =3D cpu_to_le32(DEC_SW_RING_ENABLED=
);
> +       fw_shared->present_flag_0 |=3D AMDGPU_VCN_SMU_VERSION_INFO_FLAG;
> +       if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(3, 1, =
2))
> +               fw_shared->smu_interface_info.smu_interface_type =3D 2;
> +       else if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> +                IP_VERSION(3, 1, 1))
> +               fw_shared->smu_interface_info.smu_interface_type =3D 1;
> +
> +       if (amdgpu_vcnfw_log)
> +               amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst]);
> +done:
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D amdgpu_virt_alloc_mm_table(adev);
>                 if (r)
> @@ -1132,192 +1130,188 @@ static int vcn_v3_0_start_dpg_mode(struct amdgp=
u_device *adev, int inst_idx, boo
>         return 0;
>  }
>
> -static int vcn_v3_0_start(struct amdgpu_device *adev)
> +static int vcn_v3_0_start(struct amdgpu_device *adev, unsigned int inst)
>  {
>         volatile struct amdgpu_fw_shared *fw_shared;
>         struct amdgpu_ring *ring;
>         uint32_t rb_bufsz, tmp;
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
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +               r =3D vcn_v3_0_start_dpg_mode(adev, inst, adev->vcn.indir=
ect_sram);
> +               return r;
>         }
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       /* disable VCN power gating */
> +       vcn_v3_0_disable_static_power_gating(adev, inst);
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       r =3D vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.=
indirect_sram);
> -                       continue;
> -               }
> +       /* set VCN status busy */
> +       tmp =3D RREG32_SOC15(VCN, inst, mmUVD_STATUS) | UVD_STATUS__UVD_B=
USY;
> +       WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
>
> -               /* disable VCN power gating */
> -               vcn_v3_0_disable_static_power_gating(adev, i);
> -
> -               /* set VCN status busy */
> -               tmp =3D RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__=
UVD_BUSY;
> -               WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
> -
> -               /*SW clock gating */
> -               vcn_v3_0_disable_clock_gating(adev, i);
> -
> -               /* enable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -                       UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_E=
N_MASK);
> -
> -               /* disable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
> -                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -               /* enable LMI MC and UMC channels */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
> -                       ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -               tmp =3D RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> -
> -               /* setup mmUVD_LMI_CTRL */
> -               tmp =3D RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
> -               WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp |
> -                       UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -                       UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -                       UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -                       UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -               /* setup mmUVD_MPC_CNTL */
> -               tmp =3D RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
> -               tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -               tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -               WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
> -
> -               /* setup UVD_MPC_SET_MUXA0 */
> -               WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
> -                       ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> -                       (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> -                       (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> -                       (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> -
> -               /* setup UVD_MPC_SET_MUXB0 */
> -               WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
> -                       ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> -                       (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> -                       (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> -                       (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> -
> -               /* setup mmUVD_MPC_SET_MUX */
> -               WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
> -                       ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -                       (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -                       (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> -
> -               vcn_v3_0_mc_resume(adev, i);
> -
> -               /* VCN global tiling registers */
> -               WREG32_SOC15(VCN, i, mmUVD_GFX10_ADDR_CONFIG,
> -                       adev->gfx.config.gb_addr_config);
> -
> -               /* unblock VCPU register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
> -                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -               /* release VCPU reset to boot */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +       /*SW clock gating */
> +       vcn_v3_0_disable_clock_gating(adev, inst);
>
> -               for (j =3D 0; j < 10; ++j) {
> -                       uint32_t status;
> +       /* enable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> +               UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>
> -                       for (k =3D 0; k < 100; ++k) {
> -                               status =3D RREG32_SOC15(VCN, i, mmUVD_STA=
TUS);
> -                               if (status & 2)
> -                                       break;
> -                               mdelay(10);
> -                       }
> -                       r =3D 0;
> -                       if (status & 2)
> -                               break;
> +       /* disable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
> +               ~UVD_MASTINT_EN__VCPU_EN_MASK);
>
> -                       DRM_ERROR("VCN[%d] decode not responding, trying =
to reset the VCPU!!!\n", i);
> -                       WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL=
),
> -                               UVD_VCPU_CNTL__BLK_RST_MASK,
> -                               ~UVD_VCPU_CNTL__BLK_RST_MASK);
> -                       mdelay(10);
> -                       WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL=
), 0,
> -                               ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +       /* enable LMI MC and UMC channels */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
> +               ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +       tmp =3D RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
> +
> +       /* setup mmUVD_LMI_CTRL */
> +       tmp =3D RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp |
> +               UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +               UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +               UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +               UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +       /* setup mmUVD_MPC_CNTL */
> +       tmp =3D RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
> +       tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +       tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
> +
> +       /* setup UVD_MPC_SET_MUXA0 */
> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
> +               ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +               (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +               (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +               (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +       /* setup UVD_MPC_SET_MUXB0 */
> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
> +               ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +               (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +               (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +               (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +       /* setup mmUVD_MPC_SET_MUX */
> +       WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
> +               ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +               (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +               (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +       vcn_v3_0_mc_resume(adev, inst);
> +
> +       /* VCN global tiling registers */
> +       WREG32_SOC15(VCN, inst, mmUVD_GFX10_ADDR_CONFIG,
> +               adev->gfx.config.gb_addr_config);
> +
> +       /* unblock VCPU register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
> +               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +       /* release VCPU reset to boot */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> +               ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +       for (j =3D 0; j < 10; ++j) {
> +               uint32_t status;
>
> +               for (k =3D 0; k < 100; ++k) {
> +                       status =3D RREG32_SOC15(VCN, inst, mmUVD_STATUS);
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
> -                       DRM_ERROR("VCN[%d] decode not responding, giving =
up!!!\n", i);
> -                       return r;
> -               }
> +               DRM_ERROR("VCN[%d] decode not responding, trying to reset=
 the VCPU!!!\n", inst);
> +               WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> +                       UVD_VCPU_CNTL__BLK_RST_MASK,
> +                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +               mdelay(10);
> +               WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> +                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
>
> -               /* enable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
> -                       UVD_MASTINT_EN__VCPU_EN_MASK,
> -                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +               mdelay(10);
> +               r =3D -1;
> +       }
>
> -               /* clear the busy bit of VCN_STATUS */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
> -                       ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +       if (r) {
> +               DRM_ERROR("VCN[%d] decode not responding, giving up!!!\n"=
, inst);
> +               return r;
> +       }
>
> -               WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
> +       /* enable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
> +               UVD_MASTINT_EN__VCPU_EN_MASK,
> +               ~UVD_MASTINT_EN__VCPU_EN_MASK);
>
> -               ring =3D &adev->vcn.inst[i].ring_dec;
> -               /* force RBC into idle state */
> -               rb_bufsz =3D order_base_2(ring->ring_size);
> -               tmp =3D REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bu=
fsz);
> -               tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> -               tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, =
1);
> -               tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE,=
 1);
> -               tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN=
, 1);
> -               WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
> +       /* clear the busy bit of VCN_STATUS */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
> +               ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -               fw_shared->multi_queue.decode_queue_mode |=3D cpu_to_le32=
(FW_QUEUE_RING_RESET);
> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>
> -               /* programm the RB_BASE for ring buffer */
> -               WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> -                       lower_32_bits(ring->gpu_addr));
> -               WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> -                       upper_32_bits(ring->gpu_addr));
> +       ring =3D &adev->vcn.inst[inst].ring_dec;
> +       /* force RBC into idle state */
> +       rb_bufsz =3D order_base_2(ring->ring_size);
> +       tmp =3D REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
> +       tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
> +       tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
> +       tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
> +       tmp =3D REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
> +       WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>
> -               /* Initialize the ring buffer's read and write pointers *=
/
> -               WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
> +       fw_shared =3D adev->vcn.inst[inst].fw_shared.cpu_addr;
> +       fw_shared->multi_queue.decode_queue_mode |=3D cpu_to_le32(FW_QUEU=
E_RING_RESET);
>
> -               WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
> -               ring->wptr =3D RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
> -               WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
> -                       lower_32_bits(ring->wptr));
> -               fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
> -               fw_shared->multi_queue.decode_queue_mode &=3D cpu_to_le32=
(~FW_QUEUE_RING_RESET);
> -
> -               if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=3D
> -                   IP_VERSION(3, 0, 33)) {
> -                       fw_shared->multi_queue.encode_generalpurpose_queu=
e_mode |=3D cpu_to_le32(FW_QUEUE_RING_RESET);
> -                       ring =3D &adev->vcn.inst[i].ring_enc[0];
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits=
(ring->wptr));
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits=
(ring->wptr));
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_=
addr);
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_b=
its(ring->gpu_addr));
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_si=
ze / 4);
> -                       fw_shared->multi_queue.encode_generalpurpose_queu=
e_mode &=3D cpu_to_le32(~FW_QUEUE_RING_RESET);
> -
> -                       fw_shared->multi_queue.encode_lowlatency_queue_mo=
de |=3D cpu_to_le32(FW_QUEUE_RING_RESET);
> -                       ring =3D &adev->vcn.inst[i].ring_enc[1];
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bit=
s(ring->wptr));
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bit=
s(ring->wptr));
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu=
_addr);
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_=
bits(ring->gpu_addr));
> -                       WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_s=
ize / 4);
> -                       fw_shared->multi_queue.encode_lowlatency_queue_mo=
de &=3D cpu_to_le32(~FW_QUEUE_RING_RESET);
> -               }
> +       /* programm the RB_BASE for ring buffer */
> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
> +               lower_32_bits(ring->gpu_addr));
> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
> +               upper_32_bits(ring->gpu_addr));
> +
> +       /* Initialize the ring buffer's read and write pointers */
> +       WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
> +
> +       WREG32_SOC15(VCN, inst, mmUVD_SCRATCH2, 0);
> +       ring->wptr =3D RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
> +       WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
> +               lower_32_bits(ring->wptr));
> +       fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
> +       fw_shared->multi_queue.decode_queue_mode &=3D cpu_to_le32(~FW_QUE=
UE_RING_RESET);
> +
> +       if (amdgpu_ip_version(adev, UVD_HWIP, 0) !=3D
> +               IP_VERSION(3, 0, 33)) {
> +               fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
=3D cpu_to_le32(FW_QUEUE_RING_RESET);
> +               ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR, lower_32_bits(ring=
->wptr));
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR, lower_32_bits(ring=
->wptr));
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr)=
;
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI, upper_32_bits(r=
ing->gpu_addr));
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / =
4);
> +               fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
=3D cpu_to_le32(~FW_QUEUE_RING_RESET);
> +
> +               fw_shared->multi_queue.encode_lowlatency_queue_mode |=3D =
cpu_to_le32(FW_QUEUE_RING_RESET);
> +               ring =3D &adev->vcn.inst[inst].ring_enc[1];
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2, lower_32_bits(rin=
g->wptr));
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2, lower_32_bits(rin=
g->wptr));
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr=
);
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2, upper_32_bits(=
ring->gpu_addr));
> +               WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size /=
 4);
> +               fw_shared->multi_queue.encode_lowlatency_queue_mode &=3D =
cpu_to_le32(~FW_QUEUE_RING_RESET);
>         }
>
>         return 0;
> @@ -1563,79 +1557,76 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_d=
evice *adev, int inst_idx)
>         return 0;
>  }
>
> -static int vcn_v3_0_stop(struct amdgpu_device *adev)
> +static int vcn_v3_0_stop(struct amdgpu_device *adev, unsigned int inst)
>  {
>         uint32_t tmp;
> -       int i, r =3D 0;
> +       int r =3D 0;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               goto done;
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       r =3D vcn_v3_0_stop_dpg_mode(adev, i);
> -                       continue;
> -               }
> +       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +               r =3D vcn_v3_0_stop_dpg_mode(adev, inst);
> +               goto done;
> +       }
>
> -               /* wait for vcn idle */
> -               r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS=
__IDLE, 0x7);
> -               if (r)
> -                       return r;
> +       /* wait for vcn idle */
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS, UVD_STATUS__IDL=
E, 0x7);
> +       if (r)
> +               return r;
>
> -               tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -                       UVD_LMI_STATUS__READ_CLEAN_MASK |
> -                       UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -                       UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -               r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, t=
mp);
> -               if (r)
> -                       return r;
> +       tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +               UVD_LMI_STATUS__READ_CLEAN_MASK |
> +               UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +               UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> +       if (r)
> +               return r;
>
> -               /* disable LMI UMC channel */
> -               tmp =3D RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
> -               tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -               WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
> -               tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> -                       UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -               r =3D SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp, t=
mp);
> -               if (r)
> -                       return r;
> +       /* disable LMI UMC channel */
> +       tmp =3D RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
> +       tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +       WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
> +       tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
> +               UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp, tmp);
> +       if (r)
> +               return r;
>
> -               /* block VCPU register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
> -                       UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +       /* block VCPU register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
> +               UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>
> -               /* reset VCPU */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
> -                       UVD_VCPU_CNTL__BLK_RST_MASK,
> -                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +       /* reset VCPU */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
> +               UVD_VCPU_CNTL__BLK_RST_MASK,
> +               ~UVD_VCPU_CNTL__BLK_RST_MASK);
>
> -               /* disable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
> -                       ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +       /* disable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
> +               ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>
> -               /* apply soft reset */
> -               tmp =3D RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> -               tmp =3D RREG32_SOC15(VCN, i, mmUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, mmUVD_SOFT_RESET, tmp);
> +       /* apply soft reset */
> +       tmp =3D RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, mmUVD_SOFT_RESET, tmp);
>
> -               /* clear status */
> -               WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
> +       /* clear status */
> +       WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>
> -               /* apply HW clock gating */
> -               vcn_v3_0_enable_clock_gating(adev, i);
> +       /* apply HW clock gating */
> +       vcn_v3_0_enable_clock_gating(adev, inst);
>
> -               /* enable VCN power gating */
> -               vcn_v3_0_enable_static_power_gating(adev, i);
> -       }
> +       /* enable VCN power gating */
> +       vcn_v3_0_enable_static_power_gating(adev, inst);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, false, i);
> -       }
> +done:
> +       if (adev->pm.dpm_enabled)
> +               amdgpu_dpm_enable_vcn(adev, false, inst);
>
>         return 0;
>  }
> @@ -2177,9 +2168,9 @@ static int vcn_v3_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> -               ret =3D vcn_v3_0_stop(adev);
> +               ret =3D vcn_v3_0_stop(adev, inst);
>         else
> -               ret =3D vcn_v3_0_start(adev);
> +               ret =3D vcn_v3_0_start(adev, inst);
>
>         if (!ret)
>                 adev->vcn.inst[inst].cur_state =3D state;
> --
> 2.34.1
>
