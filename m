Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48724C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 20:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4B410E577;
	Mon,  7 Apr 2025 20:05:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C/tmurkx";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF2510E56F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 20:05:35 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-223f7b10cbbso4013495ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 13:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056335; x=1744661135; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqJNF/K52+v+UuPqnH/jwFAT3ZdCj4WThwm5Jp52udQ=;
 b=C/tmurkxpwKAcIoSYlt8t8Z+d69lqY5OadTZ0+pZbkJ0s9KiBg0CJWUTX5KfOvTL8j
 xOMyHqGCESbPu+uHQRUHcvKQa/6MqI+UagFem99C5rD186csbR1y4+jkSbYPfZ82z+28
 irKWiRBnW838rr88V5QEAn787mZpt2yyXznjWvbmWQJs8zySHYOLvNOZLNysnCRz2kIq
 pDSPnVtpuwOAG0DpakPX5bZbiZOIY+kyt23HDccJUFG+7sAXENXgzh+e0SUBJwC+LeUF
 O24Zk/HF0UyyZ+AtjryzpMjbpZCd6plPPMVfCZMZsh1kAom41Xd6LqHBRUxFI+G9sx/u
 jzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056335; x=1744661135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqJNF/K52+v+UuPqnH/jwFAT3ZdCj4WThwm5Jp52udQ=;
 b=MS6+QbVN6Dp/wRtTexcmZA502BCU+HdBTDCO3EMSIl+sHiqKdl5vnfxLIZ1UMcNLh8
 SjZF1x7TK3dlujoF1aU1P46PpJ016DTFxZSHEICL1nP9aE1qSUkb8W58rPjC5Bb9oBQD
 DOJiixQylAz9wcTzNb4ZNb3/7K+/os2rswNwO6e2BtttWOFXm2XVfd7BiBhxZwyBf3LY
 MO2DCo4Gc4lAAdLzpMV6alHe45uxxI0keRGLV7Oqy9MoJmhXw/jPdWIEEzw5XmcoM/n7
 G8EmaFlSWks5xdDJ52hYxi9u3fxx9YvFwLvYuo/Kqos1x8wFmKOnMnw1WVHoZFY/Dg7y
 LLAA==
X-Gm-Message-State: AOJu0Yzmi3gNktaHSBswDjgbBbZlEhKsE5LqecR3TvGoeQbzsCMMIplN
 /ADG9gWcpJlvQOcOjgJrP4VDbIDKQ6ak+GHOGecfyZvTvFk8EI5opRsz+8W41h1lMCpH957vdDz
 rDX75PI0dbSfHEYs6OXzw/Uw8wpo=
X-Gm-Gg: ASbGncsgQjaSFdFn4uj30z0wnIa+YE+sf8lJchIKAEJb70/0mA+p6qIZfn8b5GsU1yI
 TObKr63s3IRoLXHj64fAUEwVbv/nSr2NvpPSBEvXS0m12tdLZo6Um3L9AyYbxM7ZR+Ivrw2wTBV
 qoGJXtnI7+V3WrD+zqklLyKoiJSQ==
X-Google-Smtp-Source: AGHT+IEETCS/18tC4yg5kl6gaVPP0CdhkmECQKTFZKqarZoej0MIQLLZMUYJZ/x7waNWniW2r2eFiCKqmE50AwCXlZc=
X-Received: by 2002:a17:902:da81:b0:220:cddb:5918 with SMTP id
 d9443c01a7336-22a8a0a3a9cmr68792365ad.9.1744056334634; Mon, 07 Apr 2025
 13:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
 <20250402091406.1641643-5-jesse.zhang@amd.com>
In-Reply-To: <20250402091406.1641643-5-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 16:05:22 -0400
X-Gm-Features: ATxdqUEpHkO4_x9uhSWHlZAGfC3uQoFSCIh6S6OSqZ8aH42D4mmzHha1EoM4hlQ
Message-ID: <CADnq5_P7TymPTPZWdy-okj9pXNoBnscz9Fq5ABQSqOPdh+rbww@mail.gmail.com>
Subject: Re: [v3 5/7] drm/amdgpu: Optimize SDMA v5.2 queue reset and stop logic
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

