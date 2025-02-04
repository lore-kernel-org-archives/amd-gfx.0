Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6019C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 736D410E660;
	Tue,  4 Feb 2025 14:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="grCD268o";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C21A10E660
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:57:18 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2f9c3ff9219so152868a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738681038; x=1739285838; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuhVCRbEd99nWD0wAoLivPDsJWd6v49vXbW3JMgN+qk=;
 b=grCD268oPEMCWJlw63emAQHIfVXV1vb3VR0QUs/eGm8Zu3dCWNxW2VM0Va7j6Xs0JU
 dABE0HSKH638pdJARlQH0yHMHbk0NsHrrVbsY1+f82drhUq5IdEuIU0OceDp178ODXjk
 feoXWsN6Fw6lzINhi3mbNLDlZNdWrZtGIjLy4HfefBqvVKT5W9pRQp5OoaQF2tRo7mQ+
 m7njqXzfnvbWjUZWTRgjlvRS+Fi5P/lP/Utk8MT+xXPwKjTTb5J8Z5nKXBue0aPIL3Y3
 4g1jsWmWBUWx/K8vGOw0ApBA9NP7cfuBiFT/HFPZGYoz99if73M9xHlfLB0ZxVhtMKJs
 vdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738681038; x=1739285838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuhVCRbEd99nWD0wAoLivPDsJWd6v49vXbW3JMgN+qk=;
 b=lcGJlQukii2ceB96ffy4CJksuy54hz5o66Rf1UjXfLIZ9WRmOQ4fn1Rekn8HXoZmgM
 A/ONffwluXsStZfDdrd+xU295L9XGDrb+V9HJ6eioGqMebT+anATbFthTgIQ4F+8Frd5
 jCDZxqk6LifF0gU6B415PdhRaIqZduUjVCC7lmcJE+Y9i49f5PWnFluMu0nJH0QPc44M
 vWDmiy1OPeCYIK4rHE2xBRCkCAkYzR3/qvU8HOr9H9Dd7ZsdhTpxpT+NW85WTkFrK7jV
 /pDMtlMiV6iYNEuDOpeYp0qgLMwfO2qlV9qYwDUf/P3dCM07Grvi6ceDMVMG7mH7q4Xo
 J2Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkElR1tyjwVv5xjq39DbKezx5syHG2aPuTkEZNLPY/bGBO6PmCXVuh5t0k9RbBTlnzbO8kUPLl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuW6Ewj/kkTBmbv9qUcZHPlVDcaUxi91iHmupKORQ1jh9hPwld
 kyuincB+HaWfI/b0X9dBi6Rnqv2dGmN52wjSsfSK27CJ4WrKlzQFNf8EPvhLbjIKTzDAdK/ojNL
 OLPzZj060+PZcSkLeag3K6sduJvI=
X-Gm-Gg: ASbGnctr9mmDs3koT/rOVl/KLAFWiOn1QjGypVNZruRqeG5OFzdxcCgvK0x8ZRJeuR/
 iB8KvFDlQ8HzRQ8gjCE5PdJaYwr2RBUYzAG3cIzsa05CC06NDPlzh/5besIyb4NUYsS+X58a3
X-Google-Smtp-Source: AGHT+IGLU8wCOTQon97Wr3D5ccexeJRlwcDbg/5fGvqqfKvW6N25UG2TJdyFZ7qIJuVXZBjzWGBksCk+33AnX6co3ZQ=
X-Received: by 2002:a17:90b:2f08:b0:2ee:d4ed:13a7 with SMTP id
 98e67ed59e1d1-2f9b8ca6a6amr2175421a91.7.1738681037801; Tue, 04 Feb 2025
 06:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20250204143113.6320-1-christian.koenig@amd.com>
 <20250204143113.6320-4-christian.koenig@amd.com>
In-Reply-To: <20250204143113.6320-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Feb 2025 09:57:06 -0500
X-Gm-Features: AWEUYZnax535r9afmjMqVmCtQ2mXC_NL3wY_MYrVm7weGtz8Rc6APe5FxRbi11E
Message-ID: <CADnq5_OYJtpRuuBu3bMJdDCTOt8vwD3Vaf75GHBsYV40VpyRYQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: rework gfx7 queue reset
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
> index 84745b2453ab..9f91c99725aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3092,6 +3092,33 @@ static int gfx_v7_0_cp_resume(struct amdgpu_device=
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
> @@ -3106,6 +3133,11 @@ static void gfx_v7_0_ring_emit_pipeline_sync(struc=
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
> @@ -4040,18 +4072,6 @@ static void gfx_v7_0_ring_emit_gds_switch(struct a=
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
> @@ -4926,34 +4946,6 @@ static void gfx_v7_0_emit_mem_sync_compute(struct =
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
> @@ -4986,14 +4978,13 @@ static int gfx_v7_0_reset_kgq(struct amdgpu_ring =
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
> @@ -5026,7 +5017,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
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
> @@ -5043,7 +5034,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
_funcs_gfx =3D {
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_cntxcntl =3D gfx_v7_ring_emit_cntxcntl,
>         .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v7_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v7_0_emit_mem_sync,
>         .reset =3D gfx_v7_0_reset_kgq,
>  };
> @@ -5060,7 +5050,7 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
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
> @@ -5076,7 +5066,6 @@ static const struct amdgpu_ring_funcs gfx_v7_0_ring=
_funcs_compute =3D {
>         .insert_nop =3D amdgpu_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v7_0_ring_emit_wreg,
> -       .soft_recovery =3D gfx_v7_0_ring_soft_recovery,

Probably want to keep this for compute.

Alex

>         .emit_mem_sync =3D gfx_v7_0_emit_mem_sync_compute,
>  };
>
> --
> 2.34.1
>
