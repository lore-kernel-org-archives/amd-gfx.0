Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4602C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF3010EC02;
	Fri, 11 Apr 2025 15:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CLCiPqk2";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984B010EC02
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:51:47 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-af9a6958a08so206597a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744386707; x=1744991507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yR4G17QTs4Q0SmvRIRDYn+JK7CHV/UX0bwyqUvOaEwI=;
 b=CLCiPqk2hwrLjSjEwyKZgKkWUGUEGGwDb8Dl8s1yQM/w0B2eCCqS2nN3k29+Hoyo9w
 sACQRjN9mB2b+2MA+K0dKhhmQUSB45mwgV48zULUy4zk21ErhBppbjsIdYWzAfKYiGmt
 LTR/xjEw1hYsDsV7TcpgbHDpjaGxinvtT4rvwNGadxEUhynufGNu5x59faVyKZpEsr//
 j3Fajv6y4CRS66VHZ5dowzu7pI6zroCXB7nUUOruo54C53phZSp4PBp73AsjeAdL3gYJ
 tnf8Se11EaMM8rzYaMADFy0SPebZ7vhQq5Y96WBe+wYI2f1UCEvG5pNQjIcdDOVl+2HQ
 wVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744386707; x=1744991507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yR4G17QTs4Q0SmvRIRDYn+JK7CHV/UX0bwyqUvOaEwI=;
 b=E/jgj68g9NxhWMst1bynea7669bBaIpmp1iyCgJQ463Jpkc5mjQ4qAr4GLZpiFx3Sb
 dQE+edVntIAowlCjRTU5plvEWLOz4+6JoLuWj5xMEesIwRb5biCcgXw9wRk5GMcD47Or
 I+CMGMKUfics7I5fuenC/vbQ13CtBeWbI0GXDPvz0dnumWBicXV7Xu3/pRFL9Mgv62+q
 vdBce29Lz3f7ZNjEUfHNR9zw96+Al+AqlhPd4hS3LAd0ixygFP1X1eX1sAQygHaozg28
 hyhbwhS73o8aWTbbBt04YZJttBe//ZcBXdXcOvafQ8rYGbI1WxD/tqm9V2lCtpR0Jb8Z
 EMsw==
X-Gm-Message-State: AOJu0YzNR3MKKfRa0OkBpwbslMomuS9aYdl2pFPN+Pb/ZFXlkFCeJjYK
 wb0aXWJ/Oiet/hiZFvmEORQnj3MrNbWZy4w74kIAWyfWuQDGFoVZ0TstBr8+EawE5+N50BXhuUb
 Z1RTBcNJGJH9xGCLCgSRJYrYTjFsmFU9f
X-Gm-Gg: ASbGncuFbz52k+2HG2Fsimg5SLJlp2RSsxOyOE/ABOzf3s+e6o2f1snwnt0JSk/537I
 cGSF9t6vxXmwa2Pjh9rAJlGMsptAYcHeHVGrFnqmTlR4cazHvD4OqUdXPSuFUn8a6JKIZzw7szc
 Ofr9M/v4fuAe3WmOBTOBp7dQ==
X-Google-Smtp-Source: AGHT+IGSJLllWneagHu9vm7i0QlYl0158Y0/TdUvDXQtJdB2LffP2c75ASch36QJmBBBw+Kn0bzxaEcv5AapHjYoIzo=
X-Received: by 2002:a17:90b:33cd:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-3082367472fmr1999156a91.4.1744386706855; Fri, 11 Apr 2025
 08:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
 <20250411082921.3228498-2-jesse.zhang@amd.com>
In-Reply-To: <20250411082921.3228498-2-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 11:51:35 -0400
X-Gm-Features: ATxdqUEQHkocpP5uQkob0lQoHGSaRkhw3BXye2hyYs1c_u6CIq0uNNrLjaF0Rlc
Message-ID: <CADnq5_MtGWUWh=er90SVvNAJohA9EZisdBP1MJmXSLoBw7G2hQ@mail.gmail.com>
Subject: Re: [v5 2/6] drm/amdgpu: Register the new sdma function pointers for
 each sdma IP version that needs them
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, jonathan.kim@amd.com,
 jiadong.zhu@amd.com
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

