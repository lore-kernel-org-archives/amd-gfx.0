Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B660D6D232
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 15:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA96210E0C3;
	Thu, 18 Dec 2025 15:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCluH2Gj";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA9610E0C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 15:58:57 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b9a2e3c4afcso43518a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 07:58:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766073537; cv=none;
 d=google.com; s=arc-20240605;
 b=jAQJF86VRXr0DIlEhdeXdm5RaGeBiTy2txLYpprr0y0OqEYT8DobbMpaeXnCkS92j0
 PcHxwuR/mf8pCbpE54Ct2kCq6OnFXr3Z5jE1YXOj5SmbeFakTqc1FV/c4bvdxwNBpTX4
 tD0b7njGekRIKRiPBbGaqYu2k0pYBgjVUZmZPNTDswXUuMjtAo3NIo46pgZKbvKS18Wq
 c7MZLx9z9RZSBw6KclLdrbWtt0XbAks8uF8tSMNqVALBtMpxldhuuMWWjKerxulo68ah
 fq8bzndPGvXSnQvVQRnh/AerDKKKxAcuJ9Dkxo+44dg759nlCPAKVddJRZRaunqONxxI
 aKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EV1QQhrya62FYIdd8hfQsOHnD1zT+0en4pWxm0aZifI=;
 fh=TWw7CjKH/oUmBDR6co52ihjCaPrF1ed6XoUc5ohkm2I=;
 b=LxDTYxnRffDGOW9T2uF1OFcAlLrazIu1MUI+uA5URvV6Diq3X0JTwA7w1HrPZucN7J
 0O5T56y6gbiDxMsQ5+EVfLU23Xuf7RtbaWas/MpSAsUZBoz9FByLHVEdstNY7TCONs5C
 ObRS32qTWyTvm62YoaAIEgCX+3mAvac6SXseY9THY1srni1+9283SNtEEEGlaOH9H/2S
 3hJslMn0yp116W8xckXkXrPb9cq/NiXwzWCupZf8WVRvub1B7nUvT25oGZGK099rjJ7N
 fj3LLAhPMJCcMmD+EtnJd7sbUCogfkiQH/jKiw1ghyMzg6mufX/ghentAvPGPDrr4xnN
 fI6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766073537; x=1766678337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV1QQhrya62FYIdd8hfQsOHnD1zT+0en4pWxm0aZifI=;
 b=CCluH2Gjas4O8lxp6e0UgaN9IO8zBOyta1rj9r8EJFAwrzpBsqGSeXMBkUPBFTDZPI
 oN0fMXaEh09LcQenUU9YUnWfLomRSZ5K0jXuol/esoP9WPoCRi/+DG19iXqV8wMJaCjo
 S2u5JO7oMQ8qHSwFMXre9QP9val2RDbVPWHiG88YXYhJJf10vQfe6C+1vBANnxibYtgx
 8/92s2P+TBlPtZQtz34HwZ2mVgEsGfz/4xbC/XzLGxCKnGVw3HsGdSy85Pm/S0Nr8xTQ
 WpLm+M2B0MyV+8P5riRfrhtPq2d1fnFJkagzpRqeipdqvra92kndJgaol/973bkJ4+JH
 IQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766073537; x=1766678337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EV1QQhrya62FYIdd8hfQsOHnD1zT+0en4pWxm0aZifI=;
 b=uZPvrq38c7IEZ2nSnFkyad1mRJvgKWM7hI/PY6Y02Y1S+Jj707/j9lvZJ+HU+VPFtx
 3x9aH06a5Xfg+q/vEUvfq5BKjFzZBOPQh7tsB7cOZ5hRYWS6tbm0TYXQKlFSWKsE5BLQ
 Cvkc+SDZIQnWX8RtJkIAb/PBdnwCB6WoUwufLyUK15nCEWnKfkFrJNkjZPLVckg/vxAj
 3GtKLkoYqjARd6fr+wG1Wiko1BYF1WFd3YHawk8JLP6xSQQ+CulQq4m2W7VRIq3osB38
 U9u6eDT/OPmp4lsK0Y+iG1yMTKJeCpx4N6VYFCaz3ZpxfQyvxG3nx9WAmaWGR+IZfqG+
 DK3g==
X-Gm-Message-State: AOJu0YzQQeFRJYRcPCA0pUsNXcxoHIwdhOD4wiR2KENY4ZdkajW3OX4J
 KwU5hekZbvgKUjJZGoVgtRDb2WZAWeVKgJ0UloT4SiedWiacHcrLVzzEoScU7dhPm+HV35CKG7y
 /7Pr0oxtDL4bzPJtUV2fKpimaChLqu64=
