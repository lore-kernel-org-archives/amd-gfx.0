Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA0EC36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 20:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A3310E561;
	Mon,  7 Apr 2025 20:04:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NvLFSiep";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5489D10E561
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 20:04:33 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so727254a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 13:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056273; x=1744661073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZKihXH+CKLIm0fs26Epi31aZiwAn7svh3gHdWjak90=;
 b=NvLFSiepzMO8hdWSTo/ApXVsvbaC9NWIZ94plS4T9oWX8ML0A6H1AT+CA9pZk9Wau6
 IcXYKhPY1NzZI3fEYDEyCXy7KasWtR4KiZBtJo41vIiCjq6WjX8MtlthqI2/OKRtDrKg
 nAMOItykZ9Y6N0bqKBGea5c6uFUGzGkeor5aLGP7Rcrx5k2iU0C4bi2rg/x5KqamxblT
 LEt/RcifDuH2TAbkqNrImS659IiMNuyX+bjprQkaKhJp5AUb8NdVpjhL/YXeHjrrCZRm
 gHX8O//vLdTn/rNgTG0WCvPGELWO8gs19znNPG7GCnR+CTHsjqRPJWpfFpXYiu2yUtmd
 SGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056273; x=1744661073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZKihXH+CKLIm0fs26Epi31aZiwAn7svh3gHdWjak90=;
 b=doaYQ9L4TSyEah7IQ1FPewIwh3TycrxA6bBGLNA8R15BRY5wkPSow95ZscIW9eMoIE
 KrvdaqyyibfDFUexPhThdUN9COEHkiv0T+QHW9w6dxJIpio1OzeNIdloyUYVh18uV2Nc
 vF8rPMXR8rsBUxbDGMhqGdU1zQNuriqsZ+NRpWZu7XQEFsKxPljQ/5BP72jiKSX3tMLv
 +V72D/q6ajd0XLBo868x8m+UOtJJAJV2elSS3ud24pJA03FhsqxJREzWjFG9Mw++fR71
 upSdWVff5HOIXqJCAnmOTmAwF/GJM7XZEMWbAderH/FxIH3EzUtYnGJoZBU0ckc5Gjda
 rPZA==
X-Gm-Message-State: AOJu0YziPrBBCuQeBt0DIzWAvdmrXSVpaCXRxLBqsf03iZP0ODUGLxs0
 eKxfovDWJg0H2o9QiAyxQtZhivL1C9uoZGIgZOb1DxBC+bxSFrLlTcwsOvjyUI2XRQaPK6I1YrI
 bkCuMFpEts4DP8We05CX7J5zcTsm8Tg==
X-Gm-Gg: ASbGncv25pNOYzmMEzV6HExYBu71VbUQ1do7uG7XdQXvHzCbOIQia7hqFz7hGL42XZI
 lUCuMMlBCi01XSyLHXeYxE3NvRyatdZ75B9YJxpRvbhV7hMcERfjgtz0qwrNw3FT6qzm8U8nyKM
 uhjKyzydwXbduSBg0SUEXaHl+3Lg==
X-Google-Smtp-Source: AGHT+IGG1QkuyUb+fu5Pf/6iOp/dX9mQl1wwT66CJ+Auynuz3H0h6/EBbalWJyMFnjnAvPL/DPRp+Y/3uOWCeN+Clkw=
X-Received: by 2002:a17:90b:1d0e:b0:2fe:b2ea:30f0 with SMTP id
 98e67ed59e1d1-306a4918ba6mr7146500a91.4.1744056272347; Mon, 07 Apr 2025
 13:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250402091406.1641643-1-jesse.zhang@amd.com>
 <20250402091406.1641643-3-jesse.zhang@amd.com>
In-Reply-To: <20250402091406.1641643-3-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 16:04:20 -0400
X-Gm-Features: ATxdqUFAq_CrRCwmCA4hEfU-v97UUdoZL3gmn8F-x4z6NhwnMg5aFyk-lLYjQys
Message-ID: <CADnq5_OSDkPeyNuNvwniQab7-YnXz=UYV8MQpHaJaNCFd5wYig@mail.gmail.com>
Subject: Re: [v3 3/7] drm/amdgpu: Optimize SDMA v5.0 queue reset and stop logic
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

On Wed, Apr 2, 2025 at 5:23=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch refactors the SDMA v5.0 queue reset and stop logic to improve
> code readability, maintainability, and performance. The key changes inclu=
de:
>
> 1. **Generalized `sdma_v5_0_gfx_stop` Function**:
>    - Added an `inst_mask` parameter to allow stopping specific SDMA insta=
nces
>      instead of all instances. This is useful for resetting individual qu=
eues.
>
> 2. **Simplified `sdma_v5_0_reset_queue` Function**:
>    - Removed redundant loops and checks by directly using the `ring->me` =
field
>      to identify the SDMA instance.
>    - Reused the `sdma_v5_0_gfx_stop` function to stop the queue, reducing=
 code
