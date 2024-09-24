Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B490CF9C6B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 13:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6BA10E6E8;
	Tue, 24 Sep 2024 13:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PDjI6GNC";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A1D10E6E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 13:41:53 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2db6b13c6a0so1028703a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727185313; x=1727790113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uQUc2Cmi7OF7Yqqhe4c0fQDkyUSerGaGpoqW0d0Uo8=;
 b=PDjI6GNCUic0vwQ7Za2BeSCe3ZeI37Nd8LQd54UaSCvlNVKJJg5aSwQkuIZ7z6LAl2
 cRlySMX8YTGkyW73ibULu8NRi6Bxi7/FuBMHtXrwS79wMKbkx+XVxfSNi0zBCgAiKwLw
 0ZYTAtlVIUsS1etF4PH9gAg5i2k13VYL48rWWu1DK3SV35qgFQrgd+dlyy/OLQiiB0vH
 PnVZ0SXVZI7d6HVZlhEiXQTE8i28pKnua2fuJLLMezLeJTxb4nYQwuOHnRWGsJj92VPW
 VBwtomVwHyDdspvEEbec2WOLFBxU8F/V5qrKhOOc0ZZf6qrLGYUjTlAhHuplpMrZaLP7
 jTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727185313; x=1727790113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uQUc2Cmi7OF7Yqqhe4c0fQDkyUSerGaGpoqW0d0Uo8=;
 b=hksB4ZWfMxrVpiYdxWOhEaU7w9V94wzy5Xk6zkCFyxU8wFu1Bk7S5nVxlLxAu6rERm
 wlqV+EvfXMvc+5s+I6gW4tsPB8q9S2Fq6RvKodDjjy5fx6EiNmBFCExbg636C/rEft71
 /ma/OVE724fiGLPUBMTApiNlFjEE2hmqGys5yg/qw2xfzGhbRjB5J2mvvThZBendIC8R
 zb7nU12z9Mh0hgTUzfr8LFl8muklSFkX5GMqnSmNFQ22rs8JgnTpN8bE9eSPmBVNjpja
 krMqS5dDsccSdDBIK68fG1RRjVd4aIs6/ZHMzUitkCzgFsKOhPAX1LZCyq+ebQKPQ8v4
 3XXw==
X-Gm-Message-State: AOJu0YwcAZ0euQw7WzA3nL1CEyXejowXAXA1QKWa1LZAI4+JJ/++rI0a
 KFy9s5An9rfinGJPd4MGVvxJWo3REWK0gG14DPve7rIVCQlMbm4/5ocODr0k2mzrKpAJ3tBAE7P
 6J6cZj6J7lLnn8eBYOXSylzui+EE=
X-Google-Smtp-Source: AGHT+IFk7XYIVm8BfDRsdxbbuwAvHvEXMdcwq/CKjcWXvmlR3eoDFmyZFiZl+TBTwkWD/XD03RU3iAiH+vPZkBRNkHw=
X-Received: by 2002:a17:90a:9205:b0:2db:60b:697f with SMTP id
 98e67ed59e1d1-2dd7f7a2297mr7831033a91.9.1727185312932; Tue, 24 Sep 2024
 06:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240920063112.370961-1-jiadong.zhu@amd.com>
 <20240920063112.370961-3-jiadong.zhu@amd.com>
In-Reply-To: <20240920063112.370961-3-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 09:41:41 -0400
Message-ID: <CADnq5_PZfQ9LZgk=vyzzPV1Udvpp2553fPKwhsg=2rneknm5DQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu/sdma5.2: split out per instance resume
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

On Fri, Sep 20, 2024 at 2:31=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Extract the resume sequence from sdma_v5_2_gfx_resume for
> starting/restarting an individual instance.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 247 ++++++++++++++-----------
>  1 file changed, 136 insertions(+), 111 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_2.c
> index bc9b240a3488..21457093eae9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -522,14 +522,17 @@ static void sdma_v5_2_enable(struct amdgpu_device *=
adev, bool enable)
>  }
>
>  /**
> - * sdma_v5_2_gfx_resume - setup and start the async dma engines
> + * sdma_v5_2_gfx_resume_instance - start/restart a certain sdma engine
>   *
>   * @adev: amdgpu_device pointer
> + * @i: instance
> + * @restore: used to restore wptr when restart
>   *
> - * Set up the gfx DMA ring buffers and enable them.
> - * Returns 0 for success, error for failure.
> + * Set up the gfx DMA ring buffers and enable them. On restart, we will =
restore wptr and rptr.
> + * Return 0 for success.
>   */
> -static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> +
> +static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int=
 i, bool restore)
