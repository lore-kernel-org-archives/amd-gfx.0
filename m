Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50EEECE579
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 17:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BAAB10E5E6;
	Mon,  9 Sep 2024 17:09:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VBVxzFm2";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AE7110E5E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 17:09:24 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2053f72319fso2165435ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 10:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725901763; x=1726506563; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SegbiJSmnDil053g2UPUp9MTFPVJTwv0Ljt9qH7sq+I=;
 b=VBVxzFm2BEGNpO2ry4e7f5uwHk9ySqmBMF6PBwYRjhVCww3r/AhHUzBVzHksXoSKLL
 yl8qW3rtgDSvwNDKeaD8e3um+9YzJwBnfZ8JWL6zj5E4+PWf6IeqgHHhcQfqFsACA+2R
 58HoYXJWxvLLna2ONFaNz8CB3CymWuDAaqi5N5GPR95sS5k5Ry+XCLJpCY/u9V+WtTAL
 26xg0lz932JUOeneKs9esWMIeDDvcHhcryArTQ4LJs3+PSAUMpQlq5cPzgXchXQLhehl
 hzFkriftxhB/o/Wv9ZPFVyyjH2XEI1PIJngv+EM9qGGfCtSb1LOZ+/U7r9DHfsyIeMy5
 V94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725901763; x=1726506563;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SegbiJSmnDil053g2UPUp9MTFPVJTwv0Ljt9qH7sq+I=;
 b=GXeB+uOdnrkKVrAGkXctDB8/RbSHqaMuVpjOiAjuglwMl6knBBaoSSo3XXpsxTZ1fM
 U6Z3ZcUE3MiJd78eO/2tTknyvuuiPmuPCFpqaS+tHq55atlqo5O/XimP1iduxgK6+bYN
 kS8yqhiY+lS8Rxe6eutibNcDemcBaAOgtHF/FOYWXmEi8Rph4TnYLnjPc/2p2S8OHGwx
 U/7j13OigYO+hlD5w2zql+oFVKOIxWbxiBY76x30MezwdC+p2HErzMGi+aqv8JCzbcxP
 zGhgNMAHH+nwMCLCHiK+Sy0r4B4/GfrQflNI37LlRbUYQ+AtFDbZjG2vcJWrnNte43Zd
 QIvg==
X-Gm-Message-State: AOJu0Yx3Tfsubpzw4KatUd+ZsFg/EeYkqlJc3qzou8OJ3/fIHsxJdMWq
 JLrFjqGTF+NwCrqJkm3kDWlvZLswJBkFn7Zqu+NuhChLDM00zVKds++bJk6/ghnjhuI1O79GgtC
 3H6dKAvfhLILvJQyi54sjDNUmP8Vxv2u3
X-Google-Smtp-Source: AGHT+IEjRks3DhQShE62Bli1GXim0vXpPVCrv1BF2UUKeYQEBJc8VbF3zrUSiuOY7xULzezn7lznMzSRNcCSu7uyVq4=
X-Received: by 2002:a17:902:c9cc:b0:207:14b3:11a7 with SMTP id
 d9443c01a7336-20714b31b88mr33503485ad.14.1725901763169; Mon, 09 Sep 2024
 10:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240909095408.1683-1-jiadong.zhu@amd.com>
 <20240909095408.1683-2-jiadong.zhu@amd.com>
In-Reply-To: <20240909095408.1683-2-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 13:09:09 -0400
Message-ID: <CADnq5_N+Cq27LQmWmMixR+e92Rt0Mc9oXDmd6s47g0WsQ+7O1w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/sdma6: implement ring reset callback for
 sdma6
To: jiadong.zhu@amd.com
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Sep 9, 2024 at 5:54=E2=80=AFAM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Implement sdma queue reset callback using mes_reset_queue_mmio.
> Extract sdma resume sequence from sdma_v6_0_gfx_resume for queue restarti=
ng.

Might make more sense to split this patch in two.  One patch to split
out the per instance resume function, and one to implement the reset.

More comments below.

