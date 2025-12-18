Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF3CD6E2BD
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 17:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA5D710E420;
	Thu, 18 Dec 2025 17:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UMA+PlNI";
	dkim-atps=neutral
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A46A810E420
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 17:03:19 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-4510974a6bbso308684b6e.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 09:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766077399; x=1766682199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zlKlMoMLW7T4jPJZibzKYQoBZuKQvi3k+k1AhbmsZqU=;
 b=UMA+PlNI0a3QvdAQocXwexcZ/j39Xos7cN8Vu03bn2APbbCxgYcCQ2rlR18umcinmV
 ua91gA8DqAiMkTO3BZnEFCROMTDNVu/3TE/EjUCDpeG5zZ8snpfxp03ZkBKRlncbLzm8
 zwa+9ly3KpNmx6qSe28nHPHSGhTE9l79FZBPtxF5Ih2X6Hf0wYQrtB6kfztRNaYovclc
 zzxlCY/h5Jge39dL9xOwd2E/lD3Z/sMLh0yFMwXZTneNo0ZAF/RgnxvGFPvoyl25XO5D
 vCH/ZSsSOt/PCMgHHcd5UDnbN3T0AD08VegNrUhAzOigZOKzdR2DgRkkZR0v5gYaRxYm
 ssoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766077399; x=1766682199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zlKlMoMLW7T4jPJZibzKYQoBZuKQvi3k+k1AhbmsZqU=;
 b=MiJeXtNYC5JtrGIMyH8zVoS5kcOp84eNbqbMhKFh44SqWhif4mxUpnfNOM1dVDRh6B
 bN1BA8dCwM/rrC67Ur6X/ql+zO/PPi34CkpLg1QVzQiteNjylclDB/GNSJO7OXgY9EXK
 jSrMNRfSCyXgY+JGx1PRIxrs6NowAWCXw51Hq/LFdg7QWarL36XTPxviDLYgaXiRl9o3
 ZDDM9zAQrfJLr3Fj6DxOGTH8tvFcafgQs5yyWqVHDDiCtzA7hWSvMyMifSXalr5mTMLL
 0+K4fz2EPn9lAQLYJEQGal0ettIA3gFG/wLMyY0qf/6wwofmH87qtvz17SZQZjhyCQfW
 hMcQ==
X-Gm-Message-State: AOJu0Yw4LrfGBsbtvQ2X+BPw0Z1N6hpsV/vMX1Kqp9T8EAv6L2UP0+Ig
 S1YSBPxDtimzNP/xoq3l+PomSFL4OBeHh0bsZxzVbuoDZsrXrNFF2YGB
X-Gm-Gg: AY/fxX7WCXANk+K+t3Vm5uXD5L4K9yY7s/gSNCXPOlmy9fLrCVLLQE5YinfxUDS+JwD
 pVtEWf/vwPCho9W1AQBt01E2g89Ap7KObIku/vxXu4JOaNd3YyACipQ9K1ds4ULzoKFtmakxD01
 y9FquBEvvE3HkWRRdnZ9vwqs5RdfDFz8EHV7XXjwpR8CaxJqf2pYaKMCKO7wdZTSWRT/tNLvWKA
 htQXxBjvD24V3RSbfGZikHwDt45xY5UsQXCvqhnJP8THwIJgkQ0wGYANmyfqxFBbo0xK75TsseB
 nPmr4s7QBsF7p6xrOAi4DdS795wu4H0A5yG3j4X3Mb9XSiTWfV0beGgITPYBXXwS1UqQUXBM44k
 xROg+Ebpds4gCLTPFAaGCCuEQZrsh6ZbJs0yW3TRLrSlpYfAV+9NaXkdFzyFV1BR1S9pvMXzWW9
 IVSfJcF9cUIKK7TREwRbDOjf/5eoU=
X-Google-Smtp-Source: AGHT+IHRQzbqJWpOy0f8ZjRm52WP2/PqjcbV7eyWUuqwznN3tz+F5yS04Ua376yOngfM5ZDlL5LQCA==
X-Received: by 2002:a05:6808:1a01:b0:453:ee6:12b3 with SMTP id
 5614622812f47-457b21e1efemr138278b6e.58.1766077398097; 
 Thu, 18 Dec 2025 09:03:18 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fa18024d96sm1951511fac.22.2025.12.18.09.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 09:03:17 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6/6] drm/amdgpu/gfx9: Implement KGQ ring reset
