Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997EDC54F30
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 02:50:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA12A10E033;
	Wed, 28 May 2025 02:50:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ph/vjXh4";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30FD688EBA
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:50:08 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-30ec619deecso379985a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 19:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748400607; x=1749005407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8xfks5ZP+TImGllsAS4MNxE3ZE6Lghrn7N0zz4D6ILo=;
 b=Ph/vjXh4MdaqQtMy+O8s4E4cnbqE626nHQ5m4CVdJtXx3UawWqaGyBByErZIUNyg+H
 q6p6VbI2vt8SZ3XlmoUq0eQ7GYzmhRraY8ytKvv47Z/qUJk6rdMk/7EVb4Hj3h8P8nfs
 65K51NRooBX4+xSNcH9jvZZvsnUjD8daisHpXxlPHtbSKoMEv9tTBpVTJu1bxGWPT5Z0
 P3UurrKrjnWmuc10O1hyYADhofzF1F8mFD+a8Fa75VA9v3ql//+HO+USf3H1sHK3kQMd
 pcL53L1LHW91Nqll1vIx6cTfzMp/cEwkYd+XOHiXfBUBbzwYS8vao9lhpjRc9bHCN2Zq
 2SBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748400607; x=1749005407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8xfks5ZP+TImGllsAS4MNxE3ZE6Lghrn7N0zz4D6ILo=;
 b=LADTqJWsWCrzCZ4V2Qe0tbe5buqpUdKOhtAKg7ffd1L/FhETTzLYAEmhZvqkbYScDn
 cgwX7pCWYbCMMJHujn6731GorxxX2QlxuMGD3FkLG5tkLS98LVwzRIYiBaeMKY9nfnbC
 HKSFwXWFb6odqRAm02bfkWeb18pOI8+ENra0Kd4tegw4vsZS5Brq7zZ2ibcadIH3kXBu
 fDt6UYfPEr7gU9ayCitwY1mLb2ZjXTTf57KeFVWDurvtrdy+0nOfLcDPNGvKwQDeXRDg
 +exSwEqk8nQhI5bXIb4NiWpPgKPhxHDkPIY3w9uvBbyDhRBF0cuTNe8mPMxzba3eF8S9
 EYYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYVH43h5I1VYkErFmOAnlFze2CoQ+0MYj8UV4AgzyeIvjGah+4g7cMPBrVOm9GJugsRq+tw3pg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwVu+ONXxQBLV7cnQoDktZrG1RE+AHaFEKPKdbbIwcer934b9l
 ecfMbHtY9tyh//2cuW0r0shyK+Fp8IV1zvlCIkojS3uAkk+WedAAzuyyhUO/8JNzqINPAFGPNcT
 ZHYKAHMPHykZ/cbyv/YHULQybESUpu8E=
X-Gm-Gg: ASbGncvtumtuDcUZj67rI+/QTKr1SgfBqOgx3EDjIDbU3EEnlfal6TA+5IU3Du9Tz8B
 iRqOWvvgDvRs+pSX0vWRzSM/nL45WKEh0XSg76GqwHZMwqws/I6whvJ3ldkMvhgX55O+NCt2Jtn
 kyKmRTm18XSBYHdh6uMgQgOQ6iQ7c4GkDdww==
X-Google-Smtp-Source: AGHT+IHQn+ixto3vChVpKWGw5jhxOxpIlAfMBYaXjKc00SUPcd4f/CnRifGoKxWjDDXqheznTn3jWG9rPaoEsfQwL/A=
X-Received: by 2002:a17:90b:3b92:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-311e1b168d5mr566093a91.7.1748400607454; Tue, 27 May 2025
 19:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250502161720.1704-1-christian.koenig@amd.com>
 <20250502161720.1704-2-christian.koenig@amd.com>
 <ggm5pb2sgyfe4irgrizjr4dohvxviob5p7ekqvvul4ktqvqlcj@zubqhw3yeuc4>
 <CADnq5_ODb2REjrFm0A=7Di9R-ebjfhLd9YWEv-ciJKQVcX4P4w@mail.gmail.com>
 <3hdl7edrmxxubp2mm3lxarszvtwj3wsau6sy2itolcdb3yqdnj@euf4wn2ohxkg>
In-Reply-To: <3hdl7edrmxxubp2mm3lxarszvtwj3wsau6sy2itolcdb3yqdnj@euf4wn2ohxkg>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 May 2025 22:49:55 -0400
X-Gm-Features: AX0GCFsE-cjJBCCtQg3QiAjtr2FdCMQXbBGzmQO33MAGrNIQnvwGA9XmYtBGvJY
Message-ID: <CADnq5_MKYNYuEDSj50=7ucv7L4mU-kZa6yPsb4SRGwdzcmgofQ@mail.gmail.com>
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

