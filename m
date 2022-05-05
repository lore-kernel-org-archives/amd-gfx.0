Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E97C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 15:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD4810E544;
	Thu,  5 May 2022 15:02:44 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D83AE10E536
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 15:02:42 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-e93bbb54f9so4441312fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 May 2022 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=z9s03dD5PP/Wi90GFeSdvgurwLV0LCmCse8aLymRRvQ=;
 b=XDVXO/0vP83cBZqCJafcrSUcpPagU2NRZfd8LvryYPuf7PnvWoz8Llzdb5H3m6uX79
 SqBo3RXw7fIBnEoDLk2lCt5Jn+vxhop7/mLNkWI+3Wwqxd4KwYMLx7w/OyMyH17eNYAm
 Jmpve9dHP0gN50FTNcjRK7HntH5ul0ggsNG51+BCZ65iFZdGbVTZ8sYti7zXPHwMaAgf
 S4eW0//R5XbR9SRrBaWh6yCKUCtumgEdF7oqG4TYlUJ7kF7MvAgbolnGrL4UF78Mbww7
 egZ6s9m+BrzDs+ivI3A7yaUphuWR3o23jd/rdRxiIuSqAKPW7FVPJJ1u7/+MEiO3KyTA
 WMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=z9s03dD5PP/Wi90GFeSdvgurwLV0LCmCse8aLymRRvQ=;
 b=rrJf3fY17hoX6IkkYd5YI7Tkk4vcfOyzHkxk58jQ5HcKNPf2oFSZCxCOfi635cxbPc
 EqHYTUXrQwDWwPf4jzKE68umzUNhlvUE17qHIzGizRbdd9wD1tX3x3mOJ6TR8em0z+kO
 n26JOiN7Ag6d8TGmZYDy1JtatwrtM3usHsbgzPWtrskpfvujLT0Z3J7qT9eK239RfKB4
 sxyO9DJGzK3hV+zlUeOqEChS05ssNECYa8fcLStHIvnaD+8IZ96UZLuwWEyKQVpbf04b
 JajGzyV0BeNt9G3U8Eg4t1DMnvuVaxFXUXlvTp8J6+lAYMAO7h/B5mermWgc44xS8q87
 aaEQ==
X-Gm-Message-State: AOAM5313+MUPkEgshGvjF/B/v8Y6md3FHU3C1gCdo3gvToRTsCQ8dC4O
 ijtvs4+E6E0zsUGY/NyW7bzQA4xM0J9ElmsFabA=
X-Google-Smtp-Source: ABdhPJzI/Y+IwdEcl1VLGxXAtQ6v3JJYDCUv98pFZ3GxXupRht/h9wl9zOmjkmMuQAGjz+wd8ljBDz/8N7RDmcWfK7E=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr2481839oap.253.1651762961683; Thu, 05
 May 2022 08:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220505090619.171744-1-christian.koenig@amd.com>
