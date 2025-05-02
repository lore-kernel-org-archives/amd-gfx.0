Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0BFC3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43D110E95E;
	Fri,  2 May 2025 16:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NcrU7vHD";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D0210E95E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:46:55 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so251084a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746204415; x=1746809215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SljCBxHVd2ZEY1llCunKnXRD4c6KvmyOLrd13qoolk8=;
 b=NcrU7vHDqlaGW3makkRC4xjnGpSbwz6NseoT4EswppDH/PabklxrxR5GJrIZUpG7EH
 8I3zPYdfp2O1DCZpmjxF6d4qI0UxY/gJR5Do27c7qRXCMjGEqpa8p9gH/utRYQWLvD/i
 8yXrw5QRbpYbwDaRdbmF3y1aCEoBALgyolbWnfl8R0IjyWNKLXPdNtpKRE4EVQm1oRm7
 0dGXPlWjKosCDVnFL21Minc4GvYxLvFleFWR1y/kgZecO2TDWsne9TCazVnASDNN5tnj
 7LgCrvm2UZxl2JjbsBJti6V5G72rGqVznVHF4OkicpJfmr6eUjkRllapqmrX1fA/nSah
 gYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204415; x=1746809215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SljCBxHVd2ZEY1llCunKnXRD4c6KvmyOLrd13qoolk8=;
 b=MBG5z8Ct/YX2ztICBViCvkcN1BOURJ08QYmn86pPdkUHEorvkxwcm2mHNiBUju8wKN
 9ou0582faYmRQEsAWtvHCQQM7hquu7VAogUgowjQn1OUwFA8Klj9nywTKJrusAfdyAEK
 SdSg7KOVqHunlMmPiY8izcvOOnQT2JrdZCIsH8VV0pTkntDaY6OTNHUKXzatOm27lAje
 RCQmrqjjXfSkli/eVhniWY/5++MZwT/TzOfMIG3y2PTi1mkfCX4x1l39iq9uXhuoe+MH
 CYy/woaLRBVvHQnG1BLGQbNS+Y84BtkFABL17jUwsNW3ychUA0o/muvUgBiydXW6gT2I
 a5jA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKUubUDaYf8FcucevQyrE/H8s5ehfFINaYx1gNVMhX8/tFgODHeqAWOvWs0lDhevi8kPYKbTX0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBUvFTJPvD7vk4eupOWwEHYu0wqzb3d/oG1do0y8Z7m9rVBnWa
 7iPfGIBRgqnzP8+9+J3Y7x/e5M4DRfo/1fX7Hb9G2pb1yiqqsXpBvh3tNXPkC6fHKF7b45549BZ
 ULV37xPQnrDnzV1l5VxaOL+6BjaQ=
X-Gm-Gg: ASbGncuBeVzfF23xhT7dNCtOyarj+sUlsuLeIiYfJhOHq5zF5yBoK28BOGYkI6NauXA
 69o5FKklliKcFy/WSDh4xjaZJsofESvKaCt1+YcYYuC3vbzlCuvYv1bZN+bSbG4yqoTeQrloY8p
 yfOlaGVcD+2ue73w7MtR+LfA==
X-Google-Smtp-Source: AGHT+IE0AastPoaobxu7yEKYlWS2EukC9LWWouQvlu4pqCoUgDCnID+W6Bo5Q9Yn0pyTectK+t5S3DEIBQLhC5iAG9s=
X-Received: by 2002:a17:90a:e7d1:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-30a4e6f8612mr2062376a91.8.1746204415230; Fri, 02 May 2025
 09:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-4-christian.koenig@amd.com>
In-Reply-To: <20250502161720.1704-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 12:46:44 -0400
X-Gm-Features: ATxdqUHD-MZVDfbSNy78BFa_31IK-aFmmc98ua9qMHJcM3APE4086A-lL5-vFYQ
Message-ID: <CADnq5_N0a3HNTpuFDYVyhcTSPCU=7G2nTRNE6Z9XiwQqynqV6A@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: rework gfx8 queue reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Fri, May 2, 2025 at 12:43=E2=80=AFPM Christian K=C3=B6nig
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
> index 5ee2237d8ee8..8dd1ffecfa81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6140,12 +6140,45 @@ static void gfx_v8_0_ring_emit_fence_gfx(struct a=
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
> @@ -6339,46 +6372,6 @@ static void gfx_v8_0_ring_emit_wreg(struct amdgpu_=
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
> @@ -6875,14 +6868,13 @@ static int gfx_v8_0_reset_kgq(struct amdgpu_ring =
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
> @@ -6948,7 +6940,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring=
_funcs_gfx =3D {
>         .emit_cntxcntl =3D gfx_v8_ring_emit_cntxcntl,
>         .init_cond_exec =3D gfx_v8_0_ring_emit_init_cond_exec,
>         .emit_wreg =3D gfx_v8_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v8_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v8_0_emit_mem_sync,
>         .reset =3D gfx_v8_0_reset_kgq,
>  };
> @@ -6983,7 +6974,6 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring=
_funcs_compute =3D {
>         .insert_nop =3D amdgpu_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v8_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v8_0_ring_soft_recovery,

Same here.

Alex

>         .emit_mem_sync =3D gfx_v8_0_emit_mem_sync_compute,
>         .emit_wave_limit =3D gfx_v8_0_emit_wave_limit,
>  };
> --
> 2.34.1
>
