Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3791AC3ABDD
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 13:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3B1F10E0E3;
	Tue, 20 May 2025 13:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tr1nrYgw";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD7A10E0E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 13:14:39 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-231c38c9d9eso4707845ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 06:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747746879; x=1748351679; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3Fll2FVKxfx+qeC/g2VSdQVtobn0GEtEO5xtgAUJMo=;
 b=Tr1nrYgwdO9yslPBAm0MLfynVRYOBAzEmpOrQyOmHLwf/ksYfiixd0TxgFaYEs86AX
 DBapsUPyeaJcCx7cG2ODtBSFWNCOWySAAPef2dkF5DWjrIlqObOZrxKqOMCTqxeLt+NO
 F8YizGp3K/xEKsyguvDKfygqcOLV+pcTw1yUzBLT/d/JRaDil9HOBn6UaLIqSP68VGyC
 z40KuPnm5O2AvmvKzB+vSi0XdEV2+D9h70Zxj9KpKsl6cA35A8tDtX+UiEKdeix+u/64
 HvvUJhReDLmSgh4qvcJYCI8OkBFiQRa2R4ow8s140B7yMNSRZFPhJpgc5r3rmq4iHCaJ
 jLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747746879; x=1748351679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3Fll2FVKxfx+qeC/g2VSdQVtobn0GEtEO5xtgAUJMo=;
 b=fTIQv5WKdgfHjF315gIU+ujmhJcQQ9uxE3+PdmPR1r6U8nCQLGGlTEvntMaxEQRmBs
 scFpfA9+oqt7BpAomdc7176pWguDQUWxX8prhKn/ZQxtP6u2nDuDXEmTCBUVhIbs9ilx
 e5B406Xl1QlX5a2SMTAPQaRiCiE8z9dp1wM0DmSmAq0+fh7gN6JiT1uSMbSpHk0Mzh/L
 vIJym/q4F8jLqzXxRM6WzTz0rG+ORMykJDOiY/nOGzfK14YsKxf9Z8+BUnLiV1pU0tcx
 gDQHs97DyuRtsllkj4uM6BJpB9WTjj9BSddcws98Kx2mp+EK3sCel7LOo270B3POD0oy
 3KVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcMcYk4jZwfb9uol7tj0DmAld3AdwSGa/R73IWwGvb/vxUm3KsrjlP/YjEKE/zWbgkndHjmzQr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywYV1bJ6aWTr9TXB8LeyAOU/50DAnjSNSZzCdzt+oKzfrPGJmh
 hp3EID+sYH0lV+TvdCR5qHIz77MahePYuhsUfNvliRthAXCgXKbQ/fjQSitRMkatKN57kNU0YNg
 fkrMx9okEJffH9tC7Df5OuJIzp29utmU=
X-Gm-Gg: ASbGnctGp3QIkdNs+cJ6N6EDkVMClQ4fGCuY+9+CGDhxtPl/yxP9H787BIyFpa9CUb0
 msPiO93L6wdqCj+fE+ETj2bjNpS2/2ux0fGbbCfj4YOOsqFjt1UsSA+0kdi2LFanheNVCYCSnwB
 QvTiXMmQlszHvICF/8zTXvJhW61R7JoQ3y0A==
X-Google-Smtp-Source: AGHT+IFRP2hNZNL8STQ9Lmr+Bpr6j1xoQEkrMF1pBcnljURB+lATKDxhrRYNQWLzXXY9q3tNX/y5dVKpXWc4jVrmReU=
X-Received: by 2002:a17:902:d54c:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-231d45168bcmr93096535ad.10.1747746878464; Tue, 20 May 2025
 06:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-2-christian.koenig@amd.com>
 <ggm5pb2sgyfe4irgrizjr4dohvxviob5p7ekqvvul4ktqvqlcj@zubqhw3yeuc4>
In-Reply-To: <ggm5pb2sgyfe4irgrizjr4dohvxviob5p7ekqvvul4ktqvqlcj@zubqhw3yeuc4>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 May 2025 09:14:26 -0400
X-Gm-Features: AX0GCFsptdgviC4_Oj5dKlKkDENwcZ0gUjmrebRh4l1Cg6gUUZue8mQqOJsQQ9Q
Message-ID: <CADnq5_ODb2REjrFm0A=7Di9R-ebjfhLd9YWEv-ciJKQVcX4P4w@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: rework gfx9 queue reset
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Mon, May 19, 2025 at 7:59=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 05/02, Christian K=C3=B6nig wrote:
> > Testing this feature turned out that it was a bit unstable. The
> > CP_VMID_RESET register takes the VMID which all submissions from should
> > be canceled.
> >
> > Unlike Windows Linux uses per process VMIDs instead of per engine VMIDs
> > for the simple reason that we don't have enough. So resetting one VMID
> > only killed the submissions of one specific process.
> >
> > Fortunately that turned out to be exactly what we want to have.
> >
> > So clear the CP_VMID_RESET register between every context switch betwee=
n
> > applications when we do the pipeline sync to avoid trouble if multiple
> > VMIDs are used on the ring right behind each other.
> >
> > Use the same pipeline sync function in the reset handler and issue an I=
B
> > test instead of a ring test after the queue reset to provide a longer
> > timeout and additional fence value should there be additional work on
> > the ring after the one aborted.
> >
> > Also drop the soft recovery since that pretty much does the same thing =
as
> > CP_VMID_RESET, just on a lower level and with less chance of succeeding=
.
> >
> > This now survives a stress test running over night sending a broken
> > submission ever 45 seconds and recovering fine from each of them.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 ++++++++++-----------------
> >  2 files changed, 19 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index cc26cf1bd843..c39fe784419b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
> >  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS               3000
> >  #define AMDGPU_MAX_USEC_TIMEOUT                      100000  /* 100 ms=
 */