In-Reply-To: <20220505090619.171744-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 May 2022 11:02:30 -0400
Message-ID: <CADnq5_N-A2x55wcwx8diGeZ0pNod4q09RNrQ0yqc4ddq-rgANw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: nuke dynamic gfx scratch reg allocation
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Lang Yu <Lang.Yu@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 5, 2022 at 5:06 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> It's over a decade ago that this was actually used for more than ring and
> IB tests. Just use the static register directly where needed and nuke the
> now useless infrastructure.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 36 --------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 13 -----
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 27 ++---------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 25 ++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c   | 54 ++++++---------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 64 +++++--------------------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 24 ++--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 26 ++--------
>  8 files changed, 43 insertions(+), 226 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 5d6b04fc6206..ede2fa56f6c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -98,42 +98,6 @@ bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_devi=
ce *adev,
>                         adev->gfx.me.queue_bitmap);
>  }
>
> -/**
> - * amdgpu_gfx_scratch_get - Allocate a scratch register
> - *
> - * @adev: amdgpu_device pointer
> - * @reg: scratch register mmio offset
> - *
> - * Allocate a CP scratch register for use by the driver (all asics).
> - * Returns 0 on success or -EINVAL on failure.
> - */
> -int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg)
> -{
> -       int i;
> -
> -       i =3D ffs(adev->gfx.scratch.free_mask);
> -       if (i !=3D 0 && i <=3D adev->gfx.scratch.num_reg) {
> -               i--;
> -               adev->gfx.scratch.free_mask &=3D ~(1u << i);
> -               *reg =3D adev->gfx.scratch.reg_base + i;
> -               return 0;
> -       }
> -       return -EINVAL;
> -}
> -
> -/**
> - * amdgpu_gfx_scratch_free - Free a scratch register
> - *
> - * @adev: amdgpu_device pointer
> - * @reg: scratch register mmio offset
> - *
> - * Free a CP scratch register allocated for use by the driver (all asics=
)
> - */
> -void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg)
> -{
> -       adev->gfx.scratch.free_mask |=3D 1u << (reg - adev->gfx.scratch.r=
eg_base);
> -}
> -
>  /**
>   * amdgpu_gfx_parse_disable_cu - Parse the disable_cu module parameter
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 45522609d4b4..53526ffb2ce1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -110,15 +110,6 @@ struct amdgpu_kiq {
>         const struct kiq_pm4_funcs *pmf;
>  };
>
> -/*
> - * GPU scratch registers structures, functions & helpers
> - */
> -struct amdgpu_scratch {
> -       unsigned                num_reg;
> -       uint32_t                reg_base;
> -       uint32_t                free_mask;
> -};
> -
>  /*
>   * GFX configurations
>   */
> @@ -288,7 +279,6 @@ struct amdgpu_gfx {
>         struct amdgpu_mec               mec;
>         struct amdgpu_kiq               kiq;
>         struct amdgpu_imu               imu;
> -       struct amdgpu_scratch           scratch;
>         bool                            rs64_enable; /* firmware format *=
/
>         const struct firmware           *me_fw; /* ME firmware */
>         uint32_t                        me_fw_version;
> @@ -376,9 +366,6 @@ static inline u32 amdgpu_gfx_create_bitmask(u32 bit_w=
idth)
>         return (u32)((1ULL << bit_width) - 1);
>  }
>
> -int amdgpu_gfx_scratch_get(struct amdgpu_device *adev, uint32_t *reg);
> -void amdgpu_gfx_scratch_free(struct amdgpu_device *adev, uint32_t reg);
> -
>  void amdgpu_gfx_parse_disable_cu(unsigned *mask, unsigned max_se,
>                                  unsigned max_sh);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index 64d36622ee23..4b66b9c93754 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3744,13 +3744,6 @@ static void gfx_v10_0_init_golden_registers(struct=
 amdgpu_device *adev)
>         gfx_v10_0_init_spm_golden_registers(adev);
>  }
>
> -static void gfx_v10_0_scratch_init(struct amdgpu_device *adev)
> -{
> -       adev->gfx.scratch.num_reg =3D 8;
> -       adev->gfx.scratch.reg_base =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH_=
REG0);
> -       adev->gfx.scratch.free_mask =3D (1u << adev->gfx.scratch.num_reg)=
 - 1;
