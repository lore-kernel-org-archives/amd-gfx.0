Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EDBCF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 13:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB9D10E6E3;
	Tue, 24 Sep 2024 13:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUEFoU1Z";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39EF010E6E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 13:41:32 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-718d5058819so331559b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727185292; x=1727790092; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7i4NLgIMAt51V7c6xJjqtf/uJWrSScNVCA1I7brFa2Y=;
 b=gUEFoU1Z582xOCe+uF+rZT1JXZxyPdQJyggDYEQKom4iIJDs1IX1gXg7rO0YwYHEl4
 N9WGNxRxrTiynnBsS2LcxX1ehgvZlKb06Nm5SLhOvSkj/clGsWt8fZXHYU0Li3HGthZ0
 1OdVlh9OvPtKmIfx6WZD32SlXcJdYy1e0xvTzbH0q5tex9RBINvpR2K6aJBs/m4oPBxE
 cMSG3ZgmGmsjDJO17P5AYFE4faxIe+r0et8eJ/XR07tkjQXJyBQibDjMph7BImqtL3Kq
 j267Vv/J+DOqNpU727PkqRSoKBZ6n8fFuJiPbQgkzamEOT5AeZaWiZm1qhE+0lPbWtEr
 ryCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727185292; x=1727790092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7i4NLgIMAt51V7c6xJjqtf/uJWrSScNVCA1I7brFa2Y=;
 b=L0rLaovv02cziEo+6lpEQ4a4G7yJpKMb5D+0XGokq55/RRrWPueY7y44DvFXiBiJnK
 zPhTykMBSEkwTp+nZSonu+FtSv9ZknNSqJUtQK97iZnqraYK6uu2zSn8a1AKTE8HCNFX
 3a+pMhAbd3HB3y1M5belyzoWQsAS/0mJcmx76gS7PUfLaXYls1CsK+4Ej00JqYVpQ5uz
 P6/xYIFxmrWKe0to/8dPU3WpKvsNyNEFoJ2Ze4MNbymQWiseqjQhRzbR4d5BamG6RKPD
 k+8GhdWzsikEg/v4x4DIyf0uL9wlRGHGW0ToTcxUP6orRU4tG+b5TzoXIhOqFhZvF7Vi
 NILg==
X-Gm-Message-State: AOJu0YxRuGZlTwD/HbxNpHoh5TVpYDBd1b2xD8L5RXz1GVZMj+CxFjwK
 GOZDpFNCFFp17qxeTZGHUYNrFqlNN/cacFhUoCckmZGLzb1nCLXHOhev9qGsBwGZCHGUZRJ1syQ
 vHRyRn+s7NR5uO9hlulGsgS4ME7xKSw==
X-Google-Smtp-Source: AGHT+IEpdHbJPARM8nhlkplcEqzvUjOQcF9WtgXsd0lv2MXiIAJYj3QRn0yfT75U+mRkTDKplxnGtOS+vIAsjSlYNEc=
X-Received: by 2002:a05:6a00:946a:b0:718:e49f:443e with SMTP id
 d2e1a72fcca58-7199ca808f7mr8793757b3a.7.1727185291438; Tue, 24 Sep 2024
 06:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063112.370961-1-jiadong.zhu@amd.com>
In-Reply-To: <20240920063112.370961-1-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 09:41:19 -0400
Message-ID: <CADnq5_O08JDRrGwDyiefEuUAKCZgVWKi4ZKfbm-ZTQ07fcojGg@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu/sdma5: split out per instance resume
 function
