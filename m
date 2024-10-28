Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E930D3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:25:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7CAD10E52F;
	Mon, 28 Oct 2024 19:25:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cq/y0UeS";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E8510E52F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:25:57 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-71e49d5deeeso172747b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143557; x=1730748357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmzXbttVcGeeNWoYCQwcXxjutgpfJCW79AZAJjGnoXE=;
 b=Cq/y0UeSOKmtTx6VEiMMyo6ltbQo2FHFN7MkVwaAwiPTB0z9AueODHN9m7uO/UHpj8
 MMTZeYZjHWjMkTF2wkStwjGMGm2kI9t9rmFy5UEASylCX4tvP6+YISXYX5vlGAuhyurT
 z9UEf1QqsLoCCR+k2AN0+otMYc8VLgBjtk5jhRvbcdDgh8QCKSPopdy8mKQr5xQwszIs
 UGnqrI+/cUlUDRRw/CAI+uXx0e+BC9N8xlMym6rxnvuZtrdhrKVFEESVFTwum4quhfFX
 67gPERFtLRDX+h64/h0KD05NmfAb/PJh+i2Bcd1sfuJP2Evbv7v3aRQyCcRCfOBD5Xll
 PW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143557; x=1730748357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmzXbttVcGeeNWoYCQwcXxjutgpfJCW79AZAJjGnoXE=;
 b=X4o28CCyhnHg9kYJ28vWf+XYtTseg0X/X/39n6YyP/nVbLKCbAi3fc2bIxvginQVV4
 nUlECXiMVendvqi433hP2T98IRi3ik+GOSC6xLExQBpDvKNjWsDp5D/NeoZkViy33Lyl
 XMbbC5NXYh+Nc77SEHIJzl/aQzjwj049jMpUj1/Ezjz7tuONbk6iv/KBE8zfRG2NPpUx
 CQdB0emCNy+Jrghx9e9eQl9fiag9Tgs7Shkl/k2WMusrq6ReRJTlmWbCjdNeky7t7tlu
 vszcpEZyZg0WFO94PoHb+5FpAiiTOtUcRehrRkKKWoApjc4YuzP+UPDtYZJDZgP/5yoY
 wOeQ==
X-Gm-Message-State: AOJu0Yzh8KMG7tOutWTOVo8S31eY0bSi5f9bnMGbTp3L9g7RmsZGPAsa
 qlk6ioSD12mFzQixQBj+gxHtsek4gWxSTcwu0QseF40MHQ4jYziYnN3V/WdASgu17/l9tZDxIkk
 qDJEzW80o/O0Puxk2LY8StxrvXJBASg73
X-Google-Smtp-Source: AGHT+IGQzm3ZaEUsGc15RcFdHVWkKzfVnpZ7/gV5Yto2JhByK96wSxoZUQ+9MJjGRhuGUHys1wYZTN9pCGsQT0LewrQ=
X-Received: by 2002:a05:6a00:9a4:b0:71e:594c:a812 with SMTP id
 d2e1a72fcca58-72062a74ec2mr5710851b3a.0.1730143556809; Mon, 28 Oct 2024
 12:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-15-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-15-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:25:45 -0400