> -}
> -
>  static void gfx_v10_0_write_data_to_reg(struct amdgpu_ring *ring, int en=
g_sel,
>                                        bool wc, uint32_t reg, uint32_t va=
l)
>  {
> @@ -3787,34 +3780,26 @@ static void gfx_v10_0_wait_reg_mem(struct amdgpu_=
ring *ring, int eng_sel,
>  static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t scratch;
>         uint32_t tmp =3D 0;
>         unsigned i;
>         int r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r) {
> -               DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n",=
 r);
> -               return r;
> -       }
> -
> -       WREG32(scratch, 0xCAFEDEAD);
> -
> +       WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
>         r =3D amdgpu_ring_alloc(ring, 3);
>         if (r) {
>                 DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
>                           ring->idx, r);
> -               amdgpu_gfx_scratch_free(adev, scratch);
>                 return r;
>         }
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -       amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START)=
);
> +       amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
> +                         PACKET3_SET_UCONFIG_REG_START);
>         amdgpu_ring_write(ring, 0xDEADBEEF);
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32(scratch);
> +               tmp =3D RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 if (amdgpu_emu_mode =3D=3D 1)
> @@ -3826,8 +3811,6 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_r=
ing *ring)
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
>
> -       amdgpu_gfx_scratch_free(adev, scratch);
> -
>         return r;
>  }
>
> @@ -4852,8 +4835,6 @@ static int gfx_v10_0_sw_init(void *handle)
>
>         adev->gfx.gfx_current_status =3D AMDGPU_GFX_NORMAL_MODE;
>
> -       gfx_v10_0_scratch_init(adev);
> -
>         r =3D gfx_v10_0_me_init(adev);
>         if (r)
>                 return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index f0f13eeb4b71..7bf09eeaced0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -297,13 +297,6 @@ static void gfx_v11_0_init_golden_registers(struct a=
mdgpu_device *adev)
>         gfx_v11_0_init_spm_golden_registers(adev);
>  }
>
> -static void gfx_v11_0_scratch_init(struct amdgpu_device *adev)
> -{
> -       adev->gfx.scratch.num_reg =3D 8;
> -       adev->gfx.scratch.reg_base =3D SOC15_REG_OFFSET(GC, 0, regSCRATCH=
_REG0);
> -       adev->gfx.scratch.free_mask =3D (1u << adev->gfx.scratch.num_reg)=
 - 1;
> -}
> -
>  static void gfx_v11_0_write_data_to_reg(struct amdgpu_ring *ring, int en=
g_sel,
>                                        bool wc, uint32_t reg, uint32_t va=
l)
>  {
> @@ -340,24 +333,16 @@ static void gfx_v11_0_wait_reg_mem(struct amdgpu_ri=
ng *ring, int eng_sel,
>  static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t scratch;
> +       uint32_t scratch =3D SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
>         uint32_t tmp =3D 0;
>         unsigned i;
>         int r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r) {
> -               DRM_ERROR("amdgpu: cp failed to get scratch reg (%d).\n",=
 r);
> -               return r;
> -       }
> -
>         WREG32(scratch, 0xCAFEDEAD);
> -
>         r =3D amdgpu_ring_alloc(ring, 5);
>         if (r) {
>                 DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
>                           ring->idx, r);
> -               amdgpu_gfx_scratch_free(adev, scratch);
>                 return r;
>         }
>
> @@ -365,7 +350,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>                 gfx_v11_0_ring_emit_wreg(ring, scratch, 0xDEADBEEF);
>         } else {
>                 amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, =
1));
> -               amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_RE=
G_START));
> +               amdgpu_ring_write(ring, scratch -
> +                                 PACKET3_SET_UCONFIG_REG_START);
>                 amdgpu_ring_write(ring, 0xDEADBEEF);
>         }
>         amdgpu_ring_commit(ring);
> @@ -382,9 +368,6 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_rin=
g *ring)
>
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
> -
> -       amdgpu_gfx_scratch_free(adev, scratch);
> -
>         return r;
>  }
>
> @@ -1631,8 +1614,6 @@ static int gfx_v11_0_sw_init(void *handle)
>
>         adev->gfx.gfx_current_status =3D AMDGPU_GFX_NORMAL_MODE;
>
> -       gfx_v11_0_scratch_init(adev);
> -
>         if (adev->gfx.imu.funcs) {
>                 if (adev->gfx.imu.funcs->init_microcode) {
>                         r =3D adev->gfx.imu.funcs->init_microcode(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 29a91b320d4f..204b246f0e3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1778,39 +1778,26 @@ static void gfx_v6_0_constants_init(struct amdgpu=
_device *adev)
>         udelay(50);
>  }
>
> -
> -static void gfx_v6_0_scratch_init(struct amdgpu_device *adev)
> -{
> -       adev->gfx.scratch.num_reg =3D 8;
> -       adev->gfx.scratch.reg_base =3D mmSCRATCH_REG0;
> -       adev->gfx.scratch.free_mask =3D (1u << adev->gfx.scratch.num_reg)=
 - 1;
> -}
> -
>  static int gfx_v6_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t scratch;
>         uint32_t tmp =3D 0;
>         unsigned i;
>         int r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r)
> -               return r;
> -
> -       WREG32(scratch, 0xCAFEDEAD);
> +       WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>
>         r =3D amdgpu_ring_alloc(ring, 3);
>         if (r)
> -               goto error_free_scratch;
> +               return r;
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONFIG_REG, 1));
> -       amdgpu_ring_write(ring, (scratch - PACKET3_SET_CONFIG_REG_START))=
;
> +       amdgpu_ring_write(ring, mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_S=
TART);
>         amdgpu_ring_write(ring, 0xDEADBEEF);
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32(scratch);
> +               tmp =3D RREG32(mmSCRATCH_REG0);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 udelay(1);
> @@ -1818,9 +1805,6 @@ static int gfx_v6_0_ring_test_ring(struct amdgpu_ri=
ng *ring)
>
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
> -
> -error_free_scratch:
> -       amdgpu_gfx_scratch_free(adev, scratch);
>         return r;
>  }
>
> @@ -1903,50 +1887,42 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_r=
ing *ring,
>  static int gfx_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       struct amdgpu_ib ib;
>         struct dma_fence *f =3D NULL;
> -       uint32_t scratch;
> +       struct amdgpu_ib ib;
>         uint32_t tmp =3D 0;
>         long r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r)
> -               return r;
> -
> -       WREG32(scratch, 0xCAFEDEAD);
> +       WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>         memset(&ib, 0, sizeof(ib));
> -       r =3D amdgpu_ib_get(adev, NULL, 256,
> -                                       AMDGPU_IB_POOL_DIRECT, &ib);
> +       r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>         if (r)
> -               goto err1;
> +               return r;
>
>         ib.ptr[0] =3D PACKET3(PACKET3_SET_CONFIG_REG, 1);
> -       ib.ptr[1] =3D ((scratch - PACKET3_SET_CONFIG_REG_START));
> +       ib.ptr[1] =3D mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
>         ib.ptr[2] =3D 0xDEADBEEF;
>         ib.length_dw =3D 3;
>
>         r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
>         if (r)
> -               goto err2;
> +               goto error;
>
>         r =3D dma_fence_wait_timeout(f, false, timeout);
>         if (r =3D=3D 0) {
>                 r =3D -ETIMEDOUT;
> -               goto err2;
> +               goto error;
>         } else if (r < 0) {
> -               goto err2;
> +               goto error;
>         }
> -       tmp =3D RREG32(scratch);
> +       tmp =3D RREG32(mmSCRATCH_REG0);
>         if (tmp =3D=3D 0xDEADBEEF)
>                 r =3D 0;
>         else
>                 r =3D -EINVAL;
>
> -err2:
> +error:
>         amdgpu_ib_free(adev, &ib, NULL);
>         dma_fence_put(f);
> -err1:
> -       amdgpu_gfx_scratch_free(adev, scratch);
>         return r;
>  }
>
> @@ -3094,8 +3070,6 @@ static int gfx_v6_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       gfx_v6_0_scratch_init(adev);
> -
>         r =3D gfx_v6_0_init_microcode(adev);
>         if (r) {
>                 DRM_ERROR("Failed to load gfx firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index ac3f2dbba726..0f2976507e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2049,26 +2049,6 @@ static void gfx_v7_0_constants_init(struct amdgpu_=
device *adev)
>         udelay(50);
>  }
>
> -/*
> - * GPU scratch registers helpers function.
> - */
> -/**
> - * gfx_v7_0_scratch_init - setup driver info for CP scratch regs
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Set up the number and offset of the CP scratch registers.
> - * NOTE: use of CP scratch registers is a legacy interface and
> - * is not used by default on newer asics (r6xx+).  On newer asics,
> - * memory buffers are used for fences rather than scratch regs.
> - */
> -static void gfx_v7_0_scratch_init(struct amdgpu_device *adev)
> -{
> -       adev->gfx.scratch.num_reg =3D 8;
> -       adev->gfx.scratch.reg_base =3D mmSCRATCH_REG0;
> -       adev->gfx.scratch.free_mask =3D (1u << adev->gfx.scratch.num_reg)=
 - 1;
> -}
> -
>  /**
>   * gfx_v7_0_ring_test_ring - basic gfx ring test
>   *
> @@ -2082,36 +2062,28 @@ static void gfx_v7_0_scratch_init(struct amdgpu_d=
evice *adev)
>  static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t scratch;
>         uint32_t tmp =3D 0;
>         unsigned i;
>         int r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r)
> -               return r;
> -
> -       WREG32(scratch, 0xCAFEDEAD);
> +       WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>         r =3D amdgpu_ring_alloc(ring, 3);
>         if (r)
> -               goto error_free_scratch;
> +               return r;
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -       amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START)=
);
> +       amdgpu_ring_write(ring, mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_=
START);
>         amdgpu_ring_write(ring, 0xDEADBEEF);
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32(scratch);
> +               tmp =3D RREG32(mmSCRATCH_REG0);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 udelay(1);
>         }
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
> -
> -error_free_scratch:
> -       amdgpu_gfx_scratch_free(adev, scratch);
>         return r;
>  }
>
> @@ -2355,48 +2327,40 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
>         struct amdgpu_device *adev =3D ring->adev;
>         struct amdgpu_ib ib;
>         struct dma_fence *f =3D NULL;
> -       uint32_t scratch;
>         uint32_t tmp =3D 0;
>         long r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r)
> -               return r;
> -
> -       WREG32(scratch, 0xCAFEDEAD);
> +       WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>         memset(&ib, 0, sizeof(ib));
> -       r =3D amdgpu_ib_get(adev, NULL, 256,
> -                                       AMDGPU_IB_POOL_DIRECT, &ib);
> +       r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
>         if (r)
> -               goto err1;
> +               return r;
>
>         ib.ptr[0] =3D PACKET3(PACKET3_SET_UCONFIG_REG, 1);
> -       ib.ptr[1] =3D ((scratch - PACKET3_SET_UCONFIG_REG_START));
> +       ib.ptr[1] =3D mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
>         ib.ptr[2] =3D 0xDEADBEEF;
>         ib.length_dw =3D 3;
>
>         r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
>         if (r)
> -               goto err2;
> +               goto error;
>
>         r =3D dma_fence_wait_timeout(f, false, timeout);
>         if (r =3D=3D 0) {
>                 r =3D -ETIMEDOUT;
> -               goto err2;
> +               goto error;
>         } else if (r < 0) {
> -               goto err2;
> +               goto error;
>         }
> -       tmp =3D RREG32(scratch);
> +       tmp =3D RREG32(mmSCRATCH_REG0);
>         if (tmp =3D=3D 0xDEADBEEF)
>                 r =3D 0;
>         else
>                 r =3D -EINVAL;
>
> -err2:
> +error:
>         amdgpu_ib_free(adev, &ib, NULL);
>         dma_fence_put(f);
> -err1:
> -       amdgpu_gfx_scratch_free(adev, scratch);
>         return r;
>  }
>
> @@ -4489,8 +4453,6 @@ static int gfx_v7_0_sw_init(void *handle)
>         if (r)
>                 return r;
>
> -       gfx_v7_0_scratch_init(adev);
> -
>         r =3D gfx_v7_0_init_microcode(adev);
>         if (r) {
>                 DRM_ERROR("Failed to load gfx firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index e4e779a19c20..90f64219d291 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -835,37 +835,25 @@ static void gfx_v8_0_init_golden_registers(struct a=
mdgpu_device *adev)
>         }
>  }
>
> -static void gfx_v8_0_scratch_init(struct amdgpu_device *adev)
> -{
> -       adev->gfx.scratch.num_reg =3D 8;
> -       adev->gfx.scratch.reg_base =3D mmSCRATCH_REG0;
> -       adev->gfx.scratch.free_mask =3D (1u << adev->gfx.scratch.num_reg)=
 - 1;
> -}
> -
>  static int gfx_v8_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t scratch;
>         uint32_t tmp =3D 0;
>         unsigned i;
>         int r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r)
> -               return r;
> -
> -       WREG32(scratch, 0xCAFEDEAD);
> +       WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
>         r =3D amdgpu_ring_alloc(ring, 3);
>         if (r)
> -               goto error_free_scratch;
> +               return r;
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -       amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START)=
);
> +       amdgpu_ring_write(ring, mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_=
START);
>         amdgpu_ring_write(ring, 0xDEADBEEF);
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32(scratch);
> +               tmp =3D RREG32(mmSCRATCH_REG0);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 udelay(1);
> @@ -874,8 +862,6 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ring=
 *ring)
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
>
> -error_free_scratch:
> -       amdgpu_gfx_scratch_free(adev, scratch);
>         return r;
>  }
>
> @@ -2000,8 +1986,6 @@ static int gfx_v8_0_sw_init(void *handle)
>
>         adev->gfx.gfx_current_status =3D AMDGPU_GFX_NORMAL_MODE;
>
> -       gfx_v8_0_scratch_init(adev);
> -
>         r =3D gfx_v8_0_init_microcode(adev);
>         if (r) {
>                 DRM_ERROR("Failed to load gfx firmware!\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 06182b7e4351..83639b5ea6a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -950,13 +950,6 @@ static void gfx_v9_0_init_golden_registers(struct am=
dgpu_device *adev)
>                                                 (const u32)ARRAY_SIZE(gol=
den_settings_gc_9_x_common));
>  }
>
> -static void gfx_v9_0_scratch_init(struct amdgpu_device *adev)
> -{
> -       adev->gfx.scratch.num_reg =3D 8;
> -       adev->gfx.scratch.reg_base =3D SOC15_REG_OFFSET(GC, 0, mmSCRATCH_=
REG0);
> -       adev->gfx.scratch.free_mask =3D (1u << adev->gfx.scratch.num_reg)=
 - 1;
> -}
> -
>  static void gfx_v9_0_write_data_to_reg(struct amdgpu_ring *ring, int eng=
_sel,
>                                        bool wc, uint32_t reg, uint32_t va=
l)
>  {
> @@ -994,27 +987,23 @@ static void gfx_v9_0_wait_reg_mem(struct amdgpu_rin=
g *ring, int eng_sel,
>  static int gfx_v9_0_ring_test_ring(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t scratch;
>         uint32_t tmp =3D 0;
>         unsigned i;
>         int r;
>
> -       r =3D amdgpu_gfx_scratch_get(adev, &scratch);
> -       if (r)
> -               return r;
> -
> -       WREG32(scratch, 0xCAFEDEAD);
> +       WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
>         r =3D amdgpu_ring_alloc(ring, 3);
>         if (r)
> -               goto error_free_scratch;
> +               return r;
>
>         amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
> -       amdgpu_ring_write(ring, (scratch - PACKET3_SET_UCONFIG_REG_START)=
);
> +       amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0) -
> +                         PACKET3_SET_UCONFIG_REG_START);
>         amdgpu_ring_write(ring, 0xDEADBEEF);
>         amdgpu_ring_commit(ring);
>
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32(scratch);
> +               tmp =3D RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
>                 if (tmp =3D=3D 0xDEADBEEF)
>                         break;
>                 udelay(1);
> @@ -1022,9 +1011,6 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_ri=
ng *ring)
>
>         if (i >=3D adev->usec_timeout)
>                 r =3D -ETIMEDOUT;
> -
> -error_free_scratch:
> -       amdgpu_gfx_scratch_free(adev, scratch);
>         return r;
>  }
>
> @@ -2338,8 +2324,6 @@ static int gfx_v9_0_sw_init(void *handle)
>
>         adev->gfx.gfx_current_status =3D AMDGPU_GFX_NORMAL_MODE;
>
> -       gfx_v9_0_scratch_init(adev);
> -
>         r =3D gfx_v9_0_init_microcode(adev);
>         if (r) {
>                 DRM_ERROR("Failed to load gfx firmware!\n");
> --
> 2.25.1
>
