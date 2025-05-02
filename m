Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798CFC3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F253B10E1AD;
	Fri,  2 May 2025 16:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LyVtISQa";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E444510E1AD
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:43:35 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so250567a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 May 2025 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746204215; x=1746809015; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1EPXatBNFPLil+fbUTE1tG3Ka1Cq4zNTeG5Q+KEt3VU=;
 b=LyVtISQaulWKkX0zMH5XOhMCEbOGf5wtW7agI9lOZz+3xHVVPfVRBGTM71mWMfTYgI
 g9FvveDSKgv5WhTtfCEeljPel5TGyR9mWwLa0Vpahn6TOpY5+XH50lvK76WVOKXFFTZp
 lBLSnqFORYchbrFviJvILd5H0dEvggp7Bc4cJz29iL+V3DKx0hJGnNTis/QQ8xQAEQFf
 3D5gI2flBZttCmdktmE3Y3p8TC7nMwKh7JSt+68Uh+QbPj8h9puv6TvqS159UQFcSxuX
 vk+c/JVZSfqoV0pHLgW9eIg0snTqqd/jgPTRZ9XTZUSzPyiMSaa0VX4LYmxUB9vPFJZ5
 zxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746204215; x=1746809015;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1EPXatBNFPLil+fbUTE1tG3Ka1Cq4zNTeG5Q+KEt3VU=;
 b=WS7zQarMnv/ZB8U/cfGSXqLEDgRXFbghiml9OzV/4yMfdocw2i8zTvVu/8UZ/UZFhf
 F9hD84pR1V9/xWax8WPAL+axdIF6z+LtEMM+eKPnxvr1IsIhJ5wgIDrudrdu90+Avsy7
 F2dYSgZqfM+hhfyMkdJoSLkebVtOeuWK63hJ9ji8cmxXf4aidquo2Bc2QKlOo8WuLMEk
 NEDvg2CUSP5dFtujBVwQq9Es2XZGpbF6bM8yl7JvDQk3VunCPb/nqxCofBuYd4ZJm7Ww
 N6aSVlQBQfqxCCDW7Z681Y/7RJhDkg0TOem7GNhsZG3HxZ2ctZ5H872fafxcFmzj9JUf
 bIjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVK35JdN0LJzxU2ZTAXRo/3icjxTnJu6b68dyGAzd5iuxtfYcYPOaLu1AXGwbveG8npLE7xskzu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyew3TF8Y2YE7Qnqllaadkq122bICCJqNV1TC80c724LF7urX3Z
 u7bUG64uXA1iJglec5PSXzSCX1nI9KjIowIMD7ZzZs7gNhxFBRTLYhnvGHlGkiefl7+fW6xmceR
 yYuAs/Hr8Z0jPHa8bs86xHHliRlM=
X-Gm-Gg: ASbGncvcdFbgZ2UU+yHNhZ+EOUbpra/gUm3Qw0aRnfLJ2yFaP2gzKW68vRwx72V11rf
 VO9J3bufUmJHQCNuLhvcuVvtxdZFnokNJdE6A3hcmV2/D45vBd0cZcmd6G1aOiWJlrtYLKQpWrv
 jDmygl5wX8rVp5Jb0cMb03lA==
X-Google-Smtp-Source: AGHT+IEqhF5CI3Q4upSS0bxB3bsoiOZhLjkOITZBuZ5vTNYlsXM8UARzMIgcjZWVlB+5VOsstqX1DUeeiLeOrHXVulY=
X-Received: by 2002:a17:90b:3b47:b0:2fe:b2ea:30f0 with SMTP id
 98e67ed59e1d1-30a4e6a2665mr2040517a91.4.1746204215095; Fri, 02 May 2025
 09:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-2-christian.koenig@amd.com>
In-Reply-To: <20250502161720.1704-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 May 2025 12:43:22 -0400
X-Gm-Features: ATxdqUHeGvHFfBeGv2G-52YZbt78n1WZ9mcqttes-mDNZacsUvBcAJly6wH29rs
Message-ID: <CADnq5_M56Dn-U5vi8_VSSXjKg85oFBkzEkWcVyojKWQqqRsspA@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: rework gfx9 queue reset
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
> Testing this feature turned out that it was a bit unstable. The
> CP_VMID_RESET register takes the VMID which all submissions from should
> be canceled.
>
> Unlike Windows Linux uses per process VMIDs instead of per engine VMIDs
> for the simple reason that we don't have enough. So resetting one VMID
> only killed the submissions of one specific process.
>
> Fortunately that turned out to be exactly what we want to have.
>
> So clear the CP_VMID_RESET register between every context switch between
> applications when we do the pipeline sync to avoid trouble if multiple
> VMIDs are used on the ring right behind each other.
>
> Use the same pipeline sync function in the reset handler and issue an IB
> test instead of a ring test after the queue reset to provide a longer
> timeout and additional fence value should there be additional work on
> the ring after the one aborted.
>
> Also drop the soft recovery since that pretty much does the same thing as
> CP_VMID_RESET, just on a lower level and with less chance of succeeding.
>
> This now survives a stress test running over night sending a broken
> submission ever 45 seconds and recovering fine from each of them.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 ++++++++++-----------------
>  2 files changed, 19 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index cc26cf1bd843..c39fe784419b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS         3000
>  #define AMDGPU_MAX_USEC_TIMEOUT                        100000  /* 100 ms=
 */