On Fri, Apr 11, 2025 at 4:37=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> Register stop/start/soft_reset queue functions for SDMA IP versions
> v4.4.2, v5.0 and v5.2.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Might want to split this per IP?  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 +++---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 76 ++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 92 ++++++++++++++----------
>  3 files changed, 125 insertions(+), 65 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 688a720bbbbd..c663c63485f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -108,6 +108,8 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_d=
evice *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v);
>  static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
>
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>                 u32 instance, u32 offset)
> @@ -1333,6 +1335,11 @@ static bool sdma_v4_4_2_fw_support_paging_queue(st=
ruct amdgpu_device *adev)
>         }
>  }
>
> +static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs =3D {
> +       .stop_kernel_queue =3D &sdma_v4_4_2_stop_queue,
> +       .start_kernel_queue =3D &sdma_v4_4_2_restore_queue,
> +};
> +
>  static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -1352,7 +1359,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_=
block *ip_block)
>         sdma_v4_4_2_set_irq_funcs(adev);
>         sdma_v4_4_2_set_ras_funcs(adev);
>         sdma_v4_4_2_set_engine_reset_funcs(adev);
> -
>         return 0;
>  }
>
> @@ -1447,6 +1453,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 /* Initialize guilty flags for GFX and PAGE queues */
>                 adev->sdma.instance[i].gfx_guilty =3D false;
>                 adev->sdma.instance[i].page_guilty =3D false;
> +               adev->sdma.instance[i].funcs =3D &sdma_v4_4_2_sdma_funcs;
>
>                 ring =3D &adev->sdma.instance[i].ring;
>                 ring->ring_obj =3D NULL;
> @@ -1678,11 +1685,12 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_=
ring *ring, unsigned int vmid)
>         return r;
>  }
>
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>  {
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 instance_id =3D GET_INST(SDMA0, ring->me);
>         u32 inst_mask;
>         uint64_t rptr;
> -       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
> @@ -1715,11 +1723,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_d=
evice *adev, uint32_t instance_
>         return 0;
>  }
>
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  {
> -       int i;
> +       struct amdgpu_device *adev =3D ring->adev;
>         u32 inst_mask;
> -       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
> +       int i;
>
>         inst_mask =3D 1 << ring->me;
>         udelay(50);
> @@ -1740,8 +1748,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_=
device *adev, uint32_t instan
>  }
>
>  static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs =3D {
> -       .pre_reset =3D sdma_v4_4_2_stop_queue,
> -       .post_reset =3D sdma_v4_4_2_restore_queue,
>  };
>
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index e1348b6d9c6a..bef80b318f8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -112,6 +112,8 @@ static void sdma_v5_0_set_ring_funcs(struct amdgpu_de=
vice *adev);
>  static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev);
>  static void sdma_v5_0_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v5_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring);
> +static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring);
>
>  static const struct soc15_reg_golden golden_settings_sdma_5[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmSDMA0_CHICKEN_BITS, 0xffbf1f0f, 0=
x03ab0107),
> @@ -1323,6 +1325,36 @@ static void sdma_v5_0_ring_emit_reg_write_reg_wait=
(struct amdgpu_ring *ring,
>         amdgpu_ring_emit_reg_wait(ring, reg1, mask, mask);
>  }
>
> +static int sdma_v5_0_soft_reset_engine(struct amdgpu_device *adev, u32 i=
nstance_id)
> +{
> +       u32 grbm_soft_reset;
> +       u32 tmp;
> +
> +       grbm_soft_reset =3D REG_SET_FIELD(0,
> +                                       GRBM_SOFT_RESET, SOFT_RESET_SDMA0=
,
> +                                       1);
> +       grbm_soft_reset <<=3D instance_id;
> +
> +       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       tmp |=3D grbm_soft_reset;
> +       DRM_DEBUG("GRBM_SOFT_RESET=3D0x%08X\n", tmp);
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +
> +       udelay(50);
> +
> +       tmp &=3D ~grbm_soft_reset;
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       return 0;
> +}
> +
> +static const struct amdgpu_sdma_funcs sdma_v5_0_sdma_funcs =3D {
> +       .stop_kernel_queue =3D &sdma_v5_0_stop_queue,
> +       .start_kernel_queue =3D &sdma_v5_0_restore_queue,
> +       .soft_reset_kernel_queue =3D &sdma_v5_0_soft_reset_engine,
> +};
> +
>  static int sdma_v5_0_early_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -1365,6 +1397,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 return r;
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               adev->sdma.instance[i].funcs =3D &sdma_v5_0_sdma_funcs;
>                 ring =3D &adev->sdma.instance[i].ring;
>                 ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
> @@ -1505,9 +1538,17 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_b=
lock *ip_block)
>
>  static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int =
vmid)
>  {
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 inst_id =3D ring->me;
> +
> +       return amdgpu_sdma_reset_engine(adev, inst_id);
> +}
> +
> +static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
> +{
> +       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
>         struct amdgpu_device *adev =3D ring->adev;
>         int i, j, r;
> -       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset=
, stat1_reg;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
> @@ -1562,30 +1603,25 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
>         cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
>         cntl =3D REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
>         WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
> +err0:
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +       return r;
> +}
>
> -       /* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT =3D 0 mmGRBM_SOFT_RESET=
.SOFT_RESET_SDMA0/1 =3D 1 */
> -       preempt =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_=
PREEMPT));
> -       preempt =3D REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT,=
 0);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), pr=
