Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6391C7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 15:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A73010E3A3;
	Tue, 30 May 2023 15:17:26 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4F2810E3A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 15:17:24 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5556e2bddf9so2299325eaf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685459843; x=1688051843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTQ36FAHlZOH0hHS/Mwd436WLNCFvwjFKASafLU6iYM=;
 b=N0FwSIpm9IjydM3MmQy8B6iiZSXpBlfCkOz5Aqer1F1q0X/rUe62Jtc1Qb+xa1xVe6
 Z1LBjGyPYa1y+2qn7Eyd8gDLQ8+GmO/JWAGDV1lvDGWTWIqyg5UGDnCfFVltT1XVdRZ1
 fEyFuHIFbBnwMCLh0VnfFIZqkAGT2noXU/4dSLwrczmZsjSnxUEINUA/FYijNGsrpXuS
 wuNFX+FkTIu3KN5/FtiMnkbvHyqzL9KIRXIp+J2P6BNoB+xcEwFoWLTigWDHJc3bw1HE
 6zR99MMCrx7M071iaoVXACNW0xFYmbCBU+KenNOa9DLLaADNrb5SPJuZYDjuzgG1hcoN
 8OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685459843; x=1688051843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTQ36FAHlZOH0hHS/Mwd436WLNCFvwjFKASafLU6iYM=;
 b=Hs/HacjrilQU1pjYyHaTyy7ghhRZD+HIUvk855Ub1SMFrwX0xoJiSh1ZPLXwl8Izne
 uL+oBFiFDvADTwFWdfvmXG7SUPJev9K0tmsKpU0wXMIbbfE2xGUdZ9pl0R3Y8jKTlCU5
 xuoRSFM7Q+Cyiquwu2fHtwiq/i/7idZ7Tv4AVobdxlScSw8YK2T972TZZUO2qE90VflL
 mkYIJ9LHjy8W4deB060AHbs0eE6rcNFBGA4xfehK6nrns2PMKQpAHY+utnT71dvKs5ve
 ZBHd4waFeHTAqwmjJh8qfD2KFshz2MuegHCfM04/UMAtIEdPDGFYiMggCJrSCYDa1jri
 gTdg==
X-Gm-Message-State: AC+VfDzMY0UvOa7jiAoJFReWgx9EP4YvNa0wOLNPukNemwviNU5hB98Q
 0pHY31JnMF2JifEgjoXzwCG+d3x5qsU/iPqnOu8=
X-Google-Smtp-Source: ACHHUZ6ktu42Cq//5YHsYuscn9PlP2oCQEjCI4motDV/0MpRXtlK0HxvJQZ+vcKj4V5zJvpjRPiJTiZjGC4pAoBwm1w=
X-Received: by 2002:a4a:4913:0:b0:555:8c22:a169 with SMTP id
 z19-20020a4a4913000000b005558c22a169mr1146798ooa.9.1685459843506; Tue, 30 May
 2023 08:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230526011846.3331119-1-jiadong.zhu@amd.com>
 <20230526011846.3331119-2-jiadong.zhu@amd.com>
In-Reply-To: <20230526011846.3331119-2-jiadong.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 30 May 2023 11:17:12 -0400
Message-ID: <CADnq5_PRsz+udHO=Wgu3SLjte8M7QQsU_jvDw82zbU7dFWY+pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Implement gfx9 patch functions for
 resubmission