>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 266 +++++++++++++++----------
>  1 file changed, 157 insertions(+), 109 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 208a1fa9d4e7..d8865a60b788 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -469,14 +469,16 @@ static void sdma_v6_0_enable(struct amdgpu_device *=
adev, bool enable)
>  }
>
>  /**
> - * sdma_v6_0_gfx_resume - setup and start the async dma engines
> + * sdma_v6_0_gfx_resume_instance - start/restart a certain sdma engine
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
> -static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
> +static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int=
 i, bool restore)
>  {
>         struct amdgpu_ring *ring;
>         u32 rb_cntl, ib_cntl;
> @@ -485,132 +487,152 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_dev=
ice *adev)
>         u32 doorbell_offset;
>         u32 temp;
>         u64 wptr_gpu_addr;
> -       int i, r;
>
> -       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> -               ring =3D &adev->sdma.instance[i].ring;
> +       ring =3D &adev->sdma.instance[i].ring;
> +       if (!amdgpu_sriov_vf(adev))
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
>
> -               if (!amdgpu_sriov_vf(adev))
> -                       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev=
, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
> -
> -               /* Set ring buffer size in dwords */
> -               rb_bufsz =3D order_base_2(ring->ring_size / 4);
> -               rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(=
adev, i, regSDMA0_QUEUE0_RB_CNTL));
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, =
RB_SIZE, rb_bufsz);
> +       /* Set ring buffer size in dwords */
> +       rb_bufsz =3D order_base_2(ring->ring_size / 4);
> +       rb_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i,=
 regSDMA0_QUEUE0_RB_CNTL));
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SIZE,=
 rb_bufsz);