Date: Thu, 18 Dec 2025 11:03:15 -0600
Message-ID: <98350545.IzOArtZ34E@timur-max>
In-Reply-To: <CADnq5_OdBWFJJEAH9_YikzVXw-JcGCF1E6OnUhruw+_F0H9E3w@mail.gmail.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <2952111.fDdHjke4Dd@timur-max>
 <CADnq5_OdBWFJJEAH9_YikzVXw-JcGCF1E6OnUhruw+_F0H9E3w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 18., cs=C3=BCt=C3=B6rt=C3=B6k 9:58:45 k=C3=B6z=C3=A9ps=C5=
=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex=20
Deucher wrote:
> On Thu, Dec 18, 2025 at 12:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kristo=
f@gmail.com>=20
wrote:
> > On 2025. december 15., h=C3=A9tf=C5=91 10:07:11 k=C3=B6z=C3=A9ps=C5=91 =
=C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> > Deucher>=20
> > wrote:
> > > GFX ring resets work differently on pre-GFX10 hardware since
> > > there is no MQD managed by the scheduler.
> > > For ring reset, you need issue the reset via CP_VMID_RESET
> > > via KIQ or MMIO and submit the following to the gfx ring to
> > > complete the reset:
> > > 1. EOP packet with EXEC bit set
> > > 2. WAIT_REG_MEM to wait for the fence
> > > 3. Clear CP_VMID_RESET to 0
> > > 4. EVENT_WRITE ENABLE_LEGACY_PIPELINE
> > > 5. EOP packet with EXEC bit set
> > > 6. WAIT_REG_MEM to wait for the fence
> > > Once those commands have completed the reset should
> > > be complete and the ring can accept new packets.
> > >=20
> > > However, because we have a pipeline sync between jobs,
> > > the PFP is waiting on the fence from the bad job to signal so
> > > it can't process any of the packets in the reset sequence
> > > until that pipeline sync clears.  To unblock the PFP, we
> > > use the KIQ to signal the fence after we reset the queue.
> > >=20
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >=20
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 104 ++++++++++++++++++++++++=
+-
> > >  1 file changed, 101 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c index
> > > bb1465a98c7ca..9b7073650315e
> > > 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -2410,8 +2410,10 @@ static int gfx_v9_0_sw_init(struct
> > > amdgpu_ip_block
> > > *ip_block) amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> > >=20
> > >       adev->gfx.compute_supported_reset =3D
> > >      =20
> > >               amdgpu_get_soft_full_reset_mask(&adev-
> > >
> > >gfx.compute_ring[0]);
> > >
> > > -     if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_res=
et)
> > > +     if (!amdgpu_sriov_vf(adev) && !adev->debug_disable_gpu_ring_res=
et)
> >=20
> > {
> >=20
> > >               adev->gfx.compute_supported_reset |=3D
> >=20
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> >=20
> > > +             adev->gfx.gfx_supported_reset |=3D
> >=20
> > AMDGPU_RESET_TYPE_PER_QUEUE;
> >=20
> > > +     }
> > >=20
> > >       r =3D amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
> > >       if (r) {
> > >=20
> > > @@ -7163,6 +7165,103 @@ static void gfx_v9_ring_insert_nop(struct
> > > amdgpu_ring *ring, uint32_t num_nop) amdgpu_ring_insert_nop(ring,
> > > num_nop -
> > > 1);
> > >=20
> > >  }
> > >=20
> > > +static void gfx_v9_0_ring_emit_wreg_me(struct amdgpu_ring *ring,
> > > +                                    uint32_t reg,
> > > +                                    uint32_t val)
> > > +{
> > > +     uint32_t cmd =3D 0;
> > > +
> > > +     switch (ring->funcs->type) {
> > > +     case AMDGPU_RING_TYPE_KIQ:
> > > +             cmd =3D (1 << 16); /* no inc addr */
> >=20
> > What do you mean by "inc addr" in this context?
>=20
> It's part of the packet.  bit 16 controls whether the address is
> incremented or not.  This function is basically the same as
> gfx_v9_0_ring_emit_wreg(), but uses the ME to do the wait rather than
> the PFP.  I could have alternatively added a new parameter to
> gfx_v9_0_ring_emit_wreg() to select between PFP and ME.

Thanks. I was just not familiar with this field of the packet.

>=20
> > > +             break;
> > > +     default:
> > > +             cmd =3D WR_CONFIRM;
> > > +             break;
> > > +     }
> > > +     amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
> > > +     amdgpu_ring_write(ring, cmd);
> > > +     amdgpu_ring_write(ring, reg);
> > > +     amdgpu_ring_write(ring, 0);
> > > +     amdgpu_ring_write(ring, val);
> > > +}
> > > +
> > > +static void gfx_v9_0_ring_emit_event_write(struct amdgpu_ring *ring,
> > > +                                        uint32_t event_type,
> > > +                                        uint32_t
> >=20
> > event_index)
> >=20
> > > +{
> > > +     amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE, 0));
> > > +     amdgpu_ring_write(ring, EVENT_TYPE(event_type) |
> > > +                       EVENT_INDEX(event_index));
> > > +}
> > > +
> > > +static int gfx_v9_0_reset_kgq(struct amdgpu_ring *ring,
> > > +                           unsigned int vmid,
> > > +                           struct amdgpu_fence *timedout_fence)
> > > +{
> > > +     struct amdgpu_device *adev =3D ring->adev;
> > > +     struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> > > +     struct amdgpu_ring *kiq_ring =3D &kiq->ring;
> > > +     unsigned long flags;
> > > +     u32 tmp;
> > > +     int r;
> > > +
> > > +     amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > > +
> > > +     spin_lock_irqsave(&kiq->ring_lock, flags);
> > > +
> > > +     if (amdgpu_ring_alloc(kiq_ring, 5 + 5)) {
> > > +             spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     /* send the reset - 5 */
> > > +     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmi=
d);
> > > +     gfx_v9_0_ring_emit_wreg(kiq_ring,
> > > +                             SOC15_REG_OFFSET(GC, 0,
> >=20
> > mmCP_VMID_RESET), tmp);
> >=20
> > > +     /* emit the fence to clear the pipeline sync - 5 */
> > > +     gfx_v9_0_ring_emit_fence_kiq(kiq_ring, ring->fence_drv.gpu_addr,
> > > +                                  timedout_fence->base.seqno,
> >=20
> > 0);
> >=20
> > As far as I see, this isn't going to work when sched_hw_submission > 2 =
and
> > there are more than two jobs (from various different userspace processe=
s)
> > emitted in the ring.
> >=20
> > I can think of two possible solutons:
> > - Emit each fence individually, with a short delay in between to give a
> > chance to the GFX ring to catch up with the KIQ.
> > - Change the wait_reg_mem command used for the pipeline sync to allow
> > greater than equal instead of just equal. Then it's enough to signal ju=
st
> > the last fence on the KIQ ring.
>=20
> That won't work.  The signalling patch is asynchronous so if we signal
> additional fences other than the bad one, those jobs will end up being
> seen as successfully completed.

Yeah, I already realized that after I sent the email, and sent a follow-up=
=20
email with a different suggestion, that is to change the pipeline sync to n=
ot=20
rely on the fence of the previous submission. eg. the pipeline sync could e=
mit=20
a separate fence, or even simpler, an ACQUIRE_MEM (gfx9+) / SURFACE_SYNC=20
(gfx6-8). Then this becomes a non-issue.

What do you think about that?

> That said, there is a change coming
> for the firmware to fix this.=20

That's very nice to hear that AMD is still willing to fix firmware for old =
chips=20
like Vega. However,

=2D Would be nice to solve the problem for users who are still running old=
=20
firmware, as it doesn't seem too difficult to do so.
=2D AFAIK gfx7-8 also use the same queue reset mechanism so I think they ma=
y be=20
susceptible to the same issue (and I don't think anyone's gonna release new=
 FW=20
for those).

> I'd suggest we just limit the queue
> depth to 2 until the new firmware is available.

Last I heard of it, the SteamOS kernel set it to 4 due to "CPU bubbles" tha=
t=20
they observed with the default setting of 2 on the Steam Deck. I think on t=
he=20
long term we should seriously consider increasing the default in upstream a=
s=20
well.

>=20
> > > +     amdgpu_ring_commit(kiq_ring);
> > > +     r =3D amdgpu_ring_test_ring(kiq_ring);
> > > +     spin_unlock_irqrestore(&kiq->ring_lock, flags);
> > > +     if (r)
> > > +             return r;
> > > +
> > > +     if (amdgpu_ring_alloc(ring, 8 + 7 + 5 + 2 + 8 + 7))
> > > +             return -ENOMEM;
> > > +     /* emit the fence to finish the reset - 8 */
> > > +     ring->trail_seq++;
> > > +     gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > > +                              ring->trail_seq,
> >=20
> > AMDGPU_FENCE_FLAG_EXEC);
> >=20
> > > +     /* wait for the fence - 7 */
> > > +     gfx_v9_0_wait_reg_mem(ring, 0, 1, 0,
> > > +                           lower_32_bits(ring-
> > >
> > >trail_fence_gpu_addr),
> > >
> > > +                           upper_32_bits(ring-
> > >
> > >trail_fence_gpu_addr),
> > >
> > > +                           ring->trail_seq, 0xffffffff, 4);
> > > +     /* clear mmCP_VMID_RESET - 5 */
> > > +     gfx_v9_0_ring_emit_wreg_me(ring,
> > > +                                SOC15_REG_OFFSET(GC, 0,
> >=20
> > mmCP_VMID_RESET), 0);
> >=20
> > > +     /* event write ENABLE_LEGACY_PIPELINE - 2 */
> > > +     gfx_v9_0_ring_emit_event_write(ring, ENABLE_LEGACY_PIPELINE, 0);
> > > +     /* emit a regular fence - 8 */
> > > +     ring->trail_seq++;
> > > +     gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> > > +                              ring->trail_seq,
> >=20
> > AMDGPU_FENCE_FLAG_EXEC);
> >=20
> > > +     /* wait for the fence - 7 */
> > > +     gfx_v9_0_wait_reg_mem(ring, 1, 1, 0,
> > > +                           lower_32_bits(ring-
> > >
> > >trail_fence_gpu_addr),
> > >
> > > +                           upper_32_bits(ring-
> > >
> > >trail_fence_gpu_addr),
> > >
> > > +                           ring->trail_seq, 0xffffffff, 4);
> >=20
> > Why is it necessary to emit (and wait for) a regular fence here?
> > I'm not against it, just curious why it's needed.
>=20
> It's part of the recovery sequence to make sure the
> ENABLE_LEGACY_PIPELINE event has completed successfully.