Message-ID: <CADnq5_P-wJFv4PU14RfWTGRH4fSvLW7ezsg-fZReqAu7X01QhQ@mail.gmail.com>
Subject: Re: [PATCH 14/29] drm/amdgpu: power vcn 4_0 by instance
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
> For vcn 4_0, add ip_block for each vcn instance during discovery stage.
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
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         | 495 +++++++++---------
>  2 files changed, 245 insertions(+), 253 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 2a606e8c6930..aaa759765dba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2347,7 +2347,8 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
>                 case IP_VERSION(4, 0, 0):
>                 case IP_VERSION(4, 0, 2):
>                 case IP_VERSION(4, 0, 4):
> -                       amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_blo=
ck);
> +                       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> +                               amdgpu_device_ip_block_add(adev, &vcn_v4_=
0_ip_block);
>                         amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_bl=
ock);
>                         break;
>                 case IP_VERSION(4, 0, 3):
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 87c8f1c084a5..0cc0eb52b54f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -172,7 +172,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block *i=
p_block)
>  {
>         struct amdgpu_ring *ring;
>         struct amdgpu_device *adev =3D ip_block->adev;
> -       int i, r;
> +       int inst =3D ip_block->instance, r;
> +
>         uint32_t reg_count =3D ARRAY_SIZE(vcn_reg_list_4_0);
>         uint32_t *ptr;
>
> @@ -186,45 +187,43 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>         if (r)
>                 return r;
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               goto done;
>
> -               /* Init instance 0 sched_score to 1, so it's scheduled af=
ter other instances */
> -               if (i =3D=3D 0)
> -                       atomic_set(&adev->vcn.inst[i].sched_score, 1);
> -               else
> -                       atomic_set(&adev->vcn.inst[i].sched_score, 0);
> +       /* Init instance 0 sched_score to 1, so it's scheduled after othe=
r instances */
> +       if (inst =3D=3D 0)
> +               atomic_set(&adev->vcn.inst[inst].sched_score, 1);
> +       else
> +               atomic_set(&adev->vcn.inst[inst].sched_score, 0);
>
> -               /* VCN UNIFIED TRAP */
> -               r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> -                               VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, =
&adev->vcn.inst[i].irq);
> -               if (r)
> -                       return r;
> +       /* VCN UNIFIED TRAP */
> +       r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +                       VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->v=
cn.inst[inst].irq);
> +       if (r)
> +               return r;
>
> -               /* VCN POISON TRAP */
> -               r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
> -                               VCN_4_0__SRCID_UVD_POISON, &adev->vcn.ins=
t[i].ras_poison_irq);
> -               if (r)
> -                       return r;
> +       /* VCN POISON TRAP */
> +       r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
> +                       VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[inst].=
ras_poison_irq);
> +       if (r)
> +               return r;
>
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> -               ring->use_doorbell =3D true;
> -               if (amdgpu_sriov_vf(adev))
> -                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
> -               else
> -                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + 2 + 8 * i;
> -               ring->vm_hub =3D AMDGPU_MMHUB0(0);
> -               sprintf(ring->name, "vcn_unified_%d", i);
> -
> -               r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i=
].irq, 0,
> -                                               AMDGPU_RING_PRIO_0, &adev=
->vcn.inst[i].sched_score);
> -               if (r)
> -                       return r;
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +       ring->use_doorbell =3D true;
> +       if (amdgpu_sriov_vf(adev))
> +               ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ri=
ng0_1 << 1) + inst * (adev->vcn.num_enc_rings + 1) + 1;
> +       else
> +               ring->doorbell_index =3D (adev->doorbell_index.vcn.vcn_ri=
ng0_1 << 1) + 2 + 8 * inst;
> +       ring->vm_hub =3D AMDGPU_MMHUB0(0);
> +       sprintf(ring->name, "vcn_unified_%d", inst);
>
> -               vcn_v4_0_fw_shared_init(adev, i);
> -       }
> +       r =3D amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq=
, 0,
> +                                       AMDGPU_RING_PRIO_0, &adev->vcn.in=
st[inst].sched_score);
> +       if (r)
> +               return r;
>
> +       vcn_v4_0_fw_shared_init(adev, inst);
> +done:
>         if (amdgpu_sriov_vf(adev)) {
>                 r =3D amdgpu_virt_alloc_mm_table(adev);
>                 if (r)
> @@ -1081,180 +1080,176 @@ static int vcn_v4_0_start_dpg_mode(struct amdgp=
u_device *adev, int inst_idx, boo
>   *
>   * Start VCN block
>   */
> -static int vcn_v4_0_start(struct amdgpu_device *adev)
> +static int vcn_v4_0_start(struct amdgpu_device *adev, unsigned int inst)
>  {
>         volatile struct amdgpu_vcn4_fw_shared *fw_shared;
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
> +               r =3D vcn_v4_0_start_dpg_mode(adev, inst, adev->vcn.indir=
ect_sram);
> +               return r;
>         }
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       /* disable VCN power gating */
> +       vcn_v4_0_disable_static_power_gating(adev, inst);
>
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> +       /* set VCN status busy */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_STATUS) | UVD_STATUS__UVD_=
BUSY;
> +       WREG32_SOC15(VCN, inst, regUVD_STATUS, tmp);
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       r =3D vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.=
indirect_sram);
> -                       continue;
> +       /*SW clock gating */
> +       vcn_v4_0_disable_clock_gating(adev, inst);
> +
> +       /* enable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> +                       UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_E=
N_MASK);
> +
> +       /* disable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN), 0,
> +                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +       /* enable LMI MC and UMC channels */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_LMI_CTRL2), 0,
> +                       ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +
> +       /* setup regUVD_LMI_CTRL */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL);
> +       WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL, tmp |
> +                       UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +                       UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +                       UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +                       UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +       /* setup regUVD_MPC_CNTL */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_MPC_CNTL);
> +       tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> +       tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> +       WREG32_SOC15(VCN, inst, regUVD_MPC_CNTL, tmp);
> +
> +       /* setup UVD_MPC_SET_MUXA0 */
> +       WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXA0,
> +                       ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
> +                        (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
> +                        (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
> +                        (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
> +
> +       /* setup UVD_MPC_SET_MUXB0 */
> +       WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUXB0,
> +                       ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
> +                        (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
> +                        (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
> +                        (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
> +
> +       /* setup UVD_MPC_SET_MUX */
> +       WREG32_SOC15(VCN, inst, regUVD_MPC_SET_MUX,
> +                       ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> +                        (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> +                        (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
> +
> +       vcn_v4_0_mc_resume(adev, inst);
> +
> +       /* VCN global tiling registers */
> +       WREG32_SOC15(VCN, inst, regUVD_GFX10_ADDR_CONFIG,
> +                       adev->gfx.config.gb_addr_config);
> +
> +       /* unblock VCPU register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL), 0,
> +                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +       /* release VCPU reset to boot */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> +                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
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
>                 }
>
> -               /* disable VCN power gating */
> -               vcn_v4_0_disable_static_power_gating(adev, i);
> -
> -               /* set VCN status busy */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS_=
_UVD_BUSY;
> -               WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> -
> -               /*SW clock gating */
> -               vcn_v4_0_disable_clock_gating(adev, i);
> -
> -               /* enable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -                               UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNT=
L__CLK_EN_MASK);
> -
> -               /* disable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> -                               ~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -               /* enable LMI MC and UMC channels */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> -                               ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               tmp &=3D ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -
> -               /* setup regUVD_LMI_CTRL */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> -               WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> -                               UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -                               UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -                               UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -                               UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK=
);
> -
> -               /* setup regUVD_MPC_CNTL */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_MPC_CNTL);
> -               tmp &=3D ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
> -               tmp |=3D 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
> -               WREG32_SOC15(VCN, i, regUVD_MPC_CNTL, tmp);
> -
> -               /* setup UVD_MPC_SET_MUXA0 */
> -               WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXA0,
> -                               ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT=
) |
> -                                (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT=
) |
> -                                (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT=
) |
> -                                (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT=
)));
> -
> -               /* setup UVD_MPC_SET_MUXB0 */
> -               WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUXB0,
> -                               ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT=
) |
> -                                (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT=
) |
> -                                (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT=
) |
> -                                (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT=
)));
> -
> -               /* setup UVD_MPC_SET_MUX */
> -               WREG32_SOC15(VCN, i, regUVD_MPC_SET_MUX,
> -                               ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
> -                                (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
> -                                (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)))=
;
> -
> -               vcn_v4_0_mc_resume(adev, i);
> -
> -               /* VCN global tiling registers */
> -               WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> -                               adev->gfx.config.gb_addr_config);
> -
> -               /* unblock VCPU register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> -                               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -               /* release VCPU reset to boot */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -                               ~UVD_VCPU_CNTL__BLK_RST_MASK);
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
> +               if (amdgpu_emu_mode =3D=3D 1) {
> +                       r =3D -1;
> +                       if (status & 2) {
> +                               r =3D 0;
> +                               break;
>                         }
> +               } else {
> +                       r =3D 0;
> +                       if (status & 2)
> +                               break;
>
> -                       if (amdgpu_emu_mode =3D=3D 1) {
> -                               r =3D -1;
> -                               if (status & 2) {
> -                                       r =3D 0;
> -                                       break;
> -                               }
> -                       } else {
> -                               r =3D 0;
> -                               if (status & 2)
> -                                       break;
> -
> -                               dev_err(adev->dev, "VCN[%d] is not respon=
ding, trying to reset the VCPU!!!\n", i);
> -                               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_=
VCPU_CNTL),
> -                                                       UVD_VCPU_CNTL__BL=
K_RST_MASK,
> -                                                       ~UVD_VCPU_CNTL__B=
LK_RST_MASK);
> -                               mdelay(10);
> -                               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_=
VCPU_CNTL), 0,
> +                       dev_err(adev->dev, "VCN[%d] is not responding, tr=
ying to reset the VCPU!!!\n", inst);
> +                       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_=
CNTL),
> +                                               UVD_VCPU_CNTL__BLK_RST_MA=
SK,
>                                                 ~UVD_VCPU_CNTL__BLK_RST_M=
ASK);
> +                       mdelay(10);
> +                       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_=
CNTL), 0,
> +                                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
>
> -                               mdelay(10);
> -                               r =3D -1;
> -                       }
> -               }
> -
> -               if (r) {
> -                       dev_err(adev->dev, "VCN[%d] is not responding, gi=
ving up!!!\n", i);
> -                       return r;
> +                       mdelay(10);
> +                       r =3D -1;
>                 }
> +       }
>
> -               /* enable master interrupt */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> -                               UVD_MASTINT_EN__VCPU_EN_MASK,
> -                               ~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -               /* clear the busy bit of VCN_STATUS */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> -                               ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> -
> -               ring =3D &adev->vcn.inst[i].ring_enc[0];
> -               WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> -                               ring->doorbell_index << VCN_RB1_DB_CTRL__=
OFFSET__SHIFT |
> -                               VCN_RB1_DB_CTRL__EN_MASK);
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
> +       if (r) {
> +               dev_err(adev->dev, "VCN[%d] is not responding, giving up!=
!!\n", inst);
> +               return r;
>         }
>
> +       /* enable master interrupt */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_MASTINT_EN),
> +                       UVD_MASTINT_EN__VCPU_EN_MASK,
> +                       ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +       /* clear the busy bit of VCN_STATUS */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_STATUS), 0,
> +                       ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +
> +       ring =3D &adev->vcn.inst[inst].ring_enc[0];
> +       WREG32_SOC15(VCN, inst, regVCN_RB1_DB_CTRL,
> +                       ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
> +                       VCN_RB1_DB_CTRL__EN_MASK);
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
> +
>         return 0;
>  }
>
> @@ -1543,83 +1538,79 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_=
device *adev, int inst_idx)
>   *
>   * Stop VCN block
>   */
> -static int vcn_v4_0_stop(struct amdgpu_device *adev)
> +static int vcn_v4_0_stop(struct amdgpu_device *adev, unsigned int inst)
>  {
>         volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>         uint32_t tmp;
> -       int i, r =3D 0;
> -
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->vcn.harvest_config & (1 << i))
> -                       continue;
> +       int r =3D 0;
>
> -               fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> -               fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
> +       if (adev->vcn.harvest_config & (1 << inst))
> +               goto done;
>
> -               if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       vcn_v4_0_stop_dpg_mode(adev, i);
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
> +               vcn_v4_0_stop_dpg_mode(adev, inst);
> +               goto done;
> +       }
>
> -               tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -                       UVD_LMI_STATUS__READ_CLEAN_MASK |
> -                       UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -                       UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
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
> -                       UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -               r =3D SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, =
tmp);
> -               if (r)
> -                       return r;
> +       tmp =3D UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +               UVD_LMI_STATUS__READ_CLEAN_MASK |
> +               UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +               UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> +       if (r)
> +               return r;
>
> -               /* block VCPU register access */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> -                               UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -                               ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +       /* disable LMI UMC channel */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2);
> +       tmp |=3D UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_LMI_CTRL2, tmp);
> +       tmp =3D UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +               UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +       r =3D SOC15_WAIT_ON_RREG(VCN, inst, regUVD_LMI_STATUS, tmp, tmp);
> +       if (r)
> +               return r;
>
> -               /* reset VCPU */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -                               UVD_VCPU_CNTL__BLK_RST_MASK,
> -                               ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +       /* block VCPU register access */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_RB_ARB_CTRL),
> +                       UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +                       ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>
> -               /* disable VCPU clock */
> -               WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -                               ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +       /* reset VCPU */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL),
> +                       UVD_VCPU_CNTL__BLK_RST_MASK,
> +                       ~UVD_VCPU_CNTL__BLK_RST_MASK);
>
> -               /* apply soft reset */
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -               tmp =3D RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -               tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -               WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +       /* disable VCPU clock */
> +       WREG32_P(SOC15_REG_OFFSET(VCN, inst, regUVD_VCPU_CNTL), 0,
> +                       ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>
> -               /* clear status */
> -               WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
> +       /* apply soft reset */
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(VCN, inst, regUVD_SOFT_RESET);
> +       tmp |=3D UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +       WREG32_SOC15(VCN, inst, regUVD_SOFT_RESET, tmp);
>
> -               /* apply HW clock gating */
> -               vcn_v4_0_enable_clock_gating(adev, i);
> +       /* clear status */
> +       WREG32_SOC15(VCN, inst, regUVD_STATUS, 0);
>
> -               /* enable VCN power gating */
> -               vcn_v4_0_enable_static_power_gating(adev, i);
> -       }
> +       /* apply HW clock gating */
> +       vcn_v4_0_enable_clock_gating(adev, inst);
>
> -       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -               if (adev->pm.dpm_enabled)
> -                       amdgpu_dpm_enable_vcn(adev, false, i);
> -       }
> +       /* enable VCN power gating */
> +       vcn_v4_0_enable_static_power_gating(adev, inst);
> +done:
> +       if (adev->pm.dpm_enabled)
> +               amdgpu_dpm_enable_vcn(adev, false, inst);
>
>         return 0;
>  }
> @@ -2058,9 +2049,9 @@ static int vcn_v4_0_set_powergating_state(struct am=
dgpu_ip_block *ip_block,
>                 return 0;
>
>         if (state =3D=3D AMD_PG_STATE_GATE)
> -               ret =3D vcn_v4_0_stop(adev);
> +               ret =3D vcn_v4_0_stop(adev, inst);
>         else
> -               ret =3D vcn_v4_0_start(adev);
> +               ret =3D vcn_v4_0_start(adev, inst);
>
>         if (!ret)
>                 adev->vcn.inst[inst].cur_state =3D state;
> --
> 2.34.1
>