>  {
>         struct amdgpu_ring *ring;
>         u32 rb_cntl, ib_cntl;
> @@ -539,139 +542,161 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_dev=
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
> -                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
> +       if (!amdgpu_sriov_vf(adev))
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
>
> -               /* Set ring buffer size in dwords */
> -               rb_bufsz =3D order_base_2(ring->ring_size / 4);
> -               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(=
adev, i, mmSDMA0_GFX_RB_CNTL));
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_=
SIZE, rb_bufsz);
> +       /* Set ring buffer size in dwords */
> +       rb_bufsz =3D order_base_2(ring->ring_size / 4);
> +       rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,=
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
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_CNTL), rb_cntl);
> -
> -               /* Initialize the ring buffer's read and write pointers *=
/
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_CNTL), rb_cntl);
> +
> +       /* Initialize the ring buffer's read and write pointers */
> +       if (restore) {
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR), lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> +       } else {
>                 WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR), 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_HI), 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR), 0);
>                 WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_HI), 0);
> +       }
>
> -               /* setup the wptr shadow polling */
> -               wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_POLL_ADDR_LO),
> -                      lower_32_bits(wptr_gpu_addr));
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_POLL_ADDR_HI),
> -                      upper_32_bits(wptr_gpu_addr));
> -               wptr_poll_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_=
offset(adev, i,
> -                                                        mmSDMA0_GFX_RB_W=
PTR_POLL_CNTL));
> -               wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl,
> -                                              SDMA0_GFX_RB_WPTR_POLL_CNT=
L,
> -                                              F32_POLL_ENABLE, 1);
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_WPTR_POLL_CNTL),
> -                      wptr_poll_cntl);
> -
> -               /* set the wb address whether it's enabled or not */
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_ADDR_HI),
> -                      upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_RPTR_ADDR_LO),
> -                      lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
> -
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPT=
R_WRITEBACK_ENABLE, 1);
> -
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
> -
> +       /* setup the wptr shadow polling */
> +       wptr_gpu_addr =3D ring->wptr_gpu_addr;
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_WPTR_POLL_ADDR_LO),
> +              lower_32_bits(wptr_gpu_addr));
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_WPTR_POLL_ADDR_HI),
> +              upper_32_bits(wptr_gpu_addr));
> +       wptr_poll_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(a=
dev, i,
> +                                                mmSDMA0_GFX_RB_WPTR_POLL=
_CNTL));
> +       wptr_poll_cntl =3D REG_SET_FIELD(wptr_poll_cntl,
> +                                      SDMA0_GFX_RB_WPTR_POLL_CNTL,
> +                                      F32_POLL_ENABLE, 1);
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_WPTR_POLL_CNTL),
> +              wptr_poll_cntl);
> +
> +       /* set the wb address whether it's enabled or not */
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_RPTR_ADDR_HI),
> +              upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_RPTR_ADDR_LO),
> +              lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
> +
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEB=
ACK_ENABLE, 1);
> +
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_BASE), ring->gpu_addr >> 8);
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_BASE_HI), ring->gpu_addr >> 40);
> +
> +       if (restore)
>                 ring->wptr =3D 0;
>
> -               /* before programing wptr to a less value, need set minor=
_ptr_update first */
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_MINOR_PTR_UPDATE), 1);
> +       /* before programing wptr to a less value, need set minor_ptr_upd=
ate first */
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_MINOR_PTR_UPDATE), 1);
>
> -               if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use regi=
ster write for wptr */
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
GFX_RB_WPTR), lower_32_bits(ring->wptr << 2));
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
GFX_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> -               }
> +       if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register wri=
te for wptr */
> +               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_W=
PTR), lower_32_bits(ring->wptr << 2));
> +               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_W=
PTR_HI), upper_32_bits(ring->wptr << 2));
> +       }
>
> -               doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset=
(adev, i, mmSDMA0_GFX_DOORBELL));
> -               doorbell_offset =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg=
_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
> +       doorbell =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i=
, mmSDMA0_GFX_DOORBELL));
> +       doorbell_offset =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(=
adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
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
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_DOORBELL), doorbell);
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
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
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_DOORBELL), doorbell);
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_DOORBELL_OFFSET), doorbell_offset);
>
> -               adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_=
doorbell,
> -                                                     ring->doorbell_inde=
x,
> -                                                     adev->doorbell_inde=
x.sdma_doorbell_range);
> +       adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell=
,
> +                                             ring->doorbell_index,
> +                                             adev->doorbell_index.sdma_d=
oorbell_range);
>
> -               if (amdgpu_sriov_vf(adev))
> -                       sdma_v5_2_ring_set_wptr(ring);
> +       if (amdgpu_sriov_vf(adev))
> +               sdma_v5_2_ring_set_wptr(ring);
>
> -               /* set minor_ptr_update to 0 after wptr programed */
> +       /* set minor_ptr_update to 0 after wptr programed */
>
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_MINOR_PTR_UPDATE), 0);
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_MINOR_PTR_UPDATE), 0);
>
> -               /* SRIOV VF has no control of any of registers below */
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       /* set utc l1 enable flag always to 1 */
> -                       temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i,=
 mmSDMA0_CNTL));
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_E=
NABLE, 1);
> -
> -                       /* enable MCBP */
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_P=
REEMPT_ENABLE, 1);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
CNTL), temp);
> -
> -                       /* Set up RESP_MODE to non-copy addresses */
> -                       temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_of=
fset(adev, i, mmSDMA0_UTCL1_CNTL));
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RE=
SP_MODE, 3);
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RE=
DO_DELAY, 9);
> -                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_UTCL1_CNTL), temp);
> -
> -                       /* program default cache read and write policy */
> -                       temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_of=
fset(adev, i, mmSDMA0_UTCL1_PAGE));
> -                       /* clean read policy and write policy bits */
> -                       temp &=3D 0xFF0FFF;
> -                       temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) =
|
> -                                (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
> -                                SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
> -                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev=
, i, mmSDMA0_UTCL1_PAGE), temp);
> -
> -                       /* unhalt engine */
> -                       temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i,=
 mmSDMA0_F32_CNTL));
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT=
, 0);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_=
F32_CNTL), temp);
> -               }
> +       /* SRIOV VF has no control of any of registers below */
> +       if (!amdgpu_sriov_vf(adev)) {
> +               /* set utc l1 enable flag always to 1 */
> +               temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0=
_CNTL));
> +               temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1=
);
> +
> +               /* enable MCBP */
> +               temp =3D REG_SET_FIELD(temp, SDMA0_CNTL, MIDCMD_PREEMPT_E=
NABLE, 1);
> +               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), t=
emp);
> +
> +               /* Set up RESP_MODE to non-copy addresses */
> +               temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(ade=
v, i, mmSDMA0_UTCL1_CNTL));
> +               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE,=
 3);
