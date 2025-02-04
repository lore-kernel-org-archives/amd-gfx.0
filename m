Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF091C02197
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E9A310E66E;
	Tue,  4 Feb 2025 14:58:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eG15Mjw3";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44CFD10E66E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:58:32 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-21f0debf5e8so893465ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738681112; x=1739285912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov5gFhPm8vxmRvDlxOsIXObvv1/rpWBy+yCg6kO0QDg=;
 b=eG15Mjw3VeEkqHbdGEc8xlQppgd2uUOxoux11bXxbK2D3IID8HdnGh/3ju++HruSMU
 hQDTz18I6/ojy6bGbJn2HuW9+Z4+ZK/du0Ed5zhohnKNCiJXLKWu5pnQt6wrTyus/11z
 Y00gZRaIMWLzmVIYLRa9JfesFs68J9ApUqzKjIjNhfeRHRAhgG6qHvr7TyN/Qut3nOpo
 wt6kcVUz53VbJxioc6NzL1fyQ0dF6Z1ebDqqWQ2xhVzw8E9QyjpS9oeH42CkIrtmvT5h
 Hf+HBe0V4falQiJNJdPIZngxHKWvE0B+1nh1wAlLb++NwhfhVYKhq0PMuf1LWpwjynCc
 K1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681112; x=1739285912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ov5gFhPm8vxmRvDlxOsIXObvv1/rpWBy+yCg6kO0QDg=;
 b=F1nZDwkNPr3znuEugWXpGMGWeKzMc5B3H+sw3RVR7MXSQTrZR3RiQ9TwndRBtyJdgb
 mSqyTKqtRvFGfz7hQVdRpuOd+ok52RYvqdhFhmJQj+g6qTnrHNmmtaPBr7inR4jTogat
 vjPv3TLHLRCXLlqmE7K1uE2cC4EFUhOy5x01iud4WnvLfbwIAhadO9uQQMjYS2S9FgDI
 9DBvFhF+/JT7MwwVDe564YLJ9otNurmOYH2flYVToRgb0V+/oIlr8jgcB2LKPeZQjuK/
 Z04l9I2FINTEyODLWELXFqV3PGifUNmsP6gizu72kQ5m8xqUbbuAIxZlAWIeMAk1GrtL
 L4bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp4uV7TmHtEiZbYGjv6do08fWZkSqkOCUW5tX+jhOvytg5dWJ5z6r5IoQkL9tjs/ganXkhzN/2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEP3y8qOXyutm0tozezsr/DZHE9rm7lETn5kZBTBxE59imFJQ/
 bJNmJBJarmRSPJizGivsr8SVZIOu4eWOHQCRWciaDN6fKYv7/AckOlzsQNwUiYFA625VVb5gik3
 5FIdGzhujqC/Kf3IqiCzPI8uW8LyZWA==
X-Gm-Gg: ASbGncu+xxw7YZzZk2tFzt89XLl48nHGEDJTygkpS7UZwAgZNdz/ciVmkOPvsYnJvIr
 ev9OEqMkmLf/lbkSI+fYx2a87fYJfY8djcdE7fduRXXZWOczUVLL427MnW1gO1Fi5iUTmR1c+
X-Google-Smtp-Source: AGHT+IH6gF66SeCpKbFGQUQ8l3/e/13l0cizFrA2OXwBjIIZfLdTU/FJ8gqc4jP1ju2oxDYbjbGCAr9vQdGoFr/92HE=
X-Received: by 2002:a17:902:dac2:b0:216:32b6:cf0f with SMTP id
 d9443c01a7336-21efe6f1fa0mr22259175ad.12.1738681111795; Tue, 04 Feb 2025
 06:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20250204143113.6320-1-christian.koenig@amd.com>
 <20250204143113.6320-5-christian.koenig@amd.com>
