Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE0ECDB482
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 13:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFD5910E0CF;
	Fri, 13 Oct 2023 13:53:05 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB11710E0CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 13:53:03 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1e9ac336589so1228924fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697205183; x=1697809983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZl/PCGBllYV4qs5uI0KhND9lxsExgr5gz5t31m7IuI=;
 b=HpSR3+6fk3o59ZiiahTqII57brDoZ2b860X05CdKpKnSzTxhAHNfoLyCWIBge6RuBk
 OCLpNuPccPJhdvhbMy+V0Qaden5t0fSlHRLICcJ2G/SDtOH+5Mrwde2tDmJse34zkEXC
 fSqEQ9uo22a+aU+GPNszpLB46eYkojJ2txxFGNl9o26LcGEfle3bG0shnadSbrSxkmPq
 pn3V+FlHpa8LPNAVwdmlepwTU0ofI+w7YYDYzlqXU/QyuThXv99lG7HpMCn79qnl/Z3k
 hQQOQ4O4EJIeSYK6IiweWOV+5PLuMKymHAnqsP9JEumjv4tZju6kooEm1DvFty9OVxZy
 mQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697205183; x=1697809983;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FZl/PCGBllYV4qs5uI0KhND9lxsExgr5gz5t31m7IuI=;
 b=oYyBIfXT7jbORBKJ7dhjA8fpUR4M0OhdjnF5vdSFs+sDDkmujskfYRrfzaPBfUHZ77
 d73Y3KxLHLPGk6hXDX/H32zwGQFSIFweIY45zaoUgGU2rry/JT7x77lHT6AxijSpReqK
 zsQym1AH8ds4RGBcOT+++hJWslzbbnMjApWU0rSG1On53az7QjrwIqzwvNS+yuO3wk/f
 YXx1LU9dr+mw68rq6BYsrfBPxauZs/ZsXMcZ/9MVEqI4q5BRoYtOYlvC7ygzUiOILEik
 FD7sJoLu6ULCZNwT/cVwl/7G+G7UGQhk2IqjMlLuoteCYixlankkevYEhj5+Pvmxa1hF
 +GZQ==
X-Gm-Message-State: AOJu0Yx91fVDJq2641hxfsrsg1+PTkNoT2xnR+XEYxorCBao9k1ccsTm
 lfMS4EwNKEent6obzq/u1oQqRtAog++xf+4kNXDizMZ/
X-Google-Smtp-Source: AGHT+IFEpoCpIchPFUQl2JVAjOkyKRmab/a2kRx/wU+AZfbnKKHkc0IW0VozE0Xpq7m6rxwQDBm4z7pbk2LpvA0pums=
X-Received: by 2002:a05:6870:d908:b0:1e9:c2b7:2c99 with SMTP id
 gq8-20020a056870d90800b001e9c2b72c99mr4443421oab.33.1697205182943; Fri, 13
 Oct 2023 06:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231011182647.2599981-1-alexander.deucher@amd.com>
In-Reply-To: <20231011182647.2599981-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Oct 2023 09:52:51 -0400
Message-ID: <CADnq5_MVcVWn3NZ21yynMN_Bk606UAxzwQhd0mPgvvu_FBv9Mg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/mes11: remove aggregated doorbell code
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Wed, Oct 11, 2023 at 2:27=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> It's not enabled in hardware so the code is dead.
> Remove it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 86 +++++---------------------
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 56 -----------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 83 ++++++++-----------------
>  3 files changed, 40 insertions(+), 185 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 27b224b0688a..91c07ab4f14e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5170,45 +5170,17 @@ static u64 gfx_v11_0_ring_get_wptr_gfx(struct amd=
gpu_ring *ring)
>  static void gfx_v11_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t *wptr_saved;
> -       uint32_t *is_queue_unmap;
> -       uint64_t aggregated_db_index;
> -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_GFX].mqd_size;
> -       uint64_t wptr_tmp;
>
> -       if (ring->is_mes_queue) {
> -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size =
+
> -                                             sizeof(uint32_t));
> -               aggregated_db_index =3D
> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> -                                                                ring->hw=
_prio);
> -
> -               wptr_tmp =3D ring->wptr & ring->buf_mask;
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp)=
;
> -               *wptr_saved =3D wptr_tmp;
> -               /* assume doorbell always being used by mes mapped queue =
*/
> -               if (*is_queue_unmap) {
> -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -               } else {
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -
> -                       if (*is_queue_unmap)
> -                               WDOORBELL64(aggregated_db_index, wptr_tmp=
);
> -               }
> +       if (ring->use_doorbell) {
> +               /* XXX check if swapping is necessary on BE */
> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> +                            ring->wptr);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr);
>         } else {
> -               if (ring->use_doorbell) {
> -                       /* XXX check if swapping is necessary on BE */
> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                                    ring->wptr);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
> -               } else {
> -                       WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
> -                                    lower_32_bits(ring->wptr));
> -                       WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
> -                                    upper_32_bits(ring->wptr));
> -               }
> +               WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
> +                            lower_32_bits(ring->wptr));
> +               WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
> +                            upper_32_bits(ring->wptr));
>         }
>  }
>
> @@ -5233,42 +5205,14 @@ static u64 gfx_v11_0_ring_get_wptr_compute(struct=
 amdgpu_ring *ring)