>  #ifdef __BIG_ENDIAN
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, =
RB_SWAP_ENABLE, 1);
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
> -                                       RPTR_WRITEBACK_SWAP_ENABLE, 1);
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_SWAP_=
ENABLE, 1);
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL,
> +                               RPTR_WRITEBACK_SWAP_ENABLE, 1);
>  #endif
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, =
RB_PRIV, 1);
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_CNTL), rb_cntl);
> -
> -               /* Initialize the ring buffer's read and write pointers *=
/
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_PRIV,=
 1);
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_CNTL), rb_cntl);
> +
> +       /* Initialize the ring buffer's read and write pointers */
> +       if (restore) {
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_RPTR), lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_RPTR_HI), upper_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr << 2));
> +       } else {
>                 WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_RPTR), 0);
>                 WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_RPTR_HI), 0);
>                 WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR), 0);
>                 WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR_HI), 0);
> +       }
> +       /* setup the wptr shadow polling */
> +       wptr_gpu_addr =3D ring->wptr_gpu_addr;
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_WPTR_POLL_ADDR_LO),
> +              lower_32_bits(wptr_gpu_addr));
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_WPTR_POLL_ADDR_HI),
> +              upper_32_bits(wptr_gpu_addr));
> +
> +       /* set the wb address whether it's enabled or not */
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_RPTR_ADDR_HI),
> +              upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_RPTR_ADDR_LO),
> +              lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
> +
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRI=
TEBACK_ENABLE, 1);
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POL=
L_ENABLE, 0);
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR=
_POLL_ENABLE, 1);
> +
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_BASE), ring->gpu_addr >> 8);
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_BASE_HI), ring->gpu_addr >> 40);
> +
> +       if (!restore)
> +               ring->wptr =3D 0;
>
> -               /* setup the wptr shadow polling */
> -               wptr_gpu_addr =3D ring->wptr_gpu_addr;
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR_POLL_ADDR_LO),
> -                      lower_32_bits(wptr_gpu_addr));
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR_POLL_ADDR_HI),
> -                      upper_32_bits(wptr_gpu_addr));
> -
> -               /* set the wb address whether it's enabled or not */
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_RPTR_ADDR_HI),
> -                      upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_RPTR_ADDR_LO),
> -                      lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
> +       /* before programing wptr to a less value, need set minor_ptr_upd=
ate first */
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_MINOR_PTR_UPDATE), 1);
>
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, =
RPTR_WRITEBACK_ENABLE, 1);
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, =
WPTR_POLL_ENABLE, 0);
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, =
F32_WPTR_POLL_ENABLE, 1);
> +       if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register wri=
te for wptr */
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
> +       }
>
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_BASE_HI), ring->gpu_addr >> 40);
> +       doorbell =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i=
, regSDMA0_QUEUE0_DOORBELL));
> +       doorbell_offset =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(=
adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
>
> -               ring->wptr =3D 0;
> -
> -               /* before programing wptr to a less value, need set minor=
_ptr_update first */
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_MINOR_PTR_UPDATE), 1);
> +       if (ring->use_doorbell) {
> +               doorbell =3D REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBEL=
L, ENABLE, 1);
> +               doorbell_offset =3D REG_SET_FIELD(doorbell_offset, SDMA0_=
QUEUE0_DOORBELL_OFFSET,
> +                               OFFSET, ring->doorbell_index);
> +       } else {
> +               doorbell =3D REG_SET_FIELD(doorbell, SDMA0_QUEUE0_DOORBEL=
L, ENABLE, 0);
> +       }
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_DOORBELL), doorbell);
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_DOORBELL_OFFSET), doorbell_offset);
>
> -               if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use regi=
ster write for wptr */
> -                       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev=
, i, regSDMA0_QUEUE0_RB_WPTR), lower_32_bits(ring->wptr) << 2);
> -                       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev=
, i, regSDMA0_QUEUE0_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
> -               }
> +       if (i =3D=3D 0)
> +               adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_=
doorbell,
> +                                             ring->doorbell_index,
> +                                             adev->doorbell_index.sdma_d=
oorbell_range * adev->sdma.num_instances);
>
> -               doorbell =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset=
(adev, i, regSDMA0_QUEUE0_DOORBELL));
> -               doorbell_offset =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg=
_offset(adev, i, regSDMA0_QUEUE0_DOORBELL_OFFSET));
> +       if (amdgpu_sriov_vf(adev))
> +               sdma_v6_0_ring_set_wptr(ring);
> +
> +       /* set minor_ptr_update to 0 after wptr programed */
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_MINOR_PTR_UPDATE), 0);
> +
> +       /* Set up sdma hang watchdog */
> +       temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, re=
gSDMA0_WATCHDOG_CNTL));
> +       /* 100ms per unit */
> +       temp =3D REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_HANG_COUN=
T,
> +                            max(adev->usec_timeout/100000, 1));
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_WA=
TCHDOG_CNTL), temp);
> +
> +       /* Set up RESP_MODE to non-copy addresses */
> +       temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, re=
gSDMA0_UTCL1_CNTL));
> +       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
> +       temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UT=
CL1_CNTL), temp);
> +
> +       /* program default cache read and write policy */
> +       temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, re=
gSDMA0_UTCL1_PAGE));
> +       /* clean read policy and write policy bits */
> +       temp &=3D 0xFF0FFF;
> +       temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
> +                (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
> +                SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_UT=
CL1_PAGE), temp);
>
> -               if (ring->use_doorbell) {
> -                       doorbell =3D REG_SET_FIELD(doorbell, SDMA0_QUEUE0=
_DOORBELL, ENABLE, 1);
> -                       doorbell_offset =3D REG_SET_FIELD(doorbell_offset=
, SDMA0_QUEUE0_DOORBELL_OFFSET,
> -                                       OFFSET, ring->doorbell_index);
> -               } else {
> -                       doorbell =3D REG_SET_FIELD(doorbell, SDMA0_QUEUE0=
_DOORBELL, ENABLE, 0);
> -               }
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_DOORBELL), doorbell);
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_DOORBELL_OFFSET), doorbell_offset);
> -
> -               if (i =3D=3D 0)
> -                       adev->nbio.funcs->sdma_doorbell_range(adev, i, ri=
ng->use_doorbell,
> -                                                     ring->doorbell_inde=
x,
> -                                                     adev->doorbell_inde=
x.sdma_doorbell_range * adev->sdma.num_instances);
> -
> -               if (amdgpu_sriov_vf(adev))
> -                       sdma_v6_0_ring_set_wptr(ring);
> -
> -               /* set minor_ptr_update to 0 after wptr programed */
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_MINOR_PTR_UPDATE), 0);
> -
> -               /* Set up sdma hang watchdog */
> -               temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(ade=
v, i, regSDMA0_WATCHDOG_CNTL));
> -               /* 100ms per unit */
> -               temp =3D REG_SET_FIELD(temp, SDMA0_WATCHDOG_CNTL, QUEUE_H=
ANG_COUNT,
> -                                    max(adev->usec_timeout/100000, 1));
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_WATCHDOG_CNTL), temp);
> -
> -               /* Set up RESP_MODE to non-copy addresses */
> -               temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(ade=
v, i, regSDMA0_UTCL1_CNTL));
> -               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE,=
 3);