In-Reply-To: <20250204143113.6320-5-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Feb 2025 09:58:19 -0500
X-Gm-Features: AWEUYZnfuTrWpqkBdrqRBgqhugl_gmmSLp8Bpkal4SmMsMttsRcbXO8ahAHWchY
Message-ID: <CADnq5_NZmTSWs2Gg6V2cBq0NvxvN_ME5AZEhCDr077jPGLTc6Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: rework gfx8 queue reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: timur.kristof@gmail.com, Alexander.Deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Feb 4, 2025 at 9:48=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Apply the same changes to gfx8 as done to gfx9.
>
> Untested and probably needs some more work.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 86 ++++++++++++---------------
>  1 file changed, 38 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 6a025438f9d0..f57301ebbd9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6201,12 +6201,45 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct a=
mdgpu_ring *ring, u64 addr,
>
>  }
>
> +static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
> +                                 int mem_space, int opt, uint32_t addr0,
> +                                 uint32_t addr1, uint32_t ref, uint32_t =
mask,
> +                                 uint32_t inv)
> +{
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
> +       amdgpu_ring_write(ring,
> +                         /* memory (1) or register (0) */
> +                         (WAIT_REG_MEM_MEM_SPACE(mem_space) |
> +                          WAIT_REG_MEM_OPERATION(opt) | /* wait */
> +                          WAIT_REG_MEM_FUNCTION(3) |  /* equal */
> +                          WAIT_REG_MEM_ENGINE(eng_sel)));
> +
> +       WARN_ON(mem_space && addr0 & 0x3); /* Dword align */
> +       amdgpu_ring_write(ring, addr0);
> +       amdgpu_ring_write(ring, addr1);
> +       amdgpu_ring_write(ring, ref);
> +       amdgpu_ring_write(ring, mask);
> +       amdgpu_ring_write(ring, inv); /* poll interval */
> +}
> +
> +static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32=
_t reg,
> +                                       uint32_t val, uint32_t mask)
> +{
> +       gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
> +}
> +
>  static void gfx_v8_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
>  {
>         int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
>         uint32_t seq =3D ring->fence_drv.sync_seq;
>         uint64_t addr =3D ring->fence_drv.gpu_addr;
>
> +       gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
> +       amdgpu_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
> +       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +                              ring->fence_drv.sync_seq,
> +                              AMDGPU_FENCE_FLAG_EXEC);
> +
>         amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>         amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
>                                  WAIT_REG_MEM_FUNCTION(3) | /* equal */
> @@ -6400,46 +6433,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_=
ring *ring, uint32_t reg,
>         amdgpu_ring_write(ring, val);
>  }
>
> -static void gfx_v8_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
> -                                 int mem_space, int opt, uint32_t addr0,
> -                                 uint32_t addr1, uint32_t ref, uint32_t =
mask,
> -                                 uint32_t inv)
> -{
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
> -       amdgpu_ring_write(ring,
> -                         /* memory (1) or register (0) */
> -                         (WAIT_REG_MEM_MEM_SPACE(mem_space) |
> -                          WAIT_REG_MEM_OPERATION(opt) | /* wait */
> -                          WAIT_REG_MEM_FUNCTION(3) |  /* equal */
> -                          WAIT_REG_MEM_ENGINE(eng_sel)));
> -
> -       if (mem_space)
> -               BUG_ON(addr0 & 0x3); /* Dword align */
> -       amdgpu_ring_write(ring, addr0);
> -       amdgpu_ring_write(ring, addr1);
> -       amdgpu_ring_write(ring, ref);
> -       amdgpu_ring_write(ring, mask);
> -       amdgpu_ring_write(ring, inv); /* poll interval */
> -}
> -
> -static void gfx_v8_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32=
_t reg,
> -                                       uint32_t val, uint32_t mask)
> -{
> -       gfx_v8_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
> -}
> -
> -static void gfx_v8_0_ring_soft_recovery(struct amdgpu_ring *ring, unsign=
ed vmid)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t value =3D 0;
> -
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> -       WREG32(mmSQ_CMD, value);
> -}
> -
>  static void gfx_v8_0_set_gfx_eop_interrupt_state(struct amdgpu_device *a=
dev,
>                                                  enum amdgpu_interrupt_st=
ate state)
>  {
> @@ -6936,14 +6929,13 @@ static int gfx_v8_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
> +       if (amdgpu_ring_alloc(ring, 7 + 12 + 5 + 7))
>                 return -ENOMEM;
> -       gfx_v8_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
> -                                    ring->fence_drv.sync_seq, AMDGPU_FEN=
CE_FLAG_EXEC);
> -       gfx_v8_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
> -       gfx_v8_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
>
> -       return amdgpu_ring_test_ring(ring);
> +       gfx_v8_0_ring_emit_pipeline_sync(ring);
> +       amdgpu_ring_commit(ring);
> +
> +       return gfx_v8_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>
>  static const struct amd_ip_funcs gfx_v8_0_ip_funcs =3D {
> @@ -7009,7 +7001,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring=
_funcs_gfx =3D {
>         .emit_cntxcntl =3D gfx_v8_ring_emit_cntxcntl,
>         .init_cond_exec =3D gfx_v8_0_ring_emit_init_cond_exec,
>         .emit_wreg =3D gfx_v8_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v8_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v8_0_emit_mem_sync,
>         .reset =3D gfx_v8_0_reset_kgq,
>  };
> @@ -7044,7 +7035,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring=
_funcs_compute =3D {
>         .insert_nop =3D amdgpu_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v8_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v8_0_ring_soft_recovery,

Same comment here.

Alex

>         .emit_mem_sync =3D gfx_v8_0_emit_mem_sync_compute,
>         .emit_wave_limit =3D gfx_v8_0_emit_wave_limit,
>  };
> --
> 2.34.1
>