Ah, okay. I didn't realize that we needed fences after EVENT_WRITE.

>=20
> > > +     amdgpu_ring_commit(ring);
> > > +     /* wait for the commands to complete */
> > > +     r =3D amdgpu_ring_test_ring(ring);
> > > +     if (r)
> > > +             return r;
> > > +
> > > +     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > +}
> > > +
> > >=20
> > >  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> > > =20
> > >                             unsigned int vmid,
> > >                             struct amdgpu_fence *timedout_fence)
> > >=20
> > > @@ -7441,9 +7540,9 @@ static const struct amdgpu_ring_funcs
> > > gfx_v9_0_ring_funcs_gfx =3D { .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
> > >=20
> > >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> > >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_w=
ait,
> > >=20
> > > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> >=20
> > Can you please split removing the soft recovery into a separate patch?
> >=20
> > Can we talk about removing the soft recovery? For the other chips where=
 it
> > has already been removed, it is percieved by users as a regression.
>=20
> Queue reset is superset of soft recovery.  There's no need for soft
> recovery when queue reset is available.
>=20

I'm not arguing for or against either approach, just relaying how the chang=
e=20
is percieved by users who tell their experience.

=46rom a user's perspective:
=2D queue reset just kills the entire job and the offending process, ie. th=
e user=20
sees the game crash
=2D soft recovery sometimes allows the guilty process to move on intact, ie=
=2E the=20
user would see a "hitch" in the game but then it would keep working


>=20
> > >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> > >       .emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> > >=20
> > > +     .reset =3D gfx_v9_0_reset_kgq,
> > >=20
> > >       .begin_use =3D amdgpu_gfx_enforce_isolation_ring_begin_use,
> > >       .end_use =3D amdgpu_gfx_enforce_isolation_ring_end_use,
> > > =20
> > >  };
> > >=20
> > > @@ -7542,7 +7641,6 @@ static const struct amdgpu_ring_funcs
> > > gfx_v9_0_ring_funcs_compute =3D { .emit_wreg =3D gfx_v9_0_ring_emit_w=
reg,
> > >=20
> > >       .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
> > >       .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_w=
ait,
> > >=20
> > > -     .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
> > >=20
> > >       .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
> > >       .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
> > >       .reset =3D gfx_v9_0_reset_kcq,




