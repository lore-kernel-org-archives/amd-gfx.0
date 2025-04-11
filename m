Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A50C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 15:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39C010EC06;
	Fri, 11 Apr 2025 15:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A1Ryme9z";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49E8F10EC06
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 15:52:57 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-af9a6958a08so206899a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744386777; x=1744991577; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbjfGlQcgWL/mJ8ddS9oOsgk0se5iuFjjWZwZ3P8amY=;
 b=A1Ryme9zGYvqYk2e3lMMrdb0XREu3LXaPpjMOZs+tO/FGHWduDuiWQ/l2gQL5u6roa
 1RQ0JWanryeVSuvsj6rEhf0BLUTPlxQFTEKyn8k5Kq6ik6nP7+OOm1O0QL3uii/wW/xf
 7hYWTD0cLF+aMIT5bHavqtOr+6MuQnL7SClI0X1PfCFXioG29pamThqVTO1x2cl25UPz
 0bQOnGjuIMqasyPIR+HvNNl2PNTOtwzMa8gbJ+UGiIdxsd2yv7CfrtlgHE/RAQKdkNon
 ikK3kOomctYpk5dVTm2znLmVTDu/9Z75XCG5+GMqXOz9/IhLxEJBExrByLZOZmTsHkcz
 mpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744386777; x=1744991577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbjfGlQcgWL/mJ8ddS9oOsgk0se5iuFjjWZwZ3P8amY=;
 b=po7WrfDGceeLcjw42XOH0fs4v2yOj0b5U0BzfSs8eD7wz/yQ00C46QK6YTiGfizy0e
 eSiIgl96LS/ghgLKEPaaA+RGGJs+v/hDmTJdBEd499qeZnvfw2m3YrzV7oqAnoihfe0n
 3GalJZWgsCuPHW4r8oLtIoyQScNj+b5cftY7IFMiVEIuCSy0OgNGBBMijicGXjmgMgVh
 Ph5RmxYRuXNk68Cnauc2XRwfeVQLjew6inf1BuaOu4wS6PTdvA7hPK+MhDlAUeALhhdO
 p8bPd4zfQsftt9ds/PXG25nabCf8uiFW5dFwNmcSfrkgEgOz0mdA4D436EA6uuY5dC0l
 njHg==
X-Gm-Message-State: AOJu0YzOtsbJ2q7LLS8eQvdB00Q9XMNFXGVXyLLYJOCsKG9nQBosaQdP
 HE9reXbj4DyN5o+4lywf32lyMqYgbPTglxpFI/YvCCIeOMfWyp5rLijhk31cBQy+geepDdZCLXc
 t3N/NlLHanuAY0lxomW6c95jPD8Y=
X-Gm-Gg: ASbGncsn8ynkn1ganYk2Zdbw4CcQSTeLagpv8obqgmFsi+PxZ/kbnPJ6cxnLS9aAup1
 pzir0ibAbLqrXFHdw8DWTEt5I09Zv8dyJa1lsVwKbokmpc7yAd6sgEBl2Upo3kRHwVGvljk6wOe
 fRXbhtKcaFwUkN6VjNbkgn3QBJIef5eLW+
X-Google-Smtp-Source: AGHT+IGNkkD5NxHma6EaeFdULBwa6DV/Jf1/BE5Cb9drDs4OGQTuZ6O7OOFDTD/wtwNFeOVlAsjqg+O3bSTxlhcoV+I=
X-Received: by 2002:a17:90b:17c4:b0:306:e75e:dbc7 with SMTP id
 98e67ed59e1d1-30823558034mr2049575a91.0.1744386776633; Fri, 11 Apr 2025
 08:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250411082921.3228498-1-jesse.zhang@amd.com>
 <20250411082921.3228498-4-jesse.zhang@amd.com>
In-Reply-To: <20250411082921.3228498-4-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 11:52:44 -0400
X-Gm-Features: ATxdqUHm2somqEgg3yZML08sxEHygbnAIXOU3_sE3zEvFVZDpIGdbZz3r-QZZuw
Message-ID: <CADnq5_NrCuAgDsAoy6O++26AXDwecJ98zJmf+G6cnpjDK5fNhg@mail.gmail.com>
Subject: Re: [v5 4/6] drm/amdgpu: optimize queue reset and stop logic
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

On Fri, Apr 11, 2025 at 4:42=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch refactors the SDMA v5.x queue reset and stop logic to improve
> code readability, maintainability, and performance. The key changes inclu=
de:
>
> 1. **Generalized `sdma_v5_x_gfx_stop` Function**:
>    - Added an `inst_mask` parameter to allow stopping specific SDMA insta=
nces
>      instead of all instances. This is useful for resetting individual qu=
eues.
>
> 2. **Simplified `sdma_v5_x_reset_queue` Function**:
>    - Removed redundant loops and checks by directly using the `ring->me` =
field
>      to identify the SDMA instance.
>    - Reused the `sdma_v5_x_gfx_stop` function to stop the queue, reducing=
 code
>      duplication.
>
> v1: The general coding style is to declare variables like "i" or "r" last=
. E.g. longest lines first and short lasts. (Chritian)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Might want to split this per IP?  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 31 ++++++++------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 27 ++++++++--------------
>  2 files changed, 18 insertions(+), 40 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index bef80b318f8e..11dfa0b7544d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -557,15 +557,15 @@ static void sdma_v5_0_ring_emit_fence(struct amdgpu=
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
> @@ -657,9 +657,11 @@ static void sdma_v5_0_enable(struct amdgpu_device *a=
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
> @@ -1546,33 +1548,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
>
>  static int sdma_v5_0_stop_queue(struct amdgpu_ring *ring)
>  {
> -       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
> +       u32 f32_cntl, freeze, cntl, stat1_reg;
>         struct amdgpu_device *adev =3D ring->adev;
>         int i, j, r;
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
> +       i =3D ring->me;
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
> +       sdma_v5_0_gfx_stop(adev, 1 << i);
>
>         /* engine stop SDMA1_F32_CNTL.HALT to 1 and SDMAx_FREEZE freeze b=
it to 1 */
>         freeze =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_FREEZ=
E));
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index 4cd7010ad0d7..db6630c3f30a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -407,15 +407,15 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu=
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
> @@ -506,9 +506,11 @@ static void sdma_v5_2_enable(struct amdgpu_device *a=
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
> @@ -1459,29 +1461,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
>
>  static int sdma_v5_2_stop_queue(struct amdgpu_ring *ring)
>  {
> +       u32 rb_cntl, f32_cntl, freeze, cntl, stat1_reg;
>         struct amdgpu_device *adev =3D ring->adev;
>         int i, j, r;
> -       u32 rb_cntl, ib_cntl, f32_cntl, freeze, cntl, stat1_reg;
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
> +       i =3D ring->me;
>         amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
>
>         /* stop queue */
> -       ib_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
IB_CNTL));
> -       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, =
0);
> -       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib=
_cntl);
> +       sdma_v5_2_gfx_stop(adev, 1 << i);
>
>         rb_cntl =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_=
RB_CNTL));
>         rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, =
0);
> --
> 2.25.1
>