>  #define AMDGPU_FENCE_JIFFIES_TIMEOUT           (HZ / 2)
> +#define AMDGPU_QUEUE_RESET_TIMEOUT             (HZ / 10)
>  #define AMDGPU_DEBUGFS_MAX_COMPONENTS          32
>  #define AMDGPUFB_CONN_LIMIT                    4
>  #define AMDGPU_BIOS_NUM_SCRATCH                        16
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index d377a7c57d5e..92d9a28c62d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5565,7 +5565,17 @@ static void gfx_v9_0_ring_emit_pipeline_sync(struc=
t amdgpu_ring *ring)
>         int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
>         uint32_t seq =3D ring->fence_drv.sync_seq;
>         uint64_t addr =3D ring->fence_drv.gpu_addr;
> +       struct amdgpu_device *adev =3D ring->adev;
>
> +       amdgpu_ring_emit_reg_wait(ring,
> +                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET=
),
> +                                 0, 0xffff);
> +       amdgpu_ring_emit_wreg(ring,
> +                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
> +                             0);
> +       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +                              ring->fence_drv.sync_seq,
> +                              AMDGPU_FENCE_FLAG_EXEC);
>         gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
>                               lower_32_bits(addr), upper_32_bits(addr),
>                               seq, 0xffffffff, 4);
> @@ -5896,20 +5906,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wait(=
struct amdgpu_ring *ring,
>                                                            ref, mask);
>  }
>
> -static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsign=
ed vmid)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t value =3D 0;
> -
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> -       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -       WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> -       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -}
> -
>  static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *a=
dev,
>                                                  enum amdgpu_interrupt_st=
ate state)
>  {
> @@ -7185,16 +7181,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
> +       if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
>                 return -ENOMEM;
> -       gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> -                                ring->fence_drv.sync_seq, AMDGPU_FENCE_F=
LAG_EXEC);
> -       gfx_v9_0_ring_emit_reg_wait(ring,
> -                                   SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RES=
ET), 0, 0xffff);
> -       gfx_v9_0_ring_emit_wreg(ring,
> -                               SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),=
 0);
> +       gfx_v9_0_ring_emit_pipeline_sync(ring);
> +       amdgpu_ring_commit(ring);
>
> -       return amdgpu_ring_test_ring(ring);
> +       return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>
>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -7437,7 +7429,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_gfx =3D {
>         .set_wptr =3D gfx_v9_0_ring_set_wptr_gfx,
>         .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
>                 5 +  /* COND_EXEC */
> -               7 +  /* PIPELINE_SYNC */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 2 + /* VM_FLUSH */
> @@ -7475,7 +7467,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_gfx =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> -       .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>         .reset =3D gfx_v9_0_reset_kgq,
>         .emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> @@ -7494,7 +7485,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_r=
ing_funcs_gfx =3D {
>         .set_wptr =3D amdgpu_sw_ring_set_wptr_gfx,
>         .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
>                 5 +  /* COND_EXEC */
> -               7 +  /* PIPELINE_SYNC */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 2 + /* VM_FLUSH */
> @@ -7533,7 +7524,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_r=
ing_funcs_gfx =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> -       .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>         .patch_cntl =3D gfx_v9_0_ring_patch_cntl,
>         .patch_de =3D gfx_v9_0_ring_patch_de_meta,
> @@ -7555,7 +7545,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>                 20 + /* gfx_v9_0_ring_emit_gds_switch */
>                 7 + /* gfx_v9_0_ring_emit_hdp_flush */
>                 5 + /* hdp invalidate */
> -               7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence=
, vm fence */
> @@ -7577,7 +7567,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> -       .soft_recovery =3D gfx_v9_0_ring_soft_recovery,

I think we should keep soft recovery for compute.  For compute, it
should do what we want.

Alex

>         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>         .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
>         .reset =3D gfx_v9_0_reset_kcq,
> @@ -7598,7 +7587,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_kiq =3D {
>                 20 + /* gfx_v9_0_ring_emit_gds_switch */
>                 7 + /* gfx_v9_0_ring_emit_hdp_flush */
>                 5 + /* hdp invalidate */
> -               7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fe=
nce, vm fence */
> --
> 2.34.1
>
