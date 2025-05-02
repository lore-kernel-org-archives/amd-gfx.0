Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73466C3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77E810E95B;
	Fri,  2 May 2025 16:45:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YZB8R46O";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77E510E95B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:45:32 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3054e2d13a7so171804a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746204332; x=1746809132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgjRr5qjEXqZp7365Vqg7fBQ4rUB35/Fyyhz42ju7N4=;
 b=YZB8R46O6bBitymKcCH3Akqoa3hAh5tl1Hww0ttMGJNLdo3hMIbv7U2dHpK+s7nI0F
 rxPVqLrMOFF2N1ueKwpKnlE//HFYXbXUS+pc3kcnt8jRcOY7QDWXcB7O1Wiy1PpXNVD/
 5Vr0tJ0F8w8QNMJadPq2RG5PoCIwVdiN826Fjo+EUy1c+R/TcFmXOnZdq3Sw1XeU9pa0
 jqN8fmegyeBWSMxlPgv9QdPfPYIn3/SAWku4UGK24YgnrZ+I3wCGf3ZiAwlKocDKy+Lo
 ynJUSCMACoUG6u/1Y8LnyIUayr5vpbAOTfHmWMZrM70tiqLymgzXZFpFVekP5ccx1GtH
 tKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204332; x=1746809132;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgjRr5qjEXqZp7365Vqg7fBQ4rUB35/Fyyhz42ju7N4=;
 b=fRTP3cnX4eMCNeCdIhsajMaipA9r/2yeJWa44Mh5Q9X57XeFuUj1lWO8teFtNgeyvY
 ROwXLyT9Zvto12ZIyssNo8zH/v1TsCThnL7c1S7FCSGtZLbxmyEPY8iz4noK8S5D81vg
 WCMzj33QSxVTgu7e8sy/Z1zQBbtwp2HpZUpiAIIGgVDsM5AtHWgxK4jszh0e5s5KZfzu
 kfAJT3EU+YxFN9TnxBScdSw0ICqsYW5a0xQPOYzEcg2xTwJYoo1pwQDVmWbhiqaR8Jmv
 YozHG+sipqZBtVToGl5O014tAj54IimRcmRJJzZoYry0UpBeFc4Q3Yvwe0sP93Put0K+
 ynjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbqTcv3qBNAugZi1bzq1HsGLoSJD56Co0aw5Btu0FBvTu/G/R9gpR2/swribHBbo591t9ZmGlE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzF4FV57BEwsjvR/R9e/E6EUlGdjNpH9Ynx1j6LsJSwQp5hk27S
 a+Mb1ZXgefHmw6IO7rd74XtQl1mfwfgqPSM0oR7kAMv66slrmrfPsVbxUkx6CXL7ADVRxofWgaH
 WbMUysjBiQy3UOGBoJx2SY+UP+VQ=
X-Gm-Gg: ASbGncuaoJYyNUWCkPkq8fP3Zqia2kSMCyxlIS0TLs/VK5Rrw2+AZUVAAKfT/RMa7tQ
 zYyCzGFmDw5D0UCu2BrAzB8epgVhIXg0IbWnbhIo4gmPPA3jCEM1ig6q+EcJzM5Xq+5jkkFc6mD
 erAtd3Vkr47ztkeylCTDQYiA==
X-Google-Smtp-Source: AGHT+IGPk93N2BY+BE3fxtFUHOxVLUNU+hq0W6qOExOcexR1mLlVBHNok0+9l69G0ev1Zj4c79P1oFvFn/rluOO8gn4=
X-Received: by 2002:a17:90b:1642:b0:30a:28e2:a003 with SMTP id
 98e67ed59e1d1-30a4e621a86mr1933151a91.3.1746204332209; Fri, 02 May 2025
 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-3-christian.koenig@amd.com>
In-Reply-To: <20250502161720.1704-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 12:45:21 -0400
X-Gm-Features: ATxdqUHbjCPTJuLSBkxR1nUR15-Dd0chK9lNIQj5zJC39S5RUa-zEwFOCmf2gqg
Message-ID: <CADnq5_Pk6a0ZBUoP8vb1Lnn6UTf3huOUMzQ9F1RY_ePHZFGK+g@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: rework gfx7 queue reset
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

On Fri, May 2, 2025 at 12:17=E2=80=AFPM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Apply the same changes to gfx7 as done to gfx9.
>
> Untested and probably needs some more work.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 89 ++++++++++++---------------
>  1 file changed, 39 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index da0534ff1271..3634f54ed5a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3095,6 +3095,33 @@ static int gfx_v7_0_cp_resume(struct amdgpu_device=
 *adev)