On Tue, May 27, 2025 at 12:39=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> On 05/20, Alex Deucher wrote:
> > On Mon, May 19, 2025 at 7:59=E2=80=AFPM Rodrigo Siqueira <siqueira@igal=
ia.com> wrote:
> > >
> > > On 05/02, Christian K=C3=B6nig wrote:
> > > > Testing this feature turned out that it was a bit unstable. The
> > > > CP_VMID_RESET register takes the VMID which all submissions from sh=
ould
> > > > be canceled.
> > > >
> > > > Unlike Windows Linux uses per process VMIDs instead of per engine V=
MIDs
> > > > for the simple reason that we don't have enough. So resetting one V=
MID
> > > > only killed the submissions of one specific process.
> > > >
> > > > Fortunately that turned out to be exactly what we want to have.
> > > >
> > > > So clear the CP_VMID_RESET register between every context switch be=
tween
> > > > applications when we do the pipeline sync to avoid trouble if multi=
ple
> > > > VMIDs are used on the ring right behind each other.
>
> Sorry, but could you elaborate a little bit more on what it is this
> pipeline sync?

pipeline sync waits for the previous job to complete before the next job st=
arts.

>
> > > >
> > > > Use the same pipeline sync function in the reset handler and issue =
an IB
> > > > test instead of a ring test after the queue reset to provide a long=
er
> > > > timeout and additional fence value should there be additional work =
on
> > > > the ring after the one aborted.
> > > >
> > > > Also drop the soft recovery since that pretty much does the same th=
ing as
> > > > CP_VMID_RESET, just on a lower level and with less chance of succee=
ding.
>
> It appears that the soft recovery has passed the time validation, and in
> some ways, it is stable. How about to keep this approach as a fallback
> solution?

We can definitely keep it where queue reset is not available.  Queue
reset is able to recover from more hang cases.

>
> > > >
> > > > This now survives a stress test running over night sending a broken
> > > > submission ever 45 seconds and recovering fine from each of them.
>
> What is this stress test? Some sort of IGT test? Is it publicly
> available?
>
> > > >
> > > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 ++++++++++-------------=
----
> > > >  2 files changed, 19 insertions(+), 29 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu.h
> > > > index cc26cf1bd843..c39fe784419b 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > @@ -278,6 +278,7 @@ extern int amdgpu_user_queue;
> > > >  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS               3000
> > > >  #define AMDGPU_MAX_USEC_TIMEOUT                      100000  /* 10=
0 ms */
> > > >  #define AMDGPU_FENCE_JIFFIES_TIMEOUT         (HZ / 2)
> > > > +#define AMDGPU_QUEUE_RESET_TIMEOUT           (HZ / 10)
> > > >  #define AMDGPU_DEBUGFS_MAX_COMPONENTS                32
> > > >  #define AMDGPUFB_CONN_LIMIT                  4
> > > >  #define AMDGPU_BIOS_NUM_SCRATCH                      16
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/dr=
m/amd/amdgpu/gfx_v9_0.c
> > > > index d377a7c57d5e..92d9a28c62d3 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > @@ -5565,7 +5565,17 @@ static void gfx_v9_0_ring_emit_pipeline_sync=
(struct amdgpu_ring *ring)
> > > >       int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX=
);
> > > >       uint32_t seq =3D ring->fence_drv.sync_seq;
> > > >       uint64_t addr =3D ring->fence_drv.gpu_addr;
> > > > +     struct amdgpu_device *adev =3D ring->adev;
>
> btw, you don't need this variable.

I think it's needed by the register macros.

>
> > > >
> > > > +     amdgpu_ring_emit_reg_wait(ring,
> > > > +                               SOC15_REG_OFFSET(GC, 0, mmCP_VMID_R=
ESET),
> > > > +                               0, 0xffff);
> > > > +     amdgpu_ring_emit_wreg(ring,
> > > > +                           SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET=
),
> > > > +                           0);
> > > > +     amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > > > +                            ring->fence_drv.sync_seq,
> > > > +                            AMDGPU_FENCE_FLAG_EXEC);
>
> Just for curiosity, why do we need reg_wait in the beginning and
> emit_fence in the end? Why not just use emit_wreg directly?

That's the programming sequence for the reset.  You program the
CP_VMID_RESET register and then you wait for it to go to 0, then write
0 to it, then wait on the fence.  In theory is just resets the
pipeline state associated with the vmid, but in practice it doesn't
seem to work that way.

Alex