X-Gm-Gg: AY/fxX7gZvZ+XAYGWK40olzrems3Ei9Lgwus5eQlTG1i6BUi4GKZkdLGtJlBFkwRMVN
 kPF7gdzafyLhTEXBCEpF8wvOplO0rc/n3C4qxC9Y6ZH8c+EHDhxSFfhNpIqoiQlNwLlb67Qa6mH
 TZ1f5tD7bajOQcsjtxk+yfUrZ19OTU9vH63Twzd3GyFc7hKvGa58Vk7mBwl521HSKAT6dszUMBj
 M125GzjcfbBPPXe7Exm7dzp82feX//mh2FVWTLJ+nDZ0qVw64MSYMG+g549c+6szlmEVZKN
X-Google-Smtp-Source: AGHT+IFj0FfWQP2lpCSS07veH6Vgc6Z3ZYlq0I24JPkQiSH6Gq4D6pzcJJRi+NTUzXpvDITgG4cGDT/Qpn1utjNRUak=
X-Received: by 2002:a05:7022:2491:b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-120627a3f6amr1643881c88.0.1766073537034; Thu, 18 Dec 2025
 07:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <20251215160711.11832-6-alexander.deucher@amd.com>
 <2952111.fDdHjke4Dd@timur-max>
In-Reply-To: <2952111.fDdHjke4Dd@timur-max>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Dec 2025 10:58:45 -0500
X-Gm-Features: AQt7F2oqjL917y795likgncilKSEgr10GBtrwTuA2bNmA94_zRxWRd7-BK9pDVY
Message-ID: <CADnq5_OdBWFJJEAH9_YikzVXw-JcGCF1E6OnUhruw+_F0H9E3w@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Dec 18, 2025 at 12:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On 2025. december 15., h=C3=A9tf=C5=91 10:07:11 k=C3=B6z=C3=A9ps=C5=91 =
=C3=A1llamokbeli z=C3=B3naid=C5=91 Alex Deucher
> wrote:
> > GFX ring resets work differently on pre-GFX10 hardware since
> > there is no MQD managed by the scheduler.
> > For ring reset, you need issue the reset via CP_VMID_RESET
> > via KIQ or MMIO and submit the following to the gfx ring to
> > complete the reset:
> > 1. EOP packet with EXEC bit set
> > 2. WAIT_REG_MEM to wait for the fence
> > 3. Clear CP_VMID_RESET to 0
> > 4. EVENT_WRITE ENABLE_LEGACY_PIPELINE
> > 5. EOP packet with EXEC bit set
> > 6. WAIT_REG_MEM to wait for the fence
> > Once those commands have completed the reset should
> > be complete and the ring can accept new packets.
> >
> > However, because we have a pipeline sync between jobs,
> > the PFP is waiting on the fence from the bad job to signal so
> > it can't process any of the packets in the reset sequence
> > until that pipeline sync clears.  To unblock the PFP, we
> > use the KIQ to signal the fence after we reset the queue.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 104 +++++++++++++++++++++++++-
> >  1 file changed, 101 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index bb1465a98c7ca..9b70736503=
15e
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -2410,8 +2410,10 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_blo=
ck
> > *ip_block) amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> >       adev->gfx.compute_supported_reset =3D
> >               amdgpu_get_soft_full_reset_mask(&adev-
> >gfx.compute_ring[0]);
> > -     if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset=
)
> > +     if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_reset=
)
> {
> >               adev->gfx.compute_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> > +             adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_PER_QUEUE;
> > +     }
> >
> >       r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
> >       if (r) {
> > @@ -7163,6 +7165,103 @@ static void gfx_v9_ring_insert_nop(struct
> > amdgpu_ring *ring, uint32_t num_nop) amdgpu_ring_insert_nop(ring, num_n=
op -
> > 1);
> >  }
> >
> > +static void gfx_v9_0_ring_emit_wreg_me(struct amdgpu_ring *ring,
> > +                                    uint32_t reg,
> > +                                    uint32_t val)
> > +{
> > +     uint32_t cmd =3D 0;
> > +
> > +     switch (ring->funcs->type) {
> > +     case AMDGPU_RING_TYPE_KIQ:
> > +             cmd =3D (1 << 16); /* no inc addr */
>
> What do you mean by "inc addr" in this context?

It's part of the packet.  bit 16 controls whether the address is
incremented or not.  This function is basically the same as
gfx_v9_0_ring_emit_wreg(), but uses the ME to do the wait rather than
the PFP.  I could have alternatively added a new parameter to
gfx_v9_0_ring_emit_wreg() to select between PFP and ME.

>
> > +             break;
> > +     default:
> > +             cmd =3D WR_CONFIRM;
> > +             break;
> > +     }
> > +     amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> > +     amdgpu_ring_write(ring, cmd);
> > +     amdgpu_ring_write(ring, reg);
> > +     amdgpu_ring_write(ring, 0);
> > +     amdgpu_ring_write(ring, val);
> > +}
> > +
> > +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
> > +                                        uint32_t event_type,
> > +                                        uint32_t
> event_index)
> > +{
> > +     amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> > +     amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> > +                       EVENT_INDEX(event_index));
> > +}
> > +
> > +static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
> > +                           unsigned int vmid,
> > +                           struct amdgpu_fence *timedout_fence)
> > +{
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > +     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > +     unsigned long flags;
> > +     u32 tmp;
> > +     int r;
> > +
> > +     amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > +
> > +     spin_lock_irqsave(&kiq->ring_lock, flags);
> > +
> > +     if (amdgpu_ring_alloc(kiq_ring, 5 + 5)) {
> > +             spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* send the reset - 5 */
> > +     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid)=
;
> > +     gfx_v9_0_ring_emit_wreg(kiq_ring,
> > +                             SOC15_REG_OFFSET(GC, 0,
> mmCP_VMID_RESET), tmp);
> > +     /* emit the fence to clear the pipeline sync - 5 */
> > +     gfx_v9_0_ring_emit_fence_kiq(kiq_ring, ring->fence_drv.gpu_addr,
> > +                                  timedout_fence->base.seqno,
> 0);
>
> As far as I see, this isn't going to work when sched_hw_submission > 2 an=
d
> there are more than two jobs (from various different userspace processes)
> emitted in the ring.
>
> I can think of two possible solutons:
> - Emit each fence individually, with a short delay in between to give a c=
hance
> to the GFX ring to catch up with the KIQ.
> - Change the wait_reg_mem command used for the pipeline sync to allow gre=
ater
> than equal instead of just equal. Then it's enough to signal just the las=
t
> fence on the KIQ ring.

That won't work.  The signalling patch is asynchronous so if we signal
additional fences other than the bad one, those jobs will end up being
seen as successfully completed.  That said, there is a change coming
for the firmware to fix this.  I'd suggest we just limit the queue
depth to 2 until the new firmware is available.

>
>
>
> > +     amdgpu_ring_commit(kiq_ring);
> > +     r =3D amdgpu_ring_test_ring(kiq_ring);
> > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > +     if (r)
> > +             return r;
> > +
> > +     if (amdgpu_ring_alloc(ring, 8 + 7 + 5 + 2 + 8 + 7))
> > +             return -ENOMEM;
> > +     /* emit the fence to finish the reset - 8 */
> > +     ring->trail_seq++;
> > +     gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > +                              ring->trail_seq,
> AMDGPU_FENCE_FLAG_EXEC);
> > +     /* wait for the fence - 7 */
> > +     gfx_v9_0_wait_reg_mem(ring, 0, 1, 0,
> > +                           lower_32_bits(ring-
> >trail_fence_gpu_addr),
> > +                           upper_32_bits(ring-
> >trail_fence_gpu_addr),
> > +                           ring->trail_seq, 0xffffffff, 4);
> > +     /* clear mmCP_VMID_RESET - 5 */
> > +     gfx_v9_0_ring_emit_wreg_me(ring,
> > +                                SOC15_REG_OFFSET(GC, 0,
> mmCP_VMID_RESET), 0);
> > +     /* event write ENABLE_LEGACY_PIPELINE - 2 */
> > +     gfx_v9_0_ring_emit_event_write(ring, ENABLE_LEGACY_PIPELINE, 0);
> > +     /* emit a regular fence - 8 */
> > +     ring->trail_seq++;
> > +     gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > +                              ring->trail_seq,
> AMDGPU_FENCE_FLAG_EXEC);
> > +     /* wait for the fence - 7 */
> > +     gfx_v9_0_wait_reg_mem(ring, 1, 1, 0,
> > +                           lower_32_bits(ring-
> >trail_fence_gpu_addr),
> > +                           upper_32_bits(ring-
> >trail_fence_gpu_addr),
> > +                           ring->trail_seq, 0xffffffff, 4);
>
> Why is it necessary to emit (and wait for) a regular fence here?
> I'm not against it, just curious why it's needed.

It's part of the recovery sequence to make sure the
ENABLE_LEGACY_PIPELINE event has completed successfully.

>
> > +     amdgpu_ring_commit(ring);
> > +     /* wait for the commands to complete */
> > +     r =3D amdgpu_ring_test_ring(ring);
> > +     if (r)
> > +             return r;
> > +
> > +     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +}
> > +
> >  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> >                             unsigned int vmid,
> >                             struct amdgpu_fence *timedout_fence)
> > @@ -7441,9 +7540,9 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_ring_funcs_gfx =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>
> Can you please split removing the soft recovery into a separate patch?
>
> Can we talk about removing the soft recovery? For the other chips where i=
t has
> already been removed, it is percieved by users as a regression.

Queue reset is superset of soft recovery.  There's no need for soft
recovery when queue reset is available.

Alex

>
> >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> >       .emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> > +     .reset =3D gfx_v9_0_reset_kgq,
> >       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> >       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
> >  };
> > @@ -7542,7 +7641,6 @@ static const struct amdgpu_ring_funcs
> > gfx_v9_0_ring_funcs_compute =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wre=
g,
> >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> >       .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
> >       .reset =3D gfx_v9_0_reset_kcq,
>
>
>
>