> +               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY=
, 9);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_UTCL1_CNTL), temp);
> +
> +               /* program default cache read and write policy */
> +               temp =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(ade=
v, i, mmSDMA0_UTCL1_PAGE));
> +               /* clean read policy and write policy bits */
> +               temp &=3D 0xFF0FFF;
> +               temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
> +                        (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
> +                        SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_UTCL1_PAGE), temp);
> +
> +               /* unhalt engine */
> +               temp =3D RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0=
_F32_CNTL));
> +               temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
> +               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL=
), temp);
> +       }
>
> -               /* enable DMA RB */
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_=
ENABLE, 1);
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_RB_CNTL), rb_cntl);
> +       /* enable DMA RB */
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, =
1);
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_RB_CNTL), rb_cntl);
>
> -               ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(=
adev, i, mmSDMA0_GFX_IB_CNTL));
> -               ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_=
ENABLE, 1);
> +       ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,=
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
> -               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmS=
DMA0_GFX_IB_CNTL), ib_cntl);
> +       /* enable DMA IBs */
> +       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX=
_IB_CNTL), ib_cntl);
>
> -               if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn=
't need below to lines */
> -                       sdma_v5_2_ctx_switch_enable(adev, true);
> -                       sdma_v5_2_enable(adev, true);
> -               }
> +       if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need =
below to lines */
> +               sdma_v5_2_ctx_switch_enable(adev, true);
> +               sdma_v5_2_enable(adev, true);
> +       }
> +
> +       return amdgpu_ring_test_helper(ring);
> +}
>
> -               r =3D amdgpu_ring_test_helper(ring);
> +/**
> + * sdma_v5_2_gfx_resume - setup and start the async dma engines
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Set up the gfx DMA ring buffers and enable them.
> + * Returns 0 for success, error for failure.
> + */
> +static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> +{
> +       int i, r;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               r =3D sdma_v5_2_gfx_resume_instance(adev, i, false);
>                 if (r)
>                         return r;
>         }
> --
> 2.25.1
>