>
> > > >       gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
> > > >                             lower_32_bits(addr), upper_32_bits(addr=
),
> > > >                             seq, 0xffffffff, 4);
> > > > @@ -5896,20 +5906,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg=
_wait(struct amdgpu_ring *ring,
> > > >                                                          ref, mask)=
;
> > > >  }
> > > >
> > > > -static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, =
unsigned vmid)
> > > > -{
> > > > -     struct amdgpu_device *adev =3D ring->adev;
> > > > -     uint32_t value =3D 0;
> > > > -
> > > > -     value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> > > > -     value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> > > > -     value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> > > > -     value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> > > > -     amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> > > > -     WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> > > > -     amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> > > > -}
> > > > -
> > > >  static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_dev=
ice *adev,
> > > >                                                enum amdgpu_interrup=
t_state state)
> > > >  {
> > > > @@ -7185,16 +7181,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu=
_ring *ring, unsigned int vmid)
> > > >       if (r)
> > > >               return r;
> > > >
> > > > -     if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
> > > > +     if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
> > >
> > > Hi Christian,
> > >
> > > What is the meaning of all of the above additions (7 + 7 + 5 + 7)? I =
see
> > > it in many different parts of the code. Is this some indication of
> > > preambles?
> >
> > It's the number of dwords needed for the operation.  In this case
> > gfx_v9_0_ring_emit_pipeline_sync() uses 7 + 7 + 5 + 7.  Actually It
> > should be 7 (gfx_v9_0_wait_reg_mem()) + 7
> > (amdgpu_ring_emit_reg_wait()) + 5 (amdgpu_ring_emit_wreg()) + 8
> > (amdgpu_ring_emit_fence()).  Fixed up locally.
>
> Nice! Thanks for the explantion.
>
> Thanks
> Siqueira
>
> >
> > Alex
> >
> > >
> > > Thanks
> > >
> > > >               return -ENOMEM;
> > > > -     gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> > > > -                              ring->fence_drv.sync_seq, AMDGPU_FEN=
CE_FLAG_EXEC);
> > > > -     gfx_v9_0_ring_emit_reg_wait(ring,
> > > > -                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID=
_RESET), 0, 0xffff);
> > > > -     gfx_v9_0_ring_emit_wreg(ring,
> > > > -                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RES=
ET), 0);
> > > > +     gfx_v9_0_ring_emit_pipeline_sync(ring);
> > > > +     amdgpu_ring_commit(ring);
> > > >
> > > > -     return amdgpu_ring_test_ring(ring);
> > > > +     return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT=
);
> > > >  }
> > > >
> > > >  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> > > > @@ -7437,7 +7429,7 @@ static const struct amdgpu_ring_funcs gfx_v9_=
0_ring_funcs_gfx =3D {
> > > >       .set_wptr =3D gfx_v9_0_ring_set_wptr_gfx,
> > > >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> > > >               5 +  /* COND_EXEC */
> > > > -             7 +  /* PIPELINE_SYNC */
> > > > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> > > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > > >               2 + /* VM_FLUSH */
> > > > @@ -7475,7 +7467,6 @@ static const struct amdgpu_ring_funcs gfx_v9_=
0_ring_funcs_gfx =3D {
> > > >       .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> > > >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> > > >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg=
_wait,
> > > > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> > > >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> > > >       .reset =3D gfx_v9_0_reset_kgq,
> > > >       .emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> > > > @@ -7494,7 +7485,7 @@ static const struct amdgpu_ring_funcs gfx_v9_=
0_sw_ring_funcs_gfx =3D {
> > > >       .set_wptr =3D amdgpu_sw_ring_set_wptr_gfx,
> > > >       .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
> > > >               5 +  /* COND_EXEC */
> > > > -             7 +  /* PIPELINE_SYNC */
> > > > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> > > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > > >               2 + /* VM_FLUSH */
> > > > @@ -7533,7 +7524,6 @@ static const struct amdgpu_ring_funcs gfx_v9_=
0_sw_ring_funcs_gfx =3D {
> > > >       .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> > > >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> > > >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg=
_wait,
> > > > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> > > >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> > > >       .patch_cntl =3D gfx_v9_0_ring_patch_cntl,
> > > >       .patch_de =3D gfx_v9_0_ring_patch_de_meta,
> > > > @@ -7555,7 +7545,7 @@ static const struct amdgpu_ring_funcs gfx_v9_=
0_ring_funcs_compute =3D {
> > > >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> > > >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> > > >               5 + /* hdp invalidate */
> > > > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > > > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> > > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > > >               8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user f=
ence, vm fence */
> > > > @@ -7577,7 +7567,6 @@ static const struct amdgpu_ring_funcs gfx_v9_=
0_ring_funcs_compute =3D {
> > > >       .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> > > >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> > > >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg=
_wait,
> > > > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> > > >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> > > >       .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
> > > >       .reset =3D gfx_v9_0_reset_kcq,
> > > > @@ -7598,7 +7587,7 @@ static const struct amdgpu_ring_funcs gfx_v9_=
0_ring_funcs_kiq =3D {
> > > >               20 + /* gfx_v9_0_ring_emit_gds_switch */
> > > >               7 + /* gfx_v9_0_ring_emit_hdp_flush */
> > > >               5 + /* hdp invalidate */
> > > > -             7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> > > > +             7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
> > > >               SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> > > >               SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> > > >               8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for use=
r fence, vm fence */
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > --
> > > Rodrigo Siqueira
>
> --
> Rodrigo Siqueira