To: jiadong.zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Fri, Sep 20, 2024 at 2:43=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Extract the resume sequence from sdma_v5_0_gfx_resume for
> starting/restarting an individual instance.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 253 ++++++++++++++-----------
>  1 file changed, 138 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 3e48ea38385d..e813da1e48aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -705,14 +705,16 @@ static void sdma_v5_0_enable(struct amdgpu_device *=
adev, bool enable)
>  }
>
>  /**
> - * sdma_v5_0_gfx_resume - setup and start the async dma engines
> + * sdma_v5_0_gfx_resume_instance - start/restart a certain sdma engine
>   *
>   * @adev: amdgpu_device pointer
> + * @i: instance
> + * @restore: used to restore wptr when restart
>   *
> - * Set up the gfx DMA ring buffers and enable them (NAVI10).
> - * Returns 0 for success, error for failure.
> + * Set up the gfx DMA ring buffers and enable them. On restart, we will =
restore wptr and rptr.
> + * Return 0 for success.
>   */
> -static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
> +static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int=
 i, bool restore)
>  {
>         struct amdgpu_ring *ring;
>         u32 rb_cntl, ib_cntl;
> @@ -722,142 +724,163 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_dev=
ice *adev)
>         u32 temp;
>         u32 wptr_poll_cntl;
>         u64 wptr_gpu_addr;
> -       int i, r;
>
> -       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> -               ring =3D &adev->sdma.instance[i].ring;
> +       ring =3D &adev->sdma.instance[i].ring;
>
> -               if (!amdgpu_sriov_vf(adev))
> -                       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_=
SEM_WAIT_FAIL_TIMER_CNTL), 0);
> +       if (!amdgpu_sriov_vf(adev))
> +               WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT=
_FAIL_TIMER_CNTL), 0);
>
> -               /* Set ring buffer size in dwords */
> -               rb_bufsz =3D order_base_2(ring->ring_size / 4);
> -               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(=
adev, i, mmSDMA0_GFX_RB_CNTL));
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_=
SIZE, rb_bufsz);
> +       /* Set ring buffer size in dwords */
> +       rb_bufsz =3D order_base_2(ring->ring_size / 4);
> +       rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,=
 mmSDMA0_GFX_RB_CNTL));
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb=
_bufsz);
>  #ifdef __BIG_ENDIAN
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_=
SWAP_ENABLE, 1);
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
> -                                       RPTR_WRITEBACK_SWAP_ENABLE, 1);
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENA=
BLE, 1);
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
> +                               RPTR_WRITEBACK_SWAP_ENABLE, 1);
>  #endif
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_CNTL), rb_cntl);
> -
> -               /* Initialize the ring buffer's read and write pointers *=
/
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_CNTL), rb_cntl);
> +
> +       /* Initialize the ring buffer's read and write pointers */
> +       if (restore) {
> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> +       } else {
>                 WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR), 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_HI), 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR), 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_HI), 0);
> -
> -               /* setup the wptr shadow polling */
> -               wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_POLL_ADDR_LO),
> -                      lower_32_bits(wptr_gpu_addr));
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_POLL_ADDR_HI),
> -                      upper_32_bits(wptr_gpu_addr));
> -               wptr_poll_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_=
offset(adev, i,
> -                                                        mmSDMA0_GFX_RB_W=
PTR_POLL_CNTL));
> -               wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl,
> -                                              SDMA0_GFX_RB_WPTR_POLL_CNT=
L,
> -                                              F32_POLL_ENABLE, 1);
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_POLL_CNTL),
> -                      wptr_poll_cntl);
> -
> -               /* set the wb address whether it's enabled or not */
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_ADDR_HI),
> -                      upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_ADDR_LO),
> -                      lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
> -
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPT=
R_WRITEBACK_ENABLE, 1);
> -
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_BASE),
> -                      ring->gpu_addr >> 8);
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_BASE_HI),
> -                      ring->gpu_addr >> 40);
> -
> +       }
> +       /* setup the wptr shadow polling */
> +       wptr_gpu_addr =3D ring->wptr_gpu_addr;
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_WPTR_POLL_ADDR_LO),
> +              lower_32_bits(wptr_gpu_addr));
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_WPTR_POLL_ADDR_HI),
> +              upper_32_bits(wptr_gpu_addr));
> +       wptr_poll_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(a=
dev, i,
> +                                                mmSDMA0_GFX_RB_WPTR_POLL=
_CNTL));
> +       wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl,
> +                                      SDMA0_GFX_RB_WPTR_POLL_CNTL,
> +                                      F32_POLL_ENABLE, 1);
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_WPTR_POLL_CNTL),
> +              wptr_poll_cntl);
> +
> +       /* set the wb address whether it's enabled or not */
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_RPTR_ADDR_HI),
> +              upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_RPTR_ADDR_LO),
> +              lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
> +
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEB=
ACK_ENABLE, 1);
> +
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_BASE),
> +              ring->gpu_addr >> 8);
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_BASE_HI),
> +              ring->gpu_addr >> 40);
> +
> +       if (!restore)
>                 ring->wptr =3D 0;
>
> -               /* before programing wptr to a less value, need set minor=
_ptr_update first */
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_MINOR_PTR_UPDATE), 1);
> +       /* before programing wptr to a less value, need set minor_ptr_upd=
ate first */
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_MINOR_PTR_UPDATE), 1);
>
> -               if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use regi=
ster write for wptr */
> -                       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_=
GFX_RB_WPTR),
> -                              lower_32_bits(ring->wptr << 2));
> -                       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_=
GFX_RB_WPTR_HI),
> -                              upper_32_bits(ring->wptr << 2));
> -               }
> +       if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register wri=
te for wptr */
> +               WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_W=
PTR),
> +                      lower_32_bits(ring->wptr << 2));
> +               WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_RB_W=
PTR_HI),
> +                      upper_32_bits(ring->wptr << 2));
> +       }
>
> -               doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset=
(adev, i, mmSDMA0_GFX_DOORBELL));
> -               doorbell_offset =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg=
_offset(adev, i,
> -                                               mmSDMA0_GFX_DOORBELL_OFFS=
ET));
> +       doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i=
, mmSDMA0_GFX_DOORBELL));
> +       doorbell_offset =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(=
adev, i,
> +                                       mmSDMA0_GFX_DOORBELL_OFFSET));
>
> -               if (ring->use_doorbell) {
> -                       doorbell =3D REG_SET_FIELD(doorbell, SDMA0_GFX_DO=
ORBELL, ENABLE, 1);
> -                       doorbell_offset =3D REG_SET_FIELD(doorbell_offset=
, SDMA0_GFX_DOORBELL_OFFSET,
> -                                       OFFSET, ring->doorbell_index);
> -               } else {
> -                       doorbell =3D REG_SET_FIELD(doorbell, SDMA0_GFX_DO=
ORBELL, ENABLE, 0);
> -               }
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_DOORBELL), doorbell);
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_DOORBELL_OFFSET),
> -                      doorbell_offset);
> +       if (ring->use_doorbell) {
> +               doorbell =3D REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, =
ENABLE, 1);
> +               doorbell_offset =3D REG_SET_FIELD(doorbell_offset, SDMA0_=
GFX_DOORBELL_OFFSET,
> +                               OFFSET, ring->doorbell_index);
> +       } else {
> +               doorbell =3D REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, =
ENABLE, 0);
> +       }
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_DOORBELL), doorbell);
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_DOORBELL_OFFSET),
> +              doorbell_offset);
>
> -               adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_=
doorbell,
> -                                                     ring->doorbell_inde=
x, 20);
> +       adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell=
,
> +                                             ring->doorbell_index, 20);
>
> -               if (amdgpu_sriov_vf(adev))
> -                       sdma_v5_0_ring_set_wptr(ring);
> +       if (amdgpu_sriov_vf(adev))
> +               sdma_v5_0_ring_set_wptr(ring);
>
> -               /* set minor_ptr_update to 0 after wptr programed */
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_MINOR_PTR_UPDATE), 0);
> +       /* set minor_ptr_update to 0 after wptr programed */
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_MINOR_PTR_UPDATE), 0);
>
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       /* set utc l1 enable flag always to 1 */
> -                       temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i,=
 mmSDMA0_CNTL));
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_E=
NABLE, 1);
> -
> -                       /* enable MCBP */
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_P=
REEMPT_ENABLE, 1);
> -                       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_=
CNTL), temp);
> -
> -                       /* Set up RESP_MODE to non-copy addresses */
> -                       temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i,=
 mmSDMA0_UTCL1_CNTL));
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RE=
SP_MODE, 3);
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RE=
DO_DELAY, 9);
> -                       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_=
UTCL1_CNTL), temp);
> -
> -                       /* program default cache read and write policy */
> -                       temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i,=
 mmSDMA0_UTCL1_PAGE));