>  static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t *wptr_saved;
> -       uint32_t *is_queue_unmap;
> -       uint64_t aggregated_db_index;
> -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size;
> -       uint64_t wptr_tmp;
>
> -       if (ring->is_mes_queue) {
> -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size =
+
> -                                             sizeof(uint32_t));
> -               aggregated_db_index =3D
> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> -                                                                ring->hw=
_prio);
> -
> -               wptr_tmp =3D ring->wptr & ring->buf_mask;
> -               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, wptr_tmp)=
;
> -               *wptr_saved =3D wptr_tmp;
> -               /* assume doorbell always used by mes mapped queue */
> -               if (*is_queue_unmap) {
> -                       WDOORBELL64(aggregated_db_index, wptr_tmp);
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -               } else {
> -                       WDOORBELL64(ring->doorbell_index, wptr_tmp);
> -
> -                       if (*is_queue_unmap)
> -                               WDOORBELL64(aggregated_db_index, wptr_tmp=
);
> -               }
> +       /* XXX check if swapping is necessary on BE */
> +       if (ring->use_doorbell) {
> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> +                            ring->wptr);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr);
>         } else {
> -               /* XXX check if swapping is necessary on BE */
> -               if (ring->use_doorbell) {
> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                                    ring->wptr);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr);
> -               } else {
> -                       BUG(); /* only DOORBELL method supported on gfx11=
 now */
> -               }
> +               BUG(); /* only DOORBELL method supported on gfx11 now */
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 31b26e6f0b30..4dfec56e1b7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -414,60 +414,6 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_=
mes *mes)
>                         offsetof(union MESAPI_SET_HW_RESOURCES, api_statu=
s));
>  }
>
> -static void mes_v11_0_init_aggregated_doorbell(struct amdgpu_mes *mes)
> -{
> -       struct amdgpu_device *adev =3D mes->adev;
> -       uint32_t data;
> -
> -       data =3D RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1);
> -       data &=3D ~(CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET_MASK |
> -                 CP_MES_DOORBELL_CONTROL1__DOORBELL_EN_MASK |
> -                 CP_MES_DOORBELL_CONTROL1__DOORBELL_HIT_MASK);
> -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_LOW=
] <<
> -               CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET__SHIFT;
> -       data |=3D 1 << CP_MES_DOORBELL_CONTROL1__DOORBELL_EN__SHIFT;
> -       WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1, data);
> -
> -       data =3D RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2);
> -       data &=3D ~(CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET_MASK |
> -                 CP_MES_DOORBELL_CONTROL2__DOORBELL_EN_MASK |
> -                 CP_MES_DOORBELL_CONTROL2__DOORBELL_HIT_MASK);
> -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NOR=
MAL] <<
> -               CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET__SHIFT;
> -       data |=3D 1 << CP_MES_DOORBELL_CONTROL2__DOORBELL_EN__SHIFT;
> -       WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2, data);
> -
> -       data =3D RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3);
> -       data &=3D ~(CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET_MASK |
> -                 CP_MES_DOORBELL_CONTROL3__DOORBELL_EN_MASK |
> -                 CP_MES_DOORBELL_CONTROL3__DOORBELL_HIT_MASK);
> -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_MED=
IUM] <<
> -               CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET__SHIFT;
> -       data |=3D 1 << CP_MES_DOORBELL_CONTROL3__DOORBELL_EN__SHIFT;
> -       WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3, data);
> -
> -       data =3D RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4);
> -       data &=3D ~(CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET_MASK |
> -                 CP_MES_DOORBELL_CONTROL4__DOORBELL_EN_MASK |
> -                 CP_MES_DOORBELL_CONTROL4__DOORBELL_HIT_MASK);
> -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_HIG=
H] <<
> -               CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET__SHIFT;
> -       data |=3D 1 << CP_MES_DOORBELL_CONTROL4__DOORBELL_EN__SHIFT;
> -       WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4, data);
> -
> -       data =3D RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5);
> -       data &=3D ~(CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET_MASK |
> -                 CP_MES_DOORBELL_CONTROL5__DOORBELL_EN_MASK |
> -                 CP_MES_DOORBELL_CONTROL5__DOORBELL_HIT_MASK);
> -       data |=3D mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_REA=
LTIME] <<
> -               CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET__SHIFT;
> -       data |=3D 1 << CP_MES_DOORBELL_CONTROL5__DOORBELL_EN__SHIFT;
> -       WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5, data);
> -
> -       data =3D 1 << CP_HQD_GFX_CONTROL__DB_UPDATED_MSG_EN__SHIFT;
> -       WREG32_SOC15(GC, 0, regCP_HQD_GFX_CONTROL, data);
> -}
> -
>  static const struct amdgpu_mes_funcs mes_v11_0_funcs =3D {
>         .add_hw_queue =3D mes_v11_0_add_hw_queue,
>         .remove_hw_queue =3D mes_v11_0_remove_hw_queue,
> @@ -1243,8 +1189,6 @@ static int mes_v11_0_hw_init(void *handle)
>         if (r)
>                 goto failure;
>
> -       mes_v11_0_init_aggregated_doorbell(&adev->mes);
> -
>         r =3D mes_v11_0_query_sched_status(&adev->mes);
>         if (r) {
>                 DRM_ERROR("MES is busy\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 1f8122fd1ad7..7e4d5188cbfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -156,68 +156,35 @@ static uint64_t sdma_v6_0_ring_get_wptr(struct amdg=
pu_ring *ring)
>  static void sdma_v6_0_ring_set_wptr(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t *wptr_saved;
> -       uint32_t *is_queue_unmap;
> -       uint64_t aggregated_db_index;
> -       uint32_t mqd_size =3D adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
> -
> -       DRM_DEBUG("Setting write pointer\n");
> -
> -       if (ring->is_mes_queue) {
> -               wptr_saved =3D (uint32_t *)(ring->mqd_ptr + mqd_size);
> -               is_queue_unmap =3D (uint32_t *)(ring->mqd_ptr + mqd_size =
+
> -                                             sizeof(uint32_t));
> -               aggregated_db_index =3D
> -                       amdgpu_mes_get_aggregated_doorbell_index(adev,
> -                                                        ring->hw_prio);
>
> +       if (ring->use_doorbell) {
> +               DRM_DEBUG("Using doorbell -- "
> +                         "wptr_offs =3D=3D 0x%08x "
> +                         "lower_32_bits(ring->wptr) << 2 =3D=3D 0x%08x "
> +                         "upper_32_bits(ring->wptr) << 2 =3D=3D 0x%08x\n=
",
> +                         ring->wptr_offs,
> +                         lower_32_bits(ring->wptr << 2),
> +                         upper_32_bits(ring->wptr << 2));
> +               /* XXX check if swapping is necessary on BE */
>                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
>                              ring->wptr << 2);
> -               *wptr_saved =3D ring->wptr << 2;
> -               if (*is_queue_unmap) {
> -                       WDOORBELL64(aggregated_db_index, ring->wptr << 2)=
;
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                       ring->doorbell_index, ring->wptr =
<< 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -               } else {
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                       ring->doorbell_index, ring->wptr =
<< 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -
> -                       if (*is_queue_unmap)
> -                               WDOORBELL64(aggregated_db_index,
> -                                           ring->wptr << 2);
> -               }
> +               DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
> +                         ring->doorbell_index, ring->wptr << 2);
> +               WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
>         } else {
> -               if (ring->use_doorbell) {
> -                       DRM_DEBUG("Using doorbell -- "
> -                                 "wptr_offs =3D=3D 0x%08x "
> -                                 "lower_32_bits(ring->wptr) << 2 =3D=3D =
0x%08x "
> -                                 "upper_32_bits(ring->wptr) << 2 =3D=3D =
0x%08x\n",
> -                                 ring->wptr_offs,
> -                                 lower_32_bits(ring->wptr << 2),
> -                                 upper_32_bits(ring->wptr << 2));
> -                       /* XXX check if swapping is necessary on BE */
> -                       atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
> -                                    ring->wptr << 2);
> -                       DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)=
\n",
> -                                 ring->doorbell_index, ring->wptr << 2);
> -                       WDOORBELL64(ring->doorbell_index, ring->wptr << 2=
);
> -               } else {
> -                       DRM_DEBUG("Not using doorbell -- "
> -                                 "regSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> -                                 "regSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x=
\n",
> -                                 ring->me,
> -                                 lower_32_bits(ring->wptr << 2),
> -                                 ring->me,
> -                                 upper_32_bits(ring->wptr << 2));
> -                       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev=
,
> -                                       ring->me, regSDMA0_QUEUE0_RB_WPTR=
),
> -                                       lower_32_bits(ring->wptr << 2));
> -                       WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev=
,
> -                                       ring->me, regSDMA0_QUEUE0_RB_WPTR=
_HI),
> -                                       upper_32_bits(ring->wptr << 2));
> -               }
> +               DRM_DEBUG("Not using doorbell -- "
> +                         "regSDMA%i_GFX_RB_WPTR =3D=3D 0x%08x "
> +                         "regSDMA%i_GFX_RB_WPTR_HI =3D=3D 0x%08x\n",
> +                         ring->me,
> +                         lower_32_bits(ring->wptr << 2),
> +                         ring->me,
> +                         upper_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
> +                                                            ring->me, re=
gSDMA0_QUEUE0_RB_WPTR),
> +                               lower_32_bits(ring->wptr << 2));
> +               WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev,
> +                                                            ring->me, re=
gSDMA0_QUEUE0_RB_WPTR_HI),
> +                               upper_32_bits(ring->wptr << 2));
>         }
>  }
>
> --
> 2.41.0
>