eempt);
> -
> -       soft_reset =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
i;
> -
> -       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> -
> -       udelay(50);
> -
> -       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< i);
> -       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> +static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 inst_id =3D ring->me;
> +       u32 freeze;
> +       int r;
>
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>         /* unfreeze*/
> -       freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0=
_FREEZE));
>         freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +       WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), f=
reeze);
>
> -       r =3D sdma_v5_0_gfx_resume_instance(adev, i, true);
> -
> -err0:
> +       r =3D sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
>         amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 964f12afac9e..4cd7010ad0d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -113,6 +113,8 @@ static void sdma_v5_2_set_ring_funcs(struct amdgpu_de=
vice *adev);
>  static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev);
>  static void sdma_v5_2_set_vm_pte_funcs(struct amdgpu_device *adev);
>  static void sdma_v5_2_set_irq_funcs(struct amdgpu_device *adev);
> +static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring);
> +static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring);
>
>  static u32 sdma_v5_2_get_reg_offset(struct amdgpu_device *adev, u32 inst=
ance, u32 internal_offset)
>  {
> @@ -759,37 +761,49 @@ static int sdma_v5_2_load_microcode(struct amdgpu_d=
evice *adev)
>         return 0;
>  }
>
> -static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
> +static int sdma_v5_2_soft_reset_engine(struct amdgpu_device *adev, u32 i=
nstance_id)
>  {
> -       struct amdgpu_device *adev =3D ip_block->adev;
>         u32 grbm_soft_reset;
>         u32 tmp;
> -       int i;
>
> -       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> -               grbm_soft_reset =3D REG_SET_FIELD(0,
> -                                               GRBM_SOFT_RESET, SOFT_RES=
ET_SDMA0,
> -                                               1);
> -               grbm_soft_reset <<=3D i;
> +       grbm_soft_reset =3D REG_SET_FIELD(0,
> +                                       GRBM_SOFT_RESET, SOFT_RESET_SDMA0=
,
> +                                       1);
> +       grbm_soft_reset <<=3D instance_id;
>
> -               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -               tmp |=3D grbm_soft_reset;
> -               DRM_DEBUG("GRBM_SOFT_RESET=3D0x%08X\n", tmp);
> -               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> -               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       tmp |=3D grbm_soft_reset;
> +       DRM_DEBUG("GRBM_SOFT_RESET=3D0x%08X\n", tmp);
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
>
> -               udelay(50);
> +       udelay(50);
>
> -               tmp &=3D ~grbm_soft_reset;
> -               WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> -               tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       tmp &=3D ~grbm_soft_reset;
> +       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, tmp);
> +       tmp =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> +       return 0;
> +}
>
> +static int sdma_v5_2_soft_reset(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       int i;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               sdma_v5_2_soft_reset_engine(adev, i);
>                 udelay(50);
>         }
>
>         return 0;
>  }
>
> +static const struct amdgpu_sdma_funcs sdma_v5_2_sdma_funcs =3D {
> +       .stop_kernel_queue =3D &sdma_v5_2_stop_queue,
> +       .start_kernel_queue =3D &sdma_v5_2_restore_queue,
> +       .soft_reset_kernel_queue =3D &sdma_v5_2_soft_reset_engine,
> +};
> +
>  /**
>   * sdma_v5_2_start - setup and start the async dma engines
>   *
> @@ -1302,6 +1316,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         }
>
>         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               adev->sdma.instance[i].funcs =3D &sdma_v5_2_sdma_funcs;
>                 ring =3D &adev->sdma.instance[i].ring;
>                 ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
> @@ -1435,10 +1450,18 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_=
ip_block *ip_block)
>  }
>
>  static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int =
vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 inst_id =3D ring->me;
> +
> +       return amdgpu_sdma_reset_engine(adev, inst_id);
> +}
> +
> +static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         int i, j, r;
> -       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset=
, stat1_reg;
> +       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
> @@ -1495,31 +1518,26 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
>         cntl =3D REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
>         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
>
> -       /* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT =3D 0 mmGRBM_SOFT_RESET=
.SOFT_RESET_SDMA0/1 =3D 1 */
> -       preempt =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
PREEMPT));
> -       preempt =3D REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT,=
 0);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), pr=
eempt);
> -
> -       soft_reset =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
i;
> -
> -
> -       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> -
> -       udelay(50);
> -
> -       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< i);
> +err0:
> +       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> +       return r;
> +}
>
> -       WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
> +static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 inst_id =3D ring->me;
> +       u32 freeze;
> +       int r;
>
> +       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>         /* unfreeze and unhalt */
> -       freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0=
_FREEZE));
>         freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 0);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +       WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), f=
reeze);
>
> -       r =3D sdma_v5_2_gfx_resume_instance(adev, i, true);
> +       r =3D sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
>
> -err0:
>         amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
>         return r;
>  }
> --
> 2.25.1
>