> -                       /* clean read policy and write policy bits */
> -                       temp &=3D 0xFF0FFF;
> -                       temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) =
| (CACHE_WRITE_POLICY_L2__DEFAULT << 14));
> -                       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_=
UTCL1_PAGE), temp);
> -               }
> +       if (!amdgpu_sriov_vf(adev)) {
> +               /* set utc l1 enable flag always to 1 */
> +               temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0=
_CNTL));
> +               temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1=
);
> +
> +               /* enable MCBP */
> +               temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_E=
NABLE, 1);
> +               WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_CNTL), t=
emp);
> +
> +               /* Set up RESP_MODE to non-copy addresses */
> +               temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0=
_UTCL1_CNTL));
> +               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE,=
 3);
> +               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY=
, 9);
> +               WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_CN=
TL), temp);
> +
> +               /* program default cache read and write policy */
> +               temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0=
_UTCL1_PAGE));
> +               /* clean read policy and write policy bits */
> +               temp &=3D 0xFF0FFF;
> +               temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) | (CACHE=
_WRITE_POLICY_L2__DEFAULT << 14));
> +               WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_UTCL1_PA=
GE), temp);
> +       }
>
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       /* unhalt engine */
> -                       temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i,=
 mmSDMA0_F32_CNTL));
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT=
, 0);
> -                       WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_=
F32_CNTL), temp);
> -               }
> +       if (!amdgpu_sriov_vf(adev)) {
> +               /* unhalt engine */
> +               temp =3D RREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0=
_F32_CNTL));
> +               temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
> +               WREG32(sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_F32_CNTL=
), temp);
> +       }
>
> -               /* enable DMA RB */
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_=
ENABLE, 1);
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_CNTL), rb_cntl);
> +       /* enable DMA RB */
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, =
1);
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_CNTL), rb_cntl);
>
> -               ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(=
adev, i, mmSDMA0_GFX_IB_CNTL));
> -               ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_=
ENABLE, 1);
> +       ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i,=
 mmSDMA0_GFX_IB_CNTL));