To: jiadong.zhu@amd.com
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 25, 2023 at 9:19=E2=80=AFPM <jiadong.zhu@amd.com> wrote:
>
> From: Jiadong Zhu <Jiadong.Zhu@amd.com>
>
> Patch the packages including CONTEXT_CONTROL and WRITE_DATA for gfx9
> during the resubmission scenario.
>
> Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 80 +++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index cbcf6126cce5..4fbeb9b5752c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5172,9 +5172,83 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgp=
u_ring *ring,
>  #endif
>                 lower_32_bits(ib->gpu_addr));
>         amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> +       amdgpu_ring_ib_on_emit_cntl(ring);
>         amdgpu_ring_write(ring, control);
>  }
>
> +static void gfx_v9_0_ring_patch_cntl(struct amdgpu_ring *ring,
> +                                    unsigned offset)
> +{
> +       u32 control =3D ring->ring[offset];
> +
> +       control |=3D INDIRECT_BUFFER_PRE_RESUME(1);
> +       ring->ring[offset] =3D control;
> +}
> +
> +static void gfx_v9_0_ring_patch_ce_meta(struct amdgpu_ring *ring,
> +                                       unsigned offset)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       void *ce_payload_cpu_addr;
> +       uint64_t payload_offset, payload_size;
> +
> +       payload_size =3D sizeof(struct v9_ce_ib_state);
> +
> +       if (ring->is_mes_queue) {
> +               payload_offset =3D offsetof(struct amdgpu_mes_ctx_meta_da=
ta,
> +                                         gfx[0].gfx_meta_data) +
> +                       offsetof(struct v9_gfx_meta_data, ce_payload);
> +               ce_payload_cpu_addr =3D
> +                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_of=
fset);
> +       } else {
> +               payload_offset =3D offsetof(struct v9_gfx_meta_data, ce_p=
ayload);
> +               ce_payload_cpu_addr =3D adev->virt.csa_cpu_addr + payload=
_offset;
> +       }
> +
> +       if (offset + (payload_size >> 2) <=3D ring->buf_mask + 1) {
> +               memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr, =
payload_size);
> +       } else {
> +               memcpy((void *)&ring->ring[offset], ce_payload_cpu_addr,
> +                      (ring->buf_mask + 1 - offset) << 2);
> +               payload_size -=3D (ring->buf_mask + 1 - offset) << 2;
> +               memcpy((void *)&ring->ring[0],
> +                      ce_payload_cpu_addr + ((ring->buf_mask + 1 - offse=
t) << 2),
> +                      payload_size);
> +       }
> +}
> +
> +static void gfx_v9_0_ring_patch_de_meta(struct amdgpu_ring *ring,
> +                                       unsigned offset)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       void *de_payload_cpu_addr;
> +       uint64_t payload_offset, payload_size;
> +
> +       payload_size =3D sizeof(struct v9_de_ib_state);
> +
> +       if (ring->is_mes_queue) {
> +               payload_offset =3D offsetof(struct amdgpu_mes_ctx_meta_da=
ta,
> +                                         gfx[0].gfx_meta_data) +
> +                       offsetof(struct v9_gfx_meta_data, de_payload);
> +               de_payload_cpu_addr =3D
> +                       amdgpu_mes_ctx_get_offs_cpu_addr(ring, payload_of=
fset);
> +       } else {
> +               payload_offset =3D offsetof(struct v9_gfx_meta_data, de_p=
ayload);
> +               de_payload_cpu_addr =3D adev->virt.csa_cpu_addr + payload=
_offset;
> +       }
> +
> +       if (offset + (payload_size >> 2) <=3D ring->buf_mask + 1) {
> +               memcpy((void *)&ring->ring[offset], de_payload_cpu_addr, =
payload_size);
> +       } else {
> +               memcpy((void *)&ring->ring[offset], de_payload_cpu_addr,
> +                      (ring->buf_mask + 1 - offset) << 2);
> +               payload_size -=3D (ring->buf_mask + 1 - offset) << 2;
> +               memcpy((void *)&ring->ring[0],
> +                      de_payload_cpu_addr + ((ring->buf_mask + 1 - offse=
t) << 2),
> +                      payload_size);
> +       }
> +}
> +
>  static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
>                                           struct amdgpu_job *job,
>                                           struct amdgpu_ib *ib,
> @@ -5370,6 +5444,8 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgp=
u_ring *ring, bool resume)
>         amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
>         amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
>
> +       amdgpu_ring_ib_on_emit_ce(ring);
> +
>         if (resume)
>                 amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
>                                            sizeof(ce_payload) >> 2);
> @@ -5481,6 +5557,7 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgp=
u_ring *ring, bool resume, bo
>         amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
>         amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
>
> +       amdgpu_ring_ib_on_emit_de(ring);
>         if (resume)
>                 amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
>                                            sizeof(de_payload) >> 2);
> @@ -6891,6 +6968,9 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_r=
ing_funcs_gfx =3D {
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
>         .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> +       .patch_cntl =3D gfx_v9_0_ring_patch_cntl,
> +       .patch_de =3D gfx_v9_0_ring_patch_de_meta,
> +       .patch_ce =3D gfx_v9_0_ring_patch_ce_meta,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute =3D {
> --
> 2.25.1
>