>         return 0;
>  }
>
> +static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
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
> +static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32=
_t reg,
> +                                       uint32_t val, uint32_t mask)
> +{
> +       gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
> +}
> +
>  /**
>   * gfx_v7_0_ring_emit_pipeline_sync - cik vm flush using the CP
>   *
> @@ -3109,6 +3136,11 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struc=
t amdgpu_ring *ring)
>         uint32_t seq =3D ring->fence_drv.sync_seq;
>         uint64_t addr =3D ring->fence_drv.gpu_addr;
>
> +       gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
> +       amdgpu_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
> +       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +                              ring->fence_drv.sync_seq,
> +                              AMDGPU_FENCE_FLAG_EXEC);
>         amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>         amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
>                                  WAIT_REG_MEM_FUNCTION(3) | /* equal */
> @@ -3998,18 +4030,6 @@ static void gfx_v7_0_ring_emit_gds_switch(struct a=
mdgpu_ring *ring,
>         amdgpu_ring_write(ring, (1 << (oa_size + oa_base)) - (1 << oa_bas=
e));
>  }
>
> -static void gfx_v7_0_ring_soft_recovery(struct amdgpu_ring *ring, unsign=
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
>  static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t simd,=
 uint32_t wave, uint32_t address)
>  {
>         WREG32(mmSQ_IND_INDEX,
> @@ -4884,34 +4904,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct =
amdgpu_ring *ring)
>         amdgpu_ring_write(ring, 0x0000000A);    /* poll interval */
>  }
>
> -static void gfx_v7_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
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
> -static void gfx_v7_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32=
_t reg,
> -                                       uint32_t val, uint32_t mask)
> -{
> -       gfx_v7_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
> -}
> -
>  static int gfx_v7_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmi=
d)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -4944,14 +4936,13 @@ static int gfx_v7_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       if (amdgpu_ring_alloc(ring, 7 + 12 + 5))
> +       if (amdgpu_ring_alloc(ring, 7 + 12 + 5 + 7 + 4))
>                 return -ENOMEM;
> -       gfx_v7_0_ring_emit_fence_gfx(ring, ring->fence_drv.gpu_addr,
> -                                    ring->fence_drv.sync_seq, AMDGPU_FEN=
CE_FLAG_EXEC);
> -       gfx_v7_0_ring_emit_reg_wait(ring, mmCP_VMID_RESET, 0, 0xffff);
> -       gfx_v7_0_ring_emit_wreg(ring, mmCP_VMID_RESET, 0);
>
> -       return amdgpu_ring_test_ring(ring);
> +       gfx_v7_0_ring_emit_pipeline_sync(ring);
> +       amdgpu_ring_commit(ring);
> +
> +       return gfx_v7_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>
>  static const struct amd_ip_funcs gfx_v7_0_ip_funcs =3D {
> @@ -4984,7 +4975,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
_funcs_gfx =3D {
>                 7 + /* gfx_v7_0_ring_emit_hdp_flush */
>                 5 + /* hdp invalidate */
>                 12 + 12 + 12 + /* gfx_v7_0_ring_emit_fence_gfx x3 for use=
r fence, vm fence */
> -               7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync */
> +               7 + 12 + 5 + 7 + 4 + /* gfx_v7_0_ring_emit_pipeline_sync =
*/
>                 CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + 6 + /* gfx_v7_0_ring=
_emit_vm_flush */
>                 3 + 4 + /* gfx_v7_ring_emit_cntxcntl including vgt flush*=
/
>                 5, /* SURFACE_SYNC */
> @@ -5001,7 +4992,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
_funcs_gfx =3D {
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_cntxcntl =3D gfx_v7_ring_emit_cntxcntl,
>         .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v7_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v7_0_emit_mem_sync,
>         .reset =3D gfx_v7_0_reset_kgq,
>  };
> @@ -5018,7 +5008,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
_funcs_compute =3D {
>                 20 + /* gfx_v7_0_ring_emit_gds_switch */
>                 7 + /* gfx_v7_0_ring_emit_hdp_flush */
>                 5 + /* hdp invalidate */
> -               7 + /* gfx_v7_0_ring_emit_pipeline_sync */
> +               7 + 12 + 5 + 7 + /* gfx_v7_0_ring_emit_pipeline_sync */
>                 CIK_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v7_0_ring_emi=
t_vm_flush */
>                 7 + 7 + 7 + /* gfx_v7_0_ring_emit_fence_compute x3 for us=
er fence, vm fence */
>                 7, /* gfx_v7_0_emit_mem_sync_compute */
> @@ -5034,7 +5024,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
_funcs_compute =3D {
>         .insert_nop =3D amdgpu_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v7_0_ring_soft_recovery,

Same comment here for compute.

Alex

>         .emit_mem_sync =3D gfx_v7_0_emit_mem_sync_compute,
>  };
>
> --
> 2.34.1
>