> +       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, =
1);
>  #ifdef __BIG_ENDIAN
> -               ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_=
SWAP_ENABLE, 1);
> +       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENA=
BLE, 1);
>  #endif
> -               /* enable DMA IBs */
> -               WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmS=
DMA0_GFX_IB_CNTL), ib_cntl);
> +       /* enable DMA IBs */
> +       WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX=
_IB_CNTL), ib_cntl);
>
> -               if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn=
't need below to lines */
> -                       sdma_v5_0_ctx_switch_enable(adev, true);
> -                       sdma_v5_0_enable(adev, true);
> -               }
> +       if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need =
below to lines */
> +               sdma_v5_0_ctx_switch_enable(adev, true);
> +               sdma_v5_0_enable(adev, true);
> +       }
> +
> +       return amdgpu_ring_test_helper(ring);
> +}
>
> -               r =3D amdgpu_ring_test_helper(ring);
> +/**
> + * sdma_v5_0_gfx_resume - setup and start the async dma engines
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Set up the gfx DMA ring buffers and enable them (NAVI10).
> + * Returns 0 for success, error for failure.
> + */
> +static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
> +{
> +       int i, r;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               r =3D sdma_v5_0_gfx_resume_instance(adev, i, false);
>                 if (r)
>                         return r;
>         }
> --
> 2.25.1
>