>      duplication.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 65 +++++++++++---------------
>  1 file changed, 26 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index e1348b6d9c6a..9501652f903d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -555,15 +555,15 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr, u64 se
>   * sdma_v5_0_gfx_stop - stop the gfx async dma engines
>   *
>   * @adev: amdgpu_device pointer
> - *
> + * @inst_mask: mask of dma engine instances to be disabled
>   * Stop the gfx async dma ring buffers (NAVI10).
>   */
> -static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev)
> +static void sdma_v5_0_gfx_stop(struct amdgpu_device *adev, uint32_t inst=
_mask)
>  {
>         u32 rb_cntl, ib_cntl;
>         int i;
>
> -       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +       for_each_inst(i, inst_mask) {
>                 rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(=
adev, i, mmSDMA0_GFX_RB_CNTL));
>                 rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_=
ENABLE, 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_CNTL), rb_cntl);
> @@ -655,9 +655,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *a=
dev, bool enable)
>  {
>         u32 f32_cntl;
>         int i;
> +       uint32_t inst_mask;
>
> +       inst_mask =3D GENMASK(adev->sdma.num_instances - 1, 0);
>         if (!enable) {
> -               sdma_v5_0_gfx_stop(adev);
> +               sdma_v5_0_gfx_stop(adev, 1 << inst_mask);
>                 sdma_v5_0_rlc_stop(adev);
>         }
>
> @@ -1506,40 +1508,25 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_=
block *ip_block)
>  static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int =
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
> -
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
> -       ib_cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_=
IB_CNTL));
> -       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, =
0);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib=
_cntl);
> -
> -       rb_cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_=
RB_CNTL));
> -       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, =
0);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb=
_cntl);
> +       sdma_v5_0_gfx_stop(adev, 1 << ring->me);
>
>         /* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze b=
it to 1 */
> -       freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> +       freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0=
_FREEZE));
>         freeze =3D REG_SET_FIELD(freeze, SDMA0_FREEZE, FREEZE, 1);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZE), freeze)=
;
> +       WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_FREEZE), f=
reeze);
>
>         for (j =3D 0; j < adev->usec_timeout; j++) {
> -               freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDM=
A0_FREEZE));
> +               freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst_id,=
 mmSDMA0_FREEZE));
>                 if (REG_GET_FIELD(freeze, SDMA0_FREEZE, FROZEN) & 1)
>                         break;
>                 udelay(1);
> @@ -1547,7 +1534,7 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ring=
 *ring, unsigned int vmid)
>
>         /* check sdma copy engine all idle if frozen not received*/
>         if (j =3D=3D adev->usec_timeout) {
> -               stat1_reg =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mm=
SDMA0_STATUS1_REG));
> +               stat1_reg =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst_=
id, mmSDMA0_STATUS1_REG));
>                 if ((stat1_reg & 0x3FF) !=3D 0x3FF) {
>                         DRM_ERROR("cannot soft reset as sdma not idle\n")=
;
>                         r =3D -ETIMEDOUT;
> @@ -1555,35 +1542,35 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
>                 }
>         }
>
> -       f32_cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32=
_CNTL));
> +       f32_cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDM=
A0_F32_CNTL));
>         f32_cntl =3D REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_c=
ntl);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_F32_CNTL),=
 f32_cntl);
>
> -       cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +       cntl =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_C=
NTL));
>         cntl =3D REG_SET_FIELD(cntl, SDMA0_CNTL, UTC_L1_ENABLE, 0);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), cntl);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_CNTL), cnt=
l);
>
>         /* soft reset SDMA_GFX_PREEMPT.IB_PREEMPT =3D 0 mmGRBM_SOFT_RESET=
.SOFT_RESET_SDMA0/1 =3D 1 */
> -       preempt =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_=
PREEMPT));
> +       preempt =3D RREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA=
0_GFX_PREEMPT));
>         preempt =3D REG_SET_FIELD(preempt, SDMA0_GFX_PREEMPT, IB_PREEMPT,=
 0);
> -       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_PREEMPT), pr=
eempt);
> +       WREG32(sdma_v5_0_get_reg_offset(adev, inst_id, mmSDMA0_GFX_PREEMP=
T), preempt);
>
>         soft_reset =3D RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
> -       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
i;
> +       soft_reset |=3D 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << =
inst_id;
>
>         WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
>
>         udelay(50);
>
> -       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< i);
> +       soft_reset &=3D ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT <=
< inst_id);
>         WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
>
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
> +       r =3D sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
>
>  err0:
>         amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> --
> 2.25.1
>