> -               temp =3D REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY=
, 9);
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_UTCL1_CNTL), temp);
> -
> -               /* program default cache read and write policy */
> -               temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(ade=
v, i, regSDMA0_UTCL1_PAGE));
> -               /* clean read policy and write policy bits */
> -               temp &=3D 0xFF0FFF;
> -               temp |=3D ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
> -                        (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
> -                        SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_UTCL1_PAGE), temp);
> -
> -               if (!amdgpu_sriov_vf(adev)) {
> -                       /* unhalt engine */
> -                       temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_of=
fset(adev, i, regSDMA0_F32_CNTL));
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT=
, 0);
> -                       temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, TH1_=
RESET, 0);
> -                       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev=
, i, regSDMA0_F32_CNTL), temp);
> -               }
> +       if (!amdgpu_sriov_vf(adev)) {
> +               /* unhalt engine */
> +               temp =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(ade=
v, i, regSDMA0_F32_CNTL));
> +               temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
> +               temp =3D REG_SET_FIELD(temp, SDMA0_F32_CNTL, TH1_RESET, 0=
);
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_F32_CNTL), temp);
> +       }
>
> -               /* enable DMA RB */
> -               rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, =
RB_ENABLE, 1);
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_RB_CNTL), rb_cntl);
> +       /* enable DMA RB */
> +       rb_cntl =3D REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RB_ENABL=
E, 1);
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_RB_CNTL), rb_cntl);
>
> -               ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(=
adev, i, regSDMA0_QUEUE0_IB_CNTL));
> -               ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, =
IB_ENABLE, 1);
> +       ib_cntl =3D RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i,=
 regSDMA0_QUEUE0_IB_CNTL));
> +       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABL=
E, 1);
>  #ifdef __BIG_ENDIAN
> -               ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, =
IB_SWAP_ENABLE, 1);
> +       ib_cntl =3D REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_=
ENABLE, 1);
>  #endif
> -               /* enable DMA IBs */
> -               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, reg=
SDMA0_QUEUE0_IB_CNTL), ib_cntl);
> +       /* enable DMA IBs */
> +       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QU=
EUE0_IB_CNTL), ib_cntl);
> +
> +       if (amdgpu_sriov_vf(adev))
> +               sdma_v6_0_enable(adev, true);
>
> -               if (amdgpu_sriov_vf(adev))
> -                       sdma_v6_0_enable(adev, true);
> +       return amdgpu_ring_test_helper(ring);
> +}
>
> -               r =3D amdgpu_ring_test_helper(ring);
> +/**
> + * sdma_v6_0_gfx_resume - setup and start the async dma engines
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Set up the gfx DMA ring buffers and enable them.
> + * Returns 0 for success, error for failure.
> + */
> +static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
> +{
> +       int i, r;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               r =3D sdma_v6_0_gfx_resume_instance(adev, i, false);
>                 if (r)
>                         return r;
>         }
> @@ -1469,6 +1491,31 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu=
_ring *ring)
>         return r;
>  }
>
> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int =
vmid)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       int i, r;
> +
> +       if (amdgpu_sriov_vf(adev))
> +               return -EINVAL;
> +
> +       r =3D amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> +       if (r)
> +               return r;
> +
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               if (ring =3D=3D &adev->sdma.instance[i].ring)
> +                       break;
> +       }
> +
> +       if (i =3D=3D adev->sdma.num_instances) {
> +               DRM_ERROR("sdma instance not found\n");
> +               return -EINVAL;
> +       }

I'd suggest moving the instance checks to the top of the function
since it doesn't make any sense to call
amdgpu_mes_reset_legacy_queue() in that case either.

Alex

> +
> +       return sdma_v6_0_gfx_resume_instance(adev, i, true);
> +}
> +
>  static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
>                                         struct amdgpu_irq_src *source,
>                                         unsigned type,
> @@ -1652,6 +1699,7 @@ static const struct amdgpu_ring_funcs sdma_v6_0_rin=
g_funcs =3D {
>         .emit_reg_write_reg_wait =3D sdma_v6_0_ring_emit_reg_write_reg_wa=
it,
>         .init_cond_exec =3D sdma_v6_0_ring_init_cond_exec,
>         .preempt_ib =3D sdma_v6_0_ring_preempt_ib,
> +       .reset =3D sdma_v6_0_reset_queue,
>  };
>
>  static void sdma_v6_0_set_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