> >  #define AMDGPU_FENCE_JIFFIES_TIMEOUT         (HZ / 2)
> > +#define AMDGPU_QUEUE_RESET_TIMEOUT           (HZ / 10)
> >  #define AMDGPU_DEBUGFS_MAX_COMPONENTS                32
> >  #define AMDGPUFB_CONN_LIMIT                  4
> >  #define AMDGPU_BIOS_NUM_SCRATCH                      16
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index d377a7c57d5e..92d9a28c62d3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -5565,7 +5565,17 @@ static void gfx_v9_0_ring_emit_pipeline_sync(str=
uct amdgpu_ring *ring)
> >       int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
> >       uint32_t seq =3D ring->fence_drv.sync_seq;
> >       uint64_t addr =3D ring->fence_drv.gpu_addr;
> > +     struct amdgpu_device *adev =3D ring->adev;
> >
> > +     amdgpu_ring_emit_reg_wait(ring,
> > +                               SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET=
),
> > +                               0, 0xffff);
> > +     amdgpu_ring_emit_wreg(ring,
> > +                           SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
> > +                           0);
> > +     amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > +                            ring->fence_drv.sync_seq,
> > +                            AMDGPU_FENCE_FLAG_EXEC);
> >       gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
> >                             lower_32_bits(addr), upper_32_bits(addr),
> >                             seq, 0xffffffff, 4);
> > @@ -5896,20 +5906,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wai=
t(struct amdgpu_ring *ring,
> >                                                          ref, mask);
> >  }
> >
> > -static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsi=
gned vmid)
> > -{
> > -     struct amdgpu_device *adev =3D ring->adev;
> > -     uint32_t value =3D 0;
> > -
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> > -     value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> > -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> > -     WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> > -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > -}
> > -
> >  static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device =
*adev,
> >                                                enum amdgpu_interrupt_st=
ate state)
> >  {
> > @@ -7185,16 +7181,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_rin=
g *ring, unsigned int vmid)
> >       if (r)
> >               return r;
> >
> > -     if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
> > +     if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
>
> Hi Christian,
>
> What is the meaning of all of the above additions (7 + 7 + 5 + 7)? I see
> it in many different parts of the code. Is this some indication of
> preambles?

It's the number of dwords needed for the operation.  In this case
gfx_v9_0_ring_emit_pipeline_sync() uses 7 + 7 + 5 + 7.  Actually It
should be 7 (gfx_v9_0_wait_reg_mem()) + 7
(amdgpu_ring_emit_reg_wait()) + 5 (amdgpu_ring_emit_wreg()) + 8
(amdgpu_ring_emit_fence()).  Fixed up locally.

Alex

>
> Thanks
>
> >               return -ENOMEM;
> > -     gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > -                              ring->fence_drv.sync_seq, AMDGPU_FENCE_F=
LAG_EXEC);
> > -     gfx_v9_0_ring_emit_reg_wait(ring,
> > -                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RES=
ET), 0, 0xffff);
> > -     gfx_v9_0_ring_emit_wreg(ring,
> > -                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),=
 0);
> > +     gfx_v9_0_ring_emit_pipeline_sync(ring);
> > +     amdgpu_ring_commit(ring);
> >
> > -     return amdgpu_ring_test_ring(ring);
> > +     return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
> >  }
> >
> >  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> > @@ -7437,7 +7429,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ri=
ng_funcs_gfx =3D {
> >       .set_wptr =3D gfx_v9_0_ring_set_wptr_gfx,
> >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> >               5 +  /* COND_EXEC */
> > -             7 +  /* PIPELINE_SYNC */
> > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               2 + /* VM_FLUSH */
> > @@ -7475,7 +7467,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ri=
ng_funcs_gfx =3D {
> >       .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> >       .reset =3D gfx_v9_0_reset_kgq,
> >       .emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> > @@ -7494,7 +7485,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw=
_ring_funcs_gfx =3D {
> >       .set_wptr =3D amdgpu_sw_ring_set_wptr_gfx,
> >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> >               5 +  /* COND_EXEC */
> > -             7 +  /* PIPELINE_SYNC */
> > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               2 + /* VM_FLUSH */
> > @@ -7533,7 +7524,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw=
_ring_funcs_gfx =3D {
> >       .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> >       .patch_cntl =3D gfx_v9_0_ring_patch_cntl,
> >       .patch_de =3D gfx_v9_0_ring_patch_de_meta,
> > @@ -7555,7 +7545,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ri=
ng_funcs_compute =3D {
> >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >               5 + /* hdp invalidate */
> > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence=
, vm fence */
> > @@ -7577,7 +7567,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ri=
ng_funcs_compute =3D {
> >       .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> >       .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
> >       .reset =3D gfx_v9_0_reset_kcq,
> > @@ -7598,7 +7587,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ri=
ng_funcs_kiq =3D {
> >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> >               5 + /* hdp invalidate */
> > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> >               8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fe=
nce, vm fence */
> > --
> > 2.34.1
> >
>
> --
> Rodrigo Siqueira