On Wed, Apr 2, 2025 at 5:15=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch refactors the SDMA v5.2 queue reset and stop logic to improve
> code readability, maintainability, and performance. The key changes inclu=
de:
>
> 1. **Generalized `sdma_v5_2_gfx_stop` Function**:
>         - Added an `inst_mask` parameter to allow stopping specific SDMA =
instances
>           instead of all instances. This is useful for resetting individu=
al queues.
>
> 2. **Simplified `sdma_v5_2_reset_queue` Function**:
>         - Removed redundant loops and checks by directly using the `ring-=
>me` field
>           to identify the SDMA instance.
>         - Reused the `sdma_v5_2_gfx_stop` function to stop the queue, red=
ucing code
>           duplication.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 64 +++++++++++---------------
>  1 file changed, 26 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 964f12afac9e..96b02c3e4993 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -405,15 +405,15 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr, u64 se
>   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
>   *
>   * @adev: amdgpu_device pointer
> - *
> + * @inst_mask: mask of dma engine instances to be disabled
>   * Stop the gfx async dma ring buffers.
>   */
> -static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
> +static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev,  uint32_t ins=
t_mask)
>  {
>         u32 rb_cntl, ib_cntl;
>         int i;
>
> -       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +       for_each_inst(i, inst_mask) {
>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(=
adev, i, mmSDMA0_GFX_RB_CNTL));
>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_=
ENABLE, 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_CNTL), rb_cntl);
> @@ -504,9 +504,11 @@ static void sdma_v5_2_enable(struct amdgpu_device *a=
dev, bool enable)
>  {
>         u32 f32_cntl;
>         int i;
> +       uint32_t inst_mask;
>
> +       inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
>         if (!enable) {
> -               sdma_v5_2_gfx_stop(adev);
> +               sdma_v5_2_gfx_stop(adev, inst_mask);
>                 sdma_v5_2_rlc_stop(adev);
>         }
>
> @@ -1437,40 +1439,26 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_=
ip_block *ip_block)
>  static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int =
vmid)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       int i, j, r;
> -       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, preempt, soft_reset=
, stat1_reg;
> +       int j, r;
> +       u32 f32_cntl, freeze, cntl, preempt, soft_reset, stat1_reg;
> +       u32 inst_id;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
>
> -       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> -               if (ring =3D=3D &adev->sdma.instance[i].ring)
> -                       break;
> -       }
> -
> -       if (i =3D=3D adev->sdma.num_instances) {
> -               DRM_ERROR("sdma instance not found\n");
> -               return -EINVAL;
> -       }
> -
> +       inst_id =3D ring->me;
>         amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>
>         /* stop queue */
> -       ib_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
IB_CNTL));
> -       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, =
0);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib=
_cntl);
> -
> -       rb_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
RB_CNTL));
> -       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, =
0);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb=
_cntl);
> +       sdma_v5_2_gfx_stop(adev, 1 << ring->me);
>
>         /*engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze bi=
t to 1 */
> -       freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0=
_FREEZE));
>         freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +       WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), f=
reeze);
>
>         for (j =3D 0; j < adev->usec_timeout; j++) {
> -               freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDM=
A0_FREEZE));
> +               freeze =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_id,=
 mmSDMA0_FREEZE));
>
>                 if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
>                         break;
> @@ -1479,7 +1467,7 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ring=
 *ring, unsigned int vmid)
>
>
>         if (j =3D=3D adev->usec_timeout) {
> -               stat1_reg =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mm=
SDMA0_STATUS1_REG));
> +               stat1_reg =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_=
id, mmSDMA0_STATUS1_REG));
>                 if ((stat1_reg & 0x3FF) !=3D 0x3FF) {
>                         DRM_ERROR("cannot soft reset as sdma not idle\n")=
;
>                         r =3D -ETIMEDOUT;
> @@ -1487,37 +1475,37 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
>                 }
>         }
>
> -       f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32=
_CNTL));
> +       f32_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDM=
A0_F32_CNTL));
>         f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_c=
ntl);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL),=
 f32_cntl);
>
> -       cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +       cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_C=
NTL));
>         cntl =3D REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_CNTL), cnt=
l);
>
>         /* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT =3D 0 mmGRBM_SOFT_RESET=
.SOFT_RESET_SDMA0/1 =3D 1 */
> -       preempt =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
PREEMPT));
> +       preempt =3D RREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA=
0_GFX_PREEMPT));
>         preempt =3D REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT,=
 0);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), pr=
eempt);
> +       WREG32(sdma_v5_2_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMP=
T), preempt);
>
>         soft_reset =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
i;
> +       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
inst_id;
>
>
>         WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
>
>         udelay(50);
>
> -       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< i);
> +       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< inst_id);
>
>         WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
>
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
>  err0:
>         amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> --
> 2.25.1
>
